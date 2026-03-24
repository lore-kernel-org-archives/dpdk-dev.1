Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CF6F54AC5
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 14:26:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7D89402BE;
	Tue, 24 Mar 2026 15:26:17 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
 by mails.dpdk.org (Postfix) with ESMTP id 60D6C4025F;
 Tue, 24 Mar 2026 15:26:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iD61C1pOoaEA8fuC2eTF+VilpNp8pxH2jHuztjjvI9hlvTuU/Nz0ENUw71WcNEeGXorZ/jtzNd87DZ7vtqdCd99qXeQHw7dldPDywNX6D5UxQG9VddNjmU2cbfpRA9Q72UkMaw2GVGRarTOcLJeY4WzS0rHuJvxVBIWV4lR4yH1x8HHISMX6qsbXxJ1yRxDLqzioZkxRV3wWIlaMzeuOaJ8Rsxukp03VsMpWdUSyD6mWOCQL009cENleFc6MwB3y3cLoRI8ab1WdUf1jeg+C1mUqAY+Nq/I1waDabEDpvYjm1QUpeSW+nvEH4kddwdu7hPEtV7NRle21jvikWFE8fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fABVDP3mD+bAEofeFEEjT1wA2Vsu5KcFrlS19FHGTqg=;
 b=a6Rz8Di+bmQSYz1HJ5hikQFagjrXvfdXjkAzAud3sJY8xBLsUErjK0cnqtXEyRCPpsocgGN2x7tLwnkUR/xrbPFICt5xPrK4VdAoz16ETtC2MAqi5YpPO9c0bqrELJ4RzOT7h64D5XLx/dL4M4Wo5oRc7VPGgsBZPUEEkRNB/LohbsUw3C2sXqBEHDOpcokfyZk6Jz4m9jIkwb/TTq5ntk79y+uDJqqwiLvZ1Y8fak8Vc+Yw/ckaBd+K0N3TUBlXCo7e4QALQBcT6Den2+myG5io0ZvnhyMLSFouCF+FeOCNw3Piy10JQX0HwzCJIcAE27lcuxhWvpbnAeJhmKefNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fABVDP3mD+bAEofeFEEjT1wA2Vsu5KcFrlS19FHGTqg=;
 b=nCpTyTqtP0Ui0JNK317ERzcN5+c84t1y6/wC6ZaNCBf/FIYXO1qk3w4OHZ7SnfjbqfYhS7stNN3MI0t/1luyztxvAtg6J+nyGTiGjpLrXuwio+VcO3OPi8jks+6Jf3Dq1HG9uo5pdbMhMC4stbkCex8ZamTsCMWvROyTiXoC1KuaVbK3ZqY8pR1u/B3WB0GeqPnsSA3HcO45CZcVNsYPKfcL9fzpujOf2qP5XFuuAtvBXZjY/7SRQBQEsr0OYCKuO4Vew8gPDDxj4OpywZ+MujYYV8XRllprc7+fjdRxT9rhMFbnQk8fyVLR23nWRYHfCVgz9I3q5S6NICAmsef3Tg==
