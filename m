Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C0A6071A07
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 20:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NsqsYB2v
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9CF440E03;
	Wed,  4 Nov 2026 21:15:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTPS id 666AC40285
 for <dev@dpdk.org>; Wed,  4 Nov 2026 21:15:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793823314; x=1825359314;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wz7pbM7n38UKU96WFtzjmFdtJTS0selyTFW0+5MsqgM=;
 b=NsqsYB2vZV8hWegx07HpqyH2J4pNqp1N64BvqKGLMg9tj/QXjIm2TUXA
 +xhPSCTxAf3yYBttGXeSn0BCdBkmh86MCkBg5AYPxsIkrEljVLYzvbbH2
 KTGBcx7g43O6AukOMEbxUdBwwn9/imCvVIlnlr189ljePtOIR0Rmu1CW4
 hMRcJkEcZmYXzH0MlLBYejAB2QRgKn7+uEOWx6Ue4uPTMjlu1WHzGQeI5
 JwTMGkVWoSlLuQkX2tfNfyJEd8Wu8Efos+r7WZlaCb8GbNqQ1SOWPZ/Qs
 vqL72OBOw9BDI0Q10dPL0mcYHkIBPd4KpmGwAlqirp+pmebNyoTz9pjsk g==;
X-CSE-ConnectionGUID: wISsDYuZTSeOQsKbdhAkfw==
X-CSE-MsgGUID: Q/XVQqvYTDiRzXYHyw7qvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2627692"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2627692"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 12:15:13 -0800
X-CSE-ConnectionGUID: 3LHiGQeESqS0By6qNFO5gw==
X-CSE-MsgGUID: djgu8up0SPCOwxL5wBiiCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7130669"
Received: from silpixa00401385.ir.intel.com ([10.20.227.220])
 by fmviesa008.fm.intel.com with ESMTP; 04 Nov 2026 12:15:11 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 3/3] build: deprecate HPET support
Date: Wed,  4 Nov 2026 20:15:06 +0000
Message-ID: <20261104201506.4091374-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104201506.4091374-1-bruce.richardson@intel.com>
References: <20260602090847.905721-1-bruce.richardson@intel.com>
 <20261104201506.4091374-1-bruce.richardson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DPDK HPET support has been disabled for many years and superceded by
other timer options such as TSC. Mark HPET support as deprecated
allowing for future removal.

As part of marking the feature as deprecated, remove documentation
instructions as to how to use and configure it, since we do not want to
encourage further use of this feature in new development

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/linux_gsg/enable_func.rst | 32 ----------------------------
 doc/guides/linux_gsg/sys_reqs.rst    |  3 ---
 doc/guides/rel_notes/deprecation.rst |  6 ++++++
 meson_options.txt                    |  2 +-
 4 files changed, 7 insertions(+), 36 deletions(-)

diff --git a/doc/guides/linux_gsg/enable_func.rst b/doc/guides/linux_gsg/enable_func.rst
index d99fafbde0..4c3dffee60 100644
--- a/doc/guides/linux_gsg/enable_func.rst
+++ b/doc/guides/linux_gsg/enable_func.rst
@@ -88,8 +88,6 @@ See :ref:`eal_hugepage_mapping` section to learn how these limits affect EAL.
 Device Control
 ~~~~~~~~~~~~~~
 
-If the HPET is to be used, ``/dev/hpet`` permissions must be adjusted.
-
 For ``vfio-pci`` kernel driver, the following Linux file system objects'
 permissions should be adjusted:
 
@@ -159,33 +157,3 @@ one can look into "Linux cgroups",
 Also see
 `CPU isolation example <https://www.suse.com/c/cpu-isolation-practical-example-part-5/>`_
 and `systemd core isolation example <https://www.rcannings.com/systemd-core-isolation/>`_.
-
-.. _linux_gsg_high_precision_event_timer:
-
-High Precision Event Timer (HPET) Functionality
------------------------------------------------
-
-DPDK can support the system HPET as a timer source rather than the system default timers,
-such as the core Time-Stamp Counter (TSC) on x86 systems.
-To enable HPET support in DPDK:
-
-#. Ensure that HPET is enabled in BIOS settings.
-#. Enable ``HPET_MMAP`` support in kernel configuration.
-   Note that this may involve doing a kernel rebuild,
-   as many common linux distributions do *not* have this setting
-   enabled by default in their kernel builds.
-#. Enable DPDK support for HPET by using the build-time meson option ``use_hpet``,
-   for example, ``meson configure -Duse_hpet=true``
-
-For an application to use the ``rte_get_hpet_cycles()`` and ``rte_get_hpet_hz()`` API calls,
-and optionally to make the HPET the default time source for the rte_timer library,
-the ``rte_eal_hpet_init()`` API call should be called at application initialization.
-This API call will ensure that the HPET is accessible,
-returning an error to the application if it is not.
-
-For applications that require timing APIs, but not the HPET timer specifically,
-it is recommended that the ``rte_get_timer_cycles()`` and ``rte_get_timer_hz()``
-API calls be used instead of the HPET-specific APIs.
-These generic APIs can work with either TSC or HPET time sources,
-depending on what is requested by an application call to ``rte_eal_hpet_init()``,
-if any, and on what is available on the system at runtime.
diff --git a/doc/guides/linux_gsg/sys_reqs.rst b/doc/guides/linux_gsg/sys_reqs.rst
index 2a55301893..a3b23e8168 100644
--- a/doc/guides/linux_gsg/sys_reqs.rst
+++ b/doc/guides/linux_gsg/sys_reqs.rst
@@ -130,9 +130,6 @@ System Software
 
     *   PROC_PAGE_MONITOR support
 
-    *   HPET and HPET_MMAP configuration options should also be enabled if HPET support is required.
-        See the section on :ref:`linux_gsg_high_precision_event_timer` for more details.
-
 .. _linux_gsg_hugepages:
 
 Use of Hugepages in the Linux Environment
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index ae2205827b..88c90fb60d 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -20,6 +20,7 @@ Deprecation Notices
 
   - ``kernel_dir``: option unused as Linux kernel drivers are in a separate ``dpdk-kmods`` repository.
   - ``tests``: disabling tests can be achieved by using the ``enable_apps`` / ``disable_apps`` options instead.
+  - ``use_hpet``: option option will be removed as HPET support itself is deprecated (see below).
 
 * kvargs: The function ``rte_kvargs_process`` will get a new parameter
   for returning key match count. It will ease handling of no-match case.
@@ -34,6 +35,11 @@ Deprecation Notices
   Use the ``-S <service-corelist>`` parameter instead
   to specify the cores to be used for background services in DPDK.
 
+* hpet: HPET support is deprecated and will be removed in a future release.
+  Support has been disabled by default for many years.
+  Applications should use the generic timer APIs,
+  such as ``rte_get_timer_cycles()`` and ``rte_get_timer_hz()`` instead of HPET-specific APIs.
+
 * lib: will fix extending some enum/define breaking the ABI. There are multiple
   samples in DPDK that enum/define terminated with a ``.*MAX.*`` value which is
   used by iterators, and arrays holding these values are sized with this
diff --git a/meson_options.txt b/meson_options.txt
index 323a3901e1..340d9d0a9a 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -57,4 +57,4 @@ option('enable_trace_fp', type: 'boolean', value: false, description:
 option('tests', type: 'boolean', value: true, description:
        '[Deprecated] Value unused. Add "tests" to disable_apps setting to disable the unit tests')
 option('use_hpet', type: 'boolean', value: false, description:
-       'use HPET timer in EAL')
+       '[Deprecated] use HPET timer in EAL')
-- 
2.55.0

