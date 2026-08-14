Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14936C5B572
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 20:19:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4C424014F;
	Fri, 14 Aug 2026 22:19:20 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 64C6D4013F
 for <dev@dpdk.org>; Fri, 14 Aug 2026 22:19:20 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso2020718a91.2
 for <dev@dpdk.org>; Fri, 14 Aug 2026 13:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786738759;
 x=1787343559; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tFgDvJBjnFIns0I8WiRi1zCgqF6tIPL8SZQq8HAo+nw=;
 b=cA93gr6ulpKLmp/Y4KE+yicxoymOOWROWyJyhsPzw+ktQgpQRPqDrLyfw2MyA3mY2r
 WrUqT53ESNe0gZoUcmaG/fubOiFYYhSkFESN+e+cjI0e8t5KmeLwnblebEISO1lXozCK
 MekIerUjI3ZdegJg09DRCuIxSi9NXK1I0csUGvsL3/CtwZ4l6tAQQGCGF0tAuNB+a7A/
 4VeQPGaHOwjfdxSOPSDcepyxtJBXK86OeHcJrVg3LOTr4yFs5WyeZmdt2fIbCcHHwvhT
 6SnKK2y7k9AcIm3BxYMvbXGQL8U+doEBh3PS67D9/OiFu3cKfBCCtEq9pfwmyBDzblpP
 cQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786738759; x=1787343559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tFgDvJBjnFIns0I8WiRi1zCgqF6tIPL8SZQq8HAo+nw=;
 b=VuFMir5G4AevmhNrs6YWukzn9RnBTGZ9bg6ffn3C8LtzShjjshqenlTI306XhyQSHk
 kn3RMXZWTsMdEfrcHftsCPzUdx7C3+GdwTdmD2FpO/jMqwWmNwkFrWWktUlV9FhTP5Ok
 OsI1KBQ9QNsYfdoc7HmyZ5RPXttWOt3g7I+JVvzZg/TW5gDAVRbA0VyDAn9aRvPSYCv7
 +G7ZpEgcQKEWqkDEtjOvp5ow87Tn7rZ54MpjVFQ4D2tBsZc1ykfhLq1+XnuZVwAGUQ93
 kal8IJiXvN62Yfqhd5x17tUqbnm8TDw09B4dL3uA2zMYwW7Hw8x4wfmBFwWo3s64UUam
 LCTg==
X-Gm-Message-State: AOJu0Ywx7WDehcgNAHYvumXpjnUpuLmcGBgWmMsFhD8t44icYxk/HRT9
 JfoMABU8o7q28+3nQ9A57N15koxfM2Gkz7ep3l1+p5vIXyyYeFV9Eov8tEIkVA4WN1Lj4pHAvTQ
 dFhhb
X-Gm-Gg: AR+sD10VrVKGR7ODqQTIthBsKWH2LVIFUL8Ev6FMZnM84x9yHsIIkhOsmrNJYLMtGWa
 nBc7slT3VEZshivFGJ+eOxB/8IhWfDp061x6de8m9Rw3SsIw3dSZoHThUMjLfHgrhyrZx1w3pcd
 9DhZ5SWYfHLtBc/N21NQ8uLOJFdDEg+D/KFsLxeu3xSSQBVWAYiFBPEafRF1pSaEC3bHqZiEJNr
 AIKjlbmZnf1QpiiPQETl/YuwAeexAZ94C2Q74WKv5WkvXuUuEFU1PLWeeQRp/tK7PRtwFBy0Bx5
 WYipVIvOeLX8HHYz8TgaeBw3T9B+oVRbCi752toLTmQufwe0Za5IDKJN1Gp05DT+xdIZjx3vQvl
 FQjwv8+RW+VQWINua0vFksRWPzVvLWM4WDY5d1/eM7XhdxJRrgji3mZCE3A3tdwcVeRL3APXCU7
 8GUXBWc5LkF9w8G/rVXPN3KCb/aO+WT6qjBFgoaWtpJxGrkVIb7t4WNbN7KIDrpapOSC8AJ8IBL
 Kx9AyKUTjQACAG9eLmHk4utpKA=
X-Received: by 2002:a17:90b:48ce:b0:390:b41a:b92b with SMTP id
 98e67ed59e1d1-3933b6d05c3mr10738179a91.4.1786738759036; 
 Fri, 14 Aug 2026 13:19:19 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141388bd5a7sm15553695c88.15.2026.08.14.13.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 13:19:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 00/16] per-queue statistics changes
