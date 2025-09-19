Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31D3CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 08:44:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2DA640668;
	Fri, 19 Sep 2025 10:44:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id EE726402B7
 for <dev@dpdk.org>; Fri, 19 Sep 2025 10:44:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758271497; x=1789807497;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EkKN3pGvfF0T248cKb8kOhsC7945MWT22apia+9f2W4=;
 b=DTglXGYy2G2WOWGVMonLl39laizsCYD96m/DQHaSMWwNjTAIE5FTDtaN
 7Zy/9Rfz4BVdl4Y601TAwMQy+yZd1SBq+MVzaK3EPetNJTij1GWtPv0nJ
 M8xogbp/dnrViK5MRs+DkYHeRnONxf7afPkWT62a3dY+oUeTofulqoXsn
 hu1RDhkUMWW8wuKvPcn2Ag82UWVZ7osJ+aK/qpEZgoJB+YigX7Mk0wjca
 pCulEJYruOacYWnfflmhlOUoZpsSI+PPNHOakxvW3KJfwyo92eWzoSqWS
 FYpsIGg7NXzEcDqbHulVQkSZX7jDHUQ4dmna5ia8FC7hVm1KKybhXY1rF w==;
X-CSE-ConnectionGUID: JFEl4vxCR3i3fLZgcRDj8A==
X-CSE-MsgGUID: FskFyjjlQpCp6uFQPE+UcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="59655676"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; d="scan'208";a="59655676"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2025 01:44:56 -0700
X-CSE-ConnectionGUID: 5puoawHRQe6FMtQQ6CujWw==
X-CSE-MsgGUID: 8VnUp4R5QQCYRJnPpdLT5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; d="scan'208";a="180197794"
Received: from silpixa00401385.ir.intel.com (HELO silpixa00401385..)
 ([10.237.214.33])
 by fmviesa005.fm.intel.com with ESMTP; 19 Sep 2025 01:44:55 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2] build: remove deprecated kmods option
Date: Fri, 19 Sep 2025 09:44:03 +0100
Message-ID: <20250919084404.247299-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250919075733.221023-1-bruce.richardson@intel.com>
References: <20250919075733.221023-1-bruce.richardson@intel.com>
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
v2: remove missed references in DTS and in freebsd meson.build
---
 doc/guides/rel_notes/deprecation.rst | 7 -------
 dts/framework/remote_session/dpdk.py | 2 +-
 dts/framework/utils.py               | 2 +-
 kernel/freebsd/meson.build           | 4 ++--
 meson_options.txt                    | 2 --
 5 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 5aaeb1052a..bdcd2775b6 100644
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
 
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index 606d6e22fe..2dc8dab642 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -262,7 +262,7 @@ def _build_dpdk(self) -> None:
         """
         self._session.build_dpdk(
             self._env_vars,
-            MesonArgs(default_library="static", enable_kmods=True, libdir="lib"),
+            MesonArgs(default_library="static", libdir="lib"),
             self.remote_dpdk_tree_path,
             self.remote_dpdk_build_dir,
         )
diff --git a/dts/framework/utils.py b/dts/framework/utils.py
index 0c81ab1b95..9f7201c888 100644
--- a/dts/framework/utils.py
+++ b/dts/framework/utils.py
@@ -111,7 +111,7 @@ def __init__(self, default_library: str | None = None, **dpdk_args: str | bool):
         Example:
             ::
 
-                meson_args = MesonArgs(enable_kmods=True).
+                meson_args = MesonArgs(check_includes=True).
         """
         self._default_library = f"--default-library={default_library}" if default_library else ""
         self._dpdk_args = " ".join(
diff --git a/kernel/freebsd/meson.build b/kernel/freebsd/meson.build
index 1f612711be..862e19e766 100644
--- a/kernel/freebsd/meson.build
+++ b/kernel/freebsd/meson.build
@@ -29,7 +29,7 @@ foreach k:kmods
                 'KMOD_CFLAGS=' + ' '.join(kmod_cflags),
                 'CC=clang'],
             depends: built_kmods, # make each module depend on prev
-            build_by_default: get_option('enable_kmods'),
-            install: get_option('enable_kmods'),
+            build_by_default: true,
+            install: true,
             install_dir: '/boot/modules/')
 endforeach
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

