Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2602EC3ABB6
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:16:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16F9D4060F;
	Mon,  5 May 2025 09:14:37 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id BD12E406A2
 for <dev@dpdk.org>; Mon,  5 May 2025 09:14:35 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2176.outbound.protection.outlook.com [104.47.17.176]) by
 mx-outbound10-142.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjSm/RUd/njik0CbuA0dfX6+8cFbbJlL1sNrkmiLYL+UrkyeSOjp7gxPAFAoxAPaUD4cn0WEevRIa/xdItTMfdXPWcl3K9iVMarYFXinhPOA1zOBrcy61gmCthvpR/50QQ+wBHwqOBMxw1mVqfTvnBkhMl2pJ66dv87F3+EJWoxYajDWw0iWye19wiJTbl1Kn6bvZ41pGpYi68lNnK9Z+Ax+Uszjw9QhDl4n65Y2whcRuXkAaoXpDYwGXeHi/enIgFPggBTvK1UL9/ofNnT0ehI57jKgtcskTCMywHHLqWm/B2KhjhST1C1Xasf7G2g38HCF1ItbLIQ+nL3TvGfcjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCeFC95RdpYADCEkC1WlfZ1rrajHYUVWIkdt/H8bV64=;
 b=S6K0ID32g3BKVbJEEQbqaJ68te1QN92n3ewm1UYy5lSUy9itIXIQ736jKFywoB6xqKS0fb/yim1jzu99NnvIooR9JuV72WsQjP6wDOghEqyr4yxZNeHxkxHAdbb2VpGUCFO+ViWrnNzmNC9l4uPyvkBC0uu7v2IjAQCkhVcfbI/S0C+vDRgK2XvyswNw76eqalD76YKOPyzsJ2VAzPrJD64XY+cWPJ1yXDrutX5RpE4NaGubikuSXg30eueo9ugPtYLVeSkNGM/SpozIZ+ILJBHQOLzm7MUsyU6bH59KvBChEA37QgU4PJdBx5iKwwb+keK9wz/OxoOtV5CwXW9WbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCeFC95RdpYADCEkC1WlfZ1rrajHYUVWIkdt/H8bV64=;
 b=jv6qAdqtCpP8CuX6lSCLAeDRgZEX7gwOgsZUXK1ATHX/s8ZWUNdJnQP7J+ohOohSgL9aumqPjjyZCxDD9f+U3mP6q6DYbTtdGr1EXv52jGWPWMWoT6N/dYAJ2y8RV14weDsAHKhsxISj8HTYEIffviAzN/242EPqKK2Zsjxm0+w=
