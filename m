Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E60C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 06:57:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BCD140FB5;
	Wed, 21 May 2025 08:57:33 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
 by mails.dpdk.org (Postfix) with ESMTP id 5920140EDB;
 Wed, 21 May 2025 08:57:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecbpnlIvLw6D5aEQunuM67SYxdIyMcaFtqduWB0yk0Uq4u+/QUMSd8Bmt+MXk1v+2usJudOKiTYsMd0fEHEQEYnBoEFlh+xWl4Xqq0TklTTGSX5D9q/CWtmxu0C4gk0u67791ebeQcDPhdTDFc51QfAQKXkPiy7SEplKpdgmmfBUfqZdflhZ5lGvLHq0KD6n+l2zJGixtt/urNRDrCP8uv+RM6TJDfUzWwlY0kzbJ+0qfxz8TXEdn4Y9st2TMmBUsr3Wxekvu4+QdmQiFe34ejOzrVk/YwgAZ2AbNifVekvasOY1LQIajDId8QRDiE6iekTzX4p88f8jy5hvbveVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOF5N2UOSv2pW5lEMhGqOz/OEUlYtOrlCdAR54iY7CY=;
 b=CBcDggA+dvB7hgugDAGJ5JD3clW8E5fxLcQ9Eb1T6na2wSzAx0PP5KYNMngf3LrPoJG3sw8VBFmIjJYC2PS8TUKg0W7cgCM2tXmMoP5Ym7AxpPwUm/KOje+KsCqW/gBx+R6wpdEZ/100tJl9w/wOUnuKsHDt+gM5vqo1I1tvaY5YiSTOAQrxCiuRMvZXAJ4pTuI+2exnJ+13WY3w/9cqthpJzPlOZVldY9hMnMai2mAg4mcralBaP5RRrL9BUgyF0/L7ARxp9C9EpBvxJIHG542gBrZnqork2VEheNliNNwiq29mbMs0x82NkJMQpxzINl1iS31RV1UZrlR1pdxrcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOF5N2UOSv2pW5lEMhGqOz/OEUlYtOrlCdAR54iY7CY=;
 b=ZAkKevtLvk1xMATOTR25MQIsd8h2grNnx1bRRslHIPK/+vbLqb3RoLWMH3dy3Bg5RKvspxXSuOQgOVW1xzpSjzaefTaLdmdJD4PR1evRXNY/YDQ4wDFt01VK76d4R1lymZNrSNwJNBsUOnI9kP+BsuMNRr+gYbt05yIvrVIGuIkedf/KMuXcBffDl5Q3kbj4FoCVagZUQsQ/LCIbn/5MZuSC8aRIdkn0CPD/HmLZ+ZrQh9UKpP6s4k+/ZDdZkVtt2YV0sYdRa01nOjhQK5Y2czKWu8EAngDNOjESAtyzUmHTugeiugvXh1lbcDWKdnYMl9hQzSosr/2g3PM8O5LWvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM8PR04MB7940.eurprd04.prod.outlook.com (2603:10a6:20b:240::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 06:57:27 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%6]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 06:57:27 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, gakhil@marvell.com, Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: Vanshika Shukla <vanshika.shukla@nxp.com>, g.singh@nxp.com, stable@dpdk.org
