Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55689C61CE8
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 02:12:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 053E942E96;
	Fri, 13 Jun 2025 04:12:08 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013042.outbound.protection.outlook.com [40.107.159.42])
 by mails.dpdk.org (Postfix) with ESMTP id 20B8B42EA7
 for <dev@dpdk.org>; Fri, 13 Jun 2025 04:12:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0EGqBfhX9oqzZ+S5Ftp8qQwbfkunUg9Z1iN8lDtAKLE0BA7uu/KhxfE/r0a5RxTUFq+J849kPfUBioF2hFxmrcFS/cCYOsAZJe5QYSWvyLcjNt0I5aYmL/+3U7AxW5HMksClFL5NT2HIHHQ0PskRs6LjdcxjroxAkRagzEGB3BGDZ0P05EpBYhG8EZ68SZyv4YwWhzAwRgha7817Zn7TvZmDIsW+BWJBviVxZcYJY58LlRFSqtEv/YP+VBAcaRrmKAR1nZA7f5aJPLDEBemv1YWo5QHu0BeKO+446Tt+sBQOfwy8ns3lMRmp3Aw9VV9/dX7jZTA9YygY0uLsefblQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJ1MOMfiUcI1dxV/qhSdpHLcSM41jDNlcao7Cb2mEL8=;
 b=FuUSMoWopPBmW0//GKpPRo8PJxMKQxXHN6OngexzoxgUPboElr+fT53c5016y4pM38dSQh+dF6mVHPRXQj066+rtT6EnJgo8Oe3Iwx7MOJqYTVIshRXjIsmzXx2YTDyiIACEsQrA4MogZ8C7BU8W45oVpN/W1b84hEyyTiKH9LofNLudf8vjA9j20sYjREo73dNv5muPUJ+qcPWbA1I0/12OsJux4BQfsl/OA7vIzonXGSg3878+aaPVDZ14hLBnptW5kbYJtpWFHPIlWNPTjMTKD0AhNLsnD9dDDJpeIefUbMx3MWJXvk6NIWoRGVdXHcrkZPS4YubOvoc0w5JZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJ1MOMfiUcI1dxV/qhSdpHLcSM41jDNlcao7Cb2mEL8=;
 b=fYN656sydcU98dgMvZ8W4VAzhXQZnRXCYLms4kgwVelnuHcnX4erZmO723YEkFPMmbIz6nw8LD95AVVjiMqpjWwR9xxbb6Tshhqi4Y0Bw4BVWryhAMh4DLlCsYT3V/Xvi1Ov0KLjiTeBTPxJiVX9YFQ8cl5xp2YVUqjzzZk2kWi12Wt5eGoTxUjTW1tXj9AUMF132QD5/3+oNJ6o3qzWKQPFEAuK0J/dpkL0MwWpI168Qd1lFSqjMCfkn29DVDBzAe9EKhbP40Cp+YROYhWmrKT3vT6J7ICD1FQLYvWGMrA1Parwf5x4l6AC7/80L3Rt7p9hQXCzD34t54PIxmMiPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by DB8PR04MB6907.eurprd04.prod.outlook.com (2603:10a6:10:119::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 02:12:03 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 02:12:03 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v5 09/11] net/dpaa2: retrieve DPNI API version at init time
