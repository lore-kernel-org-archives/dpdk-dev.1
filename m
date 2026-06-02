Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C407CD6E57
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 15:45:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0FA04064C;
	Tue,  2 Jun 2026 17:45:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 8E168402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 17:45:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780415118; x=1811951118;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0DT2ZbbH41sCnm2ACoFbCDxkfQVmRVXQyLX/x7dbNEI=;
 b=mf/OSnO0uOYKpCjgaHfZsA9g4YlPUFApFM638QGKhGL8HqiXazgOkMw5
 R4f/dnPZnjPbeqWi9SeXrpeCn4e5amLhaCVai+vtEOyaC4xTB5n5ntsLL
 Db7eRcDn2b9jX7prfZSYpp7OQp9bQL4cNK5VWUbW6aFItlT0F7jsiYRm2
 4IMh/Fbzb6m4Nf2kdES6/duUwiXUjF5+EfvmGUK4J9DzpVJFhKBFroRdO
 Y5/wJmThOIYqNCvPwK4rbYh6mYE+AsNvlhv1bN904Xm1MC2KgyJoIjBgN
 +Jkc294HsAbBv0h1GkqBrBlVB4Qgi7+4webmvfj9HimdtmDQRym/Ujzo+ w==;
X-CSE-ConnectionGUID: +mrysaaLREurfd0mCP8hMA==
X-CSE-MsgGUID: PGRj9hy1Qxi3n5SWPcD8hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81385601"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="81385601"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 08:45:17 -0700
X-CSE-ConnectionGUID: CrXco0UAQeekh00Afh9oqA==
X-CSE-MsgGUID: pCNH9ZWhTSqtXFosxXzGtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="237593609"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa009.fm.intel.com with ESMTP; 02 Jun 2026 08:45:15 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, ciara.loftus@intel.com,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 0/2] net/intel: optimize for fast-free hint
Date: Tue,  2 Jun 2026 16:45:10 +0100
Message-ID: <20260602154513.1079865-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260123112032.2174361-1-bruce.richardson@intel.com>
References: <20260123112032.2174361-1-bruce.richardson@intel.com>
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

When the fast-free hint is provided to the driver we know that the mbufs
have refcnt of 1 and are from the same mempool. Therefore, we can
optimize a bit for this case even in the scalar path of our drivers.

---
v4:
* add precursor patch to adjust mbuf pointers so that the DD bit
  is written to a descriptor with a valid mbuf pointer associated
  with it.

v3:
* used mbuf_raw_free_bulk rather than mempool function directly
* check for fast_free via mp pointer rather than flags
* remove unnecessary prefetches

V2: Fix issues with original submission:
* missed check for NULL mbufs
* fixed issue with freeing directly from sw_ring in scalar path which
  doesn't work as thats not a flag array of pointers
* fixed missing null assignment in case of large segments for TSO


Bruce Richardson (2):
  net/intel: write mbuf for last Tx desc of segment
  net/intel: optimize for fast-free hint

 drivers/net/intel/common/tx.h        | 21 ++++--
 drivers/net/intel/common/tx_scalar.h | 98 +++++++++++++++++++++-------
 2 files changed, 90 insertions(+), 29 deletions(-)

--
2.53.0

