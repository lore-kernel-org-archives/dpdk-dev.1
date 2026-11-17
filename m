Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D574B606A32C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tewLQyTl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95C4A402C9;
	Tue, 17 Nov 2026 20:36:48 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
 by mails.dpdk.org (Postfix) with ESMTPS id 67DC4402A4;
 Tue, 17 Nov 2026 20:36:47 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFkaOouqyiQk0g3FewHD/lPQJvdTy5W3tkOO0CAd1xsdzGR/r65praUPXA9dGBHtaAeoTIgLIS6Vz+gejYw4kIptpGICpa2IYS8TwTq8LkrMjvIOXzLfMEYWjxqA0jCLr/wgD0rzCqlsBY6kQx7fFoGlaT98y8MJOxLhPAM5nmIpZXDC90jDHLjwz0+Wmo3MTHwHE6lvuDau5+VGa7cB8P1SMOYs1HH2Cxklq591GfcZlYjLB1QcC3uDhGEULxT3O4KEvsu37fkH6gz7PhwuG49jo8EWIkVUa6A000FOneJIvYREm6S6j5S4p+kvKsUdIjXCiFRlnWuMulBgvy+iFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kMFOXe5enqe1OsEVJHX9Ow6matfyyydHaLiJqUAB+0=;
 b=m7+1TSf5cdaRBMS7KXgS+lPaCTOAMuUYGOybL6kHXLoqfdIoITjSsmTvU6K/eoMBwcwqDyxb0DTcAfFBUpLWv7DIGgOcWghOzj545WwHJLu0AEuNevk8J3u4AhPotgmrQWZc6UDILH/e+723mlK+JuAws4vPzsGV3qgw/4EM5NDhSTrKIfTdjHYvVZKzYDInoO9neYxdeVh6/zqGKRjKse4w0Njiuy1TfMAf79LbsHXxGf//wdaD65L3cwB/oVdvAwmL0hcv9guoIGzYtNdbZarJg2sHdvnKGagBn7C7bnxbihgInHqGXcFY8VsH5H6UbPUU24j9AVJZgnJYFc2lVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kMFOXe5enqe1OsEVJHX9Ow6matfyyydHaLiJqUAB+0=;
 b=tewLQyTlTKFW7vdIhaI6fz+7xz4MSuQixwS/8y690+JXNWz9YDDjdQJZM0nyWS4hMsW0wtyxiRkr0XVwDcGi9eaUI8ZDTrBYGYz8yKRDNiksWo4/+ahV35c7W6RIfwDq6I9Nk7wjwFpNT2305Ecg5Vfwj7EfBmdAfvzoFcoA6R53q27+DRJxO5lIzjmsRXsDQ/MptZ34HQgi2XiIhXTULyfYlHrqqeF/0l5jd/JCEUX+WOqoAv+gdyqLWU82/4LXiTaUWye9sqaI9l2C9cs2z1Z5LpjpJ1M7bopDrcobNMOoSlo4aYd5VWfOMu43WGnIaAITOmwItVDLCoGwoMYpoA==