Received: from DU7P191CA0018.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::11)
 by GVXP190MB2037.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:14c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Mon, 5 May
 2025 07:13:22 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::79) by DU7P191CA0018.outlook.office365.com
 (2603:10a6:10:54e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Mon,
 5 May 2025 07:13:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:22
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 14/26] net/ntnic: add explicitly specificator
Date: Mon,  5 May 2025 09:12:54 +0200
Message-ID: <20250505071309.586015-15-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|GVXP190MB2037:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 08f29332-bc62-42e5-3bc4-08dd8ba45221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gPaRuo1K14ljYBseDWu39+NxudMao/GSKDwXN9TVu/fL4qp/WThNgKUGYKIb?=
 =?us-ascii?Q?gWqU8mV6YKMeBjL3c+X0ZAIAwh2CWoWF4QpgpBacZraas6bbzxY0Y3ORmxdZ?=
 =?us-ascii?Q?piBpcmRLlYwHS5WTsQFSdCOdSGrEbs60nUqMSndnt00KfwB6PKweSa+nbXCT?=
 =?us-ascii?Q?asK1XpLT5gp3OILIPwTPk0D0VnmaJojoZhDka588mvsCI0uwERKwtLWh8a5k?=
 =?us-ascii?Q?Smv8g1LXIPQLvsILovI/Htq2BBS2w1/vDjIyT7tLALUA7eYFDo2tOG+mXLIY?=
 =?us-ascii?Q?v+UeYDdgotokTtFNP4sVe+020icSU8ShHLn82L7n2hDs7BLn6jYlZO4NUVn6?=
 =?us-ascii?Q?2LuQVNZCNW+ylq5hyIbPvfe/ni8BqdALk8i9jF2QAywqtnlrO6GFrb0e9pns?=
 =?us-ascii?Q?HFtCjDwbilAbfx6ttWt3lRwFGD5/yJVvFlqxPtAi7WByxTeYqEUtR4XrRWPo?=
 =?us-ascii?Q?PcUgAE3F5xvd9Jtf+bg4bRRt47wdgmb+UWHMEAsnSar75JNJNHdL1/XP9qE4?=
 =?us-ascii?Q?+WZ7Kc6ELzD3QF2q7MYoFI5XczQwLxr/jEb2quu3QKlH9PsyjR7CPQ9uIYx0?=
 =?us-ascii?Q?CrHso7+ek3Cd1YsNh5wcIjN2OelSoAzYkJcRelWvGa3m52V0Lo4J3SH9MBGb?=
 =?us-ascii?Q?LdHr59mQeFKYYcifawKrCqeeUWsiB7tYkh/5Kood0uq6uljKtMZumXrQLCMf?=
 =?us-ascii?Q?weJKDIW7WVpCAe50/95uvqf+PkYTwrapUAc+UzWfOkgo6U8A1yIw4onL+Ptp?=
 =?us-ascii?Q?n18/gf3qu5VXEgJtIVSs+oC9cmc+nycYu+7nFt5ieAi+LR62AgYxdpZUfCg5?=
 =?us-ascii?Q?76vC20p71ay2qfw4mF4Br7qDANEfC/n0mKsG1L8wNe39ctruBq7tFghWoA0u?=
 =?us-ascii?Q?1mPRJlucaacuEAFkBmxws7FvBwgKoo7Jgegg1bg7it2lGJHmiTm8jD9/0LwR?=
 =?us-ascii?Q?i/MdisvqRy7HJwYIR3XK0SJfAXgvCFprjRW3AsYNpXAZfu4ffftxB8DLz9Cd?=
 =?us-ascii?Q?9i1SUJuV/rkEXMoZr8+FZIq/qtf3CwFbLgbIseTFJ9DwJZemU2ZaaOGjorAp?=
 =?us-ascii?Q?WqGr2q4xEml0KBo2AA6KwWs2KW8cMcaB/BYOExputg9OuEbWqtnxYoCcLr/z?=
 =?us-ascii?Q?5/ogc5cAnt1CtZLmRKQFynlYwIAMf/x8Z5j8SaI3F/QxW8HUwNLxNwJrW2vY?=
 =?us-ascii?Q?EHPejZiZGyvIomT1pTEgfgs+1W7yhhErGtAo5N2fLXw/b/oLb65IFnwEnIly?=
 =?us-ascii?Q?6og5NdPOSVOo3QLG/kXVrgzfbeNANcRzV7DPXdHoOOIDmzH7Ec66KLZLS6kI?=
 =?us-ascii?Q?VqrXZYIHkq2EhZGpGFZdlwwQCCVNz0VEqNuLCEfI9m727I4+6pSIPZQPQcw/?=
 =?us-ascii?Q?HRfXUrbm313DvkKCaJU02STFkUNRzVw0hmOvQ4qH3v+bsznkniRv4nsFrgNB?=
 =?us-ascii?Q?v8ft+bGDnymGjEu95Avp6TpJEq+QusRTJnbJYIOeLrQRFSPWK9Xk5+virxLw?=
 =?us-ascii?Q?D20aiakvOBNjEnGN7Nx2MLdqTxdPYo7cTsbb?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SVq0Zh5vgtb8QR2PNPAo97WVwSHAs9EzDMSMLJuvmd25KpVN9dD8tnD1yeT9YpWDmCu0nJxL6RPK/TP2FcCmxq82NDd6USLT0CTCf4EWqnSe3q5Me+1jML/iw6LiZwwrpppoYzf/BCKABZUT2opxcbASp3oFBQx1FQ2dqdbkOu/7AkFJRGedIpgzjkwziXBPPKHiCGWftr4o0cYxrocK3ebz3PZRJU5OYykJmXhHHE//qQtGmonJPt1t/YsIMukUiSrhHuFf8Su865aAF8k/Jrz4/nEL0sozdgyfMZ8j0TVA/StWpfXOyGjg5tfHo1MPAom2tRSjD11DS4e4CC5Qjfn89iVP0aigfGVGTYmf2EyMifVui7GxeQjP0qI4spFttGAdm0GVktUlo26CCdzwXS+jCI7hDlTKgm3TECryv4jYpR2dzOG0oUsn5HDJ3PURUb95bN8C+el4c+eLJPrsbs2xdbNkev+e10aEoT/ivSFbLWjyBzrtOPxy3nX3w9deLO90KcLiTh181eO0JPjDFlxr2VTuvmddl5Wnl9ixVUSSwv0IFqd7uWMOBRShEDMw2P7iWue2mJpI2jjW2jq4zY/gnESh66tH3wKZg/7EuskOHksj6XYjwctEkgmOEclK17XvOXBmXJwe+AYPiDQRtw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:22.3383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f29332-bc62-42e5-3bc4-08dd8ba45221
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP190MB2037
X-BESS-ID: 1746429207-302702-7673-5196-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.17.176
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGBsZAVgZQMMXU0DDJ1DLZNN
 E4xSTJ0NQw0dw0xcDSyNLSIM3AyMJUqTYWACawr7FBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264372 [from 
 cloudscan15-74.eu-central-1a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

Add unsigned long long type to the value to ensure that
the value 1 is explicitly treated as a 64-bit unsigned integer.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../nthw/flow_api/profile_inline/flow_api_profile_inline.c      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index c674531396..3fb867c993 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -114,7 +114,7 @@ static inline uint64_t convert_policing_parameter(uint64_t value)
 	}
 
 	if (shift != 0) {
-		uint64_t tmp = POLICING_PARAMETER_OFFSET * (1 << (shift - 1));
+		uint64_t tmp = POLICING_PARAMETER_OFFSET * (1ULL << (shift - 1ULL));
 
 		if (tmp > value) {
 			res = 0;
-- 
2.47.1

