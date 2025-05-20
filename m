Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0D5C3ABDA
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 05:52:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42B0A40666;
	Tue, 20 May 2025 07:52:05 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011038.outbound.protection.outlook.com
 [40.107.130.38])
 by mails.dpdk.org (Postfix) with ESMTP id 8D9CB40648;
 Tue, 20 May 2025 07:52:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0HDJVu4JwWwBO5HpiKYYRX8fNgqNzlPMlhLM2xefPfsnSDBZOMT/6iaP7SVul6ZjRAAliKBeLuUlhBsbb3/FdKJ5tebPZ35ecmerO/mv/dWe3fq9nwuvhUTYBiU+vOBwUxUGJjBhdcHhJlOkaX52HT/Xb2c4OsO1fd0ZCS8aObs8fH8TwXlOQw4NQkLm4/hbd1DFjX7J/xWz1qpCfDiHMQSk84rvUkvx7Az2pduhOBkjRkuiOggwuvXJ4VWhuvxR5J0elUke5WTWls1t0oOW8iG2l+y117BFdoFIZOrM9/DmHL1Q3CL/9PUy0sZfk0GvuibRoJuo7TNFHldEfgnXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0XFDLy4ZhI4mTw1GHdbgwg2iFRDRwD7VSK6bTXtikU=;
 b=mzp6Bd9hatEM9bA8TKU0EwQYIJsi+FW0I28omF1J/HE/6SaiHzNDBbj5r7MtaDAGOByq+eGN2aH3XB6BWotgAryvVo4R+5mi0QJ1jtf69qhr97Jkn0H4XcPvfOrsLjDD0/yGb9g6nMkRGiDgppsv04Q8sbFEp2b4yjNawkbeHZgR39Ei5ryxsvduwKo2nGidkF7W9PcISFlt1yPTUYY9nMcRY/UmpL04H3o54E2/+cyLn7cRTHDY1yp5qRCMyFqYOUxPKrpPsYVo7+taB9x38PatdjSDrwxPBP2t8n4tmHH111vJFlyXjUQeeIdGQUX4pxRasQVV4GWfdoJ87OX66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0XFDLy4ZhI4mTw1GHdbgwg2iFRDRwD7VSK6bTXtikU=;
 b=X6JChLa+HHOmAX//Tde/TDfQQs1FaPuyMI806sREh9BPh4WpAJPTyxlpPMQdz6yHK4DQ4gd8d6S1TxXKbhKGlaqSqyRyqb5NdssgSINQ9fYCtdhs20qYWILClb7nMqqEjzUmwF5Ff8hCdSPzPlCec0dWTROAN/xFXwQn2LA1eVvKNC1yPwWvXOviAObMxEO8uQV1LlFkgvUDlNDSEqNiJupw4rnViSl5L3U4ptNqXI9gaIQ+duuTt4/qjNiIExw0ZoWDQXFzZ7622XTofpO7YizsatGRPQUK15FCLxUCcUIlHAKT1klhSAwvLtgJmvl9JlYRcvXOY15jZfqigeCwSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM9PR04MB8617.eurprd04.prod.outlook.com (2603:10a6:20b:438::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 20 May
 2025 05:52:02 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%6]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 05:52:02 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Franck Lenormand <franck.lenormand@nxp.com>
