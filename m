Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A67C55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 08:27:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAD7940276;
	Thu,  6 Aug 2026 10:27:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 0193540262
 for <dev@dpdk.org>; Thu,  6 Aug 2026 10:27:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786004858; x=1817540858;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Dhl3XjtNkQmjFuAR3xSu6OeNViESKBM32mXLVrKI/NQ=;
 b=OEzLvZtXd+21lNOzRKryDe3B3gg3Ic5iJBkLivAWzoo/J2C+uQERvmbk
 1nmmz7FQ76mlN19XKhRtnLjBeSsFYLVZ/xJIcWKuR2gt0Gj9iURWtJxE+
 NtBBrJSgEmomjmnJgGwHQBfPTxSyfimFnBMraoVwF3PoNRkdEryS4xG5c
 HPV9k+5ctan4KNaCBUU4ykSmO1IF52BCw7XgciSSX3kseec9Z9cA48iC9
 MeY5iTFC8VKkAQhF2IjzrkNqJ4zWkBeamLOm+zuZRJ66J2/MBfeqgiuOx
 RM7wDMcXj2bluZ+dozil8rHdjvcaRIC+HmWF2W7WAMmHNsf2ODtvi27bd g==;
X-CSE-ConnectionGUID: 4KBHLV89TRSk0rXxRBUZGw==
X-CSE-MsgGUID: qEAPbr7aTdyrFPQoF+iTqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86666957"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="86666957"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 01:27:36 -0700
X-CSE-ConnectionGUID: NcDV0sdlS+WPABjVDZV3sA==
X-CSE-MsgGUID: HuivQlZMRvqpIRasKinsOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="259420978"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa008.fm.intel.com with ESMTP; 06 Aug 2026 01:27:35 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH 0/5] net/iavf: harden reset recovery and data path on link flap
Date: Thu,  6 Aug 2026 08:26:23 +0000
Message-Id: <cover.1786004043.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
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

Anurag Mandal (5):
  net/iavf: discard empty AdminQ descriptors on reset
  net/iavf: defer device start when PF VSI not ready
  net/iavf: drain in-flight Tx before reset
  net/iavf: change no_poll flag to atomic
  net/iavf: improve VF reset detection on fast ARQ flip

 drivers/net/intel/iavf/iavf.h        |   5 +-
 drivers/net/intel/iavf/iavf_ethdev.c | 103 ++++++++++++++++++++----
 drivers/net/intel/iavf/iavf_rxtx.c   | 112 ++++++++++++++++++++++++++-
 drivers/net/intel/iavf/iavf_rxtx.h   |   6 ++
 drivers/net/intel/iavf/iavf_vchnl.c  |  40 +++++++++-
 5 files changed, 246 insertions(+), 20 deletions(-)

-- 
2.34.1

