Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF832E9A03E
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 09:50:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A1CA402E0;
	Wed, 18 Feb 2026 10:50:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id E7F6D4014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 10:50:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771408205; x=1802944205;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=R5V+O6sbTkdLUl0NPa8VmacuOrQ5T7eBpdrpuuhN1x8=;
 b=A7m6ZVJYkuDXqV0botKPQFjPw/TCeStQH4bzxSXWk4x+/68ZfZscKVa0
 0UD+bIry2kgQUBVYnWYl39WxSIoiqjzNEl3vG8aEglf9WXxfbOtNEhrq3
 ivItJZ/F8Z72fsTRUN4kMT69W+ppdRhYXYBBSuUHksaWIQ/H+d35cZiji
 xkJR37WvOao1erXBTTXPzfX5NCilZVC/8Vb9sSBEU4038xvUD8yKybhfF
 HFm1A2b6ucLiPpXlXg7TDEpzSfvs0e8I1/08wZ7kqIZ4uuwD7DJeLM9P1
 axWeCFZy+ldIThJ8VFY14XarwUIjc4mIT4Xhb+t1qg9+XUQstw+UtJwRq A==;
X-CSE-ConnectionGUID: 2UxPaFp6RUW3qY0RsipDvw==
X-CSE-MsgGUID: F5TlW25LSiKogXWlr4FFpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="83929840"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="83929840"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 01:50:04 -0800
X-CSE-ConnectionGUID: EyulqEtlQGqX+OoqMl2YiA==
X-CSE-MsgGUID: Hm+QwS/TRcKAKttQtZRZcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="214257048"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa007.jf.intel.com with ESMTP; 18 Feb 2026 01:50:02 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 00/10] Fix multi process path selection in Intel drivers
Date: Wed, 18 Feb 2026 09:49:27 +0000
Message-ID: <20260218094937.1652391-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205124627.371733-1-ciara.loftus@intel.com>
References: <20260205124627.371733-1-ciara.loftus@intel.com>
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

This series fixes and makes consistent the approach to selecting Rx and
Tx paths in a multi process scenario across the Intel drivers that use
the common path selection framework.

In v25.11 the i40e, iavf and ice drivers prevented Rx path selection by
secondary processes, in favour of simply selecting the path chosen by
the primary process. However, this model does not work if the primary
process hasn't started the device before the secondary process
encounters the path selection logic. To address this, permit path
selection by any process, so long as the device has not yet been
started. This allows for the use case where the secondary process is the
process that starts the device.
The idpf and cpfl drivers are updated to follow this model as well.

The same issue exists for the Tx path selection for i40e, iavf, ice,
idpf and cpfl, so implement the same logic when selecting a Tx path as
well ie. permit path selection if the device has not been started.

If two processes were to call the path selection at the same time, in
most cases they should both land on the same result. Both would be using
the same information from dev->data to build up the structure that is
used as input to the path selection function. The effect would be both
writing the same values to shared variables eg. rx_func_type in
dev->data->dev_private. For this reason I did not add any locking around
the path selection logic. The only exception would be the case where the
primary and secondary processes are configured with different maximum
SIMD bitwidths however this is an invalid use case IMO.

I kept the patches for fixing the Rx and Tx path selection separate, as
the patches that target the Rx side will need to be backported to v25.11
whereas the patches for the Tx side do not as that logic was introduced
post v25.11.

v3: In iavf ensure a secondary process can see if the primary process has
enabled LLDP, which ensures that the correct Tx path will be chosen ie.
one with context descriptor support if LLDP is enabled.

Ciara Loftus (10):
  net/i40e: permit secondary process Rx path selection
  net/iavf: permit secondary process Rx path selection
  net/ice: permit secondary process Rx path selection
  net/idpf: prevent Rx path selection after device start
  net/cpfl: prevent Rx path selection after device start
  net/i40e: permit secondary process Tx path selection
  net/iavf: permit secondary process Tx path selection
  net/ice: permit secondary process Tx path selection
  net/idpf: permit secondary process Tx path selection
  net/cpfl: permit secondary process Tx path selection

 drivers/net/intel/cpfl/cpfl_rxtx.c   | 13 ++++++++++---
 drivers/net/intel/i40e/i40e_rxtx.c   |  8 ++++----
 drivers/net/intel/iavf/iavf_ethdev.c |  5 +++++
 drivers/net/intel/iavf/iavf_rxtx.c   |  8 ++++----
 drivers/net/intel/ice/ice_rxtx.c     |  8 ++++----
 drivers/net/intel/idpf/idpf_rxtx.c   | 13 ++++++++++---
 6 files changed, 37 insertions(+), 18 deletions(-)

-- 
2.43.0

