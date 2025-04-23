Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB315C369CB
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 12:10:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F6F1402EA;
	Wed, 23 Apr 2025 14:10:48 +0200 (CEST)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id 931C84029D;
 Wed, 23 Apr 2025 14:10:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2F777400D5
 for <announce@dpdk.org>; Wed, 23 Apr 2025 14:10:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745410244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C2qQJNdC55eQItfcGzEHafHGwB/IaDHYqjt09fKe4fM=;
 b=CcJ8DJwVfL35cPFcySvsDgyhT0T4caPYyDFvHXbDZJGh6CpmzWF1BHcyL1wNlm/wUxNR7J
 VkSn49PNFcUV7AS3fPGchpU/nBU74DLyU0dzrAH8UrNi/opnhVdSdnxYxqJgI62oIXM+oU
 N9i7mGUDt6pLFBAM0qRi0qb0Sd1sNHo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-HA_s3yaRO5O6NwYXkj6IYA-1; Wed,
 23 Apr 2025 08:10:42 -0400
X-MC-Unique: HA_s3yaRO5O6NwYXkj6IYA-1
X-Mimecast-MFC-AGG-ID: HA_s3yaRO5O6NwYXkj6IYA_1745410242
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D05D21956094
 for <announce@dpdk.org>; Wed, 23 Apr 2025 12:10:41 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.45.224.63])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CDD6718002AC
 for <announce@dpdk.org>; Wed, 23 Apr 2025 12:10:40 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: announce@dpdk.org
Subject: DPDK 24.11.2 released
Date: Wed, 23 Apr 2025 13:10:34 +0100
Message-ID: <20250423121038.191851-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j_LyGLqPo_391nsVyJv8RB8QiX78xJBbzWOF8rUOOew_1745410242
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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
	https://fast.dpdk.org/rel/dpdk-24.11.2.tar.xz

The git tree is at:
	https://dpdk.org/browse/dpdk-stable/?h=24.11

This LTS release contains ~200 fixes from main branch
up to DPDK 25.03.

Thanks to the authors who helped with backports and to the
following who helped with validation: Red Hat, Nvidia, and Intel.

Kevin

