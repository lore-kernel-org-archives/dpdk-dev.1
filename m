Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D974BCA0FFD
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 10:46:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC52B402EE;
	Mon,  1 Sep 2025 12:46:33 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id C9BE44028B
 for <dev@dpdk.org>; Mon,  1 Sep 2025 12:46:31 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cFlpN4ttNz2VRZ7;
 Mon,  1 Sep 2025 18:43:24 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 0722A1A0188;
 Mon,  1 Sep 2025 18:46:29 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Sep 2025 18:46:28 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: [PATCH v4 0/5] add semicolon when export any symbol
Date: Mon, 1 Sep 2025 18:46:23 +0800
Message-ID: <20250901104628.50622-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250828025957.30917-1-fengchengwen@huawei.com>
References: <20250828025957.30917-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Currently, the RTE_EXPORT_INTERNAL_SYMBOL, RTE_EXPORT_SYMBOL and
RTE_EXPORT_EXPERIMENTAL_SYMBOL are placed at the beginning of APIs,
but don't end with a semicolon. As a result, some IDEs cannot identify
the APIs and cannot quickly jump to the definition.

A semicolon is added to the end of above RTE_EXPORT_XXX_SYMBOL in this
commit.

Chengwen Feng (5):
  lib: add semicolon when export symbol
  lib: add semicolon when export experimental symbol
  lib: add semicolon when export internal symbol
  drivers: add semicolon when export any symbol
  doc: update ABI versioning guide

---
v4:
1. fix CI error of mlx5-glue.c error.
v3:
1. split the lib commit to three commits.
2. rebase (try to fix CI error: apply rte_cfgfile.c failed).
v2:
1. drop the gen-version-map.py change make sure it will not compile
   error with on-going code.
2. fix CI error: two semicolon for rte_node_mbuf_dynfield_register.
   and mlx5-glue.c error (by keep no change)
