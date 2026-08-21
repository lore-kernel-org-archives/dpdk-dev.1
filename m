Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392D7C5DF97
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:27:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD98340289;
	Fri, 21 Aug 2026 21:27:25 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2D6084027B
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:27:24 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-84867f07d63so1328397b3a.2
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340443;
 x=1787945243; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/mZVBxc4CuS/iC0gBCbk8CDybN4c+x9830r8R6RBvW4=;
 b=s1Ku/attKEUX5x6paQDT3Acw9j0GW0wWVc/ibxG4VCxN8kllHRYeExAZL1eD1aqLG4
 3KGNifvwtEVKMgxCB3cwG6rO4+i/LknyYH8LczSgMxHkzFbhU3w4FxHfcT5JphwXLTfm
 s/qHGELgnkcsrTNeS/untbLo+bzXnrQJN07KPQozZxT1w9DZ4OwjXcuZC01SoBryKUZ6
 r4bVPzKt7Ya14bYyD2C/yXBVhfHcQFyjW3ni1lzmw6osj4NJpeKHMM/mVVPSUmkcYy8Q
 W+vi7gNZ43y+TfUJNSXbPUGmb6vvq7qgJCUlQCyuegnH0cfXMb4NEOHtTjY3jb9KLlqw
 OMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340443; x=1787945243;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/mZVBxc4CuS/iC0gBCbk8CDybN4c+x9830r8R6RBvW4=;
 b=G9oXYDsoo/DxmOS/VIzW6CgyAFtlasBbyeqk2KgOaHV8wapZmC1lyo/T4RCkrpXjnd
 WlBXEv3tiJj2YhW/EH8S5WLuwEBHSq6hTIGqtFkjYgfuzL5ZwGddzA3EE5FfAvKjVc1b
 mTeSTrBVKjGaxeKOY/ATJxi01u4UWRz3eWdB5k2GhtjALX7PXkayNQpXdZE0IveULvBm
 SQ3k01T2EhbnRb9NQjfL5cH/6WZNPz1COrCJAhNB6nSWtReNz9hj/ruKyYjFqkM8nLVp
 314P/lVEtzh85bvV8Zt153visYo+XztkC2ulFIC2mZthOrIYBZDaZd1eXlqvbLnntnmT
 RpZg==
X-Gm-Message-State: AFuF++nQtjDvOYLaz8X7VTrOldSAfdVrYn6x16SvEksnlV/Eaxs0v9is
 dLFIe+Zu1GiuyRRC9iYyhrja5UCth9QqvNyeBhvzmDYkzrBwt9oYx50krIGYCETNEbXMDr/GedL
 LVvuw
X-Gm-Gg: AR+sD12qqb4SUW71q17nPEpfq5OLaqFbq6duKmJlSYYjUyxQph+79u3fn8hISumsB5s
 mW9f6+ULp2QfVQkc4pDfj8vfGlpUf13VHeerPpa+UF69+H8NClXyl2jJNl17xDmr072PP2W6iIs
 86GlH0R1BVxbghebZE1dXd2+HqOSd7Jv68MnC0hlRT45A5pKlcdD3y/JJ7e2EhpfycpZtJTeqfY
 E4p40P6ghymjnm73qCVIfvnstA7MDyJ5TsPTq/2ayCnHM35g10kO2e2XqZWeo5t+aK6q1Nw7LvJ
 80ZOMaCXJC0vlec20i4XXZXz+uqnikOeE7DDkTzuH4vxFgr2Xc9aMnpVPbGYYAZWIgrrfPHxocx
 5Vs4PnVcUtcfLdsTnCqeygTZo80IJW99nA77Yvjl2iTaJGfvKZgwrcLIFt5h8M/O6OLZhe1vyxh
 hRQ66jQTQET8/ssye4eJ47vu+IxfC2rQShwhG4FyhFs13y3sr0SmMWV+/zZ92zJqTd7PgapGUt8
 HaR0bKl5xxfkaB1MgqiX0opazo=
