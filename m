Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37144CA1013
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 11:05:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B98E04065D;
	Mon,  8 Sep 2025 13:05:18 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id B131F40613
 for <dev@dpdk.org>; Mon,  8 Sep 2025 13:05:16 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11023137.outbound.protection.outlook.com
 [52.101.83.137]) by mx-outbound9-51.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 08 Sep 2025 11:05:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=At2fbRnGILifQMAcsuHmt9gXEx5YfWSj23T5wnrb227KVjKuh0wEosUoQaF+/LfALUnHNrqlw79pqqqfjw1efkoXuKa1ZpH4i17rRcCSOhBSxUkUfIwlvKWARbgOK8JI3FqPIhXYlM8fbd6/9dk/AVvyck3bk/OvJbU2zswb97QjfXH3UzWAk8go4U9T38P/HGIebgTHet3sCYXgPv0FBDjhRB62B0yvgOW6kv50Zw9erWepVFjPkQvF2yiEeKngQ61WBSGUq9gUF9Plou3PoYPA+y8fbarEi44NAGyaooVZ6kkjTqr64dTyFK1fGB9DkWmfr0h4ER2Gl0BkeqiUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EmQy/CGdxubNgs2Sfy9YidVi0WRds+jSHfKhVSHSbM=;
 b=E7NNehlRyKpJKsFu4Y3qqRtnPEfvTL6m4AN0mixlda5wm7nrvyklEOfYS6yls4giCY0n2GqLdMxhi7e6ATQqHIYlSlrCv2+ZI/hpki7P2dnpks/soWg7XcyGCWsqL8gf9P9Z/UtzrsqQP/b64MltrVLv5D77FAY06xDG1tIuQIvOI7/c/ti/OrLQQqV/KL0NApquGJZScqNbzyT/4+wLx07EPwyAaGfPZMNjYN5Te3TMWgwzbsAljx3nAvTQHeSqwf/35nxa14nySOsWtxAU0EAkBdC/OxtJe2ZUPOhlOEPmpwhs03Uu3EJlaabdpnwmBAy+1xWWyatYygaLiWHllA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EmQy/CGdxubNgs2Sfy9YidVi0WRds+jSHfKhVSHSbM=;
 b=Cwjenplifhvj/1W5xc7I3gV7olLVceRwWisX41cHptB6X4prdSUjxZYeNi+xq9KPrE8Nx2tJ7xm3aWr/j4NbCnUQv+4ip3hdyxeu/M/K7YSMcRX2x8NNUKQTno8FwLMeUENSh/TYBFHyFn1hiRVwwwJQcWnUoGQXBCGAnOfC6YU=
