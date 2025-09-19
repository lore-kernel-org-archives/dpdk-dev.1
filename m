Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B988CAC592
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 07:57:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44F8940647;
	Fri, 19 Sep 2025 09:57:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 3090F40611
 for <dev@dpdk.org>; Fri, 19 Sep 2025 09:57:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758268660; x=1789804660;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=f41W8aEDxnUXJ6mtILfWeF4FFLb45RDMoDSrh4MiYdw=;
 b=J/u/CL8XP3Pgdq8GF6YgrzDxz7LcQlvTQKUJjP/J94S+uBc4DCtwEyCm
 HFmn8Oq9sAKrfzKH5Mlnsvm/p45ycieOGlTdfKpBbh7wy1rcU1D/5jipN
 EwdIPKFadiVu1SgCE2YcA8T1YcR+y+S2hke3n/+gwPSzwomMAK5+XkF6d
 s/d/WbXTsSdxYCs40a0NtdYKiVFWnB8ZEubYeDpwS4Q7RBVnxUY4oIzsQ
 fOv9R0LSx1f4hmGG7JvprAeeKszX+/RAyExTRqmqIpjQe6tSI/KDve1om
 cVkEFs8b714Zc+M1gr8JlrOyrADJ1kWlISNprybF5ncCapbudpIz+hB3I w==;
X-CSE-ConnectionGUID: OX8tlLpMRNKSKXG5KrbYPQ==
X-CSE-MsgGUID: ewqov46GQY208HslFCeXcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="71291439"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; d="scan'208";a="71291439"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2025 00:57:39 -0700
X-CSE-ConnectionGUID: FkmvB+mwSgqaVt+xV03RRQ==
X-CSE-MsgGUID: 9wzg1arDSPqtCapijfz9MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; d="scan'208";a="181045017"
Received: from silpixa00401385.ir.intel.com (HELO silpixa00401385..)
 ([10.237.214.33])
 by fmviesa004.fm.intel.com with ESMTP; 19 Sep 2025 00:57:39 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] build: remove deprecated kmods option
Date: Fri, 19 Sep 2025 08:57:33 +0100
Message-ID: <20250919075733.221023-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

The "enable_kmods" meson option was deprecated back in 2023[1], so can
now be removed from DPDK.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

[1] https://doc.dpdk.org/guides-23.11/rel_notes/deprecation.html
---
 doc/guides/rel_notes/deprecation.rst | 7 -------
 meson_options.txt                    | 2 --
 2 files changed, 9 deletions(-)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 0fcdd02d3c..483030cda8 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -17,13 +17,6 @@ Other API and ABI deprecation notices are to be posted below.
 Deprecation Notices
 -------------------
 
-* build: The ``enable_kmods`` option is deprecated and will be removed in a future release.
-  Setting/clearing the option has no impact on the build.
-  Instead, kernel modules will be always built for OS's where out-of-tree kernel modules
-  are required for DPDK operation.
-  Currently, this means that modules will only be built for FreeBSD.
-  No modules are shipped with DPDK for either Linux or Windows.
-
 * kvargs: The function ``rte_kvargs_process`` will get a new parameter
   for returning key match count. It will ease handling of no-match case.
 
diff --git a/meson_options.txt b/meson_options.txt
index e49b2fc089..e28d24054c 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -24,8 +24,6 @@ option('enable_drivers', type: 'string', value: '', description:
        'Comma-separated list of drivers to build. If unspecified, build all drivers.')
 option('enable_driver_sdk', type: 'boolean', value: false, description:
        'Install headers to build drivers.')
-option('enable_kmods', type: 'boolean', value: true, description:
-       '[Deprecated - will be removed in future release] build kernel modules')
 option('enable_libs', type: 'string', value: '', description:
        'Comma-separated list of optional libraries to explicitly enable. [NOTE: mandatory libs are always enabled]')
 option('examples', type: 'string', value: '', description:
-- 
2.48.1

