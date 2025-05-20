Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40847C3ABDD
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 05:52:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF5BB40664;
	Tue, 20 May 2025 07:52:08 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013054.outbound.protection.outlook.com [40.107.159.54])
 by mails.dpdk.org (Postfix) with ESMTP id 286A040673
 for <dev@dpdk.org>; Tue, 20 May 2025 07:52:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsk2iccJaJGRWsceflhejGzspR6V+EuF3wDdCPaYSByz4To6teVOzuL304k2NxnxxiksYzrqI9hd1wO7Z2MPfPA/SAOlzjON/XzZ5aXAvIvNahJU1eQlzI/rdlpxRLPP2A8BmBG+rtvW6r21iIs/CkuvK2yy5+CG3dK2DIKcQWHHThl5mhQg/DnfkWreOqwHa6R1CF/Yexp42aYysgcIXbFjp0FmZaGpTd2Q8HKqNgThTyG0A/gbANxQKcq+z8NgxBLmG601NubqH5igdfNUStO3OPHxRtnqOZGh6Pvgz5f24Tm5KYDX7ICOYjVjRQLFoCU+NkLnF6O6svZ3r0xbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZ7rlVGD3huwm94UrOzspS9z9/bkITwFoF3us7zVdkI=;
 b=lmj3UTgaXRdFzhD9mFh57v+Xml13idEhbaUpqidsqK9zinvYTt5roI2SFLkdYpi/3ggnKH2bl/dnkIPEiv2tI+Mfcyiy0OWutLVlo7VVYYugT2SXwJ0Gx/ElyPa0ueeQaKKSA69A71X7qlh9Nucr0xkEuSJcMKzIVI08xDVHNJutAyBCcXH6BMZtwKxFU4RB1tVFclUpv5D6O5ivS3fbUJh+UrBc9sL5dC2xBPq3bg+tEl50SJNpGASIVZo+XoqRqr0VTCeeedMuHqegVaImrMp5TFgEXDnyZvepGKdvY0J51UaUXLUldBew4g8PbKJVVi80NyN2t7HStigTJNFKMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ7rlVGD3huwm94UrOzspS9z9/bkITwFoF3us7zVdkI=;
 b=VTGBKa525tk71Ds9j9eMfCSdcAqHDTF/36mStrezjBqHvvZ18MsZvQ2znrMPj53IwQjRnl0G9wTo9ifs36v5T8WXUMxmVxv7ksahcDGKEE1d84xhnVqXTSEdInGx0SFJB7df+hu7jm1ORTWh9DuMPRk/NX0Zg5fWS/bx2NDgRjXBh3UeY1UicbshECC4L+SNGXfYk1O120aUhtKrIkMB335NN/yQeJWuWo9qhFftbvtEbJheRjQy85LfimNt2rPjvnc4f1L4S+si0+6XZDBM2jirPHb/WgF7Lf7J+n49TfjZ2G9Eek3KU7HO+lwOWyY+Xo98BL+/JbKd0Fnf+cAGYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM9PR04MB8617.eurprd04.prod.outlook.com (2603:10a6:20b:438::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 20 May
 2025 05:52:06 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%6]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 05:52:06 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 4/9] crypto/dpaa2_sec: change custom device API to standard
