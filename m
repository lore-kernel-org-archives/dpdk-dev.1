Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0AEC36018
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 23:24:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 812E84014F;
	Thu,  3 Apr 2025 01:24:49 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id EB6F640144
 for <dev@dpdk.org>; Thu,  3 Apr 2025 01:24:47 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-6eb16dfa988so3115706d6.2
 for <dev@dpdk.org>; Wed, 02 Apr 2025 16:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743636287;
 x=1744241087; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iBvawC/CQXIBBua5lMO4ZcWjC3WSErb3ITricABw3gQ=;
 b=hi+oZ2Z/9kk0J2RrjDsPQO7MDwbewHrrNA7Sk7U+nncH9gQDykWf3d70nC/PkzWfva
 lwE+o70nY+ffyG1/x2Tiscy6dMEJP2wDUHnxVlwRZNsKlDw1wEMq94EMDxorPFJnkucz
 2RgXdjFO4LzGxjZTaETelOKY1ZkEPmm8vevx9b1rL+n6LFo4TthhNhJQUz3g5juPjwBD
 9IfKTLJinbfZSEYrkD57p2wutpDR+aPUabhh5il5ZAyUwpCYJIqFTJw6l7zTWADtJJZS
 HgFF2e7t38bRdAQPOOwMU+m2C41GlXacOn+BLSWpVzu3gLYFX8qjPniwybXnxWp28hiW
 5Yjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743636287; x=1744241087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iBvawC/CQXIBBua5lMO4ZcWjC3WSErb3ITricABw3gQ=;
 b=fqhaaC/KUxfVx/AdVVGsD1fON1wbvAaosCjKVnZdK9yF2Fij2gi8sLekZFIyHmV597
 Hwt5mV28Le9hLRmWAs98KhYpWHgIZ7m6cZUZFd8a4sm+egEUvjccyE8IrVNsCS48Pbn+
 HL1/79no9B7G1RENmQo2Y2yFG5sy3RIad5wAvul45YI3pzY3xpxJe8pstiPeL8HfLtbL
 zjuiEQJ0X2NCQqu2tGeJGiZLV9hMgo9yS5rk1v0BRGx/hSQ3wCqC1xdTR1yqdwFYpKd8
 4FK3Zlq9++qFtJpZLo7Q9dlD+0i68yyDBnoc0dgdnS2qSeWBWkZx9x/d4Gz4L3zGj/Zi
 TJxA==
X-Gm-Message-State: AOJu0Yxxq9iz0LtVO2WfbvKR2XzdZlYtABjpFj9yCO0hEu/q2aWmqOSZ
 vlsIIC0dsh/ym63DNB4PhsR6Gzpb7CWu5e1Zit1AGzFz+Skk1QXjfZxOvYFNQJUih5/oStqq6If
 9
X-Gm-Gg: ASbGnctEjVfKHpQFplGfGfWeyM0gRt6XWKG9kAAy+4W3dgZiSUEXHTGAP+C5i2RWmLf
 MSAQbvmT0rJBTaxNaSbE0umLII0htGERUKUwTI28DgPYl1/R2oD6bmu1TYhsMkfCnwZL1s7/7mo
 536re/RXgOZUvcbnAV40hboyTo+lzbKMM84I+M8x/vx3d0lK2a2dRd7ZiPWkHeadPDrHAzsQAQU
 wtbxEcdiwa9q+CQU41/JugGvKnfsAfshGu/qhZRA5yi6iJ4CvS9euiuegVx5XBhpcWbJaKb62aW
 ACFYAmTWLGO7RhUC+D4hW95AoZE+Hmff9SNPG1sIRmjU1NbsgtuwHMNhlRIQRh+P4+LJJRjsW0F
 q3h/RSJSFfrBen8sh/Tfc5nu72v8F
