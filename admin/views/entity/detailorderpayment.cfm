<!---

    Slatwall - An Open Source eCommerce Platform
    Copyright (C) 2011 ten24, LLC

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    Linking this library statically or dynamically with other modules is
    making a combined work based on this library.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.
 
    As a special exception, the copyright holders of this library give you
    permission to link this library with independent modules to produce an
    executable, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting executable under
    terms of your choice, provided that you also meet, for each linked
    independent module, the terms and conditions of the license of that
    module.  An independent module is a module which is not derived from
    or based on this library.  If you modify this library, you may extend
    this exception to your version of the library, but you are not
    obligated to do so.  If you do not wish to do so, delete this
    exception statement from your version.

Notes:

--->
<cfparam name="rc.orderPayment" type="any" />
<cfparam name="rc.edit" type="boolean" />

<cfoutput>
	<cf_HibachiEntityDetailForm object="#rc.orderPayment#" edit="#rc.edit#">
		<cf_HibachiEntityActionBar type="detail" object="#rc.orderPayment#" edit="#rc.edit#" backaction="admin:entity.detailorder" backquerystring="orderID=#rc.orderPayment.getOrder().getOrderID()#">
			<cf_HibachiProcessCaller entity="#rc.orderPayment#" action="admin:entity.processorderpayment" processContext="chargePreAuthorization" querystring="orderPaymentID=#rc.orderPayment.getOrderPaymentID()#" type="list" modal="true">
			<cf_HibachiProcessCaller entity="#rc.orderPayment#" action="admin:entity.processorderpayment" processContext="authorizeAndCharge" querystring="orderPaymentID=#rc.orderPayment.getOrderPaymentID()#" type="list" modal="true">
			<cf_HibachiProcessCaller entity="#rc.orderPayment#" action="admin:entity.processorderpayment" processContext="authorize" querystring="orderPaymentID=#rc.orderPayment.getOrderPaymentID()#" type="list" modal="true">
			<cf_HibachiProcessCaller entity="#rc.orderPayment#" action="admin:entity.processorderpayment" processContext="credit" querystring="orderPaymentID=#rc.orderPayment.getOrderPaymentID()#" type="list" modal="true">
			<cf_HibachiProcessCaller entity="#rc.orderPayment#" action="admin:entity.processorderpayment" processContext="offlineTransaction" querystring="orderPaymentID=#rc.orderPayment.getOrderPaymentID()#" type="list" modal="true">
		</cf_HibachiEntityActionBar>
		
		<cf_HibachiPropertyRow>
			<cf_HibachiPropertyList divClass="span6">
				<cfif rc.orderPayment.getPaymentMethodType() eq "creditCard">
					<cf_HibachiPropertyDisplay object="#rc.orderPayment#" property="nameOnCreditCard" edit="#rc.edit#" />
					<cf_HibachiPropertyDisplay object="#rc.orderPayment#" property="creditCardType" />
					<cf_HibachiPropertyDisplay object="#rc.orderPayment#" property="expirationMonth" edit="#rc.edit#" />
					<cf_HibachiPropertyDisplay object="#rc.orderPayment#" property="expirationYear" edit="#rc.edit#" />
				<cfelseif rc.orderPayment.getPaymentMethodType() eq "termPayment">
					<cf_HibachiPropertyDisplay object="#rc.orderPayment#" property="termPaymentAccount" edit="false" />
				</cfif>
			</cf_HibachiPropertyList>
			<cf_HibachiPropertyList divClass="span6">
				<cf_HibachiPropertyDisplay object="#rc.orderPayment#" property="amount" edit="#rc.edit#" />
				<cf_HibachiPropertyDisplay object="#rc.orderPayment#" property="amountReceived" />
				<cf_HibachiPropertyDisplay object="#rc.orderPayment#" property="amountCredited" />
			</cf_HibachiPropertyList>
		</cf_HibachiPropertyRow>
		
		<cf_HibachiTabGroup object="#rc.orderPayment#">
			<cf_HibachiTab view="admin:entity/orderpaymenttabs/paymenttransactions" />
			
			<!--- Custom Attributes --->
			<cfloop array="#rc.orderPayment.getAssignedAttributeSetSmartList().getRecords()#" index="attributeSet">
				<cf_SlatwallAdminTabCustomAttributes object="#rc.orderPayment#" attributeSet="#attributeSet#" />
			</cfloop>
		</cf_HibachiTabGroup>
		
	</cf_HibachiEntityDetailForm>
</cfoutput>