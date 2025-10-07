Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFFDCCA470
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 05:01:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6241D4067A;
	Tue,  7 Oct 2025 07:00:45 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013070.outbound.protection.outlook.com [52.101.72.70])
 by mails.dpdk.org (Postfix) with ESMTP id 87E7D40651
 for <dev@dpdk.org>; Tue,  7 Oct 2025 07:00:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pl5Zr976tCdzHIJby51WonwSLjoZYHBfYlX7s2Xw+AEkWy8wS2FefWaLnfBOsQNqV0LXzMGq+ROkuD5GNUcLIeWOUHIHDIwKnv+FWIP/LAq/sWQtnEW3Z7VwUCv7sd9K9kZ813lr+2+x0YE61clDj6xeSfp+MYTD6+Yiuhf8vtYnBVlxcmvn4rCCMgITLw8of0C29qD+UulLAZyDwjoPM3igAEkGCBo69GRHBvUbRNugdzSVFHXrp5W9a9ddbWkSZdO4banQl1XdOiX/qt/qTM2ENmns5wRNMzMaSYsq2TrpP6mOSXB3WeX6arS7/lK7u+NMYB/PA2gZbHMPATNYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7D4dEr11fdoH4LbXnGYrm/tNbu2v79hHX3b1rf/jVOM=;
 b=AVACYKViPQr26wlEF8aTPsBudgDA4ETRDJ0EoAXBPHrhPa0aWNWsho594yOTp6OGGzzgp3/gY+Zu92RSvj5Kx1DX3g0jVxl0CDAVPKNajY0HgLVPqNzHyoLcRRATdLTei5FrYfpLr/yvIR5CX5hXSSnCxvQ3uMpHHLlpQGQYvfCaVVF1GXqMoPLx7Hiz4jH3l/bZ1XhXgCiXyB0c1aJ/0RNeNbdrEOWkOZToN5Vk875fcIrRrlvk4/nA9HSNlAfhTB+siG9Mdjgf3HFg3u2V/p3XPTPhpjRPNLoQHn3uSAU1ixzDRVA+zPvKcvURCjsWL+VCEW/VltjlgoZjQ2ZmqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7D4dEr11fdoH4LbXnGYrm/tNbu2v79hHX3b1rf/jVOM=;
 b=QP7lHQNwqsThHrhg0VCWRKTeto7eyZWrEwm9QxzSaXAfz3/yZH7EUPa/Xbio927DLpXjB7KN0Jjnp2D6MhcgPzspiJsQl68EnMbpgyONG4mnx3EqROpPUACZBE4GHh4SVqR6MKhU4WP4h8rAb5QzjRwjQ4AVz7gjtgndpkQYiR1uW6fCr5XPmG3ghHteakqSnIQ1I3dQOSEoB21vW3LdXo0il0IN8Zq7HBgJpOkeTi3Hl9sh5cgrDSiTxNTQCXAJIVq1rTQBwsWlA74dL2eawea6fJTTLCLKQepxpg03m6YYeSASjvgCI5StcSs1laJRE15L5GHZartWrOw7P1VqRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PA1PR04MB10178.eurprd04.prod.outlook.com (2603:10a6:102:463::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 05:00:38 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 05:00:38 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH 4/5] bus/dpaa: Set max push RXQ number
