Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41BBC98307
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 11:56:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BAF140262;
	Wed, 23 Sep 2026 13:56:12 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
 by mails.dpdk.org (Postfix) with ESMTP id D15B14021E
 for <dev@dpdk.org>; Wed, 23 Sep 2026 13:56:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgvA4ujBefPsAOiQFQw3CZ8kfR58d3lZrgUxq7Itho3hoRwtF5vK1pVwhjTT+iSxc2dUmFcTcoYiH0OljQJZIMP7gjfJlr+BzYgtutVsRi0HPsKI8QyKZebi/h6vDEIzcrPFblV1R2Ytfx1/OvPyCa0f0CWtsVK0mI0rPCM1/4/1gyi2CIgLNACI3Zva0pT2MtnhEhNKA0Hpt/yQjPhK/Iq/N1H+6VZXy7uLrESzD51lZS86JPk8dXVRXrfsTuXHB/9CDEq3HIjir3YzN00eaQnwdpM+uCMCaZRCfon/rI8y3PazVsOXt5bYenANTR10jVTqn0CEcfkd9GMHjD2pEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJkteTztA1vs7zJy4WKi+R+geSAHjGEok5q9+MG6/A8=;
 b=x7FIsH4eUJ61PkByVKZfu+onjJTdHEm3bSHZenLRakHWIWUNVi/g4fF3czAgCV6iPyQBaO9qLfmACLrqPlnarXdtS7CcbhtM96zXXWr9so2jrTkJ2VXe61qv9r/c4eWuNWcFZgcX+HRPmzdDptKD78jQKlCqmYqPPqNQ//3bEcqawRHj1itXf1hZvwLBSFdSfBdv/+02eY8p7+gCl08K8KS5qk2JLvBbjYJOtLypSnv0o4tKeQjnGiuh/sH64jycYnXInuezI7zDBSQ+QquJNweDq2gFRXb421uvZcT+kMgFQuIW+z+90UDNqLfTdbTX3Du+BtM/m1E7BU4QjOlb5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJkteTztA1vs7zJy4WKi+R+geSAHjGEok5q9+MG6/A8=;
 b=lzX6IJ1qbScilsO+w9MZpKPN6Xk504CuvPz7TtTXiFpLeuknZSTLzsavD2vOh4Vm90kufaoKX06rk2rxxFLt1oZgaVYYvT7rz8EFLPegJrugFFEc4EqBj4Q7np382rceXuT11b3FZ8jSwKXVBBsnulQae6RPs6Tiw3yV6/zlLxA8lv8vdEyC/tRwcp1rzLW/J+XX0YMYn1vV8bQAQQxe3F95y6tYhlhF+pWpzwUwRqsP6pBghw9l11R+DcgUSE3xSyy5MiAc9pokEwjTNaC05BZIWwyNQQNokga6BQkmmX/KFExiyQqdQNWyf/tckvNHtq4jQr3/0w7yfyFk8sVzDA==
