Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7ACCCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 04:36:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AEE640667;
	Wed,  8 Oct 2025 06:35:46 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013065.outbound.protection.outlook.com [40.107.159.65])
 by mails.dpdk.org (Postfix) with ESMTP id 6DCF24065C
 for <dev@dpdk.org>; Wed,  8 Oct 2025 06:35:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iThgURF8rpwJm/wRPSB+elnTko176w8dLlLcZxZuNakwOnm+kckVEm4x/ga8sXakrTiAKypRNAthbrAVOT9Oxh9Ead3+gr75KuO2uBeAYvQUPwBb3xus9iyR8ZsskJe4onhfrFB/pA+N4b3YcASBvBBIcoSbtYPaj9BmnPKqqvA/wokzBQVFEQ7IGfGSmbBO5wBh8Qj3xtmDfXgq8k/5589t0FS7KGRUCABmlS20kl7vn/Cii343tdk8aQR1KSRE/doCj1U1Y/1W1oiTMGfXyetOTkPfr9CPgmX41JrgiAFmiJm7UH72bWU01zJoJ6sYXAphYAIoU5iOHWSd3uBLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7D4dEr11fdoH4LbXnGYrm/tNbu2v79hHX3b1rf/jVOM=;
 b=RMXyIdHUi67kiekBDokVjYSnNsAH3HWGGKP+PiKqHSTbKd1ONu2ScohTLv7pd5K2l0Ou5oU0qCF7YBHeMO+trD03hbWPhg3MvVQDGUlvjNaHpvjzDGIfL5YOdVwf4k+CVTey2j/xf09gwsvS65Wteyv4r9JfTiJYIRn7jkmKvLksOviW7XiENWA09GQTs5YgPekJ6qVUH2Y6WBH9/WKGkzPnMTmKjMaaqOOEsehBeyZIkiUF6Em39Y446FYD9buGk0iio4npD3kG0uOGYE77/IrX73itY9KdFvoDIcEePJ6A5ZfJQUtTxeca+15CHheLg+YLMTBYwa+gM4HqzzfvXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7D4dEr11fdoH4LbXnGYrm/tNbu2v79hHX3b1rf/jVOM=;
 b=JAlluwPIIw2pobCHEdWnVmufurK/UnCQf6Fbxem5gukNqg6BY7jXo3kUyIioDpsRcguWPndMAijrcoEdmiBn3RI2iG7JLO4ukvGY6AW0XQyQu42EqejSna/sosWo0ry9RikT3dM7xyGWZcblf8gULygmduPw0KYsJjbKretBscmXfCLaro+54qsGer/BdTv1FFWtBzcQ7DwUp7nyZ67BF4hs/XRLdTzts8gbeCJ6cqHf05gKP1KFhXg1ODZo+vksQpsjR1SHeYKWDAUHnBSLjspVYFjw93cRllJIGvzHH7VPZ+vmPAwS4nMeY61u+Jw/szdxyEa/KBvbA7F3oHohVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS8PR04MB8150.eurprd04.prod.outlook.com (2603:10a6:20b:3f0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 04:35:43 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 04:35:43 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v2 4/5] bus/dpaa: Set max push RXQ number
