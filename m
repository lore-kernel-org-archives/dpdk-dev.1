Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F54C87FC9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Jul 2025 11:35:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E7A040E39;
	Wed, 30 Jul 2025 13:35:47 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by mails.dpdk.org (Postfix) with ESMTP id B6369402A7;
 Wed, 30 Jul 2025 13:35:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltW8If+EXZcTcqDQuTholeohisSx3moM5HkzUz4A0cDK69RgH8Hs9DNtOGPjon8rZPZc0ZmWtzgKcdQdLTbZsxSJ6dxavDtcw5VStoN7+POUOvQ9Ylba91XFKg/n/pCW3oCXmodyqL99j0sfXqh8m/Yo3EMUr2AHvreg+Xq3rBkYE8rzRYmGnkxzXZZdxaqlYN9HlXvLQLUEXXB9nvnGKBeFqIun5kMHRC7Wd9JCdewS49Wv68hNk5YS4kQ6PVqQYol2A4CjnauelZnsZqxL74NCDHfG3lF49fKVVyPXVF7kPgzNCVR2JiBM8Oaah6jPpCkcUrq3dPz2FUre+pYqmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vH1ZqZArLuWvE837iPZK28Lxe06stgkSx0Jq1zF5zdE=;
 b=JsSUvHyxR1deEhg9UmjTTfG3L+r6vF+DYOk9FNz3JUpgWYr+rcEtKZPjmNgncjhQdSRnRFM6eRHjUkodu3yaaYCkt10uQG163FxNd5SQ0MX7ENEmsAo2OHWU1I1k6yrpJTfxAEqc9jgKpVKyjZpd2gUjRolK8UZHthQaJUagpabULqFuxONFOOxly9rS5cYoec/hHgmJtIsX8pwPfnhcukeKEKaCQDpEdxWCKc2FqVg9QyIOgusk0GpmlAaEQs7RNEXpQCZqM7PfNlyfgSgCU8tEt6nXaTzqPafI/KXZIZRi6skqZAmTkyXPWIqzijIVp3mfzYUfUjY2rRV4UtYsiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vH1ZqZArLuWvE837iPZK28Lxe06stgkSx0Jq1zF5zdE=;
 b=c5yArl33CzTvu6gaWSrcv75/s+UXSY9+PPpx8HJLxXq5/0Ln9lQVViBtS6OqrPn7oL++KolYjB/lv7nF5qAc5mBC7voOwlDSkxxhWVt4ljHrM8FJkjT+qKFXeCoDKy5uWITNA5lBVepN2DKhXeqQLRLzQVG5feEzx7eXrcWhZLvJFSy/0qBpVSgSG76/jMTOiI9R9HqTDGzGaNovOvVTSA+kO2+oLn/+OQ7S1kIvlYMIGUPkGwu0phvjTwi9qzG8XsaR3F7CukWNf+q1qvigUmGGbhxA/hjFp1rfVw8rbYyDtV7zfapBJLMkHnt/Yu6aBBrLRV3mFS104CPS0DzZUQ==
Received: from DS7PR03CA0012.namprd03.prod.outlook.com (2603:10b6:5:3b8::17)
 by SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 11:35:43 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::f1) by DS7PR03CA0012.outlook.office365.com
 (2603:10b6:5:3b8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.12 via Frontend Transport; Wed,
 30 Jul 2025 11:35:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 11:35:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 30 Jul
 2025 04:35:23 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 30 Jul
 2025 04:35:18 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 30 Jul 2025 04:35:16 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, Bing Zhao
 <bingz@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH] net/mlx5: fix failure on device start for default rules
