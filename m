Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A823CAC5B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 15:01:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7ECF40A71;
	Mon, 29 Sep 2025 17:00:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 1926A40A6E
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:00:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759158022; x=1790694022;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hEmKmo3QLny+LaqJKfRPYffA8SVFJF59e6HmrEuKO8k=;
 b=dRs1YMO38xjtz1BHeebhkjF0HhkJwd1uT5uC5paovm171zX0hrRTrDRw
 ZFBePZGCmOizg9JolNKEnk7RhL/LoHOCA9UgHOutIUWGIkeDHjO2C3b7F
 vmv4MD/5FfUm5oBIuS2tAOETugNOHSDWeU4m0yodChuFxHTaR4e5DJpM4
 FAQ3gpI/Enpxl5dXU9OC0cbIXQeCGMaMXVdCCFzeLNR7LoR+Wc83PjvLO
 +wcUoeZyuy+nfdb7fpv1Y5R/Ahewk9U32F2xMwLRt207AT6KZrdt82GYv
 x3AO4XNLbr2VeFwJls69e7sXn4BhWPyT9oI5l6JW2UcTw2wxZwuREBc3h w==;
X-CSE-ConnectionGUID: f+1/C+xrSTaxsyzYCyRETw==
X-CSE-MsgGUID: UrMnaVtLQmeA/czxVCmu/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="84017136"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="84017136"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 08:00:21 -0700
X-CSE-ConnectionGUID: LyJ0OBrTQ7y1M39WZepPsQ==
X-CSE-MsgGUID: 5L1KifiOTd+ckSecxyr5XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="178638047"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 29 Sep 2025 08:00:20 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 6/6] doc: update docs for ethdev changes
Date: Mon, 29 Sep 2025 16:00:09 +0100
Message-ID: <20250929150009.1542208-7-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250929150009.1542208-1-bruce.richardson@intel.com>
References: <20250923141207.10403-1-bruce.richardson@intel.com>
 <20250929150009.1542208-1-bruce.richardson@intel.com>
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
index 483030cda8..4b9da99484 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -98,13 +98,6 @@ Deprecation Notices
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
index c3b94e1896..4b00d3ec9e 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -116,6 +116,12 @@ API Changes
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

