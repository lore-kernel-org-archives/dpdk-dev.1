Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD2EC5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 18:04:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6638A40E09;
	Thu, 13 Aug 2026 20:04:13 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 9BE234026E
 for <dev@dpdk.org>; Thu, 13 Aug 2026 20:04:11 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2cab973140bso3976195ad.3
 for <dev@dpdk.org>; Thu, 13 Aug 2026 11:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786644250;
 x=1787249050; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VB9bgDpf87qlJAwIwRKgYhY3qS08iZ0rQs1DuI3fKjA=;
 b=i4nUEb77ZjL2WfgszVPS/jDYjqfz+rd2X7ZmKjmTWCLVMm7Ytl2cdeINkzGoezTWqP
 fqKys+KyUIxKJ8LDVeIPFzrAX5L9hQ1+cnBWF6uAFUnPPxBi8S97/inC84LRTUGlCsne
 d2uhbe/dJMneABKDqDBfsnFwmjJc/lxzpxwHH/jZAoXki13gw/Zk6qtPeijUQ8D02O2E
 JaCojPgA5YcP59J8fcuZLkTasZZkxKxse98LjcGG0TjR0GpbNA9J1X9APs+a3przNnur
 0qHZaS1Kec2ob2Zp3XG5poLxwUGl428tPQifvvZ2vM1lHDIdv5n+eoetisW7WzkntasN
 sH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786644250; x=1787249050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VB9bgDpf87qlJAwIwRKgYhY3qS08iZ0rQs1DuI3fKjA=;
 b=pJo68zKdoZLzEYYqCF3yokrQObYEeuBqAbWOyosqeMkkMPEaRn46KyCW1Nepn1Q6HY
 oljq42fHPa3BocnRyC7YAEylDSinXp5jddk9OcvOPZqvMcErVr7t6OlHMVJcLQjqlBSs
 Bsti7PtXVMOZR048Rzfwthuu7QgjYgg6+RHgwnxPn9GccnBCcYK+4H806srajJx+gmI7
 0/CSS34cWV1i+bXS0b6WhBeLfzLNtHu9EAApgTZFkPdPaaZI3wlIV++Q41RFnXqeR6cl
 RA7JjYGUnCyYIR9b0LAsathvVWlmYvPDvSlCGfzrO1CuUjN4kdO9aYnZPrDUYTnL9yhc
 /EpA==
X-Gm-Message-State: AOJu0Yxnnx9jR4WKpq+ShRkDfezpFc3UNOn6C8NRzHLSS8sOlICEitRa
 5QvxyFrDJm6X30q7l9sYvRPYEQJjM7mlK83qiZEYgSOhBO6lGSSEulifXSh4rsX5WAV8ZL97ax1
 B1xA5
X-Gm-Gg: AR+sD10wtbUeBjdABej/kIsvUMObqrHxg2tIR7eHFoqyhgvd53GnGM5Uaq2vgGJ4AUU
 tK/7gIb7RDpp4ED+KivucMDHesTWMwA4XKO3OPAZbGHXecOhkFClqIDtrohGD0V3N0EGahEdD/9
 iDUX1rb0RAB6kxPyYFKmM8woBb6rd5wieZHCrOMLCEjLyalVgC6IFiIwJrnZnZX7zJ1s/6YiNhZ
 ayXzklXD88Fhr3z5+MuT+uRfWW8S1ymJAnQnNw+1YtDfjO9Wxl0XfX/9bXMpQJhgR4elKtzpvhB
 iaHeXCi8zxPXb/ymASv/DS2B8RDd6i+Bmu+Ha2NqpEhEc9Oa9Ik5Sa5Gr6ii5uQ+/1+HrY8R+Qc
 nWVTbB8uIeVjZ/Qt3xV+EAmoO0+3bumLmVsDlaeL3/JRwlZgdCB3sEUE/dQETdGe92DjzRNHsD1
 MVYhT40l1vuZ2Oc+2CI86jdLjXowH27Tvh7AhV16h5Yp45Rc1l3xYbqdMGcX9Vv1afmE58mXxAM
 nq9hg3NWYRhkGANLb4pamWywhk=
X-Received: by 2002:a05:6a21:697:b0:3c3:875d:c538 with SMTP id
 adf61e73a8af0-3cc54f9bb27mr11371740637.8.1786644250398; 
 Thu, 13 Aug 2026 11:04:10 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31f7c8018cdsm3658930eec.13.2026.08.13.11.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 11:04:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 00/16] remove stats mapping an RTE_ETHDEV_QUEUE_STAT_CNTRS
Date: Thu, 13 Aug 2026 10:54:59 -0700
Message-ID: <20260813180402.622784-1-stephen@networkplumber.org>
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

This patch series completes the removal (with help of AI) of the queue
stats counters an mapping. There are also a couple of uncovered bugs
in the process.

The per-queue stats mapping mechanism (rte_eth_dev_set_{rx,tx}_queue_stats_mapping
and the queue_stats_mapping_set ethdev op) was a workaround for hardware that
could only expose a limited number of queue stat registers. It let an application
fold many queues onto a small set of counters. Since 25.11 queue statistics are
filled in directly by the ethdev layer indexed by queue id, so the mapping is no
longer needed; the functions were deprecated then by commit 2863cbd9ee6d.

Tried to split out the bug fixes where possible.

The big patch is a tree wide removal of RTE_ETHDEV_QUEUE_STAT_CNTRS.
Instead the rte_ethdev allocates the temporary qstats array based
on what the driver reports as number of queues; before querying the
driver for its stats. The error counters are no longer per-queue
because that wasn't that helpful, instead error counters are global.

The same logic to map per-queue stats into xstats still exists and
the user visible xstats remain the same. The impact is only to the
driver API.

Also added test for statistics in pmd_ring test to make sure
there is test coverage.

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
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        | 137 ++++-------------
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
 85 files changed, 665 insertions(+), 1215 deletions(-)

-- 
2.53.0

