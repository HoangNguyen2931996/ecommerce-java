<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<tiles:insertAttribute name="header"></tiles:insertAttribute>
			<!-- /Top Menu Items -->
			
			<!-- Left Sidebar Menu -->
			<div class="fixed-sidebar-left">
				<tiles:insertAttribute name="left_bar"></tiles:insertAttribute>
			</div>
			<!-- /Left Sidebar Menu -->
			
			<!-- Right Sidebar Menu -->
			<div class="fixed-sidebar-right">
				<tiles:insertAttribute name="right_bar"></tiles:insertAttribute>
			</div>
			<!-- /Right Sidebar Menu -->
			
			

			<!-- Main Content -->
			<div class="page-wrapper">
				<tiles:insertAttribute name="content"></tiles:insertAttribute>
				<!-- Footer -->
<tiles:insertAttribute name="footer"></tiles:insertAttribute>