Subject: [PATCH v2 5/9] crypto/dpaa2_sec: fix coverity Issues
Date: Wed, 21 May 2025 12:26:54 +0530
Message-Id: <20250521065658.857707-6-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a6b48cad-f137-432e-d56c-08dd9834bf21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fjSgDRWrQqXvc6OI/1vapOAxlVXiQYK/fGyRJQVFtcF0mGIaHc5MrBBiWdBe?=
 =?us-ascii?Q?aWgx6+YTHjMoewh25qFLRbLOLF+/9AwjlBQ+cfDkSgRNbS84euzKKOQ8Xown?=
 =?us-ascii?Q?m/QtGALI/a+hTedoJYM6J2XnJuBOMwHX4blD6P8MfO+p3HJvYqyzUuIn4dBy?=
 =?us-ascii?Q?fonRohwJUv7VzlPVo5DEHhe85bF/TdlH/3jOr+bgr8POmNedSNewYaOYK/YB?=
 =?us-ascii?Q?WomipbTWpe7zzzlklL2hacW69NtjqDsUKu351WHPqoRPL3NYoHArjawQisFJ?=
 =?us-ascii?Q?Lu9z4lZw7CumtF2IEI37mI8rTbejmVo6/GTZ6K08i418fqdpPgM4M9C60zmL?=
 =?us-ascii?Q?UZqeG26Ek3KWRjvkgwl3t0JtIFZXHZGmoVJBPk3EhRnkutkGGflPDWske92y?=
 =?us-ascii?Q?HNPa8yarXC8dJaD3bMqU4gWLWBkj6rQBs2YVH46KvjzhInUPh3yC7Oo3lRKI?=
 =?us-ascii?Q?VYXQW8kjdsFraCaySI9QUO5YwpGIbaY+GaCY/w9ISl3XO4DocKRY1HAYHcFG?=
 =?us-ascii?Q?l4TD1m1uFlZwZaAqizEqidZ8dcC803J1pY/JFlKC1RRRCika3/hsLlxIEtQW?=
 =?us-ascii?Q?1Cwz1Y2t2wNYCL1b3gc1Bvo2zpBNvcQKzN1pftXGUm2m6icK+Ts3x+mFMGGa?=
 =?us-ascii?Q?w4wGfw8zBbnPxOmKbq+uUBc13KxusTM+ypaVdTCm19v8rv51GKCwa2gx7aTC?=
 =?us-ascii?Q?v0DXyWiJFCazkxL42DgYwwDUIVeVVk7QR+Zh6KruvvRKA7wPzhc/WskDF3bv?=
 =?us-ascii?Q?tmXWYhHcuzgcl+9XB6n+PPsEbyosasRm8jBP5ZepDEmWgyhks8jsBcm2PzEs?=
 =?us-ascii?Q?8+Wr2O3fDF6qA1gkb1rpZJnntL4tFHYQpgH8DfF54yce7nuhKP6vqpknbKqZ?=
 =?us-ascii?Q?zmSjcExZEXzIEUwmm/lgPxTg1J0kFxC6Xk/EBeGzN9N8RPneV2zZ2C8Jd4Dg?=
 =?us-ascii?Q?c9mPlSnMHbuDX2t8WeJJ3ss2L3pCtzgISxSn/VEM2xpRmrvJX0GbLoy8SPQq?=
 =?us-ascii?Q?T/PO60pyo3k7Q8L17pWgWSVTa0NZyqxRD/z6cHeQk+2xtftwvAQJ+jhZPjTS?=
 =?us-ascii?Q?csYunrni5sgwuLTONjCp3umhGF3obccbbxNIspyfXPiVvFlvWyxO5M6NYe8p?=
 =?us-ascii?Q?Hh8H50+64n7uPlI8zK4j5pAT0LIw8XwEGS1oZkaQqoUI3W6m/nO9T5em/WBH?=
 =?us-ascii?Q?eVCYg0l3dx26863vv0wxFe30kGicTyyEi2jhBfYr5bAkuDurJuIUpwT6ixI1?=
 =?us-ascii?Q?i3W2LWbXmiuBD40d06Y8RktgiozRsS/PlDA5ed0cvo4yBtIm/wV7ahEomqZx?=
 =?us-ascii?Q?o6QtnfWYOrX8GrL0avohrOQFbRCrfnDh1AnpVXExtylgU3Lcy/2sSrn3x6Gy?=
 =?us-ascii?Q?CnOq4JLLZJsfJOpr9x/psaDKGDOc9JTyFVNl2k8FmS6dOjmWYoMg6iMtY+fx?=
 =?us-ascii?Q?k1AwP8MOBsNNfwKjYNlTgj28QGH6TLXpUwdYmpzpNrK26YcxyHLabw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jRlv8uYDkBLxkdFhCrEZ8oThGieIqrZa6Di2d5aV1YaNy2QxB7oM++5DqPOo?=
 =?us-ascii?Q?GFSPVGceH/YUTuYtNos64mIij99RDE0GbINTc2W3pcyxC1bEx60XYQZzIYRH?=
 =?us-ascii?Q?IyHxem9ETuU2ZjXlFtw4saTWObbYLti+cjBQN04AwkFBf0mz0mU+cuRGDaN5?=
 =?us-ascii?Q?i3rcdEeIE0ODAV+8kWTfvQPx+K7yKpy/gXnqPb262Er+emhXM+d787a9z+gF?=
 =?us-ascii?Q?Dd6s3B/5Y9Y/I74nKoZeLV1ObQbGEcdtLg6dxP3J0x9iOwjEKppseU38HGVW?=
 =?us-ascii?Q?a/qnH+AGhkls4akg7r02xGE0DkJeXc3Mdm4HCMNwhxlSnd1OdL710PVUtQRd?=
 =?us-ascii?Q?kbgDi3eE2w9FG9kPdSyY/QdeXAAhg2kr7QlAM/Nj11HJupCNZvU/DD9CMEql?=
 =?us-ascii?Q?jj4o1zJGc+g3/dsaNuNTteJaMPkm4wTbu5gneKmbvQwmEhY6s9/BKo1+tSsl?=
 =?us-ascii?Q?CvpzUAZ6SkUp8h7UI5kV9wUxixB9+EpBGo0Qk+/VNSOvaPG9kH8T0X4dG+04?=
 =?us-ascii?Q?TgGIsPwXvSkyQtMx39bJoxM8d+WFfJddaE2Jj3Z3mBa1j4V8/DjBI9E/0YBH?=
 =?us-ascii?Q?Fylvv6hlP6mEFhJ7iXyHefjcM806jy6Ov5CgUX5WySEXFYBOLOFudOfkIHvA?=
 =?us-ascii?Q?cbTjPt/BidSDX+utczQUcfTjSNg8CTadoql2+u2r2dkvwaC6t7tAiL3rR9QH?=
 =?us-ascii?Q?fh95zGidDTtdR18qBT0YLqDaPCNRPDKKUYEmMYMUPneARzYh2Edb1qOqyIgg?=
 =?us-ascii?Q?zcisAc/3aZr36JbzjZFdLJkFLqhGX0x4j0ON9vXfRXlD2Ikedhr8tl2v+ILq?=
 =?us-ascii?Q?vu2MqMFkEnPCB+ecd84W3WEEpC1nrJPHGmKRcb7KWRc971OknJludO12g13g?=
 =?us-ascii?Q?2MkGkuSVxSY9BWWG0MQuBexz0N+nnN9nq+FpKlH1h0eph6cf+U+VQpL/MgTt?=
 =?us-ascii?Q?wx1TXMapwgmc/Y8OAyYFQPCaZLdmCRpi/cMakO0ghviyxMd9N5xL/dhFn0IT?=
 =?us-ascii?Q?LvPMo8QIfvDsRaaTS09W2HTMmfxGn2a4hldVJnKKvYj0C+rchiOkexal2Yhw?=
 =?us-ascii?Q?NLiSNSYTIoCxJdb6PvLxh77M+iqaPnJxYC2UpalOI5muAsSGnHv+FwfAZCp4?=
 =?us-ascii?Q?aujkCoWQl62pjegJdgWPMU8nlr7o59XV4BH1qtAYLKOJnRF3Pja74yqvlYjA?=
 =?us-ascii?Q?xceVLO/bsa9QKWLa3FTHhYWTUERDXNA5ro3oKlsEOg+nHZJuWwy3z7Fca+vo?=
 =?us-ascii?Q?5QVzvnsJnzLGcZIvtDBjl5RhqHXWmE8FWknnw41l7QYCAGjcZdsHxO2u+ET8?=
 =?us-ascii?Q?/ewmoh3v0Sy6zSjxcYqLlZ0TtedOnKzE20pFuoqtA8PCIGehi3VZsF/B6AdD?=
 =?us-ascii?Q?67Mf6ZcHiAd6dYPXgyQYYhBqrm+0yqON+Nm6qddBklSyZ9DgJ3ANwmueXasU?=
 =?us-ascii?Q?aeesnC+eKWAP+f4SXZYtouDGNsEqNVEn1ern40xIx96znygNA7a7aPbI38yx?=
 =?us-ascii?Q?3O6wTMCKYjnF9UjpAxYa+LDuehhMbTCKC1iUH4+QpUfqMO1kRwrf3Tw22zKx?=
 =?us-ascii?Q?sWfC/E3pr72wI01TDe4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b48cad-f137-432e-d56c-08dd9834bf21
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 06:57:27.4036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIPSrA5bBJtFAkkbTbmozPyO3xSZyxjyfqkkN/OZ9NYD7Wp875ynVSCkUuOXDdHf
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

From: Vanshika Shukla <vanshika.shukla@nxp.com>

Fixes the uninitialized variable issue - reported by NXP internal
coverity.

Fixes: 1182b364312c ("crypto/dpaax_sec: set authdata in non-auth case")
Cc: g.singh@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 925d2709d2..5995eb58d8 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -3576,6 +3576,7 @@ dpaa2_sec_set_pdcp_session(struct rte_cryptodev *dev,
 		session->auth_key.data = NULL;
 		session->auth_key.length = 0;
 		session->auth_alg = 0;
+		authdata.algtype = PDCP_AUTH_TYPE_NULL;
 	}
 	authdata.key = (size_t)session->auth_key.data;
 	authdata.keylen = session->auth_key.length;
-- 
2.25.1

