Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68376CA0EF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:32:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63A7D40267;
	Tue, 19 Aug 2025 01:32:33 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 51D6D40262
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:32:31 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-45a1abf5466so25834035e9.0
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755559951;
 x=1756164751; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MPk2E4Bzl+GoiEACA7IUmNDi4P/O4VnK20DPVNtULGI=;
 b=hlpIghoFTkfuCh+8vElHMSV2dAFPsQP7mCU7fvgSQYlAXeuvPA6frczBSTjlk3xtqO
 by3gWFc/+W4Uv2Vv+X5scOIzKRWaARRwxSbY04oOJouRwZOAIlRdw0tGK71Taeouh+88
 a5E7FKCd+wzppJk8lzztFa7I0w4bbcMJszu7v7WUPsjfOqrIhlzXFZeM3EpVNfjt5hcl
 4GiPr0zWwAV2apadCR2zu1sDbZYy1wreWDObXbFzKdPmtztEFInIBJcAQ/K6hJSI1QEx
 PvXf+xMGgExTqFo7/ZipPOJ4J5VKz3VTje6pqP0g0LEaveUG9TjHraH/vIQJR25dqxBi
 iTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755559951; x=1756164751;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MPk2E4Bzl+GoiEACA7IUmNDi4P/O4VnK20DPVNtULGI=;
 b=ejXd42bX/UXMjetzBT2I2TvC9pveFKBsdTUFH46xtJ/YkJ+LzcijfEEZ1MHu5LBCjL
 ansr2Fw9jwrkrT5LQTw18EHf4Tma8yc3y4VJOVlO3zIYj1TRtIsgTsMlp4qDL9du3/y2
 mcTBJnxvwZZvkuZE2fl3xNkDTIJ9IdcS8LS4FWqn9cxhsAORBmbfXrr0339JFXCbX/fQ
 gDcGHY5BK/uoeZgBVuH1rcOGtHoIdMmNC9420bQnF4CjOxK+kyfqB4QZTcd5TnCMcwfB
 TzwnwUlUeHfolAnmM3W5J4cP1at31JZGMMITqbd4anEUPLm+92S30HdNFVDyl/7Hr+gL
 HtKA==
X-Gm-Message-State: AOJu0Yz1QNzcNmGN0s3nc3yRfO2wbF40jHLZlzvGBOJINR8J1oyXAwq6
 ifVbz381BIOx0TyGtya5y1tnM9bR68Y0HuFXVf5cUbihibIRTzKOx/lUum1lwaU5ZWVKtdsG457
 sqPlu
X-Gm-Gg: ASbGncsDJkIhEmMja87YraWKMjts5FOlZziS06HEBXvr3f0qlan7by7H1m8u8UcTieG
 ccCibRLd/T1A9mybb751zWT5Euv4MopWVz4WSVS5EZEPrG9Gy2XlpfRXS3YqaY9JEbfWhLS8e8M
 0Ppw5iajQ69F7NIANqVhKTz6LWEvabZb6OD3NrTzjQJHzPbk+mC5nh7u4nOvujI/iIxIvlYsVGm
 lULv08RJWXY82yxp/+AcOgON5qKU2+QZj2H1nNIE2ATPS/Wdrnzbn4tRBlitaBw7iN9oXbxTctr
 sqe2sm/bwTKrbiN2NCmtza6rKs52+h5HXrh7tgAJttVcOaGxy6n9XZ98czjdutigSl9M8udv9zX
 BM4BY1KLUbsLacc8uYpxUuEdyLKW5cqWbOa1J2FIIGP1tlnUv/teZgQ1JT3Rye4nhD0y3o6AH
X-Google-Smtp-Source: AGHT+IG9ZQazaTImfLd2T8HlfOZ17Fd77MZAPUnfvNqjwrMt08sRyTXvPNwxb6mGQUr4Kj8gOx0ZeQ==
X-Received: by 2002:a05:600c:4e94:b0:459:df1c:a13f with SMTP id
 5b1f17b1804b1-45b43eb1eafmr2096815e9.15.1755559950463; 
 Mon, 18 Aug 2025 16:32:30 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:32:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 00/47] resolve issues with sys/queue.h
Date: Mon, 18 Aug 2025 16:27:11 -0700
Message-ID: <20250818233102.180207-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

This patchset cleans up the queue.h macro problems in DPDK.
The root cause is that sys/queue.h in Linux is an old version
from early BSD; my best guess is that it is a BSD GPL license
issue that it never got updated. The Linux version is missing
several useful macros which leads to redefiniton, bugs, etc.

The patch starts out by introducing a version of the current
FreeBSD queue.h named as bsd_queue.h, then uses it across all
of DPDK. The file sys/queue.h is no longer used.
Ends up doing one line change on lots of files.

