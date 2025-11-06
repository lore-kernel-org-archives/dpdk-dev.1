Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804E2CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 16:38:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C04740670;
	Thu,  6 Nov 2025 17:38:39 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
 by mails.dpdk.org (Postfix) with ESMTP id D3CCD40657
 for <dev@dpdk.org>; Thu,  6 Nov 2025 17:38:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCB99VoVylv88tGB3E1jqh98TXI44+j8QAz0RXtIIAVGgeNUBXYHcme6TYpet2HTRK38DS5UKrf7TQ2jAkjRMEsARqpMguU2nN6PwkQLPlAe5bzfeg9AW74QUiFaZ1xb29S7SeWtrHSErXKw7sdMK24cd6pf6USfGuJkjfjataRtqqdeuPCJalWPS0AzICGmqTTqm5tF8EM8KYmJ8mocNngNHX5aVA1rqWhe9yNKL3jQg4pI+1oa8SQkBUKHoNpUlTUjJBJ7IcWkhlT0kxaiLtD+6pEa3bgwY4rv7Q9UatV0xsKgYqxGOECNonGmMu6EL5lOkTEWyNXArUz9fi63og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVzGGkXr0PQwqsbCmb/AAyJFt+A1zBgwl1YgQ0vGrCU=;
 b=xwFw/I4uN2tmSbrFGVdTCSCXP1gdGQEM6jc7QIAzrtvydYfUem7v/5I58y+blS0tUg6AbEGxsdiy5eb4cS/uBrgzjgT6oOUfjQHMtN167V43BABuiW8PZcDty03tdj8wIr7aaUsEmwo/Bsu1j0N+hf3o34oHfsWBAKuhZYjpYS2aZ4E7ztMn79PSnqgplwE3E7O6OCPqW5PrQ2l3GP7/RlXEsSPiY7Ai2S3CuRW6pMbchWOV4VdjA6/Vq/AZaUoAybq/DPCg332sJXDzzs3rvLteabjb8MEktKdQAmd/hbnerWt8SEa6Fp2jSNNHoiD9yKpDjBJF6nbNVPJuTQex9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVzGGkXr0PQwqsbCmb/AAyJFt+A1zBgwl1YgQ0vGrCU=;
 b=gYjruldxaSdRYU8PLINU0UROOvjMOhl91SGBdNXqObEUwk5LzVe8w2gyeigg9jwajGJa0Q5DAyywI8kJ/jr/LNnjFpfFNdUCjQW8xjCHDjEVVKQA0hyjNs4Iah4Py9EEOwjuYgCSuCM+LrB4aP+EHmULWGuq76dmfu2aQKhvXs4xKMZr9/XBNWK3ar3k0KjaXNLhFBF9/wv3TTgKWFpv/ATLjczBAPrNTbDedntgSvH7KRRs5JYS4EWlJ3b0iL3ObmeRLfKnHIZlk222e/1cbeb5Aj7gK/YOwMkO0JW4SL9smVHOne3Lxl0NroTkdJ+1AAiXKUz89Y5RhRUAXiYx6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by GVXPR04MB10801.eurprd04.prod.outlook.com (2603:10a6:150:21b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 16:38:36 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 16:38:36 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH 3/3] bus/fslmc: add support for hotplug of dpni