Date: Tue, 20 May 2025 11:21:28 +0530
Message-Id: <20250520055133.506071-4-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250520055133.506071-1-g.singh@nxp.com>
References: <20250520055133.506071-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AM9PR04MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: de7f38a3-e856-4b06-7ca9-08dd976273b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YX5n2blOTp6QrOxJWl6wcVirTA2tae8+Bh4KClDvRkULdjUQbsw1TT7hsAbr?=
 =?us-ascii?Q?AOXoW1zPVk+TCwzVlftiqHxIU/+qKaJupJXn4biQZiN/3h9PUopIwBHdAvR3?=
 =?us-ascii?Q?CbEmf8fwTj7Dg/48+yhRCnLmX/qbIpfGjVqER+1hd47baPh2s1Lr2N8LbEVv?=
 =?us-ascii?Q?6+jKoI4eiIHHhbzHJGO8VlvJWhdIah4kE3FY9nPlbuZH4hDRguOA469V56aS?=
 =?us-ascii?Q?xz75LV9uwoq1BokVg9pKXVh8FIkWBIB1w8yruVUVZRGJYcqB71Dmyqz+XGQf?=
 =?us-ascii?Q?aQJsN4M5udo0ys/q1XbzSMMnx6qvU22VLMjnvOYuXTL32BRb0KD4/lRluCp8?=
 =?us-ascii?Q?HtVBqoz51VuKDU19OnfFIS8ludQpYa4s4e0PGR8GOK+wqBuKlrO7bOpaZAe1?=
 =?us-ascii?Q?Up7eYewP8Zm+SeZuR8B/nnUDV+39JQMZxyP3eWyFkqMGLg+eJticePuTBzq8?=
 =?us-ascii?Q?yVLKfy3iojIQEi8scfSf1NxiBt8pI3ZDy1vl4UJCbjZZtg4cWjyRLtYuUgA5?=
 =?us-ascii?Q?esEFW7blFubpakQ1I6JdjJLpAx+A2TAdBY+bZ+mhk9BfBNIa0TkAq27ucSfP?=
 =?us-ascii?Q?OTuqbjZzr+IZbnQD7AK7prjSWXttWx76FYfGMBsM7zx/YOQQNc3WxJT0l1YP?=
 =?us-ascii?Q?ButzA7rHGjD0uhTOqw0RPAHZ1N6k/a1+5gVwpjHWmPMXEt11n1p+J6pXIsh/?=
 =?us-ascii?Q?Hj/j/vtvizeHWMkMb4fRtd04V/Koy5HYomajMf1NbrSAbrSwv1aFqlXR32sY?=
 =?us-ascii?Q?bwMUAnnrYoO0o84NAoBdBMZ7D3MQu9rLTBAxY3FJrn/8Xl9UdUc6NqgtaAPx?=
 =?us-ascii?Q?UmfLBL3wbn2zQ2bTybTjTj1Vc7Wz0pBeVc4/TFZ8EgqbdnsecEgISATAsb5H?=
 =?us-ascii?Q?s3qFkJXXmrUv+PD1TLSSGAOxILQHU/b+0UWHZqVMRopSGN2hZqkru7dmdr6y?=
 =?us-ascii?Q?oq+J+7pXezGEtyWL51QVGDme105wCCC/+E+vdbO7aabTGFZeaw64VBrPZf8C?=
 =?us-ascii?Q?7zChrwMgALqmJQWN22iYBuHI/529yUkSDJnHO4dJpEL4K7QnNj0QLZ9o2+Rs?=
 =?us-ascii?Q?ne60KsGBOz8rC+a0D+Iiz43zoRhMu1gRdZQBnE9rztjkS4uC/UdGtamNVQHB?=
 =?us-ascii?Q?5RtFPWUddwQX3wQk3VKlv16lADLDGVU1YP6/xV35o1VpqMWwVkkgj8hDUDgm?=
 =?us-ascii?Q?TvpAP4xHxmxU/YGYpwluf5prier40L9vMUwTX/x0CeEmuPPh/RER38P6iqTz?=
 =?us-ascii?Q?4M5jitmaVBgwQHkkKzQNUA0nwzevqtDyNJIAtT8QbTkrmsGDcRWgO3otYPm8?=
 =?us-ascii?Q?EEqYIIphnTYfgMX8b396tdPBDN6F8TzCk/sErja9btOYewQ66okg0hxwafaW?=
 =?us-ascii?Q?zDfhTdyzEiAO5a4NacRuXi6aRkXd92CvWDooIkFGBXO5lhjt5c5IV5Q1mlWI?=
 =?us-ascii?Q?j5yGFdUg6t4UGyW87lk5nFtJW34cMRyAwk44BBFDuttJb1JNVwhbIg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PbrYb4RAKVkPuMujrv3oMPYn2kjAnSJd0xr5+YQ5Ow8mb/wuaDvPv0YPrCod?=
 =?us-ascii?Q?bSS3Ht92kwxqg2XKaQCnW24HpNpKl3qtY6AGHzvxZGpK4up1wMZzv6OWezmc?=
 =?us-ascii?Q?J+FAxhvddRH/50fFfRK9Gn9EMKz8m/OT45axC08qPzsLMfLDAlvddzlcwEKP?=
 =?us-ascii?Q?43N94XR3fNDGKumiSGUeSB0yUQ9XljMVxyUqlcLfRuVjlO18LNQnrdZOz1IY?=
 =?us-ascii?Q?YlyqjybEywM9ORfO2EiESFIukxyyDu0Sq4x9NjaduZFtWEwDKd6USjXrS6Tk?=
 =?us-ascii?Q?esbVRZJVZBauuoKgJZOCWxrZHFz9ZY2Tp37EW+O8pBbmwDuqyt77YgbFsIWz?=
 =?us-ascii?Q?12m2uxswi5moSjwT9OJi315mmF01Azp83MZccZvN8NV3qqKpMWxGkD3Tbc+p?=
 =?us-ascii?Q?ryxxdkr2eMwQpG/8NkJZRh5OLnqlkXbaBhNnoaoAIhbRSMcA58iDLXxjc6xR?=
 =?us-ascii?Q?LAOKB/KyBe3TvtzcSGp+o9/Qgjc35Q+aoIPln8VsOoU4kdUvfr9P7hbz7KRb?=
 =?us-ascii?Q?vtBbPPWgxhXcTtthEghcU7hUaLNYDZ3ioMBSwRpdQqKsPZG0QwxTyiqsAwqO?=
 =?us-ascii?Q?uUO5f+JsISk1oLAG9MZEsUzxN+MRxwXbntas02Dz7kwTb4UfowM6BHs88HL3?=
 =?us-ascii?Q?R8Pw6H2eA3XrItDZBHapqKOgxw6yn0VEkWZXLYQGS6+b/EF23Anm4Bp1KCE/?=
 =?us-ascii?Q?qBS+wqSF87bk29ioB0xkvWeLYeQA2o6fUKcFIK81453dQWqFJoqcO2URuaAy?=
 =?us-ascii?Q?fA4FoogN+24Voha7ALGA7vgX3NOIVcctMIrZRkh21Xzhm1jaBOE7MdaohqpO?=
 =?us-ascii?Q?78S7UnHNMdvS4CnQU+bsHMLfdSFvS8Hn9I2dz61telJidRcOPREFYMC1Gt7c?=
 =?us-ascii?Q?+s7r3ojYjRV1ZesNv2MePGYtlneWpGYUdQdhn6AIHl21v8UjhkrENInSthDB?=
 =?us-ascii?Q?R2Cwgdeho45DiKkBQykunIG/N1HBW7O3m0jrqdyziUWnNW+yBx0EtSVpavns?=
 =?us-ascii?Q?CkKPssBGz1qgLN8tgndgaaH4cXIMHaqEM4pFAtAuck3vpj3voZA17TeSOVqr?=
 =?us-ascii?Q?G8wS2CFl7JLlppfAGthZ5mdmAZWfahWc6osc3B38h5kH5iK8GXv2Dq50sIE8?=
 =?us-ascii?Q?+H6E/Qd/kRzCMo8sRTayei00a+Lwx9G7GZr+TI+/+9MxJ4lqwITd6XAcaeJK?=
 =?us-ascii?Q?+xhBLQbViC5bmduAxsFMOKnHF31pbWYAReE3psBW8tDHXVIdNtFDzUvZzWYt?=
 =?us-ascii?Q?nAzz8ckV469OE/XVSKVIAJ1A4DzSTm8Gay3FEceML92pNd93UL0lRdgXA5e4?=
 =?us-ascii?Q?iSheTvSZEUcNHIumFTYMzZt7S9tNjEGN2lIna5aK2jiCV4dHJbq7wlrlvFyD?=
 =?us-ascii?Q?3XXq/kewsj0exsN42DyMR+NF4cnr5JdCAUc+SQsiAELpjoz245Vmhrsu1l+5?=
 =?us-ascii?Q?5HvCtpCygz9Bk5UF4efjPD/FaYGOfJ4X+lcYnXEnAPS0KnRmcmARxjXRvHxM?=
 =?us-ascii?Q?fwkMcyaiHfZfnJDvwZke3/0WkajBxB6Tip0UT+AfBQLb8/qUoG0HZ9YuJZAq?=
 =?us-ascii?Q?9fkNlCpka96Fdpe6coQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7f38a3-e856-4b06-7ca9-08dd976273b2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 05:52:06.1996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKGlq3WjNGeknvahsX24HUn0Dpz8K7avUgUm6NmpUi9dqHK62EqUuc7rtLdr0HE8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8617
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