Date: Fri, 13 Jun 2025 07:41:23 +0530
Message-Id: <20250613021125.790614-10-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250613021125.790614-1-g.singh@nxp.com>
References: <20250611105149.655144-1-g.singh@nxp.com>
 <20250613021125.790614-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0124.apcprd03.prod.outlook.com
 (2603:1096:4:91::28) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|DB8PR04MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: eb964a12-3411-4fcc-e51c-08ddaa1fafd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OPLKT3dmvYmXZ5q1Mr2ptJ1gK5kXs4DJVjxANMFu0mClDF0iA44Ihf2bZLLA?=
 =?us-ascii?Q?v3mLB9MyJx8PcETusmZFXByAoPaBpLebzAM5/Zoi7CfafR7WYDKvE4Gk0Qs7?=
 =?us-ascii?Q?x5kc/rjzhJCL3pW0ipd4ciZfWwfOJIDobEV9UEfRn2Rl69X98dsAGmtC/4fW?=
 =?us-ascii?Q?7DJQgAmcqjBh4l3HVbU2AvfUupoxuyG4n4LsZgnl/LUdjGFxi3qFiMEAVV8q?=
 =?us-ascii?Q?SzjuzZ4A5YcQ6hxEQQZWRS3x4wj53KPQLf3wjN8Jaj+rfbcu28EUvVCSL5RV?=
 =?us-ascii?Q?/taR6VAf6zOpIUaDeBDya3sIdlaMvFYTaq2RUA8NyYWYlcx+MPyntYnCk8ck?=
 =?us-ascii?Q?ZKvqNJKLFXiUNm1MFjpnSol9bP0GtjbbqxvYW9nOGibjs6S9FRumCz1xGVIj?=
 =?us-ascii?Q?JmzS2kMQzagQukgdg3isQ4Pj64PRjk09XzI6GxRaEDs3roUmbwPuKrSNPG/7?=
 =?us-ascii?Q?hDxdXkveEWAmsuagILaA39ib3I3iraJ4duyqoBOti0Eb1DjJU1oWId1BCDCv?=
 =?us-ascii?Q?sycsyWQzj6cqsK4zAuzVJoQfk9e8s5NcY136XbV+0QFG+y8M8PRRpMAkSe9U?=
 =?us-ascii?Q?BYPkORVylPK5xQ8I30n/Rfs1scBsGR7d6FoUk7V1epp9YZINN6cux1NN9oRy?=
 =?us-ascii?Q?NV0GEdaLLJrXajtyP23oL3KQtxl3sZjv2rDIC8729CBFuiYad17n5VY1u+El?=
 =?us-ascii?Q?3O/KL+gr1+O/yzmuHo6dC9FobvqsG67vK+rtGdI4UyVNHwzu3VLBgyHqgo36?=
 =?us-ascii?Q?HyWI3bu4p9RkNTfS3X4OKT26rfDIG0WGM4bVjJZ/8dJc9ssGwWH+GzA1f4xw?=
 =?us-ascii?Q?1zHuLTtnli14p6pd1ihpICkXTjfyZRO0xpxd+3DJ/C3tXiB0CXDMZnKt5pNF?=
 =?us-ascii?Q?bZ+OwL32pObsXkNpuYqnIQiTxwOFsdrrUQ0H7jD64D/pfwKPvVl1AL9Kf57g?=
 =?us-ascii?Q?qDdQZ/lD5/nSBDQSbofqBrFn+QcXfA0/F3ZEksPy8AZOFxkzzAU7l3tuMiAG?=
 =?us-ascii?Q?HdRy5DWAh2OUERUpLQv1o8G6nEFLF38YPz1uRpRyBXxamDZu9qvvrrYf90qL?=
 =?us-ascii?Q?M/ithYTsQkykhLmpvgQwMNYKSQq7qnloI4OoSEZNsp5NBqEySiLfJxqQyfVD?=
 =?us-ascii?Q?TCiEg69cqcbvq0oH0cLLnCE3JmZf/bmcvODxnUMFDF8XBntGlwOQ+fmGSwMI?=
 =?us-ascii?Q?3NvX7y/HJZpOO4T4PLsQz/ghNZasu5Aod4Az0SPExYJyo11RDqixONTtD9Aw?=
 =?us-ascii?Q?TOnJ1Xp2IN88eWBYxHfl7hDBKjdkOyTbzqAMj5acfxPZ1+PLAUuKNJclVC37?=
 =?us-ascii?Q?+mpzATnCBdFuNfImya+HVZc2/16oe2plZx5o8gbxrWw0ZKOcXRBzwDUIPwCf?=
 =?us-ascii?Q?FupCzAKM9P6WqLI2mwvHHoMt/8XURo2dC8cnHohOdmas5kFBenwMyonep7pA?=
 =?us-ascii?Q?oRWnhKD+d8liGhtO3+XC4h69oLIamdIyL7WMf+ZOEgP75j0DvhcmcA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?414TK5LEjS8/faFQ7djprbF6hKd1AY+5LVCwbpa8ea+61u4xxnNbC6hKLeIk?=
 =?us-ascii?Q?zthj4BR6VjQUR2SKHyO15I86suoHLHwPGZ0yPBRmvkVf1DHPkvmZAUfB60E2?=
 =?us-ascii?Q?KtWyrpKZNtw9e/Va33/gkCc+siwRLJDBU92SgtKXDfNtlNdPC3Q9fcikZhUr?=
 =?us-ascii?Q?5n3DZhoVBBJUTZCPRNSWAd13K0v/GzNfWkW4N+/IEMlb9d1FnWFwffnNtpia?=
 =?us-ascii?Q?WduR6B95Pz8LzRazHUNeDCuzZ55JR4MYP7NNeSrLRe1Gx0Qg5wPW1L24aUJ5?=
 =?us-ascii?Q?lbrvz52/eYWgf7isPzObFZPyxjLDkLu1vHjZWGBgSwr6CRO0w0I46agyiqUw?=
 =?us-ascii?Q?mtvXIyYaveJTfgXA+PD/wxWLMs31waM7MalySkjdnK2pYEUsh6R6fD5iRoKu?=
 =?us-ascii?Q?+IqF3SnQPs+pfuYwHXwUgfnZWEjb2d4MCGmRdeW+lUAIL/XZNzzUgH5zdbjH?=
 =?us-ascii?Q?Jg6S6ISRRULvKPepNVofowX/CliOFs+ibOKsb8+5CbCxTQS8kHLfuewLA6pV?=
 =?us-ascii?Q?N9yqyuHqSZl8MEfgb46fx7mdQp1SGZtRMClVkC/eOZfGKx2Kfoac2NYNKYv6?=
 =?us-ascii?Q?/dXcribaWGTdb6O+c+0AQxIVHTjMNFL5yCIz9lngO7yICbWFO0hgjSWGLC3/?=
 =?us-ascii?Q?84h+GJdtT8PuwzAX7s3FIBa2RG84E6PLGlnRyseIo3XBedJ1s3NxD7oPhJ1G?=
 =?us-ascii?Q?oubxtx7mExfTeuW8Prcs63n6GPywINcrDCzg5E29W+EG4ErfBwAkLkFOgj4/?=
 =?us-ascii?Q?AJsRAFS/PD716l8zzWejWUeUpRU3yU3ksOnmsmKkveY63DQgEbsV5lllxhLE?=
 =?us-ascii?Q?SQNpy5qZwyMjhGQaeluV0vMSZvvQ28TA3KYzKb3C7pvMOwkB9VpoMKdHcP9U?=
 =?us-ascii?Q?cpUrNF2KhtPcsNCDaqDQ1E0U6KxnGhM4PP6KrLNWeH8RRFcaTcGYlueCvLUj?=
 =?us-ascii?Q?fhWCzP2TNliq2yc0s4hFbnkBtgvaJjLenUJKjFQEhuYwiCmytlJr5l5+cV1q?=
 =?us-ascii?Q?gICyTaUIivsu2wy7/11r3nzbL+46OUr9X3GmAOu3wCH24zhsNXcCMG79BTVi?=
 =?us-ascii?Q?SGQYALDZHz+8NVKqaGNF8jTaHO9B5eMzaRt4J1R7Gs4NPxieTlTbFl137NBU?=
 =?us-ascii?Q?PIag2QW7Oa3Oi2QkUDLoTIkFsun0PJNLYAwNk6n+T1mCnhvt36E5N2sEar8O?=
 =?us-ascii?Q?wFGOGGFKvEsFeom7HYXhP2TncRPFg/Sfb+jAYUJSV/DAoKU/aFGTNg+W5JJv?=
 =?us-ascii?Q?xTGJ52Fal2tn42FHeXhw+31mJn3k1hd0/wLX/DjT1+NJpYNpkJq10v3BfTG/?=
 =?us-ascii?Q?go4qZD8ihGYZQfZuh1ojnRaVahQq58HToBhNqOTNRejnJWkXJOBRJj9Oo5tf?=
 =?us-ascii?Q?7Sl/GUEP3zF5OWv5XvagfOLyGStb+GEYnRoW6hZfz4dRDQ4icTASZ3NwlR2h?=
 =?us-ascii?Q?m6bbkcVW6HzxXDgUUD+LB/MJ8T9m9kSu2K3u2XET5QaZcYIKRGc/UrfJqIh0?=
 =?us-ascii?Q?sXoyHTWXbwAzop9SzWra32uuKwV0X3/+2g6Hkwk47RSOq0jXvIUqTelkyeOc?=
 =?us-ascii?Q?ejN+lAIDKSGUrnjYuOA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb964a12-3411-4fcc-e51c-08ddaa1fafd8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 02:12:03.0982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hO9gWZmU6zYlUD12Gj0+p/15l/H9QLe2OLzcdW7qB0z3J2o2heueSfZkZtoIPFSB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6907
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

