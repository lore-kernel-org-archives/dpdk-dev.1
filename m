Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC025CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 21:38:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F30CB4021F;
	Thu, 28 May 2026 23:38:20 +0200 (CEST)
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50]) by mails.dpdk.org (Postfix) with ESMTP id 58F264003C
 for <dev@dpdk.org>; Thu, 28 May 2026 23:38:20 +0200 (CEST)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-6604df9ba4eso154458d50.0
 for <dev@dpdk.org>; Thu, 28 May 2026 14:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780004299;
 x=1780609099; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GhnFuJViJQRAhRchdPjzRhvDoNvD7cS/bt3t+ELwg2w=;
 b=bfb+GUteNong/H/wBStOXsyr3dMjm94KMTHeDyy/XasaB3bviMv2L1FqFj33mmWJj0
 26lhAI9I3ELDOh4kpKNW9Ssb23P7WD8n8JdpGgPvoGXoek6SHCAPvtOlbjesUtG6Wy0g
 0ZKBkD4OGujohg9bPzwSLn4LXtZYni4nCmCtRfJKH3slPe9fgJpsK+xQJeBG07MkBrZB
 zbGCKsz9lI6eysSpxmHwtb7VkuFq85DpRR37zBtANFm2PIsXIcJKsTYDlxDoFdiWf3aU
 U8WG2lnTeMvnUQ03rtgFNJdtBWoGP/ZcEf1YAtNXuGW5sKbQXNkcQ5bU60RDSzTRiTbe
 /0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780004299; x=1780609099;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GhnFuJViJQRAhRchdPjzRhvDoNvD7cS/bt3t+ELwg2w=;
 b=pNKbhWv4LzBdd2L3AmzOoi8CGqFnYV/ucTBNlckNcodvFZmnKO2LLRJq1mHoStZecS
 d3KR1jhrV1xtNVaFj0yhkZcjucCL/Uj14C1r9W+R/0pH0Ihe76hIJJkZB04tjqXL7vjg
 zl/M/Ja/hSNrsXbxIeXFAV3j8zViyCbK0S6A5ihi3F0c49qKeXJ+R02akxR8R4xCDYPv
 QhJtiWSY6ed7sfIA7X/cSxqJuhfHJIFKmyGfiwqg2xveJv5/+LSFmel19RSEea9ztGYe
 j37c4UQNjpOuc3yvt9Q4qkIGonEiMMfX8Sd8rlmiuMfcf8Q7fLZUTgg3p2DWv8MOktPE
 CXwA==
X-Gm-Message-State: AOJu0YwVzQAls75ganlwwFdnxpj9OH/dqdZ5wyXyE9KY/ut79l8tgTjz
 W+Ac2GgH2qBIEgm1yA05yvqeHwSIWaG//BSeVQGIcZpmWrYD5raeHIN7B9V5izSFjmSI8N1GdBM
 2I3Ix
X-Gm-Gg: Acq92OHIsCzJ/jvGKIG+MjzcSFyChZjkNMzHeHnqYXCOq6OTBX5UtpCgDUJDuNaoud8
 Jk2nvvo4j2HgCEyglZcbJbpIVEK8f2B+qhiP3gNfm8mbQy+pFUMHOfNWTmIhJiRo84rrtUzK+c1
 qx2HHbkxUyAo1CIJpmn2jhf2Q6xO5I6xJ3SCqVFFfxITF1a/jy3UkzSbHHWMUNNsN702qyYEbRr
 RC3Ie11Sbkho4LWKbVfqsFVBBiyZEBnqcJcaCZ9QIVI5yQv/1WeXRdxbiQpIuDsgvEGfeSr88EU
 QCowqlIs/ckrsVATryNWvyXx8L6WrFaDK/nJGIzs47wYOPLn3ZFFX+wsbfJHBUu9otaFmjF1XJY
 Q0FFBRi00tU69YBPfkDcyMuPRaFvbszrkJcSjoA87hb7CL+MjL4Vuh8ZaZJnfPLnlhCmicGO4jw
 95CdV6/zV5NmjQc2+hf9T57jArST7WMjk9s2NdCRbR9auW+cYln0sw25v9W1V2KV5okou5wBcX
