Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDE7C7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 17:59:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7206140276;
	Thu, 26 Jun 2025 19:59:24 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
 by mails.dpdk.org (Postfix) with ESMTP id 12F974026F
 for <dev@dpdk.org>; Thu, 26 Jun 2025 19:59:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJv6TZaxkOc+KJmCuqe48vIkfXny8p0P+6XMvqmnfOmfQDLBfzbD9QYPQP3RaqC1y8EoIGLvULaz1jB57ee0dWOwqUizxjBKN9X879qsgWXnqst8gojDjlFcMOnlUyhTDhCUPgpkfBTg3OJHbNIMATITYhsYeVOgDTg8i/dTkNLXsfpmqwpSUyQjagM8KDLX+oRdRz2mqh3VlKWDlPiIixChAbaiUEMsCQw2dzVRghRhRp1S/PSKXMAvw7uPosDAVJpREwqFAttk4cdUgLAvy5O5AV7gYbiNacFNIV4dnnb3ZqGfe6ci/dzPuDvQy5KMwqHwEiUVyVUBL69qP3PBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vpMVBLUBhEXk8TRmyKJRBOiqGgQbvBvAwkbjs+siKA=;
 b=qEi9bf+zxN3lk53IXq3ytql2PW0H4sLOKmcjIhzPE0XE+q2+a0ZmCuoIoHfJL6qA0ndj/gCysc+maOOZkIfT7vWyKOYWG9YZExgu/L8w233fhgtKIlmuNyxVV1yBRzn2fFT3FnW0VDXZnvoEQoOAdsHHaIpH+f1TeTzWVrSghOpmE3YQQbAklyLlhW3L0/Cyfmx9Qbe05K/BhEEFcuijyOsaSvuj1BnY1nu7CPIOeZ1LNPlg1IRU6S9l5gE//6/Zg8RUxKV7BqE+K9kDQ7zLnK5S1VpGGRDOYr/6ZKkzwdr1wnh3xfp+BfEa1N63S/dkAc933oiDIs17zb+PRSvg+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vpMVBLUBhEXk8TRmyKJRBOiqGgQbvBvAwkbjs+siKA=;
 b=VeM0YdiD4tPP2mWiEaYSflwUjX/3BOqeGbb574R8MA9TkcDBw6Pn2yzOfl2R6XP3yXgn/sFoRZCO5e9uNb9bCAC7bRV8xniRig/Unml9Qk2upM/z2vxSY09rCFYMewiPBmwX68m5mVVnU982ybez8ekExyh0vyhSyTDfvD9I6A5YGSCB2I4hUAsv89kRsDgwjm2Y6Dgnp85EJEdfAD/GNezkKbOQvKa2vrziVat34THU908HVH4zc920VW7ei4JiQRPW8rWrLBjXjey7TJAJzqYkowspvpKwppK+1yHc+ByJN6HuPTFwAzz5FwjSafYjj3HFYSGhgQC6bjWectE2lw==
Received: from BY5PR17CA0016.namprd17.prod.outlook.com (2603:10b6:a03:1b8::29)
 by SJ0PR12MB7474.namprd12.prod.outlook.com (2603:10b6:a03:48d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 26 Jun
 2025 17:59:18 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::32) by BY5PR17CA0016.outlook.office365.com
 (2603:10b6:a03:1b8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Thu,
 26 Jun 2025 17:59:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 17:59:18 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 10:59:03 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 26 Jun
 2025 10:59:03 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 10:59:00 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 "Aman Singh" <aman.deep.singh@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2] app/testpmd: cross NUMA support
