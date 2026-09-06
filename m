Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D28C79F85
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Sep 2026 17:11:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C51954027E;
	Sun,  6 Sep 2026 19:11:53 +0200 (CEST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id 44A504026D
 for <dev@dpdk.org>; Sun,  6 Sep 2026 19:11:52 +0200 (CEST)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-8534d507f59so2924235b3a.0
 for <dev@dpdk.org>; Sun, 06 Sep 2026 10:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788714711;
 x=1789319511; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rXE3CZZtt+ANHmQGu7X/4MZT65QAzyA+YIkSDRprShM=;
 b=NPI3IqLRCXe7m80FK/H2qbZT2LiWgrbXI+rzxxkm1ACjrZHcQe6XY+ar7nslkoMHdM
 DQYimP6oML56rpN8m0xMBO2WV24pqq2Xc1wmoQN982ZPNPODta2T8/H77YHaAGNBrlVF
 mdW3oFCdLE0wykzfrgvNujsClkV+QsD1tuPNiQRWQ2NZFrbaQXxzk5OFbtEV59122h+m
 bwtYQmOd8T6b0l55y+E8crb3elXnJkkWOZA0TG6zM4t+I8ufJskJAUAetoXZU7SBkMk9
 M/SIANOTpx0AIAY28x5P1O/BO60Ovw+6IffxxKAYJ/RFZltkCvpYqa7ciX8mSWnoKjmu
 oKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788714711; x=1789319511;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rXE3CZZtt+ANHmQGu7X/4MZT65QAzyA+YIkSDRprShM=;
 b=DdFlhiNj/ikeuH4jua2O8IC2vGvjXCkA3K2Bog2sYFkJLmcWRLoq8gUNv3DMEE3Yos
 viMPVvT95F5mjXNiQ86Bi+wUurT976ZLxLREk6jfPoM02CC84/iqhiuP2+AjqVs387dQ
 Rp4JUvW0bgizLTT1Eah/amMTcwRA4XLiVzPnZ9Y6v6ub4NFd6HIj4z8TkzgNlkwxYcRa
 9nZmzUr48q6XHpXLfwk+I6imIdwXN9QJCOIQ/ZRskCE3zNtGlbjgiAt4zFEOMI3HV0gM
 scKoBFDx/Qt889mazFJn31M2mrApHyLJcseyGce1Pve3hrP6sk9PjbT1BhABcid1TN8z
 EzRw==
X-Gm-Message-State: AFuF++n5wIHpQhLs6APCFuHdIb5eKFMgkbYufIUWKabG2e59B2HRZhiZ
 jY7x0w0ht9BkezBLd8iR6B4Z3fmL37pZT3r4UaF0ONuU0TlH/+QoU9FFQ2tzb5KK3JPINRUhUar
 s96zt
X-Gm-Gg: AYBFou0/lPT+Bk87JYTIShwbQagH4OmFmdDhqjVc4o/aRljn9a16nhg5qvwIydvFh+T
 /oyDXhFzgGoskj96MNsabi91Q4csKOtwdxgxrLJAFheQyGSQBX7yh4y4ZXuKjkDALMO32tLBkhp
 t3nqJB9x6169D5xFPrdPp93SdqpE3dtcrTaIZ4oCs8L5taegUURAUZLSbuQNudlIrRwHOUOmwyG
 VmJlCdX5U+WBcK7uVUpjJputK/Oegn+aTeD/nBEBT2on1ysatlbTxqvfbUy/d1H5hjppcbSxMVR
 txUxzZUm8KnB7RgRJO7/tluiSzzjDSqz1TfNlmWYO7cbqPWGpWwWzc3xUw/7RET0QdUA56L+HZH
 4STbyr9aGxcSNQyx0AdNNBAvVkZ/UTuPQRHBUpgTM4NA/S/gaqbP7v6HQVtaoFQw5zEUND22Zj2
 AYsnXtkDM8hseSwsj5jCu8Cn91Nkn5sitrzlItVBToeOfhwWeAT8uxUakaBPIDHxcscjW5GJhLM
 mUscp3zld4pbH17gwjC4OF0Ghs=
X-Received: by 2002:a05:6a00:f94:b0:857:7337:5db7 with SMTP id
 d2e1a72fcca58-8616ac58363mr27000214b3a.21.1788714710870; 
 Sun, 06 Sep 2026 10:11:50 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86152f32447sm3309910b3a.38.2026.09.06.10.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 10:11:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/5] eal: RTE_PTR_ADD qualifiers and real unaligned types
Date: Sun,  6 Sep 2026 10:09:53 -0700
Message-ID: <20260906171142.3503868-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904220953.3105930-1-stephen@networkplumber.org>
References: <20260904220953.3105930-1-stephen@networkplumber.org>
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

