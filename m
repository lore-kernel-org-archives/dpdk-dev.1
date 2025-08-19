Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27D1CA0EED
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 08:52:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 124A74064E;
	Tue, 19 Aug 2025 10:52:33 +0200 (CEST)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id 6A18A40289;
 Tue, 19 Aug 2025 10:52:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id EEDE740262
 for <announce@dpdk.org>; Tue, 19 Aug 2025 10:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755593550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=52SFJsl8r9iHvEaGzUxXR/SLf+LjhRin3qFvrn5sFi0=;
 b=LhwStGC8kds8YxmXm+w6O/tQo5Vftr+bhavzWRAz4FsedDnxg280VzMzaIiPDCyDondwrT
 y1dhgLY2gYstz/FniFLpunkLVLcICPTYFVmRLuc7ypAo+JfOGMKObn6gb1Vdh7Tshv5wU9
 Z+SC7XWxgg2Kpty69Vi7DKaikkC9fSk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-X1csub7JMeaetpH_eRBOVw-1; Tue,
 19 Aug 2025 04:52:28 -0400
X-MC-Unique: X1csub7JMeaetpH_eRBOVw-1
X-Mimecast-MFC-AGG-ID: X1csub7JMeaetpH_eRBOVw_1755593548
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 092C6180028C
 for <announce@dpdk.org>; Tue, 19 Aug 2025 08:52:28 +0000 (UTC)
Received: from rh.Home (unknown [10.44.32.42])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B825018003FC
 for <announce@dpdk.org>; Tue, 19 Aug 2025 08:52:26 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: announce@dpdk.org
Subject: DPDK 24.11.3 released
Date: Tue, 19 Aug 2025 09:52:23 +0100
Message-ID: <20250819085224.107237-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uLgkiKw2MKDhBpv9emQ2JYIFBVB2c6ybaGOtFueLf18_1755593548
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
	https://fast.dpdk.org/rel/dpdk-24.11.3.tar.xz

The git tree is at:
	https://dpdk.org/browse/dpdk-stable/?h=24.11

This LTS release contains ~180 fixes from main branch
up to DPDK 25.07.

Thanks to the authors who helped with backports and to the
following who helped with validation: Red Hat, Nvidia, and Intel.

Kevin

