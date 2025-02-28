Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C84C19776
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 09:44:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FCB840609;
	Fri, 28 Feb 2025 10:44:14 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2074.outbound.protection.outlook.com [40.107.249.74])
 by mails.dpdk.org (Postfix) with ESMTP id 3B7DE4028C;
 Fri, 28 Feb 2025 10:44:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vR0g9uF22+BQDRqmqJMaPD5xtoZznvg/T31Wu0olyftRykdCEo4wcPewev0LHqDGpYUEdxET6+ciLbql8gFINLe+oaWDa/omr/cqK/gzj0Tlcq8Q168QUgTNB/K52CHUCTYgtBFwoUKqxvNONx9PQY4UoJon6esbJtUNELnLrvj8Tpwo/27siLmwkG7u3xueLWBxdOogzylheTw9XAn3EhDG3H49vgKsiQ+GRcBUplNOA6Qs80Ywn1TAxeY3le7KV92VAEPlu3+GjTB5XI1seDvSAkl8kPr3kZBS1i53iwOJRKEV+lr4LnTwFEPolAlC32UgX1wXyXNWIWP97JQk8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4+kONNmsiGXP2oa0oVpY0jrsRvk6xFIBCphO/tVIC8=;
 b=dk1mu7Qbqz1Ja2MdUkn/vVUtX/UfZHTflHD5dTbwHmpfC0Ibxiaiu3WQzYGqM/9hqCZhNPjNZYXpuFkBQhuV+S6iFOoXeoZVZASMv7vD7PBjlBITBlWjcb3R1zuuPuJnhRHnFhstdDG8/RhoY1ryqyecFbI7tOGvnxo3S9tdwAPfxRBu6pY3TtTYnAJa2fKxtfUOGWZKTVnTa2I3wCfFjEF4G1DiFtP+1o14ItYo1BNcd7pjQ18/LJRaNav444IjYLBZ+0AhJzjwXJAHGn5NpLunp3mgpaXzaCkbCyCNHYDrbw13fCxr+pOrczRPwluZnvW70oVTI2tFhbM2ciuiew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4+kONNmsiGXP2oa0oVpY0jrsRvk6xFIBCphO/tVIC8=;
 b=Bll3mGO3/Xnpn/SxIsI/Iu0JWq3rbfAEGPusZJQLDYnw3URqeyoVbp/VUDsD6N2x8pWRV+egIxWlbk7LRI4PBcbbKOmRLOz6p0idiWy+7uCjl7Be4hXqcuGlbvGtmMB1vPfVEtRNm45NoZ+YBvQUGbgZKHSKVLEL2PYbA4Ofrsm7rP4idAPvmgVWEBD28A0QVmCGdcp385hGvJnBti4ef9Cs7vu7xyA4qjzwEkbeKNojZUx2aCBXhpUvPclNv+Jzu4KzD4mI0vvU59Y24BGJeoxDqQZrQfF/sUwceoMalqlhJfBHrbf9G+JG8TK4Qv4dZxkGAmjBTiB8ldaXkqWFgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
 by AM9PR07MB7923.eurprd07.prod.outlook.com (2603:10a6:20b:2fc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 09:44:10 +0000
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21]) by VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 09:44:10 +0000
From: Yang Ming <ming.1.yang@nokia-sbell.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org,
	Yang Ming <ming.1.yang@nokia-sbell.com>,
	stable@dpdk.org
