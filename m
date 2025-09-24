Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AA3CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:42:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25B8240BA2;
	Wed, 24 Sep 2025 16:42:13 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 15ACD40A6E
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:42:05 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11023134.outbound.protection.outlook.com
 [52.101.83.134]) by mx-outbound22-32.eu-central-1b.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Sep 2025 14:42:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZ+eNBPq16lV5tZnK7dQLfpKcFF+isTXO/z2ZSDePCMl1g0zf9+inNxfec1b6hbYsoZvGWDT3MtmZXQQQkMc5sJyWgGYXf1ZthOrXfK3Cb4ZE6eo6HUAzaWaFGxLf9OQdSW+zAnW9r8USkG6lS7mj8gfslHDQiRJ1RrbJ3A/zmDManM0Jo7hUQkWNXToY9PGyAMGTHQkKKtzhIOrEs5c61BvFXT72UL6jBVW2v+G98BiJCO70wgKm4vIHAQjmSon2cEPKocdBDKq+uH8a+v9o1qQlzWXnRf9XKrLX7QbNRaAktzPgBctTfD/+yDxz7RjBrjmU6f+s8rCdlyW1mxdvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZg9D7tawOfQe3N7kAQd4XPMi713ywFs36aHCdG1CH8=;
 b=Fq+ipzm4Sa6HDNAsQ3o5tFib8jCqnn/BOO9kI94mpF6ukNGlYhPw3gFKk2dd+JhZpCfyL3FTV7uqDPc5SUaCypKMkuVz4SvyfVBQhp3OvUrQ2H4yGklSVIYKgAeU/1EJy1avU2k4GXTEq7137BXr6dq5q9oWz/TQdst4h1rORixpxpvjIxsRX8AQoQY842l4NZgYLP3MiiTX4lkWS1fdqCWcHrqHA3kbMgByy4rdymH8bKWOsS+o9i1tC2ZIoyQlv/+cJfR9tioxToW9fGXVgAHOBiZJ7UFatl0Eg9tzMsMnQeYDsOIs2WlxclUMjicde6OvJTTDFR7mUfi2TBKfgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZg9D7tawOfQe3N7kAQd4XPMi713ywFs36aHCdG1CH8=;
 b=G+DjK8dKAtTZmd3pJkQaLHDMYqQZD/qC70yZ8Hng/zIrABluJPnvXYc3+Rh0k9ayeIdiibahNNNn9A1w9V+hlWepU+sSM5AXBlBmtjJKtn9fe1nHNtxPDv4QjEaIxZZ8nSbAtXitq3aPSNIZ89zKtqmDG/P316XC6b/lipt9Wwo=