Received: from DU2PR04CA0344.eurprd04.prod.outlook.com (2603:10a6:10:2b4::17)
 by AS1P190MB1703.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:4ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:05:13 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::f4) by DU2PR04CA0344.outlook.office365.com
 (2603:10a6:10:2b4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 11:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server id 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 11:05:12
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 4/7] net/ntnic: migrate port event thread to service
Date: Mon,  8 Sep 2025 13:04:42 +0200
Message-ID: <20250908110446.1071964-5-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250908110446.1071964-1-sil-plv@napatech.com>
References: <20250908110446.1071964-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|AS1P190MB1703:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8c830ebe-45a2-4145-b5b4-08ddeec79585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c6v72LFCCxwtDZio3TAdKwSk2hpamwqGd5cq4rknsgzKUwJlXraiWk0Gk//Z?=
 =?us-ascii?Q?Aqg/IpLzVrKptfkderTrEX6zi1i0cMqf1iGLaGrJHb6CaBuicQKZlKRSr+lp?=
 =?us-ascii?Q?iWj/M6GRg/ZJ/DmtDHvnK6EcjkIYwMhQ8cFPLFC/vIK0SbtSD1w0w64A9s4p?=
 =?us-ascii?Q?AJ9Nl5sZJ3ttWiceGp5D4Jth2Uf20TNMZcRVqS7d1jBCUSOC5vCpZIlsqzlg?=
 =?us-ascii?Q?iGDKgt7qENzdKiqtkYzY5LdkoXgGfRj/1/UBT3/uvc/4QhAFTYEQ3Vxxt4C/?=
 =?us-ascii?Q?h+6v7tozTqjEQMAS41iuEQRT4ffUjYWX4z1hnKcdabzRGLUI8ni6bfwfqjXo?=
 =?us-ascii?Q?5ehcVfVqQpeFWt15VMFaNeJOfll13MYlJKrszOhzkYkPeB1v/wNK2LJVbU1q?=
 =?us-ascii?Q?kcjb2naLapS7kDlQpAly7Oigc9BTJoUCXGgSXTIZaHgihQOLa8xax9EymFC+?=
 =?us-ascii?Q?8iClpWHqEpp81S9pduoSS6rhQ0v6NRq5hIcd8hGwIsV2IpxQNL9oglpdkgHY?=
 =?us-ascii?Q?4lNlUkvUHN1E/689ONEOUUdRBul75Sr0z9mY7TgZE/HtBPi0eFzvnyUVmZZ/?=
 =?us-ascii?Q?Zmg4jz1dDMnOU24rGVSjfuTUg9BqBfQNqQYIMBSvWorbmLm4FrQ4Zd1kcJN0?=
 =?us-ascii?Q?H3VX1wzivmx2mKeZQH5k/0fwQTTEGA0gCJTEE8lWo9FWVEdxIDx9bgIfXaue?=
 =?us-ascii?Q?KvCKnyEwVOYDNcBNp159XJJ4mW4LdNCYu5GSxJKJ/7+h+R6D2apyRa+N6CkO?=
 =?us-ascii?Q?YOUEkob/f25Md0K5SgtjUY8l1aM2BiKFgmTyfU4KvYMCSg6aOF3cwScDjWyz?=
 =?us-ascii?Q?JqWNlszY5vytRPs6zTccLAJrgCLqWCNlEH0xanTMSaEDssQFDFi7PVzzYbXC?=
 =?us-ascii?Q?xSmf96zvTovPvmv46s/gUYWqtHJADHBNF2BBnhtc/n9KvWY80cLvTOHUdk4c?=
 =?us-ascii?Q?uhg+HzsxemFunq4UIv6eV5o97GQXPExyrgDRUBNQizsY7zrKux1+HUxxqsQz?=
 =?us-ascii?Q?JDzqUMLBVQfbSnwDKP5k+PunaEXeaK8kXkedkomUEpF7TZpBUEWuGCMNUN4W?=
 =?us-ascii?Q?VYTq2rVsXzuiheLuyQWaRyHVBdBjL3xf8iy09WajoO8EUOzORR1CudFjL9yn?=
 =?us-ascii?Q?6ScRgaO+Fizg9h+vRgHf5LfjhFF4/bcsmHGNbEw06jsysL03nDWt8X+Ratr2?=
 =?us-ascii?Q?/09k29eoESMGPzcMhfylyGt1wjVpupyrpPl7ZFhwL5S7koKRr4gl4M2/NNfB?=
 =?us-ascii?Q?jV5k943Ue1mF24cw//fElN49szw0YAUVZWC5xEOnGPcaE9xrN/l9c1s3Fk6Q?=
 =?us-ascii?Q?m1JbEIM+bNIENev3ZG7t2fI+CXwWY9L8PHX4QpulYp75kk6orOP13KzjzVLN?=
 =?us-ascii?Q?2BQkybHzmzZ6LpIwkCrGxYzhjNLRKGOt47k9x9nnMmSzVS5V1SSO0+yXgdcA?=
 =?us-ascii?Q?Bch0qJgt4S8PuneFYnPAMUwU76w5CSUyHcQeAbOPi1IXh+xqXTSPvsw2nM8b?=
 =?us-ascii?Q?9leVP8kfOLaX/3YxFXeomin/1SJpqMOIAzBN?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Osb+gTW/yrc7OtzDt/5HEGVm+yQQ+5PArj7OYF5zPx7/nKqBGMTwvzkvrkWJAzjAKmO/gXV5LmStp0KzRWv7cQhKYb7aHFXnqRlUsvrKXSLXcXT3LgoKUPnoYwZHNuOoN4Ilx+egA5clIAyVSnW4ksBN8eFKeFSyTr0wI5KspXyuH+BhzUL4hvy1OZYh2VetWI0uTigHsAZVTTnskxpCRqeYXFDf4TNeUXVAX/kalWeKzX/LfHuOEj/W4HvAgOD2dzaXHdwstD/oDq2xYHusYY6EQxP3vqPNQVCnosGjdHoPijo2eZo7//edYHEKnzwSEp//ZXGOqIYJtC6SjRFsrcOOrN8LVWMWOtaJQBtvf5iikuaR18h+rsAHjVnLC557zHb/s+vLtet57hqoR2/NQ+hJhwzgf0VYfQtJLwvnwcQ6XrOoQdezpXO9wLx+OIJ/dz+5IIdanfuI3MKgf5re2JwXPvCNjxypVzrGOdoWCOFEKhmcFhKS2Jr9TT/TY9KkSC25a6Wbb+wm1N6BsW48pzKg9B+zmP+rQZIumwJ/paE0yOtppcfik4SsFurMygSOzOBREzKfN0cpbQPY9jKVPidxzAnVVimTh7dv/gfhLHaQF1qDzsgmWAJ3iUi3fywh9GuFirP6ELtjtwfHhHBNdQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:05:12.9536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c830ebe-45a2-4145-b5b4-08ddeec79585
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P190MB1703
X-BESS-ID: 1757329515-302355-7669-4101-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.83.137
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGpkaWQGYGUDTJ3DjNLMXENM
 3U0MjQ0jzJ1CA10STVPDXZyDjV3NTEQKk2FgBjH8/KQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267333 [from 
 cloudscan10-175.eu-central-1a.ess.aws.cudaops.com]
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

