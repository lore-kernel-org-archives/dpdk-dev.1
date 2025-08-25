Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F34CA0FE1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 11:26:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C51D4042C;
	Mon, 25 Aug 2025 13:26:35 +0200 (CEST)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id DD0334025A;
 Mon, 25 Aug 2025 13:26:33 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by mails.dpdk.org (Postfix) with ESMTP id B551C40151
 for <announce@dpdk.org>; Mon, 25 Aug 2025 13:26:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yU5CtAMSi6iKwEBV996xwd1iBmQh6qLlWlHfl+G1rkwQmN6+CkTq//K9A+XcMpKCoMYp/Zb4fNlfESs8QLhjVCQLm+DhJmswZVJojYkOr/MjSjdQAfdCPJAthz9PxnSswp+kxGKZSH90E2MBFf7gFG35SAIJQUOvUB5O+KvSJclNmz7lwi0+bYsxTC7dQlDO4Y2HdE+Zr31I8PNy5kA+ZBRQbnc9I5k9vUaaTsBQWpxyMWtt7k5bIsIXFrY7N+IsXASRUllnXUOYr90CWJZsfrhWI/zX9mC8xagaW0SMTtU6KMDYSDz3aRaBe2Z+aZIoZwMo6ih825Bv6hozC8dPlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufYK06OuQuXRKyRpXi4GEcegJQ6VXEvVnb/yR4Etfwk=;
 b=JwvbBLdntZEQII8XKrChBVYj0dfA6tDof3GjBB2GPs7YoR20DbjIslJWfgiDO/1G1LUF+tdSc81zfSfov9l2hvNvA/cQne0rFbMlRUjNA2SO0VvFz5xhiBo36EAe+Mz4/delA7bBzX0bU0dRL1VxSseu+cik0uJML7sApvdS8+aE5d6DPAam89Y9+n47NZf/UvVHSOHDP5ZkziPZYFCW66LPU+H++D/7UOf350gvzOUhGu5YzlFXKJoy5oMEYKrNMjTBynt1bX6TCIf5bsFv2cFJl+Ai78H2qkgb/CqZyZrMFRtPmZwI7p5kd/Yk1QrzK/T3YLi76OsLbqVNDnfdzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufYK06OuQuXRKyRpXi4GEcegJQ6VXEvVnb/yR4Etfwk=;
 b=rO5E3KkbT0aFCdQ+BMByXZcgUGsWPq5bAlafBAaaVKpRrj8yZCQ14wgOlN77R0bE8OcpibtyOuEBoLbnzVXReDWEgAFRcazYjiiSUQjuBM1LNyphjUYZyQ7pCNH+0sVwukDcDH2mnNk+bfSOuikiHxVfHHb5LjfCv0FEOwIZnOQjCB0DYYTi5zuO009rUNZwjUaBQ8Ve/bQBmxNt6XbKR1tHRY0+Qg0Cf9CGxPza2KwnHMNTesZ3fEtmFonZnKIKoqQTIzVsiWi1BAcTNBEA7MPFq5uVsSvUqnrPkRcG3uDXYH4EP1EbH9CHtyDkN4TGvG0fyA9MsGJvsZVinFYQlA==