Cc: stable@dpdk.org
Subject: [PATCH 2/9] common/dpaax: fix for PDCP AES only 12bit SN case
Date: Tue, 20 May 2025 11:21:26 +0530
Message-Id: <20250520055133.506071-2-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c3a12a97-453a-4ea7-4520-08dd97627184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gln1Zpv4CPnLs5zganjvDfNLuhwChxv6FkkFGNDGvmBRwKTJ/IRBkg7bwpzj?=
 =?us-ascii?Q?J4k0K/fd4Dsa6kUILzz7iptfQPgX7k2HmLqphIawtLfBiht+thDfK92/AWtQ?=
 =?us-ascii?Q?KI2ocsO/1Bo6DTA1QEw8OOlAU1w1hH6p/UoRExx+8W3jTJ/BMVDdZ+GWxGcm?=
 =?us-ascii?Q?xD7iOleYXx5S3GEYQRzFqGTYcyFrE8BVVKkMOcxfIsAU8Hadb7Ix94+KTclx?=
 =?us-ascii?Q?txOCNUGd/NngMvMO2ChVwVw08prJ0Ts6fpeT3GnYuWW204GfAnv8tt8D0pZN?=
 =?us-ascii?Q?Yqnp2fZax3OEY/hQkbJYay60COAfF/fc7Nmhs8+C4z0xYgJbRCL8e8OVOsdr?=
 =?us-ascii?Q?1DYQDrQEh/4ATyrz5wBSPimnPWebgrRgAIRt10frbFs8t57IKuPSyNPFsWY2?=
 =?us-ascii?Q?hPdRRgZY6uJ5PLx62iUrz0xea0cgn6HWNLUpupHEhfKTgNSZYSoOPyEATeJo?=
 =?us-ascii?Q?xornTN0y7eccXQ3wxHjCHyerOpcoqECV05FO1BAd3YU+aLTXX07WFGoAXvjR?=
 =?us-ascii?Q?babBSEDvGP3J69lZhYnactYGz79VY/V5lsshtb+fpX8L4LD9QMNJersCJN+3?=
 =?us-ascii?Q?KCl69FrejGdulh5eoH21gHT/cRZEk3mE5VMiuYuWrY6RvK+vbfdM27wkMnoV?=
 =?us-ascii?Q?IoSjQTkOex9cOAeXQu6m++r5cqRi22sGJgCGI+BmUG26vqWn+ux1Bb95c+LL?=
 =?us-ascii?Q?nwIVpz6CnvbnSK9JkqHz2TU8l5I9Ukxvmi6rIv23YsM8ttqCSgVzvo5RN1M1?=
 =?us-ascii?Q?nE7+HyqAPVzHNqpme11QpkthFz10ERXJ4ySI7amWnu3ZDRkDtPuyFRspLPH0?=
 =?us-ascii?Q?+9KKujDMTPaw1p6S5Px+Ll8fy/AIaqG+6+2t6oTOAfNY+FkQaG0nA3m50K1o?=
 =?us-ascii?Q?8sxxd02B6Hetcqaojs40VLaFeiJ2p21GADXhIef0fVP0EjfX52CrjZUorGlP?=
 =?us-ascii?Q?U7ciB0YsGesVwBdgWqZM5CH93fnOJFsaKgESL1Ac3FA1sAY386Ubos6hmTaM?=
 =?us-ascii?Q?y0S3Gl3lXWC6be6sTabuQBIranvsj06it0zGGur7manaFRDKgPcQZL/JZqz2?=
 =?us-ascii?Q?PNAmhUuJtqipHvv5j+4c0TrrSMwhwd7PhQ7qzEOmCS0vS5QmGQOw1k1RbrvS?=
 =?us-ascii?Q?sTZohH5d74e96dfXjVB3kxFFnmDQKxUdSwrxpWoiThB3kflj246qHP9l1oHh?=
 =?us-ascii?Q?peC6QGEWl/pR6r0EsT/f3gID4qWtNh4JEIDV/ex35dagO8PJteRAhz89hKoZ?=
 =?us-ascii?Q?DtHqg9zaVpvZA2LmnzeCi5yJU02tZXWWcWyOdxkHiBnHr6oC4DHPf94tohuQ?=
 =?us-ascii?Q?CQNnIRJMQ4T1JBkuDFVCTRr51au2P/5dp5tO8Mm7ieY6AbERCg7Kd3OtKskh?=
 =?us-ascii?Q?UZbqHUrbAVrAnaUmVzQM/x80V1vAK+2LX7UZf+XaA62LW2ZQou1d2oI0Ngsn?=
 =?us-ascii?Q?E16f8+AE19a0ADCAovzzXoRKXHD6GixwNXvGzaizJGGwi8J7FT+fWQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m1kxUlsFf4QlNM73ebkawY94HOqLSB/Pm82oKvcLVFLCPDtepd9/3i8xtTn1?=
 =?us-ascii?Q?b2spEi+z9bk+yRKtaocHFapCmLaKXcRB9sNMGsWYVF6KtsgBxOFJkGqXhO6K?=
 =?us-ascii?Q?bFC+PhicWJ2PTfkQv8RyvhEjKmL0fBCsRR58SwSEP2EBCsOxp10ScflOxmCs?=
 =?us-ascii?Q?beqCer8nykaxLdil66IsyySZ1tPCNA5qhGHChJdKJUhpcHdVJDa2PtDX+3LL?=
 =?us-ascii?Q?LO7yaoTMH4HFK7WC1zphC0FO3O1JC629rBgybkJlbQdQTmQ4F3ku5M1au+mG?=
 =?us-ascii?Q?93otemuOMSBAITcyub1cGk2l+hexrh8ZZdCo0psLQ9s0K3OC519efu3RgBXT?=
 =?us-ascii?Q?LRd7PEdHAVRq+QxHjRm4dX9xqewVvJZZedbTiKmXDokgf+qVumEYafQCSghG?=
 =?us-ascii?Q?D9ZTHTJ85ntf2nA8+qxySI1s4nj6uUp+6eMYWENR5qmyp7F+Hhm79BCbMosk?=
 =?us-ascii?Q?qZ3wi+fBEhe49gG5jeWIfDNLvB0vbDG9XR61LCoWyQPGdDaxO1mIE2fwZ4uE?=
 =?us-ascii?Q?iAMKSKb50Bmz0llw/I4fpIJSC6I/qiDIB95q5+YjXBe4pk6anPSAnIejD8Dp?=
 =?us-ascii?Q?VAEuv2+/SPuBu9JVRg9cxe4cnfNjjgP/+XHL8MTWInA0y0rtilhy+zqCxsD0?=
 =?us-ascii?Q?jBI/v52QEBi1k1MP8bm6efot0DpZi14vooEsJrelnGfrBQr4vRuXpACGHoax?=
 =?us-ascii?Q?k6h06srqqN6rijdRH6rUSpw0EKwHiZvcjj9FxdMvmN39QHQ4EEQjTRmaQn+b?=
 =?us-ascii?Q?h6iF9hUO7nBwYevo+jN3zxCVmoJ1OgHgHTu4c1uLtagn0WapivW5xVoFZpus?=
 =?us-ascii?Q?asMP0cRXoqTer3mstm+VvLHSzFhjgGq6Ku5mZuCBwwSE0TCV2tmBvR+j+k5K?=
 =?us-ascii?Q?Idb3g3Qp2WaY8fIpVk+KZkBJJj7IRGZDSojXQ3cacajeokoO08KxxWrqDbNH?=
 =?us-ascii?Q?5nEvPI/WcY9lMrd7SUh4iwCi/quSu+wKYJTMSf7+8Ovz5cvIvfwv6wxU05w1?=
 =?us-ascii?Q?1hhbGCjeCMT4YuwW/hfBHvZn5/qgl2QGNWXMIujLMvaPP7Ngkag1afYUTbjq?=
 =?us-ascii?Q?pGWqTpAmQNCkBVoz4SKArA3Q2dX4n1aV9+TrWiqbvL1K+WEUMEdSCuYhqcrl?=
 =?us-ascii?Q?HkqnPCQmLqBL/MpzybqO4cGp7Ps9L3po4itQ59K3Jew3f5CJqLTkyDZlaFAg?=
 =?us-ascii?Q?QfG6kkixUMdlLfEja0TJfFLlk4ZU1Acv6eaageWOmCszwIweJ4p7UmtRjGUh?=
 =?us-ascii?Q?n79qJurZYk96iYq/BAF/jBy2jb+UJTVtWaqr3IVIXYUHgIO9TCjP8dscUQlN?=
 =?us-ascii?Q?HLFffS4YJl8+hyRLlZTd1DDlzb+eA0hEGy91yW/00IpV5Ef5tod/o6cKeuy8?=
 =?us-ascii?Q?ud/VB/Lkh74ZYhJLLPZ9tNfgR0EBrfQl+M1ysj+MwWX48on/737eBAidl4LH?=
 =?us-ascii?Q?Gg42cLQul2qRAfsMG9goSYc7k9rWtnhVypQB9+xNTNbqy+/KD6S2ljYqIkYl?=
 =?us-ascii?Q?ukgSfC8xeh+jZS3j+mr+MR0g7MoObZFnd74RwP/49DTp5rZiOMkm+95Cf1Iy?=
 =?us-ascii?Q?aXjACR6rQLAhdHK3i/0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a12a97-453a-4ea7-4520-08dd97627184
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 05:52:02.5873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKykdaAjaQHWEnO7GFMx19MYrplFOUFpy60/gw+kfuKbIfNZ5nOuscZ/nH1II7jQ
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

