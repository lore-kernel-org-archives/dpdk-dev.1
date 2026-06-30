Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562C8C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:16:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2909140684;
	Tue, 30 Jun 2026 16:16:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id BB92E40648
 for <dev@dpdk.org>; Tue, 30 Jun 2026 16:16:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782829007; x=1814365007;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dlcxl8JxvXg9g+y+MGdZyck8wEvo5rpd4cB03cmHcag=;
 b=WcYgUaO/1dBauybarWq9BHwmFhN0VYLUQtwUHc9adHL7umKG0VoUChW4
 yHQ9QeS/yuy0T10xOLzkQnAEht6zNKfNwObzSWvkWbLwblEvoza1DsbTd
 5TWiPsjy74pmWZQGil6aDLXejYKYXm9hIXu1hQn1BxIPH1eqCZmDJmnr8
 nT/9UObwDrxXor5sC7rj7SV0KbGQUQcUbzT0uY1Kdwv5/yEKDsIgDwKQa
 nQdlxoeD9ahjReVi866Y93fbyrC35ghQ7DrxiDRm/CrdNiuiETjbKNFiQ
 eaoWiNjDfob+1w5E5s5uWcsbTqQrKkatVaYzXxMebh2Eorw3n3zY/jHzW Q==;
X-CSE-ConnectionGUID: 0xI+SLarQBeZ4RDk17se+A==
X-CSE-MsgGUID: wKjGiH/QQxq6hluERKNlKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94693503"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="94693503"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 07:16:45 -0700
X-CSE-ConnectionGUID: rS0RivpUR2WR7JrsZXkgFA==
X-CSE-MsgGUID: VeXPASc3SVuX6Bg13WXWfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="248291036"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa010.fm.intel.com with ESMTP; 30 Jun 2026 07:16:44 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 0/2] net/intel: fix link status when interrupt delivery
 unavailable
Date: Tue, 30 Jun 2026 14:16:25 +0000
Message-ID: <20260630141627.1035420-1-ciara.loftus@intel.com>
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

Ciara Loftus (2):
  net/ice: poll AdminQ if interrupt delivery unavailable
  net/i40e: activate alarm if interrupt delivery unavailable

 drivers/net/intel/i40e/i40e_ethdev.c |  9 +++++-
 drivers/net/intel/i40e/i40e_ethdev.h |  2 ++
 drivers/net/intel/ice/ice_ethdev.c   | 45 +++++++++++++++++++++++++++-
 drivers/net/intel/ice/ice_ethdev.h   |  1 +
 4 files changed, 55 insertions(+), 2 deletions(-)

-- 
2.43.0