Received: from MW4PR04CA0246.namprd04.prod.outlook.com (2603:10b6:303:88::11)
 by CH1PPF68E8581EB.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::611) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Mon, 25 Aug
 2025 11:26:27 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::f2) by MW4PR04CA0246.outlook.office365.com
 (2603:10b6:303:88::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 11:26:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 11:26:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 04:26:09 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 04:26:08 -0700
From: Xueming Li <xuemingl@nvidia.com>
To: <announce@dpdk.org>
Subject: DPDK 23.11.5 released
Date: Mon, 25 Aug 2025 19:24:48 +0800
Message-ID: <20250825112449.285062-1-xuemingl@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|CH1PPF68E8581EB:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d798f3a-a0ff-4f06-620a-08dde3ca3ac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXUxbVBJMUZZWU9VL1FKaUpmaE5DTGxKanh6L1R5ZGdXQlVtK3dSb3F2ak45?=
 =?utf-8?B?cUoyNlNuQmRhQUJqRVRWNTVBaVMxcnZCblJHVjEzQjd4MndCQUxNam40STJJ?=
 =?utf-8?B?c3dDSmJyTkhYZ3RZNGxXL0VZcDNNQS9yNkZOR2diZ21nR3JhakJoTk0yN2xx?=
 =?utf-8?B?SGJmbzdFRklWS3dWeFdmZ2FSaFZFemY1RHQ0WDBLZHhSWTBXZDdRK3E3bVVJ?=
 =?utf-8?B?TEhKZjF6SFBGNkhERHdjc3JWWUgxZk1lVjB2NE9YOG1NRUVZTml1cjVQR3VV?=
 =?utf-8?B?ellOMVo1Z0pnbk01QUEvVDkxOHlsMElRck1CaDJzOU9RdDJ0VHo2VVZYRWZH?=
 =?utf-8?B?SzR6b1BLeVVKWjg4YnphQ2FMVmVaSzFmTnFoeDFScFVRK215R1RZZ3ZZLzh2?=
 =?utf-8?B?UjhuVEFqTXFrM1NHZ0pQcHRwWm5RbVgxc1hQSXNCTk8rSXFxTzNBaEcyaEk1?=
 =?utf-8?B?dmxvSzJTV3RoNU5ERTlDTXdib2cxYS90YkFEWmFNbS9ieFRUTFN3YkdMMGNo?=
 =?utf-8?B?bkpSTjJDb3NMb2pQSlpYVXA5Zk9Ub2EzaXJXNkRIOEFDOFJRRlA1THdiMCsw?=
 =?utf-8?B?cjBvOGRVdDY5TVNiYjA2ajIxWU9LVkM4NkhYeWxaTWxWT0NDYkNvdHk5YmdQ?=
 =?utf-8?B?S1V2UlkvamE5MmR5dUtyMm8zSDVDOHdoeEJocVRpUnJUYU1wa3JYMEQzK245?=
 =?utf-8?B?NVZINjdJSFBXWVZQbWpBbGkxUURNeUFXTUZsOVIwZXJBRU4yejlHVXZkZnBB?=
 =?utf-8?B?VmUxcVcycTJtYmpZeUtRYktWR0hnaUJTY3dDVFhaRnV0UDB1cDhBS3hLVTJJ?=
 =?utf-8?B?OHVsMUtqSXhmRE1JU3Z2Sk9HQUZLZ1BrbjNGQUZqaVR1YW43bUY3MWh5Vnlz?=
 =?utf-8?B?ZUNxRFJNRUR6cUdGYnA4dlRaZ3RNOWVSblBVNlo1R1VXcVkzaW9KUnhEalk5?=
 =?utf-8?B?Y2tqazBFc2lGSldKRjg5RVBqMnJKS3ZCL1Y0NkwwK2puSURNVVJxWWZKbnUz?=
 =?utf-8?B?eUNNQzlrWXh3clYrL2VPWVZKdnU5MC93Zi8wY3RlQWEvYjdQeEVCWlhQY21Z?=
 =?utf-8?B?YktSaFcyc3lCWTZGYmhZa2ZDa25tNkt2OFl2Mm16SlV5TnNUZWc1WUdFL2Yv?=
 =?utf-8?B?TGZwUlJDdFJ4Q3VWMW92VjZDRkdZR1RDWmpvSzhGSlhBME5IM0ZNaUpjRWlG?=
 =?utf-8?B?K05VbWpqa0ZuaWF2YWNub2xQRytIakVtWW00MFZ0SkhRQ0NtOWtDQW81NkNu?=
 =?utf-8?B?d1ZGR3k1YWNzZmFsRE5WYml5STQyMVUrOVl2dHBmOGZqL044Njh4VGtOS3Ex?=
 =?utf-8?B?U1VLS1MzRmFCMnhRcm1qUHlXRzZJWS9telVreldoM0JVd05weE1LWnhVZ2ds?=
 =?utf-8?B?bFNFUDU1WWgybGZxVG85eXE4Z3FYSmNLWjJRWFFYYjgxd3VoYUlNS0xQT043?=
 =?utf-8?B?V0c2MEU3MjB5ZGpLQ3laQ3lDMUw2OXBDelJ1a3I4WTlVTmtMSlFnanRuRDVh?=
 =?utf-8?B?ek42VTlDUHVQSnhNd0FmQmVkcFRjSVlrK1VCdFk4QW5SRk5yQms2YXMzbS9h?=
 =?utf-8?B?WGdRZzNuWDU3c3oyeUpkaUMzUGZNTWJyYXhxOU0yeXlOMTlTYVpSSVU0QzBK?=
 =?utf-8?B?U2lvY2haZy9pUldXNjNvU3YraVVIVVVXek9BSjZ2ZU9zdzR1M2dReUs2L2RI?=
 =?utf-8?B?QUloQXprTXFuWlJvLzRqaWYwdWF1eVIxV2VsbkxKNzZISmxKdHd3d2llcXVH?=
 =?utf-8?B?akdUT0FqdWZ4LzFHb2pNS0YyN04zMkE5SkM3MjdoeHZxaWdjT1ZSN1hGR2JI?=
 =?utf-8?B?Q0p4ei94M3p2VXMwTGZOZFJaUUIvMjBJcHViOWpKck5GZStvQnlMR0RNMWZV?=
 =?utf-8?B?UkdQT1lzYnZIeWlDZktKd1QrNzlodGZkTlA3K05vZHA2eXh0TnFDcmQ2bTBN?=
 =?utf-8?B?d3A2NktnZ1dCdjJjdUJhc2FXdlFMTXZvNm1tTVVzZmk3TVBpMXhneDlXZmIz?=
 =?utf-8?B?Mks2c2RIdlQ3WEQxc1FUdGJiLzZnODlCK05JUm5KUmRaTXM4UG1lVGwweEk0?=
 =?utf-8?B?cW5zVUhyYVJjYm1TWHFrNHhNd2l6SlJzM29Mdz09?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 11:26:26.4181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d798f3a-a0ff-4f06-620a-08dde3ca3ac8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161]; 
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF68E8581EB
X-BeenThere: announce@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
X-BeenThere: dev@dpdk.org
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Hi all,

