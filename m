Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADCECDE007
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 09:36:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A89D740280;
	Thu, 25 Jun 2026 11:36:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 8EB1D4025F
 for <dev@dpdk.org>; Thu, 25 Jun 2026 11:36:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782380200; x=1813916200;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JXeDxDjhbrwYxydqLGR3j5iPsH5/P1M82jo7yh1sCH8=;
 b=SOkSpE1Vh2VUfqPFmmXdj4g2AQs1x36CmVyffC0n98Yt6ysTVVc3k3CM
 8mI9UBDR6N3Ya2fCPti5jmJ2YtKAmTNFYnyPQwONZF649bgV4C5Rr2UGJ
 NAEi8Sguev7SOOl52CV+sAX1VQCeVSwkFEH15ulbeJgFk6em9jhvcodQr
 797ZUSB3wc7jCGqQhN2KjbACUNAz+xYk256BdwNuFpGKZVJUe6kRSgofk
 T2dFhh2aKyBaAIiPpC72a5N+KZLcnlxKiaJle8HpYJkOFfYeDA2ae9SYI
 JiEyIGvndR6epHWakWHM9dF6WtZQF1pgIi3vamZUN+t54+OvlNlRcrAHi A==;
X-CSE-ConnectionGUID: soUNVoJwSGilKQNDq3ORZA==
X-CSE-MsgGUID: 7Uymr9mKRbOMfLHaXvxTrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="100579265"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="100579265"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 02:36:38 -0700
X-CSE-ConnectionGUID: FXFbdt31RsiaUdw+9m3hBg==
X-CSE-MsgGUID: MWfASgC+QlWxp/8wjxrTGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="254298871"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by orviesa003.jf.intel.com with ESMTP; 25 Jun 2026 02:36:38 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 0/3] net/intel: fix potential rx stats underflow
Date: Thu, 25 Jun 2026 09:36:16 +0000
Message-ID: <20260625093619.726471-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
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

The Rx packet count reported by ice, ice DCF and iavf can momentarily
jump to an enormous invalid value under load. ipackets is derived by
subtracting the discarded packet count from the sum of the unicast,
multicast and broadcast counters. That sum already includes the
discarded packets, so the result is the number actually delivered. The
inputs are sampled from separate sources at slightly different instants,
so the discard count can briefly exceed the measured sum. Because the
arithmetic is unsigned, the subtraction wraps to a huge value and is
reported as a hugely incorrect packet count and rate.

All three share the bug but not the fix, because they differ in how
much control they have over the sampling.

The ice PF reads its counters directly from hardware registers, so the
order is under the driver's control. Reading the discard register before
the other three, combined with the fact that the counters only ever
increase and the delivered-packet sum always includes the discards,
makes it impossible for the discard count to exceed the later sum. No
clamping is needed and the subtraction can never underflow.

ice DCF and iavf receive their counters from the PF in a single virtchnl
message and cannot influence the order in which the PF sampled them.
There a reorder is not available, so the subtraction is made saturating:
when the discard count exceeds the sum, essentially nothing was delivered,
so zero is reported instead of underflowing.

Ciara Loftus (3):
  net/ice: fix Rx packets statistics underflow
  net/ice: fix DCF Rx packets statistics underflow
  net/iavf: fix Rx packets statistics underflow

 drivers/net/intel/iavf/iavf_ethdev.c   | 12 ++++++++++--
 drivers/net/intel/ice/ice_dcf_ethdev.c | 12 ++++++++++--
 drivers/net/intel/ice/ice_ethdev.c     | 11 +++++++++--
 3 files changed, 29 insertions(+), 6 deletions(-)

-- 
2.43.0