Subject: [PATCH] eal/linux: enhance ASLR verification
Date: Fri, 28 Feb 2025 17:44:04 +0800
Message-Id: <20250228094405.1437-1-ming.1.yang@nokia-sbell.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To VI1PR07MB9898.eurprd07.prod.outlook.com
 (2603:10a6:800:119::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9898:EE_|AM9PR07MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f5b5311-b89b-4669-ba22-08dd57dc73ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3/V4GT/Sm0BM7/KgYG1hsizYY/qUg+P7X/TMZfChwk6Xuy19FkCG82rBLzSg?=
 =?us-ascii?Q?jrLeUub73dG0q9ET4TnlgDV1WuDOg2Q9x3Qw9tQEmT8TZFS7Wpo1MBw8386D?=
 =?us-ascii?Q?r42tvRN4oLXm+xOka1y4mHvHaE1q3INY+UI5RchCBf+i7KBvMV4tFU4CF+jF?=
 =?us-ascii?Q?JXeoLFPVI0BVxbfTWLgb1/8nRvuTAi+AHbgFES77UvbUUbni13+6sV2Xdunv?=
 =?us-ascii?Q?ikt4y2uKoyKHRNRAFDuebFqD4Xqg+96Yu5zEyNzbT2cfKxtMbe+LscsPGKUt?=
 =?us-ascii?Q?2qeiwGT8S/gUAIfAvh0r6oAfiBvgTUXUnAZeNnFxzL/ZswnwRQHLbxJyZubd?=
 =?us-ascii?Q?ztkQ80zrom+f5/IcZB+iXknCwoeEJGD6u3ALP8WO/t3OsYSs360nDgHMt6++?=
 =?us-ascii?Q?mDsOpv5DGIUk8+sSBY8mYke6vA4pYlgTaakt/sfMOcWbHiW8WayTQVTM7zND?=
 =?us-ascii?Q?aZ24WMJpW7WK2QY3YC3B843rRZ8PNY6w740feYml0VaYSNORucYSDfSp6mbg?=
 =?us-ascii?Q?F5WOgsq1BTMuhtfj0R+Ue5kVkulLbUCyhEUu2c01hRwama8TgRv/j9HXhlDv?=
 =?us-ascii?Q?6p/FqMyjoICWhrK8++98Hk1KhYqakizBNbZ8KOdcw9Jx2fKQp1YYzyUh/8nc?=
 =?us-ascii?Q?h/Cp9rft4t1mt0kXLOfAkQn7Xobqhn3kxJxcowdLUqDNme+aTwuBNcdDtzGV?=
 =?us-ascii?Q?QtqY3VU1eHPmwmo7dCiAohRZ54wTzoTOWUrm15zzkz1mfRS3R0tZ10sP3h0B?=
 =?us-ascii?Q?GLiYgwUJb3sRvla95RqM73Jqtn0MLHY6kUafn++YATWSe2+yCq/9I3D12R6m?=
 =?us-ascii?Q?x8ylmhZ6OzSAGxAL41YLZjK0uaV/Y14DQO0pCjf3DkrdCXVqHmkWORgLVO73?=
 =?us-ascii?Q?g1knt6M9PxgxFPJPhLvkqiYlngzfW9OVR/VKlIbim5NMUFTBnFHgtNosun0T?=
 =?us-ascii?Q?il/GEolFCygGJaBYMaxqftuRlLKqM4DVNaZ/R8eqcu4pELP8+o0eQ3L2ghcW?=
 =?us-ascii?Q?P5IFN/1FZwwpzt4hQsC5pp/B1jCHbu2I0O2DMVzJ2I2xosMRkLBN0ZyvwGjq?=
 =?us-ascii?Q?nwMlGuVuK+SpvcSYkGlP4BL17xVMZ8+RZss7b/RRa/4vpepbOEAUjLFYxJB8?=
 =?us-ascii?Q?EP2H9SUQkBhtCaVlN/BNYWXmyeWrzK1M8ZIAl1NU7ZkHBXz28G6CSU4uOMYt?=
 =?us-ascii?Q?l1SeKSnkOHVy7QYbgFoW3k3K1ucjsM62LKgSOOzFhFaHT8s8f79JFol9IkrF?=
 =?us-ascii?Q?0leeJEO68MnrC+9B1sqNYjn4QqSfOK0xn0ZxjcCUrL9puLGQvR5dvwmD/9N/?=
 =?us-ascii?Q?F9XzgmgdmoF+uLXjXAIDClmg5VpzvW48XbZhfV69dRy9FBKw+hRPxyXw9Rj1?=
 =?us-ascii?Q?11dSetdBZZtgSrUjhRwiQfFMhOwo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9898.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3wgQq5kxbcTfrP/DRHSqHOJLioNN12rG9Ev7BIZd7sS5OeOWxA/gjloSoKo4?=
 =?us-ascii?Q?WZkDnyGggh04AwGycqMQVyqHVnkBoS5ABPJEmF5pB8c+IQuNTLS67PIIngyh?=
 =?us-ascii?Q?ADfcgYGZxNs9NuO3tXoWB7FiCfLRspdnpyW8lryTA2K15n9zJI60WXPpnlCh?=
 =?us-ascii?Q?AiDaVJ7JruuiifL9AcB7yp70dbQgqx+5iXsC8ZKGki99dSq8uD3/1Jf7/taT?=
 =?us-ascii?Q?OmDKQQxPaAq2ZOY2XoVf15vRHSnT/YfuKM71CjN9qHgYoAi1JLywRdnOiCM3?=
 =?us-ascii?Q?wp7J2FYVlVOq/jUxb9ppxwODfedfVUQd/RmLGRAriCcRjwOG4XOLBtwKNrGm?=
 =?us-ascii?Q?VsHzRrl5JHuSYzr4DCYUVykYUrhTF2uI8qyJ3DF5BxfmgpDPg0TBWzu1d64Z?=
 =?us-ascii?Q?zFi5iecorJdDz2gcHreFHayPZ5t+yzBlaDUBBeoW/p5dbwPnQcuHnhTz3L7L?=
 =?us-ascii?Q?mNszyTYxsKog5EnsrXb9fe5e67xU8KadNOV316dcWDPDiS9G7K13AlRw4a9l?=
 =?us-ascii?Q?23ueXBonsyKNiWankb9JWw1n3iwxl09R9ln74sKAvcmlpddZEwlx54XMv+wd?=
 =?us-ascii?Q?xJR7kN5LSD8L0QH7i23Nc/jbVtxySXO8aaBwtCCzgGXEeadk+UVK4Xu7KMJp?=
 =?us-ascii?Q?lFegnRSi2rUyFT3MPq83BEWIUm0gdx0rxibPJuAI+b0YZ4Z9eCMnZhm8iyE0?=
 =?us-ascii?Q?WHIFU/M78ImR6G1PMW1WyqwWuMvW7A+mrPZSI+ank7CPJQF2MW+dMVy5VBah?=
 =?us-ascii?Q?2krbBr36XcX2fMsQsQ9TdjOKxlfWk4bf+qc0yAi39fxbgyriSGj4RB8zDE9S?=
 =?us-ascii?Q?fEIhkPnPvLSGIlu4oozluPEhskIUw5LC4zGmD60LwYSqg9LFAU9NuSomFb6F?=
 =?us-ascii?Q?jQOcO506W3lmJgh2OdsiISEuk3whPWj5j0efnAChgjNWrGIDW8zT7PDSnCo+?=
 =?us-ascii?Q?NONd18LWpWMqi+qcjqc3qXTD0uJs4uZblgnE3Jczpw9oqYsHuu3QCDNUlUZJ?=
 =?us-ascii?Q?iPjNXdFCPsvGsTe4kdHXhUa8fKB/Y0Y+instGKBJSGkJtbFy634o9znYv9br?=
 =?us-ascii?Q?aLjwyuLw25VGERTil5vcU7OCG5MpwcFWFRJ+GjirPznYK3e/ocn8aKdrjQbh?=
 =?us-ascii?Q?CqOzDwd5DnjRm3bs0t8ZbcM+g9k9dq7FEiLjNeoxze7gIDxo6G+C9KvRllFQ?=
 =?us-ascii?Q?ZaHqrfJ1FCVnCk+7SXn54K+cpOsS1c/KxT2+j2m8rVADZvUKzVtQOgmqylG1?=
 =?us-ascii?Q?Ltbbsw0V7jKLMqrtA9AB0MdDVQ2+nmYr8+NefyzbC6UxYdzfU3mN4wcoI5oT?=
 =?us-ascii?Q?hFTjrpF8I/lIUHTNO7Q1i2Dq8GXqwp/br17fR9gMP2TN08j1aIa951+jv/tN?=
 =?us-ascii?Q?PJZRvmNGfi9gX/emI2xxBvip76F9KK2T9wmq5f/Iy4TJfp1m2e/o+9wH0zTW?=
 =?us-ascii?Q?RhFy8V1m2BDdtT3DF9IqjXOPBllabVPE2JI6ainaZYHQKMBmd64U0Hd5sltX?=
 =?us-ascii?Q?LXzcvAsOvd+1w+FEk4KhlrXe4jhuEM8Lk0vEJBaY4/UkQ80JZer/0CurBdFc?=
 =?us-ascii?Q?rvsW0AEoJ+4lbXswmpfoyB65pNDJJyu541vbBzF+nX8d+JgskzZ8ytZNgoLv?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5b5311-b89b-4669-ba22-08dd57dc73ee
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9898.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:44:10.7497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KL0zO9W7F/07DxYPXL1oQFvGivTv9c3Y4P9qIF2DwYudwYmCRBy+KXo/W61zi2PIebZLK8v1ssFXToyJcY3WlmCWroDSXWGowsNq/0QEGdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7923
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

This change ensures that the current process is checked for
being run with 'setarch' before verifying the value of
'/proc/sys/kernel/randomize_va_space'. The '-R' or
'--addr-no-randomize' parameter of the 'setarch' command is used
to disable the randomization of the virtual address space.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
---
 lib/eal/linux/eal_memory.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index 9dda60c0e1..ab1fd83cf2 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -15,6 +15,7 @@
 #include <sys/stat.h>
 #include <sys/file.h>
 #include <sys/resource.h>
+#include <sys/personality.h>
 #include <unistd.h>
 #include <limits.h>
 #include <signal.h>
@@ -26,7 +27,6 @@
 #include <numa.h>
 #include <numaif.h>
 #endif
-
 #include <rte_errno.h>
 #include <rte_log.h>
 #include <rte_memory.h>
@@ -200,6 +200,14 @@ static int
 aslr_enabled(void)
 {
 	char c;
+
+	/*
+	 * check whether the current process is executed with command line
+	 * "setarch ... --addr-no-randomize ...".
+	 */
+	if ((personality(0xffffffff) & ADDR_NO_RANDOMIZE) == ADDR_NO_RANDOMIZE)
+		return 0;
+
 	int retval, fd = open(RANDOMIZE_VA_SPACE_FILE, O_RDONLY);
 	if (fd < 0)
 		return -errno;
-- 
2.34.1