X-Received: by 2002:a05:6a20:438c:b0:3c4:46ca:334b with SMTP id
 adf61e73a8af0-3cd4bb986damr1996325637.9.1787340443114; 
 Fri, 21 Aug 2026 12:27:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:27:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 00/68] reduce use of rte_memcpy
Date: Fri, 21 Aug 2026 12:23:55 -0700
Message-ID: <20260821192646.146382-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

The DPDK function rte_memcpy() only exists as an optimization
for shortcomings in performance of libc memcpy() on some platforms.
Many platforms have no special rte_memcpy() and just use memcpy().

But many analysis and test tools know that memcpy() is a special
case and check for overwrite, bounds errors etc. Therefore memcpy()
should be preferred where ever possible.

This patch series introduces a coccinelle script to find
calls to rte_memcpy() where size is fixed, and change them to
regular memcpy(). Many of the patch series is just the results
of that script.

There is also some cleanups to include rte_memcpy.h where it
was not being done before; the include was happening by some other header.
And also removal of rte_memcpy.h where no longer needed.

The result is a 45% reduction in use of rte_memcpy (1008 call
sites down to 551). The leftover cases are places where rte_memcpy
is used in data path; and test code for rte_memcpy.

v2:
  - reorder the series so it bisects cleanly: the patches adding
    the missing includes of rte_memcpy.h now come first, before
    any patch that removes an include or replaces a call. In v1
    those were at the end of the series, so intermediate commits
    could fail to build.
  - move the documentation patch describing when to use
    rte_memcpy() to the front of the series, so the rationale for
    the rest of the changes is established first.

