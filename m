Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE31C982FE
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 01:07:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5BD9402AC;
	Wed, 23 Sep 2026 03:07:46 +0200 (CEST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mails.dpdk.org (Postfix) with ESMTP id 3D4A240041
 for <dev@dpdk.org>; Wed, 23 Sep 2026 03:07:45 +0200 (CEST)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2db87f759c5so4188445ad.1
 for <dev@dpdk.org>; Tue, 22 Sep 2026 18:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790125664; x=1790730464; darn=dpdk.org;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2UAdzpRdA6FBK1ALzcdw9FbUnPhTdpdIkcvHwpWsBq0=;
 b=VfhRwKbcz9ghCJv7aLcYxs37u3udvnCdbEGBTHq1RvoNXr3FbeRfOmgLhfvubCTk1c
 r5iihh7Kms0tWBsHw1vx5fiyFobPwZz+vPmu0j/JuzBMVE4HE6FPSVzeKEZ/K/lqhdsb
 xj6AAiOrp+0uoKnDjc42dTD0dMAj+r7AHnlih6tLTy+tLb+IHvEVzidcOjxRkjjN4MaB
 0J75NaKC2tHh42YFXXcK+54TbtaABs4Wr1/hS+SBAx5qM07PnZFfTVXZ02Ak+/hQWCbb
 24/Wh97UKxoHeUTc/NtwY6k9tgH6Rx3UMCDCsTmZrIsyHdDH6ds1r6Ab+SqUmg7/y9iu
 XAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790125664; x=1790730464;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2UAdzpRdA6FBK1ALzcdw9FbUnPhTdpdIkcvHwpWsBq0=;
 b=zKh40m4SS8jcKunSk899ZRi1b0GUOJVrGzeZDLioAbQPw9KpCc9Qsz2QRuTLfHjAeD
 BSyFDt3MTnMQrTG7tYBTAyYtPUrmrjhaK97igz/5iPspqFc1SMoAdoU8utyzYrmgbgH7
 nnU3+4MMIJTLzYi7tabWPnIGbldpGPb669mdtnGfEf50a5696PeS0PM/K0wzzhM982z9
 q7fZUy81CBttBTWdvsUd7eDO4uqXSipPujJZg7+/6PKDsCgmlLYxVkJocljwElgjQIG1
 5I1zJ9MwGfvFm+eHdtFsmK+sXvPDsGJMu1zhJ6KTzFelvTLTJn0hPSGLLtN9ht18xtRz
 Sqzw==
X-Gm-Message-State: AFuF++nmotHtdY0dwiHVKXV+eGr7X6s771TOLdO49btKsw0LEWb63tC8
 Q2RMhdQMKXd4P17LxF3lYvw2QVwdyI+MoP1i2VJfU9riib5RP/UFPgvCYgOP8fUzVIonnWv8707
 edrcXUmseDnkVdEPyD8Nsw0FqphpiRJFeED8mjFrwVXa3JDHcRDu216RGOatS3/60rVKXPN7mUB
 x2vqHSh8kiJS3u+B43HsC/jwRglalGM+eW5A==
X-Received: from plar12.prod.google.com ([2002:a17:902:c7cc:b0:2dd:5ae:3a51])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2b0c:b0:2dd:c100:b2d3 with SMTP id
 d9443c01a7336-2df69e1de2emr8571485ad.62.1790125663422; 
 Tue, 22 Sep 2026 18:07:43 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:07:23 -0700
In-Reply-To: <20260812223017.2980190-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923010742.2468145-1-joshwash@google.com>
Subject: [PATCH v3 00/16] Introduce RTE_DIV_ROUND_UP
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

Numerous components independently define the DIV_ROUND_UP macro, using
the same definition. Attempt to commonize by introducing
RTE_DIV_ROUND_UP to rte_common.h and replacing usages of DIV_ROUND_UP
with RTE_DIV_ROUND_UP. Similarly, replace DIV_CEIL, which is
functionally identical, to RTE_DIV_ROUND_UP.

Changes in v3:
  - eal: Add unit tests in app/test/test_common.c.
  - eal: Add release notes entry for RTE_DIV_ROUND_UP.
  - eal: Expand Doxygen documentation with parameters and caveats
    (divisor evaluation, non-negative inputs, wraparound).
  - base code (qede, cxgbe, ena): Keep DIV_ROUND_UP macro in osdep/platform
    headers and avoid modifying call sites under base/.
  - nfp: Change commit subject prefix from "drivers:" to "net/nfp:".
  - qede, nfp: Drop unnecessary line rewraps.
  - ena: Remove extraneous blank line in ena_plat_dpdk.h.
  - app: Convert DIV_CEIL in app/test and app/test-compress-perf to
    RTE_DIV_ROUND_UP.

Changes in v2:
  - Split single patch into series.

Joshua Washington (16):
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
  net/nfp: use common division round up macro
  app/procinfo: use common division round up macro
  app/test: use common division round up macro
  app/test-compress-perf: use common division round up macro

 app/proc-info/main.c                           |  3 +--
 app/test-compress-perf/comp_perf_test_common.c | 13 +++++--------
 app/test/test_common.c                         | 10 ++++++++++
 app/test/test_compressdev.c                    |  4 +---
 doc/guides/rel_notes/release_26_11.rst         |  5 +++++
 drivers/common/nfp/nfp_platform.h              |  2 --
 drivers/net/bnx2x/bnx2x.c                      |  4 ++--
 drivers/net/bnx2x/bnx2x.h                      | 11 ++++-------
 drivers/net/cxgbe/cxgbe_compat.h               |  2 +-
 drivers/net/cxgbe/cxgbe_filter.c               |  6 +++---
 drivers/net/cxgbe/cxgbe_ofld.h                 |  4 ++--
 drivers/net/cxgbe/sge.c                        | 14 +++++++-------
 drivers/net/ena/base/ena_plat_dpdk.h           |  2 +-
 drivers/net/hinic/base/hinic_compat.h          |  5 +----
 drivers/net/hns3/hns3_ethdev.h                 |  2 --
 drivers/net/hns3/hns3_fdir.c                   |  2 +-
 drivers/net/hns3/hns3_regs.c                   |  8 ++++----
 drivers/net/hns3/hns3_rss.c                    |  8 ++++----
 drivers/net/intel/i40e/base/i40e_osdep.h       |  3 +--
 drivers/net/intel/ice/base/ice_osdep.h         |  3 +--
 drivers/net/intel/idpf/base/idpf_osdep.h       |  3 +--
 drivers/net/nfp/nfdk/nfp_nfdk.h                |  2 +-
 drivers/net/nfp/nfdk/nfp_nfdk_dp.c             |  2 +-
 drivers/net/nfp/nfpcore/nfp_nsp.c              |  2 +-
 drivers/net/qede/base/bcm_osal.h               |  1 -
 drivers/net/qede/qede_debug.c                  | 16 ++++++++--------
 drivers/net/rnp/base/rnp_osdep.h               |  5 ++---
 drivers/net/rnp/rnp_rxtx.c                     |  2 +-
 drivers/raw/ifpga/base/opae_osdep.h            |  3 +--
 lib/eal/include/rte_common.h                   | 18 ++++++++++++++++++
 30 files changed, 88 insertions(+), 77 deletions(-)

-- 
2.55.0.1082.g2b9226bbc0-goog

