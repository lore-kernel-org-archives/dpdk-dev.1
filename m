Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF71A606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oMxIk2U1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A775E40264;
	Thu, 22 Oct 2026 11:48:17 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
 by mails.dpdk.org (Postfix) with ESMTP id 228604003C;
 Thu, 22 Oct 2026 11:48:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRmjlqpgX7PfLp/CzEpoYCGKs5n4HCHWixgCY3yc9qUD43b/hFUVpX7OuQfSDBNdf51eMppF4x/xR+QTgxbKNNzVUK9FlGVVTxQzqXMrFLpSmr7vgV4vf0hQwG5z/HbmCoh3gLZw6DotSdWxhCT7C0nTJyonrnPzmKIgVCCEdjygspTflhClcXv++f77kD2T8W/4tnyMgH1aic0lQrk2t6TxVz1nRKbYe5GzYN6mWrhmB+dgQHihwqkSF/y79k8ZjfxUzgnRqWaR5kMthcJYCkA9jgZVG5VzXy33oLsBVnh6+mLCl2IzJcaX80TxBiAcZYY5I4aOiQIVBVxilyCHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHPswp6HhajCrl2c3vUqlPN8bnyJChijV4g3/eTrD4M=;
 b=Jj1raVPmReW/EgKSWSV/PgPpKtxb3g5W3+Tbup/DHFS4MSUl8Ec3wd4rWYH3+39pKON4hIs54a06LQnFzZq4TBuZsZxgXtIGPmcABpp9mMstLpdVw4+euxqJoRr9S7C8JK+MSWxn6/9FpfLILcwfUWhu+IJFgmLdRPjsyAKdSP4tYWcapgRCYkATPJtX6W/ytL7xj+ke3EY0Q0Yi4e39efxFNJ23G2UeZvmYJZRk9ru3gXSD935b5IbE9+WiuJ8qPaXfFOvXslCl4S8Jsaqkbt6qnw8moTSyXuPPTy41PC/lYYfdKbzCGzI9lEGM5xP7C/t2ZM3y16d3ed0R0rws8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHPswp6HhajCrl2c3vUqlPN8bnyJChijV4g3/eTrD4M=;
 b=oMxIk2U1il6i3hV/H4a+9a2r4hWN2fXyrMBg1IRPfZIEfxYful5h2yd2L/TA3AE8MggoIT4Bxv8haxHfYJLEiB5nREAYY//HqQ+BXd2pXlBt3lKjLNDsR8otVXc+ucSSQd2yjDRrhBjL1+1RntW7EVsVZhPR+5jSCbSJhV963WxiETmhvw9qDBbMR3OETHSNJXPbLCOg9rQ4yROttonRzUkibDKaeWJeeidbNSsdWvA3BXkcqW10mD7PrGYP520pIRFgv0Vvwq7HuUpBIdGKjETjz2YqY4T3Hxz+iRoWoRest5VSeZXHBZEdNgCIZLIvgsJHvaKNYRqJULJfTKZk1Q==
