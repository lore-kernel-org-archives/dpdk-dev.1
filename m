Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF13C3ABA9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:52:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AD6140DD0;
	Wed, 30 Apr 2025 15:49:45 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 1091E40670
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:30 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03lp2236.outbound.protection.outlook.com [104.47.51.236]) by
 mx-outbound23-207.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfjysIITmLw4k0aPgDPRQ4dT6wrtm6UGcRowxrEIfNM0OC1CbmPt5t7AZcxP+aZIqqy2pEnL8GD5HBTmdxDELyYgjUSmskjU3PDvI/tnXd+clVwlUux/cazg6S1nmll8jiW2fxyBdhKSihgnDGQqgOC1PU6ItGOWJNcQ6QF0ZjhwtRg8YtpPa1qlGCh/h9qCKTmubrs1otTKOTQxPoPIO4w3gyjRjnLW9hMXcroSuJuWZQBsigOIYO5sahUGt2QBBNnJp6kndmtebuaIuFRs9diY8UlYH7xOX/PM6s7V/2FrzlNcTV+x9vId/keQDk2QkJFxerz78DbJrzXi7KILKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26nO36eTpwvZZx4GklHzfTJZ0xivST11u5QxxykgUag=;
 b=WmEoRr2UXedIV/wZwhhZcNas+T9VD7KJ+jMkCCeS2K3+7QkpxCQnkiiTf0zTf7cSAaUyrb+4dhx/yjW2k7qP8so6vm4tLNVu5zB92jQDpPzK2O5hoCEbJ2+BghWoXr+IfGr4gW6qPbrE1MP9oxnvqx6rikTE3zOG989A6skw5qiXzfyn452uBBzv/ZPGFPWlWGGbnXCm/KNDNGcYRJDCb6TNiOxeZzGdcq3boTrH9UK3VtFRjfIlLOg4llqzbB3L5U1LYM+JciWTkhzx3+RGo61d/DsArNlrJEeAM6odltUuyez6A3LSaO0+4A+/7yxLpLU8oqkP7PKNW6krj21Jcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26nO36eTpwvZZx4GklHzfTJZ0xivST11u5QxxykgUag=;
 b=Ab5G5I5chiIbcdg9e7x3lnFbIZt3chEbdaHPg+rfUkrT9VYjkdyo33et1JHn69dhpHg5wb5K/L49VfI/0h9FTkZl/SGINjKepUFN+o9ekhFXRN5CQUZBiP/VOzmh+mXvtBXGQzUOnRwYU5cZoIjM8sJy4ZUUbnBIkEvEzSZa7qQ=
Received: from AM9P193CA0030.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::35)
 by AM0P190MB0660.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:193::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 30 Apr
 2025 13:49:23 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::4a) by AM9P193CA0030.outlook.office365.com
 (2603:10a6:20b:21e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Wed,
 30 Apr 2025 13:49:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:23 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 23/25] net/ntnic: add null verification
