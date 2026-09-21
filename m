Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9735BC982DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 08:32:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78E0B40265;
	Mon, 21 Sep 2026 10:32:13 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
 by mails.dpdk.org (Postfix) with ESMTP id 5E1044025A
 for <dev@dpdk.org>; Mon, 21 Sep 2026 10:32:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWZi3KiX939ILGv/YGGiWyEgAwg17WV9XJFGEkz95gy9fV34aSv3JyfvvalgW1ejWEiguFm6HoP5Vy+2wE6gO6M5WqhsTAh4nrJwyGgwjE3SFwhaze9omiT38Bb7xk4cxVoH3W3c1matvw01yyCzKtveYkgWfxRSMOb9nTCfj+ODYlgfbxcuzIhvpmkoR8hjVgSxSnY0lH2/BCCcrHJpIfmXFqnbQeuXKvLQ23UE0vAlgo3OucEDzjIu2Q5vIiYlXOtZzsO4mw24ijVoAJACP1m6Eb0mC7Q5u/Ev0RoTKDdYDzTgmKP94uVrpeJDam5/9VH19edWBNFVfZhKt6MIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmF1LkD0RW5Z6GkqLV9zo0YNKik0WhA5B19PkOiqM+8=;
 b=s+kyV0KqsyHlRJCIpxN4frzmue0oE+esI3nAWtEKwZrsA9vs/nd2YiZLXBOXeIyNsa/Rf4JDZcMC+FsUqYpq1V91t71DWUcUKBWIE+IBvMgrFV52WNQHD9MrkHjKGA8pCvpBM/6awLi1cjdwlFrkqTuAklvxyzmANeDbUVNaOD7TV2fW4XhrJq/d6m6LbdgV0Om/v+htSk9QQXXYjYkTLlw1JZHwoez0NfgJ22xH29zFBOi0b2QiSqwA53b1nNocXaj+9H3q9Ue4Ul7AF1BV3v/Ow8QaS1Uc8gFyC+amw0H9B7HwJPEPk5KuAqJnWNOweSdv/FL2mELxdGiUmjpl/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmF1LkD0RW5Z6GkqLV9zo0YNKik0WhA5B19PkOiqM+8=;
 b=e5BxC8/i7Ud/SvmyHfUwwzsziuBRtsUYqVPQTAIm2O6DiBYFXmjnUWjRZWfYyDuWUDEPrzIGSbqfBAifBfL1ydMsxXx4Fqn0hMzAM3+0bwA6FLF4LNBM4iHdGM1PZZzCIYBOgUWA/8EaixbEYhyNImRB7PpFjGKxgbrvClgirD6LHlwRdaNhwX18atizHRuOpC6zSK4xS6B4ZImz2t3YZprJ+hnUC6AP5jUNgVduoGUDJjS7EP1F3kU/5ntFZxSC/7ZMY0HheWj3RHmvUgGMeEDZPl6s3Jj0uO0UoxKuGd4PzAKybF2uNCDthFXq+uSXox7eBbo9yj/YMv173Ya2Ng==
Received: from CH0PR03CA0214.namprd03.prod.outlook.com (2603:10b6:610:e7::9)
 by MN0PR12MB6368.namprd12.prod.outlook.com (2603:10b6:208:3d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 08:32:08 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::16) by CH0PR03CA0214.outlook.office365.com
 (2603:10b6:610:e7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 08:32:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 08:32:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 01:31:54 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 01:31:52 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: <dev@dpdk.org>
CC: David Marchand <david.marchand@redhat.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>
Subject: Re: [PATCH v7 2/5] net/mlx5: remove redundant MAC address index checks
Date: Mon, 21 Sep 2026 11:31:23 +0300
Message-ID: <20260921083125.40120-2-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914144234.1540150-2-david.marchand@redhat.com>
References: <20260914144234.1540150-1-david.marchand@redhat.com>
 <20260914144234.1540150-2-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: ee18c552-bd5d-4a34-159d-08df17bad2f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: PF0fxCvDL/UsQkhThs26ju8tv9qHACZMbPMzRXy+8bvqi/rSkHx34SzWZtgznR/PJMewGy0uihs4PNGJT0T1Qs7zE+RPpyS9KSl8g+2wXFHzaS+H3/HlskyroIAC5Q/q7LE3pfhil0Va0hDPsVJBdFfz63yBL+tKLzhBeNbVl8Khj+BDHnXZi2i+IzFdwyCEPM4ZdAg2GIvkbKK8rrknybHH6d4xdWcbfCBNjSm+GFVIlG+V9vyibk6cMBVfe9BG/QcCJc2tfQadSUIEKzMwRLMwKYICjeoMmKfwvW3Cl2oT5bgXdfBMRHty40h6UxLfsSM4khMBUyfWtwGg7WZKrLbTcudlsTKxUF6YTqtK1RXBR6wDPXiKXm/+sBziev1Pl0USdKytMH7fFq+hK/Wylwzi23DmwA0M5SubUe9Bw08XxiCNZEoK4mq4wj1zkyqlVpiUdeW1xxoNxteThBpfbUuMKAhr/Tu438oRN6AYbhZ1kG4WKpA8rIb0TJ2KSK3lErpe9LgK6x3xuEc1g7hM/eG/cm9TOKl67T4V70L9IKwQqequ+4V4zkeP35BI77eu0w6gcsUQ1kA2hebEJCX4UAxuQX97YRHH6u9iBOKWvpE8mLLxZa4PHhCuvui9WMNNVX4jK3D0NRJSARUWIi8tigCF2AGoBS0czuF8FgrquvuLU/GjkbtcUuZwuXFeo6K3O+p5D1cYJiaOukxxvwqSDQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: huyv4Id+XmnLMalXQhm4PVOYIAcvfr8PP1YtZ5m99NYMSgH0RA/qkkkxMQkbiOkRHs1PcWpjK53hLF7CoR3Pg4l9XGywTCkrKyQmcqzv1GIp6AXpxX1RL7IZFhhfmKYAI+7X6L/qy3YRUpAt9dUZeZu2ayBDyOEm9CrJ/Qu9oQqY5wV7hYmuaNPSYGXyA40GRnW7qHA78YnR9IrNIBkqLJxy3thCyX2fQmmEWK7YRU+uVHoRT45jXCWFKQpdbLluWaezq62qc/vRh2zkdZ8gx8N4BsqnTZFqVBZP998ufk3GYX6KJDhLaUwiA1UvvP7kPjCVvsA5VEollWnPXCocMcdGFf5KBNsZI7eoGX5bvdMazQgGPBJ1Y7R7c4byTcp7lZ8hm4gD8rcjfhg7bPdN1EaFcFEsPQ5w8aECGNn/3DJ4Bw8oz21IvWm6pZXfNElf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 08:32:07.8970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee18c552-bd5d-4a34-159d-08df17bad2f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368
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

In mlx5_os_mac_addr_remove() (drivers/net/mlx5/linux/mlx5_os.c), this
patch drops both the netlink `index` arg and the Linux bounds guard:

-	if (index < MLX5_MAX_MAC_ADDRESSES)
-		BITFIELD_RESET(priv->mac_own, index);
+	BITFIELD_RESET(priv->mac_own, index);

but the Windows counterpart (windows/mlx5_os.c) still has an equivalent
check, so the two backends diverge in defensiveness after this patch.
The check is indeed redundant given mlx5_mac.c's index validation before
calling into the OS helper -- but for consistency the Windows-side check
should be dropped too, rather than left as the odd one out. Could you
remove it there as well in the next version?

--
Raslan Darawsheh