---
 .github/workflows/build.yml                        |  42 +-
 .mailmap                                           |  21 +-
 VERSION                                            |   2 +-
 app/test-bbdev/test_vectors/fft_9.data             | 870 ---------------------
 app/test-bbdev/test_vectors/fft_byp_28.data        |  48 +-
 app/test-pmd/cmdline.c                             |  73 +-
 app/test-pmd/cmdline_flow.c                        |   3 +-
 app/test-pmd/config.c                              |   4 +-
 app/test/test_cryptodev.c                          |  29 +-
 app/test/test_cryptodev.h                          |   1 -
 app/test/test_cryptodev_aes_test_vectors.h         |   6 +-
 app/test/test_dmadev_api.c                         |  16 +-
 app/test/test_event_eth_rx_adapter.c               |   2 +-
 app/test/test_link_bonding.c                       |  69 +-
 app/test/test_ring_stress_impl.h                   |   2 +-
 buildtools/get-numa-count.py                       |   2 +-
 buildtools/get-test-suites.py                      |   4 +-
 config/meson.build                                 |  11 +-
 devtools/check-meson.py                            |   2 +-
 doc/guides/contributing/stable.rst                 |   2 +-
 doc/guides/cryptodevs/ionic.rst                    |  12 +-
 doc/guides/nics/e1000em.rst                        |   5 +
 doc/guides/nics/features.rst                       |   1 +
 doc/guides/nics/features/gve.ini                   |   1 +
 doc/guides/nics/features/mana.ini                  |   1 -
 doc/guides/nics/features/netvsc.ini                |   1 -
 doc/guides/nics/features/virtio.ini                |   1 -
 doc/guides/nics/features/vmxnet3.ini               |   1 -
 doc/guides/nics/igb.rst                            |  13 +
 doc/guides/nics/igc.rst                            |   5 +
 doc/guides/nics/ionic.rst                          |  16 +-
 doc/guides/nics/ixgbe.rst                          |  22 +-
 doc/guides/nics/mlx5.rst                           |   9 +
 doc/guides/rel_notes/release_24_11.rst             | 421 +++++++++-
 doc/guides/tools/devbind.rst                       |   5 +
 drivers/baseband/acc/rte_vrb_pmd.c                 |   2 +
 drivers/bus/pci/pci_common.c                       |  14 +-
 drivers/common/cnxk/cnxk_security.c                |   2 +-
 drivers/common/cnxk/roc_bphy_cgx.c                 |  12 +-
 drivers/common/cnxk/roc_dpi_priv.h                 |   2 +-
 drivers/common/cnxk/roc_npa.h                      |   2 +-
 drivers/common/idpf/idpf_common_rxtx_avx512.c      |  12 +-
 drivers/common/idpf/meson.build                    |   3 +
 drivers/common/mlx5/linux/mlx5_common_os.c         |  52 ++
 drivers/common/mlx5/mlx5_common.h                  |   4 +
 drivers/common/mlx5/version.map                    |   1 +
 drivers/common/mlx5/windows/mlx5_common_os.c       |  31 +
 drivers/common/qat/qat_device.c                    |   1 +
 drivers/crypto/cnxk/cn9k_cryptodev_ops.c           |   2 +
 drivers/crypto/cnxk/cnxk_se.h                      |   2 +-
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c        |   8 +-
 drivers/crypto/dpaa_sec/dpaa_sec.c                 |   7 +-
 drivers/crypto/openssl/rte_openssl_pmd.c           |  13 +-
 drivers/crypto/qat/qat_sym_session.c               |   3 +-
 drivers/crypto/virtio/virtio_cryptodev.c           |  14 +-
 drivers/crypto/virtio/virtio_rxtx.c                |   3 +-
 drivers/dma/idxd/idxd_pci.c                        |   4 +
 drivers/event/dlb2/dlb2_sse.c                      |  11 +-
 drivers/event/dpaa/dpaa_eventdev.c                 |  10 +-
 drivers/net/af_packet/rte_eth_af_packet.c          |  30 +-
 drivers/net/bnxt/bnxt_ethdev.c                     |  22 +-
 drivers/net/bnxt/bnxt_ring.h                       |  19 +
 drivers/net/bnxt/bnxt_rxq.c                        |   1 +
 drivers/net/bnxt/bnxt_rxq.h                        |   1 +
 drivers/net/bnxt/bnxt_rxr.c                        |  20 +-
 drivers/net/bnxt/bnxt_rxtx_vec_common.h            |  11 +-
 .../bnxt/hcapi/cfa_v3/bld/p70/cfa_bld_p70_mpc.c    |  90 +--
 .../bld/p70/host/cfa_bld_p70_host_mpc_wrapper.c    | 150 ++--
 drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c          |   6 +-
 drivers/net/bnxt/tf_core/tf_sram_mgr.c             |   4 +-
 drivers/net/bnxt/tf_core/v3/tfc_em.c               |   1 +
 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c        |   2 +-
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c               |   1 +
 drivers/net/bonding/rte_eth_bond_8023ad.h          |   3 +
 drivers/net/bonding/rte_eth_bond_pmd.c             |  25 +-
 drivers/net/cnxk/cn10k_tx.h                        |   7 +-
 drivers/net/cnxk/cn20k_tx.h                        |   7 +-
 drivers/net/cnxk/cn9k_tx.h                         |   7 +-
 drivers/net/cpfl/cpfl_ethdev.c                     |   2 +-
 drivers/net/dpaa/dpaa_rxtx.c                       |   7 +-
 drivers/net/dpaa2/dpaa2_rxtx.c                     |   6 +-
 drivers/net/e1000/base/e1000_80003es2lan.c         |   2 +-
 drivers/net/e1000/base/e1000_82575.c               |   5 +-
 drivers/net/e1000/base/e1000_base.c                |   3 +-
 drivers/net/e1000/base/e1000_defines.h             |   1 +
 drivers/net/e1000/base/e1000_ich8lan.c             |   2 +
 drivers/net/e1000/base/e1000_mac.c                 |  12 +-
 drivers/net/e1000/base/e1000_nvm.c                 |   4 +-
 drivers/net/e1000/base/e1000_phy.c                 |  25 +-
 drivers/net/e1000/base/e1000_vf.c                  |  12 +-
 drivers/net/e1000/em_ethdev.c                      |  80 ++
 drivers/net/e1000/igb_ethdev.c                     | 176 +++++
 drivers/net/ena/ena_ethdev.c                       |   1 +
 drivers/net/enetfec/enet_ethdev.c                  |   1 -
 drivers/net/gve/gve_ethdev.c                       | 110 ++-
 drivers/net/gve/gve_ethdev.h                       |   5 +-
 drivers/net/gve/gve_rx.c                           |   2 +-
 drivers/net/hinic/hinic_pmd_flow.c                 |  14 +-
 drivers/net/hns3/hns3_cmd.c                        |  18 +-
 drivers/net/hns3/hns3_cmd.h                        |   4 +-
 drivers/net/hns3/hns3_dump.c                       |   4 +
 drivers/net/hns3/hns3_ethdev.c                     |  29 +-
 drivers/net/hns3/hns3_intr.c                       |   4 +-
 drivers/net/hns3/hns3_intr.h                       |   2 +-
 drivers/net/hns3/hns3_rxtx.c                       |   2 +-
 drivers/net/i40e/i40e_rxtx_vec_avx2.c              |   2 +-
 drivers/net/i40e/i40e_rxtx_vec_avx512.c            |   2 +-
 drivers/net/i40e/meson.build                       |   3 +
 drivers/net/iavf/iavf_ethdev.c                     |  15 +-
 drivers/net/iavf/iavf_rxtx.c                       |   9 +-
 drivers/net/iavf/iavf_rxtx.h                       |   2 +
 drivers/net/iavf/iavf_rxtx_vec_avx2.c              |   2 +-
 drivers/net/iavf/iavf_rxtx_vec_neon.c              |   8 +-
 drivers/net/iavf/meson.build                       |   3 +
 drivers/net/ice/ice_ethdev.c                       |   4 +
 drivers/net/ice/ice_generic_flow.c                 |  41 +-
 drivers/net/ice/ice_rxtx.c                         |  10 +
 drivers/net/ice/ice_rxtx_vec_avx2.c                |   2 +-
 drivers/net/ice/meson.build                        |   3 +
 drivers/net/igc/base/igc_defines.h                 |   1 +
 drivers/net/igc/base/igc_i225.c                    |  24 +-
 drivers/net/igc/base/igc_mac.c                     |  10 +-
 drivers/net/igc/base/igc_nvm.c                     |   4 +-
 drivers/net/igc/base/igc_phy.c                     |   8 +-
 drivers/net/igc/igc_ethdev.c                       |  97 +++
 drivers/net/ixgbe/base/ixgbe_api.c                 |   5 +-
 drivers/net/ixgbe/base/ixgbe_e610.c                |  38 +-
 drivers/net/ixgbe/base/ixgbe_type.h                |   2 +-
 drivers/net/ixgbe/ixgbe_ethdev.c                   | 244 ++++++
 drivers/net/ixgbe/ixgbe_fdir.c                     |   3 +-
 drivers/net/ixgbe/ixgbe_flow.c                     |   3 +-
 drivers/net/ixgbe/ixgbe_rxtx.c                     |   4 +
 drivers/net/ixgbe/ixgbe_rxtx.h                     |   2 +-
 drivers/net/mana/mana.c                            | 103 +--
 drivers/net/mana/mana.h                            |   6 +-
 drivers/net/mana/mp.c                              |   2 +-
 drivers/net/mana/rx.c                              |  30 +-
 drivers/net/mlx5/hws/mlx5dr_action.c               |  65 +-
 drivers/net/mlx5/hws/mlx5dr_definer.c              |  30 +-
 drivers/net/mlx5/hws/mlx5dr_definer.h              |  18 +-
 drivers/net/mlx5/linux/mlx5_os.c                   |   5 +
 drivers/net/mlx5/mlx5.c                            |  37 +-
 drivers/net/mlx5/mlx5.h                            |   3 +-
 drivers/net/mlx5/mlx5_flow.c                       |  37 +-
 drivers/net/mlx5/mlx5_flow.h                       |  24 +-
 drivers/net/mlx5/mlx5_flow_dv.c                    | 108 ++-
 drivers/net/mlx5/mlx5_flow_geneve.c                |  52 +-
 drivers/net/mlx5/mlx5_flow_hw.c                    | 363 +++++----
 drivers/net/mlx5/mlx5_hws_cnt.c                    |   3 +-
 drivers/net/mlx5/mlx5_nta_split.c                  |  28 +-
 drivers/net/mlx5/mlx5_rx.h                         |   1 +
 drivers/net/mlx5/mlx5_rxq.c                        |  12 +-
 drivers/net/mlx5/mlx5_rxtx.c                       |  80 ++
 drivers/net/mlx5/mlx5_rxtx_vec.c                   |   3 +
 drivers/net/mlx5/mlx5_trigger.c                    |   4 +-
 drivers/net/netvsc/hn_ethdev.c                     |  29 +-
 drivers/net/netvsc/hn_vf.c                         |  13 +-
 drivers/net/nfp/flower/nfp_conntrack.c             |   6 +-
 drivers/net/nfp/flower/nfp_flower.c                |   2 -
 drivers/net/nfp/flower/nfp_flower_ctrl.c           |  14 +
 drivers/net/nfp/flower/nfp_flower_representor.c    |  37 +-
 drivers/net/nfp/flower/nfp_flower_representor.h    |   3 +
 drivers/net/nfp/nfp_ethdev.c                       |  59 +-
 drivers/net/nfp/nfp_net_common.c                   |  11 +-
 drivers/net/ngbe/base/ngbe_hw.c                    |   8 +-
 drivers/net/octeon_ep/otx_ep_mbox.c                |   3 -
 drivers/net/qede/base/ecore_dcbx.c                 |   8 +-
 drivers/net/qede/qede_debug.c                      |   5 +
 drivers/net/sfc/sfc_repr.c                         |   4 -
 drivers/net/thunderx/base/nicvf_mbox.c             |  42 +-
 drivers/net/txgbe/base/txgbe_phy.c                 |   8 +-
 drivers/raw/cnxk_gpio/cnxk_gpio_selftest.c         |  24 +-
 dts/framework/remote_session/testpmd_shell.py      |   5 +-
 dts/framework/test_result.py                       |  11 +-
 .../testbed_model/traffic_generator/scapy.py       |   2 +-
 dts/tests/TestSuite_smoke_tests.py                 |   4 +-
 .../flow_filtering/snippets/snippet_match_ipv4.c   |  10 +-
 .../flow_filtering/snippets/snippet_match_ipv4.h   |   1 -
 .../flow_filtering/snippets/snippet_match_mpls.c   |   2 +-
 examples/ipsec-secgw/event_helper.c                |   2 +-
 examples/ipsec-secgw/sa.c                          |   4 +-
 examples/l3fwd-power/main.c                        |   4 +-
 examples/l3fwd/main.c                              |   5 +-
 examples/ptpclient/ptpclient.c                     |   2 +-
 examples/vhost_crypto/main.c                       |   4 +-
 lib/cryptodev/rte_cryptodev.h                      |  12 +-
 lib/eal/common/eal_common_devargs.c                |   2 +-
 lib/eal/common/eal_common_lcore.c                  |  17 +-
 lib/eal/common/eal_private.h                       |   6 +
 lib/eal/common/rte_random.c                        |  12 +-
 lib/eal/common/rte_service.c                       |   4 +-
 lib/eal/freebsd/eal.c                              |   2 +
 lib/eal/linux/eal.c                                |   2 +
 lib/eal/linux/eal_dev.c                            |   3 -
 lib/eal/linux/eal_memory.c                         |   1 +
 lib/eal/windows/eal.c                              |   2 +
 lib/eal/x86/include/rte_vect.h                     |   2 -
 lib/eal/x86/rte_power_intrinsics.c                 |  15 +-
 lib/ethdev/rte_ethdev.c                            |  16 +-
 lib/eventdev/rte_event_dma_adapter.c               |   6 +-
 lib/gro/rte_gro.c                                  |   2 +-
 lib/log/log.c                                      |  14 +-
 lib/log/log_journal.c                              |   4 +-
 lib/mempool/rte_mempool.c                          |   4 +-
 lib/pdump/rte_pdump.c                              |   3 +
 lib/power/rte_power_pmd_mgmt.c                     |  27 +-
 lib/ptr_compress/rte_ptr_compress.h                |   4 +-
 lib/stack/rte_stack_lf_c11.h                       |   2 +-
 lib/vhost/fd_man.c                                 |  12 +-
 lib/vhost/fd_man.h                                 |   2 +-
 lib/vhost/socket.c                                 |  28 +-
 lib/vhost/vduse.c                                  |  12 +-
 lib/vhost/vhost.c                                  |   5 +-
 lib/vhost/vhost_crypto.c                           |  25 +-
 lib/vhost/vhost_user.c                             |   4 +-
 lib/vhost/virtio_net.c                             |  15 +
 usertools/dpdk-devbind.py                          |   7 +-
 217 files changed, 3061 insertions(+), 1986 deletions(-)
