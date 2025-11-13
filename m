Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7659ACD5BB1
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 10:00:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E770440E39;
	Thu, 13 Nov 2025 10:59:48 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013039.outbound.protection.outlook.com [40.107.159.39])
 by mails.dpdk.org (Postfix) with ESMTP id AF3F040E21
 for <dev@dpdk.org>; Thu, 13 Nov 2025 10:59:46 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHIbGrkE5829/CRc5OVA/OwbW5trBNzL6y6LYm8ZDjOPy5wdC0r2Gd75dip8saVWBrpFlRwp2ZzLMhFFkaUDvHMeAzRQPu2nNmMy+RIFkRBjmNTT2Mm2nGurxxPXvb4b+A3Yphim/rkm/ErDY/tjN+uU03W3mF+GgFsfG2Tv5rIZgE2d68VxfYlUIP8tACDb4WLdZKHz3dS/879sIGUhAh9YymzQURlyEqZDow/sHndaj7+C6PT2ZlERinqAjfXGMNFfK4g+N92OWFSoDoQUmpzYD3NnqEcRUEXa0TIR465OCgXt3zdvDXKPWGnwf/tOdVHVxRa+RtH+fO7hS9Y8+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVzGGkXr0PQwqsbCmb/AAyJFt+A1zBgwl1YgQ0vGrCU=;
 b=dFInHNteO3YQDFmM9Cn7/FXh2KFDGkaS4n0dkOtCODSZteVyIM1I6/5nIUvA0a/vxWZElVjtjAjVCO909fgxmQzBNUxuS4piFJ9TE9u8keC16Sz/CClrm2OAVUOvXPqLFc2Cjln+P/HiztfktCN+p49IdyJy8UQoQ1MKgZ94NgTYAAzyHz/Jf8KV3wc1GDGXj46jOQ/k/xdch+/cZooNaitpy63E1jGbj8vVrQ8ndCmedXJyFGCmo0Sdv54cAwuVrnYD43Vbf8ZYvwJxysI1klanFBpOj38wFDM3N4sord900ldLyMyYpoTadwtup7dOK7LPfU7Ue3JQAJoLch6z+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVzGGkXr0PQwqsbCmb/AAyJFt+A1zBgwl1YgQ0vGrCU=;
 b=iJATrah2MRoxctnOAYp0HNWH1RkGV1H7jYZnX5DOlq+5T3DRBV75AZlymrPakgBhHqdHEFy0gjPBrDmXUdZ1c/M3iKaQ3QlN/xI6Cw+YQCXnPA6TfiwNtROILya1sUsoL8dxGR+JEDhnpIg6wb0CpTsQbltYGs/ZJFxdIRYYN50+uBwVyK5ke8BCcH7mm7tZYDkfyPEoEXiQpAAa2duxp4ATkOXzNxheQalzTMLxzqW/v59bFJOXPwZAIiecy9V+lwHArFdHv86yv48/QiLJJXe0VLCMEWMiQm7Me2bBixuSXmqCjjouGfmS4iT4Z1I9THqeVzvb7I0x+BzMPjATgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by DBBPR04MB7530.eurprd04.prod.outlook.com (2603:10a6:10:1f5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 09:59:45 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 09:59:45 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org, stephen@networkplumber.org, david.marchand@redhat.com,
 maxime@leroys.fr
Subject: [PATCH v3 4/4] bus/fslmc: add support for hotplug of dpni
Date: Thu, 13 Nov 2025 15:29:17 +0530
Message-Id: <20251113095917.1973514-4-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251113095917.1973514-1-hemant.agrawal@nxp.com>
References: <20251113052931.1784953-1-hemant.agrawal@nxp.com>
 <20251113095917.1973514-1-hemant.agrawal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|DBBPR04MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9f616a-9b07-434e-71f8-08de229b5f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xeapeAUAra252f2JuP8W0//nGR4euV8v2+T/9UTM2P1rZ+3HftrjS07s85bT?=
 =?us-ascii?Q?78eFSyEPSSVVsRW2Y1077nPUBVlU5wtbfufkhy6RJIKWWGNnHOaU20Z3kqev?=
 =?us-ascii?Q?leBZsWLK05I2HJoCjKznSVBWp5wX85R1mS+GrW4Jg0OQ8ACkXU2BXBg0izi/?=
 =?us-ascii?Q?KdZtIid6yDacobfk9nB02xfEYpBVjKD7dPTspdnoV0tKWJ6uZ3UVtvNbJeR/?=
 =?us-ascii?Q?h52sI8ONa8uGELpm/rUOzXsMuPN37gLQ21j5cRJOpWm1PEVLtPkfVaA+N/Ve?=
 =?us-ascii?Q?LT0bz1vvP2qgyqOUfdC0/0PfwsTCWagwete9Ma2Z7+bbTCokgnjwj3jv7gjK?=
 =?us-ascii?Q?Z9qsDbzVTvSEkI+fPvHTpXcIdSIHLSVInLiKWxMfud7XLLgANfZ5X0BTxwlF?=
 =?us-ascii?Q?DOE2ldqnYn+WeuZQyPvKqm2rkpuA0Mj4cypKpo0n49d767okJKVH/kTsDwBz?=
 =?us-ascii?Q?cRLOflUNNEZamFi59Q6lzfmgWN87vY9728EG6ToqjHsTFD+kq64yTlQY4jtj?=
 =?us-ascii?Q?FFj+Z2/24ZPn0dv29sDxk5EDi8MbiHvCbbMRNwUEN0xAmaYwVRo9eW7mgSqH?=
 =?us-ascii?Q?tqux/3USzpYXTVdAKGM4+sENdp4IUhME2kHY1kiZfBiM5UlHaYiEf+OPC1ay?=
 =?us-ascii?Q?2aZ80xA+7OS6OTpP8IT7qrBoMcZX3X6vOFZaPcWXmYLDamB9m0CS7aMMeDin?=
 =?us-ascii?Q?Jly4aghn+WK+WzSrV6nm41R11T9xFef5g1oGPudNDbSlHYGuu9OBXRWAVedM?=
 =?us-ascii?Q?F6HBkUM3YEDDLkZXx1eLSuGPltpbCCLP1+sOjIGU5J14MoYJAM61i/DT80e9?=
 =?us-ascii?Q?HqygysxSWC0lnb4M/jGmGT+AXF7pcyZmXJZoRU3wsIPb9Bt+1pDEVVM/CKnv?=
 =?us-ascii?Q?SIfjf4sz2ZLTWf7VgZ7z3tc/yrBpb9c91/a+BWNfoUXIgDRud4c18SXVefxL?=
 =?us-ascii?Q?L7KsyKkXRA+zukjyrVBo51Oj3tRaq+nOUuqAsQEoKsKNyMPHkeMCipLsmkH2?=
 =?us-ascii?Q?60Awn+TouPLo7GSc72H20rDC1onvpZ1SSUzkfHHwpsxU5mRRaf0RtZmzBwO6?=
 =?us-ascii?Q?ZnECduMGjuMahazx6SxrkYdAuO1vKLzCfl3MkUvOvoSIc4T2C1bo9gvrKiXQ?=
 =?us-ascii?Q?yt4PUIdylLNBLJHyE5+ycf9+c8PE25TRCa7i/NYKrvxBmxnQG6eoaADP2kMx?=
 =?us-ascii?Q?8W0dbfXOoUKlHI29LxdLTDO/XSluRz6OEviArgVu1TmfuGdT0qaP1HUXrT2F?=
 =?us-ascii?Q?MhRjJhyIPVePiqr8rdFzqZOLHURfL5Jzfc/EGpSa4HrOsML9qIN4qLPSqSiy?=
 =?us-ascii?Q?U3S6p7IzIt5zrFsOK1ZY7iliRSjIgavCMxK4xHM/RbdbHu+gCgvzIq6Hho39?=
 =?us-ascii?Q?k2jEj6Bq0KXWsb7mjKh54DqQXPZf4kbAInd75J9PGTc29eKsyAMbYIWx/jcb?=
 =?us-ascii?Q?nkvLifGMZXnMKhOxt0j9nf08LzhJq6f2KYdqnFRXN3t8b0zlKvm60PLmyPjg?=
 =?us-ascii?Q?h4kmGu3VJh4EAekjYs/jkRVzwJ3cb3LTHl9j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WdtF5lLxDAyBRyBPRGvOXQQctGFoP8Nm8MZx8FiRYYlXoDJDpR3LoizlzZxO?=
 =?us-ascii?Q?TanMENNfdHPjwyr0Tl8AwGYN1F2M9/OHfE937NicgLm/tf0ktwwgqdeNP8Im?=
 =?us-ascii?Q?H3/DWPbkJLRNbmI9M53U/xd3tBG/S/iP/D8Fls5u7X2+XZg5XK+5izkg+yQ5?=
 =?us-ascii?Q?0V1I2g8b9/Mo8gY0zcHLgAh13JQ/CneksbgarzuCv/jNw+uBiCi96JE3Ufa7?=
 =?us-ascii?Q?Vyin3atV2i83r6RvG4i3cnr1BtSElQ51JZxvc1kkaJj3uG7+VRzMR8/es2Mk?=
 =?us-ascii?Q?eYOgG9z3lSktgzawgXI8fnLdw0DZol93j+YjbJKXvVPKhQXnNn/rZjjLtYGu?=
 =?us-ascii?Q?E+tO8fRl+N8cKBEu4JQClj0m5Y2heZC79K258Te4+TxzxIiDiunQYW+ZY0m+?=
 =?us-ascii?Q?Ty1/z1MXimgxxxlDGzKMOIeNwjfaf3VnL7KZho64QNPVHJPL8lHIi7Nw2GiH?=
 =?us-ascii?Q?9Uet65jF2H2X3XkljPMfEttCJD54eKb4pTty6WeeIQC5AeuFk8r7jx1CypOm?=
 =?us-ascii?Q?nYM3G7MRzbaJJ255DsuyZiavNLN8ZLEFJdlaO2TCjiJvOTgtUWbXmJCEISmx?=
 =?us-ascii?Q?DZ9VNSrIfmKtAJQA8P8V1Ure0r4eLjgcOCpUGe4yRff/oHjml1COjwHc39lg?=
 =?us-ascii?Q?3j4HmtYETp8TbQc0zKgav8yF62QSdNlyJpo3E7d73R/kQfu1itn9kSUZ59K+?=
 =?us-ascii?Q?AnoyGGuEtC/RkyjjXbG5OXcerw2YsKDsIe+YT021Hca854n6lOI05uHE1xLi?=
 =?us-ascii?Q?Ee7rroDxbtko9D/VmNS3wNY5wSL8xwEevrLcLdDFsBSiODJohdok6QSqCTzn?=
 =?us-ascii?Q?gBAce8JQkdoIPO0+ISc2/mT/RHc12782T5mwNHmSoONTbSoj31gH33BAF6DC?=
 =?us-ascii?Q?/NhVqtNPY+jBA7UcygOA8JbpUrbWykRG2iQMFDj90WgRTpcslWKD+Yf4UI3y?=
 =?us-ascii?Q?t/W9EbijOWRy487Be64TqaHgxT/Ph2LO3YF8XlclzAFTj+sx3A4iHPBXvBhJ?=
 =?us-ascii?Q?Wo9IrN9A2GxrzJbCZNsCwvp2iUn+N1qWBDB2w9SKajrITRRFxeaGpCOc5kyG?=
 =?us-ascii?Q?fsEnrcrKZKQRI9nMX2ZYT2avzF0D9n55c0rUvoahVsSE/riqCJa3kjYk3SnJ?=
 =?us-ascii?Q?j4YsnQ6+pCcVaaHtRYGkA45heFBnRwxxI9Mn12nnRw8azfHV7CX/RdZfmmAL?=
 =?us-ascii?Q?O1JTF9iXLsa1QhjzYfmdax//hnwosc9JxEE/lmwqfIjShgyBskqov5J5CHCS?=
 =?us-ascii?Q?NsiOBkth5mDf8+m0udEFL3HY9tPpA9/FeUPPOs04HzhDNpvoEI3lJyisqOMK?=
 =?us-ascii?Q?sZdPK9RDwGBkG7JfvYYBK4UyOMEJvlUNElPhGrBk86+zVW9GS+aBwyMocjRD?=
 =?us-ascii?Q?KViPESpU9vf0PA+EtGPNznGM/Cv2V59traeHpoJ9iq2wH+1gcDqvvJAzBj5/?=
 =?us-ascii?Q?gCW4eXa9yzvmA/llpLWa5lt3dwPeAuR7tm8maZX+rSn4ce8+ftOuNln9U8yg?=
 =?us-ascii?Q?CiHWdTwDLTgY6Do0wgoPPpwzwC3GZCxSIFwgkXBQrPsINlRXZn/xK5qKKveJ?=
 =?us-ascii?Q?3sCpKnWIoI9tFyKOXHKV0T0+vd3HPInDFquckAcGjTVY8MouZXuVg2eIwJgu?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9f616a-9b07-434e-71f8-08de229b5f5c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 09:59:45.4052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nxr50aCraZr6XmDqOOP5zzjhNZCzPD6qcLMoKxMPj93rXlJrzpmKEhrU7HYfcDJbrf1G7OxPwkWhAJRVfmhVDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7530
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