Here is a new stable release:
	https://fast.dpdk.org/rel/dpdk-23.11.5.tar.xz

The git tree is at:
	https://dpdk.org/browse/dpdk-stable/?h=23.11

Xueming Li <xuemingl@nvidia.com>

---
 .mailmap                                           |  12 +
 VERSION                                            |   2 +-
 app/test-crypto-perf/cperf_ops.c                   |   4 +-
 app/test-eventdev/test_perf_common.c               |   4 +-
 app/test-eventdev/test_pipeline_common.c           |   4 +-
 app/test-pmd/cmdline.c                             |   4 +-
 app/test-pmd/config.c                              |   3 +-
 app/test/test_cryptodev.c                          |   2 +
 app/test/test_cryptodev.h                          |   6 +-
 app/test/test_cryptodev_asym.c                     |  21 +-
 app/test/test_malloc.c                             |  77 ++-
 app/test/test_per_lcore.c                          |  17 +-
 buildtools/get-test-suites.py                      |  20 +-
 config/arm/meson.build                             |  25 +-
 doc/guides/freebsd_gsg/build_sample_apps.rst       |   4 -
 doc/guides/linux_gsg/build_sample_apps.rst         |   4 -
 doc/guides/nics/mlx5.rst                           |   2 +-
 doc/guides/rel_notes/release_23_11.rst             | 253 ++++++++++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst        |   2 +-
 drivers/bus/auxiliary/auxiliary_common.c           |   2 +
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c           |  10 +-
 drivers/bus/pci/bsd/pci.c                          |  17 +-
 drivers/bus/pci/pci_common.c                       |   1 +
 drivers/bus/vdev/vdev.c                            |   1 +
 drivers/bus/vmbus/bus_vmbus_driver.h               |   4 +
 drivers/bus/vmbus/linux/vmbus_uio.c                |   2 +-
 drivers/bus/vmbus/rte_vmbus_reg.h                  |   9 +-
 drivers/bus/vmbus/vmbus_bufring.c                  |   9 +-
 drivers/bus/vmbus/vmbus_common.c                   |   1 +
 drivers/bus/vmbus/vmbus_common_uio.c               |   2 +-
 drivers/common/cnxk/roc_cpt.c                      |   5 +
 drivers/common/cnxk/roc_nix.h                      |   2 +
 drivers/common/cnxk/roc_nix_inl.c                  |   6 +-
 drivers/common/cnxk/roc_nix_queue.c                |  11 +-
 drivers/common/cnxk/roc_npc.c                      |   5 +-
 drivers/common/cnxk/roc_npc_parse.c                |   2 +-
 drivers/common/dpaax/caamflib/desc/pdcp.h          |  22 +-
 drivers/common/mlx5/linux/mlx5_common_auxiliary.c  |  11 +-
 drivers/common/mlx5/mlx5_prm.h                     |   1 +
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c        |   1 +
 drivers/crypto/openssl/rte_openssl_pmd_ops.c       |   6 +-
 drivers/crypto/qat/dev/qat_crypto_pmd_gens.h       | 280 +++++++++++
 drivers/crypto/qat/dev/qat_sym_pmd_gen1.c          |  53 +-
 drivers/crypto/qat/qat_sym_session.c               |  10 +-
 drivers/crypto/virtio/virtio_cryptodev.c           |   7 +-
 drivers/crypto/virtio/virtio_rxtx.c                |  60 ++-
 drivers/event/dlb2/dlb2.c                          |  70 ++-
 drivers/event/dlb2/dlb2_priv.h                     |   3 +-
 drivers/event/dlb2/dlb2_selftest.c                 |   6 +-
 drivers/event/dlb2/pf/dlb2_pf.c                    |   4 +-
 drivers/event/dlb2/rte_pmd_dlb2.c                  |   4 +-
 drivers/event/dlb2/rte_pmd_dlb2.h                  |  29 +-
 drivers/net/af_xdp/rte_eth_af_xdp.c                |   4 +-
 drivers/net/bonding/rte_eth_bond_pmd.c             |  11 +-
 drivers/net/cnxk/cnxk_ethdev.c                     |   3 +-
 drivers/net/e1000/igb_ethdev.c                     |   4 +-
 drivers/net/e1000/igb_rxtx.c                       |   6 +-
 drivers/net/fm10k/base/fm10k_mbx.c                 |   2 +-
 drivers/net/fm10k/base/fm10k_osdep.h               |   2 +-
 drivers/net/fm10k/base/fm10k_pf.c                  |   8 +-
 drivers/net/fm10k/base/fm10k_type.h                |   6 +-
 drivers/net/fm10k/base/meson.build                 |  14 +-
 drivers/net/hns3/hns3_cmd.h                        |   8 +
 drivers/net/hns3/hns3_common.c                     |   4 +-
 drivers/net/hns3/hns3_ethdev.c                     |  47 +-
 drivers/net/hns3/hns3_ethdev.h                     |  23 +
 drivers/net/hns3/hns3_flow.c                       |  41 +-
 drivers/net/hns3/hns3_flow.h                       |   9 +-
 drivers/net/hns3/hns3_regs.c                       |   5 +-
 drivers/net/hns3/hns3_rxtx.c                       | 173 +++++--
 drivers/net/hns3/hns3_rxtx.h                       |   3 +
 drivers/net/hns3/hns3_rxtx_vec.c                   |  13 +-
 drivers/net/hns3/hns3_rxtx_vec_neon.h              |  19 -
 drivers/net/hns3/hns3_rxtx_vec_sve.c               |   3 +-
 drivers/net/i40e/base/i40e_common.c                |   5 -
 drivers/net/i40e/base/i40e_diag.c                  |   2 +-
 drivers/net/i40e/base/i40e_nvm.c                   |   1 +
 drivers/net/i40e/base/i40e_osdep.h                 |   4 +-
 drivers/net/i40e/base/i40e_type.h                  |  14 +-
 drivers/net/i40e/base/meson.build                  |  15 +-
 drivers/net/i40e/i40e_ethdev.c                     |   1 +
 drivers/net/i40e/i40e_rxtx.c                       |   2 +
 drivers/net/iavf/iavf_ethdev.c                     |  48 +-
 drivers/net/ice/base/ice_devids.h                  |   2 +-
 drivers/net/ice/base/ice_type.h                    |   2 +-
 drivers/net/ice/ice_dcf_ethdev.c                   |  38 +-
 drivers/net/ice/ice_fdir_filter.c                  |   5 +-
 drivers/net/igc/igc_ethdev.c                       |   2 +-
 drivers/net/ixgbe/base/ixgbe_common.c              |   4 +-
 drivers/net/ixgbe/base/ixgbe_osdep.h               |  21 +-
 drivers/net/ixgbe/base/ixgbe_type.h                |   2 +
 drivers/net/ixgbe/base/meson.build                 |  11 -
 drivers/net/ixgbe/ixgbe_ethdev.h                   |   2 +-
 drivers/net/ixgbe/ixgbe_flow.c                     |   2 +
 drivers/net/ixgbe/ixgbe_rxtx.c                     |   5 +-
 drivers/net/mana/mana.c                            |  14 +
 drivers/net/mana/mana.h                            |   4 +
 drivers/net/mlx5/hws/mlx5dr_send.c                 |   2 +-
 drivers/net/mlx5/linux/mlx5_os.c                   |   3 +-
 drivers/net/mlx5/linux/mlx5_verbs.c                |   8 +-
 drivers/net/mlx5/linux/mlx5_vlan_os.c              |  10 +-
 drivers/net/mlx5/mlx5.h                            |   1 +
 drivers/net/mlx5/mlx5_devx.c                       |  11 +-
 drivers/net/mlx5/mlx5_ethdev.c                     |  55 ++-
 drivers/net/mlx5/mlx5_flow.c                       |   2 +-
 drivers/net/mlx5/mlx5_flow_dv.c                    |   7 +
 drivers/net/mlx5/mlx5_flow_hw.c                    | 114 +----
 drivers/net/mlx5/mlx5_flow_meter.c                 | 540 ---------------------
 drivers/net/mlx5/mlx5_hws_cnt.c                    |  14 +-
 drivers/net/mlx5/mlx5_rx.c                         | 284 ++++++++++-
 drivers/net/mlx5/mlx5_rx.h                         |  28 +-
 drivers/net/mlx5/mlx5_rxq.c                        |  13 +-
 drivers/net/mlx5/mlx5_trigger.c                    |   6 +-
 drivers/net/mlx5/mlx5_txq.c                        |  13 +-
 drivers/net/mlx5/mlx5_vlan.c                       |   2 +-
 drivers/net/netvsc/hn_ethdev.c                     |  10 +-
 drivers/net/netvsc/hn_rndis.c                      |  14 +-
 drivers/net/netvsc/hn_rxtx.c                       |  16 +-
 drivers/net/netvsc/hn_var.h                        |   4 -
 drivers/net/nfp/flower/nfp_flower_ctrl.c           |   4 +-
 drivers/net/nfp/nfd3/nfp_nfd3.h                    |  14 +-
 drivers/net/nfp/nfd3/nfp_nfd3_dp.c                 |   8 +-
 drivers/net/nfp/nfdk/nfp_nfdk.h                    |  14 +-
 drivers/net/nfp/nfp_net_common.c                   |  13 +-
 drivers/net/ngbe/base/ngbe_hw.c                    |   9 +
 drivers/net/ngbe/base/ngbe_type.h                  |   1 +
 drivers/net/ngbe/ngbe_ethdev.c                     |   6 +-
 drivers/net/null/rte_eth_null.c                    |  12 +-
 drivers/net/octeon_ep/otx_ep_mbox.h                |   2 +-
 drivers/net/qede/qede_filter.c                     |  22 +-
 drivers/net/sfc/sfc.c                              |   6 +-
 drivers/net/tap/tap_tcmsgs.c                       |   4 +-
 drivers/net/txgbe/base/txgbe_hw.c                  |  13 +-
 drivers/net/txgbe/base/txgbe_type.h                |  21 +-
 drivers/net/txgbe/txgbe_ethdev.c                   |   6 +-
 drivers/net/txgbe/txgbe_ethdev.h                   |   8 +-
 drivers/net/txgbe/txgbe_ethdev_vf.c                |  31 +-
 drivers/net/txgbe/txgbe_fdir.c                     |  40 +-
 drivers/net/txgbe/txgbe_flow.c                     | 257 +++++-----
 drivers/net/txgbe/txgbe_rxtx.c                     |   2 +
 .../testbed_model/capturing_traffic_generator.py   |   5 +-
 examples/flow_filtering/Makefile                   |   2 +-
 examples/ipsec-secgw/ipsec-secgw.c                 |  11 +-
 examples/ipsec-secgw/ipsec_neon.h                  |   8 +-
 examples/ipsec-secgw/ipsec_worker.c                |   5 +-
 examples/ntb/ntb_fwd.c                             |  15 +
 lib/acl/acl_run.h                                  |   5 +
 lib/acl/acl_run_altivec.h                          |   8 +-
 lib/acl/acl_run_avx2.h                             |   4 +-
 lib/acl/acl_run_neon.h                             |   8 +-
 lib/acl/acl_run_scalar.c                           |   4 +-
 lib/acl/acl_run_sse.h                              |   8 +-
 lib/eal/common/eal_common_lcore.c                  |   2 +-
 lib/eal/common/eal_common_memory.c                 |   8 +-
 lib/eal/common/eal_common_options.c                |   6 +
 lib/eal/freebsd/eal.c                              |   2 +-
 lib/eal/freebsd/eal_alarm.c                        |   8 +-
 lib/eal/include/rte_trace_point.h                  |   4 +-
 lib/eal/linux/eal.c                                |   2 +-
 lib/eal/linux/eal_alarm.c                          |   9 +-
 lib/eal/linux/eal_memory.c                         |  12 +
 lib/eal/unix/eal_unix_memory.c                     |   2 +-
 lib/ethdev/rte_ethdev.c                            |  11 +-
 lib/ethdev/rte_flow.c                              |  12 +-
 lib/ethdev/rte_flow.h                              |  44 +-
 lib/latencystats/rte_latencystats.c                |  55 ++-
 lib/power/power_intel_uncore.c                     |  35 +-
 lib/vhost/vhost.c                                  |   6 +-
 lib/vhost/vhost_crypto.c                           |   3 +-
 lib/vhost/virtio_net_ctrl.c                        |  12 +-
 170 files changed, 2261 insertions(+), 1441 deletions(-)
