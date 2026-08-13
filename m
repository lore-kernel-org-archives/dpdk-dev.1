Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FC6C5CFDB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 10:46:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0460642670;
	Thu, 13 Aug 2026 12:46:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id DC98A40E2D
 for <dev@dpdk.org>; Thu, 13 Aug 2026 12:46:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786617990; x=1818153990;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gEYKNGIlJtC3E/ckkvOsAeKsFAAGU1ZC5bqHjJLxd3U=;
 b=lbw+KfKn1Q/G4HpN0TCzlNIyiMV/2ObazglPsqSjbnAxX6qorJdfnXcf
 qSPlU/7kN0kFe7T3s/UKPbh8iMuO0h/8PaNaFxwBtziECd+CE1WUQOYRD
 SEJqjXgG6KOXFMRU+Oh55qcWXSAcLkH523FTklQvkjRRz6lV5Vq15SI7U
 IKUXKCmwg4ESU9AdiMzC8j39RJztiYbGCnQzCvZMxvIT+V3yWl8qiguie
 KOkwtCb8gI01PBDJJa2mKw6H6muf0ZXrhpTJgpN3ec2pzMqU+4gzRtAWY
 dxUyKaKrDoVoGHF4s9SMxDtldE1NCXYQI+yx8nonAWLa0xNERBqmIUIsg A==;
X-CSE-ConnectionGUID: 2/hxluOyQB+dtOrFPpzzfw==
X-CSE-MsgGUID: joBjbYSIToSIZotaz38KgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="89708973"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="89708973"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 03:46:29 -0700
X-CSE-ConnectionGUID: cvxFanTGQ3qvoixq5sBhPg==
X-CSE-MsgGUID: TpSKxwXDSeaog9n2SmaS3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="264491533"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa009.jf.intel.com with ESMTP; 13 Aug 2026 03:46:27 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v2 0/7] net/iavf: harden reset recovery and data path on link
 flap
Date: Thu, 13 Aug 2026 10:45:28 +0000
Message-Id: <cover.1786617159.git.anurag.mandal@intel.com>
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
 drivers/net/intel/iavf/iavf_vchnl.c  |  21 +++++-
 5 files changed, 228 insertions(+), 20 deletions(-)

-- 
2.34.1

