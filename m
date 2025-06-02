Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B2BC5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 10:41:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D3E54067C;
	Mon,  2 Jun 2025 12:41:18 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013055.outbound.protection.outlook.com [52.101.72.55])
 by mails.dpdk.org (Postfix) with ESMTP id 62F554066E
 for <dev@dpdk.org>; Mon,  2 Jun 2025 12:41:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmeSh4VfTj2x8xOBKGBJ76nRBn2zUei5GXMRxz2hdk26QHNGXWyt4SjZBWDyh0rJZOKNBSCHQTsXhGxH7KBLJ0QwQQkEG9k0N4Q50EvVxihX1+c+Pre7VFlnZa7Brv/l4RDSgsv3vy8hulZ9fppEoB8PLU/hNbE1VTyfHENg3/Qt3H6lt/f0Plt/2QCiNzRHXrPY1RtYEsm4iLda8YICEhpknqkFG1aOWIWU/fE8qfbbWZtLmpJoGemgEwPzCxsH0DTuKP7xeJJSDz6GLTmkegFCKh7a1vkyUPMmwjNl1lljv14ld1OzDOWCRdfB7K+VbzdMpp32EXStPCzFZcEniA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ttGjp0btNF4zOpXcuPmwIEmB9LAeLpyYJU3GbMRoQ4=;
 b=V4iRwx6z1DnsxyJ+k+DRseJu3vE95OL47z1c+mBTqFLmTSYCobyvVmxjY6x71bHu5fM/CQmhTCrLSdQ3G1QFasHT+H0XNnqBJgaxL+tFBg2cCwJeVhi3C0JYi1l/wtP3X+CzIIQps5JAPRpbqLfu7DdBNFuThIW5hkADiXpdSSdyLeFuGPJ+FDRNEzJAYeDJ3p2Inxdjez7cl6eA/hF99mNeKpfQev29nmV+hi+FdyrNfJMjY730oTsb7hMF4QLkQest39H8rUNlWQTkkl/Laeu/8rAiaxbqXfogfLCRMDs7mJuKuGPP96fdIQcbDgU1+kWOJoUky0xANx5JWEkKiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ttGjp0btNF4zOpXcuPmwIEmB9LAeLpyYJU3GbMRoQ4=;
 b=hYRr3dwn8++znDpE/0aPqVxQSklH8sSwUXOJdElRPfWn40/rP9/lSMEiwnuP29+TjKjRbFqFSyvEebk5ICSK2DPM9O5xu2TX9u8pOhwcFM4u+l2Mdj/bCs574T6PtoxH45bUotU7v4UCMAjcUIMUXWqVOR+SgtN9uOmSB5E/kPZ/conjwQOn2bTDoOt7FCptqI5n/rwSKc8CI/G19zv5PT9P2/S30ZfUWtIVtfHefS8PNBwUv7CNYKBgk1wWULM3LnsV7hX5F/3FPPVYwH2tFRExepurf28dGV+siNt22XHrpuzS8qnR83dpyl7P5tkuqzrQIz0Xa1B/fIE3n9Rnpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7)
 by VI2PR04MB10956.eurprd04.prod.outlook.com (2603:10a6:800:276::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 10:41:15 +0000
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561]) by AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561%4]) with mapi id 15.20.8769.029; Mon, 2 Jun 2025
 10:41:15 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v2 07/11] net/dpaa2: support dpmac Tx stats
Date: Mon,  2 Jun 2025 16:10:37 +0530
Message-Id: <20250602104041.3322164-8-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250602104041.3322164-1-g.singh@nxp.com>
References: <20250530071344.2939434-1-g.singh@nxp.com>
 <20250602104041.3322164-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To AM9PR04MB8194.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e6::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8194:EE_|VI2PR04MB10956:EE_
