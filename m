Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883A6C3ABDD
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 05:52:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56E6440670;
	Tue, 20 May 2025 07:52:06 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011022.outbound.protection.outlook.com
 [40.107.130.22]) by mails.dpdk.org (Postfix) with ESMTP id 3A01140663
 for <dev@dpdk.org>; Tue, 20 May 2025 07:52:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cD6UM77+8TNjLmI30CK9b08676eoqLxHHRZU3fFo6K56e4EsB/3C7N7apUUNTvfH/ENcZjJ8c9j81LMJNkHEt7/HclconBzunHYACHi1Bd8UNFTjxhLHHOHk84x+ug/vtEq7GLXu6X/Mx95xPNZeYg7nEwkorkwDQTh3zpTYj16T55WoJHGYASYIX3CK+mdqg7oYKmW0IKVHOM3J0+V5++NIoTBq9SaNZkyyl/STOHkTjuA+rz/iPtx2MjiMgRHc1HCQUZ0Xb/zWtG7XkkDMjGYqjaBqnGSwET/n2TUi3NLctwGZAPP7b5gSdCcAiyfY+ZNc1mY8H4YavgWTjWrItg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGzL8z3iHZhWDxTB+2AznRg/GvhpxZ6JjkMLnNpPlMk=;
 b=tVyjAAb8vQIhoLVRxnzL9fAm2VC8+sw05hg42lPOCWH57IAW3wEkD/aCP1BTA0ogV71rL/yx6oq7NblRZLwChg5FfREocQxytjyMX2LDBSeoez2eWqEzE2m+ikF75ePmctcA0NhmJU2u/oWzFexvmJS5mwgVY/K3iFR5GQ4rq+qkDpFRFy0yd4cT9W6RV88JEtqMZhPPErn6gZgFoSrc/gjFDuhO6/J1JH2VFBSQ3j9ttLAts9rP1aztzGUh8g+8VPTS4vo9pcSGwy/noSsgkQphXxHlCJz0nOIxC0qxXYfSYZLTrFPei/Z/e8PaqaVeJwj7pD/kHxuGQKfmM+gLhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGzL8z3iHZhWDxTB+2AznRg/GvhpxZ6JjkMLnNpPlMk=;
 b=gc2iJb6H/mzHilsUGnzu3ZuywqC+d7YBCHsAWDLMCW1ZW4BfpUHLmJ+94rGzg+63ztzSkUX/aRqXVHitwsgkVeEpos1BdXX7JYS1AEDd2SRt/9R6Zz87tp54PCnD9v+AE02yL+i7eP7RE/vFypYNfCvpFPAgavi7Zk4vbpmJHBONQQjKBijzmC7m/8CYBbVd5w6Y1CdKhEiZLOVFraE28dUK0B2bfom45cIXosMXSdCdZnfIAJEsUBO1y2qSDJj1x3jlXCT/HqX/uVezhGq9jyjVzYAVjuuZfJcSYc14F15HC998Fl4m9HxorsF7VCm2T+7KEmHtV45Zb/gkES25cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM9PR04MB8617.eurprd04.prod.outlook.com (2603:10a6:20b:438::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 20 May
 2025 05:52:04 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%6]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 05:52:04 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 3/9] common/dpaax: support 12bit SN in pdcp uplane
