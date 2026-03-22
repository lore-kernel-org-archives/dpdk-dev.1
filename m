Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69405FC72B9
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Mar 2026 10:25:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1976540647;
	Sun, 22 Mar 2026 11:25:29 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012043.outbound.protection.outlook.com
 [40.107.200.43])
 by mails.dpdk.org (Postfix) with ESMTP id A96D54042E;
 Sun, 22 Mar 2026 11:25:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNw2cl+UXYGGHXdJKgB0AZh6Q5GoVzXRjsFF+H9KQEI8p/QLphBxdPWomMFCayLRugLJdyz8DdszaGkWQ/V7qBLSm0THBFBSfidCd4cl/BusTrOfDyQlEci7G66evIwynpNRbjC21KAO3ecbYC7ld/OyxtfKkraFP3R6NXnxSk3QkMnVPdrlpU8bsSvVL7jGOxeVywIERYyCd+jsLo/0dpskfrKCfDtNKRXrq28Nv3Rpj1T/sYn7DxZPYjwzIl5B4BX0nB1GO8kkH0zmorKsHKuD9BvwFoTSCkhEyTi8aA9tH/SX2peO/3N7QL5ERiQ/aWIUY6TWEuf0yWAQCxtn5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRKHWz+4EgLa2BpsWdbADdcaRblKY9Q+KTiVeteSbi4=;
 b=P8mkJCp4Eh2jrRLRV7/oSbl5A1hSD0ksfr/MZMegOzqAFCHcPqx6bcwzraTKyMLoYSMjoYKk5HZbkdb9ZEZ1F1TN2ogDSlzxcEnr7xczFjFAIXk25t0wFY+tj/paJRx/bokLe2QGnZuA9J7kKzGhZwYT1oPRB53DXERf8j0ZIkJdmf4QK7mLbdxBXly7VRBQcf44rDRXisG3BLCCrulD/Lo9ZyqMW7aGEGUhkkQVbrkg9i/yO77I3Ei3LohpshIi0UpHQHjkugMJb+uCWTrvV7XnnviiJ7EY7E+opkU+FUUCpXVO6uj23NXoupF0TY0E7DqdpIXJhHujlJ8tm9wb5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRKHWz+4EgLa2BpsWdbADdcaRblKY9Q+KTiVeteSbi4=;
 b=ec3xI/IO7d/BKVe1dVZ92c5tbuJ0ZpMJSgP90GikipBK5eVGHV8M5hLLfvOdXlRO1ZaJDxlbrgmYs3sKbaE1SsWPli1sK6w55qC7FBwgcAByPDM+r98xsWAPmqlni5rD8zuT/M0WR02NUlXzsKm13A77gFb5Lj/J2kNy7xUYthcHhmsTexH1+HP9y/4cXtqh23tNdpSmKIvNByAkgheOzW15wQh6WuqNDkRx+QPRaqUUPn4x2vsfbr7cklvwpgUTstG0HjE9p9ALsEgTT7uEQb0E/QowTHc01BaXubKk/qro31Rka1XObd8Q0ZpgBUvjSIh1hiJCUfNJM2n8C5DPXQ==