Ajit Khaparde (2):
      net/bnxt: fix Rx handler
      net/bnxt: fix epoch bit calculation

Aleksandr Loktionov (2):
      net/igc/base: fix MAC address hash bit shift
      net/e1000/base: fix MAC address hash bit shift

Alex Vesker (1):
      net/mlx5/hws: fix DV FT type convert

Alexander Kozyrev (1):
      net/mlx5/hws: fix fragmented packet type matching

Amir Avivi (2):
      net/igc/base: fix iterator type
      net/e1000/base: fix iterator type

Anatoly Burakov (5):
      net/e1000/base: correct mPHY access logic
      net/e1000: fix crashes in secondary processes
      net/ixgbe: fix crashes in secondary processes
      doc: add no-IOMMU mode in devbind tool guide
      net/ixgbe: fix VF registers for E610

Andre Muezerie (6):
      eal/x86: fix some intrinsics header include for Windows
      eventdev: fix format string data type in log messages
      net/bnxt: fix indication of allocation
      common/idpf: fix void function returning a value
      net/intel: fix void functions returning a value
      stack: fix pop in C11 implementation

Andrew Boyer (1):
      doc: update ionic driver guide

Ariel Otilibili (8):
      examples/flow_filtering: remove duplicate assignment
      net/sfc: remove unnecessary assignment
      net/octeon_ep: remove useless assignment
      net/enetfec: remove useless assignment
      buildtools: fix some Python regex syntax warnings
      use Python raw string notation
      eal/linux: remove useless assignments
      mempool: fix errno in empty create

