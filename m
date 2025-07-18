Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D79C83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 11:52:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 923244014F;
	Fri, 18 Jul 2025 13:52:33 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by mails.dpdk.org (Postfix) with ESMTP id B1A104013F
 for <dev@dpdk.org>; Fri, 18 Jul 2025 13:52:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvLB8YLn3ge2A5vES56E7UVprEsVeQWqIpNUNDRj7oOToKaL0KWmYIKqtr/yt+Ip1vW2ilAOz7V3aomV8He+CImuHNgeKozn1Gm8PB76e8k0kRKXoF6ztvC45W4ICzzc3OOUjBdgFUJVMRxTvGbPLy/pfYTYHg7Uzb3Xwu43BHTVwQfeyz6H7ItGa5aUYxmbdm8VYqOpPnIfwoZvE9gKmln+KBGuv6DbvL5ZwZLQO/B2l0ZbnfXfgnexeNS6JUqSp17Tvcxz/+8FSIKwHuAr3A8SzH0wbozg5ADTXFC4mCOtwY7+hJ60pLBObmONVqs/essh9kBN+tApxzbM0qMkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVfOzIVjkHdeJjXoJRCcZnPriZjHywjNaV7wrtqI414=;
 b=CqqpCFuMn5qin9Lw83ldbHO4HDesH+iLLHM8Pry59e/eh81YqLLs3rbBcTHs7P45mjbA7lajXBJNDf9FgaOpG/97B01qVCXdTGiWaWuhPzFnJnWKdHNvRtZ9XnFG3MfUwp8BxvfM2SwCe4LcBh7ScBaMberNtPlks0U7ReSTSkVF7wJOXwdq1pKpRgfwzfcWM21MM+HMVZjJWtXxtLamC2+PlbOs2pQrSnkpoVER6YagHMJUh9ea9Q0EwMTmen9txT6W52oIiGTi5UYEZUMHWPPj0/Cv/u6WtdktzbjJVfEUlDlfv4jx95kMQp8lCXY82E+JebA04ElZtpxOvcTdrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVfOzIVjkHdeJjXoJRCcZnPriZjHywjNaV7wrtqI414=;
 b=TDm0aX0xXjQTXhks1g6rfg76MOYZ0jc0x9bO98NbDjfln+7cdB4NYzrAaRr39yOsAHaawCTepZzDh9vaAncgTMLMpYFWcV07MQa6PBLIWgBSCAwN6CgyyFBppVIS0uVAP8FNu9KaY4fFNMER3vWLAVWUV+bQXTKtJjFeMIJp95MtbZeZcj2BRQD4Lcu7yrkeLyWLHFqGRkP8u/4ZVdGFiCAHzsmvBuoz6vu7c4uOXUJSTiHWfMzzSOW76Vzj5DjUzHxl9d8vDSmF5GPf4+1Dp2OhZq9zF1+TlMUKPTksYD4mMdgA5+nt4WIv8wqH+Xj5J3RBRRVlxxorH0KZj6UDRw==