Amiya Ranjan Mohakud (1):
      net/iavf: fix VLAN strip setting after enabling filter

Anatoly Burakov (1):
      net/ixgbe: fix indentation

Ariel Otilibili (1):
      net/af_xdp: fix use after free in zero-copy Tx

Arkadiusz Kusztal (2):
      crypto/qat: fix out-of-place header bytes in AEAD raw API
      crypto/qat: fix out-of-place chain/cipher/auth headers

Bing Zhao (2):
      net/mlx5: fix WQE size calculation for Tx queue
      examples/ntb: check more heap allocations

Bruce Richardson (8):
      net/fm10k/base: fix compilation warnings
      net/ixgbe/base: correct definition of endianness macro
      net/ixgbe/base: fix compilation warnings
      net/i40e/base: fix unused value warnings
      net/i40e/base: fix compiler warnings
      test/malloc: improve resiliency
      power/intel_uncore: fix crash closing uninitialized driver
      net/ice: fix inconsistency in Rx queue VLAN tag placement

Chaoyong He (5):
      net/nfp: fix crash with null RSS hash key
      net/nfp: fix hash key length logic
      app/testpmd: fix RSS hash key update
      net/nfp: standardize NFD3 Tx descriptor endianness
      net/nfp: standardize NFDk Tx descriptor endianness

