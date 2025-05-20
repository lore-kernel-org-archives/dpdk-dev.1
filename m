Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5451C3ABDA
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 05:52:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDDA040684;
	Tue, 20 May 2025 07:52:10 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013028.outbound.protection.outlook.com [40.107.159.28])
 by mails.dpdk.org (Postfix) with ESMTP id 771B74067B;
 Tue, 20 May 2025 07:52:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoL8oRGObVDG4vHJ/rI6lI1YhZx37xk/x9tOq9z3IBGiw0jGiDAW8RODp/xKyRi/q1rFhBiC0WAKGiONbxM8Y5becgavisAPIlUUxJmTSRXeG5gZ94StJ0wAgsxUgPywLwan454rqLmDDkhXCLElUDRsCEGk4QQSga3P/ypsPMdpjeLxz1bovp1IK6VgtUUzUeyBB38+jlJ4FAPYz7C+uNV+NCjCihwYdH8N/UfBQx/HM/sbEBOJ0ahLCxvLUIJC5R7+58rVlIzgGlhNTtIghOtDjHLIY0XIlf0nAUcCk1zNm00SGrZlJXq20vF42u06c1K/HSIDeXJEOAsUhsl1lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOF5N2UOSv2pW5lEMhGqOz/OEUlYtOrlCdAR54iY7CY=;
 b=QetRMS7Y8Ta/vDWb1yvPMDDHUbbuTEZ4sY56GwU101euX2u0CSNAxE8zIgiMg9aAvA8B5AtpHQNyxDXLOV38EbOEj3sYKKuDzczlqzJnl6rW9enfaVHieyYO3hJSmx3upESC20Y0pqHc/yFyMSI+XkWNnPUTe3HyX7+laH6gkZAk9ooo2OQGeOrIC/eiiMb3Hx/Xg3wDobcwHm5LJXOP+bh6s/sHQqP/n/LSP5GgdoDmQe/+SfZ1fM4cxPjnqcmyz3AnbkASBky4mpOTZ+ITnoT8qR0/a74p4zHNxvcwRbTSUNbDtwtoQ52zIpuCTSZw+dQ45sBs2c4l3cAuLxHEPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOF5N2UOSv2pW5lEMhGqOz/OEUlYtOrlCdAR54iY7CY=;
 b=H/nMnBvTkNP6hijetpxtENB51y8L2KB1OSxHZSXTbgTTiC2dUWJnbQ9d8CuEWNODv2TjbTY5h/9aobpM5cwNB6NUiWJqMstTiM8GihJi7GyEA9lN4nFaU0ipS2f+HuEqyfeym3+aSbx31bF2WAvmkM3rmv+IdN0lNABuQhjUXjA+aREHjzA0XtkUAVdnrtDF0CpdfooCK4bbyekvW/5nd30Picdjpl7nwdhw3RL0pTHetawxcTul9ZwkaCPsq+WkxjP0z6n7MX2ZtJDwV7kw4gwt6qWp6hnNDhPjzP91b+O9NBnMXtdTDuLVxK70y8l8dMxSLUT/cIh1YHeFpabtXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM9PR04MB8617.eurprd04.prod.outlook.com (2603:10a6:20b:438::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 20 May
 2025 05:52:08 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%6]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 05:52:08 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org,
	Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: Vanshika Shukla <vanshika.shukla@nxp.com>, g.singh@nxp.com, stable@dpdk.org