Replacing existing device creation and deletion code in probe and
remove functions with rte_cryptodev_pmd_create() and
rte_cryptodev_pmd_destroy() APIs provided by the DPDK library,
simplifying drivers initialization and teardown.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 38 +++++++------------
 drivers/crypto/dpaa_sec/dpaa_sec.c          | 42 +++++++--------------
 2 files changed, 27 insertions(+), 53 deletions(-)

diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 0ccadecff4..925d2709d2 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2023 NXP
+ *   Copyright 2016-2025 NXP
  *
  */
 
@@ -4413,33 +4413,27 @@ cryptodev_dpaa2_sec_probe(struct rte_dpaa2_driver *dpaa2_drv __rte_unused,
 {
 	struct rte_cryptodev *cryptodev;
 	char cryptodev_name[RTE_CRYPTODEV_NAME_MAX_LEN];
-
 	int retval;
+	struct rte_cryptodev_pmd_init_params init_params = {
+		.name = "",
+		.private_data_size = sizeof(struct dpaa2_sec_dev_private),
+		.socket_id = rte_socket_id(),
+		.max_nb_queue_pairs =
+			RTE_CRYPTODEV_PMD_DEFAULT_MAX_NB_QUEUE_PAIRS,
+			/* setting default, will be updated in init. */
+	};
 
 	snprintf(cryptodev_name, sizeof(cryptodev_name), "dpsec-%d",
 			dpaa2_dev->object_id);
 
-	cryptodev = rte_cryptodev_pmd_allocate(cryptodev_name, rte_socket_id());
-	if (cryptodev == NULL)
+	cryptodev = rte_cryptodev_pmd_create(cryptodev_name, &dpaa2_dev->device,
+			&init_params);
+	if (cryptodev == NULL) {
+		DPAA2_SEC_ERR("failed to create cryptodev vdev");
 		return -ENOMEM;
-
-	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
-		cryptodev->data->dev_private = rte_zmalloc_socket(
-					"cryptodev private structure",
-					sizeof(struct dpaa2_sec_dev_private),
-					RTE_CACHE_LINE_SIZE,
-					rte_socket_id());
-
-		if (cryptodev->data->dev_private == NULL)
-			rte_panic("Cannot allocate memzone for private "
-				  "device data");
 	}
 
 	dpaa2_dev->cryptodev = cryptodev;
-	cryptodev->device = &dpaa2_dev->device;
-
-	/* init user callbacks */
-	TAILQ_INIT(&(cryptodev->link_intr_cbs));
 
 	if (dpaa2_svr_family == SVR_LX2160A)
 		rta_set_sec_era(RTA_SEC_ERA_10);
@@ -4454,11 +4448,7 @@ cryptodev_dpaa2_sec_probe(struct rte_dpaa2_driver *dpaa2_drv __rte_unused,
 		rte_cryptodev_pmd_probing_finish(cryptodev);
 		return 0;
 	}
-
-	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
-		rte_free(cryptodev->data->dev_private);
-
-	cryptodev->attached = RTE_CRYPTODEV_DETACHED;
+	rte_cryptodev_pmd_destroy(cryptodev);
 
 	return -ENXIO;
 }
diff --git a/drivers/crypto/dpaa_sec/dpaa_sec.c b/drivers/crypto/dpaa_sec/dpaa_sec.c
index bcea4ff3ab..58d691d8a6 100644
--- a/drivers/crypto/dpaa_sec/dpaa_sec.c
+++ b/drivers/crypto/dpaa_sec/dpaa_sec.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2017-2024 NXP
+ *   Copyright 2017-2025 NXP
  *
  */
 
@@ -3614,16 +3614,10 @@ static const struct rte_security_ops dpaa_sec_security_ops = {
 static int
 dpaa_sec_uninit(struct rte_cryptodev *dev)
 {
-	struct dpaa_sec_dev_private *internals;
-
 	if (dev == NULL)
 		return -ENODEV;
 
-	internals = dev->data->dev_private;
 	rte_free(dev->security_ctx);
-
-	rte_free(internals);
-
 	DPAA_SEC_INFO("Closing DPAA_SEC device %s on numa socket %u",
 		      dev->data->name, rte_socket_id());
 
@@ -3780,33 +3774,26 @@ cryptodev_dpaa_sec_probe(struct rte_dpaa_driver *dpaa_drv __rte_unused,
 {
 	struct rte_cryptodev *cryptodev;
 	char cryptodev_name[RTE_CRYPTODEV_NAME_MAX_LEN];
-
 	int retval;
+	struct rte_cryptodev_pmd_init_params init_params = {
+		.name = "",
+		.private_data_size = sizeof(struct dpaa_sec_dev_private),
+		.socket_id = rte_socket_id(),
+		.max_nb_queue_pairs =
+			RTE_DPAA_MAX_NB_SEC_QPS,
+	};
 
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return 0;
 
 	snprintf(cryptodev_name, sizeof(cryptodev_name), "%s", dpaa_dev->name);
 
-	cryptodev = rte_cryptodev_pmd_allocate(cryptodev_name, rte_socket_id());
-	if (cryptodev == NULL)
+	cryptodev = rte_cryptodev_pmd_create(cryptodev_name, &dpaa_dev->device, &init_params);
+	if (cryptodev == NULL) {
+		DPAA_SEC_ERR("failed to create cryptodev vdev");
 		return -ENOMEM;
-
-	cryptodev->data->dev_private = rte_zmalloc_socket(
-				"cryptodev private structure",
-				sizeof(struct dpaa_sec_dev_private),
-				RTE_CACHE_LINE_SIZE,
-				rte_socket_id());
-
-	if (cryptodev->data->dev_private == NULL)
-		rte_panic("Cannot allocate memzone for private "
-				"device data");
-
+	}
 	dpaa_dev->crypto_dev = cryptodev;
-	cryptodev->device = &dpaa_dev->device;
-
-	/* init user callbacks */
-	TAILQ_INIT(&(cryptodev->link_intr_cbs));
 
 	/* if sec device version is not configured */
 	if (!rta_get_sec_era()) {
@@ -3841,10 +3828,7 @@ cryptodev_dpaa_sec_probe(struct rte_dpaa_driver *dpaa_drv __rte_unused,
 
 	retval = -ENXIO;
 out:
-	/* In case of error, cleanup is done */
-	rte_free(cryptodev->data->dev_private);
-
-	rte_cryptodev_pmd_release_device(cryptodev);
+	rte_cryptodev_pmd_destroy(cryptodev);
 
 	return retval;
 }
-- 
2.25.1