---
 .gitignore                                         |   1 +
 .mailmap                                           |  13 +-
 VERSION                                            |   2 +-
 app/test-crypto-perf/cperf_ops.c                   |   4 +-
 app/test-eventdev/test_perf_common.c               |   4 +-
 app/test-eventdev/test_pipeline_common.c           |   4 +-
 app/test-pmd/cmdline.c                             |   4 +-
 app/test-pmd/cmdline_flow.c                        |   2 +-
 app/test-pmd/config.c                              |   3 +-
 app/test/test_cryptodev.c                          |   3 +
 app/test/test_cryptodev.h                          |   6 +-
 app/test/test_cryptodev_asym.c                     |  37 +-
 app/test/test_cryptodev_eddsa_test_vectors.h       |   2 +-
 app/test/test_cryptodev_rsa_test_vectors.h         |  32 +-
 app/test/test_malloc.c                             |  77 +-
 app/test/test_net_ip6.c                            |  26 +
 app/test/test_per_lcore.c                          |  17 +-
 buildtools/get-test-suites.py                      |  20 +-
 doc/guides/conf.py                                 |   7 +-
 doc/guides/eventdevs/features/cnxk.ini             |   8 +
 doc/guides/eventdevs/overview.rst                  |   8 +
 doc/guides/freebsd_gsg/build_sample_apps.rst       |   4 -
 doc/guides/linux_gsg/build_sample_apps.rst         |   4 -
 doc/guides/nics/ena.rst                            |   4 +-
 doc/guides/nics/features/txgbe.ini                 |   2 +
 doc/guides/nics/mlx5.rst                           |   2 +-
 doc/guides/rel_notes/release_24_11.rst             | 285 +++++++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst        |   2 +-
 drivers/bus/auxiliary/auxiliary_common.c           |   2 +
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c           |  10 +-
 drivers/bus/pci/bsd/pci.c                          |  17 +-
 drivers/bus/pci/pci_common.c                       |   1 +
 drivers/bus/uacce/uacce.c                          |   1 +
 drivers/bus/vdev/vdev.c                            |   1 +
 drivers/bus/vmbus/bus_vmbus_driver.h               |   4 +
 drivers/bus/vmbus/linux/vmbus_uio.c                |   2 +-
 drivers/bus/vmbus/rte_vmbus_reg.h                  |   9 +-
 drivers/bus/vmbus/vmbus_bufring.c                  |   9 +-
 drivers/bus/vmbus/vmbus_common.c                   |   1 +
 drivers/bus/vmbus/vmbus_common_uio.c               |   2 +-
 drivers/common/cnxk/cnxk_security.c                |   5 +
 drivers/common/cnxk/roc_cpt.c                      |   5 +
 drivers/common/cnxk/roc_nix.h                      |   2 +
 drivers/common/cnxk/roc_nix_queue.c                |  11 +-
 drivers/common/cnxk/roc_npa_irq.c                  |   7 +-
 drivers/common/cnxk/roc_npc.c                      |   5 +-
 drivers/common/cnxk/roc_npc_parse.c                |   2 +-
 drivers/common/dpaax/caamflib/desc/pdcp.h          |  22 +-
 drivers/common/idpf/base/virtchnl2.h               |   2 -
 drivers/common/mlx5/linux/mlx5_common_auxiliary.c  |  11 +-
 drivers/common/mlx5/mlx5_prm.h                     |   1 +
 drivers/common/mlx5/windows/meson.build            |   2 +-
 drivers/crypto/cnxk/cn10k_tls_ops.h                |   8 +-
 drivers/crypto/cnxk/cnxk_ae.h                      |  11 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c           |   2 +-
 drivers/crypto/cnxk/rte_pmd_cnxk_crypto.h          |   3 +
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c        |   1 +
 drivers/crypto/openssl/rte_openssl_pmd_ops.c       |   6 +-
 drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c       |  13 +-
 drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c       |  13 +-
 drivers/crypto/qat/dev/qat_crypto_pmd_gens.h       | 280 +++++++
 drivers/crypto/qat/dev/qat_sym_pmd_gen1.c          |  53 +-
 drivers/crypto/qat/qat_sym_session.c               |  10 +-
 drivers/crypto/virtio/virtio_cryptodev.c           |   3 +-
 drivers/crypto/virtio/virtio_rxtx.c                |  61 +-
 drivers/event/cnxk/cnxk_tim_worker.h               | 140 ++--
 drivers/event/dlb2/dlb2.c                          |  80 +-
 drivers/event/dlb2/dlb2_priv.h                     |   3 +-
 drivers/event/dlb2/dlb2_selftest.c                 |   6 +-
 drivers/event/dlb2/pf/dlb2_pf.c                    |   4 +-
 drivers/event/dlb2/rte_pmd_dlb2.c                  |   4 +-
 drivers/event/dlb2/rte_pmd_dlb2.h                  |  23 +-
 drivers/net/af_xdp/rte_eth_af_xdp.c                |   4 +-
 drivers/net/bonding/rte_eth_bond_pmd.c             |  11 +-
 drivers/net/cnxk/cn10k_ethdev_sec.c                |  65 +-
 drivers/net/cnxk/cnxk_ethdev.c                     |   3 +-
 drivers/net/cnxk/cnxk_ethdev_sec.c                 |  60 +-
 drivers/net/e1000/igb_ethdev.c                     |   4 +-
 drivers/net/e1000/igb_rxtx.c                       |   6 +-
 drivers/net/ena/ena_ethdev.c                       |  44 +-
 drivers/net/ena/ena_ethdev.h                       |   3 +-
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
 drivers/net/hns3/hns3_rxtx.c                       | 173 ++++-
 drivers/net/hns3/hns3_rxtx.h                       |   3 +
 drivers/net/hns3/hns3_rxtx_vec.c                   |   9 +-
 drivers/net/hns3/hns3_rxtx_vec_neon.h              |  19 -
 drivers/net/hns3/hns3_rxtx_vec_sve.c               |   3 +-
 drivers/net/i40e/base/i40e_diag.c                  |   2 +-
 drivers/net/i40e/base/i40e_nvm.c                   |   1 +
 drivers/net/i40e/base/i40e_osdep.h                 |   4 +-
 drivers/net/i40e/base/i40e_type.h                  |  14 +-
 drivers/net/i40e/base/meson.build                  |  16 +-
 drivers/net/i40e/i40e_ethdev.c                     |   1 +
 drivers/net/i40e/i40e_rxtx.c                       |   2 +
 drivers/net/iavf/iavf_ethdev.c                     |  74 +-
 drivers/net/ice/base/ice_common.c                  |   2 +-
 drivers/net/ice/base/ice_devids.h                  |   2 +-
 drivers/net/ice/base/ice_sched.c                   |   7 +-
 drivers/net/ice/base/ice_type.h                    |   2 +-
 drivers/net/ice/ice_dcf_ethdev.c                   |  38 +-
 drivers/net/ice/ice_fdir_filter.c                  |   5 +-
 drivers/net/ice/ice_tm.c                           |  12 +
 drivers/net/igc/igc_ethdev.c                       |   2 +-
 drivers/net/ixgbe/base/ixgbe_common.c              |   4 +-
 drivers/net/ixgbe/base/ixgbe_e610.c                |   2 +
 drivers/net/ixgbe/base/ixgbe_mbx.h                 |   4 +
 drivers/net/ixgbe/base/ixgbe_osdep.c               |  47 --
 drivers/net/ixgbe/base/ixgbe_osdep.h               |  39 +-
 drivers/net/ixgbe/base/ixgbe_vf.c                  | 126 ++-
 drivers/net/ixgbe/base/ixgbe_vf.h                  |   2 +
 drivers/net/ixgbe/base/meson.build                 |  12 -
 drivers/net/ixgbe/ixgbe_ethdev.c                   | 138 ++--
 drivers/net/ixgbe/ixgbe_ethdev.h                   |   2 +-
 drivers/net/ixgbe/ixgbe_flow.c                     |   2 +
 drivers/net/ixgbe/ixgbe_rxtx.c                     |   5 +-
 drivers/net/mana/mana.c                            |  14 +
 drivers/net/mana/mana.h                            |   4 +
 drivers/net/mlx5/hws/mlx5dr_bwc.c                  |   2 +-
 drivers/net/mlx5/hws/mlx5dr_send.c                 |   2 +-
 drivers/net/mlx5/linux/mlx5_os.c                   |   3 +-
 drivers/net/mlx5/linux/mlx5_verbs.c                |   8 +-
 drivers/net/mlx5/linux/mlx5_vlan_os.c              |  10 +-
 drivers/net/mlx5/meson.build                       |  18 +-
 drivers/net/mlx5/mlx5.h                            |   1 +
 drivers/net/mlx5/mlx5_devx.c                       |  11 +-
 drivers/net/mlx5/mlx5_ethdev.c                     |  55 +-
 drivers/net/mlx5/mlx5_flow.c                       |  10 +-
 drivers/net/mlx5/mlx5_flow_dv.c                    |   7 +
 drivers/net/mlx5/mlx5_flow_hw.c                    | 191 ++---
 drivers/net/mlx5/mlx5_flow_meter.c                 | 552 -------------
 drivers/net/mlx5/mlx5_hws_cnt.c                    |  31 +-
 drivers/net/mlx5/mlx5_rx.c                         | 284 ++++++-
 drivers/net/mlx5/mlx5_rx.h                         |  28 +-
 drivers/net/mlx5/mlx5_rxq.c                        |  13 +-
 drivers/net/mlx5/mlx5_trigger.c                    |   6 +-
 drivers/net/mlx5/mlx5_txq.c                        |  13 +-
 drivers/net/mlx5/mlx5_vlan.c                       |   2 +-
 drivers/net/netvsc/hn_ethdev.c                     |  10 +-
 drivers/net/netvsc/hn_rndis.c                      |  14 +-
 drivers/net/netvsc/hn_rxtx.c                       |  16 +-
 drivers/net/netvsc/hn_var.h                        |   4 -
 drivers/net/nfp/flower/nfp_flower_ctrl.c           |  14 +-
 drivers/net/nfp/nfd3/nfp_nfd3.h                    |  14 +-
 drivers/net/nfp/nfd3/nfp_nfd3_dp.c                 |   8 +-
 drivers/net/nfp/nfdk/nfp_nfdk.h                    |  14 +-
 drivers/net/nfp/nfp_net_cmsg.c                     |   3 +-
 drivers/net/nfp/nfp_net_common.c                   |  13 +-
 drivers/net/nfp/nfp_net_flow.c                     |   2 +-
 drivers/net/nfp/nfp_net_meta.c                     |   8 +-
 drivers/net/nfp/nfp_rxtx.c                         |  36 +-
 drivers/net/nfp/nfp_rxtx.h                         |  16 +-
 drivers/net/nfp/nfp_rxtx_vec_avx2.c                |   6 +-
 drivers/net/ngbe/base/ngbe_hw.c                    |   9 +
 drivers/net/ngbe/base/ngbe_type.h                  |   1 +
 drivers/net/ngbe/ngbe_ethdev.c                     |   6 +-
 drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c  |   9 -
 drivers/net/ntnic/include/ntos_drv.h               |   1 +
 .../profile_inline/flow_api_profile_inline.c       |  12 +-
 drivers/net/ntnic/nthw/stat/nthw_stat.c            |   4 +
 drivers/net/ntnic/ntnic_ethdev.c                   |  26 +-
 drivers/net/ntnic/ntnic_vfio.c                     |   3 -
 drivers/net/null/rte_eth_null.c                    |  12 +-
 drivers/net/octeon_ep/cnxk_ep_rx.h                 |   7 +-
 drivers/net/octeon_ep/otx_ep_mbox.h                |   2 +-
 drivers/net/qede/qede_filter.c                     |  20 +-
 drivers/net/sfc/sfc.c                              |   6 +-
 drivers/net/tap/tap_tcmsgs.c                       |   4 +-
 drivers/net/txgbe/base/txgbe_hw.c                  |  13 +-
 drivers/net/txgbe/base/txgbe_type.h                |  21 +-
 drivers/net/txgbe/txgbe_ethdev.c                   |   6 +-
 drivers/net/txgbe/txgbe_ethdev.h                   |   9 +-
 drivers/net/txgbe/txgbe_ethdev_vf.c                |  31 +-
 drivers/net/txgbe/txgbe_fdir.c                     |  62 +-
 drivers/net/txgbe/txgbe_flow.c                     | 853 +++++++++++++++------
 drivers/net/txgbe/txgbe_rxtx.c                     |   2 +
 drivers/power/intel_uncore/intel_uncore.c          |  35 +-
 .../capturing_traffic_generator.py                 |   5 +-
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
 lib/eal/x86/include/rte_atomic.h                   |   6 +-
 lib/eal/x86/include/rte_byteorder.h                |   9 +-
 lib/ethdev/rte_ethdev.c                            |  11 +-
 lib/ethdev/rte_flow.c                              |  12 +-
 lib/eventdev/rte_eventdev.h                        |  67 +-
 lib/net/rte_ip6.h                                  |   4 +-
 lib/pcapng/rte_pcapng.c                            |   6 +-
 lib/vhost/vhost.c                                  |   6 +-
 lib/vhost/vhost_crypto.c                           |   3 +-
 lib/vhost/virtio_net_ctrl.c                        |  12 +-
 219 files changed, 3466 insertions(+), 1989 deletions(-)
