<!---

    Slatwall - An e-commerce plugin for Mura CMS
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

<cfoutput>
	<table class="listing-grid stripe">
		<tr>
			<th>#$.slatwall.rbKey("entity.sku.skucode")#</th>
			<th class="varWidth">#$.slatwall.rbKey("entity.product.brand")# - #$.slatwall.rbKey("entity.product.productname")#</th>
			<!---<th>#$.slatwall.rbKey("admin.vendorOrder.list.actions")#</th>--->
			<!---<th>#$.slatwall.rbKey("entity.vendorOrderitem.status")#</th>--->
			<th>#$.slatwall.rbKey("entity.vendorOrderitem.stockLocation")#</th>
			<th>#$.slatwall.rbKey("entity.vendorOrderitem.quantityIn")#</th>
			<th>#$.slatwall.rbKey("entity.vendorOrderitem.detail.cost")#</th>
		</tr>
			
		<cfloop array="#rc.vendorOrderItemSmartList.getPageRecords()#" index="local.vendorOrderItem">
			<tr>
				<td>#local.vendorOrderItem.getStock().getSku().getSkuCode()#</td>
				<td class="varWidth">#local.vendorOrderItem.getStock().getSku().getProduct().getBrand().getBrandName()# - #local.vendorOrderItem.getStock().getSku().getProduct().getProductName()#</td>
				<td>#local.vendorOrderItem.getStock().getLocation().getLocationName()#</td>								
				<td>#int(local.vendorOrderItem.getQuantity())#</td>
				<td>#local.vendorOrderItem.getFormattedValue('cost', 'currency')#</td>
			</tr>
		</cfloop>
	</table>
	
	<div class="totals" style="width:300px; float:right;">
		<dl class="fulfillmentTotals">
			<!---<dt>
				#$.slatwall.rbKey("entity.vendorOrder.subtotal")#:
			</dt>
			<dd>
				#rc.vendorOrder.getFormattedValue('subTotal', 'currency')#
			</dd>--->
			<!---<dt>
				#$.slatwall.rbKey("entity.vendorOrder.taxTotal")#:
			</dt>
			<dd>
				#rc.vendorOrder.getFormattedValue('taxTotal', 'currency')#
			</dd>--->
			<dt>
				#$.slatwall.rbKey("entity.vendorOrder.total")#:
			</dt>
			<dd>
				#rc.vendorOrder.getFormattedValue('total', 'currency')#
			</dd>
		</dl>
	</div>
	<div class="clear"></div>
</cfoutput>