Arkadiusz Kusztal (3):
      test/crypto: fix check for OOP header data
      crypto/qat: fix SM3 state size
      common/qat: fix devargs parsing

Barbara Skobiej (3):
      net/igc/base: fix data type in MAC hash
      net/e1000/base: fix data type in MAC hash
      net/e1000/base: fix reset for 82580

Bing Zhao (3):
      net/mlx5: fix leak of flow action data list
      net/mlx5: fix unneeded stub flow table allocation
      net/mlx5: fix flow group ID for action translation

Bruce Richardson (9):
      net/iavf: remove reset of Tx prepare function pointer
      net/intel: fix build with icx
      event/dlb2: fix event weight handling in SSE code path
      test/dma: fix pointers in IOVA as PA mode
      net/iavf: check interrupt registration failure
      net/iavf: fix crash on app exit on FreeBSD
      eal: fix undetected NUMA nodes
      net/ixgbe: add checks for E610 VF
      dma/idxd: add device ids for new HW versions

Carolyn Wyborny (1):
      net/e1000/base: skip management check for 82575

Chaoyong He (2):
      net/nfp: fix firmware load from flash
      net/nfp: fix init failure handling

Chengwen Feng (2):
      app/testpmd: show all DCB priority TC map
      app/testpmd: avoid crash in DCB config