Date: Tue,  7 Oct 2025 10:30:11 +0530
Message-Id: <20251007050012.2432449-5-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251007050012.2432449-1-g.singh@nxp.com>
References: <20251007050012.2432449-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:4:91::21) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|PA1PR04MB10178:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eae6e88-39c0-424f-941f-08de055e7525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Uy0GDhIEVUCJPk1XjCXSvrybFtAZ08SSdnZZ8SHlK7K6jbCOSJebmqNAY10f?=
 =?us-ascii?Q?Byrcy/DR+f6s0chNynIsjtcvrAewjvvg5GqTrpz+824Jngv1wCDQ0c7Sdbct?=
 =?us-ascii?Q?1/+vmbTPMfqnNQSVaDtEtgV9EUcqKdOyR5NAM2iPkwYTTkI9FNorngzC8M4P?=
 =?us-ascii?Q?mJ55wPpmP7nsraZ0WlMMEsnoIGYFfKj9BiHySIdixUB35cK4sFYJhik0UGjl?=
 =?us-ascii?Q?0ZntIxdBbtmYyAxMbJPhDn5EHshvoRkv5L+Om30yOl8+sxayd8c+Gi0qetUd?=
 =?us-ascii?Q?he2hE1tp1pw5tWACMOxo2tn1+FcqlnHKLtx3Hpvg6ANBDwdvDy8+ODfsO4Zg?=
 =?us-ascii?Q?MozZZ9yvF89KaIHapvc/bm867hwzX9jSoi+YPgtSfEXqzUBjB0v6kIdvXLwN?=
 =?us-ascii?Q?Hi0S4YKPo8WniFNF+GiBpS1tDFzZnj8cH0WpzpF8gSv4MR6NolHLLFoT7zQ7?=
 =?us-ascii?Q?jkETj9Ol4TAErFBVgCYQ7USrHpoUpA0DRrHDSndKYQhhAnOAbXil6/PEwezI?=
 =?us-ascii?Q?VZr+my0waAnJXg7T53CaWptEs/veVfqi0Spf8O0a9eQUFCKGDt51wlHMZr7f?=
 =?us-ascii?Q?Y2qV47UJhzHoycuckh7SPF0dDMCfKNpwbYQkuKXW0UV5+p4znx4caNa9G5Hz?=
 =?us-ascii?Q?0noS+E4paYoytClfyP91ZnRZ0ehx6W7a6LeOeuQ0UkjcucR+0cFQNNneyzK9?=
 =?us-ascii?Q?XxI/NC2nrURE8+gnTmiBqGNCWdW72rguejMN8TRuQVM8CdVqRIUGtqDiaPli?=
 =?us-ascii?Q?M165pjmK0b4CMnL16M2hDGynMhOb02kdHB4Me4JX+o48S8EiupQxVFYN/7p7?=
 =?us-ascii?Q?F+9NcZI3YRdQNLyqbGtIX6j48pVdBR4scr63mNePVgjmNGH6EtdNnFNlauy+?=
 =?us-ascii?Q?MBsRiU0tLwL9V30M9LSmNECB0XjApbsPPBxuHcszn8ntWRTXftTZden/k8m7?=
 =?us-ascii?Q?UnHOIdyL0ecV9Z7hbzsk2hOL/msBEEag6m5tRwcY4Ai1Ni1i0+a+vNVVmpkt?=
 =?us-ascii?Q?JHBG1hzFuvbfLM1KhKaX2mKqvAC3mVJYwsqnEqoZU46ouZ0Aq4jPfI/Wz4eL?=
 =?us-ascii?Q?gvoHGLI4KowUFzK6M6Ke5nwB1+tEFrLrysbSG14qfvyOpqbWdMKI9I7T8KXP?=
 =?us-ascii?Q?wyX3JG+jGi0fdVasLdmtr7SxnhKrD4ifyT0jndLIy9+yeLBi6wHZpUQQmsKe?=
 =?us-ascii?Q?JhXjtN+7eYuqeICsdQ8/C8csC+kwgQ2bc1jhudk6LNQDeKS757ZWxSmyIdQh?=
 =?us-ascii?Q?l7n5zBs6Scz+qIAzf4Bb6K6oIHhK+T9thLWlnHZpLJnqnOoGSalM8WkiYUCu?=
 =?us-ascii?Q?4XyUjWb5Ir5iIkVALPlZfAfsCAW9OKSCwFttWdPYy9vP5bvzFJ5qUQn1hU9W?=
 =?us-ascii?Q?iKUHSfLlHi9gTh/lfoY9nCy09UX9AZacWoH38IifXAWUHaHWm1NarlG11RmG?=
 =?us-ascii?Q?l38c258pNrO26ffVOuGfiOrnVnXTHJBQV5kwoC9qlVgy2dhlx33BLXRManIA?=
 =?us-ascii?Q?OUvZUHazX2hVkmDlp+8cVDLwSaRWT7vX4wzf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?px0gu8FTbffUUgYIG1Ih9y0qlzre3Spo4xW2M/zNOwFAyTmr9Vkw/xuk0h72?=
 =?us-ascii?Q?7A83IaiVPqkq1RjOiQL6yb5R6BWtTSCNqaqpdULx+VAPsdj1Y3QGU9pz1bWv?=
 =?us-ascii?Q?EDpDGIbunFVt3N5vkKYLxjK4Au6Xq5xJ4c8AR2NzyC+xD+1iI88hN8R0j+5H?=
 =?us-ascii?Q?DdkGIvObEzXhUxpksbTEdILJ7Pns5tIwYBu1/Qqqm+WgOay6bSDuxWjh9o+n?=
 =?us-ascii?Q?hv3rGFNRPAxlrMpuAwEgf8lHffMYyOL/WVze7GEuHhEXeWE1B9NppVqofoLr?=
 =?us-ascii?Q?4yh9LYqt/QYw0adYEUzCRnoXEzjjrnJ+/8cgiWx2f80W9fz2AptRbXBVFY/u?=
 =?us-ascii?Q?NbCNWVmaSBfzQ3+Cdl/e5PEZtPFNUsVw96fD4sJfoDgXvqqnXNn0HS6Mmc7A?=
 =?us-ascii?Q?X1Ehxe4XVWNzCS1C+sjn8qbdceXkBepvBfPh/uYkocvIen4TxXmYKTBUc+b2?=
 =?us-ascii?Q?7wdHesGCqs1EA0vsTOzNAsv1+kigqm0oeyqaD+Dy2T+rCpr1ggbA7DcZsTDM?=
 =?us-ascii?Q?rJZX7glSVGfji0fsq+jTOF3A9hgYFckzvQuuyPQ8qQg60qBcDcGwdP+ac+6V?=
 =?us-ascii?Q?WqXVD/FFU/Dd0ErXr99+sC+89bxDsqpkQ+fLNH5YLQ6nnMijyOwZEw42bVot?=
 =?us-ascii?Q?JQig5KLcAEj1QOeKxX3ngBcNGH12U5hQiJU8kb4ad5rGPaSqSb1nap8xgIog?=
 =?us-ascii?Q?IsR5hRGwm6/9yJ3WKpz6rEhzTkVrr4pZuqIduG8p7u6DNAkNiptim1Y+MwIN?=
 =?us-ascii?Q?o+Lwajvgq8kIQa5pSuVNuIsxxKRP8feSNf/rMuA1nUTWXNmpI0i8bqcQAqFi?=
 =?us-ascii?Q?qRxRNAPRDexragUBQWK4o8NmogQYlirPR7vf8dTlSrQgJ7fRVaN1Re+pPYsV?=
 =?us-ascii?Q?n5QAin4JcxYgrwmh1xbFJoyeHSEpgZqWNMVTR/Ug/Utk3RsUfGZ5E5LZvH/X?=
 =?us-ascii?Q?ukYQ9DXHjUs25w0pBWAMds7CqBy68Rri68xr98IbAWS5EcWJX/5ui9glEkwe?=
 =?us-ascii?Q?G4segyZAbEMEDVsyKJ6EzInG38mg0q5WcxjpSGIAuZpfH/nJEVTJ07pfErCd?=
 =?us-ascii?Q?EBoAtjzQ6yjb0eU++6kvSMHuYSAu0OwEKjfzEmF+26mu6/qGQFB0zjiIGEcD?=
 =?us-ascii?Q?K9sPnlyw8wLgkI+MNHeywJzPGDAE+k5Is8DII+oiNS1M1f3IbUmONsGIYAjc?=
 =?us-ascii?Q?jvWZCfPL31ngSq7obYVmXITRviePNmaVUL6UQdwWX4K8pmoypfGyRHUhQatg?=
 =?us-ascii?Q?J1CfEOC7aP+EZQZBjkAEQXPqckoibEgNDKL2f1ZUEaHfvsU8zWqXhiiE0heZ?=
 =?us-ascii?Q?+06YTmf1cG0SaWwMymkb4LWFJFAMN4ZU1UvCDyLfm78veDY66Ds8OksQzvob?=
 =?us-ascii?Q?wLEjP9KTeXHa/Q2Mz4LYmyZo39MxWCf5a8rEY4x1FwpXB+ueB+ghqUGDo3ET?=
 =?us-ascii?Q?XEjS9RJXQ78HeDDhsisCIdX7o3Xl8WoEiN0HBmPzsxYmcSiXiRc7Q1yvFTMM?=
 =?us-ascii?Q?JP47QIB29v+CFIzR0k0bLRC6gIipWNDbvGplBp2eXFHBRkpHn/jhoTVzk717?=
 =?us-ascii?Q?7RU5A6vWxOTeNFoqID0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eae6e88-39c0-424f-941f-08de055e7525
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 05:00:38.6583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4KJOkjZAz91h3KoaqsclFlIwGXWUXwk4FWDlS5MEsWe7bhBu1/4ziGAOsGC4kHC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10178
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

