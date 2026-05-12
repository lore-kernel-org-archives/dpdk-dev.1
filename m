Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ED3CD4851
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 13:03:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C78640615;
	Tue, 12 May 2026 15:03:13 +0200 (CEST)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id D935640261;
 Tue, 12 May 2026 15:03:12 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012011.outbound.protection.outlook.com
 [40.93.195.11]) by mails.dpdk.org (Postfix) with ESMTP id 2C5FD400D7
 for <announce@dpdk.org>; Tue, 12 May 2026 15:03:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/oGgkfcmEbwrqJ3XodouOu5iJOXSXRQmt/tdfUfy7h4dCMVVdg7PrL/iImIzaLeUGPjfkBwgdihNxMaNIZPBoIhHjftEgh7RrYC0YS5mbYX9ILlL81StiWLMMGsoUNdOYN7SLETBRVxmMge4ob2BHisvejCkGzc7DoIA4fDQUAv6Au1L+3YUy0hQr6i1Ba9PiggfSmGVDcFvzm1MSWl54RhW7HMdp1qKPaCXo1LG8pGEbd1srNRU1i6s0rvjEt4zBaUckXUPwLNpmxiYPrh40C/d7j9lV552Ws+pOdAuUIixpuj0IvjhN72PPn2lKcGFiXtTHqAZwA4VQcoJJLS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYzIfoG0EphWCtMSDe2IdmbKh+/LB5g55kvBpvVSxYk=;
 b=XZ5zxX4n0m9LJMuuXdH7rOwpjdbFtJWDk1YrOdP1dfvQrydl1rDFPhhOZFtJtTBfir7Lt2kGIha1r0ojR1TlP7c0DReBzO5ivp4fMWBOQcrs5OF39NqE56uoTKR4pPvAeBLt/xDL5hR+3X1AwYftk7dmqmIHpTEbh1ZLMY69ZkWm+qjJfipyEjK9u3+J9EQckzQ/ELe4r8HPuLO5D1ix3cHSq+Y8hdOqxK97mLgFzMgI4xxvuql+hTiedKJEdvqx7tZFMMXitnNBZpWJxt/C+tkEP5TpFDZH4wrpCkq5G6TTYMSITTRFdsVkqZi5iCV7Lxvv95xRYETR2LSAEdwFbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYzIfoG0EphWCtMSDe2IdmbKh+/LB5g55kvBpvVSxYk=;
 b=uaNi0t/v44nwGwU4NwUFQ1heLpEnJSg/M+tvo9lWNsc65PV8MVyG06Mod4dtC3l0jdBxlzQKLQNLaO8VHnrNstFOICuWDLBrdO4QVbV4JoojW4dcCzob3sv/GmgL2XJBHyFkti8I8o7oJci35crWfR2fbY+wBEff0D9Lp9MJg6ZDYM42N3NvoP2u5umjcj5+ktrYD64hVPFdnzcGsCoTsrGIjVwGH+XaL13tCSaRIPxd2CPjN2K9GOlUetayOJD69iuHFmvynCkcpea9JZXSx0ioUv3wwuDwqBMSFjpYzUvsRfMBBSDupt3i/W9NWoE/KmQBv4uijtFwirG5ANtJMQ==
