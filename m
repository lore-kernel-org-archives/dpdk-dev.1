Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DFBC5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:23:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3F0E4064E;
	Thu, 20 Aug 2026 07:23:02 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 343554026A
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:23:01 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c9d1fff21edso1194824a12.1
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203380;
 x=1787808180; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CyUE69neVBk8SkjevjkJn+EmSaqtBOjOxwF/CFOgiiU=;
 b=ZxFYpMz06F/3QHupsEbMPC5AsaC/rFrjEUswgCG9zq3pj+wByAGwphmEH47UJ65Q1q
 ODR7U9ymxYkwWyNUXxOrICbEj7FJHcmEfRx6Jd+ys8ufqL+ukwMhxXUcrPp6Vds1CdmZ
 GMF089DlWsklsbPsbnC10r0HNUiTnqhkO7K1a0dvfPsSliN06R52M5DxH/c6RVuZnSC8
 loMW+btKhrGsvV2Oz4UZ0WZmR06+vmAi2kTUcQe5L+WPsch9eoZQ8br950lDqjHAwp8Q
 HuSKa4AxIx8G32nn+xQY4CVY0Z9wlgd8z2p8KVWW68dbJ6tJQM9KqTrZ74og0bRixuAc
 xyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203380; x=1787808180;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CyUE69neVBk8SkjevjkJn+EmSaqtBOjOxwF/CFOgiiU=;
 b=Bv9HbI29Z+ntW29lqLOixmd6TlaZrKfcFRfUaydI84/+T0XvAQLSv1iyVEAzHbIODW
 xp5EWUUMxJDX/Yt72oGJCyuKH4fLOfvAWmilKy8eI1Kn1cNrm6J3oU85MsN/AFe6W8XA
 gKr7oXBUG0EkAlKr0HgFZPMAJNCn+q4QZ/1LOi2+PusJPNcJ0Y9ACrUwRdoxMY11Q0aJ
 R6grbXULl6TveoDlAnTxW2KJY0DYdQDa2JOZ2f1sE0sa00wuMgV71+JOqSz354ZydAvo
 GjkCNZv9K3SftDK1Ft2naCkDa0rrk9Q++jtUySQoSJc7+tOrVFVN4EnIZL6q7GjHsuBM
 pTAg==
X-Gm-Message-State: AOJu0Yx2ACjs2VQel/e3wL2VA7kNBik9bMxsBFIkO53kEZ+Vm5zASRLQ
 Ja8EfE8UNCd4AcbJ4zQ0OrjY1qLHxKpbK/9E4Y3CXjCPvzxHBJU0fn9tm+e3IJPosztaFgI1eGq
 761gT
X-Gm-Gg: AR+sD12YieAkWw3Uc231U+Of/mXA3BJanAVxi50s1vTGdxbtpC+twyafrBCOnNGH26+
 XGsTE7YI+mmPB6C9DdI0dKeLP+Y+cU/9yWScXNG5ZAcr/IGCOK7t0fOnJthU9UboaJdsa8pDXLI
 LWkaOInBSHkmLraweVgkbCFbnm6Z3SEVzHXnAbYDnXu+0Gv6zC0HM46Y3rOb55klUiSSN23EM9H
 /Rob/4IFWycv7AmwBhChGYESrr1LFOTW5jDr6IGMhtPhaHUtDGlL+rKnOzbT0uvqC5dMOTYtHvc
 iUmVxt3FkWHl7Q2wJhtZNKg2GVdZIWFjW4islPhs+SdFUARDWOkzuP67ilwq0G8WsswJwPtG4Kg
 LkNfhqwDV0YFtQkX2X6RuAjWMScd+aYfgWPLs3Xv8X29nKhMpTsVYGXQ9uj29HZzKraMriYz9W6
 lzWxwqt8Rqgtfgs5ivb5IbTST4njUWd0BTknlJqg1a25yFqeHBdmQ4MC0ZLOJqIvk0tTRuI1qNf
 tIyCfQ4Hooqaw7PugF8fWmg6vI=
X-Received: by 2002:a05:6a20:d48e:b0:3c4:1916:9d3c with SMTP id
 adf61e73a8af0-3cd012ac425mr19527250637.15.1787203379710; 
 Wed, 19 Aug 2026 22:22:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:22:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 00/61] reduce use of rte_memcpy
Date: Wed, 19 Aug 2026 22:11:50 -0700
Message-ID: <20260820052251.1453273-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
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
should be preferred wherever possible.