X-Received: by 2002:a05:690e:4809:b0:660:40e3:e869 with SMTP id
 956f58d0204a3-660515336b6mr46851d50.3.1780004299502; 
 Thu, 28 May 2026 14:38:19 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6604e12ea23sm208079d50.0.2026.05.28.14.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 14:38:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 0/8] retire legacy flow director API
Date: Thu, 28 May 2026 14:37:12 -0700
Message-ID: <20260528213816.562910-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The flow director (fdir) configuration API in <rte_eth_ctrl.h> was
superseded by rte_flow in 17.05 but never removed. This series
finishes the job: 26.07 retires the user-facing surface and
decouples driver internals from the public ABI; the 26.11
deprecation notice covers the public ABI removal itself.

User-visible changes in 26.07:

  - testpmd commands gone: `show port fdir`, `clear port fdir`,
    `flow_director_filter`, `port config ... pctype mapping ...`,
    and `port config ... hash_inset|fdir_inset|fdir_flx_inset ...`.
    Use the `flow` command instead.

  - Experimental functions gone:
    rte_pmd_{i40e,ixgbe}_get_fdir_info() and
    rte_pmd_{i40e,ixgbe}_get_fdir_stats(). Removed early to give
    out-of-tree callers a build-time signal ahead of 26.11.

  - <rte_pmd_i40e.h> filter configuration entry points are marked
    __rte_deprecated. -Werror sources will need
    -Wno-deprecated-declarations, or migration to rte_flow, before
    26.11.

Scheduled for 26.11 (announced in deprecation.rst):

  - Flow director types in <rte_eth_ctrl.h> and the driver-facing
    definitions in <ethdev_driver.h>.

  - PMD-private filter API in <rte_pmd_i40e.h>.

The ixgbe and txgbe patches at the tail privatize internals that
still used the legacy types — mechanical rename, no behavior
change, so the 26.11 struct removal can proceed without further
per-driver coupling.

The mbuf-side fdir metadata (RTE_MBUF_F_RX_FDIR* flags and the
hash.fdir field) is unaffected — it is used by the rte_flow MARK
and FLAG actions, not part of the legacy filter API.

Stephen Hemminger (8):
  app/testpmd: remove support for flow director
  net/i40e: remove testpmd flow filter commands
  net/i40e: deprecate legacy flow filter API
  net/i40e: remove experimental FDIR API
  net/ixgbe: remove experimental FDIR API
  doc: announce legacy flow director deprecation
  net/ixgbe: privatize legacy flow director types
  net/txgbe: privatize legacy flow director types

 app/test-pmd/cmdline.c                        |  21 +-
 app/test-pmd/config.c                         | 163 -----
 app/test-pmd/testpmd.h                        |   3 -
 doc/guides/nics/i40e.rst                      |  70 +-
 doc/guides/rel_notes/deprecation.rst          |  10 +
 doc/guides/rel_notes/release_26_07.rst        |  14 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst   |  36 -
 drivers/net/intel/i40e/i40e_ethdev.c          |   4 +-
 drivers/net/intel/i40e/i40e_ethdev.h          |   4 -
 drivers/net/intel/i40e/i40e_fdir.c            | 140 ----
 drivers/net/intel/i40e/i40e_flow.c            |   3 +-
 drivers/net/intel/i40e/i40e_testpmd.c         | 642 ------------------
 drivers/net/intel/i40e/rte_pmd_i40e.c         |  34 -
 drivers/net/intel/i40e/rte_pmd_i40e.h         | 113 ++-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  12 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        | 100 ++-
 drivers/net/intel/ixgbe/ixgbe_fdir.c          | 241 ++-----
 drivers/net/intel/ixgbe/ixgbe_flow.c          |  28 +-
 .../net/intel/ixgbe/ixgbe_rxtx_vec_common.c   |   4 +-
 drivers/net/intel/ixgbe/rte_pmd_ixgbe.c       |  34 -
 drivers/net/intel/ixgbe/rte_pmd_ixgbe.h       |  32 -
 drivers/net/txgbe/txgbe_ethdev.c              |   6 +-
 drivers/net/txgbe/txgbe_ethdev.h              | 101 ++-
 drivers/net/txgbe/txgbe_fdir.c                |  78 +--
 drivers/net/txgbe/txgbe_flow.c                |  24 +-
 drivers/net/txgbe/txgbe_rxtx_vec_common.h     |   4 +-
 26 files changed, 448 insertions(+), 1473 deletions(-)

-- 
2.53.0

