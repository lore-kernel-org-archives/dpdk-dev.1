Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84251C5DF66
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 14:59:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A4FD4028B;
	Mon, 17 Aug 2026 16:59:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 53C6E4021F
 for <dev@dpdk.org>; Mon, 17 Aug 2026 16:59:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786978745; x=1818514745;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=I/joI2Bg3udf5ISZBHrw/h6VDJHVwAvCBaH1hORU7BE=;
 b=oF7GhVOlHVbBlMWwI6ucBlpHiXh4XKnxBa35htTgEYbcfT4XTexfZkJR
 LfJxeGRxJS5g7f0gybgNu2MhC11JImNOqNmAQZIrfdjH4X5zxUKxE81fX
 s0eWaL0EhoOSbm8HoSR1q3ro2W0b/XftGIfDh87J2XBzwL2LyzsDGrdpc
 Q9IUALl/59MDhtR7S+6AHcHAEz7oBkK+X98Gt9SOTuiEWcKXS9yT+ae3n
 WTcCfmzej3XDsQe829qvs9iiPSKy5IM1c/phszgmEP7OwQN/jY06SlcjO
 lfMfAMC+CHmGV504PS+wnt0mOy3A6Wt0dFMcEFlazqnyP280V1RDIR0Tq g==;
X-CSE-ConnectionGUID: cw4yHQiBQ9qDJjezkKxAUQ==
X-CSE-MsgGUID: P4g/yne3RLaTc4ILX8m2kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87311441"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="87311441"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 07:59:04 -0700
X-CSE-ConnectionGUID: VU1RGnOiQLCrGzN8OnAN+w==
X-CSE-MsgGUID: 7Bmn4706S8KoL7X2RGbCbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="264972581"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa007.jf.intel.com with ESMTP; 17 Aug 2026 07:59:02 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 0/4] extra unit tests for cfgfile library
Date: Mon, 17 Aug 2026 15:57:20 +0100
Message-ID: <20260817145855.1421504-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706162348.460489-1-bruce.richardson@intel.com>
References: <20260706162348.460489-1-bruce.richardson@intel.com>
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

There were a few APIs in the cfgfile library which were not being
tested by the unit tests. Add tests to close that, and other, gaps.

v2: resubmit for 26.11 without the subject prefix.

Bruce Richardson (4):
  test/cfgfile: improve coverage for listing APIs
  test/cfgfile: validate config creation APIs
  test/cfgfile: verify file modification API
  test/cfgfile: test for long lines in file

 app/test/test_cfgfile.c                  | 197 +++++++++++++++++++++++
 app/test/test_cfgfiles/line_too_long.ini |   2 +-
 2 files changed, 198 insertions(+), 1 deletion(-)

-- 
2.53.0