Date: Thu,  6 Nov 2025 22:08:07 +0530
Message-Id: <20251106163807.201451-3-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251106163807.201451-1-hemant.agrawal@nxp.com>
References: <20251106163807.201451-1-hemant.agrawal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::31) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|GVXPR04MB10801:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca31c0a-c950-497e-d1d5-08de1d52eeab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CBj7UXJHCMByDAieOLW5yO2OvTgpa3LwtwB7IGhgaBaqdL39jjEaXCXBJkfp?=
 =?us-ascii?Q?SobOk8dqI053/quD6TcbpIWFYEma/SeIz+H2QZjm9BNDQvFatL17yvYqgK9C?=
 =?us-ascii?Q?X5fTUYseJesLtXzue8wqA1qQzjjzO0JS+/1s/YwPjoeqzmLi1QgmyVbDBFB+?=
 =?us-ascii?Q?89/oaxhLMucBrjBlMMfbhWr2DJdTb4R4+/ED9JLW0napw3gu7AeZfCdnCyeY?=
 =?us-ascii?Q?iWLoXsZMrA/RQXgy9ZVx++AQaQJIKtxNBciEnavYINd6FAZ+UX2ACssymoNA?=
 =?us-ascii?Q?pS/GwqgCWS989/ycOL3s+CKqX2TEAAuEQCLQSy6EuZ/IsCE2OfaG3QJRl3C4?=
 =?us-ascii?Q?knI3o72QxnnPxHlTaymie+Gm6LoidSM6gI79MJtA3rjZ4jHQebiAh/EsAKHu?=
 =?us-ascii?Q?9z3J3QIS+KO4xZfUlfE+U3OIhiMVV5Qo37r2INfWdzUCrfbMDQZVfOs/3V3l?=
 =?us-ascii?Q?e5OshjQzwvbjMLjOi+nDZ+l+hhDlr4ySWqd3vX/Fg+GmuMAAZnU2PLgG/kFT?=
 =?us-ascii?Q?AyM63pmkFIQZ0S6zIheoa0EBvcTH48G9+twiIZTnODDUyZhwwHlhAo658L2/?=
 =?us-ascii?Q?/M+jWCtDu1mFRndoZa0Qo37Zs5JMSPrxdvfgmk6F+cS1ETTRmpylalGW/YiY?=
 =?us-ascii?Q?Ovkb+2rrU/p4QVNTlQGtLLXtQebkoD+y19Nf+OHGE02cgAWAwNt1Sg0lgzV5?=
 =?us-ascii?Q?tDXpajDeJWwtltI4h/zdOGMUCW2ZgHumxNtm8j+Qj5BiWFeTCaqlo0tEaLTv?=
 =?us-ascii?Q?zfKbzAzMCt5/dK2HWn1BRIjtLeD3C4QyOEDtxuilrpyPQIsRbWxosKfZhXhz?=
 =?us-ascii?Q?DEdgSsWATY6cZY+yDdiwmhsbhlPnmstRtf3RZi3FtFo+ApXFQbmb2T2FPaxI?=
 =?us-ascii?Q?UTbC52uT6Y3iRSylw73WKnkDtHrpvnCpWXqFGlRQoM2kwXSArxeq6Ux1/yrL?=
 =?us-ascii?Q?0BqgRdbYGzJzSsvq/d2RXL9rOWuDmZ8wZtaMtqefunICjtkAwxCLYDx5bHXJ?=
 =?us-ascii?Q?/79QCNrbghhou1NSXWEBC6LoGcqos5ZW4Cd3/n91iQgOwwhp8s9fK4oYtGbf?=
 =?us-ascii?Q?uHwibcUJ3U5GLbEtnIXNRxa+mW/6PWsnuybyaQ62NqCNBf3u5aGgWKOcFRCa?=
 =?us-ascii?Q?529NmPQmLFrVHP4iJuULKYX1vKqlgGjfy9jAMC/2z/pC2My+OHhgA+VAAdx7?=
 =?us-ascii?Q?dSmllNidtqRSkJCYl8/zgLVQdj7JGOLcyhkOPT722ZrsZ8NetUA/IX7kWEuQ?=
 =?us-ascii?Q?RC68oTaND+8SsKW+T1Z7teNpPyMUjVROZKnKVPFgy21qip6ahzGtdnicf2H4?=
 =?us-ascii?Q?Q2xMP4YzpnsRdvq/C0yZC24q2TMkRgBEd1xxIw7K/88hm4Jumt8WnzF0/EmS?=
 =?us-ascii?Q?UPnJ5WEdRYkK4HUAQkOr7mzjcOm0uEn8XFRpL56S8iFcu7s+fMiFO6b9iUc2?=
 =?us-ascii?Q?eMxtf9e+Y4P4+Q95mj5xn/G0/viCcKxeyvQW0Eba9u9npcuysuHiGUfSatQm?=
 =?us-ascii?Q?9ZW4XC26Rc7KiCOzEkVDPz8Shtk9c44hShVr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JqqLWnAQT4AJGqxizoBSDEiJdu2pvqf8G9Bog26iMUr6zKapucmwIKQISfvz?=
 =?us-ascii?Q?w7Wm0ZZgPDQzednBjVCoIJqHCqc6TMX2RV28LoCWk20h0IolQMOAl5cW8Rrl?=
 =?us-ascii?Q?XHGJ4bIYYVT0yuBE4AWcGnAX+1HMH+uEL6UJZrg8z9Kr3lIljDdRaaDmJ/p3?=
 =?us-ascii?Q?EGl/o60MDOt6Tc8YXoi52W6slM+/77qaFhGm3xDBp/CpqcICrln88IJkUnVD?=
 =?us-ascii?Q?dVj+fiznVF57IFAGGsAB2r1TRG0as6kJ/ogWkMf5wvLePGzDdfHeMjfJymZW?=
 =?us-ascii?Q?3hF9dDMrwu+T9wLY/Mik0howqS2nSIKyU1TbqDN9psda12oJdC2r1pADwmvf?=
 =?us-ascii?Q?YdE9kfJMlh9JwB+pk9RtHV0YcOQN/WZjGJib4+xbWS25u1QkWo1xKZVwbADR?=
 =?us-ascii?Q?f5hFqznqQH2HLMCxdr0rWdPv43c5tYNQdThAZ/5vQ0Ks5kR3yCTbQZDhcu2n?=
 =?us-ascii?Q?t/LNi+QMYFbBrXbImcORqpiKYs7mMcrWtcbNPC8FxsOSpWh246aC7yt4eHIg?=
 =?us-ascii?Q?3NYUAz8F9r1ZF/jq8LvrfA+7wK2YGTm+lHbzn4Q7DuUWjGhGDmdf8c1dcyE9?=
 =?us-ascii?Q?QG3H2iLdgghFILC5XV8Kp0DXLByKHxk7iuGp8fFVdTWpOb+ZhNTD2riPfGLY?=
 =?us-ascii?Q?RXW8BZId/laCzUAdkeJL5+F9WKgnpR37gMqgHMuETXcyzWyVHyMfxdqEnSY7?=
 =?us-ascii?Q?VuOVo2rgiI77wLk2Xnac7Ccyd8rYZho6xSvp/fFxU/ufxGMZhphVVRtuDMS4?=
 =?us-ascii?Q?ncjpEJ95g2GF7EBaKbZ5xcnkFY2tpuKotFbGz1n6sUleQVtpfYmZfmwTY7p3?=
 =?us-ascii?Q?2xuEyNXDhLSSQ59PnZAJVNlYrvrlpAZUlyX/1DW6qXqDg59Bsxm/jEoD2x78?=
 =?us-ascii?Q?b6hdkhkYDEexBYerOoHtMkieh0fEnpz7PM7qZkiWPbZ9cuZX3LdvIPSeOo8l?=
 =?us-ascii?Q?DxhtPygEVTCOTQBWawXqy5rvT58gYHoKQFWR8VwGib6XkUUc3nK+C6NAZEZ3?=
 =?us-ascii?Q?YoSyF0D79Aebfqf5WbUzDrhct69hNIF7clvsxxUacjkw9nYu6DA/CweIE3af?=
 =?us-ascii?Q?KDafyDmMxJ2I2QwjFiXJ28XAZVe0irwSFAvAl6czCKfL0jpkmFUHUHuJWlfc?=
 =?us-ascii?Q?JFy6w37bz6T0xL+dQtxGjm8PozbSR9rw0t9MVpFbeJkTagQ7LrDgrN0MDF+a?=
 =?us-ascii?Q?IKq37LUABdwIQE2AX+Nv8nmnT6ohmSkoMcTCYKX36twfEH44ylzHeubtUQ9s?=
 =?us-ascii?Q?rjrhxMxVQolq8o0M/U7vATGN+0QpXOvfye1edkDacR9J5nbl/W3xDjQ3kIO8?=
 =?us-ascii?Q?uV3vTxFaaZKYB4hyXRCuOl6hFfNjf8hwdDjal9adrGmQ2bcfwjc04/f7d18J?=
 =?us-ascii?Q?6zPUpov1D/gdr/aRSVGm118ulYbj1ajmHu/UsYrAsRuD8HpFxBst5prS0cgm?=
 =?us-ascii?Q?ollF5a91X2vLaPwSNoNIpQAESMKtXtBXV0hUHUMfPYwKbbVFBFF1b995h+Bd?=
 =?us-ascii?Q?UfQMpZkR8bUARs+WgwC0m7+fK75aIr8RIn4EHS+n0oOZTPO2Hlmb2J9GQ9Wx?=
 =?us-ascii?Q?m/iSLNti97EUlsUGQBRXGHCPIqXLyGbqfIy5e46dMBIWnXiK+QiXrLwTk5l6?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca31c0a-c950-497e-d1d5-08de1d52eeab
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 16:38:36.3698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAKYxFcg8CqURds4/MTx/zYpkYerPdDcxamoPi21G8MRoXROhurT4iH4k7Tm5VtXRTanTkRBUx7087drQDkxyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10801
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

