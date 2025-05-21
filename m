Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6DEC54E71
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 06:57:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E26A40ED0;
	Wed, 21 May 2025 08:57:19 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2051.outbound.protection.outlook.com [40.107.249.51])
 by mails.dpdk.org (Postfix) with ESMTP id 2B1BE40ECF;
 Wed, 21 May 2025 08:57:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kr/mTHZIpoPLcyfPjFexR6MZSjHvmzttjqLYco6sPBYjqfJM5ddbEBNJmaF7qHoWVcE4itNPaZb4KYzsoIxuy6UNw8UeEb/0j71Qv4Lcutm4HPkFt9lq4YtUoLNjzJC16//haRvsYmp0ScnWDiG7a+ehFJTWU4YZaDKCmW5txCMSvoFiXPieH5FhsbyAA7bg5p8YjyZ2wr1P1e7pvFnECdTDZ+OBkdvZTGKT1/fVEsiuC+vTzi8HIln/xrIxwxqtIDPger45w+QLIkLkGS8U2LcEUxean/E08KMWRysibnCDyCt9I3NN+e0Wr8Eu93CUxBnKZPhoYVLUuwPAaTYWvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvwQbUt22fVO2xNU/r/lQudgDCJNY1RFxGdxNylWFZM=;
 b=wmm132qnPN6EwCkvOsx71sE/60VB7ii3jiNDh42qFKwi2LvxiS3QgZ/qajbGmM2NPxfqfOnacOZ47BxG7wAEpyP3qu/ZeQkrz9dQSMhSh9H6cfAmLyOQKTVcdGfWljeCU8Ag+zJ56mpjZjvshjq4j1AaT6hHFgdU+6kNjR16+JX1Kj3kFvZxmMtgTr2C6rqFIUjUNhccUeqA8B6CmZRTx69LaafwDD3xZYuEt4yhPwuHBhr4SThLspk2/JcTJLIERH9V0QUQK/rliBXEmuw6Ofni2JkOVo4cX7cAZEKg+f2pZAY6PQ+ks5Z41oIKWSWa9sr5X5uyxqPBHEP/NPJvnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvwQbUt22fVO2xNU/r/lQudgDCJNY1RFxGdxNylWFZM=;
 b=N8GBL0jARlKXmG8wk9nZdttLg+r1hm/0YULLaFAQ4LR5LR71BLHlPSiMEhvGwMgoM6GIp4/vZI7HFp10dN/iIgOvGyXuEr9wkSYyd6Pvs8EX8eCMZE8p1P0G28oD6Q2QApt2BNz2FlRw/2xjoUJx+MBtneB3pEslc3v8+H4CXxT7dWaNqsgjAbF4NPBnUlIvKzIjh1Ij5KwZLBBXZ/5UkcuvvaoisGGDf84xBbSCmYtB8BnOmcOqDG4dSgWtalBt9G+IjSjNXtnRrnJoVEeVJcvrCMUNlOAo/HZ/j9c7jBAPiqCKen9RhiUMvxhjMJtpgWKX7I3UrEpQMIBbrTTbiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PAXPR04MB8255.eurprd04.prod.outlook.com (2603:10a6:102:1ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 21 May
 2025 06:57:17 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%6]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 06:57:17 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, gakhil@marvell.com, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Franck Lenormand <franck.lenormand@nxp.com>