Amiya Ranjan Mohakud (2):
      net/iavf: fix VLAN strip setting after enabling filter
      net/iavf: fix VLAN strip disabling for ADQ v2 capability

Anatoly Burakov (1):
      net/ixgbe: fix indentation

Andre Muezerie (1):
      net/mlx5: fix link on Windows

Ariel Otilibili (2):
      net/af_xdp: fix use after free in zero-copy Tx
      pcapng: fix null dereference in close

Arkadiusz Kusztal (2):
      crypto/qat: fix out-of-place header bytes in AEAD raw API
      crypto/qat: fix out-of-place chain/cipher/auth headers

Bing Zhao (2):
      net/mlx5: fix WQE size calculation for Tx queue
      examples/ntb: check more heap allocations

Bruce Richardson (9):
      net/fm10k/base: fix compilation warnings
      net/ixgbe/base: correct definition of endianness macro
      net/ixgbe/base: fix compilation warnings
      net/i40e/base: fix unused value warnings
      net/i40e/base: fix compiler warnings
      net/ice: fix support for 3 scheduler levels
      test/malloc: improve resiliency
      power/intel_uncore: fix crash closing uninitialized driver
      net/ixgbe/base: fix lock checker errors

Chaoyong He (6):
      net/nfp: fix crash with null RSS hash key
      net/nfp: fix hash key length logic
      app/testpmd: fix RSS hash key update
      net/nfp: standardize NFDk Tx descriptor endianness
      net/nfp: standardize Rx descriptor endianness
      net/nfp: standardize NFD3 Tx descriptor endianness