This patch implements the plug and unplug function to support
attach/detach of dpni interfaces.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/fslmc/fslmc_bus.c | 56 +++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 49c61c9d2d..4529ec5085 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -589,17 +589,61 @@ rte_dpaa2_get_iommu_class(void)
 }
 
 static int
-fslmc_bus_plug(struct rte_device *dev __rte_unused)
+fslmc_bus_plug(struct rte_device *rte_dev)
 {
-	/* No operation is performed while plugging the device */
-	return 0;
+	int ret = 0;
+	struct rte_dpaa2_device *dev = container_of(rte_dev,
+			struct rte_dpaa2_device, device);
+	struct rte_dpaa2_driver *drv;
+
+	TAILQ_FOREACH(drv, &rte_fslmc_bus.driver_list, next) {
+		ret = rte_fslmc_match(drv, dev);
+		if (ret)
+			continue;
+
+		if (!drv->probe)
+			continue;
+
+		if (rte_dev_is_probed(&dev->device))
+			continue;
+
+		if (dev->device.devargs &&
+		    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
+			DPAA2_BUS_DEBUG("%s Blocked, skipping",
+				      dev->device.name);
+			continue;
+		}
+
+		ret = drv->probe(drv, dev);
+		if (ret) {
+			DPAA2_BUS_ERR("Unable to probe");
+		} else {
+			dev->driver = drv;
+			dev->device.driver = &drv->driver;
+			DPAA2_BUS_INFO("%s Plugged",  dev->device.name);
+		}
+		break;
+	}
+
+	return ret;
 }
 
 static int
-fslmc_bus_unplug(struct rte_device *dev __rte_unused)
+fslmc_bus_unplug(struct rte_device *rte_dev)
 {
-	/* No operation is performed while unplugging the device */
-	return 0;
+	struct rte_dpaa2_device *dev = container_of(rte_dev,
+			struct rte_dpaa2_device, device);
+	struct rte_dpaa2_driver *drv = dev->driver;
+
+	if (drv && drv->remove) {
+		drv->remove(dev);
+		dev->driver = NULL;
+		dev->device.driver = NULL;
+		DPAA2_BUS_INFO("%s Un-Plugged",  dev->device.name);
+		return 0;
+	}
+
+	return -ENODEV;
 }
 
 static void *
-- 
2.25.1