Date: Tue, 20 May 2025 11:21:27 +0530
Message-Id: <20250520055133.506071-3-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7bcfa95a-3998-4e4c-fee9-08dd9762729b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yT/JFYUDxBiPAE/jLIyiFuWj+NndimjTAuAurJBPV8n+l+k3LM7C3wbcGB/M?=
 =?us-ascii?Q?Yk4ic8Dqfuy174eU4IZsl8qXere3lITSPBLFqbnq/tADW/Hzkwt/5+ZL4iDT?=
 =?us-ascii?Q?3B/HO1ThV7VpDm2Rg6S26g9FQSNCoTXyKbe0POaL85e+rIVEnJbPIs9DF+Wt?=
 =?us-ascii?Q?MKTZpe+he8EPyfmghQF6j8Sn/nGKb/jcPKwNnHP1QpIBKIivzBVF+TsL3krC?=
 =?us-ascii?Q?C2TCxetLr0/NoberdBHug4u1XrZvAdaqhTguL83UlDWh0oGF1DllkTSdNIoA?=
 =?us-ascii?Q?NQbacI/+HBqJMxEACwuEzQ7TKBAY8Yx1Rsb7lncdehgjwBhwgPZcbYNaebiR?=
 =?us-ascii?Q?pRmt76Wzeb+thVlyv8QWELhN+E/w1rg6Wt3tDTBDAHPiqlpIkU7aJuPUDpQi?=
 =?us-ascii?Q?weZr3zqyRiX8E6dppuSYi9+6B0Q4CSPJ5DyzJlzoDgr1sYIx5opqdcPXQSZS?=
 =?us-ascii?Q?2GECCyTzd9K01T3NqTBnY3AieSqstpq1r9nkvhti30GeCIw3tmlL35kZwt76?=
 =?us-ascii?Q?TwZ4i3NJxKlfPIRPaU7B17zk6mdoJXnfZkie2dv1Rsh/f4qwiBRBLHWLQeON?=
 =?us-ascii?Q?mjJUJ3S9jvxzwzHbHImkDwNbW0jrV5CGmfrwoDh0uKd8vhW0NpuxxVqPJxTn?=
 =?us-ascii?Q?YzzE3KDalx4VX2FLfU0c2VQrrGFlNP0ORsXoCYsWsBJXPPnsILavXDV5902H?=
 =?us-ascii?Q?cilCswSsq9H8+VQJLvH3KkfOozVL4h2y2sCBZ18/REl/zWWrGi/ghKZwRCHw?=
 =?us-ascii?Q?9T6IMblJqQIFKfCkmvo5FuifAqL4rGzQ7dEUozuPu2is+XByM78kyEV4r/Bx?=
 =?us-ascii?Q?0MH9e27AL+8xj/0WdDpwS8phTJDMqL6FPOeP52dt9TPKKp+dYDTYLdwCnA9P?=
 =?us-ascii?Q?kyiMNpAD9tg6TH7KyN989n4esEpZMmmNNvcAFke8TU7xIZ8l1ZpcvtdBycBa?=
 =?us-ascii?Q?9kwiZbz15/RSdWKos+gkGtjrisk1SlLjfIG/JrXWBi0PMgYzE24SnTzovVY5?=
 =?us-ascii?Q?rNsp7KUtnM+OhkJP7MmvrVxnWVSeaGlDhuapidR9aX++p/9i/hO8Ui6dxg60?=
 =?us-ascii?Q?yQ3vgHJhkMi1Y0cMM3bsjNi4fQYr8Dy6kOBbO9iv6D4kf3TcZ44SiidNib7T?=
 =?us-ascii?Q?x3cZTlnBiBvgzLIQNuiJ3NlzZU9B5lQgvUQhwA9UXL8gFv6ehuxCDn9+lYBz?=
 =?us-ascii?Q?ocK64BpLJoVWspH2QYQNyNVNeAHUFlZrSS5zEsq3GUfGFoXbEU1NQhQRlci3?=
 =?us-ascii?Q?8IpgeBftIykmGl5z/KGhl1ZXlJDlHiEQ5Fpx0a6rLzpdN8v4dJejVN3s7qhb?=
 =?us-ascii?Q?TDVgjUjah4+c9Cptmaz+aSS+h0ugvmuc2yrMveu7H1R3Ky2eLX+GxYiQ9d3Q?=
 =?us-ascii?Q?mBjCWVk9cGg88ItGB7RvYHhH1Rkeg2joJv7h4+4AUtpi2t95i2UfoLyLYLZc?=
 =?us-ascii?Q?z/VdW7n1MAdVPWDT9VV5S+4yF1GJg/gHmsloz0WJbSoWXZ82dv/rWQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hH2c3yAVK3jfmHyZSvsrUxwJJPs0lVfd8AcGAjSstIR2u5dyYkEA7wRCYAo+?=
 =?us-ascii?Q?QihT0NCkwnRND4FtVhgmvHX2/WRUcyngN9Acdi7yxqI7i/oLm7ktxMfmEY8n?=
 =?us-ascii?Q?US8LNLnWMahXcxGsd+vrwR3OUGF/jgov7p4ARdYkB2SyyfEhmmCQOT82IN1j?=
 =?us-ascii?Q?sjK+scXrdjirJpYgEyZr5GDxs+K6PCTXj25zzagYPLd1ljiVU1GWDEcqqbBj?=
 =?us-ascii?Q?bAXppP/HrCxTS2kjga+Ch2QDhsjmmqwXQCLMurr+RoYudUvT54zLznKdaG+a?=
 =?us-ascii?Q?oo+sdMTJVJR1iX0g8u14nqd/Tr/w8vhifG7bHVub9byGjP5pXi5BpxZL7PcZ?=
 =?us-ascii?Q?n/GoBPzOaWicN/34OtQudm40Hlz/WtnrOUCKkLdYvaDyE7M/QkXbPflphfoU?=
 =?us-ascii?Q?MbK5e7th6BsFxhEDBVx0N8K3rUgbRtKa3XOhwZXmofLjzaQM7p1DbQZGSKy3?=
 =?us-ascii?Q?ynOhjCwKsx4V5wWT1cfs7eAvir9Vq9yB9Dj55dvOsqdwrPE8w+6eJf3HHpSM?=
 =?us-ascii?Q?YAZgG+bqM+Y6NU0eCLPtljSlv/YTh8Yk0OasHs+yoVQerQeQmSMsmhRj30QM?=
 =?us-ascii?Q?3uHZLFzYxHaz0+hFNr3eR6cD7WaVHw7vmthwUvvoSqDs4kkzY9BSefjrplka?=
 =?us-ascii?Q?wDkpkrOauJ4uRZJS4IZZ3vMfLeO5L7kHSi3zUgcCHRJDVrJ4LT3Jqe5AI7f9?=
 =?us-ascii?Q?uHYKWorv9auloisbZi+YNMqscVjAzyxnX4OTpHVm4re0uZwwm18ZH502GFdF?=
 =?us-ascii?Q?cS9BQEAKtDJ9LCTay4oB832vkEgYeBhrX6Vcc6sSWGtq+NOzCFWDoPClMp6V?=
 =?us-ascii?Q?T22yxQtDUot9RtfPb1z3QYgxR0bGl/dv5WGN4+jrmc2uY+tsh42SDNE5RmcT?=
 =?us-ascii?Q?1J1ZxqlUGG/wPgEqp4jDTgWEYEF3pngk5HR7zWy+L3VgN7BhyWGSt+IEclsT?=
 =?us-ascii?Q?DL60tsQs78rmWrb6ntJ7HcwCi9DUC+t0rI725bAGfoPlax792dlcoXeNn7l6?=
 =?us-ascii?Q?Mz/r5basc5rAosDcuZ/iBP7vcVkg8YtkPC0CFMlIswGz7tfl91goJghvlJZl?=
 =?us-ascii?Q?CsFI2OgUhTv+SjRoS0oDg0naeQGOlmgsUS4GabD7JqDtXa7xDfa8cw1PRNXb?=
 =?us-ascii?Q?AJC105GSlPy9b3Z7bdDRoFkxIL5QGrDb7qWW3tsx7xwZdHzUtfXn3DCD41KJ?=
 =?us-ascii?Q?Q/3Tp7aditAZNc/UCOitphSzCA8KhcHPGpZLVGU9R79ZDAQFUh1+UPnDR4ip?=
 =?us-ascii?Q?f1LwP9LULYK4+BEC4MewZQbr07PyBKaamGnxakrDGds9SfH0V6Oxs6u+8SAj?=
 =?us-ascii?Q?lfmqfKbQbxvdRBHlazn/gzgWNdOU/nlkMiBfmYRdKgrk9LNXa7HSKjVjeQ4Z?=
 =?us-ascii?Q?wCaOw2UDPIaVEUBszr0s0iQfwGgCI+2v+LGB7HFFzY/vcBnph/XYXyZhvPZ8?=
 =?us-ascii?Q?n8H65QAzS2KB0dJEjQjP38aitxm9q9i6JWw0mHu+7kACDzaNNccez6qJ1hRg?=
 =?us-ascii?Q?fGBmyLvPZogiBG4vENPv4PvHNcdiJrtCUj2YxEdF23HvHz07goGnugO8KX8l?=
 =?us-ascii?Q?pwc8emnfdo2/9RsjxCI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcfa95a-3998-4e4c-fee9-08dd9762729b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 05:52:04.3896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xN+hhOfWeg33h/N9xE4oQZ7lfZXnqx+4ldjpBIvxGqaqZ5Y7A8JWXJZ4i4tF8/br
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