Cc: stable@dpdk.org
Subject: [PATCH v2 1/9] common/dpaax: fix invalid key command error
Date: Wed, 21 May 2025 12:26:50 +0530
Message-Id: <20250521065658.857707-2-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250521065658.857707-1-g.singh@nxp.com>
References: <20250520055133.506071-1-g.singh@nxp.com>
 <20250521065658.857707-1-g.singh@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0072.apcprd02.prod.outlook.com
 (2603:1096:4:54::36) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|PAXPR04MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: f66d5915-047e-41c3-8d3d-08dd9834b8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ym1jQ2dzdG5CazRXZFZHUWNnWE9TdldMV2M2L1FyQjhmNll6UTV0Nzg3YWpt?=
 =?utf-8?B?TW9ka0FRT3JyQ0hpNmNYOFpEcFBOUHp5K0xOdU9HdDYrZlhOUEFwQkVuamRM?=
 =?utf-8?B?UXdmVWFsS1R3V0dYcFdzU3pLY2IyVmxkVVFJM1d6R0JrVjNHMjh4aFFLcmNz?=
 =?utf-8?B?ZjRCN2Z2UEhPcmcxTWRmcjV0MEZhR1BhbFpieDQrQkNiUG1rSlVQMFg4VnR6?=
 =?utf-8?B?ZUNMMGJycUlmMUVjdlVYUyt4MlRNTnkrTWpzL29TTm1nb2Z2WWdiRXpKQ0Vh?=
 =?utf-8?B?eGovSUhkQXJhNFBqYjl2czZ1K25BdlhzVW56elZ1NUhtSGFYRjFVLzdIRnpG?=
 =?utf-8?B?cE54SEdaVjBZZEE5UHN0UXYyS0xieWFNdDM2cXlHaGlJS2ZZVE9ub01TVlUx?=
 =?utf-8?B?eG1XWk5kWTFzKzJabStJSVhTRElVdjZ0MWpaTlRmWTk2dnd6Yko1eXVUL1Vz?=
 =?utf-8?B?OFNzZm5BSTZsMklIbzEwdlBBM2FseHVDQXl4NCtkY2RHd015VHFnSEloZTU4?=
 =?utf-8?B?SWJvSDREZ3lpNFVUS09zeExFYnA4cGVGUEJ0R3ZJaDI0M0laN0x3bElLTURY?=
 =?utf-8?B?ZXVxUk9rUERaL1p5OEtQNmdDa2tadVJJaHRPRzM4WHhVUkhtMyszQ25KUFRQ?=
 =?utf-8?B?aEZaMHk0anU1TFpodGRBc3FUbU5NT1ZGWHZneEZXU3NBcTB2U2JjQWF5RnI5?=
 =?utf-8?B?cUl0NGVpZU8vSlZOM1BaRWlBOFBzZUpZTFAwZEg0SW8weGJKdW9SdmJURGlw?=
 =?utf-8?B?MTZrNGtZdGNRQyttQXZXSzRUQmNkb2xqWkx4OXBtUDd5cVgranBpQ0dVYkti?=
 =?utf-8?B?Q1VlL09EUVRBRkNwUFFEU1B6N2lQRW12LzN0ZTFFdGtjMS84c2tNWG81YXNr?=
 =?utf-8?B?TnR0MEtQbUlJVGhWOGJMN2tjNGxrTTJDS0g5MDh3Tloxa1lrMWE0RVZ1V0FL?=
 =?utf-8?B?d0g4WWF5YzJ5YTRuVmlXVGJMMG1ROHM1S0VMU0krTkNRRHlWbks1RnZHQkJv?=
 =?utf-8?B?N1VxWW40YzFPeXJRSVJMSTVxK240UnJjbis2VDJMSnFOVUlKc1NqN0pJN1Iw?=
 =?utf-8?B?TmszMkRka1E2c0l6NVpmRmJOc00xM2o1eUFEOE1qWmhJeFIwL3ovSGFQR0lr?=
 =?utf-8?B?SUp1bzdzS3pXa2pkUWdIRFFvZko0MitHamZyeG14ODk0T2FHNFUyRUdOSlBl?=
 =?utf-8?B?akJLMGVDMFhnOEZPMnVwWk1BK0YxYlRTSS9aTW8rMFNINTY5emxKUUhFcjM5?=
 =?utf-8?B?VjQzL1NwbnZiVnhrZTlFeTQyNlVueGJDZWh5VXN0RkN6OFJHa1ZPR0dyMXl3?=
 =?utf-8?B?N0c3bVFCV2RldE10WkhRT1U0WXdHejUyS1k3UE1teXUzeCtqQjNrSFlEcTQ2?=
 =?utf-8?B?Mk0xSk1velRudFdmcXp4eldNUWJlejJlWDZ1MWt2b3ZQNkFtVzFPR1NhMEZv?=
 =?utf-8?B?cUhRWktTNWZxTkl1SkhoRzNGZE9RQnFFQXViSmdJZFVhbm5oYXFzbysxWkcz?=
 =?utf-8?B?YURwSVlkUjhSL2RybkFJUDhMYkhHTk01VXJYVjB3bm1ZaFJFdDRRMEVzRW1H?=
 =?utf-8?B?OVJRZ2FDMEdoSGhTbE5vaWFlMmoycmgwbko1WXcvMzY4MTIrbzRwM1k1cnFY?=
 =?utf-8?B?MGNtazM1dWNLRW0wZU1xM1Q4UStjYWdiTmVVSUR3T0RmTk93N0RyTERPQndY?=
 =?utf-8?B?Vi9qSVlvTDQxd3lrZldpQWhlVWg0cVBObzBhbWMvRUJRK0FVdlVPUy9IejFF?=
 =?utf-8?B?eWxmY0dIejYyWHhQQmpTMDFhbFF3R2xZdWVwejV1VDVlQ3o5RE9IOVN4WVN3?=
 =?utf-8?B?MW9DQjhPM29HUkRRSE9HKzhHcG1PbUJ5VVpZTUErTjRwL0RwWUV0QXdmU3Iy?=
 =?utf-8?B?Y3lMS0p4WVBUZGg3RGJ2eXYvSmpwbmRhZFRuVDJJZUMyTEJWWitvMTBvQlBD?=
 =?utf-8?B?QmhmdVZWUjRtMWJFL1YxbW1OOWxmL0M2UmNsbmtiZGVWOVdzSTRGWGdVRkJr?=
 =?utf-8?B?TUxBaEtxVlNnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE9yUUloeHpNZGh3Rm5ZVHhnMWhTQVViWTlRTmJDbkh3ZDVObU5pT0xzb3Fh?=
 =?utf-8?B?dStYK2RLMFRuM256Zm9GK3ptVk5kbzJ2L0ozL0JDWVlQcUovMFNsd0o4c1o3?=
 =?utf-8?B?c3V1aVFxVWZUanVkYnhtb1RSSGZaZE9EaVZIN0NTMlZ5bGpBaGV2RDlJOTF3?=
 =?utf-8?B?N2dLVjFJK1l0eHZ4cmxIRUkyaTE5eHNNSUt0SjBESUg0a0dHOXFhWEIrZS8x?=
 =?utf-8?B?MzlhTWRRSFQvWE95blc5ZHZBN3paZFNMSFNGWlVCdUlQbmJVcHI5RmRNc1Ba?=
 =?utf-8?B?Wk9zUFhka0NEZ1pzNTFYcEJBQ09rZTF0OWtDM1FEcitZc3NEY3FZcTZxZG1s?=
 =?utf-8?B?WEhZNHRvUmJOUGtrcGxkb2VISi9vaXQ2VkFjNytRZWV1TERZeEFmZDZ0dkI5?=
 =?utf-8?B?UGk3ZzlZcDBWWld2Mkl3ZEdCWWFIZHdIdjB0T1JuRG9xQWdsdmtYWDFldTJx?=
 =?utf-8?B?OWEybzZ5RitYN0RTZkRIeFlWMk5xODZuMk1yYmQwZTdXWkNzbUkxTTFjamFK?=
 =?utf-8?B?OXJDUkFZNEhaNno5UkQvSW1iOWN3VjZPVllsN1VXdVJkaDdVOEJRRlRYM0hN?=
 =?utf-8?B?V2hkOEVoTFBqR3AwcGtOWXVrSE13cXhMYkRKTDF4dlFCZGNidElsYmJVdFBH?=
 =?utf-8?B?TU5qU0h4a3dPUmx3MTh4SXNrYTNoV3ZxZ3lpZHR2WEVzMVhHRnVHb01xT0tN?=
 =?utf-8?B?Vnk5bFU3RVZIOGFSekdTd2o4Z1cwa290RDE0cHZvc3RRSFhseDNVd0p0VG1T?=
 =?utf-8?B?b2lmL0NSb3hhVENIbmtFQ3ducGdhTHRVd1VuMXM3NDJHZ3dZRnpnV2R0aUc4?=
 =?utf-8?B?eFpTdmxSWURtZVA5SnZITkxtcXJMa2NONE0yeEZiTEFzaklzSklUWFFhdTBL?=
 =?utf-8?B?T3R1UVNRbmhNVUhJNnQ5aHJhU3lURXR3aDFveEZTNzd4Yjd1alNNenZRT1BE?=
 =?utf-8?B?aGhmYmI2Q1Y3Q05LZDgxTnR0U3gwZi9zalhEbEwrQ2k3aCtwaVE1K1RFNVAv?=
 =?utf-8?B?RktlaCs4WjNPZkRCNThXdWh1eUs0S1JCZFdCYkhqYUNXN3VoamVRQ2dzVEcz?=
 =?utf-8?B?U0xxMXZQT210bWdHODJnb09TbDMzelVQelZuNk1vVGMxNWJiQ0FsTDJtZndD?=
 =?utf-8?B?Q0plVlBXWkdRTmZjQkFvTlR4TjBVZWREelhRVUhtUWlyMWlBTTZzQU9mZTJw?=
 =?utf-8?B?amY2TW1IcnNyWllWYXBIcExER3M3MWlYM05ZdEJnM2ZaVEphbGRIcjJnTzkw?=
 =?utf-8?B?bWlDVXRzelhtanZ0SW5ybkRJTHhqTk9Zc01QRzEvWDA1TzZuZ3orU2hKY3R1?=
 =?utf-8?B?WmU5aVhRUUVIelAwVytjdWU0SDVoak4yWTkyZmNRc0YrdjZpL2ZqOVBXRmZC?=
 =?utf-8?B?RkNuMEY0UVQ3Qk9aTlIyVW05L096V3F2Nm9xQXA4Lzk5M3gyYUVETndCd2I0?=
 =?utf-8?B?S2xEdytmcDduZWloWkdVMndWV3h1NTk3MWtWcGlyM1pxRXMzMG53U1ZmcWhk?=
 =?utf-8?B?NVFaRUpUbkNja0hGMFlKWDhDZTFGMW9vUXd3KzE4WXZWcmhsdGlUaHdTd0lD?=
 =?utf-8?B?YXRNcWwyWTQvVzBNUkVnd2drRnNEZktEYzR6VU9HOTZCakV3ZjNpZnVSTDZV?=
 =?utf-8?B?Mjd0eE5xV3JicXNuVVVJU0NHMGErcFJLUGY0T0RxdmpldjQ0STAwRWo3K1FF?=
 =?utf-8?B?VnZWVGRha214ZWttMHIyOEprZXZTc0l4YnNKbUVhUE5qUzJkOG40dDc2MGRv?=
 =?utf-8?B?REJCZzB0eGMwcnRhZjVsMTVYYjFJM1B4cTgxdnlaUmxPbUlkT0VXbmNKeWRr?=
 =?utf-8?B?MWY2bm1qZDZUWWNXQXRLcUVWVlljaU1NODNNY2RYSlplWUMyQzVpa0cyb1hJ?=
 =?utf-8?B?NC9sUEVvYUg4VlBqM25ybTdOajlrU2JXMm5ycnVyZ1pzQ25XSTlwMnBxbEJJ?=
 =?utf-8?B?RENhMTF1NVRQRlBKSzM2anFyVmRuMzM5RFZySU1va0d6K2tGdGpsajJ3bXdY?=
 =?utf-8?B?b1F3a1QwenFSbG9ldlhlQW1Ea2syZjFDREliUXRSbUNnVVZZTWVtbFU1L29q?=
 =?utf-8?B?VmhWMHdLdm9ZNlN3Mkl0dlpNTlpmR1ZUc3JZdTZ5ZzU5anZnSGtCbnhFdVVm?=
 =?utf-8?Q?+wqg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66d5915-047e-41c3-8d3d-08dd9834b8c2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 06:57:17.0162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAyynZxLw3RMCu/PZsEQI6ArvUkq0EDRj81VALKd7+l6zDMZp2AdIUyGXMrHrDp2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8255
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