Date: Fri, 14 Aug 2026 12:45:56 -0700
Message-ID: <20260814194757.329424-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530161151.873199-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
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

This series completes the removal of the per-queue stats mapping and
the RTE_ETHDEV_QUEUE_STAT_CNTRS definition.

The mapping mechanism (rte_eth_dev_set_{rx,tx}_queue_stats_mapping and
the queue_stats_mapping_set ethdev op) was a workaround for hardware
that could only expose a limited number of queue stat registers. It let
an application fold many queues onto a small set of counters. Since
25.11 queue statistics are filled in directly by the ethdev layer
indexed by queue id, so the mapping is no longer needed; the functions
were deprecated then by commit 2863cbd9ee6d.

The large patch is the tree wide removal of RTE_ETHDEV_QUEUE_STAT_CNTRS.
Instead ethdev allocates the temporary qstats array from the number of
queues the device reports, before querying the driver. Error counters
are no longer per-queue since that wasn't that helpful; they are global
now. The mapping of per-queue stats into xstats is unchanged and the
user visible xstats stay the same, so the impact is limited to the
driver API.

Several bugs turned up along the way and are split out as their own
fixes with Fixes: and Cc: stable tags where they apply to released
code.

A test for per-queue statistics is added to the pmd_ring test so this
path has coverage.

v4
 - work around RTE_MIN() not being treated as a constant expression by
   gcc, which turned an array declaration into a VLA
 - drop RTE_MIN4() and open code the comparison in bnxt instead
 - fix a couple of other bugs found in bnxt and zxdh
 - keep the ixgbe queue stats mapping registers programmed the same way
   as before this series, rather than changing what the hardware
   counters measure

v3
 - split the sxe2 null dereference into its own fix ahead of the rework
 - size the sxe2 multi-process shared qstats array for every queue the
   primary may write
 - reorder the cnxk fix ahead of the cnxk rework so it backports