Dan Nowlin (1):
      net/ixgbe/base: add missing buffer copy for ACI

Dariusz Sosnowski (1):
      net/mlx5: fix NAT64 register selection

David Marchand (7):
      random: defer seeding to EAL init
      power: defer lcore variable allocation
      eal/x86: defer power intrinsics variable allocation
      ci: build with MSVC in GHA
      net/mlx5: fix leak in HWS flow counter action
      ci: point at GitHub mirror
      ci: fix ccache for Ubuntu 22.04

Dean Marx (1):
      dts: fix pass rate edge case in results

Dengdui Huang (3):
      net/hns3: fix mbuf freeing in simple Tx path
      net/hns3: fix copper port initialization
      net/hns3: fix reset timeout

Dima Ruinskiy (5):
      net/igc/base: fix deadlock when writing i225 register
      net/igc/base: fix infinite loop
      net/igc/base: fix typo in LTR calculation
      net/igc/base: fix unused value
      net/e1000/base: fix unchecked return

Gavin Hu (1):
      net/mlx5: fix polling CQEs

Gowrishankar Muthukrishnan (5):
      crypto/virtio: fix data queues iteration
      vhost/crypto: skip fetch before vring init
      examples/vhost_crypto: fix user callbacks
      crypto/cnxk: fix asymmetric operation status code
      crypto/openssl: validate incorrect RSA signature

