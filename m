Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1599DC61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 20:33:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1F0A4025A;
	Fri, 28 Aug 2026 22:33:24 +0200 (CEST)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazolkn19011031.outbound.protection.outlook.com [52.103.43.31])
 by mails.dpdk.org (Postfix) with ESMTP id 64F9940151;
 Fri, 28 Aug 2026 22:33:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6Exr2rk7aCaNfmYZj5XVUSWfIw5WjGkblyyf0VRP/y4ihw+frkXY2siyP7MH8LS72Dw+5Z5SFJckb7FEi5As1KYVAJ3yVsDagGYwUczBOawa4Y0IAdDfuCe6KUbj0ArzvVBv3Cy1mqmcrkf7bITX3JwlAggSvL/OlJcNMemP0s3iqzu/00k+PzDqj5r2LR7lNtbIcMsQUf4jCIbPdGdEiSqvKwphXZwqdLqkJROj0kRi4jQywEyLhXsvmZsMLSxOOEah/5AuVdubTO2BviPUOOMtqicz3uk9p+KdQzRAEvPon065zY5QszTswMre1GxwEG6gLYhnqQR83e2ZxH6sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lce1VOx2cVIcdq8Le9KpnKyvLqVGhQMPxY9IPVznV0Q=;
 b=uwEL/7MA5FBd4DF8CPpdnHQVcpY9HDLV81Wlosq8bj50zUI0vV1Z+WYRSKhM7q8omNbWweOJj9D3UsrKolhBNugakk3kLJetslY67iyJqWPbs5vvN1EK5kylJxUce32TiWzMbksG3FcAryD2moH4gqomPjmNRZBCpFIQDbBsjZipJiMX0ByRUg0j8FPeoZJobGn3HO//ERMQrk8eTdVe861akRcbLrrNzZVOeVsEwPQTmKyn90gXdU5/pQNQlAo9hshJBryGzmmm11Z2gySdH5XHHBa2/UpeYVn5hJuTt8RvqnjkqIGm9H3qo5ZJ8PetCPUY8IBK5p+G1r0AZxhljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CN; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lce1VOx2cVIcdq8Le9KpnKyvLqVGhQMPxY9IPVznV0Q=;
 b=uUix+YXfZQjJxMgllD9TU8PpnJswNQC9A14v4Mu4bn3BzhN5zLJ2r7SJ7PZx90LN1LTyzysriVMLYU5iS+EH+Y6vpmXzWynafwEKy9nbccDhpaUaEqnDLx/mQFLkQMt/HvZbrclZ15uv8AQi1MIJgPHD44uKnqPcbnVSXw9eYHZ0hYsjM2adEbUhh3uPB72iXtVHxOg+ppd4+xwT5NKFdV26U8PbbS0QmmzA66pt2gq2zqlBSEueop9uKKMWom4z+fEuOzRV+eeqfSQsUxhrbZhu7VLdP1u2K9eGBSqZI/Z55gtRcSc38ZvXdbPGn4B3ffZ/RrPGIN9VjdugfJWWGw==