X-MS-Office365-Filtering-Correlation-Id: 85724271-fa71-4de2-e3b6-08dda1c1ffd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZVjOlXYZLoW0HFy2V4CPcyW7JFMs1iehLwKyl4/QhdL2yHIlgPpflTDnwC5u?=
 =?us-ascii?Q?XqgJam7eBLx+xKpaXMGu7gPEQ7fDZwIizGqMXzPkbxvAtNw1XVm/eLWVEaEy?=
 =?us-ascii?Q?P+ATK0QZ401yFVkDO+uAUDB/uLPgw1SnmYKL6ICipDUtTNZ7SSgIb61Cqw/V?=
 =?us-ascii?Q?bdC0DXEcMWHKaJJkHD2t99ARf4p1h1kj1ps3+okNY8lOCqF9YkWSuUS8gnzP?=
 =?us-ascii?Q?D0ApYQkX4zQZpvbEf+0KDxhpKXzTV6mWfEXEvgOGaCy1FKn1g6whHvjDN2WF?=
 =?us-ascii?Q?o5C7RiC707wkItxBOJJP7O+HIdgx8wFHk7Bhnn1xjWwxD0JuGBeymcTMtTMA?=
 =?us-ascii?Q?FRocUq2wpsZRJCJ/9gqLBMhBTZXiHzjq/tl3hZW0xoGWqlgQGwsJqbt1Ifld?=
 =?us-ascii?Q?y16m3LbRE/bo2Az9i8mB6rT6tgTsyg6Mkp7lMrs2tGWNgc5yB7M+OvIuHOrj?=
 =?us-ascii?Q?QzXK1Uff8gu5GBxeSknUGClq0onnMU9gf2FAbfWx/K4SgOmcgu4c2u45VQTK?=
 =?us-ascii?Q?ewHBp5a9OtIsgBJntBIfzvxgcG9JXYhFXUaMLegTBGXoaLjjahbQ2LmoochR?=
 =?us-ascii?Q?pbNek9bpj8+JdjgQiQEQHgEWD692LvA0bPHRctDUpILM+ITixXB7X1iHRZvx?=
 =?us-ascii?Q?eTwGmUZNSb5EPpg5N8ycVk9dYcnHugKADgnIkdObpV2+NtcWHSh659zl12K+?=
 =?us-ascii?Q?pPJA6ECO6YWuebDMsM9HG4QdhL8PuPZYozAWLnoDr3y3o14QgwDzVFdqHrcK?=
 =?us-ascii?Q?TX4zAcy/f2Vju9XXIPsaXw0hhZ5Y9sZE6EkfKtELkqcA8lGIdKy1hlCJ1on6?=
 =?us-ascii?Q?A464wSQvz1l5h1wBLazcx1ScJpgbQoULy1c32EbLLOxh0v8TPvsIxljkmY9y?=
 =?us-ascii?Q?mVaarI9zQDtG+TY4ou5HnEJaslmKdzdw0Kx0e58hnDaFgY8md7gZ6qtzSVP/?=
 =?us-ascii?Q?n2EAwamwu69R/aQDcUKgiBn08Pn+BFtmO0+C/gTq4dNQK9Z9Vr4VPUO+QFXs?=
 =?us-ascii?Q?BjN8FnhIqqClR5CW17oB3AHKPHaPEUq5xMjTPsmOev8XQ7mnFJZw3eRYTP2F?=
 =?us-ascii?Q?hsQTwKVrA2sK/ZYbVBSXbvaVBry6PvsvNgVJTfJiNm76JTCg9LfI8iVHQX78?=
 =?us-ascii?Q?Me3fb7eG+g+QbiMxpNtJLJ90RlVKu6nlOA8zTKxSe8HccsS5EsXc0SLhpBsS?=
 =?us-ascii?Q?QYMymvfk0IDsZo7IdxCoI+ZQOZ8SYD8gNk7bBHBUIMChs4Tk/NrQ5Xr4iPS2?=
 =?us-ascii?Q?3mkbf54H8Ef66iHa7lY01feVyLxzi2f9H08tPBD6TSL+F27vCOroCrgYL/9q?=
 =?us-ascii?Q?0ouF285NETtHIx9x1aeX6FWrUO9JhPvPM7dDbUPiSVExVX0S3+uwT2RPSKp1?=
 =?us-ascii?Q?CzssQs6eUhmOfGsMRdLjXPfHgCARPDnTm5qVhdZaPWA16vXhPjp+af9gpFZt?=
 =?us-ascii?Q?SHYzVbrvA9GkwM5ACD4px6KhRC49Vyc54JaQDWXUejqKneWzJ1t41g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8194.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rBr9cv5mHeffuem7K61crVJ0I8qtrU765dJXF7wmW+CvyZRHwazLw0/eV4e1?=
 =?us-ascii?Q?UluZe71sRH+wF1czWGZaeFpAR7o/zu5f8Gb8Zk6aqfoTBGC+UzuoRykVNsOx?=
 =?us-ascii?Q?A+6m9kJDR8WgPKEhFBd3OdPtOi26W2TY8jYCeIpWobZZRuaAyWiHp8vYLXxc?=
 =?us-ascii?Q?/Lxnm+LLifZAWetDMgqJS9RBO+aY99gb3VECeq5jKkEI3UAXUUdOT1QqTrjg?=
 =?us-ascii?Q?8YfjiaRXIR6Ng2nLLXHfWRHDVj0p9vOPGltfXgT5QzKoLRlxr5pNaNXTD+03?=
 =?us-ascii?Q?dSib5u4K5jc7b3+WdCdFP6wnaxuqzkblJ3i6gsZ08QAVsBhs1YFsQIKHGEbg?=
 =?us-ascii?Q?FUzaDxgvi/57/STqi8B6SAXgjummPPDHlERiZeBfchfo4tdezg/PwsL/r7im?=
 =?us-ascii?Q?dCW14EYekA9hACCKX7oWQddnQNSW3T5cHwLwPlTr1wxcSv1GSWb321OeIXJ3?=
 =?us-ascii?Q?qpJa96NCts5RQzBM/sGXtGfQskVRzEdwcA/0fPWphVDyHyiyTt7vPB8LKoN3?=
 =?us-ascii?Q?F+DFQND2l08wVVys0LJwPVriLSoc6gpnkMv0emYYND5u+cIaTgchGexh0UdG?=
 =?us-ascii?Q?3/ojI4idZhuWE/Lo4TU6xoV7vOUnVpr4WX9PGTrKzBGYjkey784dVu2gtbKX?=
 =?us-ascii?Q?YwmOr2IHIn9ErQJ3vZqhn3FqMqLOu3uxM3LSrCjyFHFOMs4JCc0zv6pdEfRh?=
 =?us-ascii?Q?J3CbloCinvld0E41c4IhiLrUnIjngM4zdo4Mtk5Tt3pqVUyNE2FP66Ayg/KO?=
 =?us-ascii?Q?KJlDbSYCNykITJ26q1OKc8QCzEgvAweq3HC0kfWOvCw/3R5tGFWz+Z8hDa2f?=
 =?us-ascii?Q?42MSc3nSBgJ58vXSSOBa9mafnCvfduiZu4KRvFj0zk43xhwN6uTP2e4rTWFc?=
 =?us-ascii?Q?d5wVX7TdH/woMqeLmjRWv0vlpMKEDqSb1XDqaRAp7kEyVxsQcWkTiVsEO5Ic?=
 =?us-ascii?Q?0yerQuLfQR4ZyO0+duMHGMZoVx7f08NDfwRznF2TvC5BTPgY9K5+dwXAZ9VK?=
 =?us-ascii?Q?k5b1tB0Qqm2iLzaXablDIcyhed472DF78geWtj1qVyO0dTugG+H3a4bpdNlY?=
 =?us-ascii?Q?AA7m6cTHthUotgQzHJWmoa2y9tgZdjCwJ/8znxvDnDKdKaGxrC7EXXh8q+aV?=
 =?us-ascii?Q?JCAA6TE2IYQ5ceVEJhSGnGttp9bDQI4iaWuTe8yHsXm+DA4Vipk7U4Y+nNPa?=
 =?us-ascii?Q?z8fSwXT964hPC5bOpQ2qQMHLlG/+61cX9W6ql39whSzcC7Y0DVgGblITEacr?=
 =?us-ascii?Q?G18gJ7eqP2g5OMjdRBxdHAtjbshHs0apDDYXC98elL0AQNVlhkpzmA9F2XFn?=
 =?us-ascii?Q?ry/ZdTrPyqR7Lblxii1p9DRe8oqZuzLaM+ab7EKoSTX5ipH/YWh1laoTMHq+?=
 =?us-ascii?Q?UZcavb+IuoTw67CuJne5FSFuZMyFapeMoyBcQzA1jlCs3CkpfLYgs23/zBaf?=
 =?us-ascii?Q?3MS1NZ9L3ZguqKpGnhKrRBkgzHWWFdHRq2jdGKR38Nzm8WL08VOpv3S8YDU8?=
 =?us-ascii?Q?P8G4hTqElVjVuisQjNdzv3y/52tKXLAqeGwMV2JvlAHkdzcXBqBtyoMQF4qV?=
 =?us-ascii?Q?N8soYh5HlMPrWd35ULw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85724271-fa71-4de2-e3b6-08dda1c1ffd7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8194.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 10:41:15.1658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHpwxANgTjbBVY8W4gtGFwTUQYdnEeVkqwb/tSc466tRvq/qCHeD3QngyHi4n3DU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10956
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

