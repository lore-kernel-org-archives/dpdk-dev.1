Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD768C54E71
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 06:57:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2F1540EE5;
	Wed, 21 May 2025 08:57:30 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
 by mails.dpdk.org (Postfix) with ESMTP id 21BC940EDD
 for <dev@dpdk.org>; Wed, 21 May 2025 08:57:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSPVPzksCgVP+Gz84C+5GcKd7QfvCPHmFg0TEI4Gtn2dNV/ZrO+MbqM7WgfJh6JKz/czp0+27/uUeDGpeWGYa/aZQ7UQtQWvBCsq0MAJ29lfBSx5dIdBnIIepO2m6PIQImdQGJqqTmQt2uITX5lLrr1O+VARmn6eZXfg4j8wPC+UX81kLw7ePI8NWRx1wH4KmHjsx6XQV+6KwRclH+9HaDhRUAGaCo2uGch5WPY51kwpuZ1aLffhbMFB4L96cvq0i+yXI4VZ9LKNOXcM2sqDX1z2Ez6iSurYhTOGNLFjEJ/1C/TQPYaIjXITLTMlY7GGx94m5zastI7vJlzR5py/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGzL8z3iHZhWDxTB+2AznRg/GvhpxZ6JjkMLnNpPlMk=;
 b=xG43v3wT9m0JA7TSj7Lw4lqtPUIwkKTKymn3DunDGbJ9yCnJx6hawX66ZgSypVHrr2wloBqWd8vUouEuSQd6eozcxnEbxhu31fFoTqJxiLhjiJjmrt78/5cp8oOifYdnO1tMem6+YYKdbYlRqNY/MZgQtn3JiAFjK3mfCqKsPa98ss/caepAnpu/AGzoNjjYNbkrng6NDa1rY8mdBoQ2qAwaVhs7TI1LtW9KQSW7HGywr04fO5wQQHaQuQuZ2EPU1ygmqQ4+vFGf4wlt13164wbtUwfZBrVGyNiMAiqw2VUW3P0h9LIJ6XNpJbT3avymAmCW6bA9vzNNcWlpNEuEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGzL8z3iHZhWDxTB+2AznRg/GvhpxZ6JjkMLnNpPlMk=;
 b=V96IN6CIOR85v3EEgVz/xZ4wi3ejsZ6SXJ+RWd/dmQEgtt/T9kKVLsd4RwI3ODzNbrqzSd+L4wEoStqeWg4umafHqaTu7q3zvVjZaNQm/2pIcdNuJj0Vkj/e2c/ux47sSs1WHpzRPNJNr3slEQFMhGdcLMWddfFMcuc2o0fGonVzAhmHXprSPdHP9ML5frJpMOb6flickFyw0wVyTGZ92RR6meJBM8ngB1VBdFhJLAHJeoS/fxDLp9V+Dm9Mx4ncf2I6ux5W64hZGTkUhO1bEVJDEZh1i33F5nposZ/mx7Rc1RmjmtT9Usd7yD20JENg/neZ/wEg0qG2kS4gnZtHnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM8PR04MB7940.eurprd04.prod.outlook.com (2603:10a6:20b:240::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 06:57:22 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%6]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 06:57:22 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, gakhil@marvell.com, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 3/9] common/dpaax: support 12bit SN in pdcp uplane
