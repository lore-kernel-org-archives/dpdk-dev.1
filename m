Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E743C8302F
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 04:30:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B70514069D;
	Tue,  1 Jul 2025 06:29:42 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazon11012039.outbound.protection.outlook.com [52.101.71.39])
 by mails.dpdk.org (Postfix) with ESMTP id DD7E540655
 for <dev@dpdk.org>; Tue,  1 Jul 2025 06:29:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1IKlKpV0RyPwRYDnlKVURLCIDhd304mey1CfOYhy2ZcThSH/T/tJSljjL0PKLQ7PCdEuvkNsJ/Fc9SuihlnnfVln1DwjcjjWXAMOHYMgIiwuOK1qVmcNnfPRrN51J3tKALjDG2zsJiQZ+b3JKj98m11moOU4zSP1L/L/tAak14AngGIS5b9g4u8gEzHe1yM7K8eOpqAXNnwV1sIV+wrLVnvTL9rCvc2Xsgy+7XIGrn5UvGoN06lFdP/0tdgojY/lFGynN4PsT5OT8X9IaaqOQ4Tyh4Jvv0fzLumPHkqFxyt15zK+lx/9/MgnsH5oyP6v8aKNgBaezy4b4S4HNZ0Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfeSHvkAHUBSk4TXXETwDb5B4yU5spvKGfPfwx1IXrY=;
 b=Io8ZiTJtf790vrLun0tMfYinJ3Rg2ZssdZ77kAy14PGBurxCLBTlBFywzPyB4joD9Hvq4a8ydpyi+l4wcmU1Crnv7Rma3DMwBe3+SMM0wIQQC768eo5vYhzpRx9bUXom0eV6EbiTQjZvy13IAQVX3ZJw0DM4n/dv8osJR7caqVHwb2K6Rca/f7SifwojiGzdBWusw1jOo2CX1dbhDizQBxRRsJRM9tR2asF2n2ad5UvSwi1BWUU0LhIWbUCQO/aGXADhh67yqQoEXq2UBRazEoPABMK0iO+7nogGsndzfoHp1/AoHzllINP8LMHFTyzJSk6P5NDAEEIyTIMgnuzOeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfeSHvkAHUBSk4TXXETwDb5B4yU5spvKGfPfwx1IXrY=;
 b=lx4H5EalJhvgFlDpoDDdZND4a1nzX0zVtngwD5QUzsMtsTOQA4nKGyz6Oi0JLQD7ZAafIerggJlFIHoG7pEHqxdwM3uBq3weoV6/oofYPjWjHUj20pNM5JrTCKrhlzgiecMh+bATw/AGaRhU9CzB8Q9hcdj15o4wW6fQExLX9x4/575tl88UaPhImKk/hrrxo3LLBCk+MVtO292jUB3Uqk/KvO7C8VFmj7DLcaX44hUkeWALjKvUGfpx+xS0TPLYxndv8ChdZ8E71rmgEZ+XfXeArwZ2HY1q+lIFeVTIV7BbB74H9mPJQ6CixCTbhfZu6r+V5JYqRs2q7FLjj4/6Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PA4PR04MB7647.eurprd04.prod.outlook.com (2603:10a6:102:ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 04:29:40 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 04:29:40 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v7 5/6] net/dpaa2: retrieve DPNI API version at init time
