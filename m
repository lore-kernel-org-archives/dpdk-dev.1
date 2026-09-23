Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3F5C9830B
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 17:32:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 853E542E81;
	Wed, 23 Sep 2026 19:32:19 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 83F274027C
 for <dev@dpdk.org>; Wed, 23 Sep 2026 19:32:17 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3a02551822eso66097a91.1
 for <dev@dpdk.org>; Wed, 23 Sep 2026 10:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790184736;
 x=1790789536; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MuQf91JjV02qnjiWavvkcKRKCUKN4xwsgmS2CGTJV7g=;
 b=w5yu/s0aa8ifltdydK/aBB2ISwy3sv1SH4QBtSjz0vJ0Qfhmhp2/3kh1x/jh5l+7eX
 bcbyVgHF8r/JTnbB9ZgpYqhQ5ZOhpd1cBTi79LYdHdehcPMImwkwXYON7Z/ldl5b15ms
 Pp9kj61qQrLju5l1t5Lc7oc64oR0yTAOFA5LfE0jhX4cKje1z77UM/E0uBWBzkGG2gPP
 u1BbSTjPPLfTLsR/ED2gVySBNzMQPgLmOmk8Sz9dL1SAl6N5TyneS4bk+1BXXWNFux76
 qfY96PwJ1/HB07Rjn25NRSqDyiIOdEYqoIEJ/a1yQsx/NLJgTiH6zrdhtFno/uKEn9x1
 bn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790184736; x=1790789536;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MuQf91JjV02qnjiWavvkcKRKCUKN4xwsgmS2CGTJV7g=;
 b=mSmSq0nD2APo4ldsFkOa0f+016FPIN7Kdwq4wJl2iNbf81p5STIBPlw6L1Gg8lbcGm
 WDX2Ac1q8OiCcD0jI12twTORq+PcgGhniNrKRvqxRYungUlYPzeZ5YEceKkKVhr6eqWb
 8cXeV/zwPyuBuIyQmcGLSNsWegqrl4E6ymsJSBfyLiyIGr/AP3QMSfaIwYcfVFBA0Cfu
 nFc6Jg9zMnEfcEaWNim5PHcYAOm6upfCFyqIC/foXl2p4bVkoTtEP6hmNG+F/EYCrLl2
 KzVY65gVZBvW2NPSU+wWYsGj1XGUonOmOzj7LBBNOHSEm0ktdAxagio/gzfc89hFa2Sr
 055Q==
X-Gm-Message-State: AFuF++kJ1fHtRydUyZB2Leri01YEfKaP7Cc6MxjnHBbSpuQDyoOJIQhb
 FFtxgz5AxtAtovhs5GEdmdTlSrGXPdu/hl1WBMVHWJJyFRVI3cwjuL2RgIRN2vvDCME=
X-Gm-Gg: AYBFou2NHhc2QDYcY35ztBZHgaX6bnCscuw9ITJqe5ojTJWPVoayimr+gCeVfjEC9eW
 QjShVLZKBhYAmZhpIhiBoNqSf2Lz9EdkxlZ7TEOpuT5FEpWemEE0w4XBbDp3ruwhO13VY2WW4Mf
 hPEBsF9G1cM/FckVYOgyGdWpbt0M0xf04KLSacCsM6AcHzYV3X7myQ6xNilew3HPSmM7jkUX4hn
 J5wpFrB/9bb/4xF6M+t1yTV4XktTWlF8RgQ/uf3KIn79PtaHYTPXVScGwR7xyxxONfP8daKIunc
 Oo4iEY3R6XyucdZFsegeUVyNwH4IGGZ1MtATOs0bRz583SNOp8B4J1qBCgQ3/y7qLMAlfTPYvKj
 2vl1WL0kMdAGWbOr62RuV4SSWzI6L+Gd2Yhc167EKQkrSYhwCoSij7My/IQjDilZI9scgP0b+04
 MH+pRFW9eLw2A+5WBKUeHWv7h0dcBUn4KMMXoVWyBrKeyHp6/+WiUQocScbjNJHSt2ZV+l0jYyW
 VCU11l0G0+40EZ0TyUYv81dNvnpqSvIwCsVPyCV