This patch series introduces a coccinelle script to find
calls to rte_memcpy() where size is fixed, and change them to
regular memcpy(). This was the starting point for this cleanup.

There is also some cleanups to include rte_memcpy.h and string.h
where needed. Often the includes were happening by some other
header. And also removal of rte_memcpy.h where no longer needed.

The result is a 46% reduction in use of rte_memcpy.
The remaining rte_memcpy can be cleaned up later:
 - drivers with active maintenance (like mlx5);
 - changes to rte_memcpy which need benchmarking;
 - test code for rte_memcpy can be removed as last step.

No functional change, no warnings in all compilers including LTO.

Stephen Hemminger (61):
  devtools/cocci: add script to replace fixed size rte_memcpy
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

 app/graph/neigh.c                             |   8 +-
 app/test-bbdev/test_bbdev.c                   |   1 -
 app/test-eventdev/test_pipeline_common.c      |   8 +-
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
 app/test/test_crc.c                           |   7 +-
 app/test/test_cryptodev.c                     |  14 +--
 app/test/test_cryptodev.h                     |   1 +
 app/test/test_cryptodev_asym.c                |   1 -
 app/test/test_cryptodev_security_pdcp.c       |   1 -
 app/test/test_efd.c                           |   1 -
 app/test/test_efd_perf.c                      |   1 -
 app/test/test_event_crypto_adapter.c          |  12 +-
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
 drivers/bus/auxiliary/linux/auxiliary.c       |   1 -
 drivers/bus/fslmc/fslmc_bus.c                 |   1 -
 drivers/bus/fslmc/fslmc_vfio.c                |   1 -
 drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c      |   1 -
 drivers/bus/fslmc/portal/dpaa2_hw_dpci.c      |   1 -
 drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c     |   1 -
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |   1 -
 drivers/bus/pci/linux/pci.c                   |   1 -
 drivers/common/qat/qat_qp.c                   |  10 +-
 drivers/compress/qat/qat_comp.c               |   8 +-
 drivers/crypto/ccp/ccp_crypto.c               |  14 +--
 drivers/crypto/cnxk/cnxk_se.h                 |   2 +-
 drivers/crypto/ipsec_mb/pmd_snow3g.c          |   4 +-
 drivers/crypto/mlx5/mlx5_crypto_gcm.c         |  10 +-
 drivers/crypto/qat/qat_sym_session.c          |  33 +++---
 .../scheduler/rte_cryptodev_scheduler.c       |   6 +-
 drivers/crypto/scheduler/scheduler_failover.c |  12 +-
 drivers/crypto/zsda/zsda_crypto_session.c     |   6 +-
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
 drivers/ml/cnxk/cn10k_ml_model.c              |   8 +-
 drivers/ml/cnxk/cn10k_ml_ops.c                |   8 +-
 drivers/ml/cnxk/tvmrt_ml_model.c              |   9 +-
 drivers/ml/cnxk/tvmrt_ml_ops.c                |   6 +-
 drivers/net/af_xdp/rte_eth_af_xdp.c           |   2 +-
 drivers/net/avp/avp_ethdev.c                  |   4 +-
 drivers/net/axgbe/axgbe_ethdev.c              |   4 +-
 drivers/net/bnx2x/bnx2x.c                     |  32 +++---
 drivers/net/bnxt/bnxt_flow.c                  |  34 +++---
 drivers/net/bonding/rte_eth_bond_8023ad.c     |   4 +-
 drivers/net/bonding/rte_eth_bond_flow.c       |   2 +-
 drivers/net/cnxk/cnxk_eswitch_devargs.c       |   3 +-
 drivers/net/cnxk/cnxk_ethdev_ops.c            |   2 +-
 drivers/net/cnxk/cnxk_rep.c                   |   3 +-
 drivers/net/cnxk/cnxk_rep_flow.c              |   6 +-
 drivers/net/cnxk/cnxk_rep_msg.c               |   8 +-
 drivers/net/cnxk/cnxk_rep_ops.c               |   2 +-
 drivers/net/cnxk/cnxk_tm.c                    |   5 +-
 drivers/net/cxgbe/clip_tbl.c                  |   2 +-
 drivers/net/cxgbe/cxgbe_filter.c              |   8 +-
 drivers/net/cxgbe/l2t.c                       |   4 +-
 drivers/net/cxgbe/smt.c                       |  20 ++--
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c        |   1 -
 drivers/net/dpaa2/dpaa2_ethdev.c              |   1 -
 drivers/net/dpaa2/dpaa2_mux.c                 |  36 +++---
 drivers/net/dpaa2/dpaa2_recycle.c             |   1 -
 drivers/net/dpaa2/dpaa2_rxtx.c                |   1 -
 drivers/net/dpaa2/dpaa2_sparser.c             |   1 -
 drivers/net/dpaa2/dpaa2_tm.c                  |   2 +-
 drivers/net/enic/enic_main.c                  |   6 +-
 drivers/net/failsafe/failsafe_ops.c           |  10 +-
 drivers/net/gve/base/gve_adminq.c             |   2 +-
 drivers/net/hinic/hinic_pmd_ethdev.c          |   1 -
 drivers/net/hinic/hinic_pmd_flow.c            |  41 ++++---
 drivers/net/hns3/hns3_fdir.c                  |   2 +-
 drivers/net/hns3/hns3_flow.c                  |   4 +-
 drivers/net/intel/ice/ice_fdir_filter.c       |   4 +-
 drivers/net/memif/memif_socket.c              |   4 +-
 drivers/net/mlx5/mlx5_devx.c                  |   4 +-
 drivers/net/mlx5/mlx5_flow.c                  |  38 +++----
 drivers/net/mlx5/mlx5_flow_aso.c              |   6 +-
 drivers/net/mlx5/mlx5_flow_hw.c               |  31 +++---
 drivers/net/mlx5/mlx5_rx.c                    |   6 +-
 drivers/net/mlx5/mlx5_rxtx_vec.c              |   8 +-
 drivers/net/mvpp2/mrvl_tm.c                   |   2 +-
 drivers/net/netvsc/hn_ethdev.c                |   1 -
 drivers/net/nfp/flower/nfp_conntrack.c        |   2 +-
 drivers/net/nfp/flower/nfp_flower_flow.c      |  16 +--
 drivers/net/nfp/nfp_mtr.c                     |  10 +-
 drivers/net/ngbe/ngbe_pf.c                    |   4 +-
 drivers/net/ntnic/ntnic_ethdev.c              |  11 +-
 drivers/net/null/rte_eth_null.c               |  12 +-
 drivers/net/pcap/pcap_ethdev.c                |   9 +-
 drivers/net/qede/qede_main.c                  |   2 +-
 drivers/net/ring/rte_eth_ring.c               |   1 -
 drivers/net/sfc/sfc.c                         |   2 +-
 drivers/net/sfc/sfc_ef10_tx.c                 |   2 +-
 drivers/net/sfc/sfc_ethdev.c                  |  11 +-
 drivers/net/sfc/sfc_flow.c                    |  20 ++--
 drivers/net/sfc/sfc_flow_rss.c                |   2 +-
 drivers/net/sfc/sfc_mae.c                     |   2 +-
 drivers/net/sfc/sfc_rx.c                      |   2 +-
 drivers/net/sfc/sfc_tso.c                     |   2 +-
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
 drivers/net/xsc/xsc_dev.c                     |   2 +-
 drivers/net/zxdh/zxdh_common.c                |   7 +-
 drivers/net/zxdh/zxdh_flow.c                  |  67 ++++++-----
 drivers/net/zxdh/zxdh_msg.c                   |  15 +--
 drivers/net/zxdh/zxdh_mtr.c                   |  10 +-
 drivers/net/zxdh/zxdh_np.c                    |   1 -
 drivers/net/zxdh/zxdh_queue.c                 |   8 +-
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
 lib/acl/rte_acl_osdep.h                       |   1 -
 lib/cryptodev/rte_cryptodev.c                 |  12 +-
 lib/eal/common/eal_common_options.c           |   6 +-
 lib/efd/rte_efd.c                             |   3 +-
 lib/ethdev/rte_ethdev.c                       |   3 +-
 lib/ethdev/rte_flow.c                         | 104 ++++++++----------
 lib/eventdev/rte_event_crypto_adapter.c       |   2 +-
 lib/hash/rte_thash.c                          |   4 +-
 lib/lpm/rte_lpm6.c                            |   1 -
 lib/net/rte_ether.c                           |   2 +-
 lib/pcapng/rte_pcapng.c                       |   2 +-
 lib/pdcp/pdcp_process.c                       |  51 +++++----
 lib/rib/rte_rib6.h                            |   1 -
 lib/security/rte_security.c                   |   4 +-
 190 files changed, 746 insertions(+), 807 deletions(-)
 create mode 100644 devtools/cocci/rte_memcpy_fixed.cocci

-- 
2.53.0