Received: from CH2PR18CA0031.namprd18.prod.outlook.com (2603:10b6:610:55::11)
 by PH7PR12MB8779.namprd12.prod.outlook.com (2603:10b6:510:26b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 09:48:09 +0000
Received: from CH01EPF000BE949.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::a0) by CH2PR18CA0031.outlook.office365.com
 (2603:10b6:610:55::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Thu,
 22 Oct 2026 09:48:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE949.mail.protection.outlook.com (10.167.244.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 09:48:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 22 Oct
 2026 02:47:49 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 22 Oct
 2026 02:47:47 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Thu, 22 Oct 2026 02:47:45 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, Bing Zhao
 <bingz@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v2] common/mlx5: fix mkey ordering enum
Date: Thu, 22 Oct 2026 12:47:40 +0300
Message-ID: <20261022094741.76346-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20261022073013.72607-1-mkashani@nvidia.com>
References: <20261022073013.72607-1-mkashani@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE949:EE_|PH7PR12MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: 947af0ca-9797-4331-a863-08df3021949c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|10067099003|22082099003|18002099003|261021121427099003|261021123027099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: x3X5P7FPupIZw+94Kun8ti0QVZwi+enedMFPqWGdKMC24t45RShyaGOSrHGrInClgxIsRZVIbX9iyILot/5nWnxKimK1o+6DyMd92YZFV9XBfeHCTrVbNmWOwvaChQo8X3gaabSXdIBhRegJI8EwqiAuYG0OV6F4E9Ddf8chqRNghUY1NGJ+LJV8F1+RN5FSsS9dHWMCW6NjIFopF+Ybk0UMcB4p3bmz8/ksqlUO24eNrTH20yHFU/MtnslkVXfqiMZ/ssWRdvzQHXeKR3g8ZVhavscolc/bJvvf7pFUv0fLWQwN9JYGYd1SKgNKBYbnmUe0NuaPrJaDNZyqpVo2Il/9yf2fLOZ7qySPfCrvRT0vId7ThACAuzKPO2XyAA3DasgkPn9guIX+coRwKkRZGlZMuUlPgwSJ4eKIkpuVafaICVR9YnC83qMJoRDwPUzSd/zU7ok8WxiJi+D1mbV3XW/IMRbvSzrhU3CJv8ylgNyfjEq+CIVwV5c1S8hdZS4ITdIEcBcaKljppwyYgniUpMWsiEtC9yeJbXyD2WK8lOhauYLeLK/Fl5iVDM1vmfGSOro9DrAJomcmba/Sj05mT3FRzAIbqJ3hnuTijFNsx9nb68bvf86XBGzDvzTzLz1JewHlTMB62H3q5qV1ajaHAC0B9i5pdLfjM8Kmk4GGgJ0+f0vRhA5BGzQgf2JsN2LzQBDD+IfuQG8RZ6WIhKSJIg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(261021121427099003)(261021123027099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1mXO93mEr0c5lGTSTgMEdXSP3Zcqxpr056U8WMeTQNexxnFxHh2Dcgoy+QlaxnxhHxelOqUjR6FImnBiUTrU+5RLipfZT1hZP6jfBKZW7/m4gjRGGuenpWVTUYvC3/asPUvOpFqcTnTe358Lx1QEoxG2N/eGgtIK9CwkV/aJeV/sSILsqjAt0FvGaslLSxiVahdmgef1wlnATUyms2CA2uHUt65g/c3kIPVWF/KT63q9YTYOesK2S2MOYPCorvMvGVbRGjnL4T/DoNd7freXoKeNqxqyqnqFZw5dpLxELVRKY8aToLsZ/Ako54BxDSTDLAbdUDLsxDHdTcXlkRCF7XqmZ/M7g7pZR/6bb/Y68rsVrdzi3ZG5bjVAdejb2Amlpeen92577bfhC2X5qy1KmA2LQ4e5nDqUGdGAEUnWRnZjtxcvj/3fVUfhacc6SGtt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 09:48:09.3653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 947af0ca-9797-4331-a863-08df3021949c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE949.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8779
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The updated device specification defines relaxed ordering as 0x1 and
reserves 0x2. Update the mkey read-after-write ordering values
accordingly.

Fixes: 5003eaab7e49 ("common/mlx5: update relaxed ordering policy for mkeys")

Cc: stable@dpdk.org
Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/common/mlx5/mlx5_prm.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_prm.h b/drivers/common/mlx5/mlx5_prm.h
index c2810194f8e..7ae5ece6c32 100644
--- a/drivers/common/mlx5/mlx5_prm.h
+++ b/drivers/common/mlx5/mlx5_prm.h
@@ -1483,8 +1483,7 @@ enum {
 /* MKC read_after_write_ordering field (2-bit, dword 0x38 bits 9:8). */
 enum mlx5_mkc_raw_ordering {
 	MLX5_MKC_RAW_ORDERING_SO = 0x0,
-	MLX5_MKC_RAW_ORDERING_SAO = 0x1,
-	MLX5_MKC_RAW_ORDERING_RO = 0x2,
+	MLX5_MKC_RAW_ORDERING_RO = 0x1,
 };
 
 struct mlx5_ifc_create_mkey_out_bits {
-- 
2.21.0

