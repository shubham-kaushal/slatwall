<cfimport prefix="swa" taglib="../../../../tags" />
<cfimport prefix="hb" taglib="../../../../org/Hibachi/HibachiTags" />

<cfparam name="rc.sku" type="any" />
<cfparam name="rc.edit" type="boolean" />

<cfoutput>
	<!--- get all actively used currencies--->
	
	
	<sw-tab-group id="#getHibachiScope().createHibachiUUID()#">
		<cfloop array="#rc.sku.getSkuCosts()#" index="skuCost" >
			<sw-tab-content id="#getHibachiScope().createHibachiUUID()#" name="#skuCost.getCurrency().getCurrencyCode()#">
				<!---<table class="table table-bordered table-hover">
					<tr>
						<td class="primary">
						</td>
						<td>
							
						</td>
					</tr>
				</table>--->
				<hb:HibachiPropertyDisplay object="#skuCost#" property="calculatedCurrentMargin"  edit="false">
				<hb:HibachiPropertyDisplay object="#skuCost#" property="calculatedCurrentLandedMargin" edit="false">
				<hb:HibachiPropertyDisplay object="#skuCost#" property="calculatedCurrentAssetValue"  edit="false">
				<hb:HibachiPropertyDisplay object="#skuCost#" property="calculatedAveragePriceSold"   edit="false">
			</sw-tab-content>
		</cfloop>
	</sw-tab-group>
			

</cfoutput>
