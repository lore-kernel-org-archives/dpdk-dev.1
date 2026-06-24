Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B791CCDB481
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 13:15:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D9CD40663;
	Wed, 24 Jun 2026 15:15:05 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
 by mails.dpdk.org (Postfix) with ESMTP id 0A6D740662
 for <dev@dpdk.org>; Wed, 24 Jun 2026 15:15:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxeR0+elaPTShrPypeIzTgkvuGBTsMuYpBkA7ReSZHo/m5AY+qZBBajx+dzjCP2989EAVhMfnZv9KBuvulXChwYVOvTT/QsKHL5YCvdddFgLp9SwLtMooMa/tTFwTQHr0TIYKHXEbHZ+uE7jYlgbtTU+LKhBTtDp6FN4tO+rv8e8c25VuZZANlLwFAVVW44WIHX+Go58D33doi28xOTGlvZINgjbQvk40i3S+1sTy7Jo2oDeO0DxfdfU6Ot94vnw5nZmDoMOuFNBBs2oVhlcQFDrqS1ir18M6GBoSQRG/46bbNOUwUi3HIs2VIdZEMXkUmGXNlS273IFloAgCcBoSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Miw8XAYZ1c/f+ms1DRv8tIpvKQnL5FIWDjHJYVavcf4=;
 b=qvYkVsWS9drLgbnK5fdRyzmChysq9rgptk+hx4wbq5xOM8SaDBKKXWH3rLMjqFcdffaChmPpxohMlI6Hblnto4lcF6vkbfFTCXL1MhnxUbwbBDDGnTOX0V58dgK6yjXt0ADin5eZ1RSRxTQo5aeNb6ydMKN9Z/i1uw8FpUV2ee0zLpBEKUCC6solP08S4pp06m5uaLwu579InAQsr64IeUwCdtGF+51kRDBE0jHZoa2WSbLdri0316dM+NYuMKI7KAJXGjLYkhB6ewnIDLv7VCE4/FHldaeAdN2qCs5Lsma8SSjfSBG//YKmHpfGxyLOdWM7kkv6gsKI9d/E0KK4Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Miw8XAYZ1c/f+ms1DRv8tIpvKQnL5FIWDjHJYVavcf4=;
 b=pmSh5ykPSGvImV7Cumobu99WK21BuXedxBz3Cc0+GH6NyyYOqRcfwcBfIN3fi7hrdGUndoA+1VKuqtKmENN3+cKB3oeFZnIiyAzyq3zNPsUPGMr82IvRkHplCqGDZ9IA0a125OZdhJqv4BlUi+zwMEsAIjd7MV1bvcFwD1Enm6Usb/xEwctfwQgljAmlmzNkbUM/Spn+m23xCSWBx0io72nX8ve0XAmcNQIQRbEIqZ68dxZy6fGrylbEEoe5cO1ZSU0nX8+LTn52lXW0cwKOrl1FCKTBNDOiAQY8oTY/GcnJS3wAZdhgDFb5INUzdfTu4RQM2LvUsqjS9lbVYw2ILw==
