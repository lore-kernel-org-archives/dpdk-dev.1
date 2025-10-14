Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B361DCCD187
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 07:45:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF251402A8;
	Tue, 14 Oct 2025 09:45:13 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010038.outbound.protection.outlook.com
 [40.93.198.38]) by mails.dpdk.org (Postfix) with ESMTP id 267AA40288
 for <dev@dpdk.org>; Tue, 14 Oct 2025 09:45:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYIufcSJwntBbeGxLGOf0T5t9nuKNDrGlqNLeWzDwcDmtrWbPMe3sRQOzt1tc3mgtwoKtiZEO/oW0NI5rqfN8i6eekbrR+vJKkhtSRzZRcgr+c40J3hxbF+QDeG190OIa4LGzucGBoIFAHUxtMKpImS9u0d+ehRyYRpcirZJ+IS29/sBdcziDgdaiPpV8XjaD17D1pq7HwmGg2Ll9X2dNIexeGETs3FsbqXfkRcdYpywHGdDawpsw1pARN51aK0f1ezjEO+UeTvhYXct49v1UR5ksOwIrHVIi+j+m4X3BNsE0BRMeEPnxER41NtZlm6l1/X4uIFHWtWSXir1toQQDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L38Z+ncC8o6sOpCizBXexcSahnom3YlPwvZrQgVUX4k=;
 b=b8fwQL8/Lpu9p1nnQ5vik/wawuy6/Wn+iwGXfiERECGEsp1cp8lQxzhBIlqRIot6u7r+HKP2DL9aek3z7A3v2pnM3WYKsAPRAUeHdukjs16tMU5HQNb8iAKVm6D/WBaqd90C3Yv5OZy8mB8M+Yd/PcWyeNsn7yS2R5W2qj6LDqKbIDRBVgzNT9A/TOK8PeNhQ2OyvbZajlsg1r/AbjzMnCdO70xKLkTU27vC0rsajYA9sWxeRl3WeTyMxpl2ODsU/PgJ7D8C1zhOd8xiQwxQQnvvp7rockw1dGnuU6CxbNgZBmIG9RBWkfotrCz00t0eIU04fgOos7vjaFIPKh8tsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L38Z+ncC8o6sOpCizBXexcSahnom3YlPwvZrQgVUX4k=;
 b=LmBPrEGDwhh6V47n9drYA9Yo1hnkWtl9psIanwhhavlfrH/zjgTz/QqVfbWOO2MdnoCTE9PhHSeI4wvyVP6bhbrhVTMrsuIfHSgvbOo50JIuZzLcQrcVXybS1W6dibQJSGdkKc2m6lzQP7AowsKkyt0ljHHt7WFbTs/kR88tSE+PLbT7iXPKzav58ErtihW/SXepEjzGjmIBT7PFlozIgJD1rZnJKiDWqyZra+9ugRo39+Svc74g+IJfmMcdTEDwVPuBcz7XIlLomSTaCmd6Rpi98zV0uqvBf1Daz7Qd0nG31fpm1ROoOo2mmo8JB4AXNS6kMEJxurYhJjZ039RVSw==
