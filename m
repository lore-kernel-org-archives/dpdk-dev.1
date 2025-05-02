Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FF4C3ABAC
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 15:12:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8964340677;
	Fri,  2 May 2025 17:12:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 517334067D
 for <dev@dpdk.org>; Fri,  2 May 2025 17:12:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746198729; x=1777734729;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=U6Y/5zlQcbfNged6ocupYBHYDfCjtOarOUxjoad3o9s=;
 b=j3RYYyKw3021swBVjCLLBMwGXyngZtW5D3oSZ+6CrrnTYHxliLVe8kxS
 KPGysjHIBzV1Z59OH/6CJ5PnEnCuFfe2u9ySlHfwfw/YcTKYuFaQ5xBWg
 PdIVREQVxxGSO+pJr/ElYBOq+844nf36Uuhod5Xat9Jh4Mzf0SH97IGOv
 TBkT2vVPHk5NUMSXpKajoYGyOdx+vmluB4ETKKgln1AXjv060XMdh96j2
 zsB3KOlC/z4FsGULhQwWn1PBNk2QUzcFFDhJ0yfefdJe2ZXlSobSXqn8L
 CdTch6ItI4J2VsiaaHWl2e2jttGUy2ADNy1c5JlXLLKmcrAwoJ6CtaMZC w==;
X-CSE-ConnectionGUID: WqVHUpfYTWawQouBn73cnw==
X-CSE-MsgGUID: Zfw65ozaR+meUjDVJvPmqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="47970525"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="47970525"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 08:12:09 -0700
X-CSE-ConnectionGUID: 7kTXmftdQ625yExVnBr6jQ==
X-CSE-MsgGUID: ojX0bTLkSNa8VLEUupsR2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="135172784"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa007.jf.intel.com with ESMTP; 02 May 2025 08:12:07 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, mb@smartsharesystems.com,
 stephen@networkplumber.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 3/4] doc: provide examples of using lcores EAL parameter
Date: Fri,  2 May 2025 16:11:33 +0100
Message-ID: <20250502151134.536799-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250502151134.536799-1-bruce.richardson@intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250502151134.536799-1-bruce.richardson@intel.com>
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
 doc/guides/linux_gsg/eal_args.include.rst | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux_gsg/eal_args.include.rst
index 01fe6a3006..d530215784 100644
--- a/doc/guides/linux_gsg/eal_args.include.rst
+++ b/doc/guides/linux_gsg/eal_args.include.rst
@@ -23,6 +23,33 @@ Lcore-related options
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
+    but with the threads being bound to physical CPUs 31, 32 and 33 respectively.
+
+    ``--lcores='(1-3)@(31-33)'``: Run three threads with lcore ids 1, 2 and 3.
+    Unlike the previous example above,
+    each of these threads is not bound to one specific physical CPU,
+    but rather, all three threads are instead bound to the three physical CPUs 31, 32 and 33.
+    This means that each of the three threads can move between the physical CPUs 31-33,
+    as decided by the OS as the application runs.
+
+    ``--lcores=(1-3)@20``: Run three threads, with lcore ids 1, 2 and 3,
+    where all three threads are bound to (can only run on) physical CPU 20.
+
+.. Note::
+    Binding multiple DPDK lcores to a single physical CPU can cause problems with poor performance
+    or deadlock when using DPDK rings or memory pools or spinlocks.
+    Such a configuration should only be used with care.
+
 .. Note::
     At a given instance only one core option ``--lcores``, ``-l`` or ``-c`` can
     be used.
-- 
2.45.2

