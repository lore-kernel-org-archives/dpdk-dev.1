Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D145CCD1A5
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 06:19:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6167B40676;
	Fri, 24 Oct 2025 08:19:38 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011058.outbound.protection.outlook.com [52.101.70.58])
 by mails.dpdk.org (Postfix) with ESMTP id 8AE4E40647
 for <dev@dpdk.org>; Fri, 24 Oct 2025 08:19:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wr7NFwvNp90qTP0ZOqYMEZMNt3PJKM1s8e/DJ1OGxiFAqWXt/lWkyGFctgFKA+blgeZ/pllzEoqhh7JnB5zc07oUTbpHWSACnXwCZC6iDsSVrkDUVoSKt3ag5++Z5Rmy+QDHEXgDapeuSO0ys/YEBfJjXh7JFbuQ6w28j0eabJw8A/ez9As9bjU/pLMSm5zD0ZtR6CzPSTVX8JOs88hwpi0rnhK/bwIh/Mnr+bFOrFy7dLjr0IvhLTIHIVsf7dQJnEIE/JBLdlRF0mWTjAo8PwTDwcJSener0/7hz2gnPIPNR5KfsGlZh8+dxMtoA5G72Hq1zx60lLJwfZZXTUy/IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7D4dEr11fdoH4LbXnGYrm/tNbu2v79hHX3b1rf/jVOM=;
 b=qA4Fdv/RoaOMUyVXt8FhNi5whwrMHNPW7YVH/rGYzeNPqiQSx5ISC9tBCCk4szCsmxdm9wFiq6OOppfCCUD5u+f+OcSI3mpaC25euoLsrhJYPTtszfXj0AWYmIVj+wKTeDAvomNOZ1NbTSl85X3Y36vvUdIhpc7BjbDv23iokjsmQorbfbGyV4ITgZmcz45HRutvi7OjvobEfo/wKpW+i2t0ke1X1PEE7NGtwNSDm5B4nrcr7tmJMyN3z6s+M3AAI8r3Z/o8zaKUchpOBOP4d0UzCH8CL3yKlX/KPc/7biogmX/4iV4ZV7Sz9XMRRGjtU+xOZ15WMbSf8Gqs15/yPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7D4dEr11fdoH4LbXnGYrm/tNbu2v79hHX3b1rf/jVOM=;
 b=D1j6X7HTCiWXfbh/gnkLN7q3WouCN8Jf+27sr0W3SlESkXQcBmPK1Q3lFC+TWj2i3ee23RLfibs4Qf0RLaLXv5S3IvN95343XARkW5nDLWSXpLwUGHhxCmH4UXX5YDP0Qpq10vEUP69zNSeZk46IE44eUD8W9EvPS1BdSotNPRBO25tq/06BpNFx3AogfBuCY7oTo48bq04f7maRnMXAe8pS9GsegV/vHLsrJGS7yqFmO6+ZxWaj/S3ceMZdhcyLU66sqMLTFwbz8paswCpfVxZedehPlnKILiTabll2M9WH7D4iLqduqBoIIURcd61gD5rY1Kj8wEPE7eUrisha5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by DBAPR04MB7478.eurprd04.prod.outlook.com (2603:10a6:10:1b3::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 06:19:33 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 06:19:33 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v6 5/6] bus/dpaa: set max push RXQ number