This series started with Scott Mitchell's patch to preserve pointer
qualifications across RTE_PTR_ADD and RTE_PTR_SUB. Reviewing it
turned up two further problems.

The first is that unaligned_uintNN_t only had alignment 1 on armv8
aarch32, the one target setting RTE_ARCH_STRICT_ALIGN. Everywhere
else they were ordinary aligned types, so code using them to read
or write at arbitrary offsets was still undefined behaviour and was
reported by UBSAN. Giving them alignment 1 on all architectures
fixes that, and once mlx5 no longer needs its strict alignment
path, RTE_ARCH_STRICT_ALIGN has no users left and is removed.

The second is the jhash test, which declared its key as a byte
array and cast it to unaligned_uint32_t * to pass to a function
taking const uint32_t *. That is fixed first in the series so the
alignment change does not introduce a new clang warning.

Only patch 1 should go to stable.

Note for reviewers: unaligned_uintNN_t is in an installed header,
so applications embedding one of these types in a structure will
see its layout change. That is called out in the release notes.

The types are also used in the hash key compare path
(rte_cuckoo_hash.c, rte_cmp_generic.h) and for 8 byte ring elements
(rte_ring_elem_pvt.h). Scalar code generation is unchanged on x86,
but the compiler can no longer assume alignment when combining
adjacent accesses, so hash and ring perf results would be welcome,
particularly on arm.


Scott Mitchell (1):
  eal: RTE_PTR_ADD/SUB API improvements

Stephen Hemminger (4):
  test: fix jhash 32 bit key type
  eal: make unaligned really unaligned
  net/mlx5: drop unnecessary STRICT_ALIGN
  arm: remove no longer used RTE_ARCH_STRICT_ALIGN

 app/test-pmd/cmdline_flow.c                 |   4 +-
 app/test/test_common.c                      | 507 +++++++++++++++++++-
 app/test/test_hash_functions.c              |  14 +-
 config/arm/meson.build                      |   1 -
 doc/guides/rel_notes/release_26_11.rst      |  20 +
 drivers/bus/cdx/cdx_vfio.c                  |  13 +-
 drivers/bus/pci/linux/pci.c                 |   6 +-
 drivers/bus/vmbus/linux/vmbus_uio.c         |   6 +-
 drivers/common/cnxk/roc_cpt_debug.c         |  12 +-
 drivers/common/cnxk/roc_ml.c                |   4 +-
 drivers/common/cnxk/roc_nix_bpf.c           |   2 +-
 drivers/common/cnxk/roc_nix_inl.h           |   4 +-
 drivers/common/cnxk/roc_nix_inl_dp.h        |   8 +-
 drivers/common/mlx5/mlx5_common_mr.c        |   2 +-
 drivers/dma/idxd/idxd_pci.c                 |   2 +-
 drivers/dma/odm/odm_dmadev.c                |   4 +-
 drivers/event/cnxk/cn10k_worker.c           |  32 +-
 drivers/event/cnxk/cn20k_worker.c           |  32 +-
 drivers/mempool/bucket/rte_mempool_bucket.c |   7 +-
 drivers/net/cxgbe/sge.c                     |   4 +-
 drivers/net/ena/ena_ethdev.c                |  10 +-
 drivers/net/mlx4/mlx4_txq.c                 |   3 +-
 drivers/net/mlx5/mlx5_tx.h                  |  12 +-
 lib/eal/common/eal_common_fbarray.c         |   2 +-
 lib/eal/common/eal_common_memory.c          |  29 +-
 lib/eal/common/eal_common_options.c         |   3 +-
 lib/eal/common/malloc_elem.h                |  34 +-
 lib/eal/freebsd/eal_memory.c                |   4 +
 lib/eal/include/rte_common.h                | 188 +++++++-
 lib/eal/linux/eal_memalloc.c                |   5 +
 lib/eal/linux/eal_memory.c                  |   7 +
 lib/eal/windows/eal_memalloc.c              |   5 +
 lib/graph/rte_graph.h                       |   4 +-
 lib/latencystats/rte_latencystats.c         |   3 +
 lib/mbuf/rte_mbuf.c                         |   2 +
 lib/mbuf/rte_mbuf.h                         |   3 +
 lib/member/rte_xxh64_avx512.h               |   6 +-
 lib/mempool/rte_mempool.h                   |   5 +
 lib/pdcp/pdcp_entity.h                      |   8 +-
 lib/vhost/vhost_user.c                      |  13 +-
 40 files changed, 870 insertions(+), 160 deletions(-)

-- 
2.53.0

