Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB30606A326
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Lwm8XsXS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08028402F1;
	Thu,  5 Nov 2026 08:17:37 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013024.outbound.protection.outlook.com
 [40.93.201.24])
 by mails.dpdk.org (Postfix) with ESMTPS id 7A04440288;
 Thu,  5 Nov 2026 08:17:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9nz6rkSdX5CVC6NvEdfv+3O/4E2yL5EOCKLYC3OIFgftE5biKIU0fiiyIIR1WKfa/zOY8wjuGJ1eu3thvnxMHBlJ2OxpfqSsCGYWDkpzdWaZVOSp60Viuys/xizxiftrzdIcaFodsaQEnpajZ+ubX2PcettTTgv3VrgPtvLnHPnlXhkhLYsJWZXZqkVeWR3RSQljvd8eDgq9F26UgX5+5Do3rdiLlpbDYf0ITakRfRwfxg/6HVgUAZBwgNNBrU9m/LS55hlT7DUhLpsUI6qaG5/IQRJiyXdzwTFyWOBLD9Z6LXR1GVXPY8FRxQbtHzO5zXHu17hd1VXj3iEsA4xmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jyd3lCYcypHLl8s6IHGsHtars8sWkruAEkuZxuu/UVw=;
 b=RSsRWi2ZUTsetk6RbGzt57h1Wo3UiKbqreIMzEF2Vcw6/PD2aa28mYEQLLZPQ1+f3MmbP3XVlVFY7eyP5yqIV3GkwxADtlRQIItZ6B1IWBRzfFLLSRvN5iIx4JIBneuRgsMBpGgH6US/l3ajvM22cUKk4kGUHu22Uth9vVO59nrt/0iiGBybkirYCQW1TksrGqu9/VynUC3rKxvaEwlCphM8dQO6cO+tiCccAr6bv47Ukhg9sbMaMiVA4MPEEHo07wDqFF9CeDgnZc3oGX1xHURNDpi5VZCbGHW9yKRRLwPAVqTEUAgO05ELagpgaP2x2j53rWl8OVyNYKVEbGPhpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jyd3lCYcypHLl8s6IHGsHtars8sWkruAEkuZxuu/UVw=;
 b=Lwm8XsXSGC2rzVZQdhazFsh2gl5TAF67OuHjhAyT/t21dtcQt5jiPFFD5+wJWr0lw3E2pU2BPmnCAPCRqkgX2vckpdytRLXU135HNNEmZ20VjWhBFbGp9MGycSCYKqreUbYudGIVQ1+jUGs9hhdFaxfr/+hz051TLl+01LWDuePU5ovEj/ONvX2QXcGhjbQgO18Wky8wlUrI7K5lJa1dV53RrFdN0duuGPJPjAfjM7CwsGrUtiYspPsOk7RKIhRY7IIQqJkKV4AlH2K577x/vaWNFvx6ObH2tz4rZjy3Dr/6q0aatwtguFyEvdXC122Th2HHPrkhLkf9jIUtfQGWEQ==