Received: from SJ0PR13CA0045.namprd13.prod.outlook.com (2603:10b6:a03:2c2::20)
 by CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Tue, 24 Mar
 2026 14:26:13 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::8c) by SJ0PR13CA0045.outlook.office365.com
 (2603:10b6:a03:2c2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 14:26:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 14:26:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 07:25:51 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 07:25:51 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Mar 2026 07:25:49 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <thomas@monjalon.net>, Shani Peretz <shperetz@nvidia.com>,
 <stable@dpdk.org>, Wathsala Vithanage <wathsala.vithanage@arm.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>
Subject: [PATCH] config/arm: drop crypto extension from armv8.4-a build
Date: Tue, 24 Mar 2026 16:25:45 +0200
Message-ID: <20260324142546.321236-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|CH2PR12MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: 385c126a-b024-4ee8-7645-08de89b14d11
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: J2zgh5VJV/pD986Wb+9HgyAX/vZAkvP6ll0wEoumQsTsDelnhHIVqW/iqHI/7iL+bY+5rS9UCTsxtTMtvkrv05NcQ9gh/duajp3UF2/rNsfQ7bBD93vi5n5+vuNyUdMUQaEuJveIeUrvGgwkJmlgTfBUETt7OOxtPK/fY8ecNEwyak2hoL21Yg0WikQ4XbctrkqVQvTiXsScra83WVHb/dgvr984UWovh8TQP2kgQJ+25JbNqHF5zQ+mDEtkt/hFLvW9pEdbXjkvgZieLEltJ65ix/9XDkiyDsMoy63co0OZYLKNOikZ98MfCP/RrDE+z1No7uoDE5aVlIMFB/4dXVjUakRdsAIWb4siBA+SN05NhubDi7qqgjZ19yQ6cwurHT3vxWj82PXhsc6jzQqJ81mYonE7y8ygG4f7RQQPgerW/GjjqcInHq/OEQLe3yYWPFCex/XdmKjqDe+B7rHOy++Gz/j0wfsLcJ1pCPAdN/hF2bh8swPjonTsnD6T/LQkX4sSPgzL5eNoWG1PqU/bOUunOLT7dfQGb0zB9lJIqNoCVbr0yXp80lA4+vfKIBPuXRi3ly+2ugLzWYcCZipNTNRrC1dwYRMwGary6E4Qcp95EsShDDhkNBiyWkNc+iVCRnjMZGwlVT/nMPBOR7d+nej2VhpAiRFjD4dgRFNc8fOqzyx0UmSOV6JU+C5OSqIJJTkH8IYx9Hsh5w4FGyisLXQRE2f/Mfr3WHspmAryplMTwnGXG/AiO6YRlisMpM+jjVg2D0+72GjQm27lU+mzrw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +h0Hq0QSYPno91O761D+i+jAUybbD7IDIoRVDGA4suXQSOvZVjL2xZEr6PXw3+PSPOZ5anZRzsTbN7x9WDERt8ZGWC7qzLfVZ1G2mqEG2eIhE5OhPdve5DMXCCf2jP19O/LC6sGkSZlmHv8tlRVcTVUA+DNqt4bulRL7HDAmFuCYoLjn4hWG6iSmVQp7hlFqctnMa2IHreWi4GnKfzjeCaYwBOcllsTjrzRTcGtDRGaOz8/3QNF65+FKcXxphsxYSU42ruJGj6BLE8Jh+tRuWCE9PgX28++20n1alOiCgDdr/MXb+Q8eDFXixQSuEBTYWktIbwAVMjnhpyt92jGuLsPG9XRdq3Ecoes6rDaUkG8LbheIuXGZj5hzZxN7LYCh09C0nAsbqS4M7q/jko6VnVWFwZiK42EDtW39sh8Nypqr+5NC1Hlq8yOU0lwaDPMD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 14:26:12.8094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 385c126a-b024-4ee8-7645-08de89b14d11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9458
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

Remove the crypto march extension added by commit 6e6cc1dc3548
("config/arm: support crypto with Cortex-A78AE"). The extension
was added under the incorrect assumption that missing crypto ISA
caused an infinite loop, the actual cause was a GCC scheduling
issue with -mcpu=cortex-a78ae. This was avoided by switching to
-march=armv8.4-a in the same commit.

The extension is unnecessary and causes build failures on
toolchains without AES support. The -march=armv8.4-a build
without -mcpu is intentionally kept to avoid the scheduling issue.

Fixes: 6e6cc1dc3548 ("config/arm: support crypto with Cortex-A78AE")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 config/arm/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config/arm/meson.build b/config/arm/meson.build
index 523b0fc0ed..5a9c16b9b1 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -706,7 +706,6 @@ mcpu_defs = {
     },
     'mcpu_cortex-a78ae': {
         'march': 'armv8.4-a',
-        'march_extensions': ['crypto']
     },
     'mcpu_ft2000plus': {
         'march': 'armv8-a',
-- 
2.34.1

