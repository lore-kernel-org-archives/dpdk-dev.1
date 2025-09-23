Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1FFCAC5AC
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 14:13:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3743406A2;
	Tue, 23 Sep 2025 16:12:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id DAE0C40672
 for <dev@dpdk.org>; Tue, 23 Sep 2025 16:12:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758636769; x=1790172769;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FGuP0LRnUg8VgAhoOuBTfbLslyL1wBB98Njix16o7Zc=;
 b=ADEx8osLDtJUCwrVcE7hNnQmxw7XFO3YeEQLL7F892P0ScHr2jGbKpJk
 Bz62UmmVjZZ6pM3dWfLdUIh8jIjpl2BzfnyyGSgRLVeqoWhe6IAqylmoS
 FHFBGBPXNeuyqMI51CE6ZJfZYL1VeiPCFBbeBST8T5QRnqYwt1oFPSj2P
 VZLk22R23dtwdz1DgwIAQ74DP8xB6VDlX3HizZ2E4xXaofV6l1Tg+MVe7
 doLKWuLv3WZ/GQh5d3n1IMKSfry6YQs/mXQVSvFMso6TO0EWVM1nnQXSY
 y+IpOPVCr1mCbOgC5WylGuspHvCvFie997Oj3GfGHwaMajZiyFWHI2xDm g==;
X-CSE-ConnectionGUID: CRGZLNCSSyOjv/+m1aXDrg==
X-CSE-MsgGUID: 11OY5aZOTsaYs2JYg/lF/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="64554302"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="64554302"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 07:12:46 -0700
X-CSE-ConnectionGUID: XjBImVCMSn2+EtcwPBiejg==
X-CSE-MsgGUID: yg2NAob2S/OY7wOBHwzeUQ==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com (HELO silpixa00401385..)
 ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 23 Sep 2025 07:12:45 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 6/6] doc: update docs for ethdev changes
Date: Tue, 23 Sep 2025 15:12:06 +0100
Message-ID: <20250923141207.10403-7-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250923141207.10403-1-bruce.richardson@intel.com>
References: <20250923141207.10403-1-bruce.richardson@intel.com>
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

Move text from deprecation notice to release note, and update.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/rel_notes/deprecation.rst   | 7 -------
 doc/guides/rel_notes/release_25_11.rst | 6 ++++++
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 5aaeb1052a..bdebc3399f 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -110,13 +110,6 @@ Deprecation Notices
   - ``rte_flow_item_pppoe``
   - ``rte_flow_item_pppoe_proto_id``
 
-* ethdev: Queue specific stats fields will be removed from ``struct rte_eth_stats``.
-  Mentioned fields are: ``q_ipackets``, ``q_opackets``, ``q_ibytes``, ``q_obytes``,
-  ``q_errors``.
-  Instead queue stats will be received via xstats API. Current method support
-  will be limited to maximum 256 queues.
-  Also compile time flag ``RTE_ETHDEV_QUEUE_STAT_CNTRS`` will be removed.
-
 * ethdev: Flow actions ``PF`` and ``VF`` have been deprecated since DPDK 21.11
   and are yet to be removed. That still has not happened because there are net
   drivers which support combined use of either action ``PF`` or action ``VF``
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index efb88bbbb0..441085de69 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -105,6 +105,12 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* ethdev: As previously announced in deprecation notes,
+  queue specific stats fields are now removed from ``struct rte_eth_stats``.
+  Mentioned fields are: ``q_ipackets``, ``q_opackets``, ``q_ibytes``, ``q_obytes``, ``q_errors``.
+  Instead queue stats will be received via xstats API.
+  Also compile time flag ``RTE_ETHDEV_QUEUE_STAT_CNTRS`` is removed from public headers.
+
 
 ABI Changes
 -----------
-- 
2.48.1

