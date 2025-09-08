Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08553CAC588
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 14:18:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF32040676;
	Mon,  8 Sep 2025 16:17:57 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 793A540615
 for <dev@dpdk.org>; Mon,  8 Sep 2025 16:17:53 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11022114.outbound.protection.outlook.com
 [52.101.66.114]) by mx-outbound45-224.eu-central-1c.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 08 Sep 2025 14:17:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7jd/PP4eyKoGSwFxCyfgP+h2UV6ls8ph9FjuT2CxWR9RcrOPsLReEyZz8RiaQGhoy/pHjDcC9k5+NiTR64yMhh6Y+bsQcw+lHTNLL3HFVxUbiBgzCrUKa0V59o9sk2ha/eC6y0F0MqQLc7vmigX1lvF4pPeGAMT7Y/OjZAwGLT4KgxD1lhTjXi3vHY8QgmaT93Cp9Ptdq/V8iuFdY/xtNMubFFJq4YX2NDdgrqjMgb47EgTIQ4ltalZKCKpGwtdm1vnizY3xsK2bEPxqoNgqCqO03ri3wAnU+mU0vy9DNZmUcLER2aeX2uWwIEmCcpG/AulI2BGDJY0tBGw5peIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EmQy/CGdxubNgs2Sfy9YidVi0WRds+jSHfKhVSHSbM=;
 b=wS21dOdmTt/5sgYNFcHSX46ZwN5sIE44nGIf4wL8lOYhweBeiJMZQivtzbPM03RnLIdaEV3FhF1+1aXmSr0mmUb4BxVTeuwSjhEOoHSv11q/LJsA4jlfTjzoRyiuWhTgm+Cc2lp7lecv88TcFec+W2OzLcON/SWjX6fjiyZ8Oy0tya6Et6Z31rrLJQ2o+Z4LNS7e8cNVlRlf5tjDFfWahDwE/RuZtyx3jvLY4ojxckmEU9EsyW7Y6LjON/X43jkau+Fcgxs70VET/BNyp+Fnv5w4b4DByHAZkGwL1W8Ovo/saKQO95McC+9zKgYy0NCbj4q/llFdlSpd7ioTY3/Mwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EmQy/CGdxubNgs2Sfy9YidVi0WRds+jSHfKhVSHSbM=;
 b=heIzoR9ui64EjR0Zq7dS1yQxA1y8uzgypgnLOrCcE11amCvykTzf1HnsORKRfhoo1Mc0AVaudjHRx871ZLhfsewVWbGJm+mHdxSmFY5ccdoGQmyvoxVGt7w2jYh/Sb7zsDmqTxkv7+WmJbjETSAZKn08jMykbaJGFyDP31c0VTk=
Received: from AS8PR05CA0027.eurprd05.prod.outlook.com (2603:10a6:20b:311::32)
 by PAXP190MB1766.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:283::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 14:17:50 +0000