Received: from OSZPR01MB8612.jpnprd01.prod.outlook.com (2603:1096:604:18f::5)
 by OS3PR01MB8209.jpnprd01.prod.outlook.com (2603:1096:604:173::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 20:33:19 +0000
Received: from OSZPR01MB8612.jpnprd01.prod.outlook.com
 ([fe80::1dcc:ec3:dcbc:d95b]) by OSZPR01MB8612.jpnprd01.prod.outlook.com
 ([fe80::1dcc:ec3:dcbc:d95b%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 20:33:19 +0000
From: Yonghao Li <cruselee1@live.cn>
To: thomas@monjalon.net, bruce.richardson@intel.com,
 konstantin.ananyev@huawei.com
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Yonghao Li <cruselee1@live.cn>
Subject: [PATCH] eal/x86: fix LZCNT CPU feature bit
Date: Fri, 28 Aug 2026 21:32:52 +0100
Message-ID: <OSZPR01MB8612B5D71DC37D3A5F2D428DE0AC2@OSZPR01MB8612.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0216.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::23) To OSZPR01MB8612.jpnprd01.prod.outlook.com
 (2603:1096:604:18f::5)
X-Microsoft-Original-Message-ID: <20260828203253.651214-1-cruselee1@live.cn>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZPR01MB8612:EE_|OS3PR01MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: 169e4f7f-d14d-4c47-0885-08df05439881
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|24021099003|22141099003|15080799012|39105399006|5072599009|5062599005|19110799012|25031999004|8060799015|23021999003|25010399006|12121999013|4140399003|40105399003|2607281247196008|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7HHQario6AWc3vyn4kBIAfbDXoPDrt6rBXzcxxEt2lqX5AVznHXtDTuuyD+3?=
 =?us-ascii?Q?V9sUcokwDqmr4N2GitwZ9cmvgm9aB50nP3Pg5HaQGavA/q6VqnKRD3z+JjIH?=
 =?us-ascii?Q?AFRspVKnqsidHhMRTN0wbsoyVDinK4F+SSLMxwBGvoxgXEvVqPa3Y3XHEI0Q?=
 =?us-ascii?Q?OLFaFpYRYZEot1Jjk63djqMDGVS9HY9UFHrs1mCvPRr+/LmDAGhGeyGGcwHv?=
 =?us-ascii?Q?rEZfnJol4Vboxjwp6dHJq2FYZipP194L72hRTlHObe7FBpGiiW77qX+ayo1K?=
 =?us-ascii?Q?tKClp1N0hVTtPsuRMxJ5dWVoQ+k6fBfXcb/mipL56t898U5li+QU6CrjCEjr?=
 =?us-ascii?Q?uXrzAUfvinhX+LM+DBM0sQ++SjnRl4tHTwIQEg5Q9xLYxFZDYJwcl/W7uusf?=
 =?us-ascii?Q?I4Hpf7mZOo3zISJejEyzKCv7Db7dwno+wECkmmGLFiNstORYGALvEG9fSier?=
 =?us-ascii?Q?9V8o1DzDKWuMmR83LnW/WlUBrRdC9r29MHPlzObhivxZyDRnk8UBj5nig9GN?=
 =?us-ascii?Q?OFPehUoLg04WXPUHYz3XcIc52lb9FxdiziYiO2IqpCwI/YVBe2tJ/pSWhv6W?=
 =?us-ascii?Q?8OIWyjnoqUkUBJiCbg5+2cGm4BH6MACacgcBW1ksNEXpJjnBZVqxJXwksPCK?=
 =?us-ascii?Q?+Og0j3ftOgrvKNzRMU/cqPQPJq8pLnJZFOhl0ZdAXdP448aW1LYjIi6QcPAs?=
 =?us-ascii?Q?wYIcyvMxmphXTiXn316M7NtKwA14xD5jAm5KnlwIXjycJx/VwMZcLJ9XAARP?=
 =?us-ascii?Q?AduQ7Gg7HpHjR1OEQY6FYKta3lKrgeSin42xJC2rVkODhLEX26LBJowuaocK?=
 =?us-ascii?Q?9XW3lw6kjO0qL9F6m1bXWBgIpjGi7ljzEYAIuegSi7bwmKo1iH/CPHSmuY+c?=
 =?us-ascii?Q?Dd4YY/LN27CS2MjZQl6Sw/um74SdsbGdAJncq8qrE40hLZ/WmbnYcw5hRsRD?=
 =?us-ascii?Q?gXUmbzKz/G396hU8l/H+KFNCDpRsI2xAO4E1K8QicIgLKOLCC2063k/Ob36B?=
 =?us-ascii?Q?A3Vsz3Bh3u6QwqFoSXcBdDbFZUVYTS7PZGrz7FDzYbNMCRpf56lu7jGa0U+o?=
 =?us-ascii?Q?pTFq17ATtjlVgBjSnQbPNFSCjwoHzw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aBCtUWA8l9Os+GzEGNxIi3GruSgnQLnSWd2FaefMIdi8l5g6m51OvUPjkZI7?=
 =?us-ascii?Q?scHbdvgJdG4rqR9GU6BUVGnumGy42jRNx6kA1QKcQzLnN+GQAFUCkvqoge/d?=
 =?us-ascii?Q?tG0GUHgb2oEhFOXn7g1CThiutCN93uz029/kmCuw/H7laQaFJrRcShWnv46c?=
 =?us-ascii?Q?AmufBjaLVt13RQhz0J84nVuKpVJU05h8rtrtGVPRCnH91m2q9cdk31A7PRj+?=
 =?us-ascii?Q?PjliM6l+ePW3qfIvqGKMW6Nz7BOzoLoN5uusNpTZ0Mb1vdleFZ3LNt0z3NBe?=
 =?us-ascii?Q?KFXpBk7vwfGlI8fvX81oqegBjf47RKhXG2C07AlItUzyCEhlikA3IL8+O/6k?=
 =?us-ascii?Q?r78MZ5acs0e1O5wql+Cp6GVIo49WEaFKkrUAixrftBe6OTMVsBnV4owtQm/b?=
 =?us-ascii?Q?fpy9Fudk2Bcuz9DtkqwYmK+84f4C1O0PHgkb7yxIQAlig5zW9f76NIHPhOQs?=
 =?us-ascii?Q?IerI1rjwwdfjE5l/qL6d5YdWR36ticvjvtCXaYFbdEG5kpX3EAHZtFxNWEYY?=
 =?us-ascii?Q?jaUtHTpXckUVwQQzYUv5aZKi47x1Q0RJvb6f5gYHMFlKf1gG0kZgvXil3Men?=
 =?us-ascii?Q?C/1Cj3e4wFRYF29at1385qi3S2FkSIHXE7tmJrE00N5/jxVpPuEPqiurmDv/?=
 =?us-ascii?Q?fbeP6zlGOkMKHRpucHwqwZ1ur9nHa3JB0VvGbZ6M5U/qIqg2bnZKe0kqtw4F?=
 =?us-ascii?Q?SPLyyGs1+CzDp2eUsPTqP1978AWtU5qmLsaoYAhPnQrdcv20OBfZr+GLeLAf?=
 =?us-ascii?Q?dOR2xSzbjKBYhVYtmGH0Bpq3nnjhIYkIuAPfWin0FNrMlQxEf7SfhHzlXOt0?=
 =?us-ascii?Q?FAk7Jd7jGqeiKrLCuRblhuVXKntnug5BXI82iCv/SA8zH6XYkDD1mXG0hUCd?=
 =?us-ascii?Q?GrTaRvVLfBgFM+Khddz2MboSxtuNXN3l/d+HI70JKvAZ1zaszFVuDnFIz91t?=
 =?us-ascii?Q?6klZvRdcf4b1/b0rabVqZrE4mdVg/WEWApqswdCczr/B6LtCnkDyKAFB9LL9?=
 =?us-ascii?Q?HmsBWvKwSchJxSvRXLYoO09J7UTQ0o5M/HMHTopo7PjoLJI8o81NNUT2ohVz?=
 =?us-ascii?Q?TlhcEzZ5OBOziCtWvqMK1Z+ANnkWDrjTt/IT/I8G4t2CdCujbM4IoZ1f4hG4?=
 =?us-ascii?Q?CVwTO3JLZq8SzBdX5ZeA51FuQTK1KU+8qhuyxhqirtlXz1BPw+L11qkRixqq?=
 =?us-ascii?Q?zmRqojr95W2mCQ3u4E2hIGRNSMnSY7SNm1iVd+VcJ9yV8uzXrtUQ0YidhFqj?=
 =?us-ascii?Q?BCjJFOAIskTp7MKLxeiZnYmABRPVr0bkZw9IGsMRxUJiRZTjOoZ2EQKU+O9U?=
 =?us-ascii?Q?HGhXkY9MN/2cK/N9h1GUoC4vWAR7iSa2B6VwrEPPi3cs+iKwiaE8vEakGiiG?=
 =?us-ascii?Q?O6DOUmdDdW2EVwt0O81I9+orpmZqNUFUR/7U4QwXExG/oXBWw3yttRRzPVu4?=
 =?us-ascii?Q?SXJdI4YFLHkMo1wk3VXS8Iaq+fuozbeT?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 169e4f7f-d14d-4c47-0885-08df05439881
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8612.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 20:33:19.1044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8209
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

LZCNT support is enumerated by CPUID.80000001H:ECX[5]. The current
definition checks ECX bit 4, which identifies CR8 legacy mode on AMD
processors and is reserved on Intel processors. As a result,
RTE_CPUFLAG_LZCNT can be reported incorrectly.

Check ECX bit 5 instead.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org
Signed-off-by: Yonghao Li <cruselee1@live.cn>
---
 .mailmap                   | 1 +
 lib/eal/x86/rte_cpuflags.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index fcb3d1bb3f..fad671fbe9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1933,6 +1933,7 @@ Yong Wang <wang.yong19@zte.com.cn> <yongwang@vmware.com>
 Yong Xu <yong.xu@corigine.com>
 Yong Zhang <zhang.yong25@zte.com.cn>
 Yongfeng Wang <mannywang@tencent.com>
+Yonghao Li <cruselee1@live.cn>
 Yongji Xie <xieyongji@baidu.com>
 Yongjie Gu <yongjiex.gu@intel.com>
 Yongping Zhang <yongping.zhang@broadcom.com>
diff --git a/lib/eal/x86/rte_cpuflags.c b/lib/eal/x86/rte_cpuflags.c
index 5d1f352e04..80b71a3ce0 100644
--- a/lib/eal/x86/rte_cpuflags.c
+++ b/lib/eal/x86/rte_cpuflags.c
@@ -137,7 +137,7 @@ struct feature_entry rte_cpu_feature_table[] = {
 	FEAT_DEF(AVX512VP2INTERSECT, 0x00000007, 0, RTE_REG_EDX,  8)
 
 	FEAT_DEF(LAHF_SAHF, 0x80000001, 0, RTE_REG_ECX,  0)
-	FEAT_DEF(LZCNT, 0x80000001, 0, RTE_REG_ECX,  4)
+	FEAT_DEF(LZCNT, 0x80000001, 0, RTE_REG_ECX,  5)
 	FEAT_DEF(MONITORX, 0x80000001, 0, RTE_REG_ECX,  29)
 
 	FEAT_DEF(SYSCALL, 0x80000001, 0, RTE_REG_EDX, 11)
-- 
2.43.0