X-Received: by 2002:a17:90b:4d08:b0:3a0:25f0:d89a with SMTP id
 98e67ed59e1d1-3a07325c7a9mr4106289a91.49.1790184735997; 
 Wed, 23 Sep 2026 10:32:15 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc75f409f96sm1512912a12.32.2026.09.23.10.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 10:32:15 -0700 (PDT)
Date: Wed, 23 Sep 2026 10:32:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 00/16] Introduce RTE_DIV_ROUND_UP
Message-ID: <20260923103213.75ac6d81@phoenix.local>
In-Reply-To: <20260923010742.2468145-1-joshwash@google.com>
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 22 Sep 2026 18:07:23 -0700
Joshua Washington <joshwash@google.com> wrote:

> Numerous components independently define the DIV_ROUND_UP macro, using
> the same definition. Attempt to commonize by introducing
> RTE_DIV_ROUND_UP to rte_common.h and replacing usages of DIV_ROUND_UP
> with RTE_DIV_ROUND_UP. Similarly, replace DIV_CEIL, which is
> functionally identical, to RTE_DIV_ROUND_UP.
> 
> Changes in v3:
>   - eal: Add unit tests in app/test/test_common.c.
>   - eal: Add release notes entry for RTE_DIV_ROUND_UP.
>   - eal: Expand Doxygen documentation with parameters and caveats
>     (divisor evaluation, non-negative inputs, wraparound).
>   - base code (qede, cxgbe, ena): Keep DIV_ROUND_UP macro in osdep/platform
>     headers and avoid modifying call sites under base/.
>   - nfp: Change commit subject prefix from "drivers:" to "net/nfp:".
>   - qede, nfp: Drop unnecessary line rewraps.
>   - ena: Remove extraneous blank line in ena_plat_dpdk.h.
>   - app: Convert DIV_CEIL in app/test and app/test-compress-perf to
>     RTE_DIV_ROUND_UP.
> 
> Changes in v2:
>   - Split single patch into series.
> 
> Joshua Washington (16):
>   eal: introduce division round up macro
>   net/i40e: use common division round up macro
>   net/idpf: use common division round up macro
>   net/ice: use common division round up macro
>   net/qede: use common division round up macro
>   net/rnp: use common division round up macro
>   net/hns3: use common division round up macro
>   net/hinic: use common division round up macro
>   net/bnx2x: use common division round up macro
>   net/cxgbe: use common division round up macro
>   net/ena: use common division round up macro
>   raw/ifpga/base: use common division round up macro
>   net/nfp: use common division round up macro
>   app/procinfo: use common division round up macro
>   app/test: use common division round up macro
>   app/test-compress-perf: use common division round up macro
> 
>  app/proc-info/main.c                           |  3 +--
>  app/test-compress-perf/comp_perf_test_common.c | 13 +++++--------
>  app/test/test_common.c                         | 10 ++++++++++
>  app/test/test_compressdev.c                    |  4 +---
>  doc/guides/rel_notes/release_26_11.rst         |  5 +++++
>  drivers/common/nfp/nfp_platform.h              |  2 --
>  drivers/net/bnx2x/bnx2x.c                      |  4 ++--
>  drivers/net/bnx2x/bnx2x.h                      | 11 ++++-------
>  drivers/net/cxgbe/cxgbe_compat.h               |  2 +-
>  drivers/net/cxgbe/cxgbe_filter.c               |  6 +++---
>  drivers/net/cxgbe/cxgbe_ofld.h                 |  4 ++--
>  drivers/net/cxgbe/sge.c                        | 14 +++++++-------
>  drivers/net/ena/base/ena_plat_dpdk.h           |  2 +-
>  drivers/net/hinic/base/hinic_compat.h          |  5 +----
>  drivers/net/hns3/hns3_ethdev.h                 |  2 --
>  drivers/net/hns3/hns3_fdir.c                   |  2 +-
>  drivers/net/hns3/hns3_regs.c                   |  8 ++++----
>  drivers/net/hns3/hns3_rss.c                    |  8 ++++----
>  drivers/net/intel/i40e/base/i40e_osdep.h       |  3 +--
>  drivers/net/intel/ice/base/ice_osdep.h         |  3 +--
>  drivers/net/intel/idpf/base/idpf_osdep.h       |  3 +--
>  drivers/net/nfp/nfdk/nfp_nfdk.h                |  2 +-
>  drivers/net/nfp/nfdk/nfp_nfdk_dp.c             |  2 +-
>  drivers/net/nfp/nfpcore/nfp_nsp.c              |  2 +-
>  drivers/net/qede/base/bcm_osal.h               |  1 -
>  drivers/net/qede/qede_debug.c                  | 16 ++++++++--------
>  drivers/net/rnp/base/rnp_osdep.h               |  5 ++---
>  drivers/net/rnp/rnp_rxtx.c                     |  2 +-
>  drivers/raw/ifpga/base/opae_osdep.h            |  3 +--
>  lib/eal/include/rte_common.h                   | 18 ++++++++++++++++++
>  30 files changed, 88 insertions(+), 77 deletions(-)
> 

