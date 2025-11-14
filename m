Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A6CCDE011
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 06:25:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8B5840EDD;
	Fri, 14 Nov 2025 07:25:35 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
 by mails.dpdk.org (Postfix) with ESMTP id 1F25C40B8F
 for <dev@dpdk.org>; Fri, 14 Nov 2025 07:25:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6rKthgtSsv19s3Jn0BYjuH16571lrASXo3BK/W9TpNq9Z0ipLn6Mw+Iw8rBSc1PaCaY7UYAWGrYtG51GcdVw6If0vGBnNrXHEWKSIKMt4yHhJBIf6SpTzjY4x7OVI5v7nYvctFd6TgMDM/kVkW4Skrljner/IaOn5N3VQKfYbG328QTNM3pr5F+CsasEkmCJmdaL/7GJDAPnGrRtRBORrATHj62ICfPMJMmYXQ1C24EPx2z4xmXF7e5uqpD7qBJcS2UgFbBbkghXJwZT6LZznvazsFfXPvpAkrS8n34so123qRCLhi5qoK5wJov1yorGbaSyAY1P/LYUKgJW/QFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ioaudv6qEvcYJU+yXqNjF9s7BWmBO29oC66QV5K0d4=;
 b=T8pgjjvcxjc7xfliMEMK1e1zIqyW2aCspgr+NGEYbpN5++pFP7FTok5eytZQN6l9zb3ij5hBvhb36HmTO29GLiV8wMobNYuezSxVrr1K3fw8vOQbMiF2ARotB3oY7RJif/Ggvi108axQx4CkcWp/72GW6xllBoIpHjVBD4gwHxafWmsA7vGeD5WXaBlV9lc+OQPpnU7HLoili29/csdU+1hOkiEx94hCbzXxbFTchXV1iYJlyYkkIql4prRpYl6LsiQTbI2E/3p0KmvYBBliGSXJjaPzV7McT5CyYTkrAkaCwgZUJg965g/AoVwm+7TIGLpfsyoX01KPJXeCEpR+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ioaudv6qEvcYJU+yXqNjF9s7BWmBO29oC66QV5K0d4=;
 b=FGKYpUDFA513gzLrrFD4j1/xfxc0Tp2Pp7EbDLU6/YgTr067rAA39v0kq7M+7kvadJavfARQNYy4XztfpNvPMGAkR+er0eNPqtvLxowRGJPPT5wry2gZFoP1xjjkC6j7G/b/z2wbjAFEnCpww5M8PLDWxKkFB8c/x5BrUfnUsi/movwXUU7Mrlvvhcequ0LhaQm6e1l0XSUJ8koEjSLaHbaVyW9LTPHx9XKdGC7KZY0tXPJgA8AEtJPLeNYLx6HoCyOoZjtsgiFQKh95fRV1nByAv4DRB3qAC7MIvL99i5Ykdt4PU4qkpr/BBFrKHYW5xhYscSdz3wIBl9ahPxHTaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by GVXPR04MB11067.eurprd04.prod.outlook.com (2603:10a6:150:21a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 06:25:16 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 06:25:16 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org, stephen@networkplumber.org, david.marchand@redhat.com,
 maxime@leroys.fr
Subject: [PATCH v5 4/4] bus/fslmc: add support for hotplug of dpni
Date: Fri, 14 Nov 2025 11:54:54 +0530
Message-Id: <20251114062454.2731559-4-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251114062454.2731559-1-hemant.agrawal@nxp.com>
References: <20251113114355.2027438-1-hemant.agrawal@nxp.com>
 <20251114062454.2731559-1-hemant.agrawal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|GVXPR04MB11067:EE_
X-MS-Office365-Filtering-Correlation-Id: b610c6dd-6cb6-4dcf-3fb4-08de23469349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IzJfqt65FPbesafCivNRn1CTJoX8v1lfG7frXp2EcGymm52zNzjBMq5K5u8Y?=
 =?us-ascii?Q?U8QTQKPdjavi/whAmAsAfz3O9LQ/SsSwAOMHuhtz+sLxxEQ2GHc21X1Lsvoc?=
 =?us-ascii?Q?gcn1SON6FpnRp93cgEUmf2G3acS5ZGKdW44hfu3kJhD2UKfGSwBtnuHgE00y?=
 =?us-ascii?Q?/0gto3B7ebEEYuRXP6MXhcCBebCVE8uKA65ayhR0xA0/VStnUIArhfs9r9yy?=
 =?us-ascii?Q?VMOX80o2CUiYz974pLIu4Aeauh4ssa/bGzH4QIFARh4Q5NR7Kle0luFqzsaq?=
 =?us-ascii?Q?tcbxOPLbNms+CV/7Nv7Xm8F/Aw4XKMAylIuNwZi6cIC2LTtjGzZeXk2TaVnv?=
 =?us-ascii?Q?L3F62FeLtl59fDK7ehBMzQTXmaDZpSQm0b5m3t4j5FA9sVcUfI3OM/w7MeBJ?=
 =?us-ascii?Q?nPRgs6zfFyzYnEHN7qN28tsO+y/sNRf3v6iu7R1CjXIdzeeAB/u64ACYr/n9?=
 =?us-ascii?Q?NC9TVHbHQIB/Rn5DbSSXOQRlMo/6ASpNdVYg6dNKFIDqljaVWxM2OLgAz95K?=
 =?us-ascii?Q?IE4urRbefV+jh/TNFz0boToi56R45Ig3V2INfpvo2shcu8wx2c9Fjun6jquJ?=
 =?us-ascii?Q?tJZVHLM0Jx2zLXZiJHRd78Q39xv71A3iVV1NtD2BA+5MiOQyYTn7T+OfZAA1?=
 =?us-ascii?Q?TrmxRBunKUAV8A41+J1acHgq0sLqcxAIVvEvVXC5ehJr6VpD3rkz06Se6Kfa?=
 =?us-ascii?Q?IOvoGQoAS26cRZXKfQBWWQwgH7TnFPYI8WgPDrDjEhDlJkX0JhLBdaBSDNoV?=
 =?us-ascii?Q?Wn62ePMwCp+dbhQCVBOp5/r7viulYuOU8Jjg2PN//hL8m3I5QrK8dAHfhJrQ?=
 =?us-ascii?Q?4tSbcEyxlCjVXkpmBsJ+BRwhyaHJvRukSfFYk1WeAL8ONxpG5+5x4InXDmGL?=
 =?us-ascii?Q?AZ7VQpHHSR5GiD6GD0XSRHbsvGDi74HjtTzESsR+I/zNLSwPIxQ24YrXs9FK?=
 =?us-ascii?Q?dzN8dPHc5twjgiB78PkTYqvmqAG59+5+xj/x0lfOddyGj2LZaRS5c0Vh/0+h?=
 =?us-ascii?Q?85aHdWIm7B7PzyfCL5ZjhEHoujddFtogr6XV4654vIQHWxQcAuH4jdBjvHwV?=
 =?us-ascii?Q?47zjpiYo6k1ybZQz5Y9XIY8DWXSLcM9qRLEKHahR69WOBppOmPZ6TGWN/jVf?=
 =?us-ascii?Q?6YN3cd40Sy5M6ulkcMKz2fIGnco5lsARkFm8zghQElLCQcNcDs/Y4WCY2jf9?=
 =?us-ascii?Q?1+gnaMVV8VlrQNYNTVVbzlA3G9kZudj7Os9PTT/RT3+NwguOt4T6EsC6GCsL?=
 =?us-ascii?Q?BbJQZpbHb7efiTgUotJlZw8+7lMuccCuJeFRUXqnAQxCVczLVYVbF7ijq7+f?=
 =?us-ascii?Q?7X3P8cGwa7HvP9uozoVCCvwoBa2eHdKcEKDBQoP1T4X75g3gdrQjuSfawpH+?=
 =?us-ascii?Q?2AZaJuNFF7aC5upPKyh2pe9slD1r5xO/3PdWjWHnzm5p/88DhlzbY8OwPEAJ?=
 =?us-ascii?Q?9n1sd+FLF/jzdbSLfCktPJEQtVUrQmoa4m6kn6NSzGNhR6J3s6Qy09v2QWnP?=
 =?us-ascii?Q?SmiFll9qlUdPM0quoRKQV92/dsWz1HlbOgVR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ELTG9xm6HAG2O8Iy/t5meU260cqWGilHKcE2hPnvZkkd1zWzIXJjiGwtBQoI?=
 =?us-ascii?Q?VQQigCLsUpBq3/j/tsoNDrxEDBt21/SlcCG2cFsWNYdAR70y6VCFkF7UfXDK?=
 =?us-ascii?Q?aSmoDGPtxLJ1CtgyqK6UAJBRq8eEGs8OZoZiS8QHrGDknvFkUf/DKTY0t7lQ?=
 =?us-ascii?Q?mwun0hOFnkDcyFO5xFPyyOKIPhNmkYmHNxi8+Lq7Pc9cXV8DzJa8YI7P2tF+?=
 =?us-ascii?Q?dtcp/Vhe4jihX2Lh8iE/ba/yjJsrvMHS0lSuKXHBrqqCSIxlqrOqItURiMsL?=
 =?us-ascii?Q?Zw5t/A6OuRimaQpOFP0bbg6Gu4wmslZXn3th4iW5OiAyipmG2nFRbb+ktaMg?=
 =?us-ascii?Q?NklGVGAxw7JDjGL8A54WVkJTB97tn+DGZCiATLetRT8DJ5GXq6BGbePTxYoY?=
 =?us-ascii?Q?HtdfD1dtnju1zfNK55LTWsQdWZPJAUPdRV9WlbY7BQ/+JatMM+tHm9enl742?=
 =?us-ascii?Q?4FDx25vo5+OThkVShrZA6b8RbpcXeepWJSYv+eI9/ez4U9Y6dLoJn2bFKNDw?=
 =?us-ascii?Q?4vDUQuNxWFkwStwvKKynd40r59IaAP6A5sZ6PmARXD8xy0G/ySfxr9sfVp+w?=
 =?us-ascii?Q?puQiympB4t7pMtbrCWxe/fu+SLDyVZzb67o4GnGSCBA7xzkSth+0RsAN3hRR?=
 =?us-ascii?Q?yDPmUVMEu5idyq7H0cG5kZHfSKHa5eRnsWc+f47DKcNlZQ/BmaLns9E2ZKDt?=
 =?us-ascii?Q?Pl7iwoWbbVXvwbtkVa8EaWuHb6GUzVwPXCABhOkgoGlaHJkWMOnhM/Pi36Ru?=
 =?us-ascii?Q?1NUFjNAMEw0aMuwJRk0sxblIsu8VheJ4Lc8GtolSxDNkOuXX6q7OHynrpOYZ?=
 =?us-ascii?Q?zP5YwjfCnXeCMMiUomN5RR6DoZ27w0M0EEcBEd4iw6JYdVfYqO9zlp+5rFgm?=
 =?us-ascii?Q?do34L25GcZNIX3JxFk6I5P/M7FZnyu9NzWLM1ePAyduG5yytP6AsONRCzjbu?=
 =?us-ascii?Q?DITd7XJWnPW6+gGGY+WSb2H2jwi+l77dbyvnMjWkJ/GhgiJIAEThgg1UVX+r?=
 =?us-ascii?Q?aQ57LkOau+PNivXu6R9JqPh7Doe2LHDK9umVlcIzGFO8BCIqJ3ymyWO3yXtV?=
 =?us-ascii?Q?XaBIWhNx2c17ODfUi/HHvdKorKjr4TCVV/wO4OjMjcXCnvDHvBmdL3/P9nAR?=
 =?us-ascii?Q?vomWC4e9VssBmvMtKMkkRXqSvuIDAZUQ/tffJfic4Akg/GLxOR7EgubnBeoe?=
 =?us-ascii?Q?4LeijP+QZn2wrW8fU5e1MY1PZ7GO6+UhiIGpJKDAJDAOBfzIoBkJEKWH40IV?=
 =?us-ascii?Q?cLVP4KxRoP5xIf5CnchJDjyGz1korFhkVVru67aAJ7x2rQY4kQAx2wpZciYH?=
 =?us-ascii?Q?E4Qi91pWoVoor2obJ8TFDGcjTraqePblriImJZZ0J5MGbpAJjggJFpw3fYDb?=
 =?us-ascii?Q?bhuyfY6yHLTreazAA0BzY7TH84L4xiZ7zbgQfcgG8qs7OuN1jF0oX4LEk++b?=
 =?us-ascii?Q?eXj6WHKQyckGc1JWaRpMpMj4fXRyNixGiTuD/TM2VLdKMj6VObEzsvvpWSxo?=
 =?us-ascii?Q?aR4ymeIPs/44dyJS9WHRs/oX1VPd5dbcOoBBCM6muLIqGmW1cSml5i3V2tOw?=
 =?us-ascii?Q?6YGXekRWNrvFgIs93bImTRl6WFbImN3CkRCUAlSCzY6uuaaYTQVBOZCJO5Rq?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b610c6dd-6cb6-4dcf-3fb4-08de23469349
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 06:25:16.0822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muIhg1C/SFqEttZ8Z+HhbNZ+6KWU5aNXuFAuQ6x/zpXtFvMYyG3+/Vo98mq1/6kHQijHqWDwyA7Yx5Ctze5ndg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11067
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
Tested-by: Maxime Leroy <maxime@leroys.fr>
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