The port event service is responsible for handling port events.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/include/ntdrv_4ga.h |   1 -
 drivers/net/ntnic/include/ntos_drv.h  |   2 +-
 drivers/net/ntnic/ntnic_ethdev.c      | 271 +++++++++++++++-----------
 drivers/net/ntnic/ntutil/nt_service.c |  12 ++
 drivers/net/ntnic/rte_pmd_ntnic.h     |   2 +
 5 files changed, 174 insertions(+), 114 deletions(-)

diff --git a/drivers/net/ntnic/include/ntdrv_4ga.h b/drivers/net/ntnic/include/ntdrv_4ga.h
index c143c0c2b6..ee0e66c4d4 100644
--- a/drivers/net/ntnic/include/ntdrv_4ga.h
+++ b/drivers/net/ntnic/include/ntdrv_4ga.h
@@ -16,7 +16,6 @@ typedef struct ntdrv_4ga_s {
 
 	volatile bool b_shutdown;
 	rte_spinlock_t stat_lck;
-	rte_thread_t port_event_thread;
 } ntdrv_4ga_t;
 
 #endif	/* __NTDRV_4GA_H__ */
diff --git a/drivers/net/ntnic/include/ntos_drv.h b/drivers/net/ntnic/include/ntos_drv.h
index 047c077057..e6e46f8cc1 100644
--- a/drivers/net/ntnic/include/ntos_drv.h
+++ b/drivers/net/ntnic/include/ntos_drv.h
@@ -21,7 +21,7 @@
 #define NUM_MULTICAST_ADDRS_PER_PORT (16U)
 
 #define NUM_ADAPTER_MAX (8)