Chengwen Feng (3):
      app/testpmd: relax number of TCs in DCB command
      bus: cleanup device lists
      net/hns3: fix queue TC configuration on VF

Clemens Famulla-Conrad (1):
      dts: fix deterministic doc

Dariusz Sosnowski (5):
      net/mlx5: fix header modify action on group 0
      net/mlx5: validate GTP PSC QFI width
      net/mlx5: fix counter service cleanup on init failure
      net/mlx5: fix VLAN stripping on hairpin queue
      net/mlx5: fix masked indirect age action validation

David Marchand (7):
      acl: fix build with GCC 15 on aarch64
      vhost: fix wrapping on control virtqueue rings
      eal: warn if no lcore is available
      test/lcore: fix race in per-lcore test
      doc: remove reference to deprecated --use-device option
      eal: add description of service corelist in usage
      net/virtio: revert Tx free threshold fix

Dengdui Huang (13):
      net/hns3: fix integer overflow in interrupt unmap
      net/hns3: fix memory leak on failure
      net/hns3: fix extra wait for link up
      net/hns3: fix memory leak for indirect flow action
      net/hns3: fix interrupt rollback
      net/hns3: fix divide by zero
      net/hns3: fix resources release on reset
      net/hns3: fix CRC data segment
      mem: fix lockup on address space shortage
      net/hns3: check requirement for hardware GRO
      net/hns3: allow Tx vector when fast free not enabled
      net/hns3: allow Rx vector mode with VLAN filter
      net/hns3: fix Rx packet without CRC data

