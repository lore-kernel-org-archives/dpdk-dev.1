Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931E1CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 09:09:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E064340659;
	Tue,  2 Jun 2026 11:08:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 20F22402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 11:08:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780391334; x=1811927334;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=C8G+bvMB6TawR8UjPCVaayZM7ToEN4sYa2ts/DsgQR0=;
 b=QfF0OTQk5SYe43x25dbdyT6KTKGaHgTOM/sgQKnJNwNbS9gcGMh+9Ttn
 m1Fdy6o9b93M6jDtaCyZOpM7Gnpt/DZaF39q9tiDAJU92AxhS7lbpKMls
 Cm9+GMzUtJ3UFIUjPNojDJsVZAmXDCbARKkoXJqLKgGh3bNvIk6kV88Uo
 w/MqwTH0+PLKrMccfHHUUfG0DMmT9mIwfk5omcScrCWdXiEqOWPLD9Qr5
 2wMQGt36bAxs42mXB2cLZXHde5honRD6PznW4PHEjzDO4QlMN+QWN6vHb
 UvH3zeCErxhNal/vew62HAKEZPRZvuk1ZoS+cmhWOxNXHvTzOxWZiPVtg A==;
X-CSE-ConnectionGUID: qZUc1lz4TJqnEAYRfRDong==
X-CSE-MsgGUID: A5EerrJQRF+jwQmehDHntA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="80201503"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="80201503"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 02:08:53 -0700
X-CSE-ConnectionGUID: c/D6WXydTxOM8XGjq6sT4g==
X-CSE-MsgGUID: JjVqB3OkRAamITiuUQGYdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="247809472"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa003.jf.intel.com with ESMTP; 02 Jun 2026 02:08:52 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 1/3] build: deprecate kernel dir option
Date: Tue,  2 Jun 2026 10:08:45 +0100
Message-ID: <20260602090847.905721-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602090847.905721-1-bruce.richardson@intel.com>
References: <20260602090847.905721-1-bruce.richardson@intel.com>
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

The kernel_dir option does nothing, so it can be deprecated and removed
in future.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/rel_notes/deprecation.rst | 4 ++++
 meson_options.txt                    | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 17f90a6352..ed1dda6008 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -17,6 +17,10 @@ Other API and ABI deprecation notices are to be posted below.
 Deprecation Notices
 -------------------
 
+* build: The following meson build options are deprecated and will be removed in a future release:
+
+  - ``kernel_dir``: option unused as Linux kernel drivers are in a separate ``dpdk-kmods`` repository.
+
 * kvargs: The function ``rte_kvargs_process`` will get a new parameter
   for returning key match count. It will ease handling of no-match case.
 
diff --git a/meson_options.txt b/meson_options.txt
index e28d24054c..7bd5ebc084 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -33,7 +33,7 @@ option('ibverbs_link', type: 'combo', choices : ['static', 'shared', 'dlopen'],
 option('include_subdir_arch', type: 'string', value: '', description:
        'subdirectory where to install arch-dependent headers')
 option('kernel_dir', type: 'string', value: '', description:
-       'Path to the kernel for building kernel modules. Headers must be in $kernel_dir or $kernel_dir/build. Modules will be installed in /lib/modules.')
+       '[Deprecated] Value unused. Previously, path to the kernel for building kernel modules.')
 option('machine', type: 'string', value: 'auto', description:
        'Alias of cpu_instruction_set.')
 option('max_ethports', type: 'integer', value: 32, description:
-- 
2.53.0