From: Jun Yang <jun.yang@nxp.com>

Max push queue number is bus level number affecting all dpaa devices.
Move the configuration from PMD driver to bus driver.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/bus_dpaa_driver.h |  6 ++++
 drivers/bus/dpaa/dpaa_bus.c        | 51 ++++++++++++++++++++++++++++++
 drivers/net/dpaa/dpaa_ethdev.c     | 51 ++++++++----------------------
 3 files changed, 70 insertions(+), 38 deletions(-)

diff --git a/drivers/bus/dpaa/bus_dpaa_driver.h b/drivers/bus/dpaa/bus_dpaa_driver.h
index 976f356699..cca0543432 100644
--- a/drivers/bus/dpaa/bus_dpaa_driver.h
+++ b/drivers/bus/dpaa/bus_dpaa_driver.h
@@ -249,6 +249,12 @@ struct fm_eth_port_cfg *dpaa_get_eth_port_cfg(int dev_id);
 __rte_internal
 uint32_t dpaa_soc_ver(void);
 
+__rte_internal
+int dpaa_push_queue_num_update(void);
+
+__rte_internal
+uint16_t dpaa_push_queue_max_num(void);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 1a35aa52df..d9830b68ca 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -50,6 +50,13 @@
 #define DPAA_SVR_MASK 0xffff0000
 #define RTE_PRIORITY_102 102
 