Dhanya Pillai (2):
      net/ice: fix flow creation failure
      net/i40e: fix RSS on plain IPv4

Doug Foster (1):
      config/arm: add grace build config

Eugenio Pérez (2):
      vhost: fix net control virtqueue used length
      vhost: search virtqueues driver data in read-only area

Ferruh Yigit (1):
      ethdev: convert string initialization

Gagandeep Singh (2):
      common/dpaax: fix PDCP key command race condition
      common/dpaax: fix PDCP AES only 12-bit SN

Gavin Li (1):
      net/mlx5: align PF and VF/SF MAC address handling

Gowrishankar Muthukrishnan (2):
      crypto/openssl: include private exponent in RSA session
      test/crypto: fix RSA decrypt validation

Gregory Etelson (4):
      net/mlx5: remove unsupported flow meter action in HWS
      net/mlx5: fix mark action with shared Rx queue
      common/mlx5: fix extraction of auxiliary device name
      bus/auxiliary: fix crash in cleanup

Hengqi Chen (1):
      net/virtio: fix check of threshold for Tx freeing

Ivan Malov (1):
      net/sfc: fix action order on start failure

Jake Freeland (1):
      bus/pci/bsd: fix device existence check

Jaromír Smrček (1):
      doc: add kernel options required for mlx5