Date: Wed, 30 Apr 2025 15:48:35 +0200
Message-ID: <20250430134840.402553-24-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|AM0P190MB0660:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e8c44615-352c-49bf-1516-08dd87edd0c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hFXMQReEU6wTZ/sfv/EtnbUSIfyw3GLRZZsoTYGf/9ZS+mmChvfhXyvkr1Em?=
 =?us-ascii?Q?lCkRg1zFiKn9vpUe47mlSpvfKiuJFoQIWA/x+/HHSHjfSfN7t0HVEZjl5IAC?=
 =?us-ascii?Q?SlzppKoZTGsh5PlQ2bRZi8Mq+owTSVNs54nIg7T+cSsf+O/b/cyaxWAe+9ea?=
 =?us-ascii?Q?pZeuNxGh3WhBmaWZyFPX4xHvPVDwSO30CoegNOz5d3y9quCSrdEfgi8o3yg6?=
 =?us-ascii?Q?t4tO3hIwLqDKu6aIELReyhQo68l+zEuXdkO7/kbab3OXYmMPBBbcv/iKGYDz?=
 =?us-ascii?Q?GuLRXcl7S6/3onVGwjDRxJU5JbB+4F9Lmg/SoF161WcUjS+/WBRnq5DWwE9U?=
 =?us-ascii?Q?B0K8o7tS+LnVokYaJ4e/PeSV6PhxBfoCT3vWbIGGyCNFZy4mZTfS4iw8FaDJ?=
 =?us-ascii?Q?59v5q/uhpI3CelylW59FXK2dWan39Gzz5RR+JFnVHd48b03/eDm+CW15Uduw?=
 =?us-ascii?Q?kPQvcAo3MK33XAlR23kpZOurkxaKAwdChQlDgTmIFcrmjQEcixNLZBSZ4RSp?=
 =?us-ascii?Q?ladnj1KWVvPQCFELLOLsTDs/QLZf2pBuEAtFfSHOnddBouOV3aWFa1HQm8uO?=
 =?us-ascii?Q?WFwb3rc5f730PKBrdyFok25REYOOZgB1nTohc7JPXT6++athPdD7JYc0qLij?=
 =?us-ascii?Q?mejqxEftkwBs/cVUdUi7c3MkT0ZR2UJGsktF2KBPudjLLEfmWX9cp+ZLlZTZ?=
 =?us-ascii?Q?ZxFEqTSSQk+yM0lRXdiE13XucytvRlAVcXYWOukPaPpPY2zDMLLh8j8PvxrJ?=
 =?us-ascii?Q?BSYN5g+wvBBi1LajJ5BpPzYVgv4kGUkwzHpjVZn5/8h859oswOjKFD7AtX86?=
 =?us-ascii?Q?mt/dHK/w015MDRLVsuKYiyCcav5u+z5AJnYkudQrnUFey714Psl9wmAfqWt6?=
 =?us-ascii?Q?p45ci0nQVcbYqqcxW+5bvN7vESm3oFfV50sNuUpfq+nS/WxVbj/4nnOI1nqt?=
 =?us-ascii?Q?nOFogEVJVxwFdLHoMWtL2HDz2MVl+J9sbuvf3uW5akf3WE5pEefByVo0di/2?=
 =?us-ascii?Q?v1HmR3ffdUnmIhSfEavEsvhnJuUcw4917kQe9j3jNEJNneitBiJTZ+XZMTUC?=
 =?us-ascii?Q?cUgobefzE4rJ29wulYRaeAfugGh+XcCn4AqB5Pm8R5dcNA92BNvsSGeK1pWq?=
 =?us-ascii?Q?CjlYbP+nj6G/VkYQEUmFnTuuCYWaKiVfQEsOR6JSVg4Q8moQftc1kqmbPy9C?=
 =?us-ascii?Q?YLGiQXSTZHXkRafSsm7z+t3ltVUNcg6X1PHwPKWVL/O9//PYF/c6jz4JrRwc?=
 =?us-ascii?Q?XGgXRYbqG32xaYpowSQgcvl9ka1TLfzWA1BIydMt+o1WjFl5zAGCkS9miqET?=
 =?us-ascii?Q?9SxAQ4nOZQzm9gSLgQWYj0u5YQxydP53qDwJvFsJl6VJzNR1OWeX/2RS6htO?=
 =?us-ascii?Q?RlTBEsouDhtvFDSJuOrIWnND6D+ee7otswWyc/CrPtSMD9vxsOeqPoisydSd?=
 =?us-ascii?Q?ivVAgqsdwMRY0BAvwIhl0Ap6UQ3NrbQCgRuTC5hQ/wE8P7h0HW8kLU/5LxYp?=
 =?us-ascii?Q?SV/d3vGg0Y3UhMDXrNwghUF/eKDYnzRcXkb+?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tUcXzucq4oSMM1kf+4mCoJWQCgAr1kRBivrejMkiL54TpPEz6B2teAz7Bx4fNepRSf024Dy7o8Q3eucW53HY9+oW27jX/4F4ySl95iAe4o4PrOb+GpmZ9LUuxtb//bxKheau0iiBQsZlwUF10wzZK+JG7Q988ukPOJ4yRDT+8jiTxZmNkBIsqryfLuwv9AqQ02aQ9HYJ4kSQs3zjmcLHTDsFhmofZ0VVSjKdQdaw2jGOh9DdICMXbSPiN9ai5YpMWXmG0fkgknqP68mZj6XfbG4poiE8c33z+G2bE7zpT1Hv2C4zDc5j3sRrcLkX2vwC6uSI+THJIeS9hjU/ovA9oH8aVroqEf0cMh5SAWflCDKwaPLvJYAucf0miXvNOkeXWtXFGp1bhaCze+sJcacpvGVxJXBbKNaJ8ZW3ibSQy12Cm8t7z4VOb13wij7NzldlpMyRIuJQgjW6Zy7Vg6OTDO0A9iC6Hl66ztwITkA5v/0kgixTOt8y4AZEKCufivLNIRfthM3O3Wb3e9x8XvO08FULakHpQrI01kMFOzpIgUYbeJjtbq5lURLKnIXHcp7BsD9dpUqeu2z43eFCc+ZynCGPJARxssl5HZw31drGCegHhECkBPOgrr3iULT01IEfOmIMYEjmwuR90uBR0hIXHw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:23.4814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c44615-352c-49bf-1516-08dd87edd0c8
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P190MB0660
X-BESS-ID: 1746020966-306095-7599-622-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.51.236
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuamlmZAVgZQ0CA5xczAKNHYND
 nVwtjE2MzUPM3c2NLY3Cwp1SzVIMlCqTYWANgJrw1BAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan18-221.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.50 BSF_RULE7568M          META: Custom Rule 7568M 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

