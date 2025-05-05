Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990A6C369C2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:15:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 107EE40B9B;
	Mon,  5 May 2025 09:14:11 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 9832240DF5
 for <dev@dpdk.org>; Mon,  5 May 2025 09:14:09 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03lp2110.outbound.protection.outlook.com [104.47.30.110]) by
 mx-outbound40-227.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujE+uu8dZf3RXoIlhoaanb0GhqsZX2SfF2P8FNFuABnw1xWidEFCvNShg+LxV2uJfzHlmLu72753Fv4fOd4eRXOvNqbVgpk5sB4if/bKcAmJzHXBjqbRKmr3rm6RkzYitx7s4SW0qQJiB12Qr2ocese/XjORvBvY7x3N7OFpdREDLmBakwAJ7W2uedSal1KdtJidaoK1uF9HTzZXuU1RotMQAOxn8Aur/4akfAT7aVi+LCKPev8ufCfk79wgNvcn84L+fhZMEfEujn26s/+LoulPLZxZZtsk8kKCJcc5d5fVybGue1i070j8GlyHwQiuUGmd4tOfzAiv03pVzc4QZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5zK/VqeDwJfJVB9A3rgHidjowKhmjxrgN9pKgEjMMs=;
 b=ZdCh07LO0fVHynriI7L/XJkjY5akT2wvVF3YmltoLZ8ODsTNdWbNQ7cGPTl3r5poq1++Kbsc91v6REx8Ty7J/SdWQEBWTZrTbEd1blWEWRmBaVjFgvEOZeA6LJGxdm1Ql0jGhc+zof3QGxhyTrSPqWYQNEML9CTBqXDnMdvqtYL7P0n7mwMrr2HV3pTjiwV50b9HRKWHtwPqcqUpxWMLYbXCOjZ5JhZvb7bgRJHxpHz+2EeGqls8utLVDha3CDsOh9I4weOY82/25AB5kB60nRk7MbUBuwmtxgkkBa3c7vlET3moL8cZEmITmYGLIj7YGE/4hNUgmPFqVWVpT8m1Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5zK/VqeDwJfJVB9A3rgHidjowKhmjxrgN9pKgEjMMs=;
 b=aHh76LiH6nyagokH2ijyCixxzwc9az/rCjnO3ugCaKc/urNqKVsndNEtEkVBdePX+jJ5h8hp98XuefANDUuezZ8j+VrHocAf0aVRsrTrhFB3olJjkjzWpecVtKJHdjZnsdE0sklvDXUdbA+ejftc/fJUeftWhHs+BFMv/kpeB54=
