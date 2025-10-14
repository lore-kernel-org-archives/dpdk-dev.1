Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E58CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 10:18:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18DF440673;
	Tue, 14 Oct 2025 12:17:45 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
 by mails.dpdk.org (Postfix) with ESMTP id E4E344067C
 for <dev@dpdk.org>; Tue, 14 Oct 2025 12:17:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7Fc3GRy9a1h/QneE2F+uw9w+mljum/jueq1UlBZsLypUKOdHSkFjcvU+7cLNjJdr67Dw17CFiTDH0qPgo0mWbPhoQ956zJ6w4VimsJaiPzR3Aq4ZJCVwhK/dMQNhafZTKWKmGaXKbCq6/4KwyHqIPRxQxxSwae/LP3PGUUKkqiGTkrGVZsSjD+OzY6yzXFoxkdhQR/cnDKjCeDlmTPxx+QyWQ6zNEMthJX/XObxy3bmuDBlE/CALBDCoK0Kper5TpP1MMMSIH2lLQayP+uHzyPXuLItFY08N+TBcYTmftrqnTu7UrMEj8MoV07EHKskG8VKW9fwPSONj2BpDOPBMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7D4dEr11fdoH4LbXnGYrm/tNbu2v79hHX3b1rf/jVOM=;
 b=j6elrn08CA0peTwRX/yOTTsUUrmTdqDUt2uPDWm4txj5XZWxJe9r0zLKVtdzUmdBvMunH/URHYFRnjM80nKHHtCdr0DOqQ5sng8u1OyTQH0N1317iYuLyz+wHpUIk6Mz8RrMwz8zh0iwsDfkXnAU3ZCB/iPgCT+mYb8lDEsLPKvP7vkjSkVaCuw51giKqTAM9z4OTS0ER4B4buwGRSIomsuhUHpLH3dyQrj3QaSkRvQ2yg+qLehwiY5xyex4QD346rEflEImS7ZAdVaer+KGBhugvsQWWn2v0ICx8tvBaoKEPY4j8MqMC50FKaw4NngaITj3e44sJpMlS9l06nzwAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7D4dEr11fdoH4LbXnGYrm/tNbu2v79hHX3b1rf/jVOM=;
 b=R0uwJzCr9VgAXj6euHd/p+zUUgtaEYxlcKUyYsjw+Ks8+57pIypiDrwG/KnmtimPBYFRq4rSmAsW084AGsHRt1SNe2vhyKoJVlxhkhV9Zps7RYWRnlFC3Nbij0RtSjfweX7kLpNCbjtqOKykYf2zQp1FVZduGssiv5Igu7HA48GPQn3+eq/cWFhFdQmjXvPIE+L1cMeJlZ5jmgAg1Pek7LY+6hz/CpvCIkk0V/0EC5QPru0r99wCxZRb/ABajBek1+RsLD7vazBMur+RjRN5ShKaJbQKcSHVtT3e0z1Oe4SjdkbOJ8CtCb/42In106cbUnaFrsOEeGlRBt/BUoVMDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by VI0PR04MB11746.eurprd04.prod.outlook.com (2603:10a6:800:2ec::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 10:17:42 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 10:17:41 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v3 4/5] bus/dpaa: Set max push RXQ number