Received: from PH8PR22CA0004.namprd22.prod.outlook.com (2603:10b6:510:2d1::19)
 by CY5PR12MB6370.namprd12.prod.outlook.com (2603:10b6:930:20::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sun, 22 Mar
 2026 10:25:24 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::89) by PH8PR22CA0004.outlook.office365.com
 (2603:10b6:510:2d1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Sun,
 22 Mar 2026 10:25:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Sun, 22 Mar 2026 10:25:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Mar
 2026 03:25:11 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Mar
 2026 03:25:11 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 22 Mar 2026 03:25:09 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, Shani Peretz <shperetz@nvidia.com>,
 <stable@dpdk.org>, Wathsala Vithanage <wathsala.vithanage@arm.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>
Subject: [PATCH 2/2] config/arm: revert forced crypto extension for
 Cortex-A78AE
Date: Sun, 22 Mar 2026 12:24:59 +0200
Message-ID: <20260322102459.141958-3-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260322102459.141958-1-shperetz@nvidia.com>
References: <20260322102459.141958-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|CY5PR12MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c9d8d29-5107-4799-9c03-08de87fd5377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: L/hhGuBQJewiNuQZ9a+9tl7qI81tAFeDqrxLEdxWO8bhyfBRrlQ6JU+WGqmgmiXCeKtQc6gCsEMPUk7R43oN/Z16Gx4sfdX5tCI0GkjQ5EiOnsoy1W6DliJVDSmF+1au3odVkvvO9mpE/jnqmWaNde9GUJjZU0SXwYNXvpn7K3Oersaz+Kf+q1TrnG916Pw2hUnm6FWgeMZZ8ao2N2FOPZwBdrOutzVY5Mh6D2cmFSuuM7R93ftMLvBpqCvLGlYeUNR148hsSFnhsorOsPk4V2ReOtHFespB3jUIcyxQVRH4CU+nr1gAK7GKZAad0IXX5FFxDjsp+HCb4qgoHhKkJCvTrwR7A5lLucIGfKyT2MphysgXOif3tFAuhDifqbGi7mBKrYmE6SNd7GhkFUEsazaVG03sKNESlZPFAEbh4kwJnR4/x4oxkiXg+hF4ewp8bF+jCFU6PwTm5oO2xaZEkvo9PbnAVLsLjMCwv0gV1iTkv7EfSAjjkSJNwg4nX1/Cty1AFtNm9vP5IjwUsGjYQa9Al3ThpjEu5e/CHmQZYagbZvCujJ2DmoiATOES3asvkEk8LTEgHXE3R89fb4I9iW3LZm/ae7xU+VDbYmR80RCTLRJefjKluEtxx5+Z4Szray7C1ZmcmU0/gIeCUx4OFzdToQurV2uP29+RXOkacIrg1TWNoD4TcP7yREJYyVuz1uMzpemHf6EqxGb+eU7S11RmUtANXVG0s+W/NsX5r/bBVGFcAOOjuYIMT84pWr/GgpYVN+RMLCs6UFKSyGj1Kw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V12PXWN6FHMljkTM9Yqo7LjZrMi/i5ibXTJA21Q13dM4tlZgL5uW06hteju1+NR4ISfSg0ZUkN9zghB0TWtj4cAcDJbCo1y+ezaaRtCdrP3S58HvcAsk4zH4jytrsK+lhmXEohGimKSqk6IiuaXNMwoA39nIwyB4s5XCAoiXeLKmG7M9jldqcE0R3cfKmePpa2bTwh6jitzt+rqS86PkP1RrV0VsbtLzdGI8C2cMdCbZsKGkqTtAr/+Mi4Ff0s+X2F/3odeszBmhMWU5KEw+n9EhL0rqUybpZ7dW7Zo8yWZd0b0E4fMINJRihL4GszCB5whzQWTUPLYik5VQ7vkZmgf6ZSbRCmD6GcEOOFV1fpxfSiamd+9MNz59xrxzQqZtngTrCV0mX1ihlyaJDiLRsonor1vF2jY1trVNt4YruoW7W3krnNYzdzUDOoGzcWwG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2026 10:25:22.9191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9d8d29-5107-4799-9c03-08de87fd5377
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6370
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

Revert commit 6e6cc1dc3548
("config/arm: support crypto with Cortex-A78AE").

The change introduced an explicit crypto march extension as a workaround
for an infinite loop in crypto performance tests. The root cause was a
doorbell race due to compiler instruction reordering, now fixed by commit
0986acdceab5 ("common/mlx5: fix doorbell race from compiler reordering").
With the root cause addressed, the workaround is no longer needed.

Additionally, the explicit crypto march extension causes compilation
failures on setups where the toolchain or environment does not support
AES instructions.

Fixes: 6e6cc1dc3548 ("config/arm: support crypto with Cortex-A78AE")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 config/arm/meson.build | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/config/arm/meson.build b/config/arm/meson.build
index 523b0fc0ed..c2e5f1bce6 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -83,7 +83,8 @@ part_number_config_arm = {
         ]
     },
     '0xd42': {
-        'mcpu' : 'mcpu_cortex-a78ae',
+        'march': 'armv8.4-a',
+        'mcpu' : 'cortex-a78ae',
         'flags': [
             ['RTE_MAX_LCORE', 16],
             ['RTE_MAX_NUMA_NODES', 1]
@@ -704,10 +705,6 @@ mcpu_defs = {
         'march': 'armv8-a',
         'march_extensions': ['crc']
     },
-    'mcpu_cortex-a78ae': {
-        'march': 'armv8.4-a',
-        'march_extensions': ['crypto']
-    },
     'mcpu_ft2000plus': {
         'march': 'armv8-a',
         'march_extensions': ['crc']
-- 
2.34.1