Received: from DUZPR01CA0325.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::22) by DB8P190MB0684.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:12f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 5 May
 2025 07:13:29 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:4ba:cafe::e5) by DUZPR01CA0325.outlook.office365.com
 (2603:10a6:10:4ba::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Mon,
 5 May 2025 07:13:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:29
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 24/26] net/ntnic: add null verification
Date: Mon,  5 May 2025 09:13:04 +0200
Message-ID: <20250505071309.586015-25-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|DB8P190MB0684:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5b8d6bf6-df6c-4a8b-2bf4-08dd8ba45686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TzrFHh1zo8bdIVUqrx4jNAn0nER9MduAMUR9ahzLuEPchT78LV0Kh2yGeDJE?=
 =?us-ascii?Q?d96VCG1QCNyuNnawOzKoZbsbbUuE2HDJwAjMEITD4BGdv7To3SzeWH78+ODc?=
 =?us-ascii?Q?jcnFA9LVadsN9GEg88FX4PiVQy8NKItcHXciXAs1+JtUwhe9lJdjtINbgdSO?=
 =?us-ascii?Q?qUSErRqEDDBiVbZYr/AoEsILzA5i4M2cCgsjfA1r4X+ysh8yIXIpPu0oE1al?=
 =?us-ascii?Q?FzelJUfekyaCiwlmpCqwnjSbD5IocmT0nUE4VRT/V11SRsPDlxv9L9pkc2cp?=
 =?us-ascii?Q?5WucQbfaSc3/q0dAIzgdpgtYXDKfS1bohg26FeJ5BGAjhi1UAIDT0ypCL+T2?=
 =?us-ascii?Q?n83d5cRPwq+Aac3hF/wyfsmEXKKAQ0kBr/niYxASNVxipJyMOB40WFPuRNpT?=
 =?us-ascii?Q?A5RJxrgH9HTPrqn0Asq/ivHjPAa08xYkLxh7BEwOOM7JcSNRP8d4SMk/0Y4v?=
 =?us-ascii?Q?i6cG35JSQ++ZOiyEKdJ+AIkZw3vR6W/7yQXgXTuT3xo83EcMf6vlQPDROREe?=
 =?us-ascii?Q?inf8lowR2G6PvUlWBDM5P8E93M+D1d6syldipfOJiaUYeQPUoi18NzwbdNhl?=
 =?us-ascii?Q?+GmJb5oJhpnypTJLRw+uK9CWsdkViIf46S85aO+HAnspNp8SObNOuGx0YJ9G?=
 =?us-ascii?Q?QuUZrMv+guabCwaGNmf2nWdQDVNINsmKXEelHDwNGCsKStTWrK0g6BN2yles?=
 =?us-ascii?Q?OnVf66a0XHWQb6lWEi0HLpRUa9bzbQx5tAR1+WgoVtZXhHcG0oqqg5CHgbAf?=
 =?us-ascii?Q?5UsSJQNqrGsXOHL1qDGWTXx6qNRA1+/4A2CAM/Xd/Ez6fmPDY2EYvyLOemtD?=
 =?us-ascii?Q?T4RUjLrteD+t/7vtnzbdGiIk264XI2hYsMiYhtW9I4aQoSwVXNhO04nT6dYd?=
 =?us-ascii?Q?+eUP7aRdydhiFgX2NtScT+h0YCvPCNP6sbfdRL1ymKJ9fvTQlrYwBaOeNvur?=
 =?us-ascii?Q?7DgzaH+mIl7YaqVCiJ90Hc/Faka8b185cgBhVVyAhyWcuQslv1PKa/kW4vm3?=
 =?us-ascii?Q?psV627zk2M/ONsapI/XrFcToq/xTpCoU1pLHDlUgA4NSekc1lKKv3o01+0A/?=
 =?us-ascii?Q?0ccO9Sftk6HDI7OxDm0DI//prSkITpxO+ebS7ZnZE68bkmq3ve96Y55Mrgdu?=
 =?us-ascii?Q?siTSe+klNMt6i+v545k4Q8Q7yrkwtr7tWnJRXv4sdWkMoo3A8Az9BqeuhoDK?=
 =?us-ascii?Q?DVHeBlw4yHSCwgmytkHvDEp0+jE3+ABLpfDk5NBGPP3Zow8jEsX64yeP0C0k?=
 =?us-ascii?Q?vrIk6JsBVIAMfSNgsmXaCdvDpTYmiAagp0GdpozqXkAmyGvWvEP0Ilzj1QRO?=
 =?us-ascii?Q?e8iq8LlQhEmQXxK+8DUsvNsyQ/GIASzG4lxWNV1lMaYdt95sPvoq9iQ11Nd2?=
 =?us-ascii?Q?t1tPwWNIpiY4YUpS4Psr0atb6Wtci36PxaPdo1thwbHa3vLi4hDquFXfbcEn?=
 =?us-ascii?Q?/DZCk4h3vPPp8sKgaNROLRoN7zu9gU3VYpeiA6jnuGGQ87dGNkLIjaQNV8N/?=
 =?us-ascii?Q?WSYYzOLjgbUHGI1ISvAAzibIbcBW84PXwo27?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Oc/NKY3krSeNyEIDxPVC4pB9Zg222puaXhHWs4qtkYxp/cfPITeyVi2sB4o9CBsok/WvGdjFKqrCCR7A7rxxv4f2c3HAuB8/1ilTPwGibikphxPyjwQrlSsKKJooU8pdRmnVwDmBWF0dpWbCJtDcreVldH4t/OIfMhpAZ2Z3q2het2+WQBJid2I/D+usQXX6hkO1QqkIjUutdXJ990YQ+V8U5Jqf3Y6zN1jVyPE4VJ0mhdDFsOTJRFIb0kc4SP3q5HUrrZhb3OZVwBxKEfGveDTPMy7r6Hm9z0bTJ1CGCw5o+xvILNyn7sN9YaU/4Bu7/QOeo4caoXalLkRWdH59n0Zq5JojtV2Wi06b2ILCaT7gQVRjwLAyCHEI2G9CHaxOd2I2XDzbztAg9KdAj9Z9cJrp5Y4cdFockKslGs7CpPxk9Sp+UesL7uZG24aVLJz3xmDIchpebF5UkMNGcRtbuG7Tfbc4hlLNi6enw5y1Vi96thedEvj87usChV1vZEVk1y53TyZVR6eSMjrFWTKJ4iqsGgX3dz9IqrbK9paRNBTaTaAzUNZt9bCSgjvbDKW+WA97RdNRI1VYrloEkQgP5iy5JjWImMm5Zy/Ru+hlkp5dYXQdd76HdKvQFiRqjF6S/duieVbnn2B8AV6jEN6KwA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:29.7098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8d6bf6-df6c-4a8b-2bf4-08dd8ba45686
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P190MB0684
X-BESS-ID: 1746429213-310467-7672-4595-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.30.110
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuZmBgZAVgZQ0NQk0TDFwMIwKd
 Ey2SjJ3DDZIMk41TjFwCjVPNXMwNxIqTYWAA1Y9R9BAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264372 [from 
 cloudscan19-189.eu-central-1b.ess.aws.cudaops.com]
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
index da126fe853..490ab2a45e 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c
@@ -86,7 +86,8 @@ void *nthw_callocate_mod(struct common_func_s *mod, int sets, ...)
 
 void nthw_zero_module_cache(struct common_func_s *mod)
 {
-	memset(mod->base, 0, mod->allocated_size);
+	if (mod)
+		memset(mod->base, 0, mod->allocated_size);
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

