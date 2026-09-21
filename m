Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FED2C982DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 08:32:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1676C410CF;
	Mon, 21 Sep 2026 10:32:20 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011021.outbound.protection.outlook.com [52.101.57.21])
 by mails.dpdk.org (Postfix) with ESMTP id C074C4025A
 for <dev@dpdk.org>; Mon, 21 Sep 2026 10:32:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZnSQc9WzYejEaGx7vtUKZQfXyMEARgL0hYrZtzFbNWofByvXfmysH3JMN+bldi9dRSMMfv/3PyCN/ij/kEoinM9ZHOI/jWp+jjp7dm3FuU8QWCMRxMTW0/WXHUCgz69Py0hZokzDFHSi13Drjvq5tNQ5i/KwVsAIOXuqwhvzszQ8rHFHqewQca8mXgKyQBZsJQwfYP2VT3nPWSsKGgRM2lehRH0n/2TaU2Wq96a1BC782l9Fw08JoXXpjTgCc7uWFu3aI2zmhGUZiVctqv6qRVnLDWDfenU1lMmguVn7H4THCCn5DoXrQDBHnVFTdCsSprX058PIX9yQd1OiQaM7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P07rjno98buVErZ4vcYraEhJ+NoDNicvxUe6uk2qqLM=;
 b=Y7nIRL0FsccdqiW5shRwa0xR6DYqy1PMik/rPcthVgDjXijnzwxp40VRvBGDJxSzkKnKeIs/7fJlQN3GqXyTGndotr1q8K+pxqYQpoQ6rmggJRWH2b8GkdcoUSvrcoX8loVwVOkIHRLRVCkqXQNwdaoP2D0kIIST1PyeWt/dwMUVUmfGh16T6wybQGYsLmDiF+1GmzUyaeYL5SWFvgY9O06NgYZ5Q8NDCEXlDfs7bAaXBNSjPsOqCqo63jA9OyKqSkolM3AyoXHgZ2ybvsOTm7tbeQzjJOkoaS80NDWIE8TzgiXfLgWg/zrkL4PIiQMHDlpYZ4iyHNJnUjX5AwZnFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P07rjno98buVErZ4vcYraEhJ+NoDNicvxUe6uk2qqLM=;
 b=hSoIWWzaSzS5Z7MYwOtaQJsUs52YEWZNtt6m5O5sxztcWNxji3jBGncVHbtQCwWIbtvKMTIyjTNVS6wXGiaL0XJ3pdI8x0vgKdZx6dkZkRgf0GaQgvO6ZcSgP/6UY3OzEfUhgIEJu49SPzU1SHab7TrKukAKhalin4Y+KQ9Ut9ybaHm1NR4yKqjR+yQLmb9Y4Kwqf9FGYSWwoQREyeQ6HyuRoX/DlTCH3cmv7/dwaGF2g2o4QaqS7bH/qjt9DZBwIhIgdln8pPgFTZsXhSR2+X1HVpbLVyJSUCJaYRDt36DbtC03t8jFt10wQosXa90WhHpeBrsYyWLhzdu+dxSUjg==
