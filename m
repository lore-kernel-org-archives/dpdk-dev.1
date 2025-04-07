Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147B6C3601E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 13:25:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0486A406B6;
	Mon,  7 Apr 2025 15:25:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 47FAE406BA
 for <dev@dpdk.org>; Mon,  7 Apr 2025 15:25:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744032308; x=1775568308;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TIaXZATNCBq5Hy9lYGyEF1/0olun993PR2d/RAQVziw=;
 b=RuiFsFDETzhDSORy5HR3BUmxjLk9fCCYdlKYhC+Uy1qLPsrDkqoUH1tb
 8LNcBb77oL7arxiSTeaUO0kgEJTaulwlSYc/IllRA5aUvJRGaXj6KQOjq
 ZsKWEVCRrn2k3IMGqQr8Hj+E09XEpXim0Cw8vMbl1adU7w1nSNIAOqdJY
 QM81t06AkE9WIph5uXFOAY05814AQDQ4e3oXvHgcNda9zjM8EplZpqBm/
 /lJGhZZS9k1wRE39/V/QPB13wqdD0DfnrVwqb+0p6RsR36kcvMkr1XxCC
 DX7e+lyfcLaZvAsrWHYEE6bu9q7ZTLeH4s6nbAvakdh9TOfMR/89eACTw w==;
X-CSE-ConnectionGUID: kCADlFGBQFuXD2sUfqlyew==
X-CSE-MsgGUID: +SOWoASBS0Kr1TCxBJ0Iyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49269092"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="49269092"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 06:25:07 -0700
X-CSE-ConnectionGUID: GPCAmBLpSvel8hzeFz/bGA==
X-CSE-MsgGUID: mfmMBC0HRd6FzalLTBwVPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="128485439"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa007.jf.intel.com with ESMTP; 07 Apr 2025 06:25:06 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: mb@smartsharesystems.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] doc: provide examples of using lcores EAL parameter
Date: Mon,  7 Apr 2025 14:24:51 +0100
Message-ID: <20250407132451.1101691-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
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

The "--lcores" EAL parameter has a very powerful syntax that can be used
to provide precise control over lcore mappings. The docs however, only
provided a minimal description of what it can do. Augment the docs by
providing some examples of use of the option, and what the resulting
core mappings would be.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/linux_gsg/eal_args.include.rst | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux_gsg/eal_args.include.rst
index 9cfbf7de84..081f09d353 100644
--- a/doc/guides/linux_gsg/eal_args.include.rst
+++ b/doc/guides/linux_gsg/eal_args.include.rst
@@ -29,6 +29,31 @@ Lcore-related options
     The grouping ``()`` can be omitted for single element group.
     The ``@`` can be omitted if cpus and lcores have the same value.
 
+    Examples:
+
+    ``--lcores=1-3``: Run threads on physical CPUs 1, 2 and 3,
+    with each thread having the same lcore id as the physical CPU id.
+
+    ``--lcores=1@(1,2)``: Run a single thread with lcore id 1,
+    but with that thread bound to both physical CPUs 1 and 2,
+    so it can run on either, as determined by the operating system.
+
+    ``--lcores='1@31,2@32,3@33'``: Run threads having internal lcore ids of 1, 2 and 3,
+    but with the threads being bound to physical CPUs 31, 32 and 33.
+
+    ``--lcores='(1-3)@(31-33)'``: Run three threads with lcore ids 1, 2 and 3.
+    Unlike the previous example above,
+    each of these threads is not bound to one specific lcore,
+    but rather, all three threads are instead bound to the three physical cores 31, 32 and 33.
+
+    ``--lcores=(1-3)@20``: Run three threads, with lcore ids 1, 2 and 3,
+    where all three threads are bound to (can only run on) physical CPU 20.
+
+.. Note::
+    Binding multiple DPDK lcores can cause problems with poor performance or deadlock when using
+    DPDK rings or memory pools or spinlocks.
+    Such a configuration should only be used with care.
+
 .. Note::
     At a given instance only one core option ``--lcores``, ``-l`` or ``-c`` can
     be used.
-- 
2.45.2

