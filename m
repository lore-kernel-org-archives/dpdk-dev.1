Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC10CD3427
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 04:48:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8B2840689;
	Thu,  7 May 2026 06:47:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id A93234066F
 for <dev@dpdk.org>; Thu,  7 May 2026 06:47:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778129269; x=1809665269;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x4nhF/eqx+ca2y4P82nRFLJHuoLRV4hiA0fwCJaQnYc=;
 b=dSTF7H9ErUQpknKZnOF9ZMgMKwsMs0sVJB6Kaxmae/6S8SaOQ/69NDkH
 K2it2UrBZQBwNtg9zRKyyxVneJVaCPeXrTm7VEIo+lYYKwjPjFkoXcnQ8
 +aa3OabwsvjazVp/yZ54CkZV2VwJPiZVwg5NNaEp0hD8ookHDtM6TmR6d
 z36N6qVac0wCsZDhHyCMtCdpC4En/Kr6g2jOuigRtXzf+LDfK+hnK2kIY
 m2/UbxCetUge7xeBXUUFoKm7re3xZEHYwbNooZAwKkiBnNUFvI9dpXBnU
 PMUhyIwJknyc60sS5RqKXXErMSnSlkzjcHy2+km/rMBNegAAWQMn/TguS g==;
X-CSE-ConnectionGUID: UEquW9uDSG6l5NS5uzI6Ag==
X-CSE-MsgGUID: tN92ZyqoTBuejvt3ErUhOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79180250"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; d="scan'208";a="79180250"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 21:47:48 -0700
X-CSE-ConnectionGUID: lnFBtuR5TYeoA/gGAjv7Qg==
X-CSE-MsgGUID: ZTvM7z1xR8q44WV11ANfYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; d="scan'208";a="233680758"
Received: from icx008.iind.intel.com ([10.190.212.196])
 by fmviesa008.fm.intel.com with ESMTP; 06 May 2026 21:47:46 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, aman.deep.singh@intel.com,
 stephen@networkplumber.org, mb@smartsharesystems.com,
 Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [PATCH v6 3/4] doc: update release notes for PTP protocol library
Date: Thu,  7 May 2026 15:43:13 +0530
Message-ID: <20260507101314.2456467-4-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507101314.2456467-1-rajesh3.kumar@intel.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
 <20260507101314.2456467-1-rajesh3.kumar@intel.com>
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

Update release notes with IEEE 1588 PTP additions:
  - PTP protocol definitions in lib/net/rte_ptp.h (header-only library
    with inline helpers and wire-format structures)
  - PTP software relay example application (ptp_tap_relay_sw)

Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
---
 doc/guides/rel_notes/release_26_07.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index f012d47a4b..c64e6e141b 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -63,6 +63,18 @@ New Features
     ``rte_eal_init`` and the application is responsible for probing each device,
   * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
 
+* **Added PTP protocol definitions (rte_ptp.h).**
+
+  Added IEEE 1588 Precision Time Protocol header structures, constants,
+  and inline helpers to ``lib/net/rte_ptp.h``.  Provides wire-format
+  structures with endian-annotated types and correctionField manipulation
+  for Transparent Clock implementations.
+
+* **Added PTP software relay example application.**
+
+  Added a new example application ``ptp_tap_relay_sw`` demonstrating a
+  software PTP Transparent Clock relay between a DPDK port and a kernel
+  TAP interface.
 
 Removed Items
 -------------
-- 
2.53.0