+#define DPAA_PUSH_RXQ_NUM_ARG "dpaa_push_rxq_num"
+/* At present we allow up to 4 push mode queues as default - as each of
+ * this queue need dedicated portal and we are short of portals.
+ */
+#define DPAA_MAX_PUSH_MODE_QUEUE 8
+#define DPAA_DEFAULT_PUSH_MODE_QUEUE 4
+
 struct rte_dpaa_bus {
 	struct rte_bus bus;
 	TAILQ_HEAD(, rte_dpaa_device) device_list;
@@ -57,6 +64,8 @@ struct rte_dpaa_bus {
 	int device_count;
 	int detected;
 	uint32_t svr_ver;
+	uint16_t max_push_rxq_num;
+	RTE_ATOMIC(uint16_t) push_rxq_num;
 };
 
 static struct rte_dpaa_bus rte_dpaa_bus;
@@ -91,6 +100,34 @@ dpaa_get_eth_port_cfg(int dev_id)
 	return &dpaa_netcfg->port_cfg[dev_id];
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_push_queue_num_update)
+int
+dpaa_push_queue_num_update(void)
+{
+	int ret = false;
+	uint16_t current, new_val;
+
+	current = rte_atomic_load_explicit(&rte_dpaa_bus.push_rxq_num,
+					   rte_memory_order_acquire);
+	if (current < rte_dpaa_bus.max_push_rxq_num) {
+		new_val = current + 1;
+		if (rte_atomic_compare_exchange_strong_explicit(&rte_dpaa_bus.push_rxq_num,
+				&current, new_val,
+				rte_memory_order_release,
+				rte_memory_order_acquire))
+			ret = true;
+	}
+
+	return ret;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_push_queue_max_num)
+uint16_t
+dpaa_push_queue_max_num(void)
+{
+	return rte_dpaa_bus.max_push_rxq_num;
+}
+
 static int
 compare_dpaa_devices(struct rte_dpaa_device *dev1,
 		     struct rte_dpaa_device *dev2)