From: Danylo Vodopianov <dvo-plv@napatech.com>

Add verification on NULL for variables before use it in the memset.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c  |  3 +++
 .../link_mgmt/link_100g/nt4ga_link_100g.c      |  2 ++
 .../net/ntnic/nthw/flow_api/flow_id_table.c    |  3 ++-
 .../nthw/flow_api/hw_mod/hw_mod_backend.c      |  3 ++-
 .../profile_inline/flow_api_profile_inline.c   | 18 ++++++++++++------
 drivers/net/ntnic/nthw/model/nthw_fpga_model.c |  6 ++++--
 .../net/ntnic/nthw/ntnic_meter/ntnic_meter.c   |  6 ++++++
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c  |  5 +++++
 8 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
index bb775c052c..94b0c97d27 100644
--- a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
+++ b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
@@ -911,6 +911,9 @@ static int nthw_setup_managed_virt_queue_packed(struct nthw_virt_queue *vq,
 	RTE_ASSERT(p_packet_buffers);
 
 	/* clean canvas */
+	if (p_virt_struct_area->virt_addr == NULL)
+		return -1;
+
 	memset(p_virt_struct_area->virt_addr, 0,
 		sizeof(struct pvirtq_desc) * vq->queue_size +
 		sizeof(struct pvirtq_event_suppress) * 2 + sizeof(int) * vq->queue_size);
diff --git a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
index ed9dabe27c..adb187d322 100644
--- a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
@@ -137,6 +137,8 @@ static int _link_state_build(adapter_info_t *drv, nthw_mac_pcs_t *mac_pcs,
 	uint32_t lh_internal_local_fault;
 	uint32_t lh_received_local_fault;
 
+	RTE_ASSERT(state);
+
 	memset(state, 0, sizeof(*state));
 	state->link_disabled = is_port_disabled;
 	nthw_mac_pcs_get_link_summary(mac_pcs, &abs, &phy_link_state, &lh_abs, &ll_phy_link_state,
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_id_table.c b/drivers/net/ntnic/nthw/flow_api/flow_id_table.c
index a63f5542d1..c33308b5f7 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_id_table.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_id_table.c
@@ -114,7 +114,8 @@ void ntnic_id_table_free_id(void *id_table, uint32_t id)
 
 	struct ntnic_id_table_element *current_element =
 		ntnic_id_table_array_find_element(handle, id);
-	memset(current_element, 0, sizeof(struct ntnic_id_table_element));
+	if (current_element)
+		memset(current_element, 0, sizeof(struct ntnic_id_table_element));
 
 	struct ntnic_id_table_element *element =
 		ntnic_id_table_array_find_element(handle, handle->free_head);
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c
index 299b9b913a..2e2ecfe253 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c
@@ -86,7 +86,8 @@ void *nthw_callocate_mod(struct common_func_s *mod, int sets, ...)
 
 void nthw_zero_module_cache(struct common_func_s *mod)
 {
-	memset(mod->base, 0, mod->alloced_size);
+	if (mod)
+		memset(mod->base, 0, mod->alloced_size);
 }
 
 int nthw_flow_api_backend_init(struct flow_api_backend_s *dev,
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index 5bf8a9a3ea..3133464675 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -1714,15 +1714,14 @@ static int interpret_flow_elements(const struct flow_eth_dev *dev,
 
 	*in_port_id = UINT32_MAX;
 
-	memset(packet_data, 0x0, sizeof(uint32_t) * 10);
-	memset(packet_mask, 0x0, sizeof(uint32_t) * 10);
-	memset(key_def, 0x0, sizeof(struct flm_flow_key_def_s));
-
-	if (elem == NULL) {
+	if (packet_data == NULL || packet_mask == NULL || key_def == NULL || elem == NULL) {
 		nthw_flow_nic_set_error(ERR_FAILED, error);
 		NT_LOG(ERR, FILTER, "Flow items missing");
 		return -1;
 	}
+	memset(packet_data, 0x0, sizeof(uint32_t) * 10);
+	memset(packet_mask, 0x0, sizeof(uint32_t) * 10);
+	memset(key_def, 0x0, sizeof(struct flm_flow_key_def_s));
 
 	if (implicit_vlan_vid > 0) {
 		uint32_t *sw_data = &packet_data[1 - sw_counter];
@@ -3192,6 +3191,9 @@ static int convert_fh_to_fh_flm(struct flow_handle *fh, const uint32_t *packet_d
 static void setup_db_qsl_data(struct nic_flow_def *fd, struct hw_db_inline_qsl_data *qsl_data,
 	uint32_t num_dest_port, uint32_t num_queues)
 {
+	if (qsl_data == NULL)
+		return;
+
 	memset(qsl_data, 0x0, sizeof(struct hw_db_inline_qsl_data));
 
 	if (fd->dst_num_avail <= 0) {
@@ -3236,6 +3238,9 @@ static void setup_db_qsl_data(struct nic_flow_def *fd, struct hw_db_inline_qsl_d
 
 static void setup_db_hsh_data(struct nic_flow_def *fd, struct hw_db_inline_hsh_data *hsh_data)
 {
+	if (hsh_data == NULL)
+		return;
+
 	memset(hsh_data, 0x0, sizeof(struct hw_db_inline_hsh_data));
 
 	hsh_data->func = fd->hsh.func;
@@ -4816,7 +4821,8 @@ int flow_info_get_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
 	int res = 0;
 
 	nthw_flow_nic_set_error(ERR_SUCCESS, error);
-	memset(port_info, 0, sizeof(struct rte_flow_port_info));
+	if (port_info)
+		memset(port_info, 0, sizeof(struct rte_flow_port_info));
 
 	port_info->max_nb_aging_objects = dev->nb_aging_objects;
 
diff --git a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
index 0838527716..5256adc648 100644
--- a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
+++ b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
@@ -854,8 +854,10 @@ void nthw_register_flush(const nthw_register_t *p, uint32_t cnt)
 
 void nthw_register_clr(nthw_register_t *p)
 {
-	memset(p->mp_shadow, 0, p->mn_len * sizeof(uint32_t));
-	nthw_register_make_dirty(p);
+	if (p->mp_shadow) {
+		memset(p->mp_shadow, 0, p->mn_len * sizeof(uint32_t));
+		nthw_register_make_dirty(p);
+	}
 }
 
 /*
diff --git a/drivers/net/ntnic/nthw/ntnic_meter/ntnic_meter.c b/drivers/net/ntnic/nthw/ntnic_meter/ntnic_meter.c
index 66cc02a865..303c2cd51a 100644
--- a/drivers/net/ntnic/nthw/ntnic_meter/ntnic_meter.c
+++ b/drivers/net/ntnic/nthw/ntnic_meter/ntnic_meter.c
@@ -51,6 +51,9 @@ static int eth_mtr_capabilities_get_inline(struct rte_eth_dev *eth_dev,
 				"Ethernet device does not support metering");
 	}
 
+	if (cap == NULL)
+		return -1;
+
 	memset(cap, 0x0, sizeof(struct rte_mtr_capabilities));
 
 	/* MBR records use 28-bit integers */
@@ -419,6 +422,9 @@ static int eth_mtr_stats_read_inline(struct rte_eth_dev *eth_dev,
 				"MTR id is out of range");
 	}
 
+	if (stats == NULL)
+		return -1;
+
 	memset(stats, 0x0, sizeof(struct rte_mtr_stats));
 	profile_inline_ops->flm_mtr_read_stats(internals->flw_dev, caller_id, mtr_id, stats_mask,
 		&stats->n_pkts[RTE_COLOR_GREEN],
diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index 5757c7c13c..fc06cf12c3 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -248,6 +248,11 @@ int nthw_interpret_raw_data(uint8_t *data, uint8_t *preserve, int size, struct r
 
 int nthw_create_attr(struct cnv_attr_s *attribute, const struct rte_flow_attr *attr)
 {
+	if (!attribute) {
+		NT_LOG(ERR, FILTER, "ERROR no attribute to iterate!");
+		return -1;
+	}
+
 	memset(&attribute->attr, 0x0, sizeof(struct rte_flow_attr));
 
 	if (attr) {
-- 
2.47.1

