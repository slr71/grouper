/*******************************************************************************
 * Copyright 2012 Internet2
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 ******************************************************************************/
/*
 * Copyright 2002-2006 The Apache Software Foundation.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package edu.internet2.middleware.grouperClientExt.org.apache.commons.jexl.parser;

import edu.internet2.middleware.grouperClientExt.org.apache.commons.jexl.JexlContext;

/**
 * represents equality between integers - use .equals() for strings.
 * 
 * @author <a href="mailto:geirm@apache.org">Geir Magnusson Jr.</a>
 * @version $Id: ASTExpressionExpression.java,v 1.1 2008-11-30 10:57:25 mchyzer Exp $
 */
public class ASTExpressionExpression extends SimpleNode {

    /**
     * Create the node given an id.
     * 
     * @param id node id.
     */
    public ASTExpressionExpression(int id) {
        super(id);
    }

    /**
     * Create a node with the given parser and id.
     * 
     * @param p a parser.
     * @param id node id.
     */
    public ASTExpressionExpression(Parser p, int id) {
        super(p, id);
    }

    /** {@inheritDoc} */
    public Object jjtAccept(ParserVisitor visitor, Object data) {
        return visitor.visit(this, data);
    }

    /** {@inheritDoc} */
    public Object value(JexlContext context) throws Exception {
        return ((SimpleNode) jjtGetChild(0)).value(context);
    }
}
