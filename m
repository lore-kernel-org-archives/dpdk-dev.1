Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE7ECCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:37:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D280640657;
	Mon, 20 Oct 2025 18:36:38 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 794F2400D6
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:36:32 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020074.outbound.protection.outlook.com [52.101.69.74])
 by mx-outbound47-33.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:36:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4AXAJCmygpPX0gL2ZUs4AnZOKdRK4yBBDIm0c/bHKoYZ/AACbDoiw9T5do19KxnfPAO5h9y1flHMmlWRpn98yVSsswanMdAONM0752I+XzaUjpFtcssjfYCpVhqH9edhFSD9YZMl8oKk+Z3XSIk95VaNh79cCJrOKL6noM4X419Z2nXGoBV528UJHAGf0UUXVXGJ0oQwbFZyqtBDMk645vQzTxB1N9O99goC36xxTfRJFAOMs9fbxrmPOwyegUmvmpFcYaQ9YhwtNy5piCk5yAD0HgdP98+yllWYhgKNVtpL1+pe1Ws9cuny+qcq4zNdZIn+t9npuCljxv+dyeisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZg9D7tawOfQe3N7kAQd4XPMi713ywFs36aHCdG1CH8=;
 b=IQbT1oiN/+0gpM7auN6UuDJ3Kjt2iJFH/XO6xEIuks4nH9BimZvC1ek12iia9qGh0s54qh9wxUvHvYm9VZs63hrjFbTpcnEhe4IiRFy/iB+z4kNvmYPezBER95zbofAmImV9sZhONV/XfRLXyaA5ECbLzIJ1FSB83B50+PJtU2vLRbzzhPSgfzLdJ9uDqHozdJQgnzq7PJ7e3rGAqmfsN8jh33owFlBQVnzFaLlcOZfIWH2nUebPnoZvK6sRmgGhdOCFRUG/zzTrwTNDVjhKD4WFdCHR0kV4EO4MaXizpRb99Zr3mwX5V5sHXeTVPnflmw5wtl9WwVpXT1FoClsvmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZg9D7tawOfQe3N7kAQd4XPMi713ywFs36aHCdG1CH8=;
 b=SpCRX1H8zEjG8aO+Gpwua3hA6o2ecuEPRAKoUgFdZsG886YNpq7r/CEKy65hnoho+R2Q/iaULpRJC6WLs8HxFndaGJCeue4+pKTmaeC7Q7JQtUiKQYo++Q2cWr4ykqPiXK7uoZmXcsNYlHvP5iZUcy0cSPlKDFL3obo99fS3XlU=
