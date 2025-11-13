Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00460CD5BCE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 11:44:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E314340E43;
	Thu, 13 Nov 2025 12:44:21 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013001.outbound.protection.outlook.com
 [52.101.83.1]) by mails.dpdk.org (Postfix) with ESMTP id 6808840E2D
 for <dev@dpdk.org>; Thu, 13 Nov 2025 12:44:20 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLtZErNtkuQqJGkLgyhOQnktrF9eswVMkBTg7wmRQdbsu7NpAwuYqBA9S30y/F90D/JQyVuCzLSDKOv4pWyCuFSA5ugFr9toxqGqqMij+Ypyn91feeY90M8PoL6ABU4Cfm2KToccCdmwKsmta2/3NNy/PlDUMKIOWfmqVYSW9ZwCEEiA4/xJzk4PJNQYuuLVasvEETm2c0GjhmhY1iC34faL3DRru1yw4lodlnE3M3uNeW0rH/7euvnECRN18aCHNNgoTabqiPJkinPiQ1/QQ59/37xRPG/Th+AuMb7/ZbxHAuBVuQii1CXp5JVJN2Rz9qPAgHAUN7DSrqSnW9R/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVzGGkXr0PQwqsbCmb/AAyJFt+A1zBgwl1YgQ0vGrCU=;
 b=DMRUKyLG2mI0hhV0L4EYMDzMZJ2C2kOsxx83eMmna7XSB7c95u2mZivaK+DOaeS/lw7oqrbvJ+hCpKpIV04SVr0iCIqJ3t9wG1gZql0iPHSQkFxYQQwqhKsLpSQfCy+KS8eU+m+2TfBB9UlMTtGRbllBZBWdAnqFqiOCy4q/Ai2SHj6uiapv4lNxdCWGWV7t6D23gCARtLxONzInI7rukQhHA9XxMbvX2y1VVhd0Xg39hws/dkFimd9Pob7wPaNtvvLM1JYsoPLi+i00ovbV5eu/ofAQSfe1g9jI2tgmFQPV0Z2gpJ4zuS/UJxolI5o8Wp0kOxO4Hsu92Lyww3DyXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVzGGkXr0PQwqsbCmb/AAyJFt+A1zBgwl1YgQ0vGrCU=;
 b=C9nFOLWgFlKYnTKdrcBzl10Zbn0iNPV20B8euem7vNRK4WTNhUfZhFJuxqE6fZ9UGfMStywZf+I6Qv1rm/05AGvL50dunj+NtlY1CyJ0juMnkx/4rKX1pf23kv7/bw8cwKNP9//pFCdbKbzJrKLzkVXI6ICOhyK31/HBW/1CMAuad8L9IBAfH3WZCg5wo9CRwjKyrR3tgK893krdP9W4KhB/+KIAFiUTJ/JI++brmVPGYLbZFPl3Hkrb+368XK9K96SsZA893Qf4wMwhSbF9N/JJonLvxoaEyXjlmEwoaSfIkDnAUTrjzKRN6JxtnHkehYwywXU9Unld8Vwcfnxg6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by DB8PR04MB7035.eurprd04.prod.outlook.com (2603:10a6:10:127::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 11:44:19 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 11:44:18 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org, stephen@networkplumber.org, david.marchand@redhat.com,
 maxime@leroys.fr