Date: Tue,  1 Jul 2025 09:59:16 +0530
Message-Id: <20250701042917.3000355-6-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250701042917.3000355-1-g.singh@nxp.com>
References: <20250630095800.2943863-1-g.singh@nxp.com>
 <20250701042917.3000355-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::8) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|PA4PR04MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 5890618d-df3f-461b-e1f2-08ddb857e4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NqpLg7VLwMOXRTjQ8F3SrOVMdwRGgUrBrw6k0FxUXyhi15iEgc0WjO2j54wq?=
 =?us-ascii?Q?06fkn6reIv2V0OS1tInV97HtYEoubnxlz0oI9QFLqzsF1TiKMFDA87UNLYkX?=
 =?us-ascii?Q?CnalZR0ollokqNKwIJiVHlOD8UgTKqG5YfhcyAHrmKnvammN3s0n1MmQ+Tdi?=
 =?us-ascii?Q?I6FN6x80xxanJblpnHzxONBNtY7x7UkUp8gKC528IlVZW3P2l6BuXuvVxZp/?=
 =?us-ascii?Q?ZjJh+Q9sy5qOTCoKaquw0MEs26DYfv4Tzo/MXQmsjDQNl8dJQsvjJ4mrWY+0?=
 =?us-ascii?Q?bEELnWvDj3mmW5jSeunVxszFKjinfc6DLAWllQinLDEwGsKQwSrVgH7Vm4wZ?=
 =?us-ascii?Q?r1/IifDQ4EMBCPud+WmNwfaXevO2g7rDoAYW2zqUatIJcekx3mpFT12qJzFb?=
 =?us-ascii?Q?pzv7bOIvvptweIB8BM5ymC4D8MAGPxfe37wzPYCDsJVdG6i/Ku8HAxk0Is1r?=
 =?us-ascii?Q?jSia/ND8O1pf265dJkVFBuiRe/sbAvnxNpmFPjRra7inFe8ZRciW+Dp6u9f3?=
 =?us-ascii?Q?pIUuxEHn8ZIeK5CLgGtRIXNZ4b1aH+blqCLEX5dj/XS3RgvijiNR269S/O17?=
 =?us-ascii?Q?jWFCjeNwVeOYu1QBEojbK6Bhn6RiIbc2CklMNwFAtJzf6CUnbEhc5cwMb5k5?=
 =?us-ascii?Q?XowkHrlJ1u+scpPTCjAxlKTmrPY+2pIchDsFGlwJZ1/3M+0Y4wogHmtXyRWF?=
 =?us-ascii?Q?GYQw/i3JFR1lzKRSql+ENNbCqT8g3DB5wOZ0RwlfNjjIKq4rIn/m7fgzT5/m?=
 =?us-ascii?Q?uHBYcxIkeRiOMqmd2N9rxiIGDDyQKPbTxx+VFwALVgbIIp/uXITRRgpC0Fdy?=
 =?us-ascii?Q?Bxf7Uf3448qroCc5xpMjwQTLA/Q9RjN1Poz/YDJGLo+38ZMqIftTxFgGO+nT?=
 =?us-ascii?Q?H7YJjo7/JDgPoqhBS7ycdW/2anEHrAeNPr6b3i/erGg8OpB7e3yaKIFvH2gY?=
 =?us-ascii?Q?S5cUN57zNGChGS6gfmIENVCD65D4lV46678gfeCNL3meBjBTOyPtaQzRMzVs?=
 =?us-ascii?Q?nZPrsZNoqMufvK64uPYML13gi2DRB2okTPlpMnUcKHl7kDRK39RKXSS92bB9?=
 =?us-ascii?Q?fz5WzFMcz2rtKEy63z+rdHcPgPWjdGr1xTCwdHT4814blNs0HmEbyJCbTvrC?=
 =?us-ascii?Q?OjUx6kABaqXCBxB+FJKVCwEyMzRw0Co0HYyRZvJ06oLIN/Iadp0WbFrHENyR?=
 =?us-ascii?Q?Q04vNs3L3+E3f1gRtX86ElXW1as7SiFfVgUxtqz9ER1mpBALKkjk7pKJ4x0f?=
 =?us-ascii?Q?7kF0lcZxFYHP/3Gzx+LAFFn7s1539pjN4f/na7wi2GNa/26+Q8SWbMHTZAvP?=
 =?us-ascii?Q?liSYM8ASjmuBWGIXevGMjqGUE7CnNs+1jGWOmTpfQ1ls/kNlHC5EcAW8foVn?=
 =?us-ascii?Q?LmMzDX012dCXdOYHpbh5BZO2+QfdaDvG9qt77X3Yxtvy9uL46V68Lz1ykboz?=
 =?us-ascii?Q?V12d8O0WNW+7SYwOOslJ4xgtpbM+xkByh2FI5sBRGkvGQ1QaDn4fmS09m4Sw?=
 =?us-ascii?Q?i2NW1RsEtDrBnRY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xW6lI8Vwl/GJq/4U2jkeMsx3aPzPuRXKGgGqes2NaqWl/aIQNkuTefbr11KK?=
 =?us-ascii?Q?fhZzGFlELVzg1QIGR3SCMAOkfXum42KwwGicBeH+poUfwyxcbcU7UizlnSW9?=
 =?us-ascii?Q?hgTbyICxyxUbfJLTEcAxr3oxkvYb5R+vd7hi95sN3YNxRLxIyglDINQsY/J5?=
 =?us-ascii?Q?QuhkWSscGAvu7xlBS5tyfNbal7eeV6Pmlf0zHXoq5kgmWAwZaOi4LOiqxqjQ?=
 =?us-ascii?Q?I4gJviUoW37OIqQu2j3ZpxgyDaevWwYpeMOfNtcbpe40/gFhYgTb4+HvZihd?=
 =?us-ascii?Q?MpQ454hI0qMYWf87aUopM3Gv4J7lfX/X0cx+/BCCra0UWoK+5GzZbCPUHI2Q?=
 =?us-ascii?Q?BWmVPq+mRYlsXDlJeluX8sbCpX/yTOEougx3UP9nFLWWjpOVS7ZLgwdN8TL8?=
 =?us-ascii?Q?XFZN08s5WPcrAsWeaQY6VAZ499xgDYLqaR/0HKQszEALZXfyqFO2rW7qfTh6?=
 =?us-ascii?Q?gh1y2DBMcK+C+X3qRRnljyI7ShLujvhYO0upkkHvhCgiejykWj7htM8HQ+TL?=
 =?us-ascii?Q?GJQJVjLwkbg8Fhd5t6Nuf2EOso0gFaYLqqoQQ7rwG/K2WE0OX/Wvm+8EcObK?=
 =?us-ascii?Q?An0uXIcq+J0IpEcyijKfRT2pbzt/ukYdco+/vgbwT1bzZw7lc4oBDqmCrk+m?=
 =?us-ascii?Q?/VUWAS9VQgUfEquJAkvDRbSVYTCy0bDKasOwrGsBza1IMRb4couMG0hg2MtE?=
 =?us-ascii?Q?EXyUzTRQpzURfKcTpps/a1P6gLBqStWb77jDENG0RbDDea566QI4//3fK01K?=
 =?us-ascii?Q?5BBJsEnXeICecNsG4Zx/pshJ+3UutYD2dK44sdgnL85JMy9P2N6UaA7adpGI?=
 =?us-ascii?Q?fRq6a+d08/dPBUJ7VH59O2XK15acJsCguQlNE4Uwz1ymKmI5QL3UmG4FswyA?=
 =?us-ascii?Q?NEaYDVY2Kq/1HzeGNObR1TlHEoEeoit/vfh0TrP4NCrhvJUAqRQWDghMsWsb?=
 =?us-ascii?Q?0XRW4dmSVRowAnNkLgAZkWxnHcKR/4uqIk8ruBO5U8bvr9oU4uTb1XBXwNid?=
 =?us-ascii?Q?7IHyzGCQKPM1f584hwNAB5FzXP6SbchNTmzLR1HzmIgQiMBrsqNRCx9IDrdh?=
 =?us-ascii?Q?B4MzOyNdIRaKC/Ywjlq5aWMbCiJwnu9s39BxAeKudC2ihL36dfhyO8x06exe?=
 =?us-ascii?Q?Pv0lTv++OXOA1ircyxsGI7KLZI9+LSfnrLjtXFGnSgjehnV3a3HnQJ3NP0Ff?=
 =?us-ascii?Q?ON1gJWpu0nroEBFFVJ/Qt7MOUYZm3jAqYJgA6i5iS5Nmup10/lo4fQdENahd?=
 =?us-ascii?Q?EpmUSg4s6Jco99GDTl7moTW5eCkDHpF86mMpUuildZiuYRDPS3Rlp/1anx5b?=
 =?us-ascii?Q?mhQmk+7CKOcSmpFKCSC7/jANvnM3J+3cnDYpHYKuoklbx4lXoGdwzdJhHvWS?=
 =?us-ascii?Q?6TX1McwK527AUymn1iiNN0AUitM8CDB5VEFxIGX4ssLY+NX+hcHJaKeCsFXd?=
 =?us-ascii?Q?/4u4Zevxk8lfvMcZYdamdjGmPCDt0bWr8EoU77OvzNu/q0yvJGGlryW7DKTa?=
 =?us-ascii?Q?HOmq+7DdDyNbKlD9TCzB3pKsW5IqmqN4lvC+L1jaZ2VQEGbT3AeahBlUKT+B?=
 =?us-ascii?Q?zkd2zcvD16qDcOJEQFA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5890618d-df3f-461b-e1f2-08ddb857e4cc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 04:29:40.0761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95neCZuWnbqPOwKMP6wXY5yZ9iZZIUg2pODrm+TOS8G2cp3Mvb4UnKLVVzalfAyl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7647
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
index bf6d6fc418..aa68f05dcf 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -2691,6 +2691,14 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
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
index 4e3e0338aa..2d01e85d33 100644
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

