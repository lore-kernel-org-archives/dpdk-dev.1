Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB69C36000
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 13:31:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AD6E40DCA;
	Fri, 21 Mar 2025 14:31:51 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2080.outbound.protection.outlook.com [40.107.103.80])
 by mails.dpdk.org (Postfix) with ESMTP id DE7AF40276
 for <dev@dpdk.org>; Fri, 21 Mar 2025 14:31:49 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFhpwqpXluYJxNqA7IvBN9lvd4pY9wJUOkguWj1Rj393nHpo4Lht9TayQr0L7uVQv3QeUnx6mHRt+5vDFA+8Ca0N+C0UCbYNMeQwn1c6yo3PZDGlNHPY8Z+qpFguxbZaravb0j/YcJ5GfQeRwPENfPDfYGZmrNq9FhDAv+0Xk73xzmEiYIh3H/awpRqVqyK6nlB35evp6Ye2oy3ez7F6vUn9iTF8rcZJeEkfYn/6XJlKmMz8G0FtGG9jh9Bblbk05B3w6wVmytd7Wlgg31ynwy9xJWKL95uUSDNxUWNDz5xngW4MJKVcaN3XxN9lBwQUIs+vtIXwwkO9JsSwPRrUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9ckM+1why+nnP1o+3faa4rZHbv5S9tJR1tUSELhRTc=;
 b=fgZ8oYAQ9HvVC4ZwER38PjPsSp6FLmmR7RcWqDOhmErqXUgsqihGTZrWsfiz3pKh/wzw6WNqblq6aC39pua3y8Cjx1ZCilEFgMcpkrwOpmUJKx1+y5KttMAMIXZLlQZEskn0xjDLwzVZOs0/4z5iNGZJD/zTWNTyCf6WkjjHQ6Wh28pSiCUcDiRMsJUMjE1FXhPpVI57UwLyKt3E1bZM+O/15SXSD+t79qiAN5hZCu68UccM7i8/EuRz024dKmNlUSP+U1YIbiw6giRE9ItKbzzN8YgO8mKURGbfTbhZLX6+VTfoaudgERCJ2aHfWiy/zq4a/MIxywQbhb9lgufzJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9ckM+1why+nnP1o+3faa4rZHbv5S9tJR1tUSELhRTc=;
 b=fp/+cbPCewphVEQZyAImxfpo2F5qNsPSFRXlFe6DC1sY0h0hDkTX9dnjbHQVW5xB00qXebak3A66qEu37xVumlUqZPnfARJWAVNJJgNUE1zM2ecin99CgDSBV2zdic2iNhRxK9zB9MK2RUZddeLeQ0QBTGb7PWox+XAxJKA6ku6z/FefxeOSCIHvA7rlARXlEpaZrpf+E4luyUFPu4n3+Kfz2FDYI5nulA2Wj3FLcRs7FmPaGEnVN4QVXdKVGN8MCG6cMVT2db+t8c7V611YBgG8mTgCEVvyFOiyHjsnfQV8ywJh3i04YPbKiZaouy7IQASNmTH16aGlKI/1VESaOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
 by AS2PR07MB9519.eurprd07.prod.outlook.com (2603:10a6:20b:64b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Fri, 21 Mar
 2025 13:31:48 +0000
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21]) by VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21%6]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 13:31:48 +0000
From: Yang Ming <ming.1.yang@nokia-sbell.com>
To: dev@dpdk.org
Cc: Yang Ming <ming.1.yang@nokia-sbell.com>, bingz@nvidia.com,
 dsosnowski@nvidia.com, stephen@networkplumber.org, julien.meunier@nokia.com