update pdcp_insert_uplane_no_int_op() to support 12bit SN size

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/common/dpaax/caamflib/desc/pdcp.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/common/dpaax/caamflib/desc/pdcp.h b/drivers/common/dpaax/caamflib/desc/pdcp.h
index c90eff26a8..55159d53f0 100644
--- a/drivers/common/dpaax/caamflib/desc/pdcp.h
+++ b/drivers/common/dpaax/caamflib/desc/pdcp.h
@@ -1988,10 +1988,10 @@ pdcp_insert_uplane_no_int_op(struct program *p,
 		return 0;
 	}
 
-	if (sn_size == PDCP_SN_SIZE_15) {
+	if (sn_size == PDCP_SN_SIZE_12) {
 		SEQLOAD(p, MATH0, 6, 2, 0);
-		sn_mask = (swap == false) ? PDCP_U_PLANE_15BIT_SN_MASK :
-					PDCP_U_PLANE_15BIT_SN_MASK_BE;
+		sn_mask = (swap == false) ? PDCP_12BIT_SN_MASK :
+			PDCP_12BIT_SN_MASK_BE;
 	} else { /* SN Size == PDCP_SN_SIZE_18 */
 		SEQLOAD(p, MATH0, 5, 3, 0);
 		sn_mask = (swap == false) ? PDCP_U_PLANE_18BIT_SN_MASK :
@@ -2000,7 +2000,7 @@ pdcp_insert_uplane_no_int_op(struct program *p,
 	JUMP(p, 1, LOCAL_JUMP, ALL_TRUE, CALM);
 	MATHB(p, MATH0, AND, sn_mask, MATH1, 8, IFB | IMMED2);
 
-	if (sn_size == PDCP_SN_SIZE_15)
+	if (sn_size == PDCP_SN_SIZE_12)
 		SEQSTORE(p, MATH0, 6, 2, 0);
 	else /* SN Size == PDCP_SN_SIZE_18 */
 		SEQSTORE(p, MATH0, 5, 3, 0);
@@ -2047,7 +2047,7 @@ pdcp_insert_uplane_no_int_op(struct program *p,
 
 	default:
 		pr_err("%s: Invalid encrypt algorithm selected: %d\n",
-		       "pdcp_insert_uplane_15bit_op", cipherdata->algtype);
+		       "pdcp_insert_uplane_no_int_op", cipherdata->algtype);
 		return -EINVAL;
 	}
 
@@ -2734,8 +2734,7 @@ cnstr_shdsc_pdcp_u_plane_encap(uint32_t *descbuf,
 					cipherdata->algtype == PDCP_CIPHER_TYPE_AES
 					&& !authdata
 					&& sn_size == PDCP_SN_SIZE_12) {
-				err = pdcp_insert_cplane_enc_only_op(p, swap, cipherdata,
-						authdata,
+				err = pdcp_insert_uplane_no_int_op(p, swap, cipherdata,
 						OP_TYPE_ENCAP_PROTOCOL, sn_size);
 				if (err)
 					return err;
-- 
2.25.1