Received: from SJ0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::31)
 by DS0PR12MB7850.namprd12.prod.outlook.com (2603:10b6:8:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Fri, 18 Jul
 2025 11:52:28 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::ff) by SJ0P220CA0011.outlook.office365.com
 (2603:10b6:a03:41b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 11:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 11:52:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Jul
 2025 04:52:18 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 18 Jul
 2025 04:52:15 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Raslan Darawsheh
 <rasland@nvidia.com>
Subject: [PATCH] net/mlx5: document IP fragment matching limitations
Date: Fri, 18 Jul 2025 13:51:56 +0200
Message-ID: <20250718115156.1220403-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|DS0PR12MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: f604b83f-aac3-4c46-4660-08ddc5f191b3
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fYDk/0vxNNZfL4E+OO4KUOF41ADj/kDi1OuRxXe+8CNgulz6tR++62BGiWqo?=
 =?us-ascii?Q?Du5Sbe5z1c60eaLosqSFkGRZwTQtAnr+NrlVjPYWtno0WwF1Ubk9bEKihak1?=
 =?us-ascii?Q?mChuTWw06cN1eIYS+L3VkWIEAgxLMh1z4WM2CcUoKMuE5EoGicNyuS5cySrL?=
 =?us-ascii?Q?cEWALScwXCRnEnFBYvHM/bCqIVCvv4m9hO3FCvDE3vUAYPMDrqRX1XDojY8J?=
 =?us-ascii?Q?I+PFEwiG6e9i2kFSY+K4tgbO65kjGMpuwiW8fb3r54OhI2eSltHtpagDehe5?=
 =?us-ascii?Q?JNLltHisz4+/FW3eKyiUKnwqiAFLygNM4mLx8/TxaRWPY9aDNC2xyKuRWXa6?=
 =?us-ascii?Q?oYGJ9r3davmwyQ5QqQh455M0gPefBVLVtVzPPnBR3m0mrlrtQh9gIy83d27n?=
 =?us-ascii?Q?uoPRBc12+fwow9iTJAYtTXvXGC1Cpotg3WCkCGK9sJ3Jl01VTFl5g9tkYAoy?=
 =?us-ascii?Q?oCRYvb8dOG5k0gwWQgpxMsqt5N4tNlq1EKxVYP33LiAjyoST+9YqWWOCukuH?=
 =?us-ascii?Q?F5dod2m0Dx6qasp4fk8gzp7HUzzoQhM/IUfMds8ITdG3i+VZfyEBXPnadxzO?=
 =?us-ascii?Q?U2Lx880F/e/AJVfolVXO6gCfZRHLVr/FxdrxkEwhrYxSZXVfLGGKnPnsXQE1?=
 =?us-ascii?Q?uJG5OHdJaTtiNAm3Guux2pDFN2FluJdDraV2qVsazcJJr1i7qMlX0RSYZcdw?=
 =?us-ascii?Q?PWvutLiCbozaQLWo82sF8f/EC/hxdfcGgepOeuzKKpqb2pLXCn78g7HQUtZr?=
 =?us-ascii?Q?XjMbVRl6yIKanclX0BSwkLF8Ttqd6+Bl07Op5HL+L5RnV0HFdshpQlWOEud8?=
 =?us-ascii?Q?gADE9nKna3xfhoFpZxNVah+MPYKwe48jmjEYYMNvwAAZZnZI+/KMN5GcdVb8?=
 =?us-ascii?Q?Zx37dKrgHz2MoJhDqSzummH1EsQstEIkYSNaIg0d1uXyWjA/qhdCbuf2MlWL?=
 =?us-ascii?Q?zbyhBtRP5suexObJqpwN/plGPIYXG9/aCcYzKKQS9pzBR3f3r7I+pkaV/8KH?=
 =?us-ascii?Q?LjCvErhDqu/owoGUdhjIVZx+RC6SJmflqvF2lDLnK/lohldRTK3PS6VS8q84?=
 =?us-ascii?Q?JqjeaToK5OHqLMXhvQ9nDXyqPjit407mixXDtPHFwRU4HIQmXca9Rrt68utf?=
 =?us-ascii?Q?GCSQgsqMMaSM0u7A8HEnC3ZyrAve3mNUN37fq07I2746CGCPMHTjnH1Ql0KV?=
 =?us-ascii?Q?/YbtN3tj9725xl7duR/oovz/jngOWT+u2fHVN4t2/nxnIS5wi5IlQssKW7P+?=
 =?us-ascii?Q?NQiLI+0k9+TkUmvwRjlvanMMFgR0qiva6rIWJUDD40hHtI39tWRn9PWSIEub?=
 =?us-ascii?Q?tLmg1QLDdDrNN1xSigLfVNychHtrSuV1VDnVyIGsRe9ApI7gCQqlafKwC3fK?=
 =?us-ascii?Q?oCzKDGOWrx9t9OjG+xuMecQANGs0PZEtgIL7zmPnHrhXGdxMVuf0sEOgZbid?=
 =?us-ascii?Q?/P3a45pPhB4ATanwOZB5Tyh3BdYv4R9zXtKr+fznCsQszybXUafeHb+oXDBL?=
 =?us-ascii?Q?P/SdxJmvoAESjcsUC05/1/HpzP3WJ09xjAuG?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 11:52:27.8273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f604b83f-aac3-4c46-4660-08ddc5f191b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7850
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

NVIDIA NICs do not support matching on packet headers appearing
after IP header if the received packet is an IP fragment.
This patch updates the relevant documentation.

Bugzilla ID: 1417

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
Depends-on: series-35735 ("rework mlx5 guide")

FYI - I added Bugzilla ticket ID just for reference.
Patch does not resolve the issue, just adds missing documentation
for existing limitation.

 doc/guides/nics/mlx5.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index f29408eace..f58fea106a 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -3305,6 +3305,13 @@ Limitations

 #. IP-in-IP is not supported with :ref:`HW steering <mlx5_hws>`.

+#. Matching on packet headers appearing after an IP header is not supported
+   if that packet is an IP fragment:
+
+   - For example: If a flow rule with pattern matching on L4 header contents is created,
+     and the first IP fragment is received,
+     then this IP fragment will miss on that flow rule.
+

 .. _mlx5_nat64:

--
2.39.5