Jiawen Wu (11):
      net/txgbe: fix ntuple filter parsing
      net/txgbe: fix raw pattern match for FDIR rule
      net/txgbe: fix MAC control frame forwarding
      net/ngbe: fix MAC control frame forwarding
      net/txgbe: fix device statistics
      net/ngbe: fix device statistics
      net/txgbe: restrict VLAN strip configuration on VF
      net/txgbe: fix packet type for FDIR filter
      net/txgbe: fix to create FDIR filter for SCTP packet
      net/txgbe: fix reserved extra FDIR headroom
      net/txgbe: add LRO flag in mbuf when enabled

Kaiwen Deng (3):
      net/e1000: fix xstats name
      net/ixgbe: enable ethertype filter for E610
      net/e1000: fix igb Tx queue offloads capability

Khadem Ullah (1):
      net/mlx5: fix crash on age query with indirect conntrack

Long Li (5):
      bus/vmbus: align ring buffer data to page boundary
      bus/vmbus: use Hyper-V page size
      net/netvsc: use Hyper-V page size
      net/netvsc: add stats counters from VF
      net/mana: check vendor ID when probing RDMA device

Lukasz Krakowiak (2):
      net/ice/base: fix integer overflow
      net/ice/base: fix typo in device ID description

Maayan Kashani (4):
      net/mlx5/hws: fix send queue drain on FW WQE destroy
      ethdev: fix error struct in flow configure
      examples/multi_process: fix ports cleanup on exit
      net/mlx5: fix crash in HWS counter pool destroy