Received: from BL1PR13CA0061.namprd13.prod.outlook.com (2603:10b6:208:2b8::6)
 by CH3PR12MB9170.namprd12.prod.outlook.com (2603:10b6:610:199::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:36:42 +0000
Received: from BN1PEPF00018070.namprd04.prod.outlook.com
 (2603:10b6:208:2b8:cafe::24) by BL1PR13CA0061.outlook.office365.com
 (2603:10b6:208:2b8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Tue, 17
 Nov 2026 19:36:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00018070.mail.protection.outlook.com (10.167.245.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 19:36:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:36:10 -0800
Received: from mec01vdimballas01.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 11:36:08 -0800
From: Mujahed Mohammed <mballas@nvidia.com>
To: <dev@dpdk.org>
CC: Mujahed Mohammed <mballas@nvidia.com>, <stable@dpdk.org>, Thomas Monjalon
 <thomas@monjalon.net>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>, Olivier Matz
 <olivier.matz@6wind.com>
Subject: [PATCH v3] mempool: avoid memzone name collision
Date: Tue, 17 Nov 2026 21:34:28 +0200
Message-ID: <20261117193531.706953-1-mballas@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <LV3PR12MB914444BAE4DA3B85B4179A4AD47D2@LV3PR12MB9144.namprd12.prod.outlook.com>
References: <LV3PR12MB914444BAE4DA3B85B4179A4AD47D2@LV3PR12MB9144.namprd12.prod.outlook.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018070:EE_|CH3PR12MB9170:EE_
X-MS-Office365-Filtering-Correlation-Id: 43845643-1976-4965-1d91-08df44e21a4b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|18002099003|22082099003|261009223027099003|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: xSrfU3OrGdhg4GBNgKwfodGf/m6cMaxmEg0fz9YxUEu9P/k8RB17KlS6E/nJ06zFM4fn6N6KrFQztYvvzbJbIgu7+2Fysrbu1rbuaNoPsjew5HSqkckkihPsz0xXLzRnp8ATggCvgip4qTAzYFVl4F05saDeYb8diePdkx2QiajyKVm62FoH1any7EbdJNL7w9SzvSHBVWfN6lxYCpgKiYdRPEXCjIpClV68Wk1svYnJIy6l4RUmxHt1hs3xW4VnkAOI+GJ14KvrLk+18LTahMbZAqvay27NXTb8fy6sD8RaFJEr519gMObpjbpnkjY4DFvfsqkTBZTQV0pv7n7GRQZnJBBN0SpcPsTXFLqcGzbYfgKyMXL0GwdY5wkadIueDqg6BlLvP6KAofHOvKVPKtKgm8evYlVfNJE0P0mZ6nKPCJN0ayO5NoS3rEOZmVsoPWhbxz+vbuZZ35WUVIaBVc2RNWgpe05d0dfWCEYL84Yvlf3+DYH2BWg1TtBKEfEk+JIrtACTP2GPDnwlyOkUrUAC6yu0SZBPskMnauVno2qVUG/FmM0XEKDjH2PqlK6sTf7oz0zxWDR0ZMdPpeodMozfRYTrL1b/gCeLoOsLm4BkPN5m5SObq3a+6RlLe69u93c2PkLqKzZzvzRwtk/GkRmJ6q3LTRX416u5xEVrJ34VY/YIkgOxdCX4l0cNdo4LY4EbYeweGDOG/WIJpnlHbQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LNLLzAoLlV4eUgR0J/SOXSx3ptyG/v3RuFasOkXVaq73FbjC+H9N86Z8o0EMkXZMQdIpp13CS/bOvpxl/dyZEEiBSzw0i/lUCnVSsexXunC56NgFIUQYPl//QOtPUk/U7ZqPbgPiUs+jTJN34/h8MdJVqISmWNL6yD49pThhLuJ/H8EzG3UXiS0aH/RXq/gc7CwKFVYFEZ/91ar8lWgFGnj5zakmf1uDnszwi7VuU2tbpUPwYO58NjuDlF+ryOB36wPRNfAnsdfg/j4QlMqQSlsYYP/BZAEPFTO0mvuCcr2uzRWcwYLDzdpcfSWmRcNSb3FOT2qq9ooCrj+/sPdwyxgT9O1Yn+bFZtrxVWressHf1uADkkgTLZ1kYT/wL+EjodXVlLUdSa3t8mvJNGx3vD2laWXWUzkSXhKTytmgYu/uw61i6MzszmsLfH1URMpC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:36:40.2569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43845643-1976-4965-1d91-08df44e21a4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018070.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9170
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

Mempool metadata uses MP_<name>, while default-populated backing chunks
use MP_<name>_<id>. If a pool named "foo" spans more than one chunk,
chunk 1 is named MP_foo_1. Creating a pool named "foo_1" then fails to
reserve its MP_foo_1 metadata memzone with EEXIST.

This can be reproduced on a two-NUMA-node system using 2 MiB hugepages
with the following memory setup:

    HugePages_Total: 2048
    HugePages_Free:  2048
    Hugepagesize:    2048 kB

Run testpmd in legacy-memory mode so the first pool spans chunks:

    dpdk-testpmd -n 4 \
        -a 0000:08:00.0 -a 0000:08:00.1 \
        --legacy-mem --socket-mem=0,2048 -- \
        -i --nb-cores=3 --rxq=8 --txq=8 \
        --rxd=2048 --txd=2048 --socket-num=1 --no-numa \
        --mbuf-size=2972,612,512 \
        --rxpkts=2844,612,512 \
        --total-num-mbufs=196608 --enable-scatter

The first pool's chunk 1 and the second pool's metadata both request
MP_mb_pool_1_1.

Use MC_<name>_<id> for chunk memzones, keeping MP_<name> for mempool
metadata. Chunk memzones are not looked up by name, and the new prefix
keeps the existing name-length budget.

Fixes: d1d914ebbc25 ("mempool: allocate in several memory chunks by default")
Cc: stable@dpdk.org

Signed-off-by: Mujahed Mohammed <mballas@nvidia.com>
---
v3:
- Move the fix from testpmd to the mempool library.
- Use the MC_ prefix for backing chunk memzones.
- Add the reproducer and hugepage setup to the commit message.
 .mailmap                  | 1 +
 lib/mempool/rte_mempool.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index a4af517007..fc7750a006 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1183,6 +1183,7 @@ Morten Brørup <mb@smartsharesystems.com>
 Moti Haimovsky <motih@mellanox.com>
 Muhammad Ahmad <muhammad.ahmad@emumba.com>
 Muhammad Bilal <m.bilal@emumba.com>
+Mujahed Mohammed <mballas@nvidia.com>
 Mukesh Dua <mukesh.dua81@gmail.com>
 Mukul Katiyar <mukul@versa-networks.com>
 Murphy Yang <murphyx.yang@intel.com>
diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 069aabaa70..8f3c88aeb4 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -565,7 +565,7 @@ rte_mempool_populate_default(struct rte_mempool *mp)
 		}
 
 		ret = snprintf(mz_name, sizeof(mz_name),
-			RTE_MEMPOOL_MZ_FORMAT "_%d", mp->name, mz_id);
+			"MC_%s_%u", mp->name, mz_id);
 		if (ret < 0 || ret >= (int)sizeof(mz_name)) {
 			ret = -ENAMETOOLONG;
 			goto fail;
-- 
2.43.0