Received: from AM3PEPF0000A798.eurprd04.prod.outlook.com
 (2603:10a6:20b:311:cafe::22) by AS8PR05CA0027.outlook.office365.com
 (2603:10a6:20b:311::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 14:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF0000A798.mail.protection.outlook.com (10.167.16.103) with Microsoft
 SMTP Server id 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 14:17:50
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 4/7] net/ntnic: migrate port event thread to service
Date: Mon,  8 Sep 2025 16:17:36 +0200
Message-ID: <20250908141740.1312268-5-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250908141740.1312268-1-sil-plv@napatech.com>
References: <20250908110446.1071964-8-sil-plv@napatech.com>
 <20250908141740.1312268-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A798:EE_|PAXP190MB1766:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7708ab47-8f41-4140-b7e7-08ddeee27e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kJm9lZJ5fUGbyI8F6FUum65gDaquJshZGUQtZBtAXNwyQC6AKDpz00fvgqrO?=
 =?us-ascii?Q?uCnoSSyGY/X3UV/R3GvaKGTUwCGMkuSZarMjzW6gEeQ7EzCD0AApvMnhHwL/?=
 =?us-ascii?Q?iaEm2xV+YSDO7DDM06tq1XDdM5BqyzPIv2nphIinlo+dBx7TfoOBsOF8CLxZ?=
 =?us-ascii?Q?eThKiTS7py9nkgGVspi2wC2EZnrWyuVeYbQW8Lc+cHvIlBgiUP/zGUYyJDWi?=
 =?us-ascii?Q?ONOtzOI5Ikh62wPQmq0elRFZ14070IFEYU02WTXmv1BEFVhTZXGylyl4KcFe?=
 =?us-ascii?Q?QicKbCQT/lnZ3qCZWiML+bVQac5TT/FJdaduBoBpz+bunKjRwv3BdxS8LZuO?=
 =?us-ascii?Q?aYZo8Rc9iumqJMQ401d6Va/UaULgMig62EMKv1S1ZVvztB6tQqqJtrOzZRKR?=
 =?us-ascii?Q?Vid/z8ldOWHeHFq6mxNroZkNXAg3UO12JN7k831c+647bW/NET13SvscApoN?=
 =?us-ascii?Q?SIFbH/14Nv9e/bo+HGtLf+Mx25Nr44Lt5CluvFwSjk3c8kavrqSUMiglQ46n?=
 =?us-ascii?Q?QNW4On4PXxRGesoyUn0MoeNo08SOqob3u5snELNsRxaUHmpl5XskcGvjNnw+?=
 =?us-ascii?Q?ENzLnJPlmb3PcfYu61O9JXAwyA4IjWIITJiKVu7DraZJN2TBJdircOzU1ReQ?=
 =?us-ascii?Q?tazGjT+cSMEiT/cq2xmRcAePAxVTTR1Fe5LL2y6WfTZ4p74nQTgDDFrkSGG4?=
 =?us-ascii?Q?BCVSdqRJRtJv+N+FgwomSoMdUOQoTaY4zi7/13xZtZcOEVCSL6eHr5/p/0sK?=
 =?us-ascii?Q?oHlAwKB4gwke4dn99EB3p8qszj83E45aTM/xCKQC9GjJpeeB87LWu+k5jshP?=
 =?us-ascii?Q?JvbnV6fLYevjvIl3D4afJ8OmG/hs0wsaK5s+G39I3iF1xQJszH/PCWR32Sud?=
 =?us-ascii?Q?ZQv/Hl50ZL1JlJ+CyaZMrmdMedwCR6r6HkIGbTGcU1DRsAtxxaQKX4EI6Uix?=
 =?us-ascii?Q?3wIhp6McpyzNnljEa1eXvpwz+ksDh6XPGNqvfGcJk8QaPxQ43LbdAY5Edkuw?=
 =?us-ascii?Q?XjP9hpswRkwD/pyeZEMEDfNkQsKCIOcREt7MDN6wZ7Dg7cX4Cjus/M8Yw4ZK?=
 =?us-ascii?Q?TPnAcBkQYFF398FvCcUgdy4jk1pNIbGcd97s7XIUS7rUqw0jZx9sesY2JrJL?=
 =?us-ascii?Q?wl3qj3Z9IGUONoUCkeQ4Nl4lGdjUeJZkWHGD/q+3bOHzd5zhXZfE8Yuhy8nA?=
 =?us-ascii?Q?fp2JNUTajL5V3j9X4rD4yRR850lnIalUhw+P06GqFqzt6BsjxTDAxq68WQ7N?=
 =?us-ascii?Q?F3ZA1SUklU9FyETpOIHmyDSAqfLhOyTq26X7gU24wkn0KclTo9KPj+kogZoo?=
 =?us-ascii?Q?ZO7Kz2RbXQCxz8C18vB6nXU/sHdlBJwbkGnYKQNaxbbNTbtojgcLVXFZDzkn?=
 =?us-ascii?Q?wPiDpS6twf7+SbQT9ytevYXL6+ZGnKzKGvpQxnCcl0Mqdd5F7TSA6ZYy+6QK?=
 =?us-ascii?Q?krb9tsiVSVRhtZeyAflCfuXNXsWpjiohFZCtYiVZu1mYza71iEtYbq6hDD2x?=
 =?us-ascii?Q?spGV6hmzysfB2lyBru0kI3skV9yp/5Mo8ORB?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YyhSKKR2LXCl5xt9lr2xYtaCCQLfwmeJ8YE2qXF/dRT0/+cUVx8vXc22rD0MwbvNIKWMNontaxkp3g50JYPP+rhUZjZit6y4zUdsCCxHOBk9DnAVOHKXIM2gUkyhlleZFcr7bzEHvma3egzY9POfgoUkhPvddMIMvqfpTXf08WfxbfyXbiZFWxcs4rSqngzgw8003X67kzBpIjZXcThXo2Om266YR8jhF0VTaFMOUECEzLbFDJmfdsWsCj3N2rwG/3xMFwDsGMqqdvfg6t6u7qFb5NJA8EDbN+4GSu7glDDZatBTI96U+XzzSp6NHLzRc7E5GiaV/seg5zSN1hBvz71G6RtTacs+WN4EL9JJX/0HnFYUqET6j9U0Pq/23bpI/QBq0Afe1ucM2mWxta5j+7nnS6fsKamObbi8qWo68n0CFHZx9BgLISYHFMapb1+cK6Gb+qdl8iu5CQs2Yt6HNxF6hZB2JvuLML5PfFY3o6cCGkA1fN7ebMDSrUWZd+5iG6BqmOGtpjOGidx+l4l9Tefu40hNLWpEK8n0jynOSFO7ze7QBrk4O0bSwlLSVR6T7LE9fGuHe1om/zLfUtDk3ZS8J/7E8J/goH9q7qcHgAgiemh2W+/mc2o+ZgIVf8FFi2qjmhWgUaJgiqYl9Co7ow==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 14:17:50.0176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7708ab47-8f41-4140-b7e7-08ddeee27e0b
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A798.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP190MB1766
X-BESS-ID: 1757341071-311744-22019-3578-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.66.114
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGpkaWQGYGUDTJ3DjNLMXENM
 3U0MjQ0jzJ1CA10STVPDXZyDjV3NTEQKk2FgBjH8/KQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267336 [from 
 cloudscan21-8.eu-central-1b.ess.aws.cudaops.com]
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