Received: from SJ0PR03CA0206.namprd03.prod.outlook.com (2603:10b6:a03:2ef::31)
 by DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 11:56:07 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::61) by SJ0PR03CA0206.outlook.office365.com
 (2603:10b6:a03:2ef::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 11:56:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 11:56:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 04:55:47 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 04:55:45 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: <dev@dpdk.org>
CC: David Marchand <david.marchand@redhat.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>
Subject: Re: [PATCH v8 5/5] net/mlx5: accept more unicast MAC addresses
Date: Wed, 23 Sep 2026 14:55:36 +0300
Message-ID: <20260923115536.87539-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921115033.2335147-5-david.marchand@redhat.com>
References: <20260921115033.2335147-5-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|DM6PR12MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: e84ce801-6bb2-4ddc-b4de-08df1969a6d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: g3WTE+o1THZEtl7uOVvE/6YXEL9IvIeF8KqHxdUkxTQJqr/kyJuAckMPa69TePzS1Ycx/B5edevqNnjWgZdGSYF9EoAen0DRdJOAWtE6xfyVEY6x1Eb9wjqFUDf1Sv/M+LsnzhGPTlE4QrrY1IFXbIeF0qxjF2vPfVj3HvrVUVOKAjMGfaPNO7Ft6K3Me0YvZP6eNQiKwGRCXafnndsu4w62I9+Z0no1Xleo5kWqhkyBc0xDf7nbRR76oXtlbZM4qDglV++keKjukywJzW+NFDR374dpSdhGU/107nIhip+VnOfr8q9DxP+vVzp0G3iew33dn6NMqeu+lgOPt3jxi2H6ucTA7YfKSTAu90OVpZrl+wnHTAmWuGtmGDFFLcF6kw+/RI7zbdtkIdq0cfC9SU2aB7xrv9I3YuF4Wz3b5wC49DGQoNYPViWOr6lt2vuhsHpPxT01I8LK0cXwy8tVaVKWWahb/31ylD/b99Xg5/T8w+Ma97wiCcicScP4lCaDV++pnL/86zqR8sIPVR/EJE+E7HS7PNEco2tASc3vWxzLJTr6RPI5DLzNTXcXVvCwlphKT5JE5QXu7WjnnxpEk3F8tQBScel9x3rmII6QmFOu5JOl4SvB3Mck6IcJuyVXozo2bxK6OvdNzBSfdDJnXEteVq+bTTJirTCy8vjmR084j3wHaZ78xne04Rndm5a4LjEkXyfR67tznffRraMV6A==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MP3KdGzIMyHVt4TuTo/s9Qp1mVWPZ55EcmS0l9JMD2BXyYji8Cyorf+7Psrl5ilyvhVoucBaGoctjOgNoxuRFezXv/ODKM65r5GGgwW+VC+DkrUavLYI8p5kl2bkpXaCh5jtWHNp6p6xiR6tyJMPFmBy9svSvFok0P9sn+mxcia6LBQkzHiUof1/YDFKBQVxkyu+kHBJ90/djZUerqsYEiZrMdF/il4kf6T23O8+rwTzbqbWaak+LzGA++hYwc6dKmP0y8fygkV7yKN5tZeY59TFaTpBBkW1mNNaPyB7JLKIG5vCsfyYYoHY3HWIk2GhohTkzsNvjoo45pSuNx+0P8xv2rGt5pGy7jazvyV/JaMbzcMaHDHt0CfFViT7mThOUB4B9T8d9BGRX7+/21vgUWNlK+vmQScNOyABpRx4YhsDnukkOeksd29dzoDX3lrO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 11:56:07.0008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e84ce801-6bb2-4ddc-b4de-08df1969a6d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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

Thanks for fixing __flow_hw_ctrl_flows_unicast() / _vlan() to loop over
priv->sh->dev_cap.max_mac_addrs.

One more spot to check: ctrl_rx_nb_flows_map[MLX5_FLOW_HW_CTRL_RX_ETH_PATTERN_DMAC]
(mlx5_flow_hw.c, ~line 11588) is a static initializer still set to the
fixed MLX5_MAX_UC_MAC_ADDRESSES (128, unchanged by this series). That
value becomes nb_flows -> cfg.max_idx (mlx5_flow_hw.c, ~line 5335), which
hard-caps the ipool backing the DMAC/DMAC_VLAN control-flow template
table, and this table isn't on the resizable-table path.

So __flow_hw_ctrl_flows_unicast() now loops up to
priv->sh->dev_cap.max_mac_addrs (which can be up to ~4096 per this series)
and tries to insert one control-flow rule per configured unicast MAC into
that same 128-capacity table. On any device that now advertises more than
128 unicast MACs -- which is the whole point of this series -- configuring
more than 128 will make flow-rule insertion fail for the 129th+ MAC, even
though mlx5_mac_addr_add() itself succeeded. Rx breaks silently for those
addresses.

Could you take a look at this one too?

Thanks,
Raslan