Received: from BN1PR13CA0029.namprd13.prod.outlook.com (2603:10b6:408:e2::34)
 by EAYPR12MB923140.namprd12.prod.outlook.com (2603:10b6:303:2fd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 07:17:29 +0000
Received: from BN2PEPF0000A7FF.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::a1) by BN1PR13CA0029.outlook.office365.com
 (2603:10b6:408:e2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Thu, 5
 Nov 2026 07:17:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000A7FF.mail.protection.outlook.com (10.167.245.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 07:17:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:17:13 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:17:13 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server id 15.2.2562.56 via Frontend Transport;
 Wed, 4 Nov 2026 23:17:11 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <anatoly.burakov@intel.com>, <dmitry.kozliuk@gmail.com>, Maayan Kashani
 <mkashani@nvidia.com>, <stable@dpdk.org>, Thomas Monjalon
 <thomas@monjalon.net>
Subject: [PATCH] eal/linux: fix dirty flag for reused hugepages in legacy mem
Date: Thu, 5 Nov 2026 09:17:10 +0200
Message-ID: <20261105071710.3640765-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FF:EE_|EAYPR12MB923140:EE_
X-MS-Office365-Filtering-Correlation-Id: be7d1602-af7f-4be2-3500-08df3b0cda01
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261026140227099003|11063799006|56012099006|261022075727099003|261021121427099003|261021123027099003|261009223027099003|261022105027099003|261102123227099003|261028144727099003|261026121527099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: SyIS07DjNeOaxz9qcNh1OnN8fIIfMPXITKCoOdZSD68vkDpcIQkyGABODjPQz+h1Z0ZxlEr4VO1qx8Ow/u4Ibn3mZhZSo0pa87iwDMS6fHv9u5dQYytrxRgZctzCNoa1OmyhUKcoJDKenByqEZ6uIzlcqMQA9Ca2nbPWtFDr/HOUoRB2jaxXsPiDbNSFnHLqdRJW4TFndBm0sqHEQwx85oBmtiAOgzjTrzuAFVRv8XqgBM2u2u+/7USZp9xO4cRSbpCoTFrur1fRsnygjFKKUsMoEyziff9hWn9x1WXnuQ5ZZ/ZJCEUzWT3yGTprLDnFrVnQbafxVKs9isRwARb2MNarqV1tj1LVLSnfWr9h/X3ginZ6T+guIkk32H8AZMgfX/BjY+nlrjcQR8PCGJi9fc+hAZsNkvKov37lKWUQ21yi3UCRhWgP2il2MCltDsHnJOO/Dq+wDuileIJvPV4u+ReCu5f2DEb4sTGROz4qANj61vGw99qUaERU37EOtQ/0E1WjiGw0cw39H5jGKp5AbG17wKvJy9+O1n2gdwe5Z2w8yAnX7vgG5sJcmwmKBE1MfpL8HGYCaNub81JQnHWuNdzJpU0WLUDJjqw2vgBYzMAw8IpqROWll6Wv7rxpvLgawbh2NJMWvC4hzAR08IP+x9GTrjrTlRtfaVf5sCt14FBS+BaKN60qVLF6rimQ9s8KeHxmzo/JUDvbXVcnt6oMNw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261026140227099003)(11063799006)(56012099006)(261022075727099003)(261021121427099003)(261021123027099003)(261009223027099003)(261022105027099003)(261102123227099003)(261028144727099003)(261026121527099003)(18002099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ci1JIrwo4DEuori3nGy7bmdFLr85LbctJZMFWKPqxtulu6rvvd+D+ZyCs1L4J5yAMOLXtwoLAmSh+U5sUNI0uY7Iqt7XYuxrX0lTdQLWPUjlL+vgmET8Sbea4xvjMYMVduz2FkRdHWvSilHPtQs1f0Te5/5JtFfpl4hfDzHe7ID3fX+lon6Rq5R9g71UtSeBp3afboSX9ugljRZDdz0scmE/qDHrKcfOrFpiIv2gPOXDCtZqN7+97RbgAYHVHHtRpBlqXYZirycsUWzon0HhQVmsjOo9QyZkH5di2GSH55JMKVlz75rl4O4zzjqt4lZwwJSgrdRYPAQaDnXaqYyOEgGQCxiYpYqtrS+fDqF49//xu770b/0QwJCvr6SeyaZTByOrFfDIxLlYEGG9PxCR8hQ0uHrEBHRp2tC6MvDUt7+zHhep0NSxcGjzB3c+21OZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 07:17:29.1231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be7d1602-af7f-4be2-3500-08df3b0cda01
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB923140
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

With --huge-unlink=never the hugepage files are kept and mapped again
on the next run. The kernel only zeroes a hugepage the first time it is
mapped from a given file, so these pages still hold the previous run's
content.

The dynamic memory path records this by setting RTE_MEMSEG_FLAG_DIRTY
in alloc_seg(). The legacy path in remap_segment() never sets ms->flags,
so rte_zmalloc_socket() skips the memset and returns stale data.

With --legacy-mem --huge-unlink=never, a second process gets non-zeroed
memory from rte_zmalloc(). mlx5 with sys_mem_en disabled allocates its
internal structures through rte_zmalloc_socket() and then reads stale
pointers from them, which crashes in mlx5_ipool_malloc_cache() during
probe:

  SEGV on unknown address 0x000000000308
    #0 _mlx5_ipool_malloc_cache drivers/net/mlx5/mlx5_utils.c:550
    ...
    #16 mlx5_alloc_shared_dr drivers/net/mlx5/linux/mlx5_os.c:628

Set RTE_MEMSEG_FLAG_DIRTY on segments remapped in legacy mode whenever
existing hugepage files are reused, matching the dynamic path. Why a
reused page is dirty is documented on unlink_existing.

Fixes: 32b4771cd8ef ("eal/linux: allow hugepage file reuse")
Cc: stable@dpdk.org

Suggested-by: Thomas Monjalon <thomas@monjalon.net>
Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 lib/eal/common/eal_internal_cfg.h | 8 +++++++-
 lib/eal/linux/eal_memory.c        | 5 +++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 07cd35167dd..1221e03253f 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -44,7 +44,13 @@ struct simd_bitwidth {
 struct hugepage_file_discipline {
 	/** Unlink files before mapping them to leave no trace in hugetlbfs. */
 	bool unlink_before_mapping;
-	/** Unlink existing files at startup, re-create them before mapping. */
+	/**
+	 * Unlink existing files at startup and re-create them before mapping.
+	 * If false, the files are kept and mapped again. The kernel zeroes a
+	 * hugepage only the first time it is mapped from a given file, so
+	 * reused pages still hold the previous content and must be treated
+	 * as dirty.
+	 */
 	bool unlink_existing;
 };
 
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index 614f31a308e..0edf66eea5e 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -692,10 +692,10 @@ remap_segment(struct hugepage_file *hugepages, int seg_start, int seg_end)
 	uint64_t page_sz;
 	size_t memseg_len;
 	int socket_id;
-#ifndef RTE_ARCH_64
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
-#endif
+	const bool dirty = !internal_conf->hugepage_file.unlink_existing;
+
 	page_sz = hugepages[seg_start].size;
 	socket_id = hugepages[seg_start].socket_id;
 	seg_len = seg_end - seg_start;
@@ -816,6 +816,7 @@ remap_segment(struct hugepage_file *hugepages, int seg_start, int seg_end)
 		ms->socket_id = hfile->socket_id;
 		ms->nchannel = rte_memory_get_nchannel();
 		ms->nrank = rte_memory_get_nrank();
+		ms->flags = dirty ? RTE_MEMSEG_FLAG_DIRTY : 0;
 
 		rte_fbarray_set_used(arr, ms_idx);
 
-- 
2.25.1