Received: from CH0PR04CA0087.namprd04.prod.outlook.com (2603:10b6:610:74::32)
 by CY3PR12MB9607.namprd12.prod.outlook.com (2603:10b6:930:103::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 08:32:12 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::8) by CH0PR04CA0087.outlook.office365.com
 (2603:10b6:610:74::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 08:32:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 08:32:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 01:31:57 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 01:31:56 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: <dev@dpdk.org>
CC: David Marchand <david.marchand@redhat.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>
Subject: Re: [PATCH v7 5/5] net/mlx5: accept more unicast MAC addresses
Date: Mon, 21 Sep 2026 11:31:25 +0300
Message-ID: <20260921083125.40120-4-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914144234.1540150-5-david.marchand@redhat.com>
References: <20260914144234.1540150-1-david.marchand@redhat.com>
 <20260914144234.1540150-5-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CY3PR12MB9607:EE_
X-MS-Office365-Filtering-Correlation-Id: c702927b-b275-498f-d384-08df17bad59e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|5023799004|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: h0MgYss40fROl28g1exq9m7TzXr6cCT/7QjM+hdPY+dg+g8ASXmZVxz7xsi+lfsUmFJ+10K0rLjNtZgiKhuaOARsw+4C3nYyrNPpO+jmtLrbDpdAdgEQddzgwR1N2SzcJDx651Rsl1+eZhM+23DPUPQcpmkh6iEjVAkJmtRDTX+7Mo2bttU5S5BvWD4Q5ycgWQjiAHhxaqHKRcLG4toiyDykfkQ0YRc5s6LXbj2caULZXMKmfdJr7hu+DZmC8ov4dvTO4vy3QQYlRGl8AN1Ex32AbkHYwxHx4q+Lvvde/gLxeyxGb8HaB6c852XCpHjuunKFhIsub0OLFL5wzTSsM3u9kBUyKdIbrfqEEVxh8DBq9ZzVkv69cst73wJCz6k7paa4I2VJZeduNnCN97cQ7oCyXBBUmz9WIoIP7OevoHDJ9NNRihHTp70qF+CKEZgdYAZ69puGbsH6WdrjQfNwwVnaKz8tj1ujPRQiBc8+OYEIzJdTTDe6jo0RUNG83lWeZsMqlDBfi1BNsGro7pPmwNlQm9HbTSIkcfeMdvwpnOhqrYW0h+2DS9CPY7zAaI3+/FZEJnTJtamienigtnXvvUx6ovh1d6Cu2WXH/YBvjA6QfGy0S/ArmRYe0XmcMmyIKM5UYCXu30LFx2xLQFpChsMdYRVXaXuHQWNc0rB8Xx6MaMcfsakBntH1va5CKLIzXXRIXvasGq93lQxyYTojHQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(5023799004)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iIgNJ4BEU7TGEIUKjJ76nBpy9omD/tyTf4WHZVC446EEJFSpiqIG+JBJeqPVYxwWJQaInCEhCEt6SpfT1v9x2KjRwp7xz0X55PscqisZQ+m3MpaIrDV9HHx8fCepq7Nf/mtKAHT0sF6vLH82CQ1bIuRo31U+XCa2ULr+nm+eZpVPZbJsidU83y4fDywwLBJIAPs65UrayjW/DnKQHIONj6GfwCrhvx6Zx4HcuhhsjJRw7xUMqiX+nRaGwKDYLah4nD6Vhx64SpxARQ/I7U/UKD3rPGr6nHhQ/3bQjhc7+f7ZKRKV/r4Q8UXItEvf3eSjr0J/UrNah+fU4uAQxszPn6DwToLsJEOoBkwz6OalSZJSIqnPPlCF/Oa3WJnzUrdvVCihS003JmTpzSvosGZIDEwERTUkB1Q9z6XX9HdhVlpMnpRIEdEmYQYO/M5IdLlp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 08:32:12.3681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c702927b-b275-498f-d384-08df17bad59e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9607
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

Hi David,

🤖 This review was drafted with assistance from Claude (Anthropic) and reviewed by me before posting.

This is the patch that raises the effective unicast MAC limit
(priv->sh->dev_cap.max_mac_addrs, up to ~4096 per the FW capability), but
it misses two consumers in the HWS control-flow path that still use the
old fixed constants:

1. __flow_hw_ctrl_flows_unicast() / __flow_hw_ctrl_flows_unicast_vlan()
   (drivers/net/mlx5/mlx5_flow_hw.c, ~line 16703 and ~16770) still loop
   over indices 0..MLX5_MAX_MAC_ADDRESSES-1 (256) instead of
   priv->sh->dev_cap.max_mac_addrs. On a device that now reports a larger
   capability, a unicast MAC added at index >= 256 via
   rte_eth_dev_mac_addr_add() succeeds at the mlx5_mac_addr_add() level,
   but no HWS control-flow rule gets created for it -- traffic to that
   MAC is silently not steered. The non-HWS path in mlx5_trigger.c was
   updated in this same patch, so this looks like an oversight. This one
   is the more important of the two to fix.

2. ctrl_rx_nb_flows_map[MLX5_FLOW_HW_CTRL_RX_ETH_PATTERN_DMAC]
   (mlx5_flow_hw.c, ~line 11588) still sizes the DMAC control-flow
   template table with the old fixed MLX5_MAX_UC_MAC_ADDRESSES (128).
   With more than 128 unicast MACs configured on a capable device,
   flow_hw_create_ctrl_flow() for the 129th+ MAC would fail even though
   mlx5_mac_addr_add() reported success.

Could you address these in a v2?

--
Raslan Darawsheh
