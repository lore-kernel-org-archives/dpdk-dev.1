Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7CDEDF173
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 15:22:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDC51402C0;
	Fri, 13 Feb 2026 16:22:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id B4AC0402B2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 16:22:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770996165; x=1802532165;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1a4oNp167yR6olyNhoS2GHBUyUBfO1VqZAPV2ZC3B/w=;
 b=Pu2NANSnSwAc57xVNrmmAwApEKKdnPXOJT8NOUIZKUG/AQnKkUjkEmF7
 Ty/dnPafHBtDfLQ3Y1Q42M3RjXdMMSDo0EoEv00x0NIkNbHtqM9OAJo43
 ADU9JP8JmpZly2sLClYpEnpthGL/bWGyJPjFjcJ2X0nai90kSG2urF38O
 XYWbUHmSXSjhpAJ1Y6r07f7SzQZiHH1p7WPe1ZOH7MRwDp9vyBpmCBZTE
 xYR+sKWDgyIh7vipuXPS9raebm7sXMNV42TnNhsIdn34b0ZxOQFIygj5E
 mzz6w9l+qX163+g1koXaYAbgY37sJ+96AaVatHFwuFpaff0oYoppvuvrq g==;
X-CSE-ConnectionGUID: NJhOwTHKTxa/Ds6Pcxoa3Q==
X-CSE-MsgGUID: TVF2kUXPTQqk41a/URvxCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="75803789"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="75803789"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 07:22:43 -0800
X-CSE-ConnectionGUID: /KwNdd1rQjOjVdv1BnHMtw==
X-CSE-MsgGUID: p4DWd+4jTeql89W7cv/1UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="217094192"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa003.jf.intel.com with ESMTP; 13 Feb 2026 07:22:43 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 0/3] improve error reporting & resilience in unit tests
Date: Fri, 13 Feb 2026 15:22:23 +0000
Message-ID: <20260213152227.879170-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126164519.3029952-1-bruce.richardson@intel.com>
References: <20260126164519.3029952-1-bruce.richardson@intel.com>
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

In the EAL flags unit tests sporadic errors were encountered which were proving
both difficult to debug and to reproduce. This series aims to improve the
situation by firstly adding more debug logs and output so we can better
root cause any issues experienced. The final patch then removes pci probing from
many test runs where its not needed, so as to avoid issues with unexpected
drivers being loaded or probed due to the HW on the system running the tests.

V2: split second patch into two, to separate out logging and no-pci changes

Bruce Richardson (3):
  eal: add location info to interrupt error message
  test/eal_flags: add EAL debug flags to recursive calls
  test/eal_flags: remove PCI probing for recursive calls

 app/test/test_eal_flags.c              | 229 +++++++++++++------------
 lib/eal/common/eal_common_interrupts.c |   2 +-
 2 files changed, 123 insertions(+), 108 deletions(-)

--
2.51.0