Since the next-net-intel tree is now merged in main this will need
a rebase. Detailed AI review also found other issues:

Review: [PATCH v3 01/16..16/16] common division round up macro

Series
------

Error

Patches 02-04 do not apply to main. The osdep headers moved out of
base/ in:

  968a7e52ef50 ("net/i40e: move editable files out of base folder")
  2eb2950a8e17 ("net/ice: move editable files out of base folder")
  7b8be7b1c614 ("net/idpf: move editable files out of base folder")

Patch 01 also conflicts in release_26_11.rst. Needs a rebase; the
changes carry over as is to drivers/net/intel/{i40e,ice,idpf}/.
With paths adjusted, every commit builds with -Dwerror=true for all
touched drivers and apps, and common_autotest passes.

Warning

Patches 05, 10 and 11 say DIV_ROUND_UP is now redundant, but v3
keeps it in bcm_osal.h, cxgbe_compat.h and ena_plat_dpdk.h as an
alias for base/ code. Update the commit bodies to match, e.g.:

  Map DIV_ROUND_UP to RTE_DIV_ROUND_UP for base code and use
  RTE_DIV_ROUND_UP directly elsewhere in the driver.

For 05, what actually goes away is the local RTE_DIV_ROUND_UP.

Info

Private copies not covered by the series, for a follow-up:

  drivers/crypto/ccp/ccp_dev.h              CCP_DIV_ROUND_UP
  drivers/common/qat/dev/qat_dev_gen_lce.c  LCE_DIV_ROUND_UP (unused)
  drivers/common/sxe2/sxe2_osal.h           SXE2_DIV_ROUND_UP
  examples/ip_fragmentation/main.c          ROUNDUP_DIV (unused)


Patch 01/16 eal: introduce division round up macro
--------------------------------------------------

Warning

The Doxygen block contradicts itself on the divisor:

  + *   Divisor. Must be a positive integer. Evaluated twice.
  + * @note Both @p n and @p d must be non-negative to round correctly.

d == 0 is non-negative. The first two @note lines only repeat the
@param text; drop them. Also @c formats a single word, so
"@c (n) + (d) - 1" renders only "(n)" as code. Suggest:

  /**
   * Divide @p n by @p d, rounding up.
   *
   * @param n
   *   Dividend. Must be non-negative.
   * @param d
   *   Divisor. Must be positive. Evaluated twice.
   * @return
   *   @p n divided by @p d, rounded up.
   *
   * @note (n) + (d) - 1 wraps if @p n is near the maximum of its
   *   type, e.g. RTE_DIV_ROUND_UP(UINT32_MAX, 2) is 0.
   */


Patch 03/16 net/idpf: use common division round up macro
--------------------------------------------------------

Info

Pre-existing, not introduced by this patch. After the rebase
idpf_osdep.h still carries a second copy, with no users in the tree:

  #define DIVIDE_AND_ROUND_UP(a, b) (((a) + (b) - 1) / (b))

Drop it or alias it to RTE_DIV_ROUND_UP.


Patch 04/16 net/ice: use common division round up macro
-------------------------------------------------------

Info

Pre-existing, not introduced by this patch. ice_osdep.h has the same
DIVIDE_AND_ROUND_UP copy, used by base code (ice_acl_ctrl.c,
ice_flow.c, ice_sched.c). Now that the file is outside base/, map it
to RTE_DIV_ROUND_UP as done for cxgbe and ena.
