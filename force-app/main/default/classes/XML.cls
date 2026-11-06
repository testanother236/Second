public class XML {
    public static final String ADD_TO_NODE_TEMPLATE = '<{0}>{1}</{0}>';

    public static String rootElementName;

    public static String addValueAfterTag(String content, String tag, String value) {
        return content.replace(tag, tag + value);
    }

    public static String removeTag(String content, String tag) {
        String openTage = '<' + tag;
        String closeTag = '</' + tag + '>';

        if (!content.contains(openTage) || !content.contains(closeTag)) {
            return content;
        }

        String result = content.substring(0, content.indexOf(openTage));
        result += content.substring(content.indexOf(closeTag) + closeTag.length());

        return result;
    }

    public static String removeCloseTags(String content) {
        List<String> props = content.split('/>');

        String result = '';

        for (Integer i = 0; i < (props.size() - 1); i++) {
            String prop = props.get(i);
            result += prop.substring(0, prop.lastIndexOf('<'));
        }

        result += props.get(props.size() - 1);

        return result;
    }

    public static String addToNode(List<String> contents, String nodeName) {
        String result = '';

        for (String content : contents) {
            result += addToNode(content, nodeName);
        }

        return result;
    }

    public static String addToNode(String content, String nodeName) {
        return String.format(ADD_TO_NODE_TEMPLATE, new List<String>{ nodeName, content });
    }

    public static String valueBetweenTag(String xml, String openTag, String closeTag) {
        return xml.substringBetween(openTag, closeTag);
    }

    public static String valueBetweenTag(String xml, String tag) {
        String openTag = '<' + tag + '>';
        String closeTag = '</' + tag + '>';

        return valueBetweenTag(xml, openTag, closeTag);
    }

    public static List<String> convertToListXml(String xml, String start, String ends) {
        List<String> results = new List<String>();

        while (xml.contains(start) && xml.contains(ends)) {
            Integer startIndex = xml.indexOf(start);
            Integer endIndex = xml.indexOf(ends) + ends.length();

            String result = xml.substring(startIndex, endIndex);
            results.add(result);

            xml = xml.replace(result, '');
        }

        return results;
    }

    public static String XMLToJSON(String xml) {
        Dom.Document doc = new Dom.Document();
        doc.load(xml);
        Dom.XmlNode root = doc.getRootElement();

        String jsonData = parse(root, false);

        rootElementName = null;

        return jsonData;
    }

    private static String parse(Dom.XmlNode node, Boolean isChild) {
        String json = '';
        Boolean isArray = false;

        if (rootElementName == null) {
            rootElementName = node.getName();
        }

        if (node.getNodeType() == Dom.XmlNodeType.ELEMENT) {
            Map<String, List<String>> jsonMap = new Map<String, List<String>>();
            List<String> jsonList = new List<String>();
            List<Dom.XmlNode> children = node.getChildElements();

            if (!children.isEmpty()) {
                for (Dom.XmlNode child : children) {
                    String tmp = parse(child, true);
                    if (tmp != '') {
                        if (!jsonMap.containsKey(child.getName())) {
                            jsonMap.put(child.getName(), new List<String>());
                        }
                        jsonMap.get(child.getName()).add(tmp);
                    }
                }

                for (String key : jsonMap.keySet()) {
                    if (jsonMap.get(key).size() > 1) {
                        if (isChild) {
                            jsonList.add('[' + String.join(jsonMap.get(key), ', ') + ']');
                        } else {
                            jsonList.add('"' + key + '": [' + String.join(jsonMap.get(key), ', ') + ']');
                        }
                        isArray = true;
                    } else {
                        jsonList.add('"' + key + '": ' + jsonMap.get(key)[0]);
                    }
                }
            }

            List<String> lastValue = new List<String>(jsonList);
            for (Integer i = 0; i < node.getAttributeCount(); i++) {
                String key = node.getAttributeKeyAt(i);
                String value = node.getAttribute(key, '');
                lastValue.add('"' + key + '": "' + value + '"');
            }

            String textContent = node.getText();
            if (textContent != null && textContent.trim() != '') {
                textContent = textContent.replace('"', '\\"');
                lastValue.add('"ele_text": "' + textContent + '"');
            }

            if (!isChild) {
                if (!isArray) {
                    json = '"' + node.getName() + '": {' + String.join(lastValue, ', ') + '}';
                } else {
                    json = ' {' + String.join(lastValue, ', ') + '}';
                }
            } else {
                if (lastValue.size() == 1 && textContent != null && textContent.trim() != '') {
                    json = '"' + textContent + '"';
                } else {
                    if (!isArray) {
                        if (lastValue.size() > 0) {
                            json = '{' + String.join(lastValue, ', ') + '}';
                        }
                    } else {
                        json = String.join(lastValue, ', ');
                    }
                }
            }
        }

        if (rootElementName == node.getName()) {
            if (!isArray) {
                json = '{' + json + '}';
            } else {
                json = '{"' + node.getName() + '" : ' + json + '}';
            }
        }

        return json;
    }

    public abstract class BaseParser {
        protected abstract String openTag();
        protected abstract String closeTag();
        protected abstract Type classType();

        private String jsonData;

        public virtual BaseParser execute(String xml) {
            String content = valueBetweenTag(xml, openTag(), closeTag());
            String contentToJson = String.format(MCConstants.SOAP_ENVELOPE_XML, new List<String>{ content });

            jsonData = XMLToJSON(contentToJson);
            return this;
        }

        public virtual Map<String, Object> toMap() {
            Map<String, Object> envelopeMap = (Map<String, Object>) JSON.deserializeUntyped(jsonData);

            return (Map<String, Object>) envelopeMap.get('Envelope');
        }

        public String toJson() {
            return jsonData;
        }

        public Object toObject() {
            Map<String, Object> envelopeMap = (Map<String, Object>) JSON.deserializeUntyped(jsonData);

            return envelopeMap.get('Envelope');
        }

        public Object toWrapper() {
            return JSON.deserialize(jsonData, classType());
        }
    }

    public class MCSoapFaultParser extends BaseParser {
        protected override String openTag() {
            return MCConstants.SOAP_FAULT_RESPONSE_START_TAG;
        }

        protected override String closeTag() {
            return MCConstants.SOAP_FAULT_RESPONSE_END_TAG;
        }

        protected override Type classType() {
            return MCService.SoapFaultEnvelopeWrapper.class;
        }
    }

    public class MCSoapDescribeParser extends BaseParser {
        protected override String openTag() {
            return MCConstants.SOAP_DESCRIBE_RESPONSE_START_TAG;
        }

        protected override String closeTag() {
            return MCConstants.SOAP_DESCRIBE_RESPONSE_END_TAG;
        }

        protected override Type classType() {
            return MCService.SoapDescribeEnvelopeWrapper.class;
        }
    }

    public class MCSoapRetrieveParser extends BaseParser {
        protected override String openTag() {
            return MCConstants.SOAP_RETRIEVE_RESPONSE_START_TAG;
        }

        protected override String closeTag() {
            return MCConstants.SOAP_RETRIEVE_RESPONSE_END_TAG;
        }

        protected override Type classType() {
            return MCService.SoapRetrieveEnvelopeWrapper.class;
        }

        public override Map<String, Object> toMap() {
            Map<String, Object> resultsMap = super.toMap();

            if (
                !resultsMap.containsKey(MCConstants.SOAP_RESULT_TAG_NAME) ||
                resultsMap.get(MCConstants.SOAP_RESULT_TAG_NAME) == null
            ) {
                resultsMap.put(MCConstants.SOAP_RESULT_TAG_NAME, new List<Object>());
            }

            try {
                List<Object> results = (List<Object>) resultsMap.get(MCConstants.SOAP_RESULT_TAG_NAME);
            } catch (Exception e) {
                if (e.getMessage().contains('Invalid conversion from runtime type Map<String,ANY> to List<ANY>')) {
                    List<Object> results = new List<Object>{ resultsMap.get(MCConstants.SOAP_RESULT_TAG_NAME) };
                    resultsMap.put(MCConstants.SOAP_RESULT_TAG_NAME, results);
                } else {
                    throw e;
                }
            }

            return resultsMap;
        }
    }

    public class MCSoapRetrieveResultParser extends BaseParser {
        protected override String openTag() {
            return MCConstants.SOAP_RETRIEVE_RESULT_START_TAG;
        }

        protected override String closeTag() {
            return MCConstants.SOAP_RETRIEVE_RESULT_END_TAG;
        }

        protected override Type classType() {
            return MCService.SoapRetrieveResultEnvelopeWrapper.class;
        }
    }

    public class MCSoapTypeRetrieveResultParser extends BaseParser {
        private final String type;

        public MCSoapTypeRetrieveResultParser(String type) {
            this.type = type;
        }

        protected override String openTag() {
            return String.format(MCConstants.SOAP_RETRIEVE_RESULT_TYPE_START_TAG, new List<String>{ this.type });
        }

        protected override String closeTag() {
            return MCConstants.SOAP_RETRIEVE_RESULT_END_TAG;
        }

        protected override Type classType() {
            return MCService.SoapRetrieveResultEnvelopeWrapper.class;
        }
    }
}