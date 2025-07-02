Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFDDC83013
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 09:52:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3937A40E11;
	Wed,  2 Jul 2025 11:52:09 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010043.outbound.protection.outlook.com [52.101.84.43])
 by mails.dpdk.org (Postfix) with ESMTP id 8994440B8C
 for <dev@dpdk.org>; Wed,  2 Jul 2025 11:52:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjRlbMPpUDiDHsDnMQL+wjkGEUzXb/fD0kmTP9tn2k5qAU/RzOCRJD1wTFSogi8YhDVCF3SCdmKkt25X3+6tDR793DKf+TgtqEpTE2xOFjJOuwNhcHj+iGTjtpKxP38PZZTFSH7G9SzgUW0FBfRY37uPWMbE5DetVeKG1swbJxg2jPQ2Tfdsp9Bme1FsoYF2tN74qE8zxEkK61wfT/IRmY/domDR+/KxugHsuDBlTyewYX98c4dTDiNdZuk89VqI/Mf7+gaUVEt1kfo2qcoLjRDGUkIUOMTFHG/3u66ZQ6rECi58KtLCI2RENX6I/SydC6/ffhZrq6d5DgCxfxBmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBXN8Rs3eY2eBHr3XT/NN9/RTge++5wG/gkxd/INkgA=;
 b=Xf9CH6UwmLgM7Hxvx2AByAkdvRTtHyRjwNCRQfrlNnfiGQlkZoF8i0nXrszs4YetXyU+c7o7IiHASmdQHVc0E1rmzTiNvTF7FqBv4x628l/qwXXL1BR6skuMeX0fh66F/ZiN6RKCHmIPvAVrwLMtsv/oqqRiwE9TDhQMuhXmdBFZ+ZWQQ8iIcHBi5MsXTBfcsqOG/0pyfomDNMc7TPOmkTJdaKyRcYA8Bm3FdRVkIn3tteVyIk7EFWvzAnCRSfaPCbiIHhBqA29ITefCWMfXFQyVxdDmV73MMN9VqVruhcmDP0aIiLsPKQY/yY7VJEtQ9VgkLeYjTKpRheq/spLtqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBXN8Rs3eY2eBHr3XT/NN9/RTge++5wG/gkxd/INkgA=;
 b=S93gwR80TGTblSQV14JHECxaWSx3aKu2PQ0OcGX4ZNp5P6Vxla57zpPEbrhipjpmn/xLtf61mrlehc/HVEEGH8Cofp4P0106a9Iig/8un74Rmu6oo1anFMvbwY0TMyt3hSk605iSPTXXTfMzwNW/s66wb+tU9f6w3K/1O8WBGfW/Qug4a2h4KZAigwAsnRAKAWlrJj3Q2owc2YF47FeqapUFdnlad3T4GEVfJuDa2GJCMPXVHeav6HiUXC5p7WiyGw8Dpt7oaAORfX4d4wN+57jkQvenCvtU0SsO070z8ufYzg9pq4RdBtyF+pm3ETdLUiOgEl0CPBrP2NFpYZw48g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PAXPR04MB8473.eurprd04.prod.outlook.com (2603:10a6:102:1dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 09:52:06 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 09:52:06 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v8 4/5] net/dpaa2: retrieve DPNI API version at init time