Chengwen Feng (3):
      app/testpmd: relax number of TCs in DCB command
      bus: cleanup device lists
      net/hns3: fix queue TC configuration on VF

Clemens Famulla-Conrad (1):
      dts: fix deterministic doc

Danylo Vodopianov (3):
      net/ntnic: avoid divide by zero
      net/ntnic: fix ring queue operation
      net/ntnic: remove unused code

Dariusz Sosnowski (7):
      net/mlx5: fix header modify action on group 0
      net/mlx5: validate GTP PSC QFI width
      net/mlx5: fix counter pool init error propagation
      net/mlx5: fix counter service cleanup on init failure
      net/mlx5: fix flex tunnel flow validation
      net/mlx5: fix VLAN stripping on hairpin queue
      net/mlx5: fix masked indirect age action validation

David Marchand (7):
      acl: fix build with GCC 15 on aarch64
      vhost: fix wrapping on control virtqueue rings
      eal: warn if no lcore is available
      test/lcore: fix race in per-lcore test
      common/mlx5: fix dependency detection on Windows
      doc: remove reference to deprecated --use-device option
      eal: add description of service corelist in usage

Dengdui Huang (12):
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
      net/hns3: fix Rx packet without CRC data

Dhanya Pillai (2):
      net/ice: fix flow creation failure
      net/i40e: fix RSS on plain IPv4