Subject: [PATCH 5/9] crypto/dpaa2_sec: fix coverity Issues
Date: Tue, 20 May 2025 11:21:29 +0530
Message-Id: <20250520055133.506071-5-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9a1a3141-a2c8-4d76-2265-08dd9762750f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q2KZJI/vCp68TS43iN6ypHfdHYWBxCbxgFZoEq9vzF7FTwD2fBO0YBrJWdhC?=
 =?us-ascii?Q?nZXHqCHmG+w968PNQdwteDZeqp+SXrxfjWIwrQvoK9gXI2wrLzok6sP+92F7?=
 =?us-ascii?Q?pFsmV8eywE+pugiY7EinBPd3U1b0Iaa7r360/kYPo1JhER+LsEtesU8n/LcH?=
 =?us-ascii?Q?2zweEyZGeKfjPWRN0tvCeKnlDwhXyAz6uqZVngsQZSVozhPxHI2aMFGnHN9H?=
 =?us-ascii?Q?jgy4TsCDKM0kkoNerN4vTtU02R2tP18Ws7B6Ar6MchdmSlUirTgMmQTPmLIW?=
 =?us-ascii?Q?8M507FUt8twT9g5wcugwW7KJNNTsrPL5tPuqqCOgw6VT5ndvlkXNxgGzcMsX?=
 =?us-ascii?Q?6iONozEKtbpXOc/aRt5TW38Np7HRqSgOl17k7RaNghwYfHFNP6fwk8ZzZqW0?=
 =?us-ascii?Q?pHi3LHAy7p7Nvhiga6O4EMBLGmgEBhmojn4LU//gmiupv7oVETUqmqp/DMTQ?=
 =?us-ascii?Q?ILyNWbA95LneAd86mVUw00BzOnOyJyfW1nObx4ttikGWcs6I+tb9udZbmx4f?=
 =?us-ascii?Q?WHn9+GgIQ3bvigaxHs2sWOgvw1uNmBxUDhORiKuaewrqGVt+IA7iRM71r3kK?=
 =?us-ascii?Q?P5HDRqG0ejeAHN56hi0zbDfIV4C6IPx5GyuJ7Fc3NL0mFmCRZ3cCCVhrUjTs?=
 =?us-ascii?Q?Ppo0a0YuSWzqjo0M66wnEwQGfRl1tGt//NyVwkHMV6kmZAllfVrBa8VsPVDe?=
 =?us-ascii?Q?VvEHw+iObZukvFZ1DfREJSOerGKY8eKrVcJpWdCNpc/ROhbYmyl1HMZsN8Tp?=
 =?us-ascii?Q?4wJxrOXBSzp2R63JiP2e1/Qx94yaateML+cCqz+K2lT8+bFKJI7DYgYdJcaA?=
 =?us-ascii?Q?6gDfQOeJ8EGZh2hIah1omzl9h3rJ21jGeFAwGDiyp+kNDS5iWNyQHhh2I/Ag?=
 =?us-ascii?Q?gk6MNNndcxnz1d61j0yE0+4dhgwc9rR00cJFBCzQvGAh2X8qYsw+BAM4El/Y?=
 =?us-ascii?Q?dSLYtK04VnsMQuJx6UCUR8J6RaT0vrozDK2Tcs2QSuVMFu017xIN9/vlf64p?=
 =?us-ascii?Q?dcBelqQlU9jXMG204Tz3l9QZU6b8KYCAVPHcm4arwCekiBVjIsdxA1I7R0V3?=
 =?us-ascii?Q?O40lEuUVShSWFG5AZFfIUWM8AhDCGuL5o7S3DmyOClblDOAdn+iga+juzvJB?=
 =?us-ascii?Q?l5szuIRYVzC+wBn8f3d0ZI7NaNe3fHrnXndE+ZFawenETKSGDRfqYZyHOZpv?=
 =?us-ascii?Q?oRbWUba6A4hnBxp0CUQUFk8gaoXJtXNH1CLnQkM2FU2Bt1ZSuU/UfnOYpzDy?=
 =?us-ascii?Q?zTOaFQxWrxdLx3gDLCXLhHQgSoPO9GQg3VXHG2F4DtmUgxG5G1kf2LqtlXdI?=
 =?us-ascii?Q?DpUxPd6k/Rfq38/YSoF73rs0Bs90pjkbPDS4+of5cH2dEtuCheFTUW7iNYrc?=
 =?us-ascii?Q?pizjKAZbpHIVhGXnskddU0vHR0jojZjb+vcken8Es8Zknuwn3ZikG/OFGvAO?=
 =?us-ascii?Q?LmMdZK2AL4mBZ0rXl3Z9P2UlEhXDFMqprW5ryWGOvf7E6bnYhhCQTQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qG0JfDXG22T5ZSd4eQZ4O0MJrTPplWd80jlSEDLkem7dlqcMnG/IHX7Gn9+j?=
 =?us-ascii?Q?uvoNXAqJfHLZGhXKvG7W0pSGCHeV+2QweqOXP6l6wE7qu7OHR2psolSO7Rnd?=
 =?us-ascii?Q?30RGKTsK/tF5YkjXYOK5gO4aL4dm1SwaMsovIMwgIWLsTNwbZ7nUvuluXy0i?=
 =?us-ascii?Q?VCXpKiSjuo8hfGIVtrWlz9dCDH+7/iePVlO+DWViBlDRa2cRHwS99h+4A4h3?=
 =?us-ascii?Q?bhEbnwpsoApnlBv+jYLY1UIezAAVGq99ad40V4VN4TEhzAT8ux9QqkLxJooK?=
 =?us-ascii?Q?BSZIJpnTxbTr5qM3vWw4YpWOtVzGW1qMY9/j9ML6D5/ro5DJtrNek9vLFhVg?=
 =?us-ascii?Q?fBgl0lTCwHMxaMqAE9i+ojZmuiYPF9800BbkJ+3BioCfME5P0hRj3IEeW9Z/?=
 =?us-ascii?Q?YhiNt8xWBmzBCBxLyMv5NuPIMoseVRJZkT0POSdhjF6xuN82GMfSUVAlue0+?=
 =?us-ascii?Q?n0vJjydIkM3rwkXDsOrfkLfNGz+DvbtqOOtwrSsJBnAZKsT+RdHm67jNtEHH?=
 =?us-ascii?Q?Ui7XZzXGAI3brX36FvdjViEeEPgp2KAKiszr3rDH/yHxj00CnHMxLAXMXOkW?=
 =?us-ascii?Q?i0yKkQ/IXMlMaQkVpEBMNim+2McOeMQGivoMlmbUhXJ/j9UJPWgsdVzPw6AX?=
 =?us-ascii?Q?4CvrceDjGtdEjlvNVF4BI0I/ucbl/OaXa5uEpHthwPnFoWNCmmRTgxBzgAjX?=
 =?us-ascii?Q?i7rDTyKPQV4Epx5toET2c5ZyPoFROOeb5FW0EpbDsOF0BDFADghA03vvrOpG?=
 =?us-ascii?Q?QXdG+cXtWYrrnIf3GYhsB0vVWduOSH3GRnoiljnxv8tsuWHQ2jw8nM2uyxNY?=
 =?us-ascii?Q?gYMzDwYnbaLpbDPKRWCIXK2tW2rYpQ3V7OtbyEmiVjjsnhD8LcbFwQDUTVyK?=
 =?us-ascii?Q?7RALnWOdSTcZSDE6EXWTP9OXHyGcUV3kkUSuyRVPtcRZUT3MPYp0T5o3DBU5?=
 =?us-ascii?Q?huFbThHeE7iCOtqR07qyQpz8TLV94QyfFpF8QJy0ONcU+QsHzs4+xwOkPa7v?=
 =?us-ascii?Q?J8lHutkmlDhJXeROINtc4gsWwgnodu8qOaZmPfGdHkBg+xv2cBVvx7Z09bmS?=
 =?us-ascii?Q?V7j0uis2heyAc1SciRsLC1SHfbnbkculIShtUWq7XEqOhJeo/Juc4hD+clo+?=
 =?us-ascii?Q?FYGxNSToHHerTb2DqBkefHdGQdeBBo4Z8T+d52W5VzFq0M+gYY7ls0UNR7yz?=
 =?us-ascii?Q?epMW1MuyxD8NR8ofKIv+MtZaGJT6U5bumOLGruKEFOg/Nmby0ae6Q4p+loSr?=
 =?us-ascii?Q?+TLBHu/T81nrXH4wY3FUVKvPiIAFBrnXFFV0P3HB1eIeHFMn/+XDv5dB12aK?=
 =?us-ascii?Q?/XWGjeJlhDcNVLtxoztT9OGGp7Ff25/Isi84t+PvckLB3D/az1rsjTtMpljp?=
 =?us-ascii?Q?nQk8bBglV3V5ikCZV3gkHaezAHBGDhKsskV9qQJcDNZsBt+6ReFhYJ3cNDug?=
 =?us-ascii?Q?S1SeiRaMfZTHQZM1Sy5k4PBKoyQed7UyeDXh624YkuDOh+aeWpZMm0f3aqIz?=
 =?us-ascii?Q?QIsl1QggxScsUsqwaf25dSNewsryyJzF7d3L3hcm9doalNaxOlN1pVLjuscY?=
 =?us-ascii?Q?BSCFTGJS/bdZumX35yw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1a3141-a2c8-4d76-2265-08dd9762750f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 05:52:08.6153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0X2S+EhlMbhqL1vbahqiUCVnwueZHPG6I6ZhfU69p3QcIhUdAblnm+I7/5dcyLO
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

