Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10453CCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 04:43:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79E6F427E6;
	Fri, 17 Oct 2025 06:43:28 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
 by mails.dpdk.org (Postfix) with ESMTP id 5E04C427A5
 for <dev@dpdk.org>; Fri, 17 Oct 2025 06:43:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZYjwlunVwHm+8xhXYyBGkf3AAO9BxxqfT0mbRYKHzHtnnMaRwr1jA/m16VAA+1JF5jPOntc2g/d06RDeDieZsE+OecniotuN7ceq71iBhQijgF3/HZ3c4CgU+g4CD8CceR/641do4Rf3fYNyCXTOFH3jNzOKKFLMJFjHxGpp1EnHFOUBud+NCDfG6dwe0dzwNphsqh/MhTu2daXOCJ6jPSD/vl2oHj+kJKf04kw8XkvoTmmK8rQCZAX71A3xVcmUWnYbXY0v3Tn2RjDTstEGQuybjzNcMobUkA3tfsSFZVMai9UbprIlgfPy1xiAgeo/Ta335Xx4Zh/W9XrnmKRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7D4dEr11fdoH4LbXnGYrm/tNbu2v79hHX3b1rf/jVOM=;
 b=girvi0L4YJaE7hAZeJ0fpQFF1ulNNUq8cun388hE6GYEWJLr7RANhnQyV+DhCsaoEKN5Y/lDQ4R+rIGSTLX0S98i2eNLVUx0KLQEoT7tj0xJJUFyVn6qtn3dAKV/fCp06uNODldel8RrErq3XEcuIbR1lTVbmKwQOHFFwl8p0CK+dKEqg+Ma+JO05aDiGkyZg0XXh1K0yPVgKuVe7yoExRJYX2SzRasB9YlAtvJOhQWKobE6k1yHBnRYYobZI0Lb6k1uHR83Szx+RFpotikqwCuZWtnU7M6S9foN8KOhqeloO38NDPOTVWfavXtwD7UKfZnXDJGJzrxfTHNOUR5oTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7D4dEr11fdoH4LbXnGYrm/tNbu2v79hHX3b1rf/jVOM=;
 b=Jl01m8MJr85wEZxnnsbZWA26fWCdDlfmKiZJk1W0vW69z3XGZEGM12gCdJ5MDJbAvhLxPtBpwf4Wp9MTT12mEnI2LqUdzprTZL16AjsnaTm0LOujrqhQmKkCGdCLGUqkw9oFtB/mwFEU5pgDXkKDWyUAGyC/UvYuWB70i6IeTUCLb2YkbpTxB93/AoMJo2Uy4jHCA421Z1ikOGvLFBaOXVyMAvYGd7+pNbk6BSuwLZHAjmhEx6r4yFfsE3ddPFyNzoOO/2b359dTyB8UFezq0kZXYq3mp1oxlwOAZgVh+UgKksZUqHA0LjJUctgcNBjDkf/AOuWXt8Oh1XT8fRolHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by GVXPR04MB11655.eurprd04.prod.outlook.com (2603:10a6:150:2c2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 04:43:22 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 04:43:22 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4 5/6] bus/dpaa: Set max push RXQ number
Date: Fri, 17 Oct 2025 10:12:55 +0530
Message-Id: <20251017044256.3264737-6-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251017044256.3264737-1-g.singh@nxp.com>
References: <20251014101716.2885563-1-g.singh@nxp.com>
 <20251017044256.3264737-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|GVXPR04MB11655:EE_
