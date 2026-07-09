Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5939C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 11:26:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE72340655;
	Thu,  9 Jul 2026 13:26:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 68055402BB
 for <dev@dpdk.org>; Thu,  9 Jul 2026 13:26:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783596383; x=1815132383;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7RAHAGlc46Pfm6srGOHm0pWxRkeDspM4ua0Zgv6YRZo=;
 b=Dp0W3ONfLTloPLDW+AjCN28x9uAwsA5qq+zM64cp4OV/bVIBXTuvVm0+
 qJhqmHDbI9uHCvuskWSGiFimW9xAfXAUbXWR00stNXsJmuh2ZKK2AU4z+
 iat5Q6apXGCD5Yw4N1b1wGRLaSPJIIZM3+p7PzVzXSp+JEGvwlHTUH/uW
 rZXitB1t4V1wqsZcVc1wfR8u2Y3hv9Yjcpeh3lB9ERjW8Tb+jIJzsfa93
 bc2tyqj28/C4hVsISQ7AKbvnOr0hX2/Vgd+dHoceRycLKmTk9tCNh2b9X
 jnDHt/lyO0ydxZ/UzLVGRCbDBmi3QBdJaSvTSqfwSx1HCuhlcORNQ2DTs Q==;
X-CSE-ConnectionGUID: Ibc4XImjSSGbwYeNQqMC7g==
X-CSE-MsgGUID: JjN01j5DQ8CW4V6EHxTI1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94879763"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="94879763"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 04:26:22 -0700
X-CSE-ConnectionGUID: aH8IlokfQg6iqz1dvlTqiQ==
X-CSE-MsgGUID: 6UlmRMHuTzGIGnJw3Sv4Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="259461736"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa005.fm.intel.com with ESMTP; 09 Jul 2026 04:26:21 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 0/3] net/intel: fix link status when interrupt delivery
 unavailable
Date: Thu,  9 Jul 2026 11:25:53 +0000
Message-ID: <20260709112556.1765262-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630141627.1035420-1-ciara.loftus@intel.com>
References: <20260630141627.1035420-1-ciara.loftus@intel.com>
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

On FreeBSD with nic_uio, interrupt registration fails silently and
hardware events, including link state notifications, are never processed
via the interrupt path.

For ice, this affects the typical polling-mode configuration: the
interrupt handler is never invoked, AdminQ messages go unprocessed,
and link status is not reliable. A periodic alarm is added to drain
the AdminQ when interrupt delivery is unavailable. For i40e, an
alarm already runs unconditionally in polling mode, so that
configuration is unaffected. The gap is the interrupt-mode
configuration, where the existing alarm was not activated as a
fallback when interrupt enable fails; this patch extends it to do so.

v2:
 * Added warning on rte_eal_alarm_set failure (i40e & ice)
 * Only set use_aq_polling if rte_eal_alarm_set succeeds (i40e & ice)
 * Move alarm cancel in ice_dev_stop to prevent a race (ice)
 * Remove unnecessary alarm cancel from ice_dev_start error path (ice)
 * Added general fix for ice dev_start error path

Ciara Loftus (3):
  net/ice: poll AdminQ if interrupt delivery unavailable
  net/i40e: activate alarm if interrupt delivery unavailable
  net/ice: fix adapter stopped on device start error

 drivers/net/intel/i40e/i40e_ethdev.c | 11 ++++++-
 drivers/net/intel/i40e/i40e_ethdev.h |  2 ++
 drivers/net/intel/ice/ice_ethdev.c   | 44 +++++++++++++++++++++++++++-
 drivers/net/intel/ice/ice_ethdev.h   |  1 +
 4 files changed, 56 insertions(+), 2 deletions(-)

-- 
2.43.0

