Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A792FC5CFC1
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 06:49:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECDC04028E;
	Mon, 17 Aug 2026 08:49:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id C4B5C4021F
 for <dev@dpdk.org>; Mon, 17 Aug 2026 08:49:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786949386; x=1818485386;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=t0Vt1RVCYPJCpM5klbuAniBxlr+H1FpYLzLwpCbWeh0=;
 b=LgkmrUGd00RWPfI+JMPq9mkSc9LHShjrAv54kg4g0uBu91RKIM8lGNtk
 KgDxOeTQ/ty6Nw1B8IH/dotE0rkGPOXpqFAJdMvPLJ4Z8wiKawxTHNjKu
 gxD6FICO9L5/kRiFZ3N7zQtTy4kx3Dexi77AF3kdzawcGtppBHaSB54Td
 JNtS2MYS+ajonQEFpNT6PRzsTNpHSrkfPOAi0RTJlarDhdHmx4uzcajzb
 0cSt4OlwYEh7awjTZZMD0UBt+nE4FQbr2DUV6nKfzv8biuOnuxSATr0xQ
 Ir0/qt51Cx2+IxaMnMdXkOZK6/JUx6k1YmA3trApQg/nTNZ/6MkdiPm/H w==;
X-CSE-ConnectionGUID: N0llhLu3QP6vjmon/vBGrQ==
X-CSE-MsgGUID: yWYFgTWMTb27sDwSZ5/nrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="91095591"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="91095591"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2026 23:49:45 -0700
X-CSE-ConnectionGUID: A8gORoOuSU2+qSWnyS/yRw==
X-CSE-MsgGUID: Q6+hKHGHTZqk0LOVWPOq+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="262195928"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa008.fm.intel.com with ESMTP; 16 Aug 2026 23:49:43 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v3 0/7] net/iavf: harden reset recovery and data path on link
 flap
Date: Mon, 17 Aug 2026 06:48:39 +0000
Message-Id: <cover.1786948817.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1786004043.git.anurag.mandal@intel.com>
References: <cover.1786004043.git.anurag.mandal@intel.com>
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

V3-changes:
 - Addressed Ciara Loftus's review comments on Fixes tag
 - Added missing watchdog enable in Patch-6
 - Removed extra space in commit msg of Patch-5

V2-changes:
 - Addressed Ciara Loftus's review comments.
 - Split Watchdog and flow flush from other patches.
 - Shortened multiple comments and commit msg
 - Prevented iavf_resume_pending_start() looping

During PF-initiated reset or a remote/ToR switch link-flap, the VF
might miss the reset event, race on the no_poll gate, leak in-flight
Tx descriptors, and stay down if dev_start ran before the PF VSI was
ready.

This patch series build on the earlier reset-recovery fixes with the
following:

- Reset detection: complement the ARQLEN1 check with VFGEN_RSTAT
  (VIRTCHNL_VFR_INPROGRESS) and poll at a 5 ms interval, matching the
  kernel iavf driver, so fast ARQ flips are not missed. When the VFR
  is still not observed, recover anyway instead of bailing out,
  keeping PF and VF state in sync.

- no_poll: make the flag atomic (RTE_ATOMIC) with release/acquire
  ordering so the data-plane lcores observe gate changes reliably.

- Tx drain: add iavf_dev_tx_drain() to flush in-flight Tx descriptors
  on link-down and impending-reset events before teardown, preventing
  MDD events and descriptor leaks.

- Deferred start: when dev_start fails during recovery (PF VSI inactive),
  defer it via start_pending and resume on the next link-up event so the
  VF comes back without manual intervention.

- AdminQ: discard zeroed (opcode 0) descriptors seen during PF-initiated
  resets to avoid the "Request 0 is not supported" log flood.

- Watchdog: keep watchdog armed for the whole reset window

- Flow flush: skip flow flush during PF-initiated reset

Anurag Mandal (7):
  net/iavf: discard empty AdminQ descriptors on reset
  net/iavf: defer device start when PF VSI not ready
  net/iavf: drain in-flight Tx before reset
  net/iavf: change no_poll flag to atomic
  net/iavf: improve VF reset detection on fast ARQ flip
  net/iavf: keep watchdog armed for the whole reset window
  net/iavf: skip flow flush during PF-initiated reset

 drivers/net/intel/iavf/iavf.h        |   5 +-
 drivers/net/intel/iavf/iavf_ethdev.c | 108 +++++++++++++++++++++++----
 drivers/net/intel/iavf/iavf_rxtx.c   | 108 ++++++++++++++++++++++++++-
 drivers/net/intel/iavf/iavf_rxtx.h   |   6 ++
 drivers/net/intel/iavf/iavf_vchnl.c  |  22 +++++-
 5 files changed, 229 insertions(+), 20 deletions(-)

-- 
2.34.1