Received: from CWLP123CA0235.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::23)
 by VE1P190MB0846.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1a1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 14:41:59 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::d0) by CWLP123CA0235.outlook.office365.com
 (2603:10a6:400:19f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 14:41:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:41:59
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 04/24] net/ntnic: migrate port event thread to service
Date: Wed, 24 Sep 2025 16:41:27 +0200
Message-ID: <20250924144152.53203-5-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250924144152.53203-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20250924144152.53203-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|VE1P190MB0846:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 28b0c70d-87d8-4c90-5aab-08ddfb788494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5dNoEHmsnLESOTgbrUUjiNVnCVs/7JHjZvKW5w04RYArzQpT3VjJJXOpYpAZ?=
 =?us-ascii?Q?Dei5TuI5csddJ1Kf8MFFGps21/94f4HQJ9LztbwZsEturBg658DdpFGa6iVO?=
 =?us-ascii?Q?OwivcWCj+3MPWEIkxuDZ+337zBD0vNuxFOJU9HfoZXaD+GXVN8JrhRsexy73?=
 =?us-ascii?Q?7wKep4rkNvi4vInJP+3PoCgQD1Y4XoQbho4jAKCknz4DlA9coxVkr3AksJae?=
 =?us-ascii?Q?CpjQZaluLMwZN8TdjkScfMWxT6iV4ICVrr7oixKB8rOlnhFlTUnjzSS162ag?=
 =?us-ascii?Q?VDPfsXeyUSW8h9UbJXjy3ZVTPVGT0vuvFVhmz5ZmjZfjjw/oI3U5xtBmKEsE?=
 =?us-ascii?Q?nsK4ws0oA73r0BaU7G/laYY8KEEOu3bVjHgkVgP9kWBf1I1aJGUNkP+Wer5q?=
 =?us-ascii?Q?CwS1qulXiMkBK+20V6vTspfbSa1biMLzKSeGHkpLJ6jJKkvCF5+goEdNHYyB?=
 =?us-ascii?Q?tN3Ek5KcSHAL+hzrMI/U9A2jHu02KZE/KILo3uvNvqSr8IYCFeVrzxXKZtUV?=
 =?us-ascii?Q?cPiBRjAXUJvvQghfEvKClUttlwTeFu1jLn2nEF2zejwCRzAocGiLaNJ5uGjy?=
 =?us-ascii?Q?tNwv9S1fZRKVqfqUUfP/ScF5zBWemC253e7loK7utoDyX54cSPa94ClCTVjp?=
 =?us-ascii?Q?eAeQQBZ9hz4mTpfkIJKq+rZknab95vKUQVMCFPJITExNqxJPOdtBeL7Etrm+?=
 =?us-ascii?Q?4NKDU6l8bCUPLSuBG949KnhdoTzhlA3Uf2nPBlcz3S4lYl08EJbAo6BCyWHy?=
 =?us-ascii?Q?bjKVkFcL6gegtfSMiU5Z7Ag1//Ku0BGbBkxXEkMmFmCopuLEsr/jCtOuQDrW?=
 =?us-ascii?Q?8hprAJcecD5f3ywFidlO33GJq1DmLyncNMRw5InJLjsISEvjeUfkKuVcSaVa?=
 =?us-ascii?Q?6iphAsVnDDRW9/LsqJXyUNn1lfYNypibP81YgJOSY8OB2MiuxKCCZ0QwkbTI?=
 =?us-ascii?Q?SzKjyMUPMjL2UgasihF+kozebEtPEcG9K2sVYfocxSsAKg46nCXknD/y5hyL?=
 =?us-ascii?Q?EOwZtG2Fn1ZHPrm7pw+zZjtMNljq3fBVyaa/SnJ9KJhowTz6HmvORoB8U2pl?=
 =?us-ascii?Q?9Ju1tWXWHEHP7bHoyNZFvWr5ypPoY+se3Avd52SiEYQFvXOP7P8UvQSRz5w5?=
 =?us-ascii?Q?TW75k77MEVYT/6FllWAkVZ1IDlyotDGm6JG9DynqU+85cc6OJYHGTBahf6xG?=
 =?us-ascii?Q?Y98T9xSZVyWjtXcy91I1G4ho3fRYpfXcQ4xneAB/oCgvAQISrPKebZZmG6RU?=
 =?us-ascii?Q?Vl4bNtFG9N9UoF/4sS8llXtITXScdwXG3Y2a7i8ZdSuahMXZ4pkZhGcZiYw+?=
 =?us-ascii?Q?mSLWCPAVH5kNQ2AGCWR0qX5qJ+DQDFjjjEWltkwhXOg1ljv/HVguEqs2hl54?=
 =?us-ascii?Q?N7m2WdQ9Cqbmt4t/B6qumpnPjtK3eztcSOnInWt5piiiwTsdqooLzAtCMKgf?=
 =?us-ascii?Q?h8VodBQFMh2rWZRjKwoENptU+3X5M5PWVDWlPa9nQ8TQ41n/oBpoMraj//AO?=
 =?us-ascii?Q?Q46465Maw2A9waGm8/Vy0HcdOq0kSSCyu0dR?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YvjycgAUyy0h3QBk61nTH4Hf5mqSRHQf2dKZqazK09RG53B/3/+PY1hGfbuPXQMXIIRv4UZBV6UzdQDlFW5F6IHd+RuUzNmOCxlcfTCWSB0D3ebGKFPndwMfl/M5OwlbmQpoGg1/srBdCYNbbvfYV84kgRzjCduzjDzejmi9ofD30nLCYF2jDXRktMVVC+Yim474+EgwYbi6fqgWdxfDouxXSgUjLNX3pIjUs8slQwOJBd8u5Vr0qZ7apQYijvdiQXaS2QJaCLHQWGk8ulT2L5wVGnRLwej21sU50Vso7LQJeyrfDfgfU/YswMg9J80t6O7vtVYfGyUN7VhYEaq0ww1W5o34uMf0DNgyF3SXOJolAgwRvAt71Fge9UlQE/kOrZU3WWuXF54Y4yex9GXOeT7cBpWfmM6j5rCJ/akUkoqrxLzw/JMUWRJBOgsXdjkfXe4rb+hqe/JLzisauD7tq51SqPXFhy67sDkflr1R/ge6bk8V+QicsVvobx63M6Sj6qaD5lUMgluWBOe3dlaLPYbYtODbEbhtdVn1nqyIROEePwVlCxTu11poAToRybPotYRqEPlekpGZsP4WaGo4D2kquAk2aov10HbEOsNGR1KE3MQsvp9PtSCExC9hE0PgiMuXChCLpDaYKK4XGFDYPw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:41:59.4417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b0c70d-87d8-4c90-5aab-08ddfb788494
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P190MB0846
X-BESS-ID: 1758724923-305664-7608-8011-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.83.134
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGpqYWQGYGUNTI2DTZMMk0Kd
 nUwszUwNzEPDE1JdEk1TTJzMAs0SDFTKk2FgA8XX30QgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267723 [from 
 cloudscan16-124.eu-central-1b.ess.aws.cudaops.com]
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

