Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D010CC36000
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 13:28:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1D8C40B9D;
	Fri, 21 Mar 2025 14:28:10 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2089.outbound.protection.outlook.com [40.107.241.89])
 by mails.dpdk.org (Postfix) with ESMTP id D046040276
 for <dev@dpdk.org>; Fri, 21 Mar 2025 14:28:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afNBUp7YtE8yVvGgvdTed+EUO6nn1EileU70VDAeUdRBd4C4UKxLmYN1afnYWatIQiKcv+sD/whiJv6umxq96CtYwIV63HTjCpWmDdepSqxbduGxBBt0NPw2d1iTMJ1TSVI8Gofd/DKZVXZqBYSHDzOzhDFHOEKwjLRhK1kb0mmWIwr/yeSRYNJWlJU4cTtm9CKFdCuXaxqIItljRLOCG+Uw9X7W0WJo0GoR5ycVLM3B9+BYE0Wgi7COecZP0/AyWmhbdnqtdPTX0oO5rq5kO7IADwcZ7CrEhjmNixeIzW9PMXwIyqLw9mwv8kq2kJaaqPgSNdUiqMM697C8MGC01g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPUUoLRrVyLPgO5GZuJPa1kWXawP47AYmFne7yLuScA=;
 b=tRV1BDXtmWWhf2D433cdtui50GIatT+XL7RVOXOYGuJ2gnEaRRXXT61aZ4gdeEj7XUfEBaw2OGma1SuHrImXHrmb76xE9s9EdboZBF2zPNym7rRJuEdqifO8dE6D83FU8w5lnFvK/b9FM5DO7/XL8kffEAcNFKwbMEy7BNCinC/0w7Za0C152+6VsPUtjaZNuAGetQdjkBN6Ozun7BZ3jKLJX17pNd2MkkKMvdOLGFbS1YrThptXbS7FzGJ8rKnF+Xm0jG6a2iGoFfpCGJrTS+iOoUMZOR2zxNmbZJHYRClR03lIg23gg7wTJeasZCfCrcZktikdSUBYQJLSaKqngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPUUoLRrVyLPgO5GZuJPa1kWXawP47AYmFne7yLuScA=;
 b=DhCeYZKUSYjGv4ZXd4X9p49AAy/nAuwnDIE+JH03b/HDajpFY1cMTNeBt0oDW3XXjuc7TEQ5bNOlwaPjn3Tii0ZOOT/SCiniBSdcxaUS62xNE81WyWAQzgROnK+ZfECbjj5MVvy1WvxhK0b3o/NOd0Xansv2J8UvkuuW/1R7bMyxMDSFGoavBzU25sEcWNLb73aDmPSY9gL3zS+rbfywOKKMEpYcChuOdJX4dqptuNZTzVqBLg62b5kkcm1L46X5TnSpX47Q7DIXeiqsuyrcw6ar6js/TK4qslR2ENHqN0JcV2vUh/rKH35LNuB5xpMOPbqPxxQ3LYg37JWR7G6ZKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
 by DBAPR07MB6631.eurprd07.prod.outlook.com (2603:10a6:10:189::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 13:28:08 +0000
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21]) by VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21%6]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 13:28:08 +0000
From: Yang Ming <ming.1.yang@nokia-sbell.com>
To: dev@dpdk.org
Cc: Yang Ming <ming.1.yang@nokia-sbell.com>, bingz@nvidia.com,
 dsosnowski@nvidia.com, stephen@networkplumber.org, julien.meunier@nokia.com