Received: from CH2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:610:50::37)
 by PH7PR12MB7017.namprd12.prod.outlook.com (2603:10b6:510:1b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Tue, 12 May
 2026 13:03:01 +0000
Received: from DS2PEPF000061C1.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::59) by CH2PR16CA0027.outlook.office365.com
 (2603:10b6:610:50::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.16 via Frontend Transport; Tue, 12
 May 2026 13:02:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C1.mail.protection.outlook.com (10.167.23.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 13:02:58 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 12 May
 2026 06:02:39 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 12 May
 2026 06:02:39 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 12 May 2026 06:02:38 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <announce@dpdk.org>
Subject: DPDK 23.11.7 released
Date: Tue, 12 May 2026 16:02:34 +0300
Message-ID: <20260512130234.3906709-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C1:EE_|PH7PR12MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a7893f-dfaa-41d0-1f01-08deb026ca89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: 6cY0EJgrQJTOtAOto1rk4Hf71rBOhTbEBqw4CwoHY4J8EQdDq2da5EgsqIgya0gKfrBeu2goF9pTD/Lx+QNPGj5Ys/xTeC7GKkO7LlqqI8KTWa/lfzhpLNofMUG53t/u8v4zT7YjMdza67ukon+HB7P7jqg9JmPkn23PIQ25KtkQ+Clj8P27kGMhvIqWj7mkgVjzbd3VLFTb1c1M+aBG4VyU/PU8ptWqJZXmg6y/VFfPQDrNdc13uQdGjKuaaK0C6o/E8wfz5bwEQtGsKzQoSUirwGB6xgpybTWXAjnSsKCYaUxzgeymns6ckIz/WVqSrzcSth5FDklhaUTCqHGjoje3YFJN+U+qyI9apcUPnpNjD3pWE2WPEFfW05sVhC4BEwwpjVH3L9kgX0mAhbdjgiF5Slvlhn1rPirrMwXMMj2e4LwwbaHS5ci7HfOxVn57BWWWmPYo8UgLZob72T7ES1GY0mikfyDJ2E6yKuyQqxcNOvG1cIBRo/komivR5AxSuzBMXx3d2MTINAUYmvikqxDODjqxeeZy7B2LQAdaPWA99Qsbz/R3Pz0uJ4u6PI3imzbPM0sjbdMRxHa6HF+C4/bxKqhHsMLreivTRivBOzTK4DErOQcProO5y8KYuUYcK7Na6wylu3mMF69dWdFR2ENGsp6GzODFMluQMzr5T+XygQDTnsvMWU+jbi+gmDGbNGrVhciodtj2+vxiCvaLuIIBIdre9BnGn1JbkHjTyjQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(56012099003)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ykJ/HHDZSlOyFG2Bq7PC42B6xOaAZ+IUMQxLQSqSDHu9Ju4PxSWQjbfgy+pqemPEaDrn5pz+c6gNgCM5k5OXD7vDGEWm5UNy2/F5am943eiW0sFrNhj81VAWRAiY+ZJ/FRZf9rV/oPia6oZkbWNrBoy2Y6Zr6VtoAzqlG03Uvz2eu8oKTpYueQ01z0yuDwG66Sp+HPMsrjNPt+7NvH4vC6KQr+p98coD0xQg5Tpx3KEjCRQa3c2et4zFxvj+sYEfDGxg/06/P4sG7PLDVJwnfvxcnzHDm9QMYShX8kopA+A+ga7ZpEAuhbxn57fRy8t06mqjjnoCXE6F8CQ59cGYe5PNy0zetbj9jg/6jhSRnTHAZjpjp+7Ofx8N7fqOzDrzeMqfhgiDrRLTzLdwaErLNaNMc0WsOo1+WV/eMjF6tbfDVLK6gPjuKQQYMVf8DTTF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 13:02:58.4833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a7893f-dfaa-41d0-1f01-08deb026ca89
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161]; 
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7017
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
	https://fast.dpdk.org/rel/dpdk-23.11.7.tar.xz

The git tree is at:
	https://dpdk.org/browse/dpdk-stable/?h=23.11

Shani

---
 .mailmap                                      |  14 +-
 VERSION                                       |   2 +-
 app/graph/conn.c                              | 134 +++---
 app/pdump/main.c                              |  12 +-
 app/proc-info/main.c                          |   2 +-
 app/test-dma-perf/benchmark.c                 |   6 +-
 app/test-dma-perf/main.h                      |   2 +-
 app/test-pmd/cmdline_flow.c                   |  42 +-
 app/test-pmd/config.c                         | 212 ++++++++-
 app/test-pmd/parameters.c                     |  36 +-
 app/test-pmd/testpmd.c                        |  10 +-
 app/test-pmd/testpmd.h                        |   4 +
 app/test/meson.build                          |   6 +-
 app/test/suites/meson.build                   |  19 +-
 app/test/test.h                               |  19 +
 app/test/test_atomic.c                        |  66 +--
 app/test/test_bpf.c                           | 644 ++++++++++++++++++++++++++
 app/test/test_cryptodev.c                     |  46 +-
 app/test/test_debug.c                         |   9 +-
 app/test/test_event_dma_adapter.c             |   2 +-
 app/test/test_mbuf.c                          |  18 +-
 app/test/test_mcslock.c                       |   9 +-
 app/test/test_pcapng.c                        |  65 ++-
 app/test/test_security_inline_proto.c         |   4 +-
 app/test/test_stack.c                         |  11 +-
 app/test/test_table_acl.c                     |  30 +-
 app/test/test_telemetry_data.c                |  21 +
 app/test/test_threads.c                       |  17 +-
 app/test/test_timer_secondary.c               |  48 +-
 buildtools/get-test-suites.py                 |   3 +-
 config/arm/arm32_armv8_linux_gcc              |   3 +
 doc/guides/nics/features/i40e.ini             |   2 +-
 doc/guides/nics/features/iavf.ini             |   4 +-
 doc/guides/nics/features/ice.ini              |   6 +-
 doc/guides/nics/i40e.rst                      |   4 +-
 doc/guides/nics/igc.rst                       |   2 +-
 doc/guides/rel_notes/release_23_11.rst        | 282 +++++++++++
 drivers/bus/fslmc/fslmc_bus.c                 |   2 +-
 drivers/bus/ifpga/ifpga_bus.c                 |   4 +-
 drivers/bus/pci/linux/pci.c                   |   1 -
 drivers/bus/pci/linux/pci_vfio.c              |   2 +-
 drivers/bus/pci/windows/pci.c                 |   1 -
 drivers/common/cnxk/roc_nix_inl.c             |   2 +-
 drivers/common/cnxk/roc_nix_inl_dev.c         |  10 +-
 drivers/common/idpf/idpf_common_rxtx.h        |   2 +-
 drivers/common/idpf/idpf_common_rxtx_avx512.c |  10 +-
 drivers/common/mlx5/linux/mlx5_common_os.c    |  85 +++-
 drivers/common/mlx5/linux/mlx5_common_os.h    |   9 +
 drivers/common/mlx5/linux/mlx5_nl.c           |   6 +-
 drivers/common/mlx5/mlx5_devx_cmds.c          |  18 +-
 drivers/common/mlx5/mlx5_prm.h                |   2 +-
 drivers/common/mlx5/version.map               |   1 +
 drivers/common/mlx5/windows/mlx5_glue.h       |   2 +-
 drivers/common/sfc_efx/base/ef10_mac.c        |  35 +-
 drivers/crypto/caam_jr/caam_jr_uio.c          |  12 +-
 drivers/crypto/cnxk/cnxk_ae.h                 |   7 +-
 drivers/crypto/openssl/rte_openssl_pmd_ops.c  |   6 +
 drivers/event/cnxk/cn10k_eventdev.c           |  15 +-
 drivers/event/cnxk/cn10k_worker.h             |   6 +-
 drivers/net/af_packet/rte_eth_af_packet.c     |   2 +-
 drivers/net/af_xdp/rte_eth_af_xdp.c           |   2 +-
 drivers/net/axgbe/axgbe_common.h              |   2 +-
 drivers/net/axgbe/axgbe_dev.c                 |   3 +
 drivers/net/axgbe/axgbe_ethdev.h              |   4 +-
 drivers/net/axgbe/axgbe_mdio.c                |   4 +-
 drivers/net/axgbe/axgbe_phy.h                 |   4 +-
 drivers/net/axgbe/axgbe_phy_impl.c            |  15 +
 drivers/net/bnxt/tf_ulp/ulp_mapper.c          |   5 +
 drivers/net/bonding/rte_eth_bond_pmd.c        |  11 +-
 drivers/net/cnxk/cn10k_rx.h                   |   6 +-
 drivers/net/cpfl/cpfl_flow_engine_fxp.c       |   2 -
 drivers/net/cpfl/cpfl_flow_parser.c           |   6 +-
 drivers/net/cpfl/cpfl_fxp_rule.h              |   2 -
 drivers/net/cpfl/cpfl_representor.h           |   2 +-
 drivers/net/cpfl/cpfl_rxtx.c                  |   1 +
 drivers/net/dpaa2/dpaa2_ethdev.c              | 106 ++---
 drivers/net/dpaa2/dpaa2_rxtx.c                |  36 +-
 drivers/net/dpaa2/mc/fsl_dpni.h               |   6 +
 drivers/net/e1000/igb_rxtx.c                  |   3 +-
 drivers/net/enetfec/enet_uio.c                |   8 +-
 drivers/net/hns3/hns3_rxtx.c                  |   3 +-
 drivers/net/i40e/i40e_ethdev.c                |  24 +-
 drivers/net/i40e/i40e_ethdev.h                |  10 +-
 drivers/net/i40e/i40e_flow.c                  |  81 ++--
 drivers/net/i40e/i40e_rxtx_vec_avx2.c         |   4 +-
 drivers/net/i40e/i40e_rxtx_vec_avx512.c       |   2 +-
 drivers/net/iavf/iavf.h                       |   1 +
 drivers/net/iavf/iavf_ethdev.c                |  40 +-
 drivers/net/iavf/iavf_fsub.c                  |   4 +-
 drivers/net/iavf/iavf_generic_flow.c          |  37 +-
 drivers/net/iavf/iavf_generic_flow.h          |   1 +
 drivers/net/iavf/iavf_ipsec_crypto.c          |   2 +-
 drivers/net/iavf/iavf_rxtx_vec_avx2.c         |   4 +-
 drivers/net/iavf/iavf_rxtx_vec_avx512.c       |   6 +-
 drivers/net/ice/base/ice_acl_ctrl.c           |   6 +-
 drivers/net/ice/base/ice_bitops.h             |  14 +-
 drivers/net/ice/base/ice_dcb.c                |   8 +-
 drivers/net/ice/base/ice_sched.c              |   3 +-
 drivers/net/ice/base/ice_switch.c             |   2 +-
 drivers/net/ice/ice_dcf_sched.c               |  15 +-
 drivers/net/ice/ice_ethdev.c                  |  21 +-
 drivers/net/ice/ice_fdir_filter.c             |   8 +-
 drivers/net/ice/ice_rxtx_vec_avx2.c           |   4 +-
 drivers/net/ice/ice_rxtx_vec_avx512.c         |   2 +-
 drivers/net/idpf/idpf_rxtx.c                  |   1 +
 drivers/net/igc/igc_ethdev.c                  |  19 +-
 drivers/net/igc/igc_txrx.c                    | 229 +++++++--
 drivers/net/igc/igc_txrx.h                    |   9 +
 drivers/net/ixgbe/ixgbe_ethdev.h              |   2 +
 drivers/net/ixgbe/ixgbe_fdir.c                |   7 +-
 drivers/net/ixgbe/ixgbe_flow.c                |  50 +-
 drivers/net/ixgbe/ixgbe_ipsec.c               |  18 +-
 drivers/net/ixgbe/ixgbe_ipsec.h               |  16 +-
 drivers/net/ixgbe/ixgbe_rxtx.c                |   3 +-
 drivers/net/mana/mana.c                       |  14 +
 drivers/net/mana/mp.c                         |   8 +
 drivers/net/mana/tx.c                         |   6 +-
 drivers/net/memif/rte_eth_memif.c             |  30 +-
 drivers/net/memif/rte_eth_memif.h             |   1 +
 drivers/net/mlx4/mlx4_mp.c                    |   6 +
 drivers/net/mlx5/hws/mlx5dr_cmd.c             |   4 +-
 drivers/net/mlx5/hws/mlx5dr_internal.h        |   6 +
 drivers/net/mlx5/hws/mlx5dr_rule.c            |   6 +-
 drivers/net/mlx5/hws/mlx5dr_send.c            |   4 +-
 drivers/net/mlx5/linux/mlx5_ethdev_os.c       |  21 +
 drivers/net/mlx5/linux/mlx5_mp_os.c           |   6 +
 drivers/net/mlx5/linux/mlx5_os.c              | 360 +++++++++-----
 drivers/net/mlx5/mlx5.c                       |  35 +-
 drivers/net/mlx5/mlx5.h                       |   6 +-
 drivers/net/mlx5/mlx5_ethdev.c                |  50 +-
 drivers/net/mlx5/mlx5_flow.c                  |   7 +
 drivers/net/mlx5/mlx5_flow.h                  |   2 +
 drivers/net/mlx5/mlx5_flow_aso.c              |  44 +-
 drivers/net/mlx5/mlx5_flow_dv.c               |   6 +
 drivers/net/mlx5/mlx5_flow_flex.c             |   4 +-
 drivers/net/mlx5/mlx5_flow_hw.c               |  82 ++--
 drivers/net/mlx5/mlx5_rx.c                    |   7 +-
 drivers/net/mlx5/mlx5_rx.h                    |  36 +-
 drivers/net/mlx5/mlx5_rxq.c                   |  85 +++-
 drivers/net/mlx5/mlx5_rxtx_vec.c              |   2 +
 drivers/net/mlx5/mlx5_trigger.c               |  16 +-
 drivers/net/mlx5/mlx5_txpp.c                  |   3 -
 drivers/net/mlx5/windows/mlx5_os.c            |  38 +-
 drivers/net/mvpp2/mrvl_ethdev.c               |   1 -
 drivers/net/netvsc/hn_ethdev.c                | 372 ++++++++++++++-
 drivers/net/netvsc/hn_nvs.h                   |   6 +
 drivers/net/netvsc/hn_rxtx.c                  |  40 +-
 drivers/net/netvsc/hn_var.h                   |   1 +
 drivers/net/netvsc/hn_vf.c                    | 213 ++++++---
 drivers/net/nfb/nfb.h                         |  13 +
 drivers/net/nfb/nfb_ethdev.c                  | 166 ++++---
 drivers/net/nfb/nfb_rx.c                      |   2 +-
 drivers/net/nfb/nfb_rxmode.c                  |  12 +-
 drivers/net/nfb/nfb_stats.c                   |  57 ++-
 drivers/net/nfb/nfb_tx.c                      |   2 +-
 drivers/net/sfc/sfc.h                         |   2 +-
 drivers/net/sfc/sfc_ethdev.c                  | 128 ++---
 drivers/net/sfc/sfc_ev.c                      |   7 +-
 drivers/net/sfc/sfc_port.c                    |   8 +-
 drivers/net/sfc/sfc_repr.c                    |   2 +-
 drivers/net/tap/rte_eth_tap.c                 |  51 +-
 drivers/net/tap/rte_eth_tap.h                 |   4 +-
 drivers/net/tap/tap_flow.c                    |  23 +-
 examples/ethtool/ethtool-app/main.c           |   8 +-
 examples/fips_validation/main.c               |  17 +-
 examples/ipsec-secgw/parser.c                 |   4 +-
 examples/ipsec-secgw/sa.c                     |   2 +-
 examples/ipsec-secgw/sp4.c                    |   2 +-
 examples/ipsec-secgw/sp6.c                    |   2 +-
 examples/l2fwd-jobstats/main.c                |   4 +-
 examples/packet_ordering/main.c               |   2 +-
 examples/ptpclient/ptpclient.c                |   2 +-
 examples/vm_power_manager/channel_manager.c   |  12 +-
 examples/vm_power_manager/main.c              |   2 +-
 examples/vmdq_dcb/main.c                      |  31 +-
 lib/bbdev/rte_bbdev.c                         |   2 +-
 lib/bpf/bpf_jit_arm64.c                       | 162 +++----
 lib/bpf/bpf_jit_x86.c                         |  15 +
 lib/bpf/bpf_load.c                            |   2 +-
 lib/bpf/bpf_validate.c                        |  48 +-
 lib/cryptodev/rte_cryptodev.c                 |  37 +-
 lib/eal/common/eal_common_options.c           |  22 +-
 lib/eal/common/eal_common_trace.c             |  90 ++--
 lib/eal/common/malloc_heap.c                  |   2 +-
 lib/eal/freebsd/eal_interrupts.c              |   6 +
 lib/eal/include/rte_bitops.h                  |  66 +++
 lib/eal/include/rte_common.h                  |   6 +-
 lib/eal/include/rte_interrupts.h              |  21 +
 lib/eal/linux/eal_interrupts.c                | 102 ++--
 lib/eal/linux/eal_memalloc.c                  |  26 +-
 lib/eal/version.map                           |   1 +
 lib/eal/windows/eal_interrupts.c              |   6 +
 lib/eal/x86/rte_cycles.c                      |   2 +-
 lib/ethdev/ethdev_driver.c                    |   6 +-
 lib/ethdev/rte_ethdev.c                       |   1 -
 lib/eventdev/rte_event_eth_rx_adapter.c       |  17 +-
 lib/eventdev/rte_event_eth_tx_adapter.c       |   8 +-
 lib/fib/dir24_8.c                             |   3 +-
 lib/fib/trie.c                                |   4 +-
 lib/hash/rte_cuckoo_hash.c                    |  46 +-
 lib/hash/rte_thash_x86_gfni.h                 |   4 +-
 lib/mbuf/rte_mbuf.c                           |   2 +-
 lib/mbuf/rte_mbuf.h                           |   2 +-
 lib/net/net_crc_avx512.c                      |   4 +-
 lib/pcapng/rte_pcapng.c                       |  83 ++--
 lib/pcapng/rte_pcapng.h                       |  10 +-
 lib/pdcp/pdcp_process.c                       |   2 +
 lib/pipeline/rte_swx_ctl.c                    |  11 +-
 lib/pipeline/rte_swx_pipeline.c               |  21 +-
 lib/pipeline/rte_swx_pipeline_internal.h      |  10 +-
 lib/power/rte_power_pmd_mgmt.c                |   6 +-
 lib/rcu/rte_rcu_qsbr.h                        |   2 +-
 lib/sched/rte_red.h                           |   9 +-
 lib/table/rte_lru.h                           |  38 +-
 lib/table/rte_lru_arm64.h                     |  14 +-
 lib/table/rte_lru_x86.h                       |   4 +-
 lib/table/rte_swx_table_em.c                  |   2 -
 lib/table/rte_swx_table_learner.c             |   4 +-
 lib/table/rte_table_hash_key16.c              |   4 +-
 lib/table/rte_table_hash_key32.c              |   4 +-
 lib/table/rte_table_hash_key8.c               |   4 +-
 lib/telemetry/telemetry_data.c                |   6 +-
 lib/vhost/vduse.c                             |   5 +-
 lib/vhost/vhost.h                             |   5 +-
 lib/vhost/virtio_net_ctrl.c                   |  22 +-
 usertools/dpdk-pmdinfo.py                     |   5 +-
 226 files changed, 4412 insertions(+), 1605 deletions(-)
Aarnav JP (2):
      examples/packet_ordering: fix format specifier for port ID
      examples/ptpclient: fix format specifier for port ID

Anatoly Burakov (12):
      net/ixgbe: fix memory leak in security flows
      net/ixgbe: fix potential null dereference with IPsec config
      net/ixgbe: fix potential null dereference in IPsec flow
      net/ixgbe: fix pointer handling in IPsec
      net/i40e: move filter config to flow create
      net/i40e: fix IPv6 GTPU handling
      net/iavf: fix memory leak on egress IPsec flows
      net/iavf: fix memory leak on uninit
      net/iavf: fix IPv4 flow subscription
      net/ice: fix memory leak in DCF QoS bandwidth config
      net/ice: fix memory leak in FDIR flow parsing
      net/iavf: fix struct size in IPsec status get

Anurag Mandal (3):
      app/testpmd: fix function names in logs
      net/i40e: fix QinQ stripping
      net/iavf: fix deletion of primary MAC address

Ashok Kumar Natarajan (5):
      net/axgbe: fix MAC TCR speed select field width
      net/axgbe: add 100 Mbps MAC speed select
      net/axgbe: fix auto-negotiation capabilities
      net/axgbe: fix SGMII auto-negotiation status bits
      net/axgbe: fix 100M SGMII mode

Bruce Richardson (31):
      net/iavf: revert check for PF Rx timestamp support
      rcu: fix build with MSVC
      test/red: fix some undefined behaviour
      test/timer: fix hang on secondary process failure
      buildtools/test: suppress empty output
      eal: fix variable shadowing
      bbdev: fix variable shadowing
      ethdev: fix variable shadowing
      eventdev: fix variable shadowing
      net: fix variable shadowing
      pcapng: fix variable shadowing
      pipeline: fix variable shadowing
      power: fix variable shadowing
      table: fix variable shadowing
      bus/pci: fix variable shadowing
      net/cpfl: fix variable shadowing
      net/e1000: fix variable shadowing
      net/i40e: fix variable shadowing
      net/ice: fix variable shadowing
      net/ixgbe: fix variable shadowing
      app/graph: fix variable shadowing
      app/pdump: fix variable shadowing
      app/testpmd: fix variable shadowing
      config/arm: fix 32-bit build
      hash: fix maybe-uninitialized warnings on build
      net/intel: fix memory leak on Tx queue setup failure
      test: fix dependencies on net null driver
      hash: fix overflow of 32-bit offsets
      test/security: skip inline protocol test if no HW support
      net/bonding: clamp Rx free threshold for small rings
      usertools/pmdinfo: fix search for PMD info string

Chengwen Feng (2):
      net/hns3: fix outer UDP checksum with simple BD
      eal: introduce more macros for bit definition

Ciara Loftus (7):
      doc: fix TSO and checksum offload feature status for ice
      doc: fix TSO feature status for iavf
      doc: fix inline crypto feature status for iavf
      doc: fix TSO feature status for i40e
      net/i40e: validate raw flow items before dereferencing
      doc: remove references to obsolete testpmd flag
      net/i40e: fix raw flow item validation

Congjie Zhou (1):
      eal/linux: fix fbarray name collision in containers

Dariusz Sosnowski (10):
      app/testpmd: fix flow queue job leaks
      net/mlx5: fix flow mark reading after reconfigure
      net/mlx5: fix shared Rx queue limitations
      common/mlx5: fix bonding check
      net/mlx5: fix bonding check
      net/mlx5: fix probing to allow BlueField Socket Direct
      net/mlx5: fix VLAN strip info for CQE compression
      net/mlx5: fix flex item capability check
      common/mlx5: fix error logging for queue modify
      net/mlx5: report share group and queue ID

David Marchand (9):
      bus/ifpga: fix const pointer in device name parsing
      crypto/caam_jr: fix const pointer in UIO filename parsing
      net/enetfec: fix const pointer in UIO filename parsing
      net/memif: fix const pointer in socket check
      app/procinfo: fix const pointer in collectd format
      net/tap: remove log when running without multiprocess
      net/af_xdp: fix external mbuf transmit
      common/mlx5: fix MAC deletion on Linux
      examples/vm_power_manager: fix format specifier for port ID

Emma Finn (1):
      examples/fips_validation: fix dangling pointers

Garvit Varshney (1):
      crypto/cnxk: return decrypted data for RSA verify

Gregory Etelson (3):
      net: fix packet type for stacked VLAN
      net/mlx5: fix MPESW PF probe for any number of ports
      net/mlx5: fix IPv6 SRH flex node header length

Itai Sharoni (1):
      net/mlx5/windows: fix MAC address ownership tracking

Ivan Malov (4):
      common/sfc_efx/base: fix flow control on legacy MCDI
      net/sfc: rework capability check that is done on FEC set
      net/sfc: drop AUTO from FEC capabilities and fix comment
      net/sfc: fix reporting status of autonegotiation

Jacob Keller (1):
      net/iavf: negotiate PTP before reporting Rx timestamping

John McNamara (1):
      net/i40e: fix unused variable

Kai Ji (1):
      crypto/openssl: fix SM2 public key buffer overflow

Kevin Traynor (5):
      eal/linux: handle interrupt epoll events
      interrupts: add interrupt event info
      net/mlx5: check DevX disconnect/error interrupt events
      examples/ipsec-secgw: fix build with glibc 2.43
      examples/vm_power: check truncation of socket path

Liangxing Wang (1):
      app/dma-perf: fix reversed CPU copy

Long Li (14):
      net/netvsc: fix race conditions on VF add/remove events
      net/netvsc: support multi-process VF device removal
      net/mana: fix PD resource leak on device close
      net/netvsc: fix devargs memory leak on hotplug
      net/mana: fix fast-path ops setup in secondary process
      net/mlx5: fix fast-path ops setup in secondary process
      net/mlx4: fix fast-path ops setup in secondary process
      net/netvsc: fix subchannel leak on device removal
      net/netvsc: fix double-free of primary Rx queue on uninit
      net/netvsc: fix resource leak on init failure
      net/netvsc: fix event callback leak on Rx filter failure
      net/netvsc: fix resource leaks on MTU change
      net/mana: fix CQE suppression handling on error completions
      net/netvsc: switch data path to synthetic on device stop

Luca Boccassi (1):
      test/debug: fix IOVA mode on PPC64 without huge pages

Maayan Kashani (1):
      net/mlx5: fix redundant control rules in promiscuous mode

Maciej Paczkowski (1):
      net/ice/base: fix integer types in comparisons

Marat Khalili (6):
      bpf: fix x86 call stack alignment for external calls
      bpf: disallow empty program
      bpf: fix add/subtract overflow
      bpf: fix starting with conditional jump
      bitops: allow variable as first argument of shift macros
      bpf: fix signed shift overflows in ARM JIT

Martin Spinler (5):
      net/nfb: use constant values for max Rx/Tx queues count
      net/nfb: fix bad pointer access in queue stats
      net/nfb: use process private variable for internal
      net/nfb: fix resources release
      net/nfb: stop only started queues in fail path

Maxime Coquelin (3):
      vhost: fix virtqueue array size for control queue
      vhost: fix descriptor chain bounds check in control queue
      vhost: fix mmap error check in VDUSE IOTLB miss handler

Maxime Leroy (8):
      net/dpaa2: warn on Rx descriptor limit in high perf mode
      net/dpaa2: fix resource leak on soft parser failure
      net/dpaa2: fix link after port stop/start
      net/dpaa2: fix spurious VLAN insertion on non-VLAN packet
      net/dpaa2: fix L4 packet type in slow parse path
      net/dpaa2: fix L3/L4 checksum offload flags
      net/dpaa2: fix burst mode info
      net/dpaa2: add SG table walk upper bound in Rx

Morten Brørup (2):
      eal: fix cache guard for pedantic compilation
      mbuf: fix packet data read

Nithinsen Kaithakadan (1):
      test/crypto: fix mbuf segment number

Pavan Nikhilesh (1):
      event/cnxk: fix Rx offload flags

Piotr Krzewinski (1):
      cryptodev: fix memory corruption in secondary process

Radu Nicolau (1):
      pdcp: add digest physical address

Rahul Bhansali (1):
      event/cnxk: fix crash on CN10K

Rakesh Kudurumalla (2):
      common/cnxk: fix engine capabilities fetch logic
      examples/l2fwd-jobstats: fix stats availability

Robin Jarry (3):
      net/iavf: fix reported max Tx and Rx queues
      telemetry: fix adding dict in container array
      hash: avoid leaking entries on RCU defer queue failure

Rongwei Liu (1):
      net/mlx5: fix job leak on indirect meter creation failure

Sergei Iashin (1):
      eventdev/eth_rx: fix crash with telemetry

Shaiq Wani (1):
      net/idpf: fix typo in CQ scan threshold macro name

Shani Peretz (10):
      examples/ethtool: fix size of mempool name
      net/mlx5/hws: fix stack alignment for ASan compatibility
      net/mlx5/hws: fix null dereference in rule skip
      net/mlx5: allow MTU mismatch for running shared queue
      app/testpmd: fix memory leak in port flow configure
      net/mlx5: fix meter ASO action leak on release to pool
      version: 23.11.7-rc1
      app/test: fix uninitialized event in DMA adapter test
      Revert "net: fix packet type for stacked VLAN"
      version: 23.11.7

Song Yoong Siang (3):
      net/e1000: use device timestamp for clock read in igc
      net/e1000: fix allocation of context desc for launch time
      net/e1000: fix igc launch time calculation

Sriram Yagnaraman (2):
      net/memif: fix descriptor Tx flags corruption
      net/memif: fix multi-segment Rx corruption

Stephen Hemminger (26):
      bus/fslmc: fix const pointer in device name parsing
      common/cnxk: fix array out-of-bounds
      examples/fips_validation: fix RSA memcpy
      net/bnxt: fix build with GCC 16
      test/table: avoid input line overflow
      test/crypto: check for vdev args overflow
      pcapng: document return values
      pcapng: use malloc instead of fixed buffer size
      pcapng: chain additional mbuf when comment exceeds tailroom
      test/pcapng: skip test if null driver missing
      net/mlx5: fix use-after-free in ASO management init
      net/tap: use correct length for interface names
      net/tap: fix resource leaks in secondary process probe
      net/tap: free IPC reply buffer on queue count mismatch
      net/tap: fix use-after-free on remote flow creation failure
      net/tap: free remote flow when implicit rule already exists
      test/pcapng: fix for Windows
      test: add pause to synchronization spinloops
      test/atomic: scale test based on core count
      test/mcslock: scale test based on core count
      test/stack: scale test based on core count
      test/timer: scale test based on core count
      test/timer: replace volatile with C11 atomics
      test: add file-prefix for all fast-tests on Linux
      test/trace: fix parallel execution with traces enabled
      examples/vmdq_dcb: initialize all configuration structures

Talluri Chaitanyababu (1):
      app/testpmd: fix DCB forwarding TC mismatch handling

Thierry Herbelot (1):
      net/intel: update key length when getting RSS key

Thomas Monjalon (4):
      common/mlx5: fix variable shadowing
      net/mvpp2: fix variable shadowing
      eal/x86: fix TSC frequency query
      examples/ethtool: fix error message about ports limit

Venkatesh Vemula (1):
      net/intel: fix comma operator warnings

Viacheslav Ovsiienko (2):
      net/mlx5: fix flex parser creation length attribute
      net/mlx5: fix send skew settings when using wait on time

Vipin Varghese (1):
      app/dma-perf: fix buffer overflow with high core count

Vladimir Medvedkin (1):
      fib: fix prefix addition handling

Xavier Guillaume (1):
      net/af_packet: fix MTU set data size calculation

Xiaoyu Min (1):
      net/mlx5: fix HW flow counter query

Yang Xu (1):
      net/mlx5: fix port down in link detection failure

Yunjian Wang (1):
      net/mlx5: fix memory leak after device spawn failure