A race condition between loading the key into CAAM’s internal
memory and initiating cryptographic operations can cause SEC
errors in PDCP AES algorithm combinations.

To mitigate this, the CALM instruction is added for the
12-bit SN case, and the older version of the descriptor
is used for the 18-bit SN case.

Fixes: 6127fff842a7 ("common/dpaax: remove outdated caamflib code")
Cc: franck.lenormand@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/common/dpaax/caamflib/desc/pdcp.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/common/dpaax/caamflib/desc/pdcp.h b/drivers/common/dpaax/caamflib/desc/pdcp.h
index 9ada3905c5..f4379ede2c 100644
--- a/drivers/common/dpaax/caamflib/desc/pdcp.h
+++ b/drivers/common/dpaax/caamflib/desc/pdcp.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause or GPL-2.0+
  * Copyright 2008-2013 Freescale Semiconductor, Inc.
- * Copyright 2019-2023 NXP
+ * Copyright 2019-2025 NXP
  */
 
 #ifndef __DESC_PDCP_H__
@@ -1981,8 +1981,7 @@ pdcp_insert_uplane_no_int_op(struct program *p,
 	KEY(p, KEY1, cipherdata->key_enc_flags, cipherdata->key,
 	    cipherdata->keylen, INLINE_KEY(cipherdata));
 
-	if ((sn_size == PDCP_SN_SIZE_15) ||
-			(rta_sec_era >= RTA_SEC_ERA_10)) {
+	if (sn_size == PDCP_SN_SIZE_15) {
 		PROTOCOL(p, dir, OP_PCLID_LTE_PDCP_USER,
 			 (uint16_t)cipherdata->algtype);
 		return 0;
@@ -2747,6 +2746,7 @@ cnstr_shdsc_pdcp_u_plane_encap(uint32_t *descbuf,
 			    (uint64_t)cipherdata->key, cipherdata->keylen,
 			    INLINE_KEY(cipherdata));
 
+			JUMP(p, 1, LOCAL_JUMP, ALL_TRUE, CALM);
 			if (authdata)
 				PROTOCOL(p, OP_TYPE_ENCAP_PROTOCOL,
 					 OP_PCLID_LTE_PDCP_USER_RN,
-- 
2.25.1