Date: Fri, 24 Oct 2025 11:49:05 +0530
Message-Id: <20251024061906.3535470-6-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251024061906.3535470-1-g.singh@nxp.com>
References: <20251017044848.3269627-1-g.singh@nxp.com>
 <20251024061906.3535470-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|DBAPR04MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: 599aebbe-968e-4612-e6b5-08de12c54c43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HjFy+499zkLMKl/v6S61bolUYMjY3mvUAVXdhnMux18JWEoBsAbA6EuHtBOn?=
 =?us-ascii?Q?RsAyqg8ovLWZO0VeAjOe3/DsCy/3ICgq1lH74sv0aiJq32iX1IVqhI4TQnZV?=
 =?us-ascii?Q?YmRjWz8gNcan0UOmfb4VAcjGbzXsLt+CxI6qfwYjzw4GRF+AmrX16sk7nNJW?=
 =?us-ascii?Q?P0nTLbTxb1cmVse03eMgva17Fco+Oux7a0s/KxgI4i0n6bEM9ii4/J+4uCwi?=
 =?us-ascii?Q?5TzLVDPSv2m+Jzyqs7U325ZnaupZr1kxiF8OAnVca1DEBCTcmIVwxmHaqL+R?=
 =?us-ascii?Q?G2OJggyyRn3gYWKGUAn8bZKnrIZ+xobc/NZ/i3gw9Jx2ROY4tWLBkaZbkk+P?=
 =?us-ascii?Q?BOeA5jmFWjimIZZzLw4i+QnOFEfklpxuZYDKU1/xNmfXHbza2tGc8uQuBINq?=
 =?us-ascii?Q?lRt8KOAtD2VcmAkQpnmSxgn5ZuYVOUn81oagzffPXe1z6I084mCb4wKmRn+Y?=
 =?us-ascii?Q?iYl1Kz2s8Im0piHHTrcybYJKx6H3GeFY16WkveIjZDZg20Qa24qrKZYlkZOw?=
 =?us-ascii?Q?bULk01BscnR0vR0t6wRozsIKSZnbckKrnEu/hK9lXw2BVikx1hAgsVfExfd6?=
 =?us-ascii?Q?0gLAh4tqeXmiqcui9YqXro1szTBwCNHDm4u+orGk7IDCRXebbOD1yurUogUn?=
 =?us-ascii?Q?JAP7VUx73i/hYU8U4Vm2o7TG9GnurQEbtmnEvRrz5xIzuILUAwpGWWxqhwan?=
 =?us-ascii?Q?+fnXQxXC+NHrYHLK4e3P9yOeWaRmf7snRanA6WZiptvYpjMLsYs+PXbX/feR?=
 =?us-ascii?Q?16MqIVkoFGgPJsimy1kKnJb9Oams2IgXIrYp+jqCtNmTJkqDzH/wRdfZBVeq?=
 =?us-ascii?Q?aZKHIUJR9q0LxSAigEGiwLVF+Zc9dQWDjh+NDQQbCAWLcV5Z85olzFlBYAWu?=
 =?us-ascii?Q?OkeroCgluafYFhI8pp4BisNkgQJAQQ1G4KmQRSK0tYWex5T/RgS7QNbRFw/z?=
 =?us-ascii?Q?/ae+goV7AfqLqRR9xRpy8Fl7khrw4yk73Bgag3tS3xjgRHkIp4AysxfvGVy4?=
 =?us-ascii?Q?aU91+E3lbcZy1j9jlbXiHuY6WVX5w7bcOcEnHtWgWz0bs6B3H6sSvPHW08C8?=
 =?us-ascii?Q?n5ExfhPGuy/mZQ2QTzSc7lGybBBqMZmnzzfefYfrPjzx/oDUC+RZvg2ecyGc?=
 =?us-ascii?Q?FJqKDgCZ4isc5PUUDg7ysFHIbr8NXH6KViGguYGrqjlJ1wk29Sjz7o8+/ky8?=
 =?us-ascii?Q?/q80HoKOcHxbiLR0s9wzTNYPO/988KGotrLeXIY6SZqz3dOq6m23oCmAVffa?=
 =?us-ascii?Q?9sKMMCtLy6ToNbwED0gvqMoJivMbyGUgDl1Y6UqjgGvDq24MKVlGypyRio5l?=
 =?us-ascii?Q?CP4fcRX9oMcRPIIEaAj+8iwDikjEZTiHXNuxHI0KaFvMlB3E5GKLBl4GRX2m?=
 =?us-ascii?Q?rTOslY/f7jEyFXYM8mYU4WuSGdrSS2Z3WZch5BdYR4e1S3wCv3iSGLWnwAV2?=
 =?us-ascii?Q?q7y3ZLGjgqrWLH4Ew5PoPgM4BFUZ6ZIesIcyQO/f2UWzuNU2oCx5D31GU0Ei?=
 =?us-ascii?Q?YwnZILU3qLVhEczDe6154hEgCgwVo/h7yFz8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nc2miROF5pkwSznwj6vBe3PFNLl7VmlaIbvGq/hP6zvnTgwutCI03mZp+aPp?=
 =?us-ascii?Q?6WhyTXpPMuCT1mjgyjSH0A3b+lvcOMNN+1yo/BchlB0ZvQkNBTZ1gPWV1x3e?=
 =?us-ascii?Q?ksdWL7HthU8WsmjQo3fAj0vsruKmzAPxgL1MHha5UONX19gyU7yB4Z24ckxq?=
 =?us-ascii?Q?ksbzMQTyGx7CVVsZqNB3lIPvOk2YO3eg8bwTDk9Pcqv4Yx5SM1PliZb3WrjW?=
 =?us-ascii?Q?ilmfC5dgCyErpQtcK1KxwCfOqXTeGm39P7JqHDOZr79lYlBX4NOnw15LygW4?=
 =?us-ascii?Q?41OTzh24y4qUp/IoMaMiaUYGffYQoWkrDN0nykTONSw66PhpyB8vdyW4Oowm?=
 =?us-ascii?Q?axLLmWs3DrZ5sjghG756jR+E55ZaCV68nOGAYkMQC+lIy0SCCiVRTOrifOkD?=
 =?us-ascii?Q?De94nrKvqeIktk888FRxYGOs9RU8UbRvIe1We8C0MHh7EHdNk/jR67yOyfZx?=
 =?us-ascii?Q?K2hx350zxhz7tLmkAYaTRxEus3Q7YkFtAiRPraONlopPg+jaTBDPgIlhJI1D?=
 =?us-ascii?Q?kgZXuaJzsYeharSIc2YWVMFLCZjYQ5chm01JXryR0h8rvkXULddmmjh70MB/?=
 =?us-ascii?Q?rYdlmG1S6ppQ43z0vg/45u3onXt0wUC6hw5OYl6k5eSDiMo1ZMoaikafaFe/?=
 =?us-ascii?Q?1MLHaLsxWKcoAu8npMtpUreY+//mqJwcnzpFzH05nAj9S4t0oDi82T3wNBCk?=
 =?us-ascii?Q?fb6gzh/HBZlcBfu9MKeg+owIaglEHEuIUSt08ln5qUX1/pQ17rlzbvJSB5IG?=
 =?us-ascii?Q?Bq0tRgwe/zKWAi2REqqbUvcaYoDhiv6LYRY+YGJXPDbVD5gwQrg9pqhJnbIK?=
 =?us-ascii?Q?QbkFAe0051BE3stHLutQczj8ZXGJiTSjc4vqqnN4jG+lAzxoQQv6O07gBvxg?=
 =?us-ascii?Q?iuU0QQXEMMAoNPTZH+oNU/jOAXWcqmhVP/9DUHYP1QZDAt+tQ1DFzWgwtavj?=
 =?us-ascii?Q?EjU9AAKbU8A9WbsolBwyr5swm+oRNyJ33wfpYaoM5wq3nBdPWg/ckNNAACJp?=
 =?us-ascii?Q?DxsjTfM1U6rbUNk7AJQHqMQJJlM+P/F8nrNEZ8Lxdw0TTiIQZF5qCNIe1V8O?=
 =?us-ascii?Q?eksTmva+1BrTCFFmDE+PEwKrcTaPyThIxOisVmlos1P/ELix0Pv75MYEB1ts?=
 =?us-ascii?Q?krSLtgNUbK2jFdsXFcDePxAIh09JP11jjc6Xm3WIM6I+J7AtSMtMfV+Wwot9?=
 =?us-ascii?Q?PcmxPTSPd2cZZLlTZROFjBtfEysHVFNog4pRy3RL4WyIW1kC61Q/TtSurwrp?=
 =?us-ascii?Q?3ZqKPJBuFUTwwYKIZu9xRjqrHRekUZh2NyMHJAV7ewSyjcmQsFczPjlDGCuu?=
 =?us-ascii?Q?Uapu9vj/tbsJ2Mmc9nYveGmBkHNN8HcukqBqqXgkLecs2Uzd1W2IrM4/uL8w?=
 =?us-ascii?Q?udcHvNK2kwMyY4ESKPlgDNVD8FJa/37TL+yf3uAL4H+jti261o0FkXrY+1vJ?=
 =?us-ascii?Q?1WUH/KZ7qcKWCybo72DXZh1mwvn7m69witLNIFpAYdz4p5bKBpdSkOZ7dNu9?=
 =?us-ascii?Q?2zSy2x4YQCOtFWcfAhs8Bry+Ov+U4/N+Yi5r8MGyuU00zEwv3ZkrqyjMgcvf?=
 =?us-ascii?Q?InoRaXAxLwp6WD+W/zc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599aebbe-968e-4612-e6b5-08de12c54c43
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 06:19:33.3493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxR6/UKGsJCdHGrLNepQ2TuvGLE/NRUoZ2KPsttGXUiFiDKejmqew663QrHw76wy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7478
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

