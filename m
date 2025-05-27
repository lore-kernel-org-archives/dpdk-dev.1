Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD62C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 15:29:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F2B640A77;
	Tue, 27 May 2025 17:29:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 7006740678
 for <dev@dpdk.org>; Tue, 27 May 2025 17:29:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748359763; x=1779895763;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oUfwkSvG+Y87RkUx3zqtwvaDGB2BH3Jpz+hVLkxbX8c=;
 b=ascijQjgIHJD81r7ZcAbgle2qT4SjwCz1OYOZlgvOp+clomnTSQTUbLH
 PUQKeOtQ+4nEETydifox5Dv14S5UINBnpjrioveC9ywj5pErJLAAlxUgV
 ztmW1AZdm7LdugH1hnoLAVSysQD0PdIyisDnOtohugt4DFveZzQ9NABZU
 pjBa4jmlbKG0KdEM+W/HW5F+yoy1RU7Xbn2kSEdOP7oIBQJFUJE+Pq4HE
 jw0Lr20rMgtavMx85Lk3IH5+Mhcd7wr2OXw9r+4DwyqD2H4dhuID8xEva
 ULBSCIki1lhqY5fz4ig1jBheBH5cVvI0xKCL7SZ4cxkiIZ2ST8GFpfRyd A==;
X-CSE-ConnectionGUID: CvT+moLrSMCxbpBGKXphPA==
X-CSE-MsgGUID: jx9MbDNdRsqg6hvLXNjX5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50233263"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="50233263"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 08:29:22 -0700
X-CSE-ConnectionGUID: I95xmGnESvOAr34YzCzVqw==
X-CSE-MsgGUID: xgJKGZa9RjGqSwX4aemAHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="180067387"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa001.jf.intel.com with ESMTP; 27 May 2025 08:29:21 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v5 3/3] doc: provide examples of using lcores EAL parameter
Date: Tue, 27 May 2025 16:29:13 +0100
Message-ID: <20250527152913.279011-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250527152913.279011-1-bruce.richardson@intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250527152913.279011-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 doc/guides/linux_gsg/eal_args.include.rst | 32 +++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux_gsg/eal_args.include.rst
index 01fe6a3006..2fc03594e5 100644
--- a/doc/guides/linux_gsg/eal_args.include.rst
+++ b/doc/guides/linux_gsg/eal_args.include.rst
@@ -23,6 +23,38 @@ Lcore-related options
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
+    ``--lcores=1@31,2@32,3@33``: Run threads having internal lcore ids of 1, 2 and 3,
+    but with the threads being bound to physical CPUs 31, 32 and 33 respectively.
+
+    ``--lcores='(1-3)@(31-33)'``: Run three threads with lcore ids 1, 2 and 3.
+    Unlike the previous example above,
+    each of these threads is not bound to one specific physical CPU,
+    but rather, all three threads are instead bound to the three physical CPUs 31, 32 and 33.
+    This means that each of the three threads can move between the physical CPUs 31-33,
+    as decided by the OS as the application runs.
+
+    ``--lcores='(1-3)@20'``: Run three threads, with lcore ids 1, 2 and 3,
+    where all three threads are bound to (can only run on) physical CPU 20.
+
+.. Note::
+    Binding multiple DPDK lcores to a single physical CPU can cause problems with poor performance
+    or deadlock when using DPDK rings or memory pools or spinlocks.
+    Such a configuration should only be used with care.
+
+.. Note::
+    As shown in the examples above, and depending on the shell in use,
+    it is sometimes necessary to enclose the lcores parameter value in quotes,
+    for example, when the parameter value starts with a ``(`` character.
+
 .. Note::
     At a given instance only one core option ``--lcores``, ``-l`` or ``-c`` can
     be used.
-- 
2.48.1