@@ -681,6 +718,7 @@ rte_dpaa_bus_probe(void)
 	uint32_t svr_ver;
 	int probe_all = rte_dpaa_bus.bus.conf.scan_mode != RTE_BUS_SCAN_ALLOWLIST;
 	static int process_once;
+	char *penv;
 
 	/* If DPAA bus is not present nothing needs to be done */
 	if (!rte_dpaa_bus.detected)
@@ -709,6 +747,18 @@ rte_dpaa_bus_probe(void)
 			rte_dpaa_bus.svr_ver);
 	}
 
+	/* Disabling the default push mode for LS1043A */
+	if (rte_dpaa_bus.svr_ver == SVR_LS1043A_FAMILY) {
+		rte_dpaa_bus.max_push_rxq_num = 0;
+		return 0;
+	}
+
+	penv = getenv("DPAA_PUSH_QUEUES_NUMBER");
+	if (penv)
+		rte_dpaa_bus.max_push_rxq_num = atoi(penv);
+	if (rte_dpaa_bus.max_push_rxq_num > DPAA_MAX_PUSH_MODE_QUEUE)
+		rte_dpaa_bus.max_push_rxq_num = DPAA_MAX_PUSH_MODE_QUEUE;
+
 	/* Device list creation is only done once */
 	if (!process_once) {
 		rte_dpaa_bus_dev_build();
@@ -947,6 +997,7 @@ static struct rte_dpaa_bus rte_dpaa_bus = {
 		.dev_iterate = dpaa_bus_dev_iterate,
 		.cleanup = dpaa_bus_cleanup,
 	},
+	.max_push_rxq_num = DPAA_DEFAULT_PUSH_MODE_QUEUE,
 	.device_list = TAILQ_HEAD_INITIALIZER(rte_dpaa_bus.device_list),
 	.driver_list = TAILQ_HEAD_INITIALIZER(rte_dpaa_bus.driver_list),
 	.device_count = 0,
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 43aab98339..0baf5c03fa 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -89,16 +89,6 @@ static int fmc_q = 1;	/* Indicates the use of static fmc for distribution */
 static int default_q;	/* use default queue - FMC is not executed*/
 bool dpaa_enable_recv_err_pkts; /* Enable main queue to receive error packets */
 
-/* At present we only allow up to 4 push mode queues as default - as each of
- * this queue need dedicated portal and we are short of portals.
- */
-#define DPAA_MAX_PUSH_MODE_QUEUE       8
-#define DPAA_DEFAULT_PUSH_MODE_QUEUE   4
-
-static int dpaa_push_mode_max_queue = DPAA_DEFAULT_PUSH_MODE_QUEUE;
-static int dpaa_push_queue_idx; /* Queue index which are in push mode*/
-
-
 /* Per RX FQ Taildrop in frame count */
 static unsigned int td_threshold = CGR_RX_PERFQ_THRESH;
 
@@ -1113,7 +1103,7 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	struct qman_fq *rxq = &dpaa_intf->rx_queues[queue_idx];
 	struct qm_mcc_initfq opts = {0};
 	u32 ch_id, flags = 0;
-	int ret;
+	int ret, set_push_rxq = false;
 	u32 buffsz = rte_pktmbuf_data_room_size(mp) - RTE_PKTMBUF_HEADROOM;
 	uint32_t max_rx_pktlen;
 
@@ -1214,12 +1204,12 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		DPAA_PMD_DEBUG("if:%s sg_on = %d, max_frm =%d", dpaa_intf->name,
 			       fman_if_get_sg_enable(fif), max_rx_pktlen);
 	/* checking if push mode only, no error check for now */
-	if (!rxq->is_static &&
-	    dpaa_push_mode_max_queue > dpaa_push_queue_idx) {
+	if (!rxq->is_static)
+		set_push_rxq = dpaa_push_queue_num_update();
+	if (set_push_rxq) {
 		struct qman_portal *qp;
 		int q_fd;
 
-		dpaa_push_queue_idx++;
 		opts.we_mask = QM_INITFQ_WE_FQCTRL | QM_INITFQ_WE_CONTEXTA;
 		opts.fqd.fq_ctrl = QM_FQCTRL_AVOIDBLOCK |
 				   QM_FQCTRL_CTXASTASHING |
@@ -1269,7 +1259,7 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		qp = fsl_qman_fq_portal_create(&q_fd);
 		if (!qp) {
 			DPAA_PMD_ERR("Unable to alloc fq portal");
-			return -1;
+			return -EIO;
 		}
 		rxq->qp = qp;
 
@@ -1279,19 +1269,19 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 			struct rte_device *rdev = dev->device;
 
 			dpaa_dev = container_of(rdev, struct rte_dpaa_device,
-						device);
+				device);
 			dev->intr_handle = dpaa_dev->intr_handle;
 			if (rte_intr_vec_list_alloc(dev->intr_handle,
-					NULL, dpaa_push_mode_max_queue)) {
+					NULL, dpaa_push_queue_max_num())) {
 				DPAA_PMD_ERR("intr_vec alloc failed");
 				return -ENOMEM;
 			}
 			if (rte_intr_nb_efd_set(dev->intr_handle,
-					dpaa_push_mode_max_queue))
+					dpaa_push_queue_max_num()))
 				return -rte_errno;
 
 			if (rte_intr_max_intr_set(dev->intr_handle,
-					dpaa_push_mode_max_queue))
+					dpaa_push_queue_max_num()))
 				return -rte_errno;
 		}
 