This workaround fixes the invalid key command SEC error.
Fixes: 6127fff842a7 ("common/dpaax: remove outdated caamflib code")
Cc: franck.lenormand@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/common/dpaax/caamflib/desc/pdcp.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/common/dpaax/caamflib/desc/pdcp.h b/drivers/common/dpaax/caamflib/desc/pdcp.h
index f4379ede2c..c90eff26a8 100644
--- a/drivers/common/dpaax/caamflib/desc/pdcp.h
+++ b/drivers/common/dpaax/caamflib/desc/pdcp.h
@@ -619,7 +619,7 @@ pdcp_insert_cplane_enc_only_op(struct program *p,
 	KEY(p, KEY1, cipherdata->key_enc_flags, cipherdata->key,
 	    cipherdata->keylen, INLINE_KEY(cipherdata));
 
-	if ((sn_size != PDCP_SN_SIZE_18 &&
+	if ((authdata && sn_size != PDCP_SN_SIZE_18 &&
 			!(rta_sec_era == RTA_SEC_ERA_8 &&
 				authdata->algtype == 0))
 			|| (rta_sec_era == RTA_SEC_ERA_10)) {
@@ -631,6 +631,7 @@ pdcp_insert_cplane_enc_only_op(struct program *p,
 				 (uint16_t)cipherdata->algtype << 8);
 		return 0;
 	}
+
 	/* Non-proto is supported only for 5bit cplane and 18bit uplane */
 	switch (sn_size) {
 	case PDCP_SN_SIZE_5:
@@ -2719,7 +2720,7 @@ cnstr_shdsc_pdcp_u_plane_encap(uint32_t *descbuf,
 		case PDCP_CIPHER_TYPE_AES:
 		case PDCP_CIPHER_TYPE_SNOW:
 		case PDCP_CIPHER_TYPE_NULL:
-			if (rta_sec_era == RTA_SEC_ERA_8 &&
+			if (rta_sec_era >= RTA_SEC_ERA_8 &&
 					authdata && authdata->algtype == 0){
 				err = pdcp_insert_uplane_with_int_op(p, swap,
 						cipherdata, authdata,
@@ -2729,6 +2730,17 @@ cnstr_shdsc_pdcp_u_plane_encap(uint32_t *descbuf,
 					return err;
 				break;
 			}
+			if (rta_sec_era >= RTA_SEC_ERA_8 &&
+					cipherdata->algtype == PDCP_CIPHER_TYPE_AES
+					&& !authdata
+					&& sn_size == PDCP_SN_SIZE_12) {
+				err = pdcp_insert_cplane_enc_only_op(p, swap, cipherdata,
+						authdata,
+						OP_TYPE_ENCAP_PROTOCOL, sn_size);
+				if (err)
+					return err;
+				break;
+			}
 
 			if (pdb_type != PDCP_PDB_TYPE_FULL_PDB) {
 				pr_err("PDB type must be FULL for PROTO desc\n");
-- 
2.25.1