From: Apeksha Gupta <apeksha.gupta@nxp.com>

Added all mac counters including Tx stats buckets for
packet sizes.

Signed-off-by: Apeksha Gupta <apeksha.gupta@nxp.com>
Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 drivers/net/dpaa2/mc/fsl_dpmac.h | 50 ++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dpaa2/mc/fsl_dpmac.h b/drivers/net/dpaa2/mc/fsl_dpmac.h
index c4f16f6113..13b5a94b8c 100644
--- a/drivers/net/dpaa2/mc/fsl_dpmac.h
+++ b/drivers/net/dpaa2/mc/fsl_dpmac.h
@@ -1,5 +1,5 @@
 /* Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2018-2022, 2024 NXP
+ * Copyright 2018-2022, 2024-2025 NXP
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -434,6 +434,34 @@ int dpmac_set_link_state(struct fsl_mc_io *mc_io,
  *			      pause frames.
  * @DPMAC_CNT_EGR_GOOD_FRAME: counts frames transmitted without error, including
  *			      pause frames.
+ * @DPMAC_CNT_EGR_FRAME_64: counts transmitted 64-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_127: counts transmitted 65 to 127-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_255: counts transmitted 128 to 255-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_511: counts transmitted 256 to 511-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_1023: counts transmitted 512 to 1023-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_1518: counts transmitted 1024 to 1518-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_1519_MAX: counts transmitted 1519-bytes frames and
+ * larger (up to max frame length specified), good or bad.
+ * @DPMAC_CNT_ING_ALL_BYTE: counts bytes received in both good and bad packets
+ * @DPMAC_CNT_ING_FCS_ERR: counts frames received with a CRC-32 error but the
+ * frame is otherwise of correct length
+ * @DPMAC_CNT_ING_VLAN_FRAME: counts the received VLAN tagged frames which are valid.
+ * @DPMAC_CNT_ING_UNDERSIZED: counts received frames which were less than 64
+ * bytes long and with a good CRC.
+ * @DPMAC_CNT_ING_CONTROL_FRAME: counts received control frames (type 0x8808)
+ * but not pause frames.
+ * @DPMAC_CNT_ING_FRAME_DISCARD_NOT_TRUNC: counts the fully dropped frames (not
+ * truncated) due to internal errors of the MAC client. Occurs when a received
+ * FIFO overflows.
+ * @DPMAC_CNT_EGR_ALL_BYTE: counts transmitted bytes in both good and bad
+ * packets.
+ * @DPMAC_CNT_EGR_FCS_ERR: counts trasmitted frames with a CRC-32 error except
+ * for underflows.
+ * @DPMAC_CNT_EGR_VLAN_FRAME: counts the transmitted VLAN tagged frames which
+ * are valid.
+ * @DPMAC_CNT_EGR_ALL_FRAME: counts all trasmitted frames, good or bad.
+ * @DPMAC_CNT_EGR_CONTROL_FRAME: counts transmitted control frames (type
+ * 0x8808) but not pause frames.
  */
 enum dpmac_counter {
 	DPMAC_CNT_ING_FRAME_64,
@@ -463,7 +491,25 @@ enum dpmac_counter {
 	DPMAC_CNT_EGR_UCAST_FRAME,
 	DPMAC_CNT_EGR_ERR_FRAME,
 	DPMAC_CNT_ING_GOOD_FRAME,
-	DPMAC_CNT_EGR_GOOD_FRAME
+	DPMAC_CNT_EGR_GOOD_FRAME,
+	DPMAC_CNT_EGR_FRAME_64,
+	DPMAC_CNT_EGR_FRAME_127,
+	DPMAC_CNT_EGR_FRAME_255,
+	DPMAC_CNT_EGR_FRAME_511,
+	DPMAC_CNT_EGR_FRAME_1023,
+	DPMAC_CNT_EGR_FRAME_1518,
+	DPMAC_CNT_EGR_FRAME_1519_MAX,
+	DPMAC_CNT_ING_ALL_BYTE,
+	DPMAC_CNT_ING_FCS_ERR,
+	DPMAC_CNT_ING_VLAN_FRAME,
+	DPMAC_CNT_ING_UNDERSIZED,
+	DPMAC_CNT_ING_CONTROL_FRAME,
+	DPMAC_CNT_ING_FRAME_DISCARD_NOT_TRUNC,
+	DPMAC_CNT_EGR_ALL_BYTE,
+	DPMAC_CNT_EGR_FCS_ERR,
+	DPMAC_CNT_EGR_VLAN_FRAME,
+	DPMAC_CNT_EGR_ALL_FRAME,
+	DPMAC_CNT_EGR_CONTROL_FRAME
 };
 
 int dpmac_get_counter(struct fsl_mc_io *mc_io,
-- 
2.25.1

