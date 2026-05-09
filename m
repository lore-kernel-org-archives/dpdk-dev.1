Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40856CD37B2
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 18:00:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF5D24066B;
	Sat,  9 May 2026 20:00:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id F3BD240269
 for <dev@dpdk.org>; Sat,  9 May 2026 20:00:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778349616; x=1809885616;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x4nhF/eqx+ca2y4P82nRFLJHuoLRV4hiA0fwCJaQnYc=;
 b=Qha5auRBaos+AhGp+hUPe4jNbdRD14xggqhKqSYUmLdlMRwqLz/GChef
 AQmUZq5E3wfV8UUdPPUvK6fbS9+4eD3TwPIWAJE5HRul0LhmOXq/DhrLJ
 dNp6v0tc8dJidu9Yi0I7vci/Mj1tD9K1H+TeDbbOP6kFNSVyyJo9cfM8V
 x2EkxQz/PKXQcWaJV48nAOOkuoSiMy1VwevrRV24O02usQ7ZSEURz+3QT
 rrA8l+mL1+JB+9R7wcAthaJ3o9KA3Dtq/5VqRE+KH0DoKMvMHkMyhue+D
 qi+Lkgfc40Tl0RF/67Wyl2Oa8aop8DqNC9iNfwEVjVONLKK7kQPXiJ0EH Q==;
X-CSE-ConnectionGUID: 4OILkVT8QnisB6s1XDe95w==
X-CSE-MsgGUID: fxRTGMJhTU2SdAsz6YjWXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="96865024"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; d="scan'208";a="96865024"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2026 11:00:15 -0700
X-CSE-ConnectionGUID: qE7lt2fjR0KVWoSpRShhbA==
X-CSE-MsgGUID: wcKIUsD0S8qCqKhQ65eppw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; d="scan'208";a="267426441"
Received: from icx008.iind.intel.com ([10.190.212.196])
 by orviesa002.jf.intel.com with ESMTP; 09 May 2026 11:00:14 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, aman.deep.singh@intel.com,
 stephen@networkplumber.org, mb@smartsharesystems.com,
 Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [PATCH v8 3/4] doc: update release notes for PTP protocol library
Date: Sun, 10 May 2026 04:55:50 +0530
Message-ID: <20260509232551.2844201-4-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509232551.2844201-1-rajesh3.kumar@intel.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
 <20260509232551.2844201-1-rajesh3.kumar@intel.com>
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