Madhuker Mythri (1):
      net/bonding: avoid RSS RETA update in flow isolation mode

Marat Khalili (1):
      buildtools/test: scan muti-line registrations

Maxime Coquelin (1):
      net/mlx5: avoid setting kernel MTU if not needed

Mingjin Ye (2):
      net/ice: fix handling empty DCF RSS hash
      net/ice: fix querying RSS hash for DCF

Mohamed Feroz Abdul Majeeth (1):
      net/octeon_ep: increase mailbox timeout

Morten Brørup (1):
      eal/unix: fix log message for madvise failure

Nithin Dabilpuram (1):
      common/cnxk: fix CQ tail drop

Nithinsen Kaithakadan (3):
      test/crypto: fix auth and cipher case IV length
      test/crypto: set to null after freeing operation
      common/cnxk: fix qsize in CPT iq enable

Oleksandr Nahnybida (1):
      trace: fix overflow in per-lcore trace buffer

Pavan Nikhilesh (1):
      eal: fix return value of lcore role

Pravin Pathak (6):
      event/dlb2: fix validaton of LDB port COS ID arguments
      event/dlb2: fix num single link ports for DLB2.5
      event/dlb2: fix QID depth xstat
      event/dlb2: fix public symbol namespace
      app/eventdev: fix number of releases sent during cleanup
      event/dlb2: fix dequeue with CQ depth <= 16

Radu Nicolau (2):
      crypto/virtio: add request check on request side
      crypto/virtio: fix driver cleanup

Rahul Bhansali (2):
      net/cnxk: fix descriptor count update on reconfig
      common/cnxk: fix null pointer checks

Rajesh Mudimadugula (3):
      vhost/crypto: fix cipher data length
      crypto/virtio: fix cipher data source length
      crypto/virtio: fix driver ID

Rakesh Kudurumalla (2):
      examples/ipsec-secgw: fix crash with IPv6
      examples/ipsec-secgw: fix crash in event vector mode

Rui Ferreira (2):
      eal/linux: unregister alarm callback before free
      eal/freebsd: unregister alarm callback before free

Satheesh Paul (1):
      common/cnxk: fix E-tag pattern parsing

Shani Peretz (1):
      app/crypto-perf: fix AAD offset alignment

Stephen Hemminger (5):
      net/qede: fix use after free
      bus/fslmc: fix use after free
      net/null: fix packet copy
      crypto/qat: fix size calculation for memset
      latencystats: fix receive sample race

Sunyang Wu (1):
      ethdev: keep promiscuous/allmulti value before disabling

Tanzeel Ahmed (1):
      examples/flow_filtering: fix make clean

Thomas Monjalon (1):
      examples/multi_process: revert ports cleanup on exit

Tirthendu Sarkar (1):
      event/dlb2: fix default credits based on HW version

Vanshika Shukla (1):
      crypto/dpaa2_sec: fix uninitialized variable

Viacheslav Ovsiienko (3):
      net/mlx5: fix maximal queue size query
      net/mlx5: fix hypervisor detection in VLAN workaround
      net/mlx5: fix out-of-order completions in ordinary Rx burst

Volodymyr Fialko (1):
      examples/ipsec-secgw: fix number of queue pairs

Xueming Li (3):
      Revert "net/ice: fix inconsistency in Rx queue VLAN tag placement"
      version: 23.11.5-rc1
      version: 23.11.5

Yan Lu (1):
      net/tap: fix qdisc add failure handling

Yang Ming (1):
      eal/linux: improve ASLR check

Yuan Wang (2):
      net/e1000: fix EEPROM dump
      net/ixgbe: fix port mask default value in filter