@@ -1339,9 +1329,8 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_eth_eventq_attach)
 int
 dpaa_eth_eventq_attach(const struct rte_eth_dev *dev,
-		int eth_rx_queue_id,
-		u16 ch_id,
-		const struct rte_event_eth_rx_adapter_queue_conf *queue_conf)
+	int eth_rx_queue_id, u16 ch_id,
+	const struct rte_event_eth_rx_adapter_queue_conf *queue_conf)
 {
 	int ret;
 	u32 flags = 0;
@@ -1349,10 +1338,10 @@ dpaa_eth_eventq_attach(const struct rte_eth_dev *dev,
 	struct qman_fq *rxq = &dpaa_intf->rx_queues[eth_rx_queue_id];
 	struct qm_mcc_initfq opts = {0};
 
-	if (dpaa_push_mode_max_queue) {
+	if (dpaa_push_queue_max_num() > 0) {
 		DPAA_PMD_WARN("PUSH mode q and EVENTDEV are not compatible");
 		DPAA_PMD_WARN("PUSH mode already enabled for first %d queues.",
-			      dpaa_push_mode_max_queue);
+			dpaa_push_queue_max_num());
 		DPAA_PMD_WARN("To disable set DPAA_PUSH_QUEUES_NUMBER to 0");
 	}
 
@@ -2581,20 +2570,6 @@ rte_dpaa_probe(struct rte_dpaa_driver *dpaa_drv,
 			}
 		}
 
-		/* disabling the default push mode for LS1043 */
-		if (dpaa_soc_ver() == SVR_LS1043A_FAMILY)
-			dpaa_push_mode_max_queue = 0;
-
-		/* if push mode queues to be enabled. Currently we are allowing
-		 * only one queue per thread.
-		 */
-		if (getenv("DPAA_PUSH_QUEUES_NUMBER")) {
-			dpaa_push_mode_max_queue =
-					atoi(getenv("DPAA_PUSH_QUEUES_NUMBER"));
-			if (dpaa_push_mode_max_queue > DPAA_MAX_PUSH_MODE_QUEUE)
-			    dpaa_push_mode_max_queue = DPAA_MAX_PUSH_MODE_QUEUE;
-		}
-
 		is_global_init = 1;
 	}
 
-- 
2.25.1