Stephen Hemminger (47):
  eal: add BSD version of queue.h
  net/nfp: fix use after free
  eal: use bsd_queue.h
  test: remove unnecessary inclusion of sys/queue.h
  testpmd: use bsd_queue.h
  dumpcap: use bsd_queue.h
  proc-info: remove unnecessary sys/queue.h
  doc: suggest bsd_queue.h
  test-pipeline: remove unnecessary use of sys/queue.h
  test-eventdev: use bsd_queue.h
  test-bbdev, test-cmdline, test-mldev: don't use sys/queue.h
  examples: replace use of sys/queue.h
  hash: do not include sys/queue.h
  lpm: do not include sys/queue.h
  log: replace use of sys/queue.h
  ethdev: replace use of sys/queue.h
  bpf: replace use of sys/queue.h
  mempool: do not need sys/queue.h
  lib: remove use of sys/queue.h
  bus/fslmc: use rte_tailq.h
  drivers/bus: replace use of sys/queue.h
  net/qede: use bsd_queue.h
  net/bnxt: remove use of sys/queue.h
  net/intel: remove use of sys/queue.h
  net/mlx5: remove unnecessary include of sys/queue.h
  net/tap: remove unnecessary include of sys/queue.h
  net/axgbe: replace use of sys/queue.h
  net/bnx2x: replace use of sys/queue.h
  net/bonding: replace use of sys/queue.h
  net/cxgbe: replace use of sys/queue.h
  net/enic: replace use of sys/queue.h
  net/failsafe: replace use of sys/queue.h
  net/memif: replace use of sys/queue.h
  net/mlx4: replace use of sys/queue.h
  net/ngbe: replace use of sys/queue.h
  net/ntnic: replace use of sys/queue.h
  net/sfc: replace use of sys/queue.h
  net/softnic: replace use of sys/queue.h
  net/thunderx: replace use of sys/queue.h
  net/txgbe: replace use of sys/queue.h
  net/vdev_netvsc: replace use of sys/queue.h
  net/vmxnet3: replace use of sys/queue.h
  net/zxdh: replace use of sys/queue.h
  net/dpaa2: replace use of sys/queue.h
  eal: remove no longer used windows version of queue.h
  net/mvpp2: replace local definition of FOREACH_SAFE
  drivers/raw: replace with TAILQ_FOREACH_SAFE

 app/dumpcap/main.c                            |   2 +-
 app/proc-info/main.c                          |   1 -
 app/test-bbdev/main.h                         |   1 -
 app/test-cmdline/cmdline_test.c               |   1 -
 app/test-eventdev/evt_test.c                  |   2 +-
 app/test-eventdev/evt_test.h                  |   1 -
 app/test-mldev/ml_test.h                      |   1 -
 app/test-pipeline/config.c                    |   1 -
 app/test-pipeline/init.c                      |   1 -
 app/test-pipeline/main.c                      |   1 -
 app/test-pipeline/runtime.c                   |   1 -
 app/test-pmd/5tswap.c                         |   2 -
 app/test-pmd/cmdline.c                        |   2 +-
 app/test-pmd/config.c                         |   2 +-
 app/test-pmd/csumonly.c                       |   1 -
 app/test-pmd/flowgen.c                        |   1 -
 app/test-pmd/hairpin.c                        |   1 -
 app/test-pmd/icmpecho.c                       |   1 -
 app/test-pmd/iofwd.c                          |   1 -
 app/test-pmd/macfwd.c                         |   1 -
 app/test-pmd/macswap.c                        |   1 -
 app/test-pmd/noisy_vnf.c                      |   1 -
 app/test-pmd/parameters.c                     |   1 -
 app/test-pmd/rxonly.c                         |   1 -
 app/test-pmd/testpmd.c                        |   1 -
 app/test-pmd/testpmd.h                        |   2 +-
 app/test-pmd/txonly.c                         |   1 -
 app/test/commands.c                           |   2 +-
 app/test/test.c                               |   1 -
 app/test/test.h                               |   2 +-
 app/test/test_atomic.c                        |   1 -
 app/test/test_cmdline_lib.c                   |   1 -
 app/test/test_func_reentrancy.c               |   1 -
 app/test/test_hash.c                          |   1 -
 app/test/test_hash_functions.c                |   1 -
 app/test/test_link_bonding.c                  |   1 -
 app/test/test_link_bonding_mode4.c            |   1 -
 app/test/test_link_bonding_rssconf.c          |   1 -
 app/test/test_logs.c                          |   1 -
 app/test/test_malloc.c                        |   1 -
 app/test/test_mbuf.c                          |   1 -
 app/test/test_mcslock.c                       |   1 -
 app/test/test_mempool.c                       |   1 -
 app/test/test_mempool_perf.c                  |   1 -
 app/test/test_memzone.c                       |   1 -
 app/test/test_mp_secondary.c                  |   1 -
 app/test/test_per_lcore.c                     |   1 -
 app/test/test_pflock.c                        |   1 -
 app/test/test_ring.c                          |   1 -
 app/test/test_rwlock.c                        |   1 -
 app/test/test_soring.c                        |   1 -
 app/test/test_spinlock.c                      |   1 -
 app/test/test_tailq.c                         |   1 -
 app/test/test_ticketlock.c                    |   1 -
 app/test/test_timer.c                         |   1 -
 doc/guides/contributing/coding_style.rst      |   4 +-
 drivers/bus/auxiliary/auxiliary_common.c      |   2 +-
 drivers/bus/auxiliary/private.h               |   2 +-
 drivers/bus/fslmc/bus_fslmc_driver.h          |   1 -
 drivers/bus/fslmc/fslmc_vfio.c                |   1 +
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |  11 +-
 drivers/bus/ifpga/ifpga_bus.c                 |   2 +-
 drivers/bus/pci/bsd/pci.c                     |   2 +-
 drivers/bus/pci/pci_common.c                  |   1 -
 drivers/bus/pci/pci_params.c                  |   2 -
 drivers/bus/pci/windows/pci.c                 |   3 +-
 drivers/bus/pci/windows/pci_netuio.c          |   2 -
 drivers/bus/platform/platform.c               |   2 +-
 drivers/bus/vdev/vdev.c                       |   1 -
 drivers/bus/vmbus/vmbus_common.c              |   1 -
 drivers/net/axgbe/axgbe_common.h              |   1 -
 drivers/net/bnx2x/bnx2x_ethdev.h              |   1 -
 drivers/net/bnxt/bnxt.h                       |   1 -
 drivers/net/bnxt/bnxt_filter.c                |   7 +-
 drivers/net/bnxt/bnxt_flow.c                  |   1 -
 drivers/net/bnxt/bnxt_vnic.h                  |   1 -
 drivers/net/bnxt/tf_ulp/bnxt_ulp.h            |   1 -
 drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c      |   1 -
 drivers/net/bonding/eth_bond_private.h        |   1 -
 drivers/net/bonding/rte_eth_bond_flow.c       |   1 -
 drivers/net/cxgbe/cxgbe_ethdev.c              |   2 +-
 drivers/net/cxgbe/cxgbe_main.c                |   1 -
 drivers/net/cxgbe/sge.c                       |   1 -
 drivers/net/dpaa2/dpaa2_flow.c                |   1 -
 drivers/net/dpaa2/dpaa2_mux.c                 |   1 -
 drivers/net/dpaa2/dpaa2_ptp.c                 |   1 -
 drivers/net/enic/enic.h                       |   1 -
 drivers/net/failsafe/failsafe_flow.c          |   1 -
 drivers/net/failsafe/failsafe_private.h       |   2 +-
 drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c |   1 -
 drivers/net/intel/e1000/e1000_ethdev.h        |   1 -
 drivers/net/intel/e1000/em_ethdev.c           |   1 -
 drivers/net/intel/e1000/em_rxtx.c             |   1 -
 drivers/net/intel/e1000/igb_ethdev.c          |   2 +-
 drivers/net/intel/e1000/igb_flow.c            |   2 +-
 drivers/net/intel/e1000/igb_rxtx.c            |   1 -
 drivers/net/intel/i40e/i40e_ethdev.c          |   9 +-
 drivers/net/intel/i40e/i40e_ethdev.h          |   1 -
 drivers/net/intel/i40e/i40e_fdir.c            |   2 +-
 drivers/net/intel/i40e/i40e_flow.c            |   1 -
 drivers/net/intel/i40e/i40e_hash.c            |   1 -
 drivers/net/intel/i40e/i40e_pf.c              |   1 -
 drivers/net/intel/i40e/i40e_rxtx.c            |   1 -
 drivers/net/intel/iavf/iavf.h                 |   1 -
 drivers/net/intel/iavf/iavf_ethdev.c          |   1 -
 drivers/net/intel/iavf/iavf_fdir.c            |   1 -
 drivers/net/intel/iavf/iavf_fsub.c            |   1 -
 drivers/net/intel/iavf/iavf_generic_flow.c    |   1 -
 drivers/net/intel/iavf/iavf_hash.c            |   1 -
 drivers/net/intel/iavf/iavf_rxtx.c            |   1 -
 drivers/net/intel/iavf/iavf_vchnl.c           |   7 -
 drivers/net/intel/ice/base/ice_osdep.h        |   2 +-
 drivers/net/intel/ice/ice_acl_filter.c        |   1 -
 drivers/net/intel/ice/ice_dcf.c               |   2 +-
 drivers/net/intel/ice/ice_dcf_ethdev.c        |   1 -
 drivers/net/intel/ice/ice_ethdev.c            |   8 +-
 drivers/net/intel/ice/ice_generic_flow.c      |   1 -
 drivers/net/intel/ice/ice_hash.c              |   1 -
 drivers/net/intel/ice/ice_switch_filter.c     |   1 -
 drivers/net/intel/idpf/base/idpf_osdep.h      |   9 +-
 drivers/net/intel/ipn3ke/ipn3ke_ethdev.h      |   1 -
 drivers/net/intel/ipn3ke/ipn3ke_flow.c        |   1 -
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |   2 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |   1 -
 drivers/net/intel/ixgbe/ixgbe_fdir.c          |   2 +-
 drivers/net/intel/ixgbe/ixgbe_flow.c          |   2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          |   1 -
 drivers/net/memif/memif_socket.h              |   1 -
 drivers/net/memif/rte_eth_memif.h             |   1 -
 drivers/net/mlx4/mlx4.h                       |   1 -
 drivers/net/mlx4/mlx4_flow.c                  |   2 +-
 drivers/net/mlx4/mlx4_flow.h                  |   1 -
 drivers/net/mlx4/mlx4_mr.h                    |   1 -
 drivers/net/mlx4/mlx4_rxtx.h                  |   1 -
 drivers/net/mlx5/hws/mlx5dr_internal.h        |   1 -
 drivers/net/mlx5/linux/mlx5_verbs.c           |   1 -
 drivers/net/mlx5/mlx5.h                       |   2 +-
 drivers/net/mlx5/mlx5_devx.c                  |   1 -
 drivers/net/mlx5/mlx5_flow.c                  |   2 +-
 drivers/net/mlx5/mlx5_flow.h                  |   2 +-
 drivers/net/mlx5/mlx5_flow_dv.c               |   1 -
 drivers/net/mlx5/mlx5_flow_verbs.c            |   2 +-
 drivers/net/mlx5/mlx5_rx.h                    |   1 -
 drivers/net/mlx5/mlx5_rxq.c                   |   2 +-
 drivers/net/mlx5/mlx5_rxtx.h                  |   1 -
 drivers/net/mlx5/mlx5_tx.h                    |   1 -
 drivers/net/mvpp2/mrvl_mtr.c                  |   8 +-
 drivers/net/nfp/nfp_mtr.c                     |  12 +-
 drivers/net/ngbe/ngbe_ethdev_vf.c             |   1 -
 drivers/net/ngbe/ngbe_rxtx.c                  |   1 -
 drivers/net/ntnic/ntnic_ethdev.c              |   1 -
 drivers/net/qede/qede_ethdev.h                |   3 +-
 drivers/net/qede/qede_filter.c                |   6 -
 drivers/net/sfc/sfc_dp.c                      |   2 +-
 drivers/net/sfc/sfc_dp.h                      |   1 -
 .../net/softnic/rte_eth_softnic_internals.h   |   1 -
 drivers/net/tap/rte_eth_tap.h                 |   1 -
 drivers/net/tap/tap_flow.c                    |   1 -
 drivers/net/thunderx/base/nicvf_bsvf.h        |   2 +-
 drivers/net/thunderx/base/nicvf_plat.h        |   1 +
 drivers/net/thunderx/nicvf_ethdev.c           |   1 -
 drivers/net/txgbe/txgbe_ethdev_vf.c           |   1 -
 drivers/net/txgbe/txgbe_fdir.c                |   2 +-
 drivers/net/txgbe/txgbe_flow.c                |   2 +-
 drivers/net/txgbe/txgbe_rxtx.c                |   1 -
 drivers/net/vdev_netvsc/vdev_netvsc.c         |   2 +-
 drivers/net/vmxnet3/vmxnet3_ethdev.c          |   1 -
 drivers/net/vmxnet3/vmxnet3_rxtx.c            |   1 -
 drivers/net/zxdh/zxdh_mtr.h                   |   1 -
 drivers/raw/ifpga/base/ifpga_enumerate.c      |   6 +-
 drivers/raw/ifpga/base/opae_intel_max10.c     |   8 +-
 examples/bbdev_app/main.c                     |   2 +-
 examples/bond/main.c                          |   2 +-
 examples/cmdline/main.c                       |   1 -
 examples/cmdline/parse_obj_list.h             |   2 +-
 examples/flow_filtering/main.c                |   1 -
 examples/helloworld/main.c                    |   2 +-
 examples/ip_fragmentation/main.c              |   2 +-
 examples/ip_pipeline/action.h                 |   2 +-
 examples/ip_pipeline/cryptodev.h              |   2 +-
 examples/ip_pipeline/link.h                   |   2 +-
 examples/ip_pipeline/mempool.h                |   2 +-
 examples/ip_pipeline/pipeline.h               |   2 +-
 examples/ip_pipeline/swq.h                    |   2 +-
 examples/ip_pipeline/tap.h                    |   2 +-
 examples/ip_pipeline/tmgr.h                   |   2 +-
 examples/ip_reassembly/main.c                 |   2 +-
 examples/ipsec-secgw/ipsec-secgw.c            |   2 +-
 examples/ipv4_multicast/main.c                |   2 +-
 examples/l2fwd-crypto/main.c                  |   2 +-
 examples/l2fwd-event/l2fwd_common.h           |   1 -
 examples/l2fwd-keepalive/ka-agent/main.c      |   1 -
 examples/l2fwd-keepalive/main.c               |   2 +-
 examples/l2fwd-macsec/main.c                  |   2 +-
 examples/l2fwd/main.c                         |   2 +-
 examples/l3fwd-graph/main.c                   |   2 +-
 examples/l3fwd-power/main.c                   |   2 +-
 examples/l3fwd/l3fwd_em.c                     |   1 -
 examples/l3fwd/l3fwd_lpm.c                    |   1 -
 examples/l3fwd/main.c                         |   2 +-
 examples/link_status_interrupt/main.c         |   2 +-
 .../client_server_mp/mp_client/client.c       |   1 -
 .../client_server_mp/mp_server/init.c         |   1 -
 .../client_server_mp/mp_server/main.c         |   2 +-
 examples/multi_process/hotplug_mp/main.c      |   1 -
 examples/multi_process/simple_mp/main.c       |   2 +-
 examples/multi_process/symmetric_mp/main.c    |   2 +-
 examples/server_node_efd/efd_node/node.c      |   1 -
 examples/server_node_efd/efd_server/init.c    |   1 -
 examples/server_node_efd/efd_server/main.c    |   1 -
 examples/service_cores/main.c                 |   1 -
 examples/timer/main.c                         |   2 +-
 examples/vhost/main.h                         |   2 +-
 examples/vm_power_manager/channel_manager.c   |   2 +-
 examples/vm_power_manager/channel_monitor.c   |   2 +-
 examples/vm_power_manager/main.c              |   2 +-
 examples/vmdq/main.c                          |   2 +-
 examples/vmdq_dcb/main.c                      |   2 +-
 lib/acl/rte_acl_osdep.h                       |   1 -
 lib/bbdev/rte_bbdev.c                         |   2 +-
 lib/bpf/bpf_load_elf.c                        |   1 -
 lib/bpf/bpf_pkt.c                             |   3 +-
 lib/cryptodev/cryptodev_pmd.c                 |   1 -
 lib/cryptodev/rte_cryptodev.c                 |   1 -
 lib/distributor/rte_distributor.c             |   2 +-
 lib/distributor/rte_distributor_single.c      |   2 +-
 lib/eal/common/eal_common_bus.c               |   2 +-
 lib/eal/common/eal_common_class.c             |   2 +-
 lib/eal/common/eal_common_dev.c               |   2 +-
 lib/eal/common/eal_common_tailqs.c            |   2 +-
 lib/eal/common/eal_common_trace.c             |   2 +-
 lib/eal/common/eal_private.h                  |   2 +-
 lib/eal/common/malloc_elem.c                  |   2 +-
 lib/eal/common/malloc_heap.c                  |   2 +-
 lib/eal/common/malloc_heap.h                  |   2 +-
 lib/eal/common/rte_malloc.c                   |   2 +-
 lib/eal/freebsd/eal.c                         |   2 +-
 lib/eal/freebsd/eal_interrupts.c              |   2 +-
 lib/eal/freebsd/eal_thread.c                  |   2 +-
 lib/eal/freebsd/include/rte_os.h              |   6 +-
 .../sys/queue.h => include/bsd_queue.h}       | 683 ++++++++++++------
 lib/eal/linux/eal_alarm.c                     |   2 +-
 lib/eal/linux/eal_interrupts.c                |   2 +-
 lib/eal/linux/include/rte_os.h                |   3 +-
 lib/eal/windows/eal_alarm.c                   |   2 +-
 lib/efd/rte_efd.c                             |   1 -
 lib/ethdev/ethdev_private.h                   |   3 +-
 lib/ethdev/rte_ethdev.c                       |   2 +-
 lib/fib/rte_fib.c                             |   1 -
 lib/fib/rte_fib6.c                            |   1 -
 lib/gpudev/gpudev_driver.h                    |   1 -
 lib/graph/graph_private.h                     |   1 -
 lib/hash/rte_cuckoo_hash.c                    |   1 -
 lib/hash/rte_fbk_hash.c                       |   1 -
 lib/hash/rte_thash.c                          |   1 -
 lib/ip_frag/ip_frag_common.h                  |   3 +-
 lib/log/log.c                                 |   2 +-
 lib/lpm/rte_lpm.c                             |   1 -
 lib/lpm/rte_lpm6.c                            |   1 -
 lib/mbuf/rte_mbuf_dyn.c                       |   1 -
 lib/mempool/rte_mempool.c                     |   1 -
 lib/pipeline/rte_swx_ctl.c                    |   1 -
 lib/pipeline/rte_swx_pipeline_internal.h      |   3 +-
 lib/pmu/pmu.c                                 |   1 -
 lib/reorder/rte_reorder.c                     |   1 -
 lib/rib/rte_rib.c                             |   1 -
 lib/rib/rte_rib6.c                            |   1 -
 lib/ring/rte_ring.c                           |   1 -
 lib/stack/rte_stack.c                         |   1 -
 lib/vhost/fd_man.h                            |   1 -
 lib/vhost/socket.c                            |   2 +-
 lib/vhost/vdpa.c                              |   2 -
 lib/vhost/vhost.h                             |   2 +-
 273 files changed, 589 insertions(+), 562 deletions(-)
 rename lib/eal/{windows/include/sys/queue.h => include/bsd_queue.h} (52%)