Gregory Etelson (2):
      net/mlx5: fix IPIP tunnel verification
      net/mlx5: fix mark action validation in FDB mode

Huisong Li (1):
      ethdev: fix functions available in new device event

Jakub Buchocki (1):
      net/e1000/base: fix uninitialized variable

Jianping Zhao (1):
      vhost: clear ring addresses when getting vring base

Jie Hai (2):
      net/hns3: remove PVID info dump for VF
      net/hns3: rename RAS module

Junfeng Guo (1):
      net/mlx5: fix actions translation error overwrite

Kevin Traynor (5):
      vhost: add null callback checks
      net/mlx5: fix crash with null flow list creation
      doc: fix year of final LTS release
      version: 24.11.2-rc1
      version: 24.11.2

Konstantin Ananyev (2):
      test/ring: fix init with custom number of lcores
      gro: fix unprocessed IPv4 packets

Lingli Chen (1):
      doc: add two more tested Intel NICs in 24.11

Long Li (3):
      net/netvsc: scan all net devices under the PCI device
      net/netvsc: remove device if its net devices removed
      net/mana: fix multi-process tracking

Long Wu (3):
      net/nfp: fix VF link speed
      net/bonding: fix dedicated queue setup
      net/nfp: fix representor port statistics

Luca Vizzarro (2):
      dts: fix MTU set command
      dts: fix smoke tests docstring

Lukasz Krakowiak (1):
      net/ixgbe/base: fix TSAM checking return value

Maayan Kashani (14):
      net/mlx5: adjust actions per rule limitation
      net/mlx5: fix crash in non-template metadata split
      net/mlx5: fix flush of non-template flow rules
      net/mlx5: fix GRE flow match with SWS
      net/mlx5: fix hairpin queue release
      net/mlx5: fix LACP packet handling in isolated mode
      net/mlx5/hws: fix crash using represented port without ID
      net/mlx5: fix non-template set VLAN VID
      net/mlx5: fix error info in actions construct
      net/mlx5/hws: fix GTP flags matching
      net/mlx5: fix non-template flow validation
      net/mlx5: fix non-template flow validation on create
      net/mlx5: fix flow matching GENEVE options
      net/mlx5: fix GRE matching on root table

Matthew Smith (1):
      net/ice: fix dropped packets when using VRRP

Maxime Coquelin (3):
      vhost: fix log when setting max queue num
      vhost: reset packets count when not ready
      vhost: fix FD entries cleanup

Michael Baum (2):
      common/mlx5: add device duplication function
      net/mlx5: fix GENEVE parser cleanup

Minggang Li (Gavin) (3):
      net/mlx5: fix Netlink socket leak
      doc: add VXLAN matching requirement in mlx5 guide
      app/testpmd: use VXLAN flow flags from user if set

Mingjin Ye (1):
      net/ixgbe: fix minimum Rx/Tx descriptors

Nawal Kishor (1):
      common/cnxk: fix atomic load in batch ops

Nicolas Chautru (2):
      test/bbdev: update FFT test vectors
      baseband/acc: fix queue setup failure clean up

Nithin Dabilpuram (2):
      ptr_compress: fix build with Arm SVE
      common/cnxk: fix inbound IPsec SA setup

Nithinsen Kaithakadan (1):
      examples/ipsec-secgw: fix IV length in CTR 192/256

Pawel Malinowski (2):
      net/igc/base: fix semaphore timeout value
      net/e1000/base: fix semaphore timeout value

Peng Zhang (1):
      net/nfp: fix multi-PF control flag

