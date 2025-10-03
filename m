Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE81CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 11:03:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9421140696;
	Fri,  3 Oct 2025 13:02:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id DC6954064A
 for <dev@dpdk.org>; Fri,  3 Oct 2025 13:02:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759489355; x=1791025355;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hEmKmo3QLny+LaqJKfRPYffA8SVFJF59e6HmrEuKO8k=;
 b=OYzic2F6ALE/FRHgW35mOD2HKtLhX1W9TKLjoTvBbtWIjy/61CIxSsMh
 B32xpLgt9PZARBdwWbHCMkzSX3j9Ske+fao8gG8Offjp/eG+ihQXYn4Wy
 fMDXZs4eYmv5P6Z8Ogj1k2fkGhYxmWfZMQPk17IsD2nS4RemaXYdyYhM3
 1YVcZAt72f4wi1ms24YWhBJUS+bR+bWArtBeGHcCTQH9D+6iJuIjwDUod
 ZKAsd3kVBpUyFQSwWsZEtTYP5405xncBmq51e6d3RKvuXJF308l6WYHyd
 zr5AlmQBkPEeSYnXjWtYWFuhM3ModC2d/K8TUeLgsIy+/DJyXBswmCzt1 Q==;
X-CSE-ConnectionGUID: UgxGQQg8Scaur3JjCZSkig==
X-CSE-MsgGUID: 6MPt4D2aSHSCCN1FdkTvww==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="72873501"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="72873501"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 04:02:24 -0700
X-CSE-ConnectionGUID: 5lvIltLBS7ifomstiilS5Q==
X-CSE-MsgGUID: oyBlRaA8QcaIC0XFznvG1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="179077680"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa007.jf.intel.com with ESMTP; 03 Oct 2025 04:02:23 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, thomas@monjalon.net,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 6/7] doc: update docs for ethdev changes
Date: Fri,  3 Oct 2025 12:02:00 +0100
Message-ID: <20251003110201.1541183-7-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251003110201.1541183-1-bruce.richardson@intel.com>
References: <20250923141207.10403-1-bruce.richardson@intel.com>
 <20251003110201.1541183-1-bruce.richardson@intel.com>
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