Stephen Hemminger (68):
  devtools/cocci: add script to replace fixed size rte_memcpy
  lib: add missing include of rte_memcpy.h
  net: add missing include of rte_memcpy.h
  crypto: add missing include of rte_memcpy.h
  drivers: add missing include of rte_memcpy.h
  app: add missing include of rte_memcpy.h
  examples: add missing include of rte_memcpy.h
  eal: document when to use rte_memcpy
  app/testpmd: replace rte_memcpy with memcpy
  test: use memcpy instead of rte_memcpy
  app/graph: replace rte_memcpy with memcpy
  lpm: remove unnecessary include of rte_memcpy.h
  acl: remove unnecessary include of rte_memcpy.h
  drivers/bus: remove unnecessary include of rte_memcpy.h
  security: replace fixed size rte_memcpy
  ethdev: replace use of rte_memcpy
  net: replace use of rte_memcpy
  pdcp: replace use of rte_memcpy
  eventdev: replace fixed size rte_memcpy
  eal: replace rte_memcpy of cpuset
  cryptodev: replace use of rte_memcpy
  drivers/raw: use memcpy for fixed size data
  test-pipeline: replace use of rte_memcpy
  net/af_xdp: replace use of rte_memcpy
  net/avp: replace use of rte_memcpy
  net/axgbe: replace use of rte_memcpy
  net/bnx2x: replace use of rte_memcpy
  net/bnxt: replace use of rte_memcpy
  net/bonding: replace use of rte_memcpy
  net/cnxk: replace use of rte_memcpy
  net/cxgbe: replace use of rte_memcpy
  net/dpaa2: replace use of rte_memcpy
  net/enic: replace use of rte_memcpy
  net/failsafe: replace use of rte_memcpy
  net/gve: replace use of rte_memcpy
  net/hinic: replace use of rte_memcpy
  net/hns3: replace use of rte_memcpy
  net/mlx5: replace use of rte_memcpy
  net/mvpp2: replace use of rte_memcpy
  net/netvsc: replace use of rte_memcpy
  net/nfp: replace use of rte_memcpy
  net/ngbe: replace use of rte_memcpy
  net/ntnic: replace use of rte_memcpy
  net/null: replace use of rte_memcpy
  net/qede: replace use of rte_memcpy
  net/ring: replace use of rte_memcpy
  net/sfc: replace use of rte_memcpy
  net/txgbe: replace use of rte_memcpy
  net/vhost: replace use of rte_memcpy
  net/virtio: replace use of rte_memcpy
  net/sxe2: replace use of rte_memcpy
  net/zxdh: replace use of rte_memcpy
  net/memif: use memcpy for fixed size data
  net/ice: use memcpy for fixed size data
  test-bbdev: remove unnecessary include rte_memcpy.h
  drivers/mempool: use memcpy for fixed size data
  ml/cnxk: use memcpy for fixed size data
  drivers/event: use memcpy for fixed size data
  baseband/la12xx: use memcpy for fixed size data
  baseband/acc: replace use of rte_memcpy
  drivers/*/qat: use memcpy for fixed size data
  hash: replace use of rte_memcpy
  rib: remove rte_memcpy include
  pcapng: replace use of rte_memcpy
  efd: replace use of rte_memcpy
  net/xsc: replace use of rte_memcpy
  net/pcap: replace use of rte_memcpy
  power: replace use of rte_memcpy

 app/graph/ip4_output_hook.c                   |   1 +
 app/graph/neigh.c                             |   8 +-
 app/test-bbdev/test_bbdev.c                   |   1 -
 app/test-bbdev/test_bbdev_perf.c              |   1 +
 .../comp_perf_test_common.c                   |   1 +
 .../comp_perf_test_verify.c                   |   1 +
 app/test-dma-perf/benchmark.c                 |   1 +
 app/test-eventdev/test_pipeline_common.c      |   8 +-
 app/test-mldev/test_common.c                  |   1 +
 app/test-mldev/test_inference_common.c        |   1 +
 app/test-pipeline/config.c                    |   1 -
 app/test-pipeline/init.c                      |   1 -
 app/test-pipeline/main.c                      |   1 -
 app/test-pipeline/runtime.c                   |   1 -
 app/test-pmd/cmdline.c                        |  28 ++---
 app/test-pmd/cmdline_flow.c                   |  34 +++---
 app/test-pmd/config.c                         |  13 +--
 app/test-pmd/csumonly.c                       |   1 -
 app/test-pmd/flowgen.c                        |   1 -
 app/test-pmd/iofwd.c                          |   1 -
 app/test-pmd/macfwd.c                         |   1 -
 app/test-pmd/macswap.c                        |   1 -
 app/test-pmd/noisy_vnf.c                      |   1 -
 app/test-pmd/rxonly.c                         |   1 -
 app/test-pmd/testpmd.c                        |   1 -
 app/test-pmd/txonly.c                         |   7 +-
 app/test/commands.c                           |   1 -
 app/test/packet_burst_generator.c             |  10 +-
 app/test/test_bpf.c                           |   1 +
 app/test/test_compressdev.c                   |   1 +
 app/test/test_crc.c                           |   7 +-
 app/test/test_cryptodev.c                     |  14 +--
 app/test/test_cryptodev.h                     |   1 +
 app/test/test_cryptodev_asym.c                |   1 -
 app/test/test_cryptodev_crosscheck.c          |   1 +
 app/test/test_cryptodev_security_pdcp.c       |   1 -
 app/test/test_efd.c                           |   1 -
 app/test/test_efd_perf.c                      |   1 -
 app/test/test_event_crypto_adapter.c          |  13 ++-
 app/test/test_eventdev.c                      |   1 -
 app/test/test_link_bonding_mode4.c            |   8 +-
 app/test/test_mbuf.c                          |   1 -
 app/test/test_member.c                        |   1 -
 app/test/test_member_perf.c                   |   1 -
 app/test/test_rawdev.c                        |   1 -
 app/test/test_ring.h                          |  17 ++-
 app/test/test_security_inline_macsec.c        |   2 +-
 app/test/test_security_inline_proto.c         |  42 +++----
 app/test/test_security_proto.c                |   2 +-
 app/test/test_service_cores.c                 |   1 -
 app/test/test_thash.c                         |   4 +-
 app/test/virtual_pmd.c                        |   5 +-
 devtools/cocci/rte_memcpy_fixed.cocci         |  15 +++
 drivers/baseband/acc/rte_acc100_pmd.c         |   7 +-
 drivers/baseband/acc/rte_vrb_pmd.c            |  21 ++--
 drivers/baseband/la12xx/bbdev_la12xx.c        |   4 +-
 .../baseband/turbo_sw/bbdev_turbo_software.c  |   1 +
 drivers/bus/auxiliary/linux/auxiliary.c       |   1 -
 drivers/bus/fslmc/fslmc_bus.c                 |   1 -
 drivers/bus/fslmc/fslmc_vfio.c                |   1 -
 drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c      |   1 -
 drivers/bus/fslmc/portal/dpaa2_hw_dpci.c      |   1 -
 drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c     |   1 -
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |   1 -
 drivers/bus/pci/linux/pci.c                   |   1 -
 drivers/common/mlx5/mlx5_common_mr.c          |   1 +
 drivers/common/qat/qat_qp.c                   |  10 +-
 drivers/compress/qat/qat_comp.c               |   8 +-
 drivers/crypto/armv8/rte_armv8_pmd.c          |   1 +
 drivers/crypto/caam_jr/caam_jr.c              |   1 +
 drivers/crypto/ccp/ccp_crypto.c               |  15 +--
 drivers/crypto/cnxk/cn10k_tls_ops.h           |   1 +
 drivers/crypto/cnxk/cn20k_tls_ops.h           |   1 +
 drivers/crypto/cnxk/cnxk_ae.h                 |   1 +
 drivers/crypto/cnxk/cnxk_se.h                 |   3 +-
 drivers/crypto/dpaa2_sec/dpaa2_sec_raw_dp.c   |   1 +
 drivers/crypto/dpaa_sec/dpaa_sec_raw_dp.c     |   1 +
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c        |   1 +
 drivers/crypto/ipsec_mb/pmd_snow3g.c          |   5 +-
 drivers/crypto/mlx5/mlx5_crypto_gcm.c         |  11 +-
 drivers/crypto/mvsam/rte_mrvl_pmd.c           |   1 +
 drivers/crypto/openssl/rte_openssl_pmd.c      |   1 +
 drivers/crypto/qat/asym/qat_asym.c            |   1 +
 drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c  |   1 +
 .../crypto/qat/dev/qat_crypto_pmd_gen_lce.c   |   1 +
 drivers/crypto/qat/dev/qat_crypto_pmd_gens.h  |   1 +
 drivers/crypto/qat/qat_sym_session.c          |  33 +++---
 .../scheduler/rte_cryptodev_scheduler.c       |   7 +-
 drivers/crypto/scheduler/scheduler_failover.c |  12 +-
 drivers/crypto/virtio/virtio_cryptodev.c      |   1 +
 drivers/crypto/virtio/virtio_rxtx.c           |   1 +
 drivers/crypto/zsda/zsda_crypto_session.c     |   6 +-
 drivers/dma/dpaa2/dpaa2_qdma.c                |   1 +
 drivers/event/cnxk/cnxk_eventdev_selftest.c   |   1 -
 drivers/event/cnxk/cnxk_tim_evdev.c           |   4 +-
 drivers/event/dlb2/dlb2.c                     |   4 +-
 drivers/event/dpaa/dpaa_eventdev.c            |   1 -
 drivers/event/dpaa2/dpaa2_eventdev.c          |   3 +-
 drivers/event/dpaa2/dpaa2_eventdev_selftest.c |   1 -
 drivers/event/octeontx/ssovf_evdev_selftest.c |   1 -
 drivers/event/octeontx/timvf_evdev.c          |   4 +-
 drivers/mempool/dpaa/dpaa_mempool.c           |   4 +-
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c      |   5 +-
 drivers/ml/cnxk/cn10k_ml_dev.c                |   1 +
 drivers/ml/cnxk/cn10k_ml_model.c              |   9 +-
 drivers/ml/cnxk/cn10k_ml_ops.c                |   9 +-
 drivers/ml/cnxk/cnxk_ml_io.c                  |   1 +
 drivers/ml/cnxk/tvmrt_ml_model.c              |   9 +-
 drivers/ml/cnxk/tvmrt_ml_ops.c                |   7 +-
 drivers/net/af_xdp/rte_eth_af_xdp.c           |   3 +-
 .../net/atlantic/hw_atl/hw_atl_utils_fw2x.c   |   1 +
 drivers/net/avp/avp_ethdev.c                  |   4 +-
 drivers/net/axgbe/axgbe_ethdev.c              |   4 +-
 drivers/net/bnx2x/bnx2x.c                     |  32 +++---
 drivers/net/bnx2x/bnx2x.h                     |   1 +
 drivers/net/bnx2x/ecore_sp.c                  |   1 +
 drivers/net/bnx2x/ecore_sp.h                  |   1 +
 drivers/net/bnxt/bnxt_flow.c                  |  34 +++---
 drivers/net/bonding/rte_eth_bond_8023ad.c     |   4 +-
 drivers/net/bonding/rte_eth_bond_flow.c       |   2 +-
 drivers/net/cnxk/cn10k_ethdev_sec.c           |   1 +
 drivers/net/cnxk/cn10k_rx.h                   |   1 +
 drivers/net/cnxk/cn20k_ethdev_sec.c           |   1 +
 drivers/net/cnxk/cn20k_rx.h                   |   1 +
 drivers/net/cnxk/cnxk_eswitch_devargs.c       |   3 +-
 drivers/net/cnxk/cnxk_ethdev_ops.c            |   3 +-
 drivers/net/cnxk/cnxk_rep.c                   |   3 +-
 drivers/net/cnxk/cnxk_rep_flow.c              |   7 +-
 drivers/net/cnxk/cnxk_rep_msg.c               |   9 +-
 drivers/net/cnxk/cnxk_rep_ops.c               |   3 +-
 drivers/net/cnxk/cnxk_tm.c                    |   5 +-
 drivers/net/cxgbe/clip_tbl.c                  |   2 +-
 drivers/net/cxgbe/cxgbe_ethdev.c              |   1 +
 drivers/net/cxgbe/cxgbe_filter.c              |   8 +-
 drivers/net/cxgbe/l2t.c                       |   4 +-
 drivers/net/cxgbe/sge.c                       |   1 +
 drivers/net/cxgbe/smt.c                       |  20 ++--
 drivers/net/dpaa/dpaa_rxtx.c                  |   1 +
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c        |   1 -
 drivers/net/dpaa2/dpaa2_ethdev.c              |   1 -
 drivers/net/dpaa2/dpaa2_mux.c                 |  37 ++++---
 drivers/net/dpaa2/dpaa2_recycle.c             |   1 -
 drivers/net/dpaa2/dpaa2_rxtx.c                |   1 -
 drivers/net/dpaa2/dpaa2_sparser.c             |   1 -
 drivers/net/dpaa2/dpaa2_tm.c                  |   2 +-
 drivers/net/ena/ena_ethdev.c                  |   1 +
 drivers/net/ena/ena_rss.c                     |   1 +
 drivers/net/enic/enic_main.c                  |   6 +-
 drivers/net/failsafe/failsafe_ops.c           |  10 +-
 drivers/net/gve/base/gve_adminq.c             |   2 +-
 drivers/net/gve/gve_rx.c                      |   1 +
 drivers/net/gve/gve_tx.c                      |   1 +
 drivers/net/hinic/hinic_pmd_ethdev.c          |   1 -
 drivers/net/hinic/hinic_pmd_flow.c            |  41 ++++---
 drivers/net/hinic/hinic_pmd_tx.c              |   1 +
 drivers/net/hns3/hns3_fdir.c                  |   2 +-
 drivers/net/hns3/hns3_flow.c                  |   4 +-
 drivers/net/intel/ice/ice_fdir_filter.c       |   4 +-
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  |   1 +
 drivers/net/ionic/ionic_rxtx.h                |   1 +
 drivers/net/memif/memif_socket.c              |   4 +-
 drivers/net/memif/rte_eth_memif.c             |   1 +
 drivers/net/mlx4/mlx4_rxtx.c                  |   1 +
 drivers/net/mlx5/linux/mlx5_ethdev_os.c       |   1 +
 drivers/net/mlx5/mlx5_devx.c                  |   4 +-
 drivers/net/mlx5/mlx5_flow.c                  |  39 +++----
 drivers/net/mlx5/mlx5_flow_aso.c              |   6 +-
 drivers/net/mlx5/mlx5_flow_dv.c               |   1 +
 drivers/net/mlx5/mlx5_flow_flex.c             |   1 +
 drivers/net/mlx5/mlx5_flow_hw.c               |  32 +++---
 drivers/net/mlx5/mlx5_rx.c                    |   6 +-
 drivers/net/mlx5/mlx5_rx.h                    |   1 +
 drivers/net/mlx5/mlx5_rxq.c                   |   1 +
 drivers/net/mlx5/mlx5_rxtx_vec.c              |   8 +-
 drivers/net/mlx5/mlx5_tx.h                    |   1 +
 drivers/net/mlx5/mlx5_txpp.c                  |   1 +
 drivers/net/mvpp2/mrvl_tm.c                   |   2 +-
 drivers/net/netvsc/hn_ethdev.c                |   1 -
 drivers/net/nfb/nfb_rx.h                      |   1 +
 drivers/net/nfb/nfb_tx.h                      |   1 +
 drivers/net/nfp/flower/nfp_conntrack.c        |   3 +-
 drivers/net/nfp/flower/nfp_flower_cmsg.c      |   1 +
 drivers/net/nfp/flower/nfp_flower_flow.c      |  16 +--
 drivers/net/nfp/nfp_mtr.c                     |  10 +-
 drivers/net/nfp/nfp_net_flow.c                |   1 +
 drivers/net/nfp/nfpcore/nfp_nsp.c             |   1 +
 drivers/net/ngbe/ngbe_pf.c                    |   4 +-
 drivers/net/ntnic/ntnic_ethdev.c              |  12 +-
 drivers/net/null/rte_eth_null.c               |  12 +-
 drivers/net/octeon_ep/otx_ep_rxtx.c           |   1 +
 drivers/net/pcap/pcap_ethdev.c                |   9 +-
 drivers/net/qede/qede_main.c                  |   2 +-
 drivers/net/ring/rte_eth_ring.c               |   1 -
 drivers/net/sfc/sfc.c                         |   2 +-
 drivers/net/sfc/sfc_ef10_tx.c                 |   2 +-
 drivers/net/sfc/sfc_ethdev.c                  |  12 +-
 drivers/net/sfc/sfc_flow.c                    |  20 ++--
 drivers/net/sfc/sfc_flow_rss.c                |   2 +-
 drivers/net/sfc/sfc_mae.c                     |   3 +-
 drivers/net/sfc/sfc_rx.c                      |   2 +-
 drivers/net/sfc/sfc_tbl_meta_cache.c          |   1 +
 drivers/net/sfc/sfc_tso.c                     |   3 +-
 drivers/net/sfc/sfc_tso.h                     |   9 +-
 drivers/net/sxe2/sxe2_cmd_chnl.c              |   6 +-
 drivers/net/sxe2/sxe2_flow.c                  |  11 +-
 drivers/net/sxe2/sxe2_flow_parse_pattern.c    |  36 +++---
 drivers/net/sxe2/sxe2_ipsec.c                 |   2 +-
 drivers/net/sxe2/sxe2_rss.c                   |  10 +-
 drivers/net/sxe2/sxe2_rx.c                    |   4 +-
 drivers/net/sxe2/sxe2_stats.c                 |  25 +++--
 drivers/net/sxe2/sxe2_tm.c                    |   4 +-
 drivers/net/txgbe/txgbe_ethdev.c              |   9 +-
 drivers/net/txgbe/txgbe_fdir.c                |  11 +-
 drivers/net/txgbe/txgbe_flow.c                |  73 ++++++------
 drivers/net/txgbe/txgbe_ipsec.c               |   8 +-
 drivers/net/txgbe/txgbe_pf.c                  |   6 +-
 drivers/net/txgbe/txgbe_tm.c                  |  11 +-
 drivers/net/vhost/rte_eth_vhost.c             |   1 -
 drivers/net/virtio/virtio_ethdev.c            |   1 -
 drivers/net/vmxnet3/vmxnet3_rxtx.c            |   1 +
 drivers/net/xsc/xsc_dev.c                     |   2 +-
 drivers/net/xsc/xsc_tx.c                      |   1 +
 drivers/net/zxdh/zxdh_common.c                |   7 +-
 drivers/net/zxdh/zxdh_flow.c                  |  67 ++++++-----
 drivers/net/zxdh/zxdh_msg.c                   |  15 +--
 drivers/net/zxdh/zxdh_mtr.c                   |  10 +-
 drivers/net/zxdh/zxdh_np.c                    |   1 -
 drivers/net/zxdh/zxdh_queue.c                 |   8 +-
 drivers/net/zxdh/zxdh_rxtx.c                  |   1 +
 drivers/net/zxdh/zxdh_tables.c                |  21 ++--
 drivers/power/acpi/acpi_cpufreq.c             |   4 +-
 drivers/power/amd_pstate/amd_pstate_cpufreq.c |   4 +-
 drivers/power/amd_uncore/amd_uncore.c         |   5 +-
 drivers/power/cppc/cppc_cpufreq.c             |   4 +-
 .../power/intel_pstate/intel_pstate_cpufreq.c |   3 +-
 drivers/power/intel_uncore/intel_uncore.c     |   5 +-
 drivers/raw/ifpga/afu_pmd_he_hssi.c           |   4 +-
 drivers/raw/ifpga/afu_pmd_he_lpbk.c           |   4 +-
 drivers/raw/ifpga/afu_pmd_he_mem.c            |   4 +-
 drivers/raw/ifpga/afu_pmd_n3000.c             |   8 +-
 drivers/raw/ifpga/ifpga_rawdev.c              |  11 +-
 drivers/raw/skeleton/skeleton_rawdev.c        |   8 +-
 drivers/raw/skeleton/skeleton_rawdev_test.c   |   1 -
 drivers/regex/mlx5/mlx5_rxp.c                 |   1 +
 examples/bbdev_app/main.c                     |   1 +
 examples/dma/dmafwd.c                         |   1 +
 examples/ipsec-secgw/esp.c                    |   1 +
 lib/acl/rte_acl_osdep.h                       |   1 -
 lib/cryptodev/rte_cryptodev.c                 |  12 +-
 lib/eal/common/eal_common_options.c           |   6 +-
 lib/eal/include/generic/rte_memcpy.h          |  18 +++
 lib/eal/x86/include/rte_memcpy.h              |   1 +
 lib/efd/rte_efd.c                             |   3 +-
 lib/ethdev/rte_ethdev.c                       |   3 +-
 lib/ethdev/rte_flow.c                         | 104 ++++++++----------
 lib/eventdev/rte_event_crypto_adapter.c       |   2 +-
 lib/graph/rte_graph_model_mcore_dispatch.c    |   1 +
 lib/hash/rte_thash.c                          |   4 +-
 lib/ipsec/esp_inb.c                           |   1 +
 lib/ipsec/esp_outb.c                          |   1 +
 lib/lpm/rte_lpm6.c                            |   1 -
 lib/net/rte_ether.c                           |   2 +-
 lib/node/interface_tx_feature.c               |   1 +
 lib/node/ip4_local.c                          |   1 +
 lib/node/ip4_lookup.c                         |   1 +
 lib/node/ip4_lookup_fib.c                     |   1 +
 lib/node/ip4_reassembly.c                     |   1 +
 lib/node/ip4_rewrite.c                        |   1 +
 lib/node/ip6_lookup.c                         |   1 +
 lib/node/ip6_lookup_fib.c                     |   1 +
 lib/node/ip6_rewrite.c                        |   1 +
 lib/node/pkt_cls.c                            |   1 +
 lib/node/udp4_input.c                         |   1 +
 lib/pcapng/rte_pcapng.c                       |   2 +-
 lib/pdcp/pdcp_process.c                       |  51 +++++----
 lib/port/rte_swx_port_source_sink.c           |   1 +
 lib/rib/rte_rib6.h                            |   1 -
 lib/security/rte_security.c                   |   4 +-
 lib/vhost/vhost.c                             |   1 +
 lib/vhost/vhost_crypto.c                      |   1 +
 280 files changed, 875 insertions(+), 807 deletions(-)
 create mode 100644 devtools/cocci/rte_memcpy_fixed.cocci

-- 
2.53.0

