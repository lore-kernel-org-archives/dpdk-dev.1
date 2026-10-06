Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F44CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 02:30:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 468D3402E1;
	Tue,  6 Oct 2026 04:30:57 +0200 (CEST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mails.dpdk.org (Postfix) with ESMTP id 03297402DD
 for <dev@dpdk.org>; Tue,  6 Oct 2026 04:30:55 +0200 (CEST)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e564adf782so20243285ad.2
 for <dev@dpdk.org>; Mon, 05 Oct 2026 19:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791253855; x=1791858655; darn=dpdk.org;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z//l9/FjnD2eADhLDn6j62sfRPpnHjRL7wT31K1uvo8=;
 b=WKVnNZvSltd6Beqw2L+3vl0/ymqWoFj2YmflOlIh11GDPc8+9uKhwPFeAREvHAraeP
 k9FK7FKAvp1+g0pL0kxL6ASksLfA9HxNyfyxrq6LRMIwgGsjz0SdGXOVBI09mTp2dI2n
 HYU42hAVJixQbEyCTGg8EExA91Z+hjPakVfqWJOqpDJXracOcjC1nXhTjNTZfkoK/6N3
 2cAHp7FUATDdIWiuGLTULgSHADakbuO+HKDvG8T8Jy+Ew3PYOCiV1Jhk4imx0RS4ejzy
 o1T+i0UAZmNdoeg0zHx8HZCI3C79D9xmBhXKQK0y4I9blpZfXzOuSZPRjpdKKHcr/2vH
 2NRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791253855; x=1791858655;
 h=content-type:cc:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z//l9/FjnD2eADhLDn6j62sfRPpnHjRL7wT31K1uvo8=;
 b=OeHPi1hjB+WrOh88KIWexp4cLTximE3dyEZvc54dWeo54QpKm0PA+GxtOSfk88GBZx
 WxLq3RBFZIWliBs0iLQzOOT04+YB+fS1qtf0twTZ7eYZtFEIc7FxqG8ccCao0zprnmDa
 W0GNG+t3K9WeXt3uonqu7fHWmRKqLKbqTXQWPrHTJYz4z4lqlcah0xeV0/5JFdyCM+ic
 yMbdoQLK+469QGA2dVg+aXoRawJpJJ7iwjwwcAZrvUzveyxEmlJd+pAp7h1I1bxVcVG4
 kZE3K7UfuvUn8hlIdiIBZR6FIcC7fEmnBv8NfOCiQJGf4uNDSUgRdDpeCBVUkKYBlpd5
 OK5A==
X-Gm-Message-State: AFq9FYKstCkv0jG/wlg0Rr06dnpqO62k+N6lg8ygcWMT0BGjH9ORUd4l
 PCcQs5iPa6vRLgXNoNlWJc+WEFHcR9cGEpGivPaQiTo9jheaa5R8NMBAQC8RTQKLzQITooGf/9k
 EFsJt8X7OPGyTfx7ptKh4TKB8jgqyeY1yfTPzZsBSKyXBsZWKKnjU6HJ4o6q86KnyOZ1O8MXMeN
 Sf3ohgmXL34+a9wZR7dQQGq7L9O9rbiYuu/A==
X-Received: from plic14.prod.google.com ([2002:a17:903:370e:b0:2e4:90ac:5fc4])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f68d:b0:2e5:6ce9:dc7c with SMTP id
 d9443c01a7336-2e56ce9deb9mr51347585ad.5.1791253854508; 
 Mon, 05 Oct 2026 19:30:54 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:30:36 -0700
In-Reply-To: <20260923010742.2468145-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260923010742.2468145-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006023053.2572501-1-joshwash@google.com>
Subject: [PATCH v4 00/15] Introduce RTE_DIV_ROUND_UP
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

Changes in v4:
  - eal: Fix merge conflict in release notes after rebase.
  - various commits: add rte_common.h includes where missing to fix
    compilation issues.
  - opae: drop RTE_DIV_ROUND_UP change due to shered osdep file for RTE
    and raw drivers.

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

Joshua Washington (15):
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
  net/nfp: use common division round up macro
  app/procinfo: use common division round up macro
  app/test: use common division round up macro
  app/test-compress-perf: use common division round up macro

 app/proc-info/main.c                           |  3 +--
 app/test-compress-perf/comp_perf_test_common.c | 14 ++++++--------
 app/test/test_common.c                         | 10 ++++++++++
 app/test/test_compressdev.c                    |  5 ++---
 doc/guides/rel_notes/release_26_11.rst         |  5 +++++
 drivers/common/nfp/nfp_platform.h              |  2 --
 drivers/net/bnx2x/bnx2x.c                      |  4 ++--
 drivers/net/bnx2x/bnx2x.h                      | 12 +++++-------
 drivers/net/cxgbe/cxgbe_compat.h               |  2 +-
 drivers/net/cxgbe/cxgbe_filter.c               |  6 +++---
 drivers/net/cxgbe/cxgbe_ofld.h                 |  4 ++--
 drivers/net/cxgbe/sge.c                        | 14 +++++++-------
 drivers/net/ena/base/ena_plat_dpdk.h           |  3 ++-
 drivers/net/hinic/base/hinic_compat.h          |  5 +----
 drivers/net/hns3/hns3_ethdev.h                 |  2 --
 drivers/net/hns3/hns3_fdir.c                   |  3 ++-
 drivers/net/hns3/hns3_regs.c                   |  9 +++++----
 drivers/net/hns3/hns3_rss.c                    |  9 +++++----
 drivers/net/intel/i40e/i40e_osdep.h            |  3 +--
 drivers/net/intel/ice/ice_osdep.h              |  3 +--
 drivers/net/intel/idpf/idpf_osdep.h            |  3 +--
 drivers/net/nfp/nfdk/nfp_nfdk.h                |  3 ++-
 drivers/net/nfp/nfdk/nfp_nfdk_dp.c             |  2 +-
 drivers/net/nfp/nfpcore/nfp_nsp.c              |  2 +-
 drivers/net/qede/base/bcm_osal.h               |  2 +-
 drivers/net/qede/qede_debug.c                  | 16 ++++++++--------
 drivers/net/rnp/base/rnp_osdep.h               |  5 ++---
 drivers/net/rnp/rnp_rxtx.c                     |  2 +-
 lib/eal/include/rte_common.h                   | 18 ++++++++++++++++++
 29 files changed, 96 insertions(+), 75 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