Subject: [PATCH v2 2/2] net/mlx5: enhance log file path
Date: Fri, 21 Mar 2025 21:27:50 +0800
Message-Id: <20250321132750.4237-2-ming.1.yang@nokia-sbell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
References: <20241213092444.2987-1-ming.1.yang@nokia-sbell.com>
 <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0174.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::30) To VI1PR07MB9898.eurprd07.prod.outlook.com
 (2603:10a6:800:119::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9898:EE_|AS2PR07MB9519:EE_
X-MS-Office365-Filtering-Correlation-Id: e076cc34-8738-42fd-ef01-08dd687cbb15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dFdW+x5mFoocIzsVre78IRziehbEr180+0zewrKTAFsesqCtvk1RSEIHBcnu?=
 =?us-ascii?Q?3sCGsVMw/rsOcLLjlkXlJ7vxQl+Y2XkZS/D4NMfX0IAw8G+kSpPudhonkZYE?=
 =?us-ascii?Q?2zKPf6PqPNSz3LHFmOEawKdv2DOhoJwMTefo2zenAF3YgXBrJUIO8WVknCDh?=
 =?us-ascii?Q?cER2pIJxhgU1GHX6lIoU3xyT6It7S55qRA5Ier2PT3hOPmX1+TUkLWWJhit+?=
 =?us-ascii?Q?Suu3lO8fMwvScRdS7VCGVn/EIUfIGCrELe659Ly4i3ROGLdlawps/plq0RUQ?=
 =?us-ascii?Q?vFWi/WPZUMYWbH5c19V8oTjV1k7vFq8Od2SUw6G+3r9x2sbt7wzpWpY9c3h5?=
 =?us-ascii?Q?3n8vWmisY0uVHargpOpFwV5/R9cjwP/OvDmRzenT8HmOcs9871wHs2JUzc2A?=
 =?us-ascii?Q?8Vy1wfR7GsSIejTBqr6TSbyOS/J+ePmiqv3noXaKdyqRP0RpQW3wBXCQ3HyY?=
 =?us-ascii?Q?Z2ahzDZ3mW2HVRlW1jF3ApvocDemsNqI/qjs+viiHouKKnIAImjKYBfv5xV8?=
 =?us-ascii?Q?ZoQxSqIWhTUW3k9pVTFUMPtjTpkcNqzG9s7fyj4PTGX4DOFtIkUbzReoG8eO?=
 =?us-ascii?Q?PM4xNlEGao2jEsRHL8st5Hb75SY7gIjBNlL2tRETyF+xu9m+LWnNXxc+BLe4?=
 =?us-ascii?Q?03skU7R0xCW7v5niTArHDUPOhJ9YolWR8XE5DNSpnXho1aKbW4ChVRdjMTFp?=
 =?us-ascii?Q?V/weIJAPZa038wRfDvsc/vEbb4EJFMNIyaLnkNopzg25yF+qqboS3kgD5Kck?=
 =?us-ascii?Q?wIOQDPb8tl+Gr2lU6JpBrZ880sd+YQH8b/tRzua6TBd9Gp4E7GMfY2T0ZVJH?=
 =?us-ascii?Q?BsIsUforKpzPGe71THt5QNajrkX5O5hwXMmn04Mql8+gw9m6E42CfgVhHEje?=
 =?us-ascii?Q?n8DCLcWDdZB38bTXUu8wqGA2Dv8tPrf6EwO7FbgQDUnTRko7iaTDKdbiUUhA?=
 =?us-ascii?Q?tB+ZiSaVH9501dRUD91vHYOKlpgrR5CQ9lOR2sVaF2ROM6rT4ZO5ZNjPrbPC?=
 =?us-ascii?Q?XxeR7LppcnYe0SQFFBosBhGoqEiMsbmsHIJKKhmRNoptA12qcYWpK9NLBc3i?=
 =?us-ascii?Q?VbsAPDIorPt2hDiOfQH/hxOoGEWddNL2eSR3UH/+kKlubhZhExLqW15qzJAZ?=
 =?us-ascii?Q?8hGjw88vIlbI8+Cj+JLgHyI0n5d23COYXyiVSu/B0uTkRA14tWBjuj2lcQMW?=
 =?us-ascii?Q?R/lMPQzJiMKHhpMlMhRJug/FxTs9NkSVButeOin9JMGOV4YUURzx7gsPrvXZ?=
 =?us-ascii?Q?GySeU7GangTufs9lEemt/C5+y0xGH35VhMUwiDg9Lgrdc7vG15VgST2epz4s?=
 =?us-ascii?Q?fhkksTp6iYcnvijf77JBDDwRyOdwzGGE29zTO3ZnNY+WV4xg2NMHV6Ov7KhQ?=
 =?us-ascii?Q?+zySYy8m0p3znQ0kCYgNg9i39CJBpzn35bamlkKaYVkKjG/1E83SP56VBcKF?=
 =?us-ascii?Q?r2cG5IJV428=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9898.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ze9GjL4fUbiTL5ONnPBesgmLTPZTEI5hCPH+f1toRA1dGAMhGgRcqDlwJzWa?=
 =?us-ascii?Q?QisII3Dud31RShDuMNQuTIQojXwSLfwIMwt8J/cxwvNv8uQIp3ZHus73hoEZ?=
 =?us-ascii?Q?1JXkc4oUDUecRRpQ5pEHDyM5pBuitvDB4Ybw4D91EtFGb/hcSCYiGTpsBiIR?=
 =?us-ascii?Q?I697o+FEzwFQrxpMQ9rg2cX4hJIK9Vp6S4WCJenGBpN8diZ7GEpX732Ba+r0?=
 =?us-ascii?Q?1fSvFf05rmrLerpNMz06s7N5KjZx/OsU9/9u1uglp0DK7RPmXjwLmH5Fow1d?=
 =?us-ascii?Q?xgSg4a9sFLelyFu8adANuziNwE0fOfnja+Sbcl/G8zmWaO9D1Vfxc5TYLiFg?=
 =?us-ascii?Q?p7avH/I5wda6Q2pIuszSCmU5tB7jni3gXU1VM2uLAyuw95zWdW4XMIBY8nwr?=
 =?us-ascii?Q?UNEgVBvWcfK2UFN8ckHFeeazR+FqR8cE4GI1UJ6WSyuDMEb5byk9ZdxoK2nQ?=
 =?us-ascii?Q?6kOJfASNrjUxbyd8VN2T0+mZFtlUq/2f10sqs+mlYe/wirj9iA3TTwuqoNKG?=
 =?us-ascii?Q?0Fs1wFzWAeq2icpRW8yvpyTJ8LdiUYq6/M7h5G8YffPNcb6UDblwC8yB1WRE?=
 =?us-ascii?Q?OEIM72xOQTiNl5Qtyq8l39749rD1xX+ROTqxsguFeamXS92F93/+PaHWq5Db?=
 =?us-ascii?Q?9LCxvyerEKe184WYwcht3yjeWXlOoseaI6qXYIShXm62pfx/EYcohzQgJSQZ?=
 =?us-ascii?Q?luonE4KZkQAyrkrSQxlsrJgTUaEeOjh4A6gos9U7u23ERxw0ty34qdKBPIng?=
 =?us-ascii?Q?7o0/9nHeuSYH3yWnGmgkkC6cWNC3QnIwK4gp3c/7H6YN4G9AiZF7ESUMl7rX?=
 =?us-ascii?Q?vLnR4m7G6r9K3y0ANsbUTitxgMo5kw0BGB87PybJFlECyGrPvBbldQxMDbq7?=
 =?us-ascii?Q?OrVdH0oCjNqT04s/P2uukIF8nFU1J7dXLZJz2nBzELp8Y7iRMAVm9s0wVUSe?=
 =?us-ascii?Q?XLuSEY55kOHWX/wavNF/gPkDqZdDyzoOXjQcQ1CFnfI3ci2J17wy1puzW0FT?=
 =?us-ascii?Q?3Ip1IXQuOeA1RWKLP8cdGV/3X69YJ8AYipOPMIsvrjkZKNgosAngyq4iD9KD?=
 =?us-ascii?Q?BVNZYYzbBw1ZtEdPqMZ3RngPftdHXExxttQM0jAH2p1ilk12AAIipqRuKP1w?=
 =?us-ascii?Q?JBFByAt9TYjAbyR8ReR/sjEYUwkKvMM+eYwEsPNSk4Lbz9OdZ78y8bmAUMlL?=
 =?us-ascii?Q?anFRFfjRu5MvxubzqggzV+8GqhhwNTYcwERgh4RXZTVL0EX+PRAf+hRJbZ7F?=
 =?us-ascii?Q?fIMtZb6sfxTU5GPo0CxQ6ycc7iRCX7KbCHR8/3toS+9T8IOTNZ2jp06lfWZA?=
 =?us-ascii?Q?yid+3RZBSxIeJK+CAUc+3nyFo3xsuyO90TL/aCLL0AHOaj1mlypySK4dxo9f?=
 =?us-ascii?Q?ckSrXod47v2SmfPLT7Xl1TtIk1IF5CkDEvdY+KSpJhGYEAmee99X76vC3yDA?=
 =?us-ascii?Q?4eH+hZR+R8Q1RmL7aWIpy7T7w5alnMj0C0bkVTuKHvpiREwvfgU3vn3Y8ugR?=
 =?us-ascii?Q?pUASOcHiKaTQMFAWFzz6yuRdQxebtXpRWpxzMMcqxKrc5n5CfL7IsK99iqG4?=
 =?us-ascii?Q?i40j9iPHH10/IYtbrMmHU/uscN32uII0mjG+ChUDX249ezOx03keMEfbtd26?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e076cc34-8738-42fd-ef01-08dd687cbb15
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9898.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 13:31:48.3173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7hoP87D1XebC5M/3DZRxqDUlh97FDrONX7DK9V3LJy4buluE29GHvrb7DU0Z3c0nPLYcUUSu/WG+/VzX0ACpoWTvfz8ODYdtOqZqDZDNuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9519
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

The directory /var/log may not be writable in a container's
read-only mode. To address this issue, use the DPDK runtime
directory as an alternative when /var/log is not writable.

Cc: bingz@nvidia.com
Cc: dsosnowski@nvidia.com
Cc: stephen@networkplumber.org
Cc: julien.meunier@nokia.com

Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
---
 drivers/net/mlx5/mlx5_rxtx.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_rxtx.c b/drivers/net/mlx5/mlx5_rxtx.c
index 9c075f6a56..9e63d38524 100644
--- a/drivers/net/mlx5/mlx5_rxtx.c
+++ b/drivers/net/mlx5/mlx5_rxtx.c
@@ -6,12 +6,14 @@
 #include <stdint.h>
 #include <string.h>
 #include <stdlib.h>
+#include <unistd.h>
 
 #include <rte_mbuf.h>
 #include <rte_mempool.h>
 #include <rte_prefetch.h>
 #include <rte_common.h>
 #include <rte_branch_prediction.h>
+#include <rte_eal.h>
 #include <rte_ether.h>
 #include <rte_cycles.h>
 #include <rte_flow.h>
@@ -411,20 +413,33 @@ mlx5_dump_debug_information(const char *fname, const char *hex_title,
 {
 	FILE *fd;
 
-	MKSTR(path, "%s/%s", MLX5_SYSTEM_LOG_DIR, fname);
-	fd = fopen(path, "a+");
-	if (!fd) {
-		DRV_LOG(WARNING, "cannot open %s for debug dump", path);
-		MKSTR(path2, "./%s", fname);
+	if (access(MLX5_SYSTEM_LOG_DIR, W_OK) == 0) {
+		MKSTR(path, "%s/%s", MLX5_SYSTEM_LOG_DIR, fname);
+		fd = fopen(path, "a+");
+		if (!fd)
+			DRV_LOG(WARNING, "cannot open %s for debug dump", path);
+		else
+			DRV_LOG(INFO, "New debug dump in file %s", path);
+	} else {
+		MKSTR(path2, "%s/%s", rte_eal_get_runtime_dir(), fname);
 		fd = fopen(path2, "a+");
+		if (!fd)
+			DRV_LOG(WARNING, "cannot open %s for debug dump", path2);
+		else
+			DRV_LOG(INFO, "New debug dump in file %s", path2);
+	}
+
+	if (!fd) {
+		MKSTR(path3, "./%s", fname);
+		fd = fopen(path3, "a+");
 		if (!fd) {
-			DRV_LOG(ERR, "cannot open %s for debug dump", path2);
+			DRV_LOG(ERR, "cannot open %s for debug dump", path3);
 			return;
+		} else {
+			DRV_LOG(INFO, "New debug dump in file %s", path3);
 		}
-		DRV_LOG(INFO, "New debug dump in file %s", path2);
-	} else {
-		DRV_LOG(INFO, "New debug dump in file %s", path);
 	}
+
 	if (hex_title)
 		rte_hexdump(fd, hex_title, buf, hex_len);
 	else
-- 
2.34.1

