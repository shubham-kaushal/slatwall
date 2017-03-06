/*

    Slatwall - An Open Source eCommerce Platform
    Copyright (C) ten24, LLC
	
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
    
    Linking this program statically or dynamically with other modules is
    making a combined work based on this program.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.
	
    As a special exception, the copyright holders of this program give you
    permission to combine this program with independent modules and your 
    custom code, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting program under terms 
    of your choice, provided that you follow these specific guidelines: 

	- You also meet the terms and conditions of the license of each 
	  independent module 
	- You must not alter the default display of the Slatwall name or logo from  
	  any part of the application 
	- Your custom code must not alter or create any files inside Slatwall, 
	  except in the following directories:
		/integrationServices/

	You may copy and distribute the modified version of this program that meets 
	the above guidelines as a combined work under the terms of GPL for this program, 
	provided that you include the source code of that other code when and as the 
	GNU GPL requires distribution of source code.
    
    If you modify this program, you may extend this exception to your version 
    of the program, but you are not obligated to do so.

Notes:

*/
component extends="Slatwall.meta.tests.unit.SlatwallUnitTestBase" {

	public void function setUp() {
		super.setup();
		variables.dao = request.slatwallScope.getDAO("stockDAO");
	}

	public void function inst_ok() {
		assert(isObject(variables.dao));
	}
	
	// Ensure that updateStockLocation will accept arguments and run query. 
	public void function updateStockLocation_has_no_errors() {
		variables.dao.updateStockLocation(toLocationID="1",fromLocationID="1");
	}
	
	public void function getAverageCostTest(){
		var stockData = {
			stockID=""
		};
		var stock = createPersistedTestEntity('Stock',stockData);
		
		var inventoryData ={
			inventoryID="",
			cost=50,
			quantityin=5,
			stock={
				stockID=stock.getStockID()
			}
		};
		var inventory = createPersistedTestEntity('Inventory',inventoryData);
		
		var averageCost = variables.dao.getAverageCost(stock.getStockID());
		assertEquals(10,averageCost);
		
		var inventoryData2 = {
			inventoryID="",
			cost=35,
			quantityin=5,
			stock={
				stockID=stock.getStockID()
			}
		};
		var inventory2 = createPersistedTestEntity('Inventory',inventoryData2);
		
		averageCost = variables.dao.getAverageCost(stock.getStockID());
		assertEquals(8.5,averageCost);
	}
	
	public void function getCurrentMarginTest(){
		var skuData = {
			skuID="",
			price=77
			
		};
		var sku = createPersistedTestEntity('Sku',skuData);
		
		var stockData = {
			stockID="",
			calculatedAverageCost=11,
			sku={
				skuID=sku.getSkuID()
			}
		};
		var stock = createPersistedTestEntity('Stock',stockData);
		
		var inventoryData ={
			inventoryID="",
			cost=50,
			quantityin=5,
			stock={
				stockID=stock.getStockID()
			}
		};
		var inventory = createPersistedTestEntity('Inventory',inventoryData);
		
		var averageCost = variables.dao.getAverageCost(stock.getStockID());
		assertEquals(10,averageCost);
		
		var inventoryData2 = {
			inventoryID="",
			cost=35,
			quantityin=5,
			stock={
				stockID=stock.getStockID()
			}
		};
		var inventory2 = createPersistedTestEntity('Inventory',inventoryData2);
		var currentMargin = variables.dao.getCurrentMargin(stock.getStockID());
		assertEquals(0.857143,currentMargin,'(77-11)/77');
	}
	
	
}