Date: Thu, 26 Jun 2025 20:58:55 +0300
Message-ID: <20250626175856.1579-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20250617155351.190622-1-mkashani@nvidia.com>
References: <20250617155351.190622-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|SJ0PR12MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: 18d08f37-f102-4127-f7ce-08ddb4db2c00
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JrpNY+Xkp9VEibR7i7XUG6idm0lmbGVHeNTH/WCZRJzTnl6u4MkWzwngVbW3?=
 =?us-ascii?Q?nlLlNVn1Q7/Kv5J0Tww4y1tWF2TVv3TjbtoatlsGGAVEz8zxXTyWqEEhYLcZ?=
 =?us-ascii?Q?cPogfT6zF87CE586+eZU+PBw4GIwuFwWtEQYNM1P+ZxdLvfSiMc0KYQtcKCm?=
 =?us-ascii?Q?n0kvDTk2jfUME5ZmASf/4ILqeATDE3BgdGfNxaoEEjHJf28LHI/JA5XXlm0t?=
 =?us-ascii?Q?eqx7Slf+b512ArE/t02ACmDUW9HAJ7IKWTDMBjmmzY4zZUJn7azTKgCHc+Xs?=
 =?us-ascii?Q?+38A+UQFnEZ0+E/nHUK/CA6/AYakXgVImAJ64gXchjSBGnKjQmD79En0/CrI?=
 =?us-ascii?Q?3bjktCLNtMh3X0bq1XWSjJCmttJ/7kdzVxzqqVoXQUb6OdOxVU0mpScj/iaW?=
 =?us-ascii?Q?HF/ab1hLhFIjYiiTETzGeN+zc7jX67jRmJCadmhyAIqqvyJwb6jAA/LqzUn4?=
 =?us-ascii?Q?/5am6Z207UK2WYIVCZ9OX5WLswCfIHki8KMPYwPprifdpzq9VyNT5/nDbYuW?=
 =?us-ascii?Q?20wn8bxEmvNMpYtAsUoGfUbdIkyC8bhyivTtoDy2Cxo4FBTw3qfOSBFRorLe?=
 =?us-ascii?Q?+wYNMJRSSUxKeyg2zwuYAVzAEHkbjuUXW8p017xnMHRuN4AWpim/IWRvYbDl?=
 =?us-ascii?Q?Kbanjf0MYHG1i3AkOmUihGZf2qty1cdPCeK3ti14tHIpqgMlrGAF6r1m3YQ6?=
 =?us-ascii?Q?iXf1n6y5uw2ZajGx/b87CZmeOIiW2E4J2AjCLbTN+DPYTcAIr34a53VNDxCM?=
 =?us-ascii?Q?LkuvA/JILuWWuZKz9tSC3psz3KLPIuynEKkkSgn0SgCNuHbweJVl80oCLHuI?=
 =?us-ascii?Q?xU9Lgh6jGHQOpY88BwMaAaFuMHRUzB25a4KfHvBcBwGfISEzDTRIFObVRjAV?=
 =?us-ascii?Q?k1U2Yl19P6uOCKMXbp+jXuPBZgl0oDZkKUhRDx9Fqj9KOHcl5jXPVYxpS1rL?=
 =?us-ascii?Q?PGfRftN8tn5vESKfmerGkKk2WeolFgg6EC5CrbdFqJZ+acyugDT1mPZl71oQ?=
 =?us-ascii?Q?yKSHYtVk62kJJa+kf7CpfIv9Jo3p2YDcsra4Pg/0rnFHUIGlqdIv9jmzK7WQ?=
 =?us-ascii?Q?w6/y+N19hDM2eOtmNcsuy2BxqhFNiKCMZH2kSNsq8av3h9+YsouZhMQ+oXtM?=
 =?us-ascii?Q?/wYbLlwsY3KlTXzWFFRDu3pOCBWWr8Bjhq8ouGZ61L/KsNCoUP9fDL/WKaPl?=
 =?us-ascii?Q?nFU/RgCWOjOA3UAD1iMMSmHtOhJLkSRPkCOHAsIa3Yy9cERsn2ui8y84afbK?=
 =?us-ascii?Q?O7m7lVUgCbS5j5n0OLplpNke9Az/TVjmo85r2VYq/fvMeCyr+ySnY5PIrTt2?=
 =?us-ascii?Q?FGE24RE4A0dL3aWqlDO2e/mNkzIruBDBZx6jBvBLHMZ/jgJ97ImUEpMvz77T?=
 =?us-ascii?Q?g0DprkuVTuip2ntbfBmyR6EO5eCOKq7NrYXtVPJIus8FglTmQoVaM6lz+XWs?=
 =?us-ascii?Q?a1tmuG1E/p1INPjTb8br0jrvGrHDZijyplDUul0nflhiEvCmD/mOwUT2Q1WB?=
 =?us-ascii?Q?jfygcGKq93zPu8B8DPg+Pm8UrXznxl6TaQwb?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 17:59:18.5274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d08f37-f102-4127-f7ce-08ddb4db2c00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7474
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

Cross NUMA support means that
if the current NUMA is out of memory,
use another available NUMA memory.

This patch is meant to support cross NUMA in testpmd,
when disabling gro, gro fix for cross NUMA will come later.

Replace pdump, metrics and dev shared data
memory allocations to any socket
instead of port socket id.

Replace mbuf pools allocations to any socket
when --no-numa flag is set.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 app/test-pmd/testpmd.c      | 8 ++++----
 lib/ethdev/ethdev_private.c | 2 +-
 lib/pdump/rte_pdump.c       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 344c256c050..92a5d581bb9 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -1729,8 +1729,7 @@ init_config(void)
 			mempools[i] = mbuf_pool_create
 					(mbuf_data_size[i],
 					 nb_mbuf_per_pool,
-					 socket_num == UMA_NO_CONFIG ?
-					 0 : socket_num, i);
+					 SOCKET_ID_ANY, i);
 	}
 
 	init_port_config();
@@ -3057,7 +3056,8 @@ start_port(portid_t pid)
 				} else {
 					struct rte_mempool *mp =
 						mbuf_pool_find
-							(port->socket_id, 0);
+							((numa_support ? port->socket_id :
+							(unsigned int)SOCKET_ID_ANY), 0);
 					if (mp == NULL) {
 						fprintf(stderr,
 							"Failed to setup RX queue: No mempool allocation on the socket %d\n",
@@ -4476,7 +4476,7 @@ main(int argc, char** argv)
 
 #ifdef RTE_LIB_METRICS
 	/* Init metrics library */
-	rte_metrics_init(rte_socket_id());
+	rte_metrics_init(SOCKET_ID_ANY);
 #endif
 
 #ifdef RTE_LIB_LATENCYSTATS
diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
index b96d992ea12..285d377d91f 100644
--- a/lib/ethdev/ethdev_private.c
+++ b/lib/ethdev/ethdev_private.c
@@ -343,7 +343,7 @@ eth_dev_shared_data_prepare(void)
 		/* Allocate port data and ownership shared memory. */
 		mz = rte_memzone_reserve(MZ_RTE_ETH_DEV_DATA,
 				sizeof(*eth_dev_shared_data),
-				rte_socket_id(), flags);
+				SOCKET_ID_ANY, flags);
 		if (mz == NULL) {
 			RTE_ETHDEV_LOG_LINE(ERR, "Cannot allocate ethdev shared data");
 			goto out;
diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index 79b20ce59b2..ba75b828f2e 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -426,7 +426,7 @@ rte_pdump_init(void)
 	int ret;
 
 	mz = rte_memzone_reserve(MZ_RTE_PDUMP_STATS, sizeof(*pdump_stats),
-				 rte_socket_id(), 0);
+				 SOCKET_ID_ANY, 0);
 	if (mz == NULL) {
 		PDUMP_LOG_LINE(ERR, "cannot allocate pdump statistics");
 		rte_errno = ENOMEM;
-- 
2.21.0