Subject: [PATCH v2 1/2] net/mlx5: enhance socket file path
Date: Fri, 21 Mar 2025 21:27:49 +0800
Message-Id: <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213092444.2987-1-ming.1.yang@nokia-sbell.com>
References: <20241213092444.2987-1-ming.1.yang@nokia-sbell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0136.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::16) To VI1PR07MB9898.eurprd07.prod.outlook.com
 (2603:10a6:800:119::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9898:EE_|DBAPR07MB6631:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3415d2-bcd3-41e9-bd77-08dd687c37f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dzXWJijPImGv0rKXqPhS47ik58IJmOXglOoUX3bgnSQOzufx95WvQUf1c7hG?=
 =?us-ascii?Q?ka4dEpXgx4YRfbHE8Ipbso07pRCOeYx2VTahMuETJYdKeUMsDy73n5Vv0CNH?=
 =?us-ascii?Q?eT9LX92NapBIu1t+f8Bc0wEE8SqOAMN0ICDy/NT31pOnl1rNJ/7E0gO2ewEv?=
 =?us-ascii?Q?bq+vBcEb0plKnRs8gD2yErGY14cRVypQykZKublRqUUWg0NHjJDi3b4ofvCX?=
 =?us-ascii?Q?0RenlBzaZDsnXAfxSSbdpC8dzysyKfa+OiXoB27KX87/bGpsZIrzwo9Ekt5X?=
 =?us-ascii?Q?2XAaazMvGRAXEmw4o96LEZTyr9wjp8DvbbHf9iPhyYtIdW1e1UhJLciY1F69?=
 =?us-ascii?Q?HKo44z1I4TiW3aFJ6/3n5y+Bq1cc+TP+7BCUQqUwk1Rj6lFymOpWJlaLQD4N?=
 =?us-ascii?Q?4LuSS1nL+ZHywDdpaWkMV57eYZRDXUNSDmHEtSu4GfTWBeqYo1T2mghXuKnt?=
 =?us-ascii?Q?4DxavxZbJTyXCSNuobaPrSwp19FKNMkrNtRFvSMetieUgBSXtccWG3MRgODh?=
 =?us-ascii?Q?TKNrYIY+hUcbRA8tO6jkFd1aFu+h/8EnQhgJdMpAw+Qr7GFv/qIiIcmZ6cm0?=
 =?us-ascii?Q?vONhcaZlUqcqJUmaq9EeQx4TBzSl7W9H7brliQtfWUzr9jD8ynN5IujthpqQ?=
 =?us-ascii?Q?yMwo1lQea7Wzj4HD4cEDJmzfRCEKh1tXAcFiT9U9Cph/HIe+dvBqeJ2jOKCH?=
 =?us-ascii?Q?g0aVOYzhkK4HuS7s4m1qaRwSlW3fVg4k3fIrODp5NqhuR0LcrnfdfBM0DTgO?=
 =?us-ascii?Q?XH5uZedU2XAZMrlU+MOlxnhufJUVYC+TZ9EU64Cv4W8MJEZ0ZkqLHS75iptG?=
 =?us-ascii?Q?fxsN1ecJfRTuo8/Osyvc2NSS9qrQeawGkZZe/GI+h0tVU7wcnaUwUHmKzoE8?=
 =?us-ascii?Q?n9/neR8VdAjInQlBE0t7Y9Hk8KjtALNiR3nj4Dsx2FYXCyeg6+NM+Y25Z3f8?=
 =?us-ascii?Q?5dmjxp/upxiDIRHT6M201l/UmBkxUcMujbcZJsrR4lxE/ST6/vhrF1nXx2tp?=
 =?us-ascii?Q?UXb7+j6OS0vVs1QO/VVNcbHW89/aHL2oQTZwUFu0D8jBTIOu3vBXNlvtxgoa?=
 =?us-ascii?Q?sNWrr2ggb/rALrrSGE77V/qK/GVBlW7vusYdIjzYALqVCN0I5fPDuRcB5Qxw?=
 =?us-ascii?Q?xRNPvqGk+vqjk/7k0g/QCzw2JBPOSckajyKfdFiAoc+yugTBufzwR3YUejkw?=
 =?us-ascii?Q?/gqgtnqChZDsf8eRIiZnqJUhZmesAV3vxllT7BItjlLCwxoT7GBmvZ4157dm?=
 =?us-ascii?Q?AreX/mX3Al4KycWZ10R31c3jLadgdRjqHNQC3IOxP4sEZvE9GQlEcoukEZB6?=
 =?us-ascii?Q?5QJRSh8tVshhxZ0DQQuoHubfx7LUZt9xs31EtWx3UXJSQqEN03FfTCc5cn0j?=
 =?us-ascii?Q?iE0koU5pQ6nhugoW1wP0+RgdkNE51K/o4FiC8/Ab8Xdz2NuyEeA/990QhnUw?=
 =?us-ascii?Q?uK17v7OZwi8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9898.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7F+wc/6S1/t0R1edjO2GMcdZtZs1OuIfTLjQn7uezEkkjhnMbVD84/2cuKGJ?=
 =?us-ascii?Q?IyQNLE7s93R5TX8IvIzT5SM/olfLuv0A6y1THcPtELHPdAWkL1wEw5ph+cIX?=
 =?us-ascii?Q?ugR0UbPwVGhIEOu34RgozBHsW6OMbLkxANqU9HU9SjrlaQF1Gsm8eKL2P0hv?=
 =?us-ascii?Q?/sYTIhcIo19NSX13oe5iiyFgwXgDgeC+e/Zwlqv/DXfd2xgFpIEm7USqLTc1?=
 =?us-ascii?Q?pluaRGp8CCKUJOOcEPAOS8W10n2g8Effv4Jsg0nZno8YendG4Q+fM9MtJCd/?=
 =?us-ascii?Q?CKbhVEtudqVr4JGfH1DnAH+u7v0gcXKCugPiT851gAWE9XVhqNnafeWunw5T?=
 =?us-ascii?Q?zlHWOEaaSPj2Q3f8FqVlmIYkWQ+vsG+5D9CNWrjFV274lOhrJHnp38yOqxMy?=
 =?us-ascii?Q?+zogfRfv+CaygLuPML3PI4MLKswRfIysuQFnKGCwP6uC9w9N09j8AmrtuAOs?=
 =?us-ascii?Q?f43s50pHUddQBVHrpIEBBRejl2IOVQTnzpXf+vPkC9YM7P+wzXKPocxV4nFM?=
 =?us-ascii?Q?pg26uSJ1k9YVRtkuHX3eW9TaHJujvg5MtG6cUh8Aa9cdjy30p/rwtFSpy9qy?=
 =?us-ascii?Q?gt4YqYk+1aCFPZKNFOl+/J9lNvkPECCYv84Z4eMy16vyJVp9NB6sz9OaphYA?=
 =?us-ascii?Q?m9zEYm99zeMwZnCvbPEW7W2yp8DBjzAobd9+ndNdcUQh+NplKoUA/nO4nqR8?=
 =?us-ascii?Q?BFvIQdcY6t06Vvr83kvVBPCapq3sFca0RO4jwnmtTrYkQaBQOeXFXHvGhnHA?=
 =?us-ascii?Q?Bl8qpEpU8N66WIg89Mnt+YARFXxvQ8GZrvpaL/kxgsR4qo6cTnoUuEhU8rnH?=
 =?us-ascii?Q?6fp1DMbg3XTpdJUhnaCQ2HR6hXEpZGMBagNm6dqKxlxfRd6Ww1CdfIE62ai3?=
 =?us-ascii?Q?4f5tMbQbp6SJjRj7t7krxrrDxPgX+ZrF4jLcSzm/OJ06kd8q4m041Rn1gIDi?=
 =?us-ascii?Q?AvOujEY9EFSRE4VPPGVTL7NnoanstNwYYB79HONNzkWew1iTgLnlIR4j/DYG?=
 =?us-ascii?Q?JXJ0EMNxUzTvju5tdi2nWs3G4A6X/4wNRkwPZp8+2k5YZEKzF1TtpbL5h1vA?=
 =?us-ascii?Q?CV08A4OcKWXHkzRmTPDs36WuQyPdBIFQZ9G7R1jTD0sUBe8eE0LaPq+mJP3U?=
 =?us-ascii?Q?m6yZjqh/lrfgIlt4VUEjUF0GHdA9AKwZ11oMsvi8oZwl6EpgoxusNM0DqsB7?=
 =?us-ascii?Q?DDWxV04ql/L4m586TA//FVKs7rh/VjleAjU4MsppwSYSOfBzDLQmz5itoZ6M?=
 =?us-ascii?Q?9CirygMWwO15OVsAPbi+CLfm+SGf0BvVjn3kcQ3D+EpkqWrPTN8xCxh0KMGK?=
 =?us-ascii?Q?vIhLfVaEopxVKUVTnZQrTneDY4kc36Pub2WpHYsOCemm6CaQyCQtlkntWUr4?=
 =?us-ascii?Q?/S/Rxhz7Xz765t9efVro1a8tnvYtOWBUcbMrpH7AoudHBLWOUOKm/9oZv87h?=
 =?us-ascii?Q?JUlSMAtaHBkmqwnCl76rUCoCUJqbvcN6rk2xVN1gQDKj2ryDB+XlVuHmZlXW?=
 =?us-ascii?Q?6jqqz+ihzaRv1ixD4HiJ3++dm+XTXs1e71lVmLCLO4Bmys8jwFSolWA1SuhK?=
 =?us-ascii?Q?Ftp9Sti88GtCRULj7h7N+s6ziHuJyfnxlJgvtK4BM1vDhJ3jMErRqika1FKD?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3415d2-bcd3-41e9-bd77-08dd687c37f4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9898.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 13:28:08.4352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvwcc/2hlE4isf9ChBnUut81CvwzrekFcH5HHAoVbbMfm9Qq8UQKCCIKJKFJ2uIQgBlPKKGw74osH7McASei52mmoZChnjvI6V2AxW0GlJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6631
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

The directory /var/tmp may not be writable in a container's
read-only mode. To address this issue, use the DPDK runtime
directory as an alternative when /var/tmp is not writable.

Cc: bingz@nvidia.com
Cc: dsosnowski@nvidia.com
Cc: stephen@networkplumber.org
Cc: julien.meunier@nokia.com

Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
---
 drivers/net/mlx5/linux/mlx5_socket.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_socket.c b/drivers/net/mlx5/linux/mlx5_socket.c
index 6ce0e59643..270a105f1d 100644
--- a/drivers/net/mlx5/linux/mlx5_socket.c
+++ b/drivers/net/mlx5/linux/mlx5_socket.c
@@ -20,7 +20,8 @@
 
 /* PMD socket service for tools. */
 
-#define MLX5_SOCKET_PATH "/var/tmp/dpdk_net_mlx5_%d"
+#define MLX5_SOCKET_DPATH "/var/tmp"
+#define MLX5_SOCKET_FNAME "dpdk_net_mlx5"
 #define MLX5_ALL_PORT_IDS 0xffff
 
 int server_socket = -1; /* Unix socket for primary process. */
@@ -177,8 +178,13 @@ mlx5_pmd_socket_init(void)
 	ret = fcntl(server_socket, F_SETFL, flags | O_NONBLOCK);
 	if (ret < 0)
 		goto close;
-	snprintf(sun.sun_path, sizeof(sun.sun_path), MLX5_SOCKET_PATH,
-		 getpid());
+
+	if (access(MLX5_SOCKET_DPATH, W_OK) == 0)
+		snprintf(sun.sun_path, sizeof(sun.sun_path), "%s/%s_%d",
+			 MLX5_SOCKET_DPATH, MLX5_SOCKET_FNAME, getpid());
+	else
+		snprintf(sun.sun_path, sizeof(sun.sun_path), "%s/%s_%d",
+			 rte_eal_get_runtime_dir(), MLX5_SOCKET_FNAME, getpid());
 	remove(sun.sun_path);
 	ret = bind(server_socket, (const struct sockaddr *)&sun, sizeof(sun));
 	if (ret < 0) {
@@ -223,6 +229,13 @@ mlx5_pmd_socket_uninit(void)
 					  mlx5_pmd_socket_handle, NULL);
 	claim_zero(close(server_socket));
 	server_socket = -1;
-	MKSTR(path, MLX5_SOCKET_PATH, getpid());
-	claim_zero(remove(path));
+	if (access(MLX5_SOCKET_DPATH, W_OK) == 0) {
+		MKSTR(path, "%s/%s_%d", MLX5_SOCKET_DPATH, MLX5_SOCKET_FNAME,
+		      getpid());
+		claim_zero(remove(path));
+	} else {
+		MKSTR(path2, "%s/%s_%d", rte_eal_get_runtime_dir(), MLX5_SOCKET_FNAME,
+		      getpid());
+		claim_zero(remove(path2));
+	}
 }
-- 
2.34.1