Received: from BN9PR03CA0301.namprd03.prod.outlook.com (2603:10b6:408:112::6)
 by IA1PR12MB7709.namprd12.prod.outlook.com (2603:10b6:208:423::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 13:14:58 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:408:112:cafe::a8) by BN9PR03CA0301.outlook.office365.com
 (2603:10b6:408:112::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Wed,
 24 Jun 2026 13:14:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 13:14:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 24 Jun
 2026 06:14:36 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 24 Jun
 2026 06:14:35 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Yu Jiang <yux.jiang@intel.com>
Subject: [PATCH v2 2/4] build: support function versioning for drivers
Date: Wed, 24 Jun 2026 15:13:34 +0200
Message-ID: <20260624131337.1127323-3-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624131337.1127323-1-dsosnowski@nvidia.com>
References: <20260623113752.1100072-1-dsosnowski@nvidia.com>
 <20260624131337.1127323-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|IA1PR12MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f920f5-d653-410b-ac4b-08ded1f29740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|4143699003|56012099006|11063799006|10062099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XAzQqxzvfwN9xk+cLGjI0j1yIeGb677YckBcRpyNlyjMRKSKtTlZPNJd75w6IozQIi5FiY2NUmwqF0LJCqmBnZPWwqhwpy5W4KtjyjDDmVy+cy2pnM3JkM+SvA9gUwRBGKZPDK/ho56vAODyNuorY0QPqrwWwWYldIbwwe7P6+B2FHuA5rBYjo4loyZYHEfF+WIwuTOhKk+N4FT+ADVQQGQ+fcgmL67iEYbczXIFbpOyQQXFMCQAJDv6e0jGGAlbUnKatkYDRKwL8LKnbNswdeNvWdbN/1RrPM4aZX5JyM1lXURjApEfkVLqobJCjk47qsQncu7iV5TN+2nRW3p60bSiXdQiaQmL2tDDoQdlK5DhyJV7LxYeNGDQHW5636tejsaFEo/C9qr8r0XowzHZVt5YnygKzVfUUnLU3QH3ncQ+PQ89BWHF6J6PJfPkczbxt79uEjNBZbZ5Ij+4sS+tpF3XCPoGCUJSvY7GLLMjodIxDjT8DwT3+IbNG1hmX6gkMbNXj+UEzWhINNxwkQgLNq3pO/Htb68XzUqBMjt5rhceUAqTJNi+NU4N45src+dTU93eS0j84QXcv0MEGc1yGhBIFPAj+J5udeoD6vgme2UmYj5Tz8quvOjB2fRURmZYuj8/P2SWJqnbJA3x2ezfaoXVuwmSbWjqxiPC+OzGro5oZw4Q3amd0UA6mHtT8WO/fDWWVdtyvR3pr5v/J3QxKQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(4143699003)(56012099006)(11063799006)(10062099007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nJeJAbVxo1hrZ/0vJx23qmKcew1OXICbj31/7Z5k4bj/wg8MzZ84iISGUMaRjALMoSR8+9ja5E92RlO4q/0DzCLkFf0EQPSUFBfQKqxOUBOAnjiL65sC5d4S7h59iOIGfxHql0vOQQdmswCi4fxCcPgERsRWqbD+w12Cob5H9IcAL9Jvbcut2zlDW9P38hZSRSw+knLlkGM8wFgp8eC/m30UGO3/Tq6zzys/lDYcSE2GaisVADxS8ckdUF9BW/CboO9XUfEvZw3XjuF5jToShWDnzKN/peUMDwkR0vgPnxxKPR0M5MXgHui1qHGhTV1IfURH9mHD2CDlZhCyeoWHKgN04T/87gTPW3ICeetKKUmLZvEg7KwNKV3mkEXIQiA1R+61C2iF4txiiXjpjzpKla4yCU8MVcVkBEUzbzvO1/KzG9ZgeVN+ZmlAt3t9738m
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 13:14:58.1261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f920f5-d653-410b-ac4b-08ded1f29740
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7709
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

Add support for enabling function versioning
(through use_function_versioning meson variable) for drivers,
similar to libraries.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/meson.build | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/meson.build b/drivers/meson.build
index 4d95604ecd..a63d93372a 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -171,6 +171,7 @@ foreach subpath:subdirs
         pkgconfig_extra_libs = []
         testpmd_sources = []
         require_iova_in_mbuf = true
+        use_function_versioning = false
         # for handling base code files which may need extra cflags
         base_sources = []
         base_cflags = []
@@ -273,6 +274,13 @@ foreach subpath:subdirs
         endif
         dpdk_conf.set(lib_name.to_upper(), 1)
 
+        if developer_mode and is_windows and use_function_versioning
+            message('@0@: Function versioning is not supported by Windows.'.format(name))
+        endif
+        if use_function_versioning
+            cflags += '-DRTE_USE_FUNCTION_VERSIONING'
+        endif
+
         dpdk_extra_ldflags += pkgconfig_extra_libs
 
         dpdk_headers += headers
-- 
2.47.3