Peter Spreadborough (4):
      net/bnxt: fix dead code
      net/bnxt: fix overflow
      net/bnxt: fix overflow
      net/bnxt: address uninitialized variables

Piotr Krzewinski (1):
      service: fix getting service lcore attributes

Piotr Kwapulinski (2):
      net/ixgbe/base: remove 2.5/5G from auto-negotiation for E610
      net/ixgbe/base: fix driver hang in VM

Praveen Kaligineedi (1):
      net/gve: allocate Rx QPL pages using malloc

Przemyslaw Ciesielski (4):
      net/igc/base: fix bitwise operation type
      net/igc/base: fix NVM data type in bit shift
      net/e1000/base: fix bitwise operation type
      net/e1000/base: fix NVM data type in bit shift

Rahul Bhansali (1):
      net/cnxk: fix NIX send header L3 type

Rajesh Mudimadugula (1):
      crypto/virtio: fix redundant queue free

Raslan Darawsheh (1):
      doc: add tested platforms with NVIDIA NICs in 24.11

Robin Jarry (1):
      log: fix double free on cleanup

Sangtani Parag Satishbhai (1):
      net/bnxt: fix crash when representor is re-attached

Sasha Neftin (3):
      net/igc/base: increase PHY power up delay
      net/igc/base: reset loop variable
      net/igc/base: fix LTR for i225

Shai Brandes (1):
      net/ena: fix missing default LLQ policy

Shani Peretz (2):
      bus/pci: fix registered device name
      examples/flow_filtering: fix IPv4 matching snippet

Shaokai Zhang (2):
      test/crypto: fix AES-ECB test lengths
      test/crypto: remove unused variable

Shijith Thotton (1):
      test/event: fix number of queues in eventdev conf

Stephen Hemminger (23):
      crypto/cnxk: fix build with GCC 15
      net/thunderx/base: fix build with GCC 15
      examples/flow_filtering: fix build with GCC 15
      test/bonding: fix active backup receive test
      log: fix systemd journal socket open
      build: force GCC 15 to initialize padding bits
      net/cpfl: fix representor parsing log
      raw/cnxk_gpio: fix file descriptor leak
      eal: fix devargs layers parsing out of bounds
      net/qede: fix debug messages array
      examples/ptpclient: fix message parsing
      net/hinic: fix flow type bitmask overflow
      crypto/dpaa2_sec: fix bitmask truncation
      crypto/dpaa_sec: fix bitmask truncation
      event/dpaa: fix bitmask truncation
      net/dpaa: fix bitmask truncation
      net/dpaa2: fix bitmask truncation
      net/qede: fix nested loops
      examples/l3fwd: fix socket ID check
      common/cnxk: fix null check
      doc: fix feature flags for queue start/stop
      app/testpmd: fix out-of-bound reference in offload config
      pdump: clear statistics when enabled

Tejasree Kondoj (1):
      examples/ipsec-secgw: fix cryptodev and eventdev IDs

Thierry Herbelot (1):
      ethdev: fix registers info request

Thomas Monjalon (1):
      cryptodev: fix C++ include

Tudor Cornea (1):
      net/af_packet: fix socket close on device stop

Vamsi Attunuru (1):
      common/cnxk: fix DPI mailbox structure

Viacheslav Ovsiienko (1):
      net/mlx5: fix hardware packet type translation

Vladimir Medvedkin (4):
      net/ixgbe: fix E610 support in flow engine
      net/ice: fix memory leak in scalar Rx
      net/ice: fix flows handling
      net/ice: fix flow engines order

Wathsala Vithanage (1):
      crypto/openssl: fix CMAC auth context update

Wei Hu (1):
      net/mana: do not ring short doorbell for every mbuf alloc

Yang Ming (2):
      eal/linux: fix memseg length in legacy mem init
      net/iavf: fix mbuf release in Arm multi-process

Yunjian Wang (2):
      vhost: check GSO size validity
      vhost: check descriptor chains length

Zaiyu Wang (2):
      net/ngbe: fix WOL and NCSI capabilities
      net/txgbe: remove useless condition for SW-FW sync

Zerun Fu (2):
      net/nfp: fix multiple PFs check from NSP
      net/nfp: fix misuse of function return values