Date: Wed,  8 Oct 2025 10:05:18 +0530
Message-Id: <20251008043519.2461707-5-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251008043519.2461707-1-g.singh@nxp.com>
References: <20251007050012.2432449-1-g.singh@nxp.com>
 <20251008043519.2461707-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AS8PR04MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c82cefa-95f8-4011-f5e7-08de06242456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EdxpFFAnk15wc5QxmTdJEngSXFC4Odhak+FsKJqFhLdyc4inqbDuj9M0ni0M?=
 =?us-ascii?Q?ZzyBHTAOgtcPjpxoKz8AEcGB1Chl/rk2X+7l/lqlry2CSrYH0MmuQeu4UVDE?=
 =?us-ascii?Q?FkjpwJlRYYbEOBZhGl7AzbFxGXQVXMvmGxUWODUPyzaniKWWv/0VUMLuPnuZ?=
 =?us-ascii?Q?4NEI7vzR2FzAYZuN5qAgErLaO0bth+3l/qNlewguFRXOr5vvUF6ot/KdA+gf?=
 =?us-ascii?Q?ghe5xKJqjj4HpnD4prNPSl8/DreSNjUm7lZnA4ETlJE03lewZByXZyfZwXv8?=
 =?us-ascii?Q?B2jFPtiOQyg3DAJNbaus/pnbFRjhd4gbi2uPN4ESKT9iNkVvnT9V7q07g+Ts?=
 =?us-ascii?Q?otdMVLeo/7DGqCnKOffNgM23Sv5HqORqMtnX/vcb9HYNd3WzPTEUk2d1Bs0w?=
 =?us-ascii?Q?zyz8eebno4LlV+LmCaAXoRgELZgx3hBX2H/Z1Ynl7Yd5JYw57Id4nGb8T9Gw?=
 =?us-ascii?Q?vkrwV9o8MYIS3j1vbNzdC+Nq+cuKjVyeOJY5fZi0Zos0G5lZrVQfdCjlnluV?=
 =?us-ascii?Q?hjEorzi3tLxnrRclg0zXMRRG0Nh7cXNMVAOtT1ql8JUJR9HrYtrywhZLP7bh?=
 =?us-ascii?Q?fziWrP7wKRHSvHYNfkHzbXMR7SCCfDei3SeHXYw/TE+Ag9UYZgjvSupDMIFk?=
 =?us-ascii?Q?HKm+60gZlG7AEOaq1VtvpXDcnd2HwZzZjrgDEbK0Da/E00V5JwQe6h+VAO/K?=
 =?us-ascii?Q?Q3mqcy4ckA/k8i92dG248Z4bz3xB9U1uCaa3EOOY0T0k6oiYl63KlWhDVGKk?=
 =?us-ascii?Q?+kqQGrvwYJOw9D6V1qj/sOBkprIr+/TSRoqI+9nBjOaHG8b6IS+DGUw8N3lL?=
 =?us-ascii?Q?+LECAVmug8xoNrW6ESfdQg4XvoeV23gC1ObMWtXbZ4LXaaGTTAdCjACCITiG?=
 =?us-ascii?Q?H/MUY89n2sX8wnfKQ2GOpuPsjH6PvDs1EKvIElzOFLHvjYsil0KHZT9UBUEv?=
 =?us-ascii?Q?I6pbsl6AWbPeVc5LVCM4OOVDNDshT+ggp71St2bC+U7TIPs8ZnVGUBC24HNH?=
 =?us-ascii?Q?EGU3IT/PMyuX8zccnuTzGEJ1GzL/rPGgA2aYUlqD4t3+wrQx0rmkrr8r5TDx?=
 =?us-ascii?Q?bP5b7VVZlD8oj1JH/TOAifUI/pu1dn9lEN1HYvFExUd9FoO3JN6gYMPoV88l?=
 =?us-ascii?Q?K0BRlqSIzRwUfH4srn8v+nEz0NIboSpsqsrjoJy2K4rcJJ98hN48z9gkt1/q?=
 =?us-ascii?Q?H0eyDlouMpIUmPnmffansC7E0b2hC5YTsu8Hdos+Xtfh6Ht+1TSs0X17pXgm?=
 =?us-ascii?Q?lsEYGNuAqUuW3pCMAqgQDbMHSQApjuSMWrmpcVP0vIPMLYTodQnxVbE9yfVV?=
 =?us-ascii?Q?T8pWKtBnOpH/LTYe16qshi8ZC/j4g8SlaFJ73yLMsNYb4Wz86VlNfmDzaJg1?=
 =?us-ascii?Q?dHpMHGw/i1HMq4+0MiFJxAbSry7/E7VRfITHrwDgsApf6BaJVXj5CUXCAdgn?=
 =?us-ascii?Q?g8n9NkQgkQeeXwUQLf682/CWK6vumox6zH2crvEwnSioFO3XwPC8p7O4iuLK?=
 =?us-ascii?Q?8S68TkxqqYjTcwUoA39V6DI8f+x/bJd9NMXC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eCiTIZF7Xe2fbb498aoo/95NuENKbwHG8Nqy0li3sB9ym7BNNgC3GWA7zuiq?=
 =?us-ascii?Q?xKcGUfpboPVnofJD7lTZt6PXiGs5ImpWkGJw7drjj5JezlUiJ13swUtpj7tO?=
 =?us-ascii?Q?ccP6Flgo2guWIvCu0ejbzNtbVch1Chej3k7UMEH6GHatJyqtPtA11LtKWcn8?=
 =?us-ascii?Q?LLprZRlkcWk15VMMlpSqlKjZDFoTYP9gYwnfNgw5zdjeUuTTH2l2ERAdSjSO?=
 =?us-ascii?Q?GZde5RRmQ0SOsRdytoJSv6ftnXLK5/F5VgDdH0j9tNZhkmhT+MJx+WhftUGF?=
 =?us-ascii?Q?esZxzRbYLFH0oE3EasWzLVIyGgGaCBNLgKd5ctNi6Ox6c983w+F9UaMxSajJ?=
 =?us-ascii?Q?nL0fNXWGPt9Snqosiqf8LIyOgQASQKmHucmTggA+rPHoLmUVM95utw4atokY?=
 =?us-ascii?Q?LEMlBnzCn8SrWI65T54qGDgsHJFHtFIxb5lA4/HrefNSORavAMnhO4/3hp+E?=
 =?us-ascii?Q?rQkz8jO7Wb/H3NUT5Yuo/Q9MYaFpJ4b7rrHOhkvbM4nlGQ7OvPs/YegX+Qd+?=
 =?us-ascii?Q?ub5uqhO2NE28qXBEnf8jRh3/31ninDh3SYUDq+wXgu5qNPP03mam2XIW2DKz?=
 =?us-ascii?Q?AmKG0ZAI7zCu4nLzYZmysjgemBJPhD2DWB3/BBFOkIwDnzHjdftdIUkPxg2O?=
 =?us-ascii?Q?fPgkk1k1/Xq6pR/W03B7+PoVAO6lKYryo3khmZwi7/JoZOjJplj+xdepVN0I?=
 =?us-ascii?Q?UfedKCDPj2u7H+4/SQXKO+ugpv6ru5TwvOr+BHsBJAQ2YPb7rV2J3pDyvv9t?=
 =?us-ascii?Q?gF2+KjvL3VRe59tmMnAUze0x9KjWZZn6W7ZnoFREamaZGHJhyWUoXR0JuRO3?=
 =?us-ascii?Q?lbcLJN5mCsB9F07QdQVANcJ8PsLALBrzKakvVR4qp0NBYGBKRG/W/aTGpMVz?=
 =?us-ascii?Q?bU+ciSuYnpuPI630tzd4bzBLfyOnfOyTfZ6jEi2Nb/bG/tHKTFDHZ03DqHrK?=
 =?us-ascii?Q?cWEP6zazhfw5vLKzVJiGKz7MQeOulryuSasXlyvAvDYOwR9yL3prtKdpHpqI?=
 =?us-ascii?Q?dTdeSzzl+kr5nfJmB05pzb7PGgMDtcoe1KP9m/7F+/Pj2jMH8w3wQHuNyHGL?=
 =?us-ascii?Q?Ri/j1UpSZKlKBRT3y9sTWaI4UI8W5htqlFM+p4ggMmPPN6OrS8YHLclcB0xN?=
 =?us-ascii?Q?ADeayEhMIdiq5YARv+/9FrICEZAYRsGE/iwQHv3MCTXaKN+hYmhwcxP85FDl?=
 =?us-ascii?Q?iWPpaKP0VlNTGVTHfctSdrp+fFIeo7EJgUZP32zh2XvY6fo4y66lziIYukTC?=
 =?us-ascii?Q?N/mwao9tIucqh/zKetstd8hhc7VNrv9iTffR9vlLaz/uzIasNbsq+jqph+gC?=
 =?us-ascii?Q?Jzfs2o/sOXrmVzFv0vZS1vsqZlxLhg4Jd6HsYmGRKt0OMhPyabDlHvuFMSOw?=
 =?us-ascii?Q?JtLmMrri5T0TJ7YTY7vTKTEGmrgSFfrEkOJPOFjOnQrPOG2HyWahiP1xq7PE?=
 =?us-ascii?Q?WIhLR55U3ILdBnHjouBATvawASbJZC60/PiS0SEkUSIQiwsDcMXJD3f6g46P?=
 =?us-ascii?Q?itryFIUWlMhg9NAZ9Q5N98lmip/kAkaP8eVNqHDh90euGrzMqJPdkNGZ+0sl?=
 =?us-ascii?Q?vZwmLDqCDd5bakqFqXdKqIgop6nw1n2iAk+EOyWM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c82cefa-95f8-4011-f5e7-08de06242456
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 04:35:43.4561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdL3OrFtgrq+fyVEcodVitEk9pLA/vj5irlxvNq/edTmpLgB+GpKeglUYLK8irP6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8150
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