From: Ioana Ciornei <ioana.ciornei@nxp.com>

The list of availabla DPNI APIs depends on the DPNI API version
available on a system. Retrieve the API version in the init stage and
store it in the private structure so that it can be used at a later
stage.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .mailmap                         | 1 +
 drivers/net/dpaa2/dpaa2_ethdev.c | 8 ++++++++
 drivers/net/dpaa2/dpaa2_ethdev.h | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/.mailmap b/.mailmap
index 3dec1492aa..49aa2f08a3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -607,6 +607,7 @@ Ilya Maximets <i.maximets@ovn.org> <i.maximets@samsung.com>
 Ilya V. Matveychikov <matvejchikov@gmail.com>
 Ilyes Ben Hamouda <ilyes.ben_hamouda@6wind.com>
 Intiyaz Basha <intiyaz.basha@caviumnetworks.com>
+Ioana Ciornei <ioana.ciornei@nxp.com>
 Isaac Boukris <iboukris@gmail.com>
 Itamar Gozlan <igozlan@nvidia.com>
 Itsuro Oda <oda@valinux.co.jp>
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 298fded65e..b88c9d748a 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -2814,6 +2814,14 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		goto init_err;
 	}
 
+	ret = dpni_get_api_version(dpni_dev, CMD_PRI_LOW, &priv->dpni_ver_major,
+				   &priv->dpni_ver_minor);
+	if (ret) {
+		DPAA2_PMD_ERR("Failure in get dpni@%d API version, err code %d",
+			hw_id, ret);
+		goto init_err;
+	}
+
 	priv->num_rx_tc = attr.num_rx_tcs;
 	priv->num_tx_tc = attr.num_tx_tcs;
 	priv->qos_entries = attr.qos_entries;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 94de1024f8..526f88393c 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -398,6 +398,9 @@ struct dpaa2_dev_priv {
 	uint8_t max_cgs;
 	uint8_t cgid_in_use[MAX_RX_QUEUES];
 
+	uint16_t dpni_ver_major;
+	uint16_t dpni_ver_minor;
+
 	enum rte_dpaa2_dev_type ep_dev_type;   /**< Endpoint Device Type */
 	uint16_t ep_object_id;                 /**< Endpoint DPAA2 Object ID */
 	char ep_name[RTE_DEV_NAME_MAX_LEN];
-- 
2.25.1