-#define NUM_ADAPTER_PORTS_MAX (128)
+#define NUM_ADAPTER_PORTS_MAX (2)
 
 
 /* Max RSS queues */
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 54c9e218bc..7ec1c94a14 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -1549,7 +1549,8 @@ drv_deinit(struct drv_s *p_drv)
 	if (fpga_info->profile == FPGA_INFO_PROFILE_INLINE) {
 		nthw_service_del(RTE_NTNIC_SERVICE_FLM_UPDATE);
 		profile_inline_ops->flm_free_queues();
-		THREAD_JOIN(p_nt_drv->port_event_thread);
+		nthw_service_del(RTE_NTNIC_SERVICE_PORT_0_EVENT);
+		nthw_service_del(RTE_NTNIC_SERVICE_PORT_1_EVENT);
 		/* Free all local flm event queues */
 		nthw_flm_inf_sta_queue_free_all(FLM_INFO_LOCAL);
 		/* Free all remote flm event queues */
@@ -1849,135 +1850,168 @@ static struct eth_dev_ops nthw_eth_dev_ops = {
 };
 
 /*
- * Port event thread
+ * Port event service
  */
-THREAD_FUNC port_event_thread_fn(void *context)
+static int port_event_service(void *context)
 {
 	struct pmd_internals *internals = context;
-	struct drv_s *p_drv = internals->p_drv;
-	ntdrv_4ga_t *p_nt_drv = &p_drv->ntdrv;
-	struct adapter_info_s *p_adapter_info = &p_nt_drv->adapter_info;
-	struct flow_nic_dev *ndev = p_adapter_info->nt4ga_filter.mp_flow_device;
+	RTE_ASSERT(internals != NULL);
 
-	nt4ga_stat_t *p_nt4ga_stat = &p_nt_drv->adapter_info.nt4ga_stat;
-	struct rte_eth_dev *eth_dev = &rte_eth_devices[internals->port_id];
-	uint8_t port_no = internals->port;
+	const uint8_t port_no = internals->port;
+	if (port_no >= NUM_ADAPTER_PORTS_MAX) {
+		NT_LOG(ERR, NTNIC, "Invalid Port number");
+		return -1;
+	}
 
-	ntnic_flm_load_t flmdata;
-	ntnic_port_load_t portdata;
+	static ntdrv_4ga_t *p_nt_drv[NUM_ADAPTER_PORTS_MAX] = {NULL, NULL};
+	static struct rte_eth_dev *eth_dev[NUM_ADAPTER_PORTS_MAX] = {NULL, NULL};
+	static nt4ga_stat_t *p_nt4ga_stat[NUM_ADAPTER_PORTS_MAX] = {NULL, NULL};
+	static ntnic_flm_load_t flmdata[NUM_ADAPTER_PORTS_MAX];
+	static ntnic_port_load_t portdata[NUM_ADAPTER_PORTS_MAX];
 
-	memset(&flmdata, 0, sizeof(flmdata));
-	memset(&portdata, 0, sizeof(portdata));
+	const int port_srv_tag[2] = {
+		RTE_NTNIC_SERVICE_PORT_0_EVENT,
+		RTE_NTNIC_SERVICE_PORT_1_EVENT
+	};
 
-	while (ndev != NULL && ndev->eth_base == NULL)
-		nt_os_wait_usec(1 * 1000 * 1000);
+	struct nt_service *port_event_srv = nthw_service_get_info(port_srv_tag[port_no]);
+	RTE_ASSERT(port_event_srv != NULL);
+
+	if (!NT_SERVICE_GET_STATE(port_event_srv)) {
+		struct drv_s *p_drv = internals->p_drv;
+		p_nt_drv[port_no] = &p_drv->ntdrv;
+		struct adapter_info_s *p_adapter_info = &p_nt_drv[port_no]->adapter_info;
+		struct flow_nic_dev *ndev = p_adapter_info->nt4ga_filter.mp_flow_device;
+		p_nt4ga_stat[port_no] = &p_nt_drv[port_no]->adapter_info.nt4ga_stat;
+		eth_dev[port_no] = &rte_eth_devices[internals->port_id];
+		if (ndev != NULL && ndev->eth_base == NULL)
+			return -1;
 
-	while (!p_drv->ntdrv.b_shutdown) {
-		/*
-		 * FLM load measurement
-		 * Do only send event, if there has been a change
-		 */
-		if (p_nt4ga_stat->flm_stat_ver > 22 && p_nt4ga_stat->mp_stat_structs_flm) {
-			if (flmdata.lookup != p_nt4ga_stat->mp_stat_structs_flm->load_lps ||
-				flmdata.access != p_nt4ga_stat->mp_stat_structs_flm->load_aps) {
-				rte_spinlock_lock(&p_nt_drv->stat_lck);
-				flmdata.lookup = p_nt4ga_stat->mp_stat_structs_flm->load_lps;
-				flmdata.access = p_nt4ga_stat->mp_stat_structs_flm->load_aps;
-				flmdata.lookup_maximum =
-					p_nt4ga_stat->mp_stat_structs_flm->max_lps;
-				flmdata.access_maximum =
-					p_nt4ga_stat->mp_stat_structs_flm->max_aps;
-				rte_spinlock_unlock(&p_nt_drv->stat_lck);
-
-				if (eth_dev && eth_dev->data && eth_dev->data->dev_private) {
-					rte_eth_dev_callback_process(eth_dev,
-						(enum rte_eth_event_type)RTE_NTNIC_FLM_LOAD_EVENT,
-						&flmdata);
-				}
+		memset(&flmdata, 0, sizeof(flmdata));
+		memset(&portdata, 0, sizeof(portdata));
+
+
+		NT_LOG(INF, NTNIC, "port[%u] event service started on lcore %i",
+			port_no, rte_lcore_id());
+		port_event_srv->lcore = rte_lcore_id();
+		NT_SERVICE_SET_STATE(port_event_srv, true);
+		return 0;
+	}
+
+	/*
+	 * FLM load measurement
+	 * Do only send event, if there has been a change
+	 */
+
+	nt4ga_stat_t *port_stat = p_nt4ga_stat[port_no];
+	ntnic_flm_load_t *port_flm_load = &flmdata[port_no];
+	ntnic_port_load_t *port_load = &portdata[port_no];
+
+	if (port_stat->flm_stat_ver > 22 && port_stat->mp_stat_structs_flm) {
+		if (port_flm_load->lookup != port_stat->mp_stat_structs_flm->load_lps ||
+			port_flm_load->access != port_stat->mp_stat_structs_flm->load_aps) {
+			rte_spinlock_lock(&p_nt_drv[port_no]->stat_lck);
+			port_flm_load->lookup = port_stat->mp_stat_structs_flm->load_lps;
+			port_flm_load->access = port_stat->mp_stat_structs_flm->load_aps;
+			port_flm_load->lookup_maximum =
+				port_stat->mp_stat_structs_flm->max_lps;
+			port_flm_load->access_maximum =
+				port_stat->mp_stat_structs_flm->max_aps;
+			rte_spinlock_unlock(&p_nt_drv[port_no]->stat_lck);
+
+			if (eth_dev[port_no] &&
+				eth_dev[port_no]->data &&
+				eth_dev[port_no]->data->dev_private) {
+				rte_eth_dev_callback_process(eth_dev[port_no],
+					(enum rte_eth_event_type)RTE_NTNIC_FLM_LOAD_EVENT,
+					&flmdata);
 			}
 		}
+	}
 
-		/*
-		 * Port load measurement
-		 * Do only send event, if there has been a change.
-		 */
-		if (p_nt4ga_stat->mp_port_load) {
-			if (portdata.rx_bps != p_nt4ga_stat->mp_port_load[port_no].rx_bps ||
-				portdata.tx_bps != p_nt4ga_stat->mp_port_load[port_no].tx_bps) {
-				rte_spinlock_lock(&p_nt_drv->stat_lck);
-				portdata.rx_bps = p_nt4ga_stat->mp_port_load[port_no].rx_bps;
-				portdata.tx_bps = p_nt4ga_stat->mp_port_load[port_no].tx_bps;
-				portdata.rx_pps = p_nt4ga_stat->mp_port_load[port_no].rx_pps;
-				portdata.tx_pps = p_nt4ga_stat->mp_port_load[port_no].tx_pps;
-				portdata.rx_pps_maximum =
-					p_nt4ga_stat->mp_port_load[port_no].rx_pps_max;
-				portdata.tx_pps_maximum =
-					p_nt4ga_stat->mp_port_load[port_no].tx_pps_max;
-				portdata.rx_bps_maximum =
-					p_nt4ga_stat->mp_port_load[port_no].rx_bps_max;
-				portdata.tx_bps_maximum =
-					p_nt4ga_stat->mp_port_load[port_no].tx_bps_max;
-				rte_spinlock_unlock(&p_nt_drv->stat_lck);
-
-				if (eth_dev && eth_dev->data && eth_dev->data->dev_private) {
-					rte_eth_dev_callback_process(eth_dev,
-						(enum rte_eth_event_type)RTE_NTNIC_PORT_LOAD_EVENT,
-						&portdata);
-				}
+	/*
+	 * Port load measurement
+	 * Do only send event, if there has been a change.
+	 */
+	if (port_stat->mp_port_load) {
+		if (port_load->rx_bps != port_stat->mp_port_load[port_no].rx_bps ||
+			port_load->tx_bps != port_stat->mp_port_load[port_no].tx_bps) {
+			rte_spinlock_lock(&p_nt_drv[port_no]->stat_lck);
+			port_load->rx_bps = port_stat->mp_port_load[port_no].rx_bps;
+			port_load->tx_bps = port_stat->mp_port_load[port_no].tx_bps;
+			port_load->rx_pps = port_stat->mp_port_load[port_no].rx_pps;
+			port_load->tx_pps = port_stat->mp_port_load[port_no].tx_pps;
+			port_load->rx_pps_maximum =
+				port_stat->mp_port_load[port_no].rx_pps_max;
+			port_load->tx_pps_maximum =
+				port_stat->mp_port_load[port_no].tx_pps_max;
+			port_load->rx_bps_maximum =
+				port_stat->mp_port_load[port_no].rx_bps_max;
+			port_load->tx_bps_maximum =
+				port_stat->mp_port_load[port_no].tx_bps_max;
+			rte_spinlock_unlock(&p_nt_drv[port_no]->stat_lck);
+
+			if (eth_dev[port_no] && eth_dev[port_no]->data &&
+				eth_dev[port_no]->data->dev_private) {
+				rte_eth_dev_callback_process(eth_dev[port_no],
+					(enum rte_eth_event_type)RTE_NTNIC_PORT_LOAD_EVENT,
+					&portdata);
 			}
 		}
+	}
 
-		/* Process events */
-		{
-			int count = 0;
-			bool do_wait = true;
-
-			while (count < 5000) {
-				/* Local FLM statistic events */
-				struct flm_info_event_s data;
-
-				if (nthw_flm_inf_queue_get(port_no, FLM_INFO_LOCAL, &data) == 0) {
-					if (eth_dev && eth_dev->data &&
-						eth_dev->data->dev_private) {
-						struct ntnic_flm_statistic_s event_data;
-						event_data.bytes = data.bytes;
-						event_data.packets = data.packets;
-						event_data.cause = data.cause;
-						event_data.id = data.id;
-						event_data.timestamp = data.timestamp;
-						rte_eth_dev_callback_process(eth_dev,
-							(enum rte_eth_event_type)
-							RTE_NTNIC_FLM_STATS_EVENT,
-							&event_data);
-						do_wait = false;
-					}
-				}
-
-				/* AGED event */
-				/* Note: RTE_FLOW_PORT_FLAG_STRICT_QUEUE flag is not supported so
-				 * event is always generated
-				 */
-				int aged_event_count = flm_age_event_get(port_no);
-
-				if (aged_event_count > 0 && eth_dev && eth_dev->data &&
-					eth_dev->data->dev_private) {
-					rte_eth_dev_callback_process(eth_dev,
-						RTE_ETH_EVENT_FLOW_AGED,
-						NULL);
-					flm_age_event_clear(port_no);
+	/* Process events */
+	{
+		int count = 0;
+		bool do_wait = true;
+
+		while (count < 5000) {
+			/* Local FLM statistic events */
+			struct flm_info_event_s data;
+
+			if (nthw_flm_inf_queue_get(port_no, FLM_INFO_LOCAL, &data) == 0) {
+				if (eth_dev[port_no] && eth_dev[port_no]->data &&
+					eth_dev[port_no]->data->dev_private) {
+					struct ntnic_flm_statistic_s event_data;
+					event_data.bytes = data.bytes;
+					event_data.packets = data.packets;
+					event_data.cause = data.cause;
+					event_data.id = data.id;
+					event_data.timestamp = data.timestamp;
+					rte_eth_dev_callback_process(eth_dev[port_no],
+						(enum rte_eth_event_type)
+						RTE_NTNIC_FLM_STATS_EVENT,
+						&event_data);
 					do_wait = false;
 				}
+			}
 
-				if (do_wait)
-					nt_os_wait_usec(10);
-
-				count++;
-				do_wait = true;
+			/* AGED event */
+			/* Note: RTE_FLOW_PORT_FLAG_STRICT_QUEUE flag is not supported so
+			 * event is always generated
+			 */
+			int aged_event_count = flm_age_event_get(port_no);
+
+			if (aged_event_count > 0 &&
+				eth_dev[port_no] &&
+				eth_dev[port_no]->data &&
+				eth_dev[port_no]->data->dev_private) {
+				rte_eth_dev_callback_process(eth_dev[port_no],
+					RTE_ETH_EVENT_FLOW_AGED,
+					NULL);
+				flm_age_event_clear(port_no);
+				do_wait = false;
 			}
+
+			if (do_wait)
+				nt_os_wait_usec(10);
+
+			count++;
+			do_wait = true;
 		}
 	}
 
-	return THREAD_RETURN;
+	return 0;
 }
 
 /*
@@ -2547,10 +2581,23 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 			}
 		}
 
-		/* Port event thread */
+		/* Port event service */
 		if (fpga_info->profile == FPGA_INFO_PROFILE_INLINE) {
-			res = THREAD_CTRL_CREATE(&p_nt_drv->port_event_thread, "nt_port_event_thr",
-					port_event_thread_fn, (void *)internals);
+			struct rte_service_spec port_event_spec = {
+				.callback = port_event_service,
+				.socket_id = SOCKET_ID_ANY,
+				.capabilities = RTE_SERVICE_CAP_MT_SAFE,
+				.callback_userdata = internals
+			};
+
+			sprintf(port_event_spec.name, "ntnic-port_%d_event_service", n_intf_no);
+
+			const int port_srv_tag[2] = {
+				RTE_NTNIC_SERVICE_PORT_0_EVENT,
+				RTE_NTNIC_SERVICE_PORT_1_EVENT
+			};
+
+			res = nthw_service_add(&port_event_spec, port_srv_tag[n_intf_no]);
 
 			if (res) {
 				NT_LOG(ERR, NTNIC, "%s: error=%d",
diff --git a/drivers/net/ntnic/ntutil/nt_service.c b/drivers/net/ntnic/ntutil/nt_service.c
index c109b44483..9f22ee2bba 100644
--- a/drivers/net/ntnic/ntutil/nt_service.c
+++ b/drivers/net/ntnic/ntutil/nt_service.c
@@ -24,6 +24,18 @@ static struct nt_service g_nt_services[RTE_NTNIC_SERVICE_MAX] = {
 		.lcore = RTE_MAX_LCORE,
 		.initialized = false,
 	},
+	[RTE_NTNIC_SERVICE_PORT_0_EVENT] = {
+		.tag = RTE_NTNIC_SERVICE_PORT_0_EVENT,
+		.id = NT_SERVICE_UNKNOWN_ID,
+		.lcore = RTE_MAX_LCORE,
+		.initialized = false,
+	},
+	[RTE_NTNIC_SERVICE_PORT_1_EVENT] = {
+		.tag = RTE_NTNIC_SERVICE_PORT_1_EVENT,
+		.id = NT_SERVICE_UNKNOWN_ID,
+		.lcore = RTE_MAX_LCORE,
+		.initialized = false,
+	},
 };
 
 inline struct nt_service *nthw_service_get_info(const enum rte_ntnic_service_tag tag)
diff --git a/drivers/net/ntnic/rte_pmd_ntnic.h b/drivers/net/ntnic/rte_pmd_ntnic.h
index 6fe6541984..1a68cb8e37 100644
--- a/drivers/net/ntnic/rte_pmd_ntnic.h
+++ b/drivers/net/ntnic/rte_pmd_ntnic.h
@@ -43,6 +43,8 @@ enum rte_ntnic_event_type {
 enum rte_ntnic_service_tag {
 	RTE_NTNIC_SERVICE_FLM_UPDATE = 0,
 	RTE_NTNIC_SERVICE_STAT = 1,
+	RTE_NTNIC_SERVICE_PORT_0_EVENT = 2,
+	RTE_NTNIC_SERVICE_PORT_1_EVENT = 3,
 	RTE_NTNIC_SERVICE_MAX
 };
 
-- 
2.45.0