-- 
2.47.2



Stephen Hemminger (47):
  eal: add BSD version of queue.h
  net/nfp: fix use after free
  eal: use bsd_queue.h
  test: remove unnecessary inclusion of sys/queue.h
  testpmd: use bsd_queue.h
  dumpcap: use bsd_queue.h
  proc-info: remove unnecessary sys/queue.h
  doc: suggest bsd_queue.h
  test-pipeline: remove unnecessary use of sys/queue.h
  test-eventdev: use bsd_queue.h
  test-bbdev, test-cmdline, test-mldev: don't use sys/queue.h
  examples: replace use of sys/queue.h
  hash: do not include sys/queue.h
  lpm: do not include sys/queue.h
  log: replace use of sys/queue.h
  ethdev: replace use of sys/queue.h
  bpf: replace use of sys/queue.h
  mempool: do not need sys/queue.h
  lib: remove use of sys/queue.h
  bus/fslmc: use rte_tailq.h
  drivers/bus: replace use of sys/queue.h
  net/qede: use bsd_queue.h
  net/bnxt: remove use of sys/queue.h
  net/intel: remove use of sys/queue.h
  net/mlx5: remove unnecessary include of sys/queue.h
  net/tap: remove unnecessary include of sys/queue.h
  net/axgbe: replace use of sys/queue.h
  net/bnx2x: replace use of sys/queue.h
  net/bonding: replace use of sys/queue.h
  net/cxgbe: replace use of sys/queue.h
  net/enic: replace use of sys/queue.h
  net/failsafe: replace use of sys/queue.h
  net/memif: replace use of sys/queue.h
  net/mlx4: replace use of sys/queue.h
  net/ngbe: replace use of sys/queue.h
  net/ntnic: replace use of sys/queue.h
  net/sfc: replace use of sys/queue.h
  net/softnic: replace use of sys/queue.h
  net/thunderx: replace use of sys/queue.h
  net/txgbe: replace use of sys/queue.h
  net/vdev_netvsc: replace use of sys/queue.h
  net/vmxnet3: replace use of sys/queue.h
  net/zxdh: replace use of sys/queue.h
  net/dpaa2: replace use of sys/queue.h
  eal: remove no longer used windows version of queue.h
  net/mvpp2: replace local definition of FOREACH_SAFE
  drivers/raw: replace with TAILQ_FOREACH_SAFE

 app/dumpcap/main.c                            |   2 +-
 app/proc-info/main.c                          |   1 -
 app/test-bbdev/main.h                         |   1 -
 app/test-cmdline/cmdline_test.c               |   1 -
 app/test-eventdev/evt_test.c                  |   2 +-
 app/test-eventdev/evt_test.h                  |   1 -
 app/test-mldev/ml_test.h                      |   1 -
 app/test-pipeline/config.c                    |   1 -
 app/test-pipeline/init.c                      |   1 -
 app/test-pipeline/main.c                      |   1 -
 app/test-pipeline/runtime.c                   |   1 -
 app/test-pmd/5tswap.c                         |   2 -
 app/test-pmd/cmdline.c                        |   2 +-
 app/test-pmd/config.c                         |   2 +-
 app/test-pmd/csumonly.c                       |   1 -
 app/test-pmd/flowgen.c                        |   1 -
 app/test-pmd/hairpin.c                        |   1 -
 app/test-pmd/icmpecho.c                       |   1 -
 app/test-pmd/iofwd.c                          |   1 -
 app/test-pmd/macfwd.c                         |   1 -
 app/test-pmd/macswap.c                        |   1 -
 app/test-pmd/noisy_vnf.c                      |   1 -
 app/test-pmd/parameters.c                     |   1 -
 app/test-pmd/rxonly.c                         |   1 -
 app/test-pmd/testpmd.c                        |   1 -
 app/test-pmd/testpmd.h                        |   2 +-
 app/test-pmd/txonly.c                         |   1 -
 app/test/commands.c                           |   2 +-
 app/test/test.c                               |   1 -
 app/test/test.h                               |   2 +-
 app/test/test_atomic.c                        |   1 -
 app/test/test_cmdline_lib.c                   |   1 -
 app/test/test_func_reentrancy.c               |   1 -
 app/test/test_hash.c                          |   1 -
 app/test/test_hash_functions.c                |   1 -
 app/test/test_link_bonding.c                  |   1 -
 app/test/test_link_bonding_mode4.c            |   1 -
 app/test/test_link_bonding_rssconf.c          |   1 -
 app/test/test_logs.c                          |   1 -
 app/test/test_malloc.c                        |   1 -
 app/test/test_mbuf.c                          |   1 -
 app/test/test_mcslock.c                       |   1 -
 app/test/test_mempool.c                       |   1 -
 app/test/test_mempool_perf.c                  |   1 -
 app/test/test_memzone.c                       |   1 -
 app/test/test_mp_secondary.c                  |   1 -
 app/test/test_per_lcore.c                     |   1 -
 app/test/test_pflock.c                        |   1 -
 app/test/test_ring.c                          |   1 -
 app/test/test_rwlock.c                        |   1 -
 app/test/test_soring.c                        |   1 -
 app/test/test_spinlock.c                      |   1 -
 app/test/test_tailq.c                         |   1 -
 app/test/test_ticketlock.c                    |   1 -
 app/test/test_timer.c                         |   1 -
 doc/guides/contributing/coding_style.rst      |   4 +-
 drivers/bus/auxiliary/auxiliary_common.c      |   2 +-
 drivers/bus/auxiliary/private.h               |   2 +-
 drivers/bus/fslmc/bus_fslmc_driver.h          |   1 -
 drivers/bus/fslmc/fslmc_vfio.c                |   1 +
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |  11 +-
 drivers/bus/ifpga/ifpga_bus.c                 |   2 +-
 drivers/bus/pci/bsd/pci.c                     |   2 +-
 drivers/bus/pci/pci_common.c                  |   1 -
 drivers/bus/pci/pci_params.c                  |   2 -
 drivers/bus/pci/windows/pci.c                 |   3 +-
 drivers/bus/pci/windows/pci_netuio.c          |   2 -
 drivers/bus/platform/platform.c               |   2 +-
 drivers/bus/vdev/vdev.c                       |   1 -
 drivers/bus/vmbus/vmbus_common.c              |   1 -
 drivers/net/axgbe/axgbe_common.h              |   1 -
 drivers/net/bnx2x/bnx2x_ethdev.h              |   1 -
 drivers/net/bnxt/bnxt.h                       |   1 -
 drivers/net/bnxt/bnxt_filter.c                |   7 +-
 drivers/net/bnxt/bnxt_flow.c                  |   1 -
 drivers/net/bnxt/bnxt_vnic.h                  |   1 -
 drivers/net/bnxt/tf_ulp/bnxt_ulp.h            |   1 -
 drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c      |   1 -
 drivers/net/bonding/eth_bond_private.h        |   1 -
 drivers/net/bonding/rte_eth_bond_flow.c       |   1 -
 drivers/net/cxgbe/cxgbe_ethdev.c              |   2 +-
 drivers/net/cxgbe/cxgbe_main.c                |   1 -
 drivers/net/cxgbe/sge.c                       |   1 -
 drivers/net/dpaa2/dpaa2_flow.c                |   1 -
 drivers/net/dpaa2/dpaa2_mux.c                 |   1 -
 drivers/net/dpaa2/dpaa2_ptp.c                 |   1 -
 drivers/net/enic/enic.h                       |   1 -
 drivers/net/failsafe/failsafe_flow.c          |   1 -
 drivers/net/failsafe/failsafe_private.h       |   2 +-
 drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c |   1 -
 drivers/net/intel/e1000/e1000_ethdev.h        |   1 -
 drivers/net/intel/e1000/em_ethdev.c           |   1 -
 drivers/net/intel/e1000/em_rxtx.c             |   1 -
 drivers/net/intel/e1000/igb_ethdev.c          |   2 +-
 drivers/net/intel/e1000/igb_flow.c            |   2 +-
 drivers/net/intel/e1000/igb_rxtx.c            |   1 -
 drivers/net/intel/i40e/i40e_ethdev.c          |   9 +-
 drivers/net/intel/i40e/i40e_ethdev.h          |   1 -
 drivers/net/intel/i40e/i40e_fdir.c            |   2 +-
 drivers/net/intel/i40e/i40e_flow.c            |   1 -
 drivers/net/intel/i40e/i40e_hash.c            |   1 -
 drivers/net/intel/i40e/i40e_pf.c              |   1 -
 drivers/net/intel/i40e/i40e_rxtx.c            |   1 -
 drivers/net/intel/iavf/iavf.h                 |   1 -
 drivers/net/intel/iavf/iavf_ethdev.c          |   1 -
 drivers/net/intel/iavf/iavf_fdir.c            |   1 -
 drivers/net/intel/iavf/iavf_fsub.c            |   1 -
 drivers/net/intel/iavf/iavf_generic_flow.c    |   1 -
 drivers/net/intel/iavf/iavf_hash.c            |   1 -
 drivers/net/intel/iavf/iavf_rxtx.c            |   1 -
 drivers/net/intel/iavf/iavf_vchnl.c           |   7 -
 drivers/net/intel/ice/base/ice_osdep.h        |   2 +-
 drivers/net/intel/ice/ice_acl_filter.c        |   1 -
 drivers/net/intel/ice/ice_dcf.c               |   2 +-
 drivers/net/intel/ice/ice_dcf_ethdev.c        |   1 -
 drivers/net/intel/ice/ice_ethdev.c            |   8 +-
 drivers/net/intel/ice/ice_generic_flow.c      |   1 -
 drivers/net/intel/ice/ice_hash.c              |   1 -
 drivers/net/intel/ice/ice_switch_filter.c     |   1 -
 drivers/net/intel/idpf/base/idpf_osdep.h      |   9 +-
 drivers/net/intel/ipn3ke/ipn3ke_ethdev.h      |   1 -
 drivers/net/intel/ipn3ke/ipn3ke_flow.c        |   1 -
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |   2 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |   1 -
 drivers/net/intel/ixgbe/ixgbe_fdir.c          |   2 +-
 drivers/net/intel/ixgbe/ixgbe_flow.c          |   2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          |   1 -
 drivers/net/memif/memif_socket.h              |   1 -
 drivers/net/memif/rte_eth_memif.h             |   1 -
 drivers/net/mlx4/mlx4.h                       |   1 -
 drivers/net/mlx4/mlx4_flow.c                  |   2 +-
 drivers/net/mlx4/mlx4_flow.h                  |   1 -
 drivers/net/mlx4/mlx4_mr.h                    |   1 -
 drivers/net/mlx4/mlx4_rxtx.h                  |   1 -
 drivers/net/mlx5/hws/mlx5dr_internal.h        |   1 -
 drivers/net/mlx5/linux/mlx5_verbs.c           |   1 -
 drivers/net/mlx5/mlx5.h                       |   2 +-
 drivers/net/mlx5/mlx5_devx.c                  |   1 -
 drivers/net/mlx5/mlx5_flow.c                  |   2 +-
 drivers/net/mlx5/mlx5_flow.h                  |   2 +-
 drivers/net/mlx5/mlx5_flow_dv.c               |   1 -
 drivers/net/mlx5/mlx5_flow_verbs.c            |   2 +-
 drivers/net/mlx5/mlx5_rx.h                    |   1 -
 drivers/net/mlx5/mlx5_rxq.c                   |   2 +-
 drivers/net/mlx5/mlx5_rxtx.h                  |   1 -
 drivers/net/mlx5/mlx5_tx.h                    |   1 -
 drivers/net/mvpp2/mrvl_mtr.c                  |   8 +-
 drivers/net/nfp/nfp_mtr.c                     |  12 +-
 drivers/net/ngbe/ngbe_ethdev_vf.c             |   1 -
 drivers/net/ngbe/ngbe_rxtx.c                  |   1 -
 drivers/net/ntnic/ntnic_ethdev.c              |   1 -
 drivers/net/qede/qede_ethdev.h                |   3 +-
 drivers/net/qede/qede_filter.c                |   6 -
 drivers/net/sfc/sfc_dp.c                      |   2 +-
 drivers/net/sfc/sfc_dp.h                      |   1 -
 .../net/softnic/rte_eth_softnic_internals.h   |   1 -
 drivers/net/tap/rte_eth_tap.h                 |   1 -
 drivers/net/tap/tap_flow.c                    |   1 -
 drivers/net/thunderx/base/nicvf_bsvf.h        |   2 +-
 drivers/net/thunderx/base/nicvf_plat.h        |   1 +
 drivers/net/thunderx/nicvf_ethdev.c           |   1 -
 drivers/net/txgbe/txgbe_ethdev_vf.c           |   1 -
 drivers/net/txgbe/txgbe_fdir.c                |   2 +-
 drivers/net/txgbe/txgbe_flow.c                |   2 +-
 drivers/net/txgbe/txgbe_rxtx.c                |   1 -
 drivers/net/vdev_netvsc/vdev_netvsc.c         |   2 +-
 drivers/net/vmxnet3/vmxnet3_ethdev.c          |   1 -
 drivers/net/vmxnet3/vmxnet3_rxtx.c            |   1 -
 drivers/net/zxdh/zxdh_mtr.h                   |   1 -
 drivers/raw/ifpga/base/ifpga_enumerate.c      |   6 +-
 drivers/raw/ifpga/base/opae_intel_max10.c     |   8 +-
 examples/bbdev_app/main.c                     |   2 +-
 examples/bond/main.c                          |   2 +-
 examples/cmdline/main.c                       |   1 -
 examples/cmdline/parse_obj_list.h             |   2 +-
 examples/flow_filtering/main.c                |   1 -
 examples/helloworld/main.c                    |   2 +-
 examples/ip_fragmentation/main.c              |   2 +-
 examples/ip_pipeline/action.h                 |   2 +-
 examples/ip_pipeline/cryptodev.h              |   2 +-
 examples/ip_pipeline/link.h                   |   2 +-
 examples/ip_pipeline/mempool.h                |   2 +-
 examples/ip_pipeline/pipeline.h               |   2 +-
 examples/ip_pipeline/swq.h                    |   2 +-
 examples/ip_pipeline/tap.h                    |   2 +-
 examples/ip_pipeline/tmgr.h                   |   2 +-
 examples/ip_reassembly/main.c                 |   2 +-
 examples/ipsec-secgw/ipsec-secgw.c            |   2 +-
 examples/ipv4_multicast/main.c                |   2 +-
 examples/l2fwd-crypto/main.c                  |   2 +-
 examples/l2fwd-event/l2fwd_common.h           |   1 -
 examples/l2fwd-keepalive/ka-agent/main.c      |   1 -
 examples/l2fwd-keepalive/main.c               |   2 +-
 examples/l2fwd-macsec/main.c                  |   2 +-
 examples/l2fwd/main.c                         |   2 +-
 examples/l3fwd-graph/main.c                   |   2 +-
 examples/l3fwd-power/main.c                   |   2 +-
 examples/l3fwd/l3fwd_em.c                     |   1 -
 examples/l3fwd/l3fwd_lpm.c                    |   1 -
 examples/l3fwd/main.c                         |   2 +-
 examples/link_status_interrupt/main.c         |   2 +-
 .../client_server_mp/mp_client/client.c       |   1 -
 .../client_server_mp/mp_server/init.c         |   1 -
 .../client_server_mp/mp_server/main.c         |   2 +-
 examples/multi_process/hotplug_mp/main.c      |   1 -
 examples/multi_process/simple_mp/main.c       |   2 +-
 examples/multi_process/symmetric_mp/main.c    |   2 +-
 examples/server_node_efd/efd_node/node.c      |   1 -
 examples/server_node_efd/efd_server/init.c    |   1 -
 examples/server_node_efd/efd_server/main.c    |   1 -
 examples/service_cores/main.c                 |   1 -
 examples/timer/main.c                         |   2 +-
 examples/vhost/main.h                         |   2 +-
 examples/vm_power_manager/channel_manager.c   |   2 +-
 examples/vm_power_manager/channel_monitor.c   |   2 +-
 examples/vm_power_manager/main.c              |   2 +-
 examples/vmdq/main.c                          |   2 +-
 examples/vmdq_dcb/main.c                      |   2 +-
 lib/acl/rte_acl_osdep.h                       |   1 -
 lib/bbdev/rte_bbdev.c                         |   2 +-
 lib/bpf/bpf_load_elf.c                        |   1 -
 lib/bpf/bpf_pkt.c                             |   3 +-
 lib/cryptodev/cryptodev_pmd.c                 |   1 -
 lib/cryptodev/rte_cryptodev.c                 |   1 -
 lib/distributor/rte_distributor.c             |   2 +-
 lib/distributor/rte_distributor_single.c      |   2 +-
 lib/eal/common/eal_common_bus.c               |   2 +-
 lib/eal/common/eal_common_class.c             |   2 +-
 lib/eal/common/eal_common_dev.c               |   2 +-
 lib/eal/common/eal_common_tailqs.c            |   2 +-
 lib/eal/common/eal_common_trace.c             |   2 +-
 lib/eal/common/eal_private.h                  |   2 +-
 lib/eal/common/malloc_elem.c                  |   2 +-
 lib/eal/common/malloc_heap.c                  |   2 +-
 lib/eal/common/malloc_heap.h                  |   2 +-
 lib/eal/common/rte_malloc.c                   |   2 +-
 lib/eal/freebsd/eal.c                         |   2 +-
 lib/eal/freebsd/eal_interrupts.c              |   2 +-
 lib/eal/freebsd/eal_thread.c                  |   2 +-
 lib/eal/freebsd/include/rte_os.h              |   6 +-
 .../sys/queue.h => include/bsd_queue.h}       | 683 ++++++++++++------
 lib/eal/include/meson.build                   |   1 +
 lib/eal/linux/eal_alarm.c                     |   2 +-
 lib/eal/linux/eal_interrupts.c                |   2 +-
 lib/eal/linux/include/rte_os.h                |   3 +-
 lib/eal/windows/eal_alarm.c                   |   2 +-
 lib/efd/rte_efd.c                             |   1 -
 lib/ethdev/ethdev_private.h                   |   3 +-
 lib/ethdev/rte_ethdev.c                       |   2 +-
 lib/fib/rte_fib.c                             |   1 -
 lib/fib/rte_fib6.c                            |   1 -
 lib/gpudev/gpudev_driver.h                    |   1 -
 lib/graph/graph_private.h                     |   1 -
 lib/hash/rte_cuckoo_hash.c                    |   1 -
 lib/hash/rte_fbk_hash.c                       |   1 -
 lib/hash/rte_thash.c                          |   1 -
 lib/ip_frag/ip_frag_common.h                  |   3 +-
 lib/log/log.c                                 |   2 +-
 lib/lpm/rte_lpm.c                             |   1 -
 lib/lpm/rte_lpm6.c                            |   1 -
 lib/mbuf/rte_mbuf_dyn.c                       |   1 -
 lib/mempool/rte_mempool.c                     |   1 -
 lib/pipeline/rte_swx_ctl.c                    |   1 -
 lib/pipeline/rte_swx_pipeline_internal.h      |   3 +-
 lib/pmu/pmu.c                                 |   1 -
 lib/reorder/rte_reorder.c                     |   1 -
 lib/rib/rte_rib.c                             |   1 -
 lib/rib/rte_rib6.c                            |   1 -
 lib/ring/rte_ring.c                           |   1 -
 lib/stack/rte_stack.c                         |   1 -
 lib/vhost/fd_man.h                            |   1 -
 lib/vhost/socket.c                            |   2 +-
 lib/vhost/vdpa.c                              |   2 -
 lib/vhost/vhost.h                             |   2 +-
 274 files changed, 590 insertions(+), 562 deletions(-)
 rename lib/eal/{windows/include/sys/queue.h => include/bsd_queue.h} (52%)

-- 
2.47.2