Date: Wed, 30 Jul 2025 14:35:12 +0300
Message-ID: <20250730113512.197555-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: 05fe49a2-cf40-4138-c4a4-08ddcf5d378c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B5+6z3xXwCQg3+6kL9GiSk0X+v0GfF9YpFbvLxM7HxGjqYZutiwXWWi5wlWZ?=
 =?us-ascii?Q?9RMgQz5OAxkPhopRXl/ozjRbN+Bb/eKyh66GgKJACIaz/x+0aCHE1damIW/B?=
 =?us-ascii?Q?gDc9/Ok7p2CO4mGB7sdVjBKc7boyGCJm4iNp6r6J8e2l70JHh6YhtCE/FbbZ?=
 =?us-ascii?Q?Oh2GOduC2bCtHcdrvoc2a3H2zc2So3dBA2/hVWLxhJA5j380JlRaMD9c5UTA?=
 =?us-ascii?Q?0B8f0VvWkhbPrXBqtY9+8+lZ/OXj7EE2S6kMvbs+l4AlWFF5O4yFbfEYKYar?=
 =?us-ascii?Q?XWU2iqGtQhYO4/eCB1YaELvcHRUkBWdeeuDdeS/Cbjt9nAGRjS15R7Cvy1tS?=
 =?us-ascii?Q?SyVBNQzOO4+RilZXwkzO6N8XEkzbNeAdk6S75kmZSKdMLMtp1Tticidz04No?=
 =?us-ascii?Q?z5U+qOkUfNhVGXJUsnTNCp1C5KgHaiJNuKOTJzZOv9Y93bBVXX4Wx0Nd80x3?=
 =?us-ascii?Q?4ucoATL4ytVqaER8KW7kfgzMkNdr8nDLhV6uYEXhVGzC53i74cZ40Dh1p9tp?=
 =?us-ascii?Q?tSUxXpkAZlhJbD4KHP7tGl8HrT9nQ8TbtGGRaec+VAnxGzbmS9IN6Q2j2RLT?=
 =?us-ascii?Q?+JeQUprZys7L6dfiVazZxnEX8GuDkhTfCkeAQh6jZ5agzPCEO7I5jRfAALXE?=
 =?us-ascii?Q?ZN65IvfQXw57vkezh7Bb9mxachni8zl8evnTR5eC/MehJPG2xJMXM4D7ocZC?=
 =?us-ascii?Q?iH4jil4JlTxzB9vU+F6nQHrD7L3mZtJcdrhFUpfVFqgd+5YXVWBzBs7D+hrk?=
 =?us-ascii?Q?p+lmYOI3JqW2mLCT2Tr9fkYmkL2Lr3BQvMTuEe6gDH51B425o1pjfloKkmUY?=
 =?us-ascii?Q?Tviz2o0ChVIDe3xTVFdtIrLye5E05MjVAiQZQndTr1xS+lt0Hs+3gW1QBNH6?=
 =?us-ascii?Q?Zpn9nN1RE5+xiW50p4HOTCCXvS3SHLj5RX4vL+8R2om004xSqfoOY/oeTzCA?=
 =?us-ascii?Q?jQfzMawRbAY6DxqoeQiWmzCQJTJRB3FR1burRm4lEY16/lfGUktecxVWhJ9r?=
 =?us-ascii?Q?sIOwRiVtBsUvxp9ZjAxlYohSf8Hcl5h59yOPeTgjI/ZrHd0Ja0bloghTuXuC?=
 =?us-ascii?Q?SEs/l3PMeVKot3GBmkxUV/cFZ/pXkeJ/gYHTMx3zGkXUoIN/rDwTwSwX1mTC?=
 =?us-ascii?Q?iLqtOsn7oMdh+UdyoLdfrDDaIxllPd4mly4sIeXX5gNYCU9e99hBRvt4ua2P?=
 =?us-ascii?Q?IKts/+GKB0Hh4YSRG6nU+1LBHHgzZ3hI/hR9IV75ZBBd9BRtc3syHZJRLh1Q?=
 =?us-ascii?Q?FaiRwC3potKXgZ1HK7eySKVmB8fMJk1XjSHZplLLU9KY8VHBQJWkj3eAryns?=
 =?us-ascii?Q?uNgA8HrSDKyGv9yQ0Pxur5ZIVt31MfPSG4VqTH1/C9PQa2f9MXBzR2WV9Seo?=
 =?us-ascii?Q?EsgUUZErA5QjRieY7obYX6g7GySBq0dMgHjwv3+OUfnSW+ssREjXrci6CXfa?=
 =?us-ascii?Q?ai6Agnj/2SAwu7M5N/8YGATaNLIrpLYqPk86csNPy2Ns0gqNI9UHM28o5yjf?=
 =?us-ascii?Q?yOawCeLao/zUJ4tnfsNTMSBsGuHRfzkvgENB?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 11:35:42.5951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fe49a2-cf40-4138-c4a4-08ddcf5d378c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225
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

As part of non-template implementation,
new default rule was added in HWS mode (dv_flow_en=2)
in case dv_xmeta_en=4 (32bits extended META for HWS mode).
In case the proxy port did not start, and it was not configured,
it failed to create this rule and failed to start port representors.

Added ignore for this failure to align to other default rules
creation failure behaviour, and to enable testing port representors
 w/o starting the proxy port.

Fixes: 821a6a5cc495 ("net/mlx5: add metadata split for compatibility")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 8db372123c7..7c6811b5233 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -8217,8 +8217,18 @@ mlx5_flow_start_default(struct rte_eth_dev *dev)
 #ifdef HAVE_MLX5_HWS_SUPPORT
 	struct mlx5_priv *priv = dev->data->dev_private;
 
-	if (priv->sh->config.dv_flow_en == 2)
-		return mlx5_flow_nta_add_default_copy_action(dev, &error);
+	if (priv->sh->config.dv_flow_en == 2) {
+		/*
+		 * Ignore this failure, if the proxy port is not started, other
+		 * default jump actions are not created and this rule will not
+		 * be hit.
+		 */
+		if (mlx5_flow_nta_add_default_copy_action(dev, &error)) {
+			DRV_LOG(DEBUG, "port %u failed to start default copy action: %s",
+				dev->data->port_id, strerror(rte_errno));
+			return 0;
+		}
+	}
 #endif
 	/* Make sure default copy action (reg_c[0] -> reg_b) is created. */
 	return flow_mreg_add_default_copy_action(dev, &error);
-- 
2.21.0

