Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E00CD4F2F
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 05:30:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BC8940E12;
	Thu, 13 Nov 2025 06:30:04 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
 by mails.dpdk.org (Postfix) with ESMTP id A0E1440E2D
 for <dev@dpdk.org>; Thu, 13 Nov 2025 06:30:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5h2HnHwQt22n/VV5ZP4/9dHoxZHG4HScWLItfcjnmFR0XGAYnu1QuGgMnmuFIuAQUkIZ8ZfplnB0cRsdNyvbuOw4it2kvnP5IZ8R7NIKXbYNRv5G2pBHaBHqgMTuAltiyNFWMs+nWFnmkwLgIxov3JGa0Y+0oJlZC3ZXjhFB6QDGItGuIYg4yfTWKf45IatgfOhuEp7UUmVUYMamUIgwNG2F4dVCJXA2N31WCMMMgf+diokBnXZhZ+rJSYNIT1ppGN7MI8bGV5D8sCsGorukf8Lk3NixqYydZ9SDYDnJxqbm3dwfL+G20AdMItibW2R39r/2jf2sNwl6hBemcdWwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGMU9nEhwBkXcMCHRjAQtytcLAEmYBoomPQXNLQ+J10=;
 b=ippziHfg8f7LqXODM2ijjnoE+w+WEBs9K+sLdumFfCDMU2mz/+oRpoLEXq441BVGpevHLqcupaUPYp/XDL3fjNdOsj8BQjX2C0WtWPb4Z434okoMoxCCLjsj/G74uhJ1/i20m0okJ0I5n8PU33jx2nNC9sM+RICtFg8xVFomNywzSd66S+A3QoZXp+b/vS1+k++Nzm1e964vkk6bK6YdKNFNA/drLBTNYtMPWKekQWUMCT3uvP/uH9pr5f7Fo+Tts7zU96ONb+HsrK9H9YcAIOKXlEyFkpA2iH8Dim2jiFqMuG95aEP1IN1angVRjCr/j5t1reXAHDmG1ykRT0160w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGMU9nEhwBkXcMCHRjAQtytcLAEmYBoomPQXNLQ+J10=;
 b=KmFX9Hs83FwXnkKs09sr4c8hMNjnt6JnNwjHZBtyGpRF5VK9q1EC9OP7mBEZIx0mnh+hxB1H4PsV2Bo0Bmag5pQ1lToyijxqBHE1DYxi4dHizbc8SJaL4minvRdEWH0Ae629IyajaAEtd/IHpFud64SSXZESNUvzhpyHm1dkl50A88rmaxoH4Z3zLgEOvsv1S+FFxTSegZYzsqpBDRU0fIm9dkpx0cYnLoEeDo0Ny/442qUmRSYn+K/r2pkdN1txRzkQR6yri6mdjT31pMDK/+8Nc9qBKU7L/mxyQFSdzR7s0YV+W7RlvOrOdshKNoO5Uaj3ZZ/QU6RiRRHhMXer1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by PR3PR04MB7355.eurprd04.prod.outlook.com (2603:10a6:102:8f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 05:30:00 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 05:30:00 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org, stephen@networkplumber.org, david.marchand@redhat.com,
 maxime@leroys.fr
Subject: [PATCH v2 4/5] net/dpaa2: bifurcate close into close and deinit
Date: Thu, 13 Nov 2025 10:59:30 +0530
Message-Id: <20251113052931.1784953-4-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251113052931.1784953-1-hemant.agrawal@nxp.com>
References: <20251106163807.201451-1-hemant.agrawal@nxp.com>
 <20251113052931.1784953-1-hemant.agrawal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|PR3PR04MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: 976d6469-2b4f-45ae-64db-08de2275b0c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EhO8tu83dbrL9d38NP5xwzmLTZN/9Kju5rxhuz2nNOGw4jSyQmOr4Ocf4rAJ?=
 =?us-ascii?Q?NRvb7j8ko+7S1B/NfHJ0Mcsxg47xFNHsficr1EEe8diBaOOAtlLzTxlU6Szr?=
 =?us-ascii?Q?jsX2Dz3z/e8QIAfJn3SZgZ8vQiJTtPYk0SBWbsCI0mKbDfAI96PHVgbPtmhA?=
 =?us-ascii?Q?KBBWDj93JGa5HUDebp6WbWhmPyj/QNK2p6hFv2xW8czB3eqiynMf/L4GCtLk?=
 =?us-ascii?Q?iy9sshmrfcjST3XWop5G/v4vX5kLFxr6QCcTHwIqM4xF24xeFlPUJ5KzK8ye?=
 =?us-ascii?Q?Xsjqw1wLLoTMnbyIRJst71dxz4eLvPOBJ3ThgPrfb3SQPZxFHsYTw+o9urn4?=
 =?us-ascii?Q?6qoYqzAhxFJ6unq6ftqjmcI9vCLAG1ld38oL2q7ackFbRAXbIa3i+WMcu73t?=
 =?us-ascii?Q?D8YX+Feyo+EErgy3IgYkAdqlSjezSKnqB3tVB5ecbd/InXtB5XCDSgvL0Zh9?=
 =?us-ascii?Q?fCEdCTyHCJ8ZADn8h6jU801mQBTNrhWDgRMTsd4xZ9t3rBuuTeq/nGgm1rKJ?=
 =?us-ascii?Q?Ruf93z/NsL+cI+ZGI4laGIc8r8E3ch5qSKEK+QkA+FJoZ121CBmu3AsBDIXG?=
 =?us-ascii?Q?m+XHPcLqn8G2HaX32VnaDR6q6Gj1JXWictSGt4GtJZ1m6JSVAjRl0E56GEp1?=
 =?us-ascii?Q?QoPMEa44u8XFAmVCCFQuDHOrp/Etwq4Cxuz2AsQZ4vbc+zmOyoyNCHkkdJCR?=
 =?us-ascii?Q?ZcfkbqZE9jEAjAvWdawNpAoqwW1nvpg3j5Bff+pj+vPSdhEGmfT8hyMcE6F/?=
 =?us-ascii?Q?g1sfEpAd+R3btpB4PsFKfA90AwdxXN22PFcac7UOoMmg8IPTcij7p5Gf+uck?=
 =?us-ascii?Q?i7uEGuE0MUu/yGCOY0j4lB9sDlWPmj6JJI6M8aSjIXlXpPny0Xy9XwqUS68l?=
 =?us-ascii?Q?uEIHfHDEOdQso7FAU+KtoAea8Tee00EHBI058vc+eGwQFhDnJQNAQ6+ZJMe3?=
 =?us-ascii?Q?hmlIlhskES+lLRw+OhxVM1uEfr7l8yeeEqhddnhnVaqBibHdux3RGJnwD/9O?=
 =?us-ascii?Q?kbGxTduR02OtYEvc3TeI25PS/r0WdXaUYDeMUUkMu7heiyyGoBb8bANUPsv2?=
 =?us-ascii?Q?/1jEcGNlluQ2ld7jAfPg20bzQ2vzF+D+ajioheEITsiGaodpUAcs4LAtKoO3?=
 =?us-ascii?Q?5sdTGJepzzg6Pn5MEu6v1/yHgG08QgzU7AaxJQD3AToh/euq22aOZrMSxr4/?=
 =?us-ascii?Q?G0POelqXZ4gU3tp15VzQxhZ+jtfaPBxwul4A15gJ4fyvVqQMvfB0iAwYCIwr?=
 =?us-ascii?Q?RbKqcaA0la4pgtvbuOBC9Yq1kkcrPKv01vQ/M1YJQIC+8u0NX6ScOHe62uxm?=
 =?us-ascii?Q?TSml05bjoZtK31DqhcLKetwXJxNODY0cuwTZ4m75YxhYZupZx/T0RFKHa8n1?=
 =?us-ascii?Q?aBS0Cwy7Qa+3KdfohAIegHQpwZBBA4vZwxOn8vt1AzICNTGPIY2pIOowGzmz?=
 =?us-ascii?Q?QwfbpUV7rwWeOX7BWIr46AF5NAP0ht+dKJMtevnE+s9rfFL+55DFwTNsNJag?=
 =?us-ascii?Q?Pyn7E5nDHTPOTkE2gumu3B0tJNxscCgCP7ih?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RxOFsyEOVwB9AYRdvpaD2epcvB2ddznUyvlWVVyKPliUkFDPiMNKOz+8bxqv?=
 =?us-ascii?Q?GPRbXeoMz3xJSDeSmbCjQqQMO2S7L2a1jXUq3Vkx9ttF896KfFKHhTQBcP7J?=
 =?us-ascii?Q?QQ9OAyEJYqVMJFZHrFQXeOgUGVkIPWjnO5i+jCfcppSD+j2QuzT7ZoMBjfs9?=
 =?us-ascii?Q?CMg49m9QCiMRmsMC0jV3JvdrudwcoAaqvV8CNqMKiD6yCaYzKx7cvqgo9+pt?=
 =?us-ascii?Q?47FalOeSWyyPuPHB/zG4lJxvu3DvargTYMhPg9Xktc/s/5aFyhT5Xy5qENML?=
 =?us-ascii?Q?SLNQwKG+ClHSCxkEvs9LavTLDWPJL/Y7ZaSRwLmxFliK21z14wudtLHvnIMb?=
 =?us-ascii?Q?hL/OYiKpEvyC5t1hHEpfZ36uGcfRx9dC27Jp1+2V0jh0GvE5f0Qazv5hq3wt?=
 =?us-ascii?Q?8Xu9d8R9pm2BIFzXwCkrYtXATeVOg1J5RuoRuxrQQLb0rtcDHLMz9d+5jU+Z?=
 =?us-ascii?Q?eunkddhnDZLFHDuZ5vZHdI35OBg89xkrgj/kktLnixGKVFGTPpYRhLBg/APr?=
 =?us-ascii?Q?1TO/hyLF0lMuXra5PWPBI8wl/0BOHTun8MrVjpjlxYYESUgAl56Q0tTgQYUk?=
 =?us-ascii?Q?54php8ZAKbB763Z0TM0hcOAW+N2D5UYpac5pB5LZZ8g9tXTEaf2zrJANfl/w?=
 =?us-ascii?Q?uyd1RUEtIzIbAHuUuZOOdvtBcNzdgn4AWODRHh1yojWrSOB525P+UXgfyHhi?=
 =?us-ascii?Q?CUcDouYLz3kTzFcF4AQ9OZcqqLcjMfnrZNKcZPxvqfTTl+cGSafnLKD/lQiK?=
 =?us-ascii?Q?ZTRdq78JkXLEKsLYREWZj3Zu0UpcQQwef9L6vWaTtcduk/al1KsTlnsR4aXZ?=
 =?us-ascii?Q?VpR/ogO3YLAhujf2K2KsKu3WMbWoh0XVuCz4KldeZOWbPAS0D0GdR+euZnTm?=
 =?us-ascii?Q?ZRqK+oHGxktO+6TEdrjRmF6aM7XVo63tXPg/xJRfJ33OCipDREi50f2GpEd3?=
 =?us-ascii?Q?Yn/Vxky8c/LM4k2O06M4Uz1bBglNOSHAyWbdemMbVxeISzhfJ/XcnoOzcMiR?=
 =?us-ascii?Q?ymqzikbri1BO4RWielvOfbOg05eY1o5zLQOl8fWRg6jitFTBwqgzGk8ite2r?=
 =?us-ascii?Q?zXlYPEOL6yseeLyEsE3lXwV7Eaur/T41iBZTMLyqvYqz6typjs75x/Z/jqKI?=
 =?us-ascii?Q?BBNn0BPRezejxxE2cljkIC3/dQ87QnR70n6+BxZvQy1RLZ8MSs7Pfwkp9oFs?=
 =?us-ascii?Q?8nDk1hrOMO1NEFiB73DYCdhufhlmeczWk0u5l/Iw9Sk3Bo/1xYLsz3TGrL1/?=
 =?us-ascii?Q?YWwsArllPdAzrHL12yp3jYGoCzJwxWz73498S7vSfGgYKTfrk1tc4c4Qi9LY?=
 =?us-ascii?Q?D4eb/urR60UDwtV50sX2GBDyepBeLB0f8eximSgh+25MRsdUrqSilMWZOXZ8?=
 =?us-ascii?Q?ZMB4VDhJB9mM9OCRfZUG4CeChr4tn/B2eC9cFVLF3l1LpHMlCcoSVgZYj3gY?=
 =?us-ascii?Q?Ggk/Jv+4w5entOUGMEjR8qq5T4/t0sC/mml4hvkQddMWhOSdxX4z5qiJJjqz?=
 =?us-ascii?Q?0w5Cxjlz16eIaxbH4rV98iljJXNUd0IxTjwMs9PWR0cstHLzSTCNFag4hzhZ?=
 =?us-ascii?Q?h/lXb03EqZlKvNMXcTrRhWLhwKyowO8lWGi/C1MUxIRbJ5gCDRkQu7H4YgU4?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 976d6469-2b4f-45ae-64db-08de2275b0c2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 05:30:00.7368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6b9H7OvBQ/xrPeCeAAcgIRloa0uHdX5U/Q2pwGmI3wlcp3LkjLYQOzWgVrnUouFjXDhRI3tUxbkPHcsxMMZF+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7355
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

The close function was overloaded to be also used as deinit function.
This can cause issues when using functions like hotplug.

This patch cleans up the code and implement separate close and deinit

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 92 ++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 41 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index f82c50341d..0cd875d715 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1524,53 +1524,14 @@ dpaa2_dev_stop(struct rte_eth_dev *dev)
 static int
 dpaa2_dev_close(struct rte_eth_dev *dev)
 {
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	struct fsl_mc_io *dpni = dev->process_private;
-	int i, ret;
-	struct rte_eth_link link;
-
 	PMD_INIT_FUNC_TRACE();
 
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return 0;
 
-	if (!dpni) {
-		DPAA2_PMD_WARN("Already closed or not started");
-		return -EINVAL;
-	}
-
 	dpaa2_tm_deinit(dev);
 	dpaa2_flow_clean(dev);
-	/* Clean the device first */
-	ret = dpni_reset(dpni, CMD_PRI_LOW, priv->token);
-	if (ret) {
-		DPAA2_PMD_ERR("Failure cleaning dpni device: err=%d", ret);
-		return ret;
-	}
-
-	memset(&link, 0, sizeof(link));
-	rte_eth_linkstatus_set(dev, &link);
-
-	/* Free private queues memory */
-	dpaa2_free_rx_tx_queues(dev);
-	/* Close the device at underlying layer*/
-	ret = dpni_close(dpni, CMD_PRI_LOW, priv->token);
-	if (ret) {
-		DPAA2_PMD_ERR("Failure closing dpni device with err code %d",
-			ret);
-	}
-
-	/* Free the allocated memory for ethernet private data and dpni*/
-	priv->hw = NULL;
-	dev->process_private = NULL;
-	rte_free(dpni);
 
-	for (i = 0; i < MAX_TCS; i++)
-		rte_free(priv->extract.tc_extract_param[i]);
-
-	rte_free(priv->extract.qos_extract_param);
-
-	DPAA2_PMD_INFO("%s: netdev deleted", dev->data->name);
 	return 0;
 }
 
@@ -2891,6 +2852,55 @@ dpaa2_get_devargs(struct rte_devargs *devargs, const char *key)
 	return 1;
 }
 
