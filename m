Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6374C5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 17:22:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B610A40298;
	Thu, 13 Aug 2026 19:22:45 +0200 (CEST)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mails.dpdk.org (Postfix) with ESMTP id 79BC44026E
 for <dev@dpdk.org>; Thu, 13 Aug 2026 19:22:44 +0200 (CEST)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8484ba00601so2911618b3a.1
 for <dev@dpdk.org>; Thu, 13 Aug 2026 10:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786641763; x=1787246563; darn=dpdk.org;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d3/ySvzGIP/dshe15WGq+svAIzbBKdSj5xElFjdYNYc=;
 b=O/gaIjM2OT9qj8CpdT1Ho9KXXRjkWS2b7+jnNvg2HMTl6M54X4oZYDk2YnA0yxBowK
 ArkpK1nPvimu1S2d+0t7qLrAMMqkKbTgjhU+WXNqb+OKpjz0/PO3wvMaBuATw7fUxx23
 8W19b8/gkNO7xOZg0LdeSRV5pSGedloXiq/HD6uYCyVLnkBsS6BZ3lKGqZiMN+j3xYbS
 /kaZpupCA1o/9wbNpS9luAyqrGPcInQjW0FijzqmOis3+LnHFWMQeWlKswhLUaVD8qfe
 oebicsqRaFZUF4/lzBKtTLuYiYb/0l69NnvJcNf8cfAI/VakS+ElXG8xm33ZYj4WMbmD
 crnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786641763; x=1787246563;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d3/ySvzGIP/dshe15WGq+svAIzbBKdSj5xElFjdYNYc=;
 b=LPp13r2TRCCBttW39sroXLPrjEsQ3Hgj8I8fxZPQ0mU5p91CnE3pBYcY9g6LAFhXzE
 22t1eAZvXvkfEBXl54nNE3zyYwij9b7cTCuJ9JcR3VWSRgtBMs8UBSawz5UTP2Hu1pmg
 XFrfHebvfhFMcle2MeYslv/KB+W3B5nxyPDWXLrriNnaSkf4qgKEru3xrGLW1d1VtHXl
 u2aGY5b2WC5BViQFIFqmlT7Jjl8ihEs6Kh5sCylidOxcPdZpKd06yOjOW9GcEiNfSJpH
 mvrVQ/OF3dnskrqI1Q9yXb/QfG2OJqRqkdTZoOryur6EejKSjj1eIDpk5iAOtfwGWLAR
 9xXw==
X-Gm-Message-State: AOJu0YwJ8Cg8VphPF7X73WmKChRczEXxPRD+8roes3W5ZpdiayYCg0ny
 lHSydBepvudynZHL8798MbYW6BfWYMgRxmDkG8noHAo0OhWOckLsc75en6STJ3OqMmC6DLD5x82
 Y1J03cH3T4V4RNRp2mNfZqIae9mkaTH1kJHTHqAbEQXU/4/ot5laIvR+YCYCU7XcmFVZ0BrQ/7m
 4k+pYdslbPcr4GGNxLxe1at5EvI0o5CPLxrA==
X-Received: from pfiu3.prod.google.com ([2002:a05:6a00:1243:b0:84a:2dcb:5abe])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1704:b0:847:9315:fb8b with SMTP id
 d2e1a72fcca58-84fc6e03c6cmr7374226b3a.6.1786641763066; 
 Thu, 13 Aug 2026 10:22:43 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:22:25 -0700
In-Reply-To: <20260812223017.2980190-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813172241.964736-1-joshwash@google.com>
Subject: [PATCH v2 00/14] Introduce RTE_DIV_ROUND_UP
From: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Numerous drivers independently define the DIV_ROUND_UP macro, using the
same definition. Attempt to commonize by introducing RTE_DIV_ROUND_UP to
rte_common.h and replacing usages of DIV_ROUND_UP with RTE_DIV_ROUND_UP.

Changes in v2:
  - Split single patch into series.

Joshua Washington (14):
  eal: introduce division round up macro
  net/i40e: use common division round up macro
  net/idpf: use common division round up macro
  net/ice: use common division round up macro
  net/qede: use common division round up macro
  net/rnp: use common division round up macro
  net/hns3: use common division round up macro
  net/hinic: use common division round up macro
  net/bnx2x: use common division round up macro
  net/cxgbe: use common division round up macro
  net/ena: use common division round up macro
  raw/ifpga/base: use common division round up macro
  drivers: use common division round up macro
  app/procinfo: use common division round up macro

 app/proc-info/main.c                        |  3 +--
 drivers/common/nfp/nfp_platform.h           |  2 --
 drivers/net/bnx2x/bnx2x.c                   |  4 ++--
 drivers/net/bnx2x/bnx2x.h                   | 11 ++++-------
 drivers/net/cxgbe/base/t4_hw.c              |  4 ++--
 drivers/net/cxgbe/base/t4vf_hw.c            | 10 +++++-----
 drivers/net/cxgbe/cxgbe_compat.h            |  3 +--
 drivers/net/cxgbe/cxgbe_filter.c            |  6 +++---
 drivers/net/cxgbe/cxgbe_ofld.h              |  4 ++--
 drivers/net/cxgbe/sge.c                     | 14 +++++++-------
 drivers/net/ena/base/ena_eth_com.h          |  4 ++--
 drivers/net/ena/base/ena_plat_dpdk.h        |  1 -
 drivers/net/hinic/base/hinic_compat.h       |  5 +----
 drivers/net/hns3/hns3_ethdev.h              |  2 --
 drivers/net/hns3/hns3_fdir.c                |  2 +-
 drivers/net/hns3/hns3_regs.c                |  8 ++++----
 drivers/net/hns3/hns3_rss.c                 |  8 ++++----
 drivers/net/intel/i40e/base/i40e_osdep.h    |  3 +--
 drivers/net/intel/ice/base/ice_osdep.h      |  3 +--
 drivers/net/intel/idpf/base/idpf_osdep.h    |  3 +--
 drivers/net/nfp/nfdk/nfp_nfdk.h             |  5 +++--
 drivers/net/nfp/nfdk/nfp_nfdk_dp.c          |  3 ++-
 drivers/net/nfp/nfpcore/nfp_nsp.c           |  2 +-
 drivers/net/qede/base/bcm_osal.h            |  2 --
 drivers/net/qede/base/ecore_chain.h         |  2 +-
 drivers/net/qede/base/ecore_cxt.c           | 20 +++++++++++---------
 drivers/net/qede/base/ecore_init_fw_funcs.c | 21 ++++++++++++---------
 drivers/net/qede/base/ecore_mcp.c           |  6 +++---
 drivers/net/qede/qede_debug.c               | 16 ++++++++--------
 drivers/net/rnp/base/rnp_osdep.h            |  5 ++---
 drivers/net/rnp/rnp_rxtx.c                  |  2 +-
 drivers/raw/ifpga/base/opae_osdep.h         |  3 +--
 lib/eal/include/rte_common.h                |  5 +++++
 33 files changed, 92 insertions(+), 100 deletions(-)

-- 
2.55.0.691.gc56d675ccc-goog