Edvard Fagerholm (1):
      eal/x86: fix C++ build

Eugenio Pérez (2):
      vhost: search virtqueues driver data in read-only area
      vhost: fix net control virtqueue used length

Gagandeep Singh (2):
      common/dpaax: fix PDCP key command race condition
      common/dpaax: fix PDCP AES only 12-bit SN

Gavin Li (1):
      net/mlx5: align PF and VF/SF MAC address handling

Gowrishankar Muthukrishnan (5):
      crypto/cnxk: fix uninitialized variable
      crypto/cnxk: fix out-of-bounds access in SM2
      crypto/openssl: include private exponent in RSA session
      test/crypto: fix RSA vector as per RFC 8017
      test/crypto: fix RSA decrypt validation

Gregory Etelson (7):
      net/mlx5: remove unsupported flow meter action in HWS
      net/mlx5: fix error notification for large flow patterns
      net/mlx5: fix mark action with shared Rx queue
      app/testpmd: fix flow random item token
      net/mlx5: fix access to auxiliary flow data
      common/mlx5: fix extraction of auxiliary device name
      bus/auxiliary: fix crash in cleanup

Ivan Malov (1):
      net/sfc: fix action order on start failure

Jake Freeland (1):
      bus/pci/bsd: fix device existence check

Jaromír Smrček (1):
      doc: add kernel options required for mlx5

Jedrzej Jagielski (1):
      net/ixgbe/base: fix link status for E610

Jiawen Wu (13):
      net/txgbe: fix ntuple filter parsing
      net/txgbe: fix raw pattern match for FDIR rule
      net/txgbe: fix packet type for FDIR filter
      net/txgbe: fix to create FDIR filter for SCTP packet
      net/txgbe: fix FDIR perfect mode for IPv6
      net/txgbe: fix to create FDIR filter for tunnel packet
      net/txgbe: fix reserved extra FDIR headroom
      net/txgbe: fix MAC control frame forwarding
      net/ngbe: fix MAC control frame forwarding
      net/txgbe: fix device statistics
      net/ngbe: fix device statistics
      net/txgbe: restrict VLAN strip configuration on VF
      net/txgbe: add LRO flag in mbuf when enabled

Junfeng Guo (1):
      net/mlx5: fix template flow rule identification

Kaiwen Deng (4):
      net/ixgbe: enable ethertype filter for E610
      net/e1000: fix igb Tx queue offloads capability
      net/e1000: fix xstats name
      net/ixgbe: skip MACsec stats for E610

Kevin Traynor (2):
      version: 24.11.3-rc1
      version: 24.11.3

Khadem Ullah (1):
      net/mlx5: fix crash on age query with indirect conntrack

Konstantin Ananyev (1):
      net/ixgbe: remove VLAs

Long Li (5):
      bus/vmbus: use Hyper-V page size
      net/netvsc: use Hyper-V page size
      net/netvsc: add stats counters from VF
      net/mana: check vendor ID when probing RDMA device
      bus/vmbus: align ring buffer data to page boundary

Long Wu (2):
      net/nfp: fix flow rule freeing
      net/nfp: fix control message overflow

Lukasz Krakowiak (2):
      net/ice/base: fix integer overflow
      net/ice/base: fix typo in device ID description

Maayan Kashani (5):
      net/mlx5: fix validation for GENEVE options
      net/mlx5: fix GRE flow item validation
      net/mlx5/hws: fix send queue drain on FW WQE destroy
      ethdev: fix error struct in flow configure
      net/mlx5: fix crash in HWS counter pool destroy