+static int
+dpaa2_dev_deinit(struct rte_eth_dev *dev)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct fsl_mc_io *dpni = dev->process_private;
+	int i, ret;
+	struct rte_eth_link link;
+
+	PMD_INIT_FUNC_TRACE();
+
+	if (!dpni) {
+		DPAA2_PMD_WARN("Already closed or not started");
+		return -EINVAL;
+	}
+
+	/* Clean the device first */
+	ret = dpni_reset(dpni, CMD_PRI_LOW, priv->token);
+	if (ret) {
+		DPAA2_PMD_ERR("Failure cleaning dpni device: err=%d", ret);
+		return ret;
+	}
+
+	memset(&link, 0, sizeof(link));
+	rte_eth_linkstatus_set(dev, &link);
+
+	/* Free private queues memory */
+	dpaa2_free_rx_tx_queues(dev);
+	/* Close the device at underlying layer*/
+	ret = dpni_close(dpni, CMD_PRI_LOW, priv->token);
+	if (ret) {
+		DPAA2_PMD_ERR("Failure closing dpni device with err code %d",
+			ret);
+	}
+
+	/* Free the allocated memory for ethernet private data and dpni*/
+	priv->hw = NULL;
+	dev->process_private = NULL;
+	rte_free(dpni);
+
+	for (i = 0; i < MAX_TCS; i++)
+		rte_free(priv->extract.tc_extract_param[i]);
+
+	rte_free(priv->extract.qos_extract_param);
+
+	DPAA2_PMD_INFO("%s: netdev deleted", dev->data->name);
+	return 0;
+}
+
+
 static int
 dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 {
@@ -3177,7 +3187,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 
 	return 0;
 init_err:
-	dpaa2_dev_close(eth_dev);
+	dpaa2_dev_deinit(eth_dev);
 
 	return ret;
 }
@@ -3381,7 +3391,7 @@ rte_dpaa2_remove(struct rte_dpaa2_device *dpaa2_dev)
 
 	eth_dev = rte_eth_dev_allocated(dpaa2_dev->device.name);
 	if (eth_dev) {
-		dpaa2_dev_close(eth_dev);
+		dpaa2_dev_deinit(eth_dev);
 		ret = rte_eth_dev_release_port(eth_dev);
 	}
 
-- 
2.25.1