X-Google-Smtp-Source: AGHT+IEnvvG9bYTwV937FMnt0fQvGtDZ2kUEsXs7hCEpAEQfWhxX1twP/bq/eStspfCdWlUsbRXh1w==
X-Received: by 2002:a05:6214:234e:b0:6eb:26ed:4d87 with SMTP id
 6a1803df08f44-6eed6211263mr308502376d6.31.1743636286907; 
 Wed, 02 Apr 2025 16:24:46 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ef0f14e993sm672826d6.112.2025.04.02.16.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 16:24:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v12 00/10] replace use of term sanity check
Date: Wed,  2 Apr 2025 16:23:10 -0700
Message-ID: <20250402232441.440346-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20240529233811.663211-1-stephen@networkplumber.org>
References: <20240529233811.663211-1-stephen@networkplumber.org>
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

Remove use of expression sanity check across DPDK drivers
and documentation.

The term sanity-check is on the Tier 2 word list from the Inclusive
Naming project.
   https://inclusivenaming.org/word-lists/tier-2/sanity-check/

Rationale
	This term might be derogatory to neurodiverse people.
	Jargon, such as “sanity test”, is difficult to translate and is difficult
	to understand by readers whose first language is not English.

v12 - rebase on 25.07
      mark old mbuf API functions as deprecated