Received: from SA1P222CA0056.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::8)
 by CH0PR12MB8462.namprd12.prod.outlook.com (2603:10b6:610:190::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 07:45:09 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::ca) by SA1P222CA0056.outlook.office365.com
 (2603:10b6:806:2c1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Tue,
 14 Oct 2025 07:45:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 07:45:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Tue, 14 Oct
 2025 00:44:57 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Oct
 2025 00:44:56 -0700
From: Ali Alnubani <alialnu@nvidia.com>
To: <dev@dpdk.org>
Subject: [PATCH] devtools: honor -n flag regardless of stdin state
Date: Tue, 14 Oct 2025 10:43:40 +0300
Message-ID: <20251014074340.2364328-1-alialnu@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|CH0PR12MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: da67bc22-01fa-4abe-c105-08de0af59973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bOjUU1zT+AFpWc3MT5dcFrLfpfbUPTPoPIKhRFLuywo2jsA0IoJ1cGCy+x/l?=
 =?us-ascii?Q?O+0UqBq4p/XKcourWyG5TsWhwtmKwEXuut5gAvEZcBoSpfuhOiGEvINHYqhF?=
 =?us-ascii?Q?wBbggJADztaeOyzggxquHjtcLBQ5ruB0r2++PoJKJ4XOf8Je9SRWuaNxsuKk?=
 =?us-ascii?Q?fW1vjNlH37EtHXfsmreI3TEBH7CW7/8hGwUcS6qdt6FqODf/XS4Jnvg8xHDg?=
 =?us-ascii?Q?jIuwZmVX2LvWokCzVr8nf2xO7ocvVBLcV4THomqfH+mITuv8PtjpAWnxwLFJ?=
 =?us-ascii?Q?fkVkKEIka2UzHxYJ4R2qz8t9MeNvh36PIPDXRP+xZch0wKK+UUreAk+EvtI/?=
 =?us-ascii?Q?tzyTsZpRQVbLhjSVItq5Fgm5lVIJY2Ujh3UGmQLPU07bh07HNhJ2ZT1a3SZq?=
 =?us-ascii?Q?Y1sJDKIx+GeVNqZtpy0cDdFnXnp0B/GijUsgE2uKkqFPLVmmE5Ih7OXjgGU5?=
 =?us-ascii?Q?IAqt/H7AIdPlyZJnsR0HV71nDugifXRGX36BAW7ahYwDp+5d+mwz9oiP3DLZ?=
 =?us-ascii?Q?RrbIPlUtPFwNsE+neOcULZsHAnAP/e393Xa7KZ2IeaUGE77rva3wLYaGVUGN?=
 =?us-ascii?Q?1s8AZuW3WxsTnIom86nWbRN5QB3kOC2XloOVGTa8hiRiHWlgr0eGXj1yshBP?=
 =?us-ascii?Q?aRtaC1wi6sYxhG5NBRoYuytiYut/rFZ2dQ0e0sZmvoxRr11ndqISYNwWGjNd?=
 =?us-ascii?Q?OvzWL+JKvPuCasodxYKwNhgHsra0R4VNQaE4z7zoIaud9qqF5iDYUWJxswyp?=
 =?us-ascii?Q?v1eSffgoPQjfbFw0rRHWqwtQHAEapbEwVPhf/y/mmWQMyJMtluchhuC+xnX7?=
 =?us-ascii?Q?4ixXuRt3Zyg3AeyCaSjWB/N0M0Y7G/PgGCDst/hnZlgjP84/2c7eqxcF/1/2?=
 =?us-ascii?Q?M4qI9j+JiW9smo1ovF2YDCTlfuAiIffKYHmE7ONTeOE+qFcLRMvs6g8Xb5hQ?=
 =?us-ascii?Q?lY5WgzIrcHacw/vyMd19W3cu+yGN0kYHuQ446fDK3k0aveSM2/xek0gZJVjx?=
 =?us-ascii?Q?EO6ZdFfsUNQFrBs64Fx6c9Q5Vs1tLwfC2+9oHDapUxu84AwopkbZix5I1Ozp?=
 =?us-ascii?Q?Z12+DjU1H2dfPUaX/bpjwxDkIYniw1flDx3P7SGfra3GWS6XdUxVvfM213HM?=
 =?us-ascii?Q?AFor4YPLKszW3tLrmW1w2MZaqHSz2zA5TXfxNetb9P4OH17MMcQCGm3XhIM2?=
 =?us-ascii?Q?eTxy3RWa0/Sp14JjNlmRcTjtfYSKd+i8DFqkwY2i2y3MgrXVdFBHWMFbuGT1?=
 =?us-ascii?Q?OHxxAyZ+j8c7fOlR8h79/0o639H4QgAr9pVh51mom1oVZwpTwX4rqRdW8F8G?=
 =?us-ascii?Q?CdR/WRahz0UlfVNhIVK74k/4zAmmZMyOocs516IET+M7o9bGWFyHgBJ47pD5?=
 =?us-ascii?Q?CokMxxGyb7+GAvCQQDsTShn92lZemS63YRk0itfyB52fb6IMHI808D3WfqLQ?=
 =?us-ascii?Q?0oFes55N25OEcVa+JgQWcVxWHyID26Ba5j70i/Y2mJg990CTIu2nR2DUtA9n?=
 =?us-ascii?Q?sDO7tEXx/BsSejA5hikrvFhSZIWwUVdk+M9CGuCKLBOujYv6EWAcBw7kt4yD?=
 =?us-ascii?Q?F/P14yj0tS0wQvdMvX8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 07:45:08.9482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da67bc22-01fa-4abe-c105-08de0af59973
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8462
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

The checkpatches.sh script was checking if stdin is a terminal before
honoring the -n flag, causing it to incorrectly attempt to read patches
from stdin when run without a TTY (e.g., in Jenkins/CI pipelines).

Reorder the conditionals to check for the -n flag before checking stdin
state. This ensures the -n flag takes precedence and the script checks
git commits as intended.

Signed-off-by: Ali Alnubani <alialnu@nvidia.com>
---
 devtools/checkpatches.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index 9fb8fd0a07..0884f24839 100755
--- a/devtools/checkpatches.sh
+++ b/devtools/checkpatches.sh
@@ -558,9 +558,7 @@ if [ -n "$1" ] ; then
 	for patch in "$@" ; do
 		check "$patch" ''
 	done
-elif [ ! -t 0 ] ; then # stdin
-	check '' ''
-else
+elif [ $number -ne 0 ] || [ -t 0 ]; then
 	if [ $number -eq 0 ] ; then
 		commits=$(git rev-list --reverse $range)
 	else
@@ -569,6 +567,8 @@ else
 	for commit in $commits ; do
 		check '' $commit
 	done
+else # stdin
+	check '' ''
 fi
 pass=$(($total - $status))
 $quiet || printf '\n%d/%d valid patch' $pass $total
-- 
2.43.0

