Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D91CD4F2F
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 05:30:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D88940E6E;
	Thu, 13 Nov 2025 06:30:05 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011055.outbound.protection.outlook.com
 [40.107.130.55]) by mails.dpdk.org (Postfix) with ESMTP id DD2AE40C35
 for <dev@dpdk.org>; Thu, 13 Nov 2025 06:30:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BoDlAaJAHS2VYSlQB79vQSMWkqkRLgu2NA/G/teXU1M42WbYaCPRbhTuLXjqOc6+9vhWQp6ZgUN8VA7s9GbLSJFwRoJFwRhLqYrQZ9IdrIacDRLzczxLvbZ6+DoV12UNGSlJNuqQeMBFBmiCgVtgC4a3UZQh1Sy6uB4UIdP0dIQtZ0KQKzl3i6GPBX63IYdD8iCKsHcPCf4qYFJZJ5R3lgoRd/CT+8peUAq61Cjbz3tXC9YxRpT/GFgHgfuuEuYCMsvfWaIx5B13dF+uR7fRz0V3UE3EHQQkPRep2lKXKT4m6NzL6hR/iGXYsH71JagbU3zLBVC+LBsGGbcADr/LyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVzGGkXr0PQwqsbCmb/AAyJFt+A1zBgwl1YgQ0vGrCU=;
 b=EIvWqSyppqLVnVs0XThcZibcuin9opp6EZROzbC84UkBKGhYYuGHlxK58qU8gzsntp76IzYHlSp9hiU/eA+Jq+aRgPTRpVCdcXArENJ4ZtATqR8eBdiB8JAN9maMsnZdGexkdO/YWT8k9XdrsmLMQwj6y0Gdse2gJcYS3h7j7otAaeVUkUVi5MwF4smtz4mrDZXqmbvWKJC6Vb5gw/PI9CUtza/nLHXEh+NTa8hm40l/ct9VnXY9S0Y211uUuVddqk7G8Hy3UhoqqJM9vxKAZ0RZHjJVekP7mXwqJRkk53C3GL5iQZQdgjDE5vPQwXqdv476ZGR4Q0aMuRI5O8/Ocw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVzGGkXr0PQwqsbCmb/AAyJFt+A1zBgwl1YgQ0vGrCU=;
 b=J1wQ42GIje+tgNSamXe9OvrIJsQMyEYnv33YJaCdncc4UlbEMThsUkDjRnBADnkj3lzV6Wc+JhMZKc3Gy2p591dZzkZ/lquPTwOZGiPk/MiG9rXORAGCiy/FIZkx/i/7RQ2Ti3uY+0BLZVx22xchXqcxc+s+lHscwXB+CHUAaZYNV2fADjKQo1UHywfcPZ96IYAyXxcX+ikimOcNm45F5zC1zxGMdSNZT1vVA7T6hqe+UG9rLMvDODlsoZ/98glrZqdRd3nmO3WaHlXoHKkYjhFz9jP5tLTPHJ4XyKCwcYTn8pkBh2a/Uw1rNO4gyT2OaIkPNW9KVGgqHRq1YD5ISA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by PR3PR04MB7355.eurprd04.prod.outlook.com (2603:10a6:102:8f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 05:30:02 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 05:30:02 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org, stephen@networkplumber.org, david.marchand@redhat.com,
 maxime@leroys.fr
Subject: [PATCH v2 5/5] bus/fslmc: add support for hotplug of dpni
Date: Thu, 13 Nov 2025 10:59:31 +0530
Message-Id: <20251113052931.1784953-5-hemant.agrawal@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3257fbf5-dd50-418a-f527-08de2275b1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wPU3QAUQMngCciyPZrUDmWHZjb86cgJK+RZIKrdboNelb+9XQfQC8J4YysDv?=
 =?us-ascii?Q?ziEAmztRM8oyPliTmTs8wWJHoJ820aZCpTOFxNjTmhyrr6/fHx8EIoBYiGL0?=
 =?us-ascii?Q?9YfhGaB1eIU0qgCdzq7DROzJSKAafn3fuD9gacq5qpvS09+Gjfk5EumhcIJO?=
 =?us-ascii?Q?xG8NSZGa+4wQ5pjP7OUKReuDSm6iaHVoZm9KdjFAcz4nZfheXmM0Ko7DzGiS?=
 =?us-ascii?Q?pAm0kn9WATDbN6evpt24n0iQOn9FL3PDEZg/JuURI5n2KLEaNPmTkZugug1R?=
 =?us-ascii?Q?jURzx+2u9LqVbZdqonluJ1aMktfGwtkY7wpYyFrvyHwWkLz9ZmGQKqoVcjeM?=
 =?us-ascii?Q?8YQZn2v4RsniIg2Zv6p8JHIrRMkFW17W11s+m934cd2ECNECt/dKIwKnm4ET?=
 =?us-ascii?Q?GB0cVhF0Cs9KsxTLo/fzu+gs7uPqh0qcliAAwAw9DiTREqj6zG0q7fRtAe3a?=
 =?us-ascii?Q?goXlr/tUXM1U01bpLwpB5Ivnpfs3epZjO5oObKvyiXEP99TPcLJGp31nVIqG?=
 =?us-ascii?Q?geXGFlFY6r3UsEaIC0xyfLz8TSZtMVy8d8X2o15SvMSLHkS2cII0109xeZOJ?=
 =?us-ascii?Q?fdbtJxpyzxDhWkPiXsSbE9/+v3HvwwOGaSeNtBJOuiFPdpVY9OIRmMzZc/DK?=
 =?us-ascii?Q?21R1ApDn4Eo+ZAZJnfu20OoeeEKowSmOm7wLVU1nG5aFDczJegz48nPCn/36?=
 =?us-ascii?Q?0tv95Ph62pv1VI9Bt2bbFGPLi/JfJ/MffPjql/yENkwJd/twtMGZOvW9+Z3I?=
 =?us-ascii?Q?ZVCbqDWFgvhFpo6BmK/AMSyfce3nRXLJoA/VWGQNtQV8NxDej1bfbtHR/M39?=
 =?us-ascii?Q?usB2tu2wp3nFun7ti89YWLHRCoVcGez42m84Sa08vdRgss1zjVz35fizFPWd?=
 =?us-ascii?Q?DLaSY2pbRdvKdLe/QvfwZUqWRmDBR8pa9G5bRKD0EdlLHlI8JmXkEwErx9Jd?=
 =?us-ascii?Q?TB88AYMTLlpABvuzEZMnzJ+WHcambXFe7WqgDzhUG8NYulImrom1RzEtOyKb?=
 =?us-ascii?Q?G3N/hIzhWt3I1LMlNygtcx9yghUa8bwyffh/wrxA8kC71mhI2ZiJMzDdWSev?=
 =?us-ascii?Q?0+tAMNdAxvwXYeBEgnaApRdS/bnB5QV6dHRxtxJGmsX2HGr+zo0pi7b/8yF5?=
 =?us-ascii?Q?GmSUmwUWZlrGOvBFOrfBGkWrahP7cOF/tauAMrMxZJxYbSg/9eGIOnokL63M?=
 =?us-ascii?Q?HevIdlsJy/GfzCSWYfbnhMMc5HpgCfNlo5CoI2K9tKThwiVhAec8kmDHRCEJ?=
 =?us-ascii?Q?PT4jNgWzWRKo1MtMi1OuisJh+8OErnnJoQs/RNuPlg1IDZTHpb+6VycxkpZN?=
 =?us-ascii?Q?z9SouG7M/vqf1fvpWSUBEFGZPx/5PZ4hke0K6l4yyAgBfdzd7zv1DhQ6fJJC?=
 =?us-ascii?Q?I2LJl84AwZARdnTV74OcAE/rflHBxLY5ySNoVlDW/ykNuF2WjuaZiaRHXmqv?=
 =?us-ascii?Q?v5ovs1R5PKk0hK/3zy/EseluzZw9y2MGZsIOLeyIqwdajl7FblYROtId/r7Y?=
 =?us-ascii?Q?Red64Cap2jF+6w5rzKA73JFYM9Oo/MDzfeiV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QVKuhf0pJ4XcND6kyGAI8WenmgfETmlZ/+B9CTCMg2Lyj6EGMNWDZK4UVzdN?=
 =?us-ascii?Q?DmF0Na+IbZs8xx0p6bnZpaNksjOOeGV2xaYA71ltp2FuGQ+sfQEpei1zTqYe?=
 =?us-ascii?Q?iQQ7J/nfpBq6NxT/+h5MRRF3S+yl4tSTpHgZ8iQPCxzMN270RLZKndCoNye0?=
 =?us-ascii?Q?ezdP0RPs4xT7bXbpixwDV7I1s1xokQlQnis3HUEmBG156lKZJRK1pKrLuz4u?=
 =?us-ascii?Q?9jGafxrvBhe6h/yAAiUpqA/24oym9kTfXfPLhPHJmraI/6x23zSagzRpRV7D?=
 =?us-ascii?Q?GpKXbxt37Yfzb6VfM/ArvQE9Ga+7lcbXrg5orQQMLN0JrKqkHbJ/nhKgSOw3?=
 =?us-ascii?Q?HKZ/HAQrB9hisLmtPmCIjsJz7CobXrUWOGA23s6ZtKPXdb/RyksJ7ebh8CIZ?=
 =?us-ascii?Q?y/10+HbTBBe9vkgw8vqryJZFm1VZbFaBID/WXSnCD4HkhK82XalVDKboIAOK?=
 =?us-ascii?Q?2wgpoMP7XwzQlRvhP/dTnqTogUrB+rwxd9tZlELdVk1J3K9JXf9eCmu9t4Cd?=
 =?us-ascii?Q?kcw5EDiFgjPdmMNryzADEtktRID8zrt9+7ShOZDBPk5o0WB7V6n1uI+8nKEu?=
 =?us-ascii?Q?b8NgFzagn62O7TPmPwQyPWEnU8wNAoI0pXLDKQSrVAS9Bfxoozs8+KKBXEyp?=
 =?us-ascii?Q?QRZ0stlcf4eVfsh0IcCPH/zC5XAknGVqhGozD9c6LGdrxF0oaM+rEibJ5lI1?=
 =?us-ascii?Q?62Q1/X6o2kgSQqzg+1cnTrBehJ6NAF2qPNs4/Rc+9x9PBJ4UMEYg5VJh3lKf?=
 =?us-ascii?Q?MPhrXsF+Rd9DtiVWopAx6uW2I9qfN5ht790yZ4OXstTspfiwRJmYcI89RXAq?=
 =?us-ascii?Q?uBxV/9BVA4A+EuSQ5r0L3R5SeFuHstmg8b4KWSiJ4VMjR5CmSPifq85QQPzV?=
 =?us-ascii?Q?UgrRYxtp7l5ug1R0xw17T2egEwoq6W2y6K51rXg4PhaM9UeGVz35qoAn/Vn3?=
 =?us-ascii?Q?GbE3yWSVYHjuipmZ7iUlt+yJNDhfdzGgfewRZ6n0w3sZQJc0gF6NfrSCYu/y?=
 =?us-ascii?Q?r4apmUZqJWe9NZ2WKRRIfBkECuqNtZrYIFpzsmRaD/vu/dFadAZ5nxq8Gv7f?=
 =?us-ascii?Q?zmYBDIBT+OLgG24xbGYLgLJw09p7kq3lgGfB3XZ7TC4yr471pLdY788g+jJo?=
 =?us-ascii?Q?BGKzateXjC2Wnybblz4fWiijQRoSXzKZppoL8YtTouoxKw+IKIblJcDyV2ic?=
 =?us-ascii?Q?3E7N0Uo8fgwBXHMP5vxLdD+z3mlQXgrt6CLsAsXiS5B9wWNhh8s3VQzmCENu?=
 =?us-ascii?Q?Yw7cEV23bA+BgwkpB/76v4y1aJbjzQxecXQhcJag8KNleFbgAijatgN57Ihm?=
 =?us-ascii?Q?4V1+j+vLnqINF1NxXkrFsFxo15/wQraBIS5CNczu7Q4zxat1y2Zn0z93/CNF?=
 =?us-ascii?Q?XdVSbAild7sLN3dltk0Ph7MLFZ9r7xQ6cdNB3SxctBnPWvv3uQH9PSPFWbw6?=
 =?us-ascii?Q?cWljcTvayM0mzLAdw+w5wIwA2/1GbiZknQKjyi1E3u9Geo+2fxY/qPQ6jbft?=
 =?us-ascii?Q?zZFTYRu/Hpi25IvtB1slta0+WUK5lCtDTldGJKgkD5o8zFCsfb1ewkPZqOAo?=
 =?us-ascii?Q?ulivxi4RilgeIIpCpbGPzik7JNMam83AVeu7evA48qu3sTYSiLXPeceZawvR?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3257fbf5-dd50-418a-f527-08de2275b1c2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 05:30:02.4694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiqHf3hN+8+0l19lm5pyqDTnaXM8Fk7zkoznrfFSPmXDLmYTiQIdNOjHqQOjOIKK/APu8ZHsluJGC3pGpXFfDw==
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