Stephen Hemminger (10):
  mbuf: replace term sanity check
  net/avp: replace use of rte_mbuf_sanity_check
  net/sfc: replace use of rte_mbuf_sanity_check
  examples: remove term sanity
  eal: replace use of sanity check in comments and messages
  test: replace use word sanity
  dts: replace use of sanity check in comment
  doc: remove sanity
  lib: replace use of sanity check in comments and
  drivers: remove use of term sanity check

 app/test/test_bitmap.c                        |  4 +-
 app/test/test_bpf.c                           |  6 +-
 app/test/test_common.c                        |  2 +-
 app/test/test_cryptodev.c                     |  2 +-
 app/test/test_distributor.c                   | 46 +++++------
 app/test/test_eal_flags.c                     | 20 ++---
 app/test/test_hash.c                          |  2 +-
 app/test/test_interrupts.c                    |  9 ++-
 app/test/test_link_bonding_mode4.c            |  2 +-
 app/test/test_mbuf.c                          | 30 +++----
 app/test/test_rawdev.c                        |  2 +-
 app/test/test_timer.c                         | 10 +--
 doc/guides/gpus/cuda.rst                      |  2 +-
 doc/guides/prog_guide/mbuf_lib.rst            |  4 +-
 doc/guides/rel_notes/deprecation.rst          |  3 +
 .../sample_app_ug/eventdev_pipeline.rst       |  2 +-
 doc/guides/tools/testbbdev.rst                |  8 +-
 drivers/bus/fslmc/qbman/qbman_sys_decl.h      |  2 +-
 drivers/common/cnxk/roc_nix_tm_ops.c          |  2 +-
 drivers/common/cnxk/roc_npa.c                 |  6 +-
 drivers/common/dpaax/caamflib/desc.h          |  2 +-
 drivers/common/mlx5/linux/mlx5_common_os.c    |  2 +-
 drivers/common/sfc_efx/base/ef10_nvram.c      |  4 +-
 drivers/common/sfc_efx/base/efx_rx.c          |  2 +-
 drivers/crypto/bcmfs/hw/bcmfs4_rm.c           |  6 +-
 drivers/crypto/bcmfs/hw/bcmfs5_rm.c           |  6 +-
 drivers/dma/idxd/idxd_pci.c                   |  2 +-
 drivers/event/opdl/opdl_evdev.c               |  2 +-
 drivers/event/opdl/opdl_evdev_init.c          |  2 +-
 drivers/net/ark/ark_ethdev.c                  |  8 +-
 drivers/net/ark/ark_ethdev_rx.c               |  2 +-
 drivers/net/avp/avp_ethdev.c                  | 18 ++---
 drivers/net/bnx2x/bnx2x.c                     |  2 +-
 drivers/net/bnx2x/bnx2x_stats.c               |  8 +-
 drivers/net/bnx2x/ecore_sp.c                  |  2 +-
 drivers/net/bnx2x/elink.c                     |  4 +-
 drivers/net/bnxt/bnxt_hwrm.c                  |  2 +-
 drivers/net/bnxt/hsi_struct_def_dpdk.h        |  2 +-
 drivers/net/bonding/rte_eth_bond_8023ad.c     |  2 +-
 drivers/net/cnxk/cnxk_ethdev.c                |  4 +-
 drivers/net/cxgbe/cxgbe_ethdev.c              | 10 +--
 drivers/net/cxgbe/cxgbevf_main.c              |  4 +-
 drivers/net/intel/fm10k/fm10k_ethdev.c        |  2 +-
 drivers/net/intel/fm10k/fm10k_rxtx.c          |  2 +-
 drivers/net/intel/ixgbe/ixgbe_fdir.c          |  2 +-
 drivers/net/intel/ixgbe/ixgbe_ipsec.c         |  2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          |  2 +-
 drivers/net/mlx4/mlx4.c                       |  2 +-
 drivers/net/mlx4/mlx4_flow.c                  |  6 +-
 drivers/net/mlx5/mlx5_flow_dv.c               |  2 +-
 drivers/net/mlx5/mlx5_flow_hw.c               |  6 +-
 drivers/net/mlx5/mlx5_rxq.c                   |  2 +-
 drivers/net/mlx5/mlx5_rxtx_vec.h              |  2 +-
 drivers/net/mvpp2/mrvl_qos.c                  |  2 +-
 drivers/net/nfp/flower/nfp_flower_flow.c      |  2 +-
 drivers/net/nfp/nfp_net_flow.c                |  2 +-
 drivers/net/ntnic/nthw/nthw_rac.c             |  2 +-
 drivers/net/qede/qede_rxtx.c                  |  6 +-
 drivers/net/ring/rte_eth_ring.c               |  7 +-
 drivers/net/sfc/sfc_dp_rx.h                   |  2 +-
 drivers/net/sfc/sfc_ef100_rx.c                |  6 +-
 drivers/net/sfc/sfc_ef10_essb_rx.c            |  4 +-
 drivers/net/sfc/sfc_ef10_rx.c                 |  4 +-
 drivers/net/sfc/sfc_rx.c                      |  2 +-
 drivers/net/txgbe/txgbe_ipsec.c               |  2 +-
 drivers/net/txgbe/txgbe_rxtx.c                |  2 +-
 dts/tests/TestSuite_blocklist.py              |  2 +-
 examples/ipsec-secgw/event_helper.c           |  2 +-
 examples/ipv4_multicast/main.c                |  2 +-
 examples/qos_sched/args.c                     |  2 +-
 lib/eal/common/eal_common_memory.c            |  2 +-
 lib/eal/common/eal_common_proc.c              |  3 +-
 lib/eal/common/eal_common_trace.c             |  2 +-
 lib/eal/common/eal_memcfg.h                   |  2 +-
 lib/eal/common/rte_malloc.c                   |  2 +-
 lib/eal/freebsd/eal.c                         |  2 +-
 lib/eal/linux/eal.c                           |  2 +-
 lib/eal/linux/eal_timer.c                     |  2 +-
 lib/eal/windows/eal.c                         |  2 +-
 lib/graph/graph.c                             |  2 +-
 lib/graph/graph_stats.c                       |  2 +-
 lib/graph/node.c                              |  2 +-
 lib/jobstats/rte_jobstats.c                   |  6 +-
 lib/mbuf/rte_mbuf.c                           | 23 ++++--
 lib/mbuf/rte_mbuf.h                           | 79 ++++++++++---------
 lib/mbuf/version.map                          |  1 +
 lib/metrics/rte_metrics.c                     |  2 +-
 lib/pcapng/rte_pcapng.c                       |  2 +-
 88 files changed, 244 insertions(+), 235 deletions(-)

-- 
2.47.2