Date: Tue, 14 Oct 2025 15:47:15 +0530
Message-Id: <20251014101716.2885563-5-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251014101716.2885563-1-g.singh@nxp.com>
References: <20251008043519.2461707-1-g.singh@nxp.com>
 <20251014101716.2885563-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|VI0PR04MB11746:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab78527-7130-4479-ac5d-08de0b0ae888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ni9/r+eZanXrhG/6qj0AHT0Ly1/ev/WfvA/6n2ZxJ+HErSV+y23+tmaB92Jz?=
 =?us-ascii?Q?8KDUuEArB89b+xy3VQRBgW1yuw5/MHVNccCsKj265N77Wmm+ihaF30x8KA29?=
 =?us-ascii?Q?FhNqp8lP5vUgD5fAYZH/CtFRZZRp1MeVqpVTLEZ2xmytegXOQbczEQk64Ok6?=
 =?us-ascii?Q?pDlzfXhaSnNMwLlZRvEGSv4lAylDmQi7v1Zo2Yx06RRLq5Okd8JfLxSxK9R/?=
 =?us-ascii?Q?iL9tTbJGkuBm10VK23JXa7hPE7C2ruNCkRw8WcEbMsG9dbDW9cqrl+/wKPD1?=
 =?us-ascii?Q?c/eF0mtbosn1z8M3epvOBSmpaaSWi2m8yLfeVrjs/3xDO+vvjr1dJrn+85CO?=
 =?us-ascii?Q?q08EhCzD9N38vcvxDWeABzdi1zVQLEjP0UdaelhybnU4watV7NSulG7lDa0J?=
 =?us-ascii?Q?tfEhh1PnwT24hoLoHbfEzlpXZxFuuFyS11sYuVq7Qv0p4YgNOCjM2aDwod3E?=
 =?us-ascii?Q?hekbNzRZCXPcErvArKu05ImrJIf9i7BO+mTmlcwe5F1IWXr3uNt97lmcIpun?=
 =?us-ascii?Q?Llh/Q2N2O5113mv/0qTMd/eutCvGIKKfoe4mAVddTeMqf/nTP5j6z2XuzmYg?=
 =?us-ascii?Q?c7TCIqEx9o3FS+AjuJ7Z/qIMqcD3bS/qizUwanl/tiKRsnUXasj9mLnDfdC1?=
 =?us-ascii?Q?Gaa9v/Mp7nMSfuyEvENZZPEJ/Y3jTI3yj/7LyLgmJjAhjbdaBKasXXtoqKjq?=
 =?us-ascii?Q?Lufep0YrIFA3Y73S18dAA8i3cVd5elPJTMZEtuETh/u42yLoh1HXPE9c6s47?=
 =?us-ascii?Q?K50V901sA7cBIuBHNSA9Xh6usNKpeHNbkrjhrGnYOWP1pobxLE+ngkRO4Thk?=
 =?us-ascii?Q?zYnGlj99Qvu0jss6Yij0rqmknBUy7+u6Jcizy77okjEkgBnggclsVSZf/LZp?=
 =?us-ascii?Q?A7zONOS7MMHDlRdEk8ZhgfPImSccCuqatqhm5aHS6Jf+uPiNsl5FGLYcg4O1?=
 =?us-ascii?Q?+fXUPrniwT3XTo0xJPgwjMIWm677KXv8ok4/jms7YDFvsYrsKgALpGC1ny79?=
 =?us-ascii?Q?RXhnFefoBAX8FLmrEawPJlqfSQwERRbhTG6m5Bc+UVn2F5eosbZhboGdA5hB?=
 =?us-ascii?Q?wh4+zh/bz9PjN4X3aL1b95OPeqeCPYJsWp3yC0Uq5rQqJCIu4KnQ7NawEB1F?=
 =?us-ascii?Q?5zAwhS1nXYBRmRmwaJQ33yrU7tOGvfSG+qoXbnREHcVcF948yETCJ1XvMsKO?=
 =?us-ascii?Q?caftIAfP+JGyRLKZy26NxV9bwXMyuPcWQqMLpivs6eDqoo3nU3F7SLUMTPHJ?=
 =?us-ascii?Q?41soUbmSHGKrsX4W7r60Ve2+qroKr1M5z2RYGk+ehPmcr21e7BQYI07m00vi?=
 =?us-ascii?Q?vUmNof01trOCC5aSEOwFIew7x/vP424O87aooHxvkp+UTSGAS6VRBpc8s+DY?=
 =?us-ascii?Q?hPvG/6u1O1Gqgk5S51Oh+HY3BeIsJMZBJlsMxXsXVvopcGZf2VIriUryUnCo?=
 =?us-ascii?Q?7/I8qM8H7cdWVpaD8wONpmSyug6V7Kpa6/bpJXbxUK3xHtbnTWnjf4F81aYF?=
 =?us-ascii?Q?MuHydZPt2bNp3fbBezGNvDhgM637//4gSJCs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NjpR7Nr22NoYdIuN0HC24EpION6wYqY8SNeUwJ0jvi5B8Pyndo6ziLwNQKuc?=
 =?us-ascii?Q?zkA8ruY7C1AY8OyJagvzVYecT779yqf0Ej5xDIV4nRqgL5InkAXCqHuQT8JB?=
 =?us-ascii?Q?HET7i0O43lI6yaZcOfub/WCRyxCM+tgzzx8ePmSz6Vu0N4I/K6UuCwl4hBed?=
 =?us-ascii?Q?dhFS2rkdAbdXTopFP2c8825r/cU6pVeoJm9ajGSJRt4EfbM4ZAwyyF4U1ei1?=
 =?us-ascii?Q?m/8Ddbd5XNdQembEUCH2gnzoUaS1/tL+zE0QpPai5JwGtLW283/EvzVuCpIk?=
 =?us-ascii?Q?HyaIyD7BXJuqnts5kILEnIgsuOcuZWyX7//EwCNhTr7Y8FV7QZYDN+l8G8Hw?=
 =?us-ascii?Q?pbo5vFr4RBiLjvwbfOz81QYMg/PO86rKaz5lDOIg32ERFeT3rBAtUnW58a38?=
 =?us-ascii?Q?tAiaREXvs+zgxrBrnoWt9qgxuTQ57KjH612ruZW3esOovoWqs/dLuz0Z9zov?=
 =?us-ascii?Q?dmTl7jvaAem7Qcez6GPW1hFQy7Ld+yPxicG5k8JCMpmer0doreNAs/Q4EsIT?=
 =?us-ascii?Q?8yzcY6UW7F/dsWGwFvTI9rxCREFmFjYcewHp9XvYiXX6d58k42GKR8Rzw2m3?=
 =?us-ascii?Q?g4YBDeoEUFLVszHQ+6zj6dH/nzjIk/Ddoktd9ferqLXUqkeoEP8z1diZt45R?=
 =?us-ascii?Q?ereDvSm/F2g4WX9oWDJJTzldQHM5ytS74Fe+Q0+I7y9EJMTqWta8evJ72vwi?=
 =?us-ascii?Q?QBvWguNCu+RK1RVUG4CkToDy5bmPB5kDwrgSHscuTSb2asVbc7dFUGOdDpfq?=
 =?us-ascii?Q?YTETg4GhwkAz1bHB9hbGKaAbcU4pec6uN+21pJXxmgG0hOWIpJRjeuJd8c8r?=
 =?us-ascii?Q?M4SnykRCE5zGxtpUYg1qlgnBkO3yX2uV+cR+sp5GmHsJXJEeCgfezpf+7dsu?=
 =?us-ascii?Q?X39S9PaLamk71AbQIv8wIB/Ju9SaK1gldTLDsnCqGEaG7QBmZJ8j1K9HEXYT?=
 =?us-ascii?Q?IBroPxyqRzwqiIZHq+kOicsVLJayc0EWnWUNyoX0YikMh11c1Fj8CBFQZkXJ?=
 =?us-ascii?Q?1SwRQtr+bBoU+RJVbmQS+6WR8LOH8N+dch8FBf6YlVH2nnawATWiuh418hVN?=
 =?us-ascii?Q?O5qKHBS6S3A2TT8FSLdSjUUxRfHCDBpoO/eJ3dpOw4d7V7Gc417Ap5jSdOQQ?=
 =?us-ascii?Q?vqJbYLh2HPKk/JszL6guBX9OdedVRC63TOoR/Do1I+9jRBBSbsuVQsS6elRa?=
 =?us-ascii?Q?ttFS02m+IC1ZUuqgFYbN99P6jHL6rCnY1WN3OxTh5nmbVLNOCgG06rBSHxmb?=
 =?us-ascii?Q?SDjokFfiS9I6bFmHega80tmiUoxstzfyz8OUL05hh2vF6diTrkwFBP6rLZTj?=
 =?us-ascii?Q?AIqSU1MWvx57GqXE2DfaOwLCKXGuiBU96czI/OhvfG9M9x7uIV4nwGo4nRN9?=
 =?us-ascii?Q?ekApgpyu6OSk/tKMfSmiSSLgXTRZXa8A16YEKahqR2POvHkFu8MaoKGJocTU?=
 =?us-ascii?Q?e+i43gq5rJewQzHLJRTXJVkwCZfNdbNrc5wvhOhRF7rga+OKmXTsZo4et1tw?=
 =?us-ascii?Q?zdDJjG0XFI2MtNV6hr2ICvAen3QUOCF55zXXnf4l4SA59K3l3dy42ULmEP1d?=
 =?us-ascii?Q?ACCjEzeOh6QJ4AOarTU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab78527-7130-4479-ac5d-08de0b0ae888
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 10:17:41.5417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fy7ZQvldzDDDmaZEMe6LbVR7vPfPT2WGnB1j0O+0XLUYU5MtAcz2v1bUiF/RVcNh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11746
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