Date: Wed, 21 May 2025 12:26:52 +0530
Message-Id: <20250521065658.857707-4-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250521065658.857707-1-g.singh@nxp.com>
References: <20250520055133.506071-1-g.singh@nxp.com>
 <20250521065658.857707-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0072.apcprd02.prod.outlook.com
 (2603:1096:4:54::36) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AM8PR04MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: cf915db7-31fa-4274-76ef-08dd9834bc3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BOLOqiNF74VRvV7aKC1Le9+rg9R2HB1zyZRtOPJ/ppgGRXr78z2ug6dbR6Td?=
 =?us-ascii?Q?tRh478G0F7KjQVukFoyWnqCkRCuFTmz8yTgzY05VcIgN44qJQaZwOQKlp/a8?=
 =?us-ascii?Q?RpO6oJVaeu6vMC3NcifFcolWYr7rTj0SQ/+LNbneEIVki4wf8BE8e+HfiArL?=
 =?us-ascii?Q?Zise86n3E8D/E3RGCNzkVMUfXHcUb5hH3SOy8qrNwCJbtIkJ6Y7L6QeHKu64?=
 =?us-ascii?Q?FXFwpZq8sVZMFkzgRqFB8H+KkAXWCRfRM/GsWTtJzhcQsURdkBXzVm3NI28p?=
 =?us-ascii?Q?rUe72Ec6zu2eHe+eKUPZ9DKfZAWGH21Skj/krV+6O0sSSR/y9PfLPWr82MoN?=
 =?us-ascii?Q?z3CtVoH7JcEpSBQ4+bstpzavNR/4kjfb3JvHyGcooJ/23S3YNWKY3vaD4sIv?=
 =?us-ascii?Q?R9Z3HMe4yAiIr7JZViZtEeOg5+vArgqcWMl9mObBIsLdj3p8P4f2z4mGAIUP?=
 =?us-ascii?Q?O573pEoSkguQXsiJLiN4600XwvZE6/LbLaOxVzX3yPL9dFuuNU/A3DxauF8K?=
 =?us-ascii?Q?kFXY1uLOvwJPIFiMg1J95zLM9tJLmfQgvzVyJa4lkOGath7eDOrAFFI+mYJK?=
 =?us-ascii?Q?dUfGVH5f5hpA8CT4lFyKm0VDWJ2Ll13RxSJuc7MN2+JcZRvdhduhQ0Q22gdl?=
 =?us-ascii?Q?y8HUnxz11q/wrnYWD0t52FZdRqQq6ySJ3l/e2LUCBCOKG8qZ5BszPy+U9Xx0?=
 =?us-ascii?Q?TRMKaoawHqtN7zPx5YH+QX1YsTXM+l6WuilI72wiaDO8InrLp1074pm4hiX3?=
 =?us-ascii?Q?8ob+Co/ga+6LPC8f3xsxKkpLvnmomJKF1NibrZfvRUGX0DqKL5AQEzKX0LKZ?=
 =?us-ascii?Q?6pJuWDSTyYNLMzIb0b88uPDoE07XIDYEABME2yoGxYG1ycaZ9fbm5LrI18v4?=
 =?us-ascii?Q?4uzxAmx2/nGNsFjGSGeU9zO3xgLd1kXhn5XCCpoqely56nrWZ0lcEesRT6Ye?=
 =?us-ascii?Q?YVHUB04EPrhWaPE20JjLN/xmo8Ln4X98+xcxHDhD2WftsjtvP0uiU8tvdLjN?=
 =?us-ascii?Q?qo+jLTm7Xo8lRgIWCwhau6UGy6uRn3087Ov1EOukTfFRwFY/5gjXgOw0jkXd?=
 =?us-ascii?Q?1rZCg8pF2L3No31suvAeiSUooXNlvg3YEH7GtzI7uqlMSOwticF1hS2CZgIu?=
 =?us-ascii?Q?M42TyJkCQwHMS+zOA/uHCEkh03yZDxknu3zuS5aBSzoUrln7juWPSQXp/s9e?=
 =?us-ascii?Q?wIPGrEA0DWn/qplvT9OHNSSPLJBW4aJrUgsj2eHtZBIWmvaE02PMPkbzQRWw?=
 =?us-ascii?Q?DtTiXdmdK1m0kgxrNL+jkAVOn1Re6MalVlTwFPakgT4wOlqxkciFnHfTKI57?=
 =?us-ascii?Q?k+7newtgm27KxJ60esSICCtzInh5nmb9g5aqhr082MnHoFj1XsYj+0pZ3DDX?=
 =?us-ascii?Q?T0AlL/+181EC9epw/+ndEtXo62D9UOcQNBAM8P4ih+2+xhFK9iuBetJXmWsy?=
 =?us-ascii?Q?rKF5LFUk5EnakGDVpstGp5QAkZFILeybvAD0cuf6fid25cWUUVxKiA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1pI+rVSocWLyJ3gS7N2rkp9DCGKbzoQ7i/ejftnXQWks69KQJ38sd1POAPvp?=
 =?us-ascii?Q?p3lKQgo4dy1b7hFqUulQfLnwqnqCBhluWR7VM2ltpVV8wq2//AWE8bCi+CJ2?=
 =?us-ascii?Q?EsqUOhSkOSAgfO9HJiNwVZBb6BljLGfqO6/hAbG2HBaUqgO2YVxEEUus1Cp9?=
 =?us-ascii?Q?NzhHAV/5GWK00bkjilgw7Ku2cud3ZSDoRLvkioV6dr8cvjZZAHO2fzk89js9?=
 =?us-ascii?Q?hBZap05bPOtBAfTJVEL1qT3oI0zURbMkigpSu6Kxc36YjPwEFd1asv+SVx12?=
 =?us-ascii?Q?BBeBgVJkLGop3PoNDaXk0niwLGAbY9CEQdzzu/PqM3cLuuAvLanmyQzOyoD3?=
 =?us-ascii?Q?UzJll/ZBzGeHq5z80xTI4+pJ11EKDB54t7dmCzJQ8oqAnWKah8zFOx40NbDc?=
 =?us-ascii?Q?bGeBxPQk0uO4kVQnm5IFwZFwtt1YI0bCHWp0H9A6Rcn4cecgpoDpv0liJm9C?=
 =?us-ascii?Q?aB6PlgW9+NRM6+Z+xVfMexZlN30W2cDz2kD+abuI4Q0vGG2V/Oum+squrjie?=
 =?us-ascii?Q?tUnt46rsPqM1yZ7zeOJTkyEzZGziOVcq1h008XUIzecGjqU5w3KlHbNz3p5l?=
 =?us-ascii?Q?dQ9Pz+sCM06sCfzEw6QguYQn5AMnmybP62uckOwN1sw65D+B5e2GSliUFYeK?=
 =?us-ascii?Q?oHn4euQZc3xZEXVEVquAMGwV+3ZPqF5unTLX2EV5ezA7QpjfjdxKn9Yu/JI9?=
 =?us-ascii?Q?Dnba/oZteUKUG9s9J0vZQqnyl4LUNj9Stp8VN3pLNrXVI6OI5UJTtwX9ja/Q?=
 =?us-ascii?Q?oDwINA3wvwLyxrgmuWJhrEGXslo4QXHGqoE1xy+ScLHfZ0WiEgbkItOtIjGy?=
 =?us-ascii?Q?1O8O/X65X+uCjJZuqkZne65jINhnQ9Wy7wSoN1n2iPrmAcvTEkunBMn161ZT?=
 =?us-ascii?Q?HjaOR/LhL9wTad/ZECzGvKzpFZZ8Gq8lKvdzprFFMP3PtqfLEH2pyW25eMCe?=
 =?us-ascii?Q?Nn7UsOAZsFfs1ylpVTu0OMBVbEa9ls6WixuITbkLK0wC4xcHi8YqriS418Y6?=
 =?us-ascii?Q?z0nXTymMtjCNTiKat537R68nWeEu3CDINqs1yhQoJ6gUmUzo3jCiTKYenUxc?=
 =?us-ascii?Q?BiAYw/vrjd7vimCUDFRZl9KKYY6z0ktuEeW65/96CwEz5wxGjyDlb0M+4aoZ?=
 =?us-ascii?Q?Q6LnOcwNQXEE7V6LuCmGro0Lm8MTrJq4NNhZRXvPkZ3clANXixKrvFu271nB?=
 =?us-ascii?Q?/yfkgNmqf0qz0+sFcnJ74FeINxXjKjvvKOCoOuDlBmC4YSBPsoOmr+40w/Lj?=
 =?us-ascii?Q?2R47bf36wfLOljQUY5E/oags9zK2FWXE9Fgq6NzAASB/oRbByqH73yC44VSX?=
 =?us-ascii?Q?JzqKX0eaVz3wDpKfNGH0wBFTutUfggno5lgICodSLgdXOLc8IHlR6pt21NFb?=
 =?us-ascii?Q?vP9YzY5pkntPvDE0xqxBzKScgjo/lCqbO04caa4xrSBl2ojGUgbmcgPtgZ3+?=
 =?us-ascii?Q?majCGVebL9sxBqDh8rR/4vkSdX5x1KTxIiqOOsAouSVD/IWc+pxmb817DfXg?=
 =?us-ascii?Q?kqoXhZ6fRmjiTlSxJjHfqcz1cbGArN8cpe9LeC5Jgb83PiGmWU9OfdAU4VOy?=
 =?us-ascii?Q?86idfL2NZSyxKBxqGmA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf915db7-31fa-4274-76ef-08dd9834bc3e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 06:57:22.2366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qiFp0BL6lBmYSDZ97jXoXEwV7gSuhGJBYQVH6dr+BznA7NUbZRv4X3RxhzDZ/SlY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7940
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