Madhuker Mythri (1):
      net/bonding: avoid RSS RETA update in flow isolation mode

Marat Khalili (1):
      buildtools/test: scan muti-line registrations

Mattias Rönnblom (1):
      eventdev: fix flag types consistency

Maxime Coquelin (1):
      net/mlx5: avoid setting kernel MTU if not needed

Mingjin Ye (2):
      net/ice: fix querying RSS hash for DCF
      net/ice: fix handling empty DCF RSS hash

Mohamed Feroz Abdul Majeeth (1):
      net/octeon_ep: increase mailbox timeout

Morten Brørup (1):
      eal/unix: fix log message for madvise failure

Nawal Kishor (1):
      common/cnxk: fix aura offset

Nithin Dabilpuram (1):
      common/cnxk: fix CQ tail drop

Nithinsen Kaithakadan (4):
      common/cnxk: fix qsize in CPT iq enable
      test/crypto: fix auth and cipher case IV length
      test/crypto: set to null after freeing operation
      common/cnxk: fix AES-CTR salt handling

Oleksandr Kolomeiets (1):
      net/ntnic: unmap DMA during queue release

Oleksandr Nahnybida (1):
      trace: fix overflow in per-lcore trace buffer

Paul Greenwalt (1):
      net/ice/base: fix media type check

Pavan Nikhilesh (3):
      event/cnxk: fix missing HW state checks
      eal: fix return value of lcore role
      doc: fix missing feature matrix for event device

Praveen Shetty (1):
      net/idpf: fix truncation of constant value

Pravin Pathak (6):
      event/dlb2: fix dequeue with CQ depth <= 16
      event/dlb2: fix validaton of LDB port COS ID arguments
      event/dlb2: fix num single link ports for DLB2.5
      event/dlb2: fix QID depth xstat
      event/dlb2: fix public symbol namespace
      app/eventdev: fix number of releases sent during cleanup

Radu Nicolau (3):
      crypto/virtio: fix driver cleanup
      crypto/qat: fix out-of-place chain/cipher/auth headers
      crypto/virtio: add request check on request side

Rahul Bhansali (2):
      net/cnxk: fix descriptor count update on reconfig
      net/cnxk: fix lock for security session operations

Rajesh Mudimadugula (2):
      vhost/crypto: fix cipher data length
      crypto/virtio: fix cipher data source length

Rakesh Kudurumalla (2):
      examples/ipsec-secgw: fix crash with IPv6
      examples/ipsec-secgw: fix crash in event vector mode

Robin Jarry (1):
      net: fix IPv6 check for IPv4 compat

Rui Ferreira (2):
      eal/linux: unregister alarm callback before free
      eal/freebsd: unregister alarm callback before free

Satheesh Paul (1):
      common/cnxk: fix E-tag pattern parsing

Shai Brandes (2):
      net/ena: fix control path interrupt mode
      net/ena: fix aenq timeout with low poll interval

Shani Peretz (1):
      app/crypto-perf: fix AAD offset alignment

Stephen Hemminger (4):
      net/qede: fix use after free
      bus/fslmc: fix use after free
      net/null: fix packet copy
      crypto/qat: fix size calculation for memset

Sucharitha Sarananaga (1):
      test/crypto: fix EdDSA vector description

Sunyang Wu (1):
      ethdev: keep promiscuous/allmulti value before disabling

Tanzeel Ahmed (1):
      examples/flow_filtering: fix make clean

Tejasree Kondoj (2):
      crypto/cnxk: fix QP stats
      crypto/cnxk: fix includes

Tirthendu Sarkar (1):
      event/dlb2: fix default credits based on HW version

Vanshika Shukla (1):
      crypto/dpaa2_sec: fix uninitialized variable

Viacheslav Ovsiienko (3):
      net/mlx5: fix hypervisor detection in VLAN workaround
      net/mlx5: fix out-of-order completions in ordinary Rx burst
      net/mlx5: fix maximal queue size query

Vidya Sagar Velumuri (2):
      net/octeon_ep: fix buffer refill
      crypto/cnxk: update SG list population

Volodymyr Fialko (1):
      examples/ipsec-secgw: fix number of queue pairs

Waldemar Dworakowski (1):
      net/ice/base: fix type conversion

Yan Lu (1):
      net/tap: fix qdisc add failure handling

Yang Ming (1):
      eal/linux: improve ASLR check

Yuan Wang (2):
      net/e1000: fix EEPROM dump
      net/ixgbe: fix port mask default value in filter