Received: from AS4P191CA0029.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::12)
 by DU4P190MB2198.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:56f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Mon, 20 Oct
 2025 16:36:29 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::65) by AS4P191CA0029.outlook.office365.com
 (2603:10a6:20b:5d9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 16:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:36:29
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 04/24] net/ntnic: migrate port event thread to service
Date: Mon, 20 Oct 2025 18:35:55 +0200
Message-ID: <20251020163620.282312-5-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020163620.282312-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20251020163620.282312-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|DU4P190MB2198:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5c206d17-ae2c-4578-3443-08de0ff6d25d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LjFj1AEnpiikHEBbOtY0tDDiFnjM3PLrpRC6gpeNd/jM/WeNQVfnYLxtds1w?=
 =?us-ascii?Q?lu1eh6pxroCQMxgFDXC8IdeFs2dZWuDUqwM9P1C6JxgTcjsbQ7woLiOBioWb?=
 =?us-ascii?Q?2GKRnUMcElNAGrNg7LGiRruhlXgLS7hmpdhdZZIFrjmO5fnpAjzCLtCwR4dA?=
 =?us-ascii?Q?SLWNCaj7LvZL5+vMOQeodsmWVgv0jAKoM3sdy63tigITM6L2sWC0yUkan+qz?=
 =?us-ascii?Q?o3g4leg6VmnygCrXoR0c4rYZ1tbymFIkdHaTsjzFh3MKbSzUmDYBXMN/mSeO?=
 =?us-ascii?Q?APj5DtuQN/ELebrt4C6cM1hL2qz0lfbl2XmrUSbaTh1gyBGtknNGkqgwoBPo?=
 =?us-ascii?Q?EdNVkhfm084F2O+XE+eykPzDfnEx4V/gfeLOl72zsVAd71Gt3bxLqJ8zjY/H?=
 =?us-ascii?Q?woa5f9G3Jtl4e0fxEfFudWzfhnQ0viOZLzBlZyEpGwdPToKNSZ+M3R1EjF5X?=
 =?us-ascii?Q?IvCn2ufoT8T3zq7vDT4M+Lrqs4/ScrJfSyTnGfYaQnEH1bsxl3NlJwMVqp03?=
 =?us-ascii?Q?ICA8NhHvChC/RNxyKqdqdWYzXe2mv7nOKKYQAA8LrnIu6ApRLHDzbUTJjPnk?=
 =?us-ascii?Q?NgnRSnFgeFP6x1GLpVwfsZU2ccHKkdR4qGzoKT3Yon0rCbFqfpNz/1WLaiUR?=
 =?us-ascii?Q?skcpWyAhd+G5gi18+3yiv7VXwR6QAnzoEa/lyv3OgO95lyeomr9ZQ3Y00KUW?=
 =?us-ascii?Q?PqKO5xiBwWWXZa7bjn4ffBD9+D14xOr5Tl39ikuKPgb8oq0L7yuyugCOQrIs?=
 =?us-ascii?Q?TPqndhGI8vHsiRPFO6F2xcojPKAILMJW/9tWw553OYXxcZfeJS/3ncg344XG?=
 =?us-ascii?Q?/e05KIGEPPcreRWQCbb64gUC0VEqk17615QIuw63nopvY1XLHly03+7P7bEU?=
 =?us-ascii?Q?+rcCF1VQALmbVT5RDCE9BvkMbHqiGcnkPQXVjRWMbD99OuYqAMeQYYj2laRa?=
 =?us-ascii?Q?szxFmvNs5t0zdQmfd1UVc8i8T9fdKJqzoVxrsz17eOVj8MRYAxldcV+njCWH?=
 =?us-ascii?Q?da1rvkx2nG8Pbock53djpf0tIqJf9crZyWwNKb+5sfAHitTAxTsyWqBFfFXE?=
 =?us-ascii?Q?wOGkCJHaYHuysgagkrK8Wt+58lBf5vlEofXmKNaCcQQRgPDKl3djy72TxiFJ?=
 =?us-ascii?Q?U+OLJSwpFLqLbmfkNaCONwGgtWPMjybtbQUNzg9egrSIlDpOxpRUKNHHq6es?=
 =?us-ascii?Q?MkEOtCqWFMf8iTLKD92Um6FufRGdL/BieBwm1XXoy3XyfraiRJJsHDWN11Q6?=
 =?us-ascii?Q?M/TMNxte+Zfs0qdr7JzWCO4kLEvPuWb6QHyb/w6FwOYur55gfPQQH0BAcPfc?=
 =?us-ascii?Q?GfcJfmEwFDE1XwNg7fBNJYb/hvIgafpUtfAmPbIgaudNtt54uRv+K9X3u1Bq?=
 =?us-ascii?Q?0r/2iY5O8R+xcwr6l7G41WUsbaL0ohGZiWXdJAmSrRfK3Lyn86fSSROzN56L?=
 =?us-ascii?Q?bFPqmS6kL5I6Ufsm4gMn202qSdpNGh7Xn1pYaIzsA6ck+ekPC22fqVwsB12G?=
 =?us-ascii?Q?Dxh9qopiZyDGeJ7XIyBXQmWhACpLiYZeEYnh4kVoclXthGSvv0x46laTuOY9?=
 =?us-ascii?Q?Dfv4W2RN6piTl4vxngw=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ws7PBmE8xol0fuUqnnkBgIHKoSNQkSpJfS7ZhC1dHXZhKkMsaqpzD8Tu2N9edey7SIkUnp/Nns0bO9baOl2NdSXk616JJGFTU44h0x4ek48+zSLIOukiW4kSRZgRdDtPnAw+xysGH1850OA0KL3Qx4jW5m7gPaZi70O/x5jY3vm8s1Fy4XCOf1sAj+WGqKv+/xfbfDD5MP6EWgzZek0msTVhySHhNRcUoh78jWiuvWUdJZXBwkL7TQAeHGbDIOJE0yXgP//n/b3j3O5wLKYM0ZlS9vaXaiPylIg7jJV8W8DkZNJw7k19nZ1tiMemRQu0TvhJ8M0hSTFCuhM4KAjakUhvqiexpXF7L+GaA+lRXSEthIYcX4r83VbGcA7QdkMDR3zH8cigpZ0QrGKIsSNX5OC5LdXw5DIAFNYHd3G8wsDpvnzBqJzf1KErzjtedMezkoo8IqpTujy4PTo9Ouf4EMTbbf1TzeZSw3XhgQK1MUWZWmHdSGYtkiFDccGdsAICp4r7BuRr52OBtG/u2FQ3L/ZAlFGnow9m5bnXEw6BpzMYbYu0/j6FGw9UhB6GdwPNDvBY8jm1kfMjyLERJ6FAfn8g0qq+G9590FTTDWUfG8Z6ektSrCfPQAZucPBoEGW5d2jWi7x0UsmgraXlZ7CMTdKUETGTOF7jTTRgACDvJXU=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:36:29.7736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c206d17-ae2c-4578-3443-08de0ff6d25d
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P190MB2198
X-BESS-ID: 1760978191-312065-25061-118006-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.69.74
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGpqYWQGYGUNTI2DTZMMk0Kd
 nUwszUwNzEPDE1JdEk1TTJzMAs0SDFTKk2FgA8XX30QgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan19-215.eu-central-1b.ess.aws.cudaops.com]
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
 drivers/net/ntnic/ntnic_ethdev.c      | 272 +++++++++++++++-----------
 drivers/net/ntnic/ntutil/nt_service.c |  12 ++
 drivers/net/ntnic/rte_pmd_ntnic.h     |   2 +
 5 files changed, 175 insertions(+), 114 deletions(-)

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
index 54c9e218bc..d98c0289cc 100644
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
@@ -2547,10 +2581,24 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
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
+			snprintf(port_event_spec.name, RTE_SERVICE_NAME_MAX,
+				 "ntnic-port_%d_event_service", n_intf_no);
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