Date: Wed,  2 Jul 2025 15:21:43 +0530
Message-Id: <20250702095144.3087250-5-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250702095144.3087250-1-g.singh@nxp.com>
References: <20250701042917.3000355-1-g.singh@nxp.com>
 <20250702095144.3087250-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::13) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|PAXPR04MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb9ed4d-fd38-4a61-feca-08ddb94e1a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qXzwiZ29sScW1RQ77igTdlApGoz0+SE7vMElcoXFNZeHwZrHtzPMvcsUyGoC?=
 =?us-ascii?Q?pOyltq/CVEXqTNfoi9YC/iErxHa/0BKhgPc8KrOkV7jSW0DZ45rkHklbWMiG?=
 =?us-ascii?Q?2lbI0bLthD02stoZpeIUWat2Y23IXwC1TX79ar1fyNsIAdokxum4Jfk6bW58?=
 =?us-ascii?Q?j1hn5Kpb/hjtYy+b9wrCRBR67Fk/tDCmpqBFDjTxohrsOmenkODy9H1KZm+9?=
 =?us-ascii?Q?Ag9L0iAHebKTkdYOKvU5FpSi5KrGUkIR8ZGjzOTxmIKri32eje1MTzVkMXyZ?=
 =?us-ascii?Q?Guq7Cogxo4iBdu+DhROWZIb+mTGPUNSGuLghg2SedPfLlbj+LVUXu71vTiTn?=
 =?us-ascii?Q?mz1TnMXGT3JkcqhmjSyrHFegIAOB9iWg5JYkXdNENfh2qsUzkF7lBE6MMW2s?=
 =?us-ascii?Q?SVEfcsUbwFia+Q/0hcoICaKy6H2mEzchIOr6zTDU3Upkh0AMTlJvr3H3ftKd?=
 =?us-ascii?Q?ycfsybCrSot5N5YWfGKfdnoh82EvqBlivoKGaqfmis3V4P9HPC5p2CuQB9bI?=
 =?us-ascii?Q?lwZ09mIt9b6fr+dNN+07PYno/aoZm67sZqK5ucBjoe5weCwSI9me+Ywbq8Sp?=
 =?us-ascii?Q?TzOL0X6dMyjxFDjENHCacjAHDV0ojIH0n0GKS6AAO8uc8kmq3sokE1TXBwyH?=
 =?us-ascii?Q?H4+QlxPQJM0grkNpLaNc3r3olDOT4IcjaYegAdeHIOMsas0Uar61IahSCZQQ?=
 =?us-ascii?Q?sqZNn7aCjG0Ju385Uy6g0qxMSnM2KwkGu0Jjmyxshfyn2kasl6bcOIAsHx2f?=
 =?us-ascii?Q?THo2E8B2kkjZp4Q4rJLkJzhLcX7Fk26w141MEdAqaaTVP8ZnovfLz0KwoGgO?=
 =?us-ascii?Q?GdtpfUvlgFbaY3ZHyvwxfeMo7ftoIvlZCjxQGL8aaEmR+h6T80YknHuDviEl?=
 =?us-ascii?Q?+N3Pi5Z9hM36eBwRWt2Aj+MCw4wt0NCi4xCkDJ2dLIj1y2A5pdum6YytzLhV?=
 =?us-ascii?Q?kck7wrHXFp+YFXTGLvBBK/5tw6Iw0iOcuoB5GAQ7gGRq3x5hqO2utbUJaMkj?=
 =?us-ascii?Q?1SokSU4Zp1mejHFw3hdCoPQJCEAvGE2imYYrosFXcre5LYliyDpGdrBSNhkh?=
 =?us-ascii?Q?ewWYWbvHmryFYPcwjKPASYeMgTFO3bhNikTmyWP+dW5nzCq9UypGCsInmIjt?=
 =?us-ascii?Q?dYK2rtPJyCz7XEuVJM0WQheNUvSqjK967/0Hs7iSPBS0f2pkuMoGKr9yOQtw?=
 =?us-ascii?Q?ITDM1cSm1PGbpUtWnj7rHziN2I+0YWmbclzgl8ZDqAPmrBb/3slA+/WIlTvz?=
 =?us-ascii?Q?mSNYBO0CVZoMpYT0xXtWpt/YWexsn+bngkf4SFXwo9+H4jR2zQYlsi9bz8zV?=
 =?us-ascii?Q?MtqU9b+DLTOWsJShuJn+CoOFmEmGH7sKm3DVmbSbxqZrIvijeKtsl5wr40An?=
 =?us-ascii?Q?prHYhXrHWbxo0SMgrpuGvHj/SGzCbmGGlew94H2gpEa1gSJBKY1RUvyNLna5?=
 =?us-ascii?Q?eGHxnJbA2Xbb4Vk/95Hn9lSU5blRTjXLLExrK/6dtuOXFv9YnApHu/5XFXYj?=
 =?us-ascii?Q?+2wQZhvsjTPIN6g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JaztiY+FV2jMmTvz5YVFgS2WvToPUze3QBXMI8U2uNSMPCW8L/ueBmFvbODh?=
 =?us-ascii?Q?PhfKSR1ctiR4CloMNQOr35Qztpe9ZTpPstmof7Wsq85p1fdrim/L6pq8b4Mw?=
 =?us-ascii?Q?R7ywstA9OObutxCAZ9Q6g+LUsjitfJlDIkZcwzQRUp7Jme3G5ELyOkJaQ56f?=
 =?us-ascii?Q?nH2DZK8evkMddz1BdYJHQSJec8chLzxXhXumuYwufy6/ZVxnwsjr+SPMP0hb?=
 =?us-ascii?Q?LgqGUq+/nCNRY6/zTvjMVU67p3lWsMNeFA6Z2cyfiMEROiygqdlTsZPh7DYR?=
 =?us-ascii?Q?8RGzt0xjahwwSVaYntUXI6nP24al0XSgwdtPj35CimjmkZlB9InflujwBBtd?=
 =?us-ascii?Q?9GZ6uV4s7yaFxydlBtSWOG3BQ8QvJJ3g+ksx9TgG4ZmT1ajI01aGXHvsDl+O?=
 =?us-ascii?Q?P3IceEuJc//GdmSoSr+mkIv5miRj8v6eZUyDSkS4hXj4G/tGVItrqxgqL1hX?=
 =?us-ascii?Q?6R0hxwOR7RF6FWCRsbE97SGVEioQAysyHXEavz0YlBwm+kYac+TACIz9JtyF?=
 =?us-ascii?Q?CkNHPgsI3v+fqzpKbRZVHFAGDtIOvIWGNIb1IuJmjv15Muzzm9mLwptCFP4G?=
 =?us-ascii?Q?Y9VkDfRuDEYHFrBPWsYNNwQU6ZaYgjBobQR+hZ1snf9Rwe4VNo1/TTJti/mF?=
 =?us-ascii?Q?WX77XPNi3ROxxkkwbnXvS0zPZ/mASEZHNULeQUO/RwlpEhMC4/37bcA8euJ2?=
 =?us-ascii?Q?aMQZbb7RkO1CvMNSoAuYYQyly8oao2JtZ81fvoH71hnN9NEAVoeDtN6/4ehV?=
 =?us-ascii?Q?p5kkjBFdQnT0yraRwH5IlIPjFnEyH5/IGJajJzJiU8P/1/jRTz0XXd+U3hqw?=
 =?us-ascii?Q?dE9C9xyYQacSKt2GnFwNrSjDxwQ6PV5EeduFEl0cFPiNaCCjTpV1Z7fzcCY8?=
 =?us-ascii?Q?ipHmisPmBl/9/WnGN+YdlGMlUAU+O531YxpK+df4K3sK7EzxQKZWRmzOJAWL?=
 =?us-ascii?Q?rfJbT8/MzG3fx/Z7dornUAJmCg6GwQsOZhCYhjEMGRvVrEMM8RLvFgwNK8mI?=
 =?us-ascii?Q?OOsia6dwZyUs5tnc1UH/s3ZDGjlDloix3xYy2d7D/Ak43O7kBWcWNF+//xsX?=
 =?us-ascii?Q?OL469j56XXN6Ft/VEjFxEt761t4cWbXaaJ3Z461BOW/1R7keyzjkSCv2hm5Z?=
 =?us-ascii?Q?qzSu7a81dlgqo5D8PCqdwPwEr/kJE/ToejA+JkrdmggMwrRIhi7uX4EjAzZV?=
 =?us-ascii?Q?bbgdzOxkQc4b5r2fSYdk07AE+o2ef6My7bvAJ2huU+tFWePnn1EGPtUp7VCy?=
 =?us-ascii?Q?UYMAKH5WoAwmik6l+I45rHv/Pnm9tglbY62/YPFJWYvOvTgHhktSWev4SEbb?=
 =?us-ascii?Q?EwC6lJh5WfTmRdV6pDrZMrtPIWyLG0sdVq6n1txcL/+Gc3dsDlxBX2tT2nGD?=
 =?us-ascii?Q?s9v85aygS+umosjHian4tlKErXVvIVy8BXcAXl+J83GC1rhbCU4WvELksrRv?=
 =?us-ascii?Q?EIAgwic9SVpjN5v+JrOkl+A3HKnQWLe/FIN0+bM1LB5HTcziUzDiQKyYgdu6?=
 =?us-ascii?Q?Lw+3vZXLuzchxK4xcfSo8TSpFpAXTujvi6gdwg+XJ1dfXNh0F9BBC3pt/5Ku?=
 =?us-ascii?Q?2KrJqQwYcRKhNSI0s30=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb9ed4d-fd38-4a61-feca-08ddb94e1a8c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:52:06.3239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76BORgwyFya0ld3dWZydo3LX3ry2lQJvaljsK/3nbDoo7pkKXRkC/7jZsI9tLNCz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8473
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
index 8e898e303e..741c14426c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -611,6 +611,7 @@ Ilya Maximets <i.maximets@ovn.org> <i.maximets@samsung.com>
 Ilya V. Matveychikov <matvejchikov@gmail.com>
 Ilyes Ben Hamouda <ilyes.ben_hamouda@6wind.com>
 Intiyaz Basha <intiyaz.basha@caviumnetworks.com>
+Ioana Ciornei <ioana.ciornei@nxp.com>
 Isaac Boukris <iboukris@gmail.com>
 Itamar Gozlan <igozlan@nvidia.com>
 Itsuro Oda <oda@valinux.co.jp>
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 1d11847d76..384f72d663 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -2658,6 +2658,14 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
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
index b501fc091a..ffc9ebadb8 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -392,6 +392,9 @@ struct dpaa2_dev_priv {
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