3. split to three commit.

 doc/guides/contributing/abi_versioning.rst    |   10 +-
 drivers/baseband/acc/rte_acc100_pmd.c         |    2 +-
 .../fpga_5gnr_fec/rte_fpga_5gnr_fec.c         |    2 +-
 drivers/baseband/fpga_lte_fec/fpga_lte_fec.c  |    2 +-
 drivers/bus/auxiliary/auxiliary_common.c      |    4 +-
 drivers/bus/cdx/cdx.c                         |    8 +-
 drivers/bus/cdx/cdx_vfio.c                    |    8 +-
 drivers/bus/dpaa/dpaa_bus.c                   |   18 +-
 drivers/bus/dpaa/dpaa_bus_base_symbols.c      |  186 +--
 drivers/bus/fslmc/fslmc_bus.c                 |    8 +-
 drivers/bus/fslmc/fslmc_vfio.c                |   24 +-
 drivers/bus/fslmc/mc/dpbp.c                   |   12 +-
 drivers/bus/fslmc/mc/dpci.c                   |    6 +-
 drivers/bus/fslmc/mc/dpcon.c                  |   12 +-
 drivers/bus/fslmc/mc/dpdmai.c                 |   16 +-
 drivers/bus/fslmc/mc/dpio.c                   |   26 +-
 drivers/bus/fslmc/mc/dpmng.c                  |    4 +-
 drivers/bus/fslmc/mc/mc_sys.c                 |    2 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c      |    6 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpci.c      |    4 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |   22 +-
 drivers/bus/fslmc/qbman/qbman_debug.c         |    4 +-
 drivers/bus/fslmc/qbman/qbman_portal.c        |   82 +-
 drivers/bus/ifpga/ifpga_bus.c                 |    6 +-
 drivers/bus/pci/bsd/pci.c                     |   20 +-
 drivers/bus/pci/linux/pci.c                   |   20 +-
 drivers/bus/pci/pci_common.c                  |   20 +-
 drivers/bus/pci/windows/pci.c                 |   20 +-
 drivers/bus/platform/platform.c               |    4 +-
 drivers/bus/uacce/uacce.c                     |   18 +-
 drivers/bus/vdev/vdev.c                       |   12 +-
 drivers/bus/vmbus/linux/vmbus_bus.c           |   12 +-
 drivers/bus/vmbus/vmbus_channel.c             |   26 +-
 drivers/bus/vmbus/vmbus_common.c              |    6 +-
 drivers/common/cnxk/cnxk_security.c           |   24 +-
 drivers/common/cnxk/cnxk_utils.c              |    2 +-
 drivers/common/cnxk/roc_platform.c            |   36 +-
 .../common/cnxk/roc_platform_base_symbols.c   | 1084 ++++++++---------
 drivers/common/cpt/cpt_fpm_tables.c           |    4 +-
 drivers/common/cpt/cpt_pmd_ops_helper.c       |    6 +-
 drivers/common/dpaax/caamflib.c               |    2 +-
 drivers/common/dpaax/dpaa_of.c                |   24 +-
 drivers/common/dpaax/dpaax_iova_table.c       |   12 +-
 drivers/common/ionic/ionic_common_uio.c       |    8 +-
 .../common/mlx5/linux/mlx5_common_auxiliary.c |    2 +-
 drivers/common/mlx5/linux/mlx5_common_os.c    |   20 +-
 drivers/common/mlx5/linux/mlx5_common_verbs.c |    6 +-
 drivers/common/mlx5/linux/mlx5_nl.c           |   42 +-
 drivers/common/mlx5/mlx5_common.c             |   18 +-
 drivers/common/mlx5/mlx5_common_devx.c        |   18 +-
 drivers/common/mlx5/mlx5_common_mp.c          |   16 +-
 drivers/common/mlx5/mlx5_common_mr.c          |   22 +-
 drivers/common/mlx5/mlx5_common_pci.c         |    4 +-
 drivers/common/mlx5/mlx5_common_utils.c       |   22 +-
 drivers/common/mlx5/mlx5_devx_cmds.c          |  102 +-
 drivers/common/mlx5/mlx5_malloc.c             |    8 +-
 drivers/common/mlx5/windows/mlx5_common_os.c  |   12 +-
 drivers/common/mvep/mvep_common.c             |    4 +-
 drivers/common/nfp/nfp_common.c               |   14 +-
 drivers/common/nfp/nfp_common_pci.c           |    2 +-
 drivers/common/nfp/nfp_dev.c                  |    2 +-
 drivers/common/nitrox/nitrox_device.c         |    2 +-
 drivers/common/nitrox/nitrox_logs.c           |    2 +-
 drivers/common/nitrox/nitrox_qp.c             |    4 +-
 drivers/common/octeontx/octeontx_mbox.c       |   12 +-
 drivers/common/sfc_efx/sfc_base_symbols.c     |  542 ++++-----
 drivers/common/sfc_efx/sfc_efx.c              |    4 +-
 drivers/common/sfc_efx/sfc_efx_mcdi.c         |    4 +-
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c     |   14 +-
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c     |   12 +-
 drivers/crypto/cnxk/cn9k_cryptodev_ops.c      |    4 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c      |   14 +-
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c   |    4 +-
 drivers/crypto/dpaa_sec/dpaa_sec.c            |    4 +-
 drivers/crypto/octeontx/otx_cryptodev_ops.c   |    4 +-
 .../scheduler/rte_cryptodev_scheduler.c       |   20 +-
 drivers/dma/cnxk/cnxk_dmadev_fp.c             |    8 +-
 drivers/event/cnxk/cnxk_worker.c              |    4 +-
 drivers/event/dlb2/rte_pmd_dlb2.c             |    4 +-
 drivers/mempool/cnxk/cn10k_hwpool_ops.c       |    6 +-
 drivers/mempool/dpaa/dpaa_mempool.c           |    4 +-
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c      |   12 +-
 drivers/net/atlantic/rte_pmd_atlantic.c       |   12 +-
 drivers/net/bnxt/rte_pmd_bnxt.c               |   32 +-
 drivers/net/bonding/rte_eth_bond_8023ad.c     |   24 +-
 drivers/net/bonding/rte_eth_bond_api.c        |   30 +-
 drivers/net/cnxk/cnxk_ethdev.c                |    6 +-
 drivers/net/cnxk/cnxk_ethdev_sec.c            |   18 +-
 drivers/net/dpaa/dpaa_ethdev.c                |    6 +-
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c        |    2 +-
 drivers/net/dpaa2/base/dpaa2_tlu_hash.c       |    2 +-
 drivers/net/dpaa2/dpaa2_ethdev.c              |   14 +-
 drivers/net/dpaa2/dpaa2_mux.c                 |    6 +-
 drivers/net/dpaa2/dpaa2_rxtx.c                |    2 +-
 drivers/net/intel/i40e/rte_pmd_i40e.c         |   78 +-
 drivers/net/intel/iavf/iavf_base_symbols.c    |   14 +-
 drivers/net/intel/iavf/iavf_rxtx.c            |   16 +-
 drivers/net/intel/ice/ice_diagnose.c          |    6 +-
 drivers/net/intel/idpf/idpf_common_device.c   |   20 +-
 drivers/net/intel/idpf/idpf_common_rxtx.c     |   46 +-
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    |    4 +-
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  |   10 +-
 drivers/net/intel/idpf/idpf_common_virtchnl.c |   58 +-
 drivers/net/intel/ipn3ke/ipn3ke_ethdev.c      |    2 +-
 drivers/net/intel/ixgbe/rte_pmd_ixgbe.c       |   74 +-
 drivers/net/mlx5/mlx5.c                       |    2 +-
 drivers/net/mlx5/mlx5_flow.c                  |    8 +-
 drivers/net/mlx5/mlx5_rx.c                    |    4 +-
 drivers/net/mlx5/mlx5_rxq.c                   |    4 +-
 drivers/net/mlx5/mlx5_tx.c                    |    2 +-
 drivers/net/mlx5/mlx5_txq.c                   |    6 +-
 drivers/net/octeontx/octeontx_ethdev.c        |    2 +-
 drivers/net/ring/rte_eth_ring.c               |    4 +-
 drivers/net/softnic/rte_eth_softnic.c         |    2 +-
 drivers/net/softnic/rte_eth_softnic_thread.c  |    2 +-
 drivers/net/vhost/rte_eth_vhost.c             |    4 +-
 drivers/power/kvm_vm/guest_channel.c          |    4 +-
 drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c         |   20 +-
 drivers/raw/ifpga/rte_pmd_ifpga.c             |   22 +-
 lib/acl/acl_bld.c                             |    2 +-
 lib/acl/acl_run_scalar.c                      |    2 +-
 lib/acl/rte_acl.c                             |   22 +-
 lib/argparse/rte_argparse.c                   |    4 +-
 lib/bbdev/bbdev_trace_points.c                |    4 +-
 lib/bbdev/rte_bbdev.c                         |   62 +-
 lib/bitratestats/rte_bitrate.c                |    8 +-
 lib/bpf/bpf.c                                 |    4 +-
 lib/bpf/bpf_convert.c                         |    2 +-
 lib/bpf/bpf_dump.c                            |    2 +-
 lib/bpf/bpf_exec.c                            |    4 +-
 lib/bpf/bpf_load.c                            |    2 +-
 lib/bpf/bpf_load_elf.c                        |    2 +-
 lib/bpf/bpf_pkt.c                             |    8 +-
 lib/bpf/bpf_stub.c                            |    4 +-
 lib/cfgfile/rte_cfgfile.c                     |   34 +-
 lib/cmdline/cmdline.c                         |   18 +-
 lib/cmdline/cmdline_cirbuf.c                  |   38 +-
 lib/cmdline/cmdline_parse.c                   |    8 +-
 lib/cmdline/cmdline_parse_bool.c              |    2 +-
 lib/cmdline/cmdline_parse_etheraddr.c         |    6 +-
 lib/cmdline/cmdline_parse_ipaddr.c            |    6 +-
 lib/cmdline/cmdline_parse_num.c               |    6 +-
 lib/cmdline/cmdline_parse_portlist.c          |    6 +-
 lib/cmdline/cmdline_parse_string.c            |   10 +-
 lib/cmdline/cmdline_rdline.c                  |   30 +-
 lib/cmdline/cmdline_socket.c                  |    6 +-
 lib/cmdline/cmdline_vt100.c                   |    4 +-
 lib/compressdev/rte_comp.c                    |   12 +-
 lib/compressdev/rte_compressdev.c             |   50 +-
 lib/compressdev/rte_compressdev_pmd.c         |    6 +-
 lib/cryptodev/cryptodev_pmd.c                 |   14 +-
 lib/cryptodev/cryptodev_trace_points.c        |    6 +-
 lib/cryptodev/rte_cryptodev.c                 |  166 +--
 lib/dispatcher/rte_dispatcher.c               |   26 +-
 lib/distributor/rte_distributor.c             |   18 +-
 lib/dmadev/rte_dmadev.c                       |   38 +-
 lib/dmadev/rte_dmadev_trace_points.c          |   14 +-
 lib/eal/arm/rte_cpuflags.c                    |    6 +-
 lib/eal/arm/rte_hypervisor.c                  |    2 +-
 lib/eal/arm/rte_power_intrinsics.c            |    8 +-
 lib/eal/common/eal_common_bus.c               |   20 +-
 lib/eal/common/eal_common_class.c             |    8 +-
 lib/eal/common/eal_common_config.c            |   14 +-
 lib/eal/common/eal_common_cpuflags.c          |    2 +-
 lib/eal/common/eal_common_debug.c             |    4 +-
 lib/eal/common/eal_common_dev.c               |   38 +-
 lib/eal/common/eal_common_devargs.c           |   18 +-
 lib/eal/common/eal_common_errno.c             |    4 +-
 lib/eal/common/eal_common_fbarray.c           |   52 +-
 lib/eal/common/eal_common_hexdump.c           |    4 +-
 lib/eal/common/eal_common_hypervisor.c        |    2 +-
 lib/eal/common/eal_common_interrupts.c        |   54 +-
 lib/eal/common/eal_common_launch.c            |   10 +-
 lib/eal/common/eal_common_lcore.c             |   34 +-
 lib/eal/common/eal_common_lcore_var.c         |    2 +-
 lib/eal/common/eal_common_mcfg.c              |   40 +-
 lib/eal/common/eal_common_memory.c            |   60 +-
 lib/eal/common/eal_common_memzone.c           |   18 +-
 lib/eal/common/eal_common_options.c           |    8 +-
 lib/eal/common/eal_common_proc.c              |   16 +-
 lib/eal/common/eal_common_string_fns.c        |    8 +-
 lib/eal/common/eal_common_tailqs.c            |    6 +-
 lib/eal/common/eal_common_thread.c            |   28 +-
 lib/eal/common/eal_common_timer.c             |    8 +-
 lib/eal/common/eal_common_trace.c             |   30 +-
 lib/eal/common/eal_common_trace_ctf.c         |    2 +-
 lib/eal/common/eal_common_trace_points.c      |   36 +-
 lib/eal/common/eal_common_trace_utils.c       |    2 +-
 lib/eal/common/eal_common_uuid.c              |    8 +-
 lib/eal/common/rte_bitset.c                   |    2 +-
 lib/eal/common/rte_keepalive.c                |   12 +-
 lib/eal/common/rte_malloc.c                   |   46 +-
 lib/eal/common/rte_random.c                   |    8 +-
 lib/eal/common/rte_reciprocal.c               |    4 +-
 lib/eal/common/rte_service.c                  |   62 +-
 lib/eal/common/rte_version.c                  |   14 +-
 lib/eal/freebsd/eal.c                         |   44 +-
 lib/eal/freebsd/eal_alarm.c                   |    4 +-
 lib/eal/freebsd/eal_dev.c                     |    8 +-
 lib/eal/freebsd/eal_interrupts.c              |   38 +-
 lib/eal/freebsd/eal_memory.c                  |    6 +-
 lib/eal/freebsd/eal_thread.c                  |    4 +-
 lib/eal/freebsd/eal_timer.c                   |    2 +-
 lib/eal/linux/eal.c                           |   14 +-
 lib/eal/linux/eal_alarm.c                     |    4 +-
 lib/eal/linux/eal_dev.c                       |    8 +-
 lib/eal/linux/eal_interrupts.c                |   38 +-
 lib/eal/linux/eal_memory.c                    |    6 +-
 lib/eal/linux/eal_thread.c                    |    4 +-
 lib/eal/linux/eal_timer.c                     |    8 +-
 lib/eal/linux/eal_vfio.c                      |   32 +-
 lib/eal/loongarch/rte_cpuflags.c              |    6 +-
 lib/eal/loongarch/rte_hypervisor.c            |    2 +-
 lib/eal/loongarch/rte_power_intrinsics.c      |    8 +-
 lib/eal/ppc/rte_cpuflags.c                    |    6 +-
 lib/eal/ppc/rte_hypervisor.c                  |    2 +-
 lib/eal/ppc/rte_power_intrinsics.c            |    8 +-
 lib/eal/riscv/rte_cpuflags.c                  |    6 +-
 lib/eal/riscv/rte_hypervisor.c                |    2 +-
 lib/eal/riscv/rte_power_intrinsics.c          |    8 +-
 lib/eal/unix/eal_debug.c                      |    4 +-
 lib/eal/unix/eal_filesystem.c                 |    2 +-
 lib/eal/unix/eal_firmware.c                   |    2 +-
 lib/eal/unix/eal_unix_memory.c                |    8 +-
 lib/eal/unix/eal_unix_timer.c                 |    2 +-
 lib/eal/unix/rte_thread.c                     |   26 +-
 lib/eal/windows/eal.c                         |   22 +-
 lib/eal/windows/eal_alarm.c                   |    4 +-
 lib/eal/windows/eal_debug.c                   |    2 +-
 lib/eal/windows/eal_dev.c                     |    8 +-
 lib/eal/windows/eal_interrupts.c              |   38 +-
 lib/eal/windows/eal_memory.c                  |   14 +-
 lib/eal/windows/eal_mp.c                      |   12 +-
 lib/eal/windows/eal_thread.c                  |    2 +-
 lib/eal/windows/eal_timer.c                   |    2 +-
 lib/eal/windows/rte_thread.c                  |   28 +-
 lib/eal/x86/rte_cpuflags.c                    |    6 +-
 lib/eal/x86/rte_hypervisor.c                  |    2 +-
 lib/eal/x86/rte_power_intrinsics.c            |    8 +-
 lib/eal/x86/rte_spinlock.c                    |    2 +-
 lib/efd/rte_efd.c                             |   14 +-
 lib/ethdev/ethdev_driver.c                    |   48 +-
 lib/ethdev/ethdev_linux_ethtool.c             |    6 +-
 lib/ethdev/ethdev_private.c                   |    4 +-
 lib/ethdev/ethdev_trace_points.c              |   12 +-
 lib/ethdev/rte_ethdev.c                       |  336 ++---
 lib/ethdev/rte_ethdev_cman.c                  |    8 +-
 lib/ethdev/rte_flow.c                         |  128 +-
 lib/ethdev/rte_mtr.c                          |   42 +-
 lib/ethdev/rte_tm.c                           |   62 +-
 lib/eventdev/eventdev_private.c               |    4 +-
 lib/eventdev/eventdev_trace_points.c          |   22 +-
 lib/eventdev/rte_event_crypto_adapter.c       |   30 +-
 lib/eventdev/rte_event_dma_adapter.c          |   30 +-
 lib/eventdev/rte_event_eth_rx_adapter.c       |   46 +-
 lib/eventdev/rte_event_eth_tx_adapter.c       |   34 +-
 lib/eventdev/rte_event_ring.c                 |    8 +-
 lib/eventdev/rte_event_timer_adapter.c        |   22 +-
 lib/eventdev/rte_event_vector_adapter.c       |   20 +-
 lib/eventdev/rte_eventdev.c                   |   94 +-
 lib/fib/rte_fib.c                             |   20 +-
 lib/fib/rte_fib6.c                            |   18 +-
 lib/gpudev/gpudev.c                           |   64 +-
 lib/graph/graph.c                             |   32 +-
 lib/graph/graph_debug.c                       |    2 +-
 lib/graph/graph_feature_arc.c                 |   34 +-
 lib/graph/graph_stats.c                       |    8 +-
 lib/graph/node.c                              |   24 +-
 lib/graph/rte_graph_model_mcore_dispatch.c    |    6 +-
 lib/graph/rte_graph_worker.c                  |    6 +-
 lib/gro/rte_gro.c                             |   12 +-
 lib/gso/rte_gso.c                             |    2 +-
 lib/hash/rte_cuckoo_hash.c                    |   54 +-
 lib/hash/rte_fbk_hash.c                       |    6 +-
 lib/hash/rte_hash_crc.c                       |    4 +-
 lib/hash/rte_thash.c                          |   24 +-
 lib/hash/rte_thash_gf2_poly_math.c            |    2 +-
 lib/hash/rte_thash_gfni.c                     |    4 +-
 lib/ip_frag/rte_ip_frag_common.c              |   10 +-
 lib/ip_frag/rte_ipv4_fragmentation.c          |    4 +-
 lib/ip_frag/rte_ipv4_reassembly.c             |    2 +-
 lib/ip_frag/rte_ipv6_fragmentation.c          |    2 +-
 lib/ip_frag/rte_ipv6_reassembly.c             |    2 +-
 lib/ipsec/ipsec_sad.c                         |   12 +-
 lib/ipsec/ipsec_telemetry.c                   |    4 +-
 lib/ipsec/sa.c                                |    8 +-
 lib/ipsec/ses.c                               |    2 +-
 lib/jobstats/rte_jobstats.c                   |   28 +-
 lib/kvargs/rte_kvargs.c                       |   16 +-
 lib/latencystats/rte_latencystats.c           |   10 +-
 lib/log/log.c                                 |   44 +-
 lib/log/log_color.c                           |    2 +-
 lib/log/log_syslog.c                          |    2 +-
 lib/log/log_timestamp.c                       |    2 +-
 lib/lpm/rte_lpm.c                             |   16 +-
 lib/lpm/rte_lpm6.c                            |   20 +-
 lib/mbuf/rte_mbuf.c                           |   34 +-
 lib/mbuf/rte_mbuf_dyn.c                       |   18 +-
 lib/mbuf/rte_mbuf_pool_ops.c                  |   10 +-
 lib/mbuf/rte_mbuf_ptype.c                     |   16 +-
 lib/member/rte_member.c                       |   26 +-
 lib/mempool/mempool_trace_points.c            |   20 +-
 lib/mempool/rte_mempool.c                     |   54 +-
 lib/mempool/rte_mempool_ops.c                 |    8 +-
 lib/mempool/rte_mempool_ops_default.c         |    8 +-
 lib/meter/rte_meter.c                         |   12 +-
 lib/metrics/rte_metrics.c                     |   16 +-
 lib/metrics/rte_metrics_telemetry.c           |   22 +-
 lib/mldev/mldev_utils.c                       |    4 +-
 lib/mldev/mldev_utils_neon.c                  |   36 +-
 lib/mldev/mldev_utils_neon_bfloat16.c         |    4 +-
 lib/mldev/mldev_utils_scalar.c                |   36 +-
 lib/mldev/mldev_utils_scalar_bfloat16.c       |    4 +-
 lib/mldev/rte_mldev.c                         |   74 +-
 lib/mldev/rte_mldev_pmd.c                     |    4 +-
 lib/net/rte_arp.c                             |    2 +-
 lib/net/rte_ether.c                           |    6 +-
 lib/net/rte_net.c                             |    4 +-
 lib/net/rte_net_crc.c                         |    6 +-
 lib/node/ethdev_ctrl.c                        |    4 +-
 lib/node/ip4_lookup.c                         |    2 +-
 lib/node/ip4_lookup_fib.c                     |    4 +-
 lib/node/ip4_reassembly.c                     |    2 +-
 lib/node/ip4_rewrite.c                        |    2 +-
 lib/node/ip6_lookup.c                         |    2 +-
 lib/node/ip6_lookup_fib.c                     |    4 +-
 lib/node/ip6_rewrite.c                        |    2 +-
 lib/node/udp4_input.c                         |    4 +-
 lib/pcapng/rte_pcapng.c                       |   14 +-
 lib/pci/rte_pci.c                             |    6 +-
 lib/pdcp/rte_pdcp.c                           |   10 +-
 lib/pdump/rte_pdump.c                         |   18 +-
 lib/pipeline/rte_pipeline.c                   |   46 +-
 lib/pipeline/rte_port_in_action.c             |   16 +-
 lib/pipeline/rte_swx_ctl.c                    |   34 +-
 lib/pipeline/rte_swx_ipsec.c                  |   14 +-
 lib/pipeline/rte_swx_pipeline.c               |  146 +--
 lib/pipeline/rte_table_action.c               |   32 +-
 lib/pmu/pmu.c                                 |   10 +-
 lib/port/rte_port_ethdev.c                    |    6 +-
 lib/port/rte_port_eventdev.c                  |    6 +-
 lib/port/rte_port_fd.c                        |    6 +-
 lib/port/rte_port_frag.c                      |    4 +-
 lib/port/rte_port_ras.c                       |    4 +-
 lib/port/rte_port_ring.c                      |   12 +-
 lib/port/rte_port_sched.c                     |    4 +-
 lib/port/rte_port_source_sink.c               |    4 +-
 lib/port/rte_port_sym_crypto.c                |    6 +-
 lib/port/rte_swx_port_ethdev.c                |    4 +-
 lib/port/rte_swx_port_fd.c                    |    4 +-
 lib/port/rte_swx_port_ring.c                  |    4 +-
 lib/port/rte_swx_port_source_sink.c           |    6 +-
 lib/power/power_common.c                      |   16 +-
 lib/power/rte_power_cpufreq.c                 |   36 +-
 lib/power/rte_power_pmd_mgmt.c                |   20 +-
 lib/power/rte_power_qos.c                     |    4 +-
 lib/power/rte_power_uncore.c                  |   28 +-
 lib/rawdev/rte_rawdev.c                       |   60 +-
 lib/rcu/rte_rcu_qsbr.c                        |   22 +-
 lib/regexdev/rte_regexdev.c                   |   52 +-
 lib/reorder/rte_reorder.c                     |   22 +-
 lib/rib/rte_rib.c                             |   28 +-
 lib/rib/rte_rib6.c                            |   28 +-
 lib/ring/rte_ring.c                           |   22 +-
 lib/ring/rte_soring.c                         |    6 +-
 lib/ring/soring.c                             |   32 +-
 lib/sched/rte_approx.c                        |    2 +-
 lib/sched/rte_pie.c                           |    4 +-
 lib/sched/rte_red.c                           |   12 +-
 lib/sched/rte_sched.c                         |   30 +-
 lib/security/rte_security.c                   |   40 +-
 lib/stack/rte_stack.c                         |    6 +-
 lib/table/rte_swx_table_em.c                  |    4 +-
 lib/table/rte_swx_table_learner.c             |   20 +-
 lib/table/rte_swx_table_selector.c            |   12 +-
 lib/table/rte_swx_table_wm.c                  |    2 +-
 lib/table/rte_table_acl.c                     |    2 +-
 lib/table/rte_table_array.c                   |    2 +-
 lib/table/rte_table_hash_cuckoo.c             |    2 +-
 lib/table/rte_table_hash_ext.c                |    2 +-
 lib/table/rte_table_hash_key16.c              |    4 +-
 lib/table/rte_table_hash_key32.c              |    4 +-
 lib/table/rte_table_hash_key8.c               |    4 +-
 lib/table/rte_table_hash_lru.c                |    2 +-
 lib/table/rte_table_lpm.c                     |    2 +-
 lib/table/rte_table_lpm_ipv6.c                |    2 +-
 lib/table/rte_table_stub.c                    |    2 +-
 lib/telemetry/telemetry.c                     |    6 +-
 lib/telemetry/telemetry_data.c                |   34 +-
 lib/telemetry/telemetry_legacy.c              |    2 +-
 lib/timer/rte_timer.c                         |   36 +-
 lib/vhost/socket.c                            |   32 +-
 lib/vhost/vdpa.c                              |   22 +-
 lib/vhost/vhost.c                             |   82 +-
 lib/vhost/vhost_crypto.c                      |   12 +-
 lib/vhost/vhost_user.c                        |    4 +-
 lib/vhost/virtio_net.c                        |   14 +-
 397 files changed, 4171 insertions(+), 4171 deletions(-)

-- 
2.17.1