X-MS-Office365-Filtering-Correlation-Id: 8baeda45-9b9a-4166-6c90-08de0d37b384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4/LeXGvJtMRz9NxWjlZPOuLPU28zF9446wmX2WCrv+qVqC1NAFnFiRiZOIvd?=
 =?us-ascii?Q?in9QGdYwfwph3z8JSzMexCA2E3r/3HkYyKQZVBcnQr4b2g9FfLgX0ekDH+1I?=
 =?us-ascii?Q?ojDlLznctOkXQrN3meVu4Bn5tMFtQdgSZCMrRu1UfOBd1FqlVGDD4Ga+E/xP?=
 =?us-ascii?Q?oTI5ERR99Ije0/TTqAQ8sA9Ar7zr12vZoxkwY6BK/2syt+zRftojUrJlwl+N?=
 =?us-ascii?Q?MPimmWuiyFvpVaMgN5xFaYpn7WLB4XB2NW1vdQHY2X6SGK7SLdVhl9a3fenC?=
 =?us-ascii?Q?DZmsI3mFXEfvBTorrtG8qqJ4D/q5q5PAgxFn+U7l/HG47KpE6fFDBLTnI/Km?=
 =?us-ascii?Q?Uamzitwul2LUILg9R2iKA+TFAWoAmN6jq43ro+v+p8LKQIK7KAMWfIfORbtr?=
 =?us-ascii?Q?qyjmiaRz8D8rlCzVQ+yuUtTBTBPSlIcW6Z9+FZ0be9nJAAs1e4dYkdoBvCf5?=
 =?us-ascii?Q?WDy75sXnxB/k8O7oSNuSyVhNK5mf8PwQFYlqFVEYhMT8kCr+NyIb8DjjgHaR?=
 =?us-ascii?Q?rxtXOCcOS/0UMA0HL/eSCKmxGSYzzwTPp4muxaAnPZhWfF4iv4s4akWFVezK?=
 =?us-ascii?Q?dZqD0ADvPnnR0YzjpEuL05qrGlPFB1MifxVsT3eQNmINeOohs55ezFwy45UV?=
 =?us-ascii?Q?CFoJLewHIXg8GtO29DK1NB5Uq/s196W+qMusjxdoB0yvGE5PTRFvGolpNgq8?=
 =?us-ascii?Q?uCbqZ4M9kyluLPEguZHDXHLL69TypUpo29Grkx6bHs8nHa/MGKaAE9hPAueg?=
 =?us-ascii?Q?iKAmlJyw7v3q3JcjVQsv5XpNaCHAallflyNkhIBs/yYEuD+S/gRySR04h5vi?=
 =?us-ascii?Q?rp5Palh0kr+5drTyADYvgVSILPKELdqSkj7ztttGSft1QTJRt8fTtPUduycv?=
 =?us-ascii?Q?14zRTCXaLCtzAasX3iV7B3l206TFrDjMSA9uv+ulIQPUayn39JdhNQKiiSwG?=
 =?us-ascii?Q?ZKMBeMqpUo6LZE1vp2EY49CJSPCmyY0u/AUlNgrvNhjzuXFKfc6JMV2b7QB1?=
 =?us-ascii?Q?qYuziMzVfrqZWRJU49inDmmCcAJmP4yLBbFDjt3FOMq7uhooPp2V0usFrMsB?=
 =?us-ascii?Q?zGQ6EmleTkQA/1dHQ4Ybvc8Ebq+rgbeTEvBOXe1eh+AYYw+LecPa+m2e3HZn?=
 =?us-ascii?Q?AYyOeq5A+35Ok6YPEi7rHg2Py7N8MPzJqQeqJMyqGoT2CYhuwnOxQGmRsM/s?=
 =?us-ascii?Q?KKLTtRGTEZv83iqXotvXltnCc9/D60kQyCyC+Fnt2xqeZwvOr8LRWa/iYD9U?=
 =?us-ascii?Q?U2RMad39xYnSUT9A7M25HtrBphsqZBbQ1b84V5Eqc+4CnqL+lqgLed71fObp?=
 =?us-ascii?Q?w+sKYMjfRmfq0eq+TeDziFRwE5i17gk76munKAGfVoOthQ/uh7B9a6Zj90Hl?=
 =?us-ascii?Q?3BzPaEKep3Q+RQNJb5OpKSVCGmxz2a2/mCN88H66Y6U3jke9X2Pal77DMnrE?=
 =?us-ascii?Q?fuRpUAxXLjlqmCksPlO9ll6Y7nkC9Cj8T/WNB5Hb2u6p7vN1faCbALnu0PJJ?=
 =?us-ascii?Q?O/bnTc3Gy2kTfvFgVgGPX8FHv5EtAmP6hHdX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bWqlCgz0EXG7tBACRh9QXKd8qi4Abdan5/ceEdGQteqQuX5EnnOvxOiNl11+?=
 =?us-ascii?Q?tuNXHxXIwLjVee1+cdb+Iv2/NumuT+69yt3iTSmM8mqQ1Qe70YRlFvNMQVcY?=
 =?us-ascii?Q?TG7+U/OMj11j5j2jhKJal0NN+RIehjmA3e6E24gZZzSbGGPGWfSgnBSuYzzR?=
 =?us-ascii?Q?co4REk7q9mWChxn2dAFSYcR+AI4Qe9ymHGgba7OWuXahKh4y5uuE4vxvcM73?=
 =?us-ascii?Q?8cEn/6GO7E2pMgVKQPe23aIm5etGq3G3L1pJRRXDX9P/ZJSPwoRU3jcWi3Cu?=
 =?us-ascii?Q?4a/43sijVxnMAbrq0Pp71kDRbtEazwOgYcmxwHeNtiqJOqVkF9ysde9WbKHA?=
 =?us-ascii?Q?qL/UNxGT+rzWQ4w0xkmsW1KfeL0NS440T8d1P7aLzeztVl8eVG9/UN17uS9t?=
 =?us-ascii?Q?1S4gzcHskBq0ZJhB2E+3X0eZXE1grGL6I5eAHbRMmpnhfXjhOr678zylFF3v?=
 =?us-ascii?Q?Svsg8skxtiTqJ5Q4i6GPmuVMfwNjQJXWRGhNReu/6cwKyjZjcQ8o2Y33VQij?=
 =?us-ascii?Q?cSpuMFzOtWBOwlleq9+ku+Vla5NlunWPdL29OzR+u3dz7HRlcDwWnoFAE+YR?=
 =?us-ascii?Q?RoGneWDZGiGaEaMNrCxvW5kNULqGMwghCxsWBgr935WBoLLJc33/Y6W2KYOi?=
 =?us-ascii?Q?TA7u5MrxTT89gi4Rwx3eVcEOE+Sk2BuZLrfwnrH2I19ux7OWlr2QJVZEfEHv?=
 =?us-ascii?Q?ZYuO8ni9T0c3w+0Rd9AOUhqED2nMwgmMACzL7alu3+UqaDKxiZMRWY2SyHu0?=
 =?us-ascii?Q?/nYxJrzlVnVVq457rCudIJ42kdCjDuKZhPBmGY4XRkMRJ7GqWWW/Sff07Ean?=
 =?us-ascii?Q?H7mR0jNmwrzX4cbxAPib9sC1vrq/o20S4IMCmmQHlHOhDXFAVJzxwj/+1mLE?=
 =?us-ascii?Q?I2Jqy+iqRziWQev8BEPXqyywupBlc7Nw5Zxm8qWVDBhdK+PIFrFDGaCI6nCW?=
 =?us-ascii?Q?zZQeaP2SkFH1mHcks/3xm5KlP1N5KBLRMaQo0pXFqwefen2tCVEeIMQ4pCAw?=
 =?us-ascii?Q?/BqIFJ4BuKU2C7+xOH3gfK8sJ8oWMUeww+YxwO8XVGtuukFub2Voh85POYWy?=
 =?us-ascii?Q?P2Z9hWevEcsI6dnYfO5p/iEpaDz87e/8UwY9LWdvizd5REgsEp9MzVUwYBHh?=
 =?us-ascii?Q?YCWTeJBBagkVVqpVNGC4MXLr+dbBrKm8kmty2GXqlnxQuFbhqDjnBYv0irUI?=
 =?us-ascii?Q?r6P5LSpR429tyjjmajML5bhJetVuyw1Udjosy3e8ffByk+BmuSQvQzO0fV9U?=
 =?us-ascii?Q?CBRMLrn4yKHKpmKxoSaFWjsxj1ESHnjqK76EQJi1jWEcmeVGKlPCFqb65r5+?=
 =?us-ascii?Q?tVmkk+/0DlJ9YVs2/ki/IuwFrPREICieaPwlYMVp8m5lxTcXO1G+GgQytUlS?=
 =?us-ascii?Q?1iVgp70OSrcigW4YbZ1oL+bJnSvuuXPNuVJtJJB0n1dLM26jkfPCt7uMU/dl?=
 =?us-ascii?Q?GuEVU2FJAYDdPzKyY4LeX0PaK1i/6tJCHXL/TkfXfitcm59tN03R94mGvzQK?=
 =?us-ascii?Q?8BYR5hf3Xf2i4we30Rl/dr+l7CmSLwA9zhuE4mLCFmRsNwCFaJ24N3T0Darl?=
 =?us-ascii?Q?ZMoZjfvbluK3uKFeQT0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8baeda45-9b9a-4166-6c90-08de0d37b384
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 04:43:22.2699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmeWo696RUwyaMvg0IrjU4mevnRVepxkvEHq02ZBjWv+FOEmEZyUISKBZfFkHo8e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11655
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