Stephen Hemminger (16):
  net/virtio: remove unused queue stats mapping
  app/testpmd: remove leftover set qmap
  net/enic: remove unneeded ops initialization
  net/cnxk: fix Tx drops added to Rx queue errors
  net/cnxk: remove queue stats mapping
  net/e1000: remove queue stats mapping
  net/ixgbe: remove queue stats mapping
  net/txgbe: remove queue stats mapping
  net/sxe2: fix null dereference in stats get
  net/sxe2: remove queue stats mapping
  ethdev: remove support for queue stats mapping
  net/mvpp2: fix out of range Tx queue stats write
  net/ntnic: fix Tx errors reported as Rx queue errors
  net/xsc: fix Tx errors added to Rx queue errors
  ethdev: remove queue stats counter limit
  test/pmd_ring: test per-queue xstats

 app/test-pmd/cmdline.c                        |   6 -
 app/test-pmd/testpmd.h                        |   2 -
 app/test/test_pmd_ring.c                      | 145 ++++++++++++++++++
 doc/guides/howto/debug_troubleshoot.rst       |   5 +-
 doc/guides/nics/bnxt.rst                      |   4 +-
 doc/guides/nics/features.rst                  |  12 +-
 doc/guides/rel_notes/deprecation.rst          |   6 -
 doc/guides/rel_notes/release_26_11.rst        |   9 ++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst   |  11 --
 drivers/net/af_packet/rte_eth_af_packet.c     |  15 +-
 drivers/net/af_xdp/rte_eth_af_xdp.c           |  13 +-
 drivers/net/ark/ark_ethdev_rx.c               |   7 +-
 drivers/net/ark/ark_ethdev_tx.c               |   6 +-
 drivers/net/atlantic/atl_ethdev.c             |  13 +-
 drivers/net/atlantic/atl_rxtx.c               |   8 +-
 drivers/net/atlantic/atl_types.h              |  15 +-
 drivers/net/avp/avp_ethdev.c                  |  13 +-
 drivers/net/axgbe/axgbe_ethdev.c              |  13 +-
 drivers/net/bnxt/bnxt_ethdev.c                |   5 -
 drivers/net/bnxt/bnxt_reps.c                  |   9 +-
 drivers/net/bnxt/bnxt_stats.c                 |  40 ++---
 drivers/net/cnxk/cnxk_ethdev.c                |   1 -
 drivers/net/cnxk/cnxk_ethdev.h                |   6 -
 drivers/net/cnxk/cnxk_rep_ops.c               |   8 +-
 drivers/net/cnxk/cnxk_stats.c                 |  67 +++-----
 drivers/net/dpaa2/dpaa2_ethdev.c              |  17 +-
 drivers/net/ena/ena_ethdev.c                  |  21 +--
 drivers/net/enic/enic_ethdev.c                |  11 --
 drivers/net/hinic/hinic_pmd_ethdev.c          |  17 +-
 drivers/net/hinic3/hinic3_ethdev.c            |  13 +-
 drivers/net/intel/e1000/igc_ethdev.c          |  57 ++-----
 drivers/net/intel/e1000/igc_ethdev.h          |   2 -
 drivers/net/intel/fm10k/fm10k_ethdev.c        |  16 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        | 112 ++------------
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |   9 --
 drivers/net/ionic/ionic_lif.c                 |  24 +--
 drivers/net/mana/mana.c                       |  12 +-
 drivers/net/memif/rte_eth_memif.c             |  16 +-
 drivers/net/mlx4/mlx4_ethdev.c                |  14 +-
 drivers/net/mlx5/mlx5_rx.h                    |   3 +-
 drivers/net/mlx5/mlx5_stats.c                 |  22 ++-
 drivers/net/mvpp2/mrvl_ethdev.c               |  21 ++-
 drivers/net/nbl/nbl_dev/nbl_dev.c             |   2 -
 drivers/net/nbl/nbl_hw/nbl_txrx.c             |  12 +-
 drivers/net/netvsc/hn_ethdev.c                |  12 +-
 drivers/net/netvsc/hn_vf.c                    |   3 +-
 drivers/net/nfb/nfb_stats.c                   |  12 +-
 drivers/net/nfp/flower/nfp_flower.c           |   8 +-
 .../net/nfp/flower/nfp_flower_representor.c   |  32 ++--
 .../net/nfp/flower/nfp_flower_representor.h   |   4 +-
 drivers/net/nfp/nfp_ethdev.c                  |  13 ++
 drivers/net/nfp/nfp_ethdev_vf.c               |  13 ++
 drivers/net/nfp/nfp_net_common.c              |  36 ++---
 drivers/net/nfp/nfp_net_common.h              |   3 +-
 drivers/net/ngbe/ngbe_ethdev.c                |  34 +---
 drivers/net/ngbe/ngbe_ethdev.h                |  12 --
 drivers/net/ntnic/ntnic_ethdev.c              |  13 +-
 drivers/net/null/rte_eth_null.c               |  12 +-
 drivers/net/octeon_ep/otx_ep_ethdev.c         |  13 +-
 drivers/net/pcap/pcap_ethdev.c                |  14 +-
 drivers/net/qede/qede_ethdev.c                |  36 +----
 drivers/net/ring/rte_eth_ring.c               |  10 +-
 drivers/net/rnp/rnp_ethdev.c                  |  12 +-
 drivers/net/sxe2/sxe2_cmd_chnl.c              | 119 ++------------
 drivers/net/sxe2/sxe2_cmd_chnl.h              |  10 --
 drivers/net/sxe2/sxe2_ethdev.c                |   5 -
 drivers/net/sxe2/sxe2_mp.c                    |  17 +-
 drivers/net/sxe2/sxe2_mp.h                    |   7 +-
 drivers/net/sxe2/sxe2_stats.c                 |  84 +---------
 drivers/net/sxe2/sxe2_stats.h                 |   5 -
 drivers/net/tap/rte_eth_tap.c                 |  12 +-
 drivers/net/thunderx/nicvf_ethdev.c           |  24 +--
 drivers/net/txgbe/txgbe_ethdev.c              |  89 +----------
 drivers/net/txgbe/txgbe_ethdev.h              |  13 --
 drivers/net/vhost/rte_eth_vhost.c             |  14 +-
 drivers/net/virtio/virtio_ethdev.c            |  33 +---
 drivers/net/vmxnet3/vmxnet3_ethdev.c          |  13 +-
 drivers/net/xsc/xsc_ethdev.c                  |  15 +-
 drivers/net/zxdh/zxdh_ethdev_ops.c            |  24 +--
 lib/ethdev/ethdev_driver.h                    |  38 ++---
 lib/ethdev/ethdev_private.c                   |   2 -
 lib/ethdev/ethdev_trace.h                     |  20 ---
 lib/ethdev/ethdev_trace_points.c              |   6 -
 lib/ethdev/rte_ethdev.c                       | 128 +++++-----------
 lib/ethdev/rte_ethdev.h                       |  45 ------
 85 files changed, 648 insertions(+), 1207 deletions(-)

-- 
2.53.0