Subject: [PATCH v4 4/4] bus/fslmc: add support for hotplug of dpni
Date: Thu, 13 Nov 2025 17:13:55 +0530
Message-Id: <20251113114355.2027438-4-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251113114355.2027438-1-hemant.agrawal@nxp.com>
References: <20251113095917.1973514-1-hemant.agrawal@nxp.com>
 <20251113114355.2027438-1-hemant.agrawal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|DB8PR04MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1cf259-04a3-4f64-a935-08de22a9fab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iACtRtXRf+LvEchsLjYxtpRAo8Y/Etfrb0OrvicgxeGlRjLyRLB68dIFH9nE?=
 =?us-ascii?Q?/xTI8jBoXjk+hcM+VzR50M1xZNjnYY192WduxzzZLARE9e9FPQFCRSlaWKBS?=
 =?us-ascii?Q?mrulpFMaZV+YTB/6oy8Ekjj6OetLhCHR+hS30b+MwmsH/hgJeVI+edZDOuUq?=
 =?us-ascii?Q?I33F80PyKe7X/2lFWc68i/um2ixODnSNOyYtuCmRDKU4x5Vmr8zWvc77d1pJ?=
 =?us-ascii?Q?9mAEQZgBNi7eEHp6R9i4Sz1SjG8TAFWj7WVE5fBPJDY0xT8wjw8nmgaf52cB?=
 =?us-ascii?Q?R/d4EeRDT4nvuiV3XxRW/dn5mJOYPeCSlEEFufJGhH+ZT48N7OO2l6mYxcPP?=
 =?us-ascii?Q?ZHWP6OJDVYUADIHHb6V428V8ckYck5VO+PO9JQhvBw2dBVUkeEfJGRteAPdJ?=
 =?us-ascii?Q?6GP5o8YPAZE653vk78HdJQS6W4IFc2K/OEw3odF4RN7RTK+QrqFavVa9Ili+?=
 =?us-ascii?Q?WNMCGlp8GBT/QFPTCK1hFGUjA7/2KR9FSNLGnW68MWirjoKQnjtg9MZlI645?=
 =?us-ascii?Q?n+n0YDmxQfSBKH/sJmLuUrDVMgnXqttXs59t40kEW1Clws8ROpqFZngpuBZq?=
 =?us-ascii?Q?uHnGKbL+Zj/RW994qtZWXisvcmCmWS4OA4Ixnjk4qugGy0G5d4ai/EVH6M0G?=
 =?us-ascii?Q?RWqHl9o/k0q5lJrld3HTqvFMxfeaxozGP2tYZv+svg0pKrUv5FXh4ONM9Y8X?=
 =?us-ascii?Q?2tS/VkKiAE9sfPNy317wM8mof4jhWLydYnlMAw0xODUtbhx9Ry14vP6q6473?=
 =?us-ascii?Q?VUkC7fyA7eK6L7Dz+6k+GTogDsZ9mKASGYVcbTgJ9HlDpRvsAxQph1k0uHYS?=
 =?us-ascii?Q?zrKzXHksoDYqrOLD4xqyBQfZ62BDpXyWN1PQ6vJfppY5qTNGrQjf4aMFDJZL?=
 =?us-ascii?Q?P3NcHaKWFniYxcC0Pjs5k7Z66qpDyU1hWoUnDJ761PLW2syPz7etLTe/TCLt?=
 =?us-ascii?Q?neBlUlc93Pp8W7bzAJKhcC1piAMyYRqWMLc/n93Nz7iAY/75JuuRczlRMHYv?=
 =?us-ascii?Q?Pc59kyzxFe0MCxoTv/NxOvxHYvEt2EvGg6Pc6tCF8Me/aG3GnajiJHhNQP5Y?=
 =?us-ascii?Q?KK1SrzJfGtpDksu/p7CRiLc0TL2Qxa32ejgpBIjEZ7wO/zW+ZEyGDPnPE+WG?=
 =?us-ascii?Q?5QHx3YUyIbIMqqa2JQakI3DE9fxbH9jqto2DbVCM+SrqHU03733NaDCRDmm7?=
 =?us-ascii?Q?EtmkieYGNpQasu7WdCvTxxDm/O03uI1eJDHueY7D788gHWLvCD4mUIEZ5D5G?=
 =?us-ascii?Q?5L/mQ4TtEfs+XUrZrDbNcOl55OIKu4BWb0kQb5Ur40qbIdVjAHjuFz8s9grn?=
 =?us-ascii?Q?woGGZ1XICN5qPEf9PIoyIJzNbMNUXvcXOIqwNAHTX8lbvbeL+wkAFa/E/TYc?=
 =?us-ascii?Q?Bgdp7CdtT9gIFChyI1rjohWPUWw+gfYVvfbx03Hg6ZcL0iqgoFe0eHhLF2+D?=
 =?us-ascii?Q?x82lBW5VLb/3rB2SxEr0Uuk5LJF00HMw7HWRnCly8OTS7VFZxsVK0sbBwyI/?=
 =?us-ascii?Q?7FnHQOQ4vSE0+wNdrNAP6Y09rH2u7YVtQ6Cd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VsyOodG7zsR0ijTSk/U9fg5lZmaMxD+63bDCBoEIuwTTlvq9dOSo561HbL+P?=
 =?us-ascii?Q?J/a5R7y5V7MgJDHPZXsfQNI2cywMwgWG7evBufb02O9BeA8BqTT4+08C2nqM?=
 =?us-ascii?Q?32yw+BMWodDyUcYeWp2KNJo10EjI3Hr590fl6v3fXabl/ZKfJ273dSKpQcFN?=
 =?us-ascii?Q?Z8Gxx+fQlvTO1zUE9WRVXNZIydVnrmCAebcR6Vbn2lbWDajvQ6k93KZkAbKq?=
 =?us-ascii?Q?dH5xpIe6vGQ0sXU3Jhj/iLGDifCsVhm2W6Rksg3yp9eDdpV9vCH+8Qg5p/hu?=
 =?us-ascii?Q?6V1k3ceCM56bHYyl3aLXK62vwvV256GhcJyJwIU1pRKe8+KaLqp6Q5O7LyM6?=
 =?us-ascii?Q?YFb4gel0jXovAz5p7MWMzYNuIGuaDbvSzAyKjTS2peIbwq9ZbgmvFdmHo1cu?=
 =?us-ascii?Q?JEEP8ySoBH/pSzICzgnSFJGxdX+vLJXzCp99XdowRRL1N60P8E1BG52LnuAl?=
 =?us-ascii?Q?FP1pV4mDvCkl6JeAxz21XjKfnMrIBR19niuX+WtnYE6zNOdFAqS39bxxlfXf?=
 =?us-ascii?Q?8cpzsxoPb5XmFJ/ZPue4Fq2X9947zSn5Xe+DQzkOl4yV/AWvzhFKY013JNlv?=
 =?us-ascii?Q?AwqUTho4UBc49NYGqMC1erHUArXPKNaPSEIivMcBMf3yuMEhMLdY0XcoVerP?=
 =?us-ascii?Q?abv3DlbvZtU3mvTUx+vpiNegNdeVYAvFHrTDmpLTkxTgkD/I1aLZ73duXAT2?=
 =?us-ascii?Q?JVoEAJLb+DHVFLuRfCIYSH3Yzr0zIF//Q8W1E7cuaHZHmPJotAMvCWRS5IMp?=
 =?us-ascii?Q?iiYZVvptHxeXW9/zRlzzB+dNuHseCewOXKAozF4vrpI/zThYEDWikTwVpxqu?=
 =?us-ascii?Q?uJtLVcBMjrYgIi0xZ2GJ+Rxdz8KJN0MoKNeDfQzlY+UFEO8UxAadjQgQ9Cdn?=
 =?us-ascii?Q?wuoQOzzh54HsRRxjxuhbnGkL7+shgOA/vKzokw+Vh53UQLFM48jubONog3bi?=
 =?us-ascii?Q?kNYVrfeNf/kRJsLuAa0q2PB2h/xPP+HGWLrMh3foqCjgySXELSozvDFeJzV6?=
 =?us-ascii?Q?DkXg50Ws6/doJeH6nDeIqgGI7JNX77MbM5O37xEGpfq2D9ffrGhQ5E10mVVX?=
 =?us-ascii?Q?nbgQNNy6deON3Fut8JldDKHHXae7yL06J0PAQ8T230FlOEuPMRvCInHzW36W?=
 =?us-ascii?Q?1kbbitt1TjnjEp2EhLxMfXjoh91qq1+hodS9tHqBl9/Sl7j4AqXM7Rbdrhhl?=
 =?us-ascii?Q?ugEClC1l32yL+nN/iMJz8hTTypOy239bkrB+SycUVyh2XlCeZkHYYThOYF3B?=
 =?us-ascii?Q?UG9Jy1By0xjgAqkkyxS30YG7PDQIVc2WRwRT4bPDH30USLZhJNDEiboW986B?=
 =?us-ascii?Q?tttrrNCbtR84zGzv6ciEw49JPaTLEsAj5VFyxn76sED+L4sun9wficeWt8Co?=
 =?us-ascii?Q?XKpVdQVef14VkZ06GuFbTMXZPQbP4gVZz99rQuSIPTrgv9FJJvx4uHrfPknh?=
 =?us-ascii?Q?G6wS0Y5GuKeT5bogN0daizCpR4WLgrHX46l1eFGuFtK0miEq8dy3yOIkcwT3?=
 =?us-ascii?Q?9XdFmoYo/urE30tK+kpt5gDaATo+rYOL3gqRHH8y5qXzCzGnE/gysNZqTz7D?=
 =?us-ascii?Q?aC/HJZtUIcLdTIhHyy/30gXLxRGZTlCrKdHARe+x+3R3PP7O/ln9k767EqYQ?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1cf259-04a3-4f64-a935-08de22a9fab4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:44:18.8223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSVSw/b1N2eLolfWLOEUepc39EbsYYvuL772w0s7OdPMuxh5RJB5ckqd2j551py/yh8P04RD5cTLZhDNW7GWPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7035
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

