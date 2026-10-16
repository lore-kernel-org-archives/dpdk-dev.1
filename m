Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C97CCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 15:39:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11F3540615;
	Fri, 16 Oct 2026 17:39:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 99162402F2
 for <dev@dpdk.org>; Fri, 16 Oct 2026 17:39:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792165149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tcAa9F9TKGCo/oosoUGuMZpPspZMWwgfTgmt4UvmuH8=;
 b=IyjGo6btDHcvmEfmnFg/MXxijGerkGuGw0NqdetAywZjQzbmMcn+T0cM5LC2+cyFBsW4NY
 OHGs1XTe6ACz5RtFmV4+XbDOGUMmopApUpsgU8IkNiCcQlx6wrun8kYfG9Tc4oisplkkzn
 FD1OrMMrKZAHtDAxZ38B/yl5Lp7Qmps=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-Q8e1-ZRIPnW2JAK_XJgBWw-1; Fri,
 16 Oct 2026 15:39:03 +0000
X-MC-Unique: Q8e1-ZRIPnW2JAK_XJgBWw-1
X-Mimecast-MFC-AGG-ID: Q8e1-ZRIPnW2JAK_XJgBWw_1792165142
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9515180AC78; Fri, 16 Oct 2026 15:38:55 +0000 (UTC)
Received: from ringo.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B15621803A4D; Fri, 16 Oct 2026 15:38:53 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH dpdk v3 2/2] meson: add all drivers to dynamic libraries
Date: Fri, 16 Oct 2026 17:38:11 +0200
Message-ID: <20261016153807.4020321-7-rjarry@redhat.com>
In-Reply-To: <20261016153807.4020321-5-rjarry@redhat.com>
References: <20261015100921.2944274-5-rjarry@redhat.com>
 <20261016153807.4020321-5-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aj_rWLE28x9vJvwPobZBW-ZfA9tIZkx300UTWONbosg_1792165142
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

dpdk_shared_lib_deps only collects library dependencies, so DPDK built
as a meson subproject with shared libraries never links against the
drivers, even those that install public headers (e.g. bus/pci,
bus/vdev). Add all drivers to dpdk_shared_lib_deps as well, mirroring
what is already done for libraries in lib/meson.build.

Listing every driver (not only the ones with public headers) lets the
pkg-config files be simplified. The two .pc files existed only to get
the link order right: drivers must come before the libraries they
depend on, but pkg-config emits Libs.private after Libs, so the
libraries had to live in a separate file pulled in through Requires.
With the drivers and libraries both present in a single Libs.private
block, a second file is no longer needed and libdpdk-libs.pc can be
folded back into libdpdk.pc. The --as-needed flag keeps shared builds
from overlinking.

Listing the drivers in the shared Libs field is safe with respect to
the constructor functions that drivers use to register themselves,
which must run exactly once. Thanks to --as-needed, a driver whose
symbols are not referenced by the application is dropped from the
binary NEEDED list, so its constructor does not run at startup and EAL
loads the driver once at runtime with dlopen() as before. If the
application does reference a driver symbol, the driver stays in NEEDED
and its constructor runs at startup, but EAL's later dlopen() of the
same file is deduplicated by the dynamic loader (same soname and inode,
since the plugin directory holds symlinks to the installed libraries)
and does not run the constructor again. The constructor runs exactly
once in both cases.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---

Notes:
    v3:
    
    - Added all shared driver libs to pkg-config, regardless if they have
      a public API. -Wl,--as-needed prevents overlinking.
    - Simplified to a single .pc file now that all libraries are listed in
      the correct order.
    
    v2: added driver shared libs to the list for pkg-config

 buildtools/pkg-config/meson.build | 63 ++++++++++++++++---------------
 drivers/meson.build               |  2 +
 meson.build                       |  1 +
 3 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/buildtools/pkg-config/meson.build b/buildtools/pkg-config/meson.build
index 14ea3097c461..e1198762d354 100644
--- a/buildtools/pkg-config/meson.build
+++ b/buildtools/pkg-config/meson.build
@@ -7,35 +7,36 @@ if is_freebsd
     pkg_extra_cflags += ['-D__BSD_VISIBLE']
 endif
 
-# When calling pkg-config --static --libs, pkg-config will always output the
-# regular libs first, and then the extra libs from Libs.private field,
-# since the assumption is that those are additional dependencies for building
-# statically that the .a files depend upon. The output order of .pc fields is:
+# The output order of the .pc file fields used by pkg-config is:
 #   Libs   Libs.private   Requires   Requires.private
-# The fields Requires* are for package names.
-# The flags of the DPDK libraries must be defined in Libs* fields.
-# However, the DPDK drivers are linked only in static builds (Libs.private),
-# and those need to come *before* the regular libraries (Libs field).
-# This requirement is satisfied by moving the regular libs in a separate file
-# included in the field Requires (after Libs.private).
-# Another requirement is to allow linking dependencies as shared libraries,
-# while linking static DPDK libraries and drivers. It is satisfied by
-# listing the static files in Libs.private with the explicit syntax -l:libfoo.a.
-# As a consequence, the regular DPDK libraries are already listed as static
-# in the field Libs.private. The second occurences of DPDK libraries,
-# included from Requires and used for shared library linkage case,
-# are skipped in the case of static linkage thanks to the flag --as-needed.
-
-
-pkg.generate(name: 'dpdk-libs',
-        filebase: 'libdpdk-libs',
-        description: '''Internal-only DPDK pkgconfig file. Not for direct use.
-Use libdpdk.pc instead of this file to query DPDK compile/link arguments''',
-        version: meson.project_version(),
-        subdirs: [get_option('include_subdir_arch'), '.'],
-        extra_cflags: pkg_extra_cflags,
-        libraries: ['-Wl,--as-needed'] + dpdk_libraries,
-        libraries_private: dpdk_extra_ldflags)
+# The Requires* fields are for package names, while the flags of the DPDK
+# libraries and drivers must be defined in the Libs* fields.
+#
+# For shared linking, only the Libs field is used, and it lists the DPDK
+# libraries and drivers, all with the --as-needed flag to avoid overlinking
+# against components that the application does not actually use.
+#
+# Listing the drivers here is safe even though they are normally loaded at
+# runtime with dlopen(). DPDK drivers register themselves through constructor
+# functions that must run exactly once. Thanks to --as-needed, a driver whose
+# symbols are not referenced by the application is dropped from the binary's
+# NEEDED list entirely, so its constructor does not run at startup and EAL
+# loads it once at runtime as usual. If the application does reference a driver
+# symbol, the driver stays in NEEDED and its constructor runs at startup; EAL's
+# later dlopen() of the same file is deduplicated by the dynamic loader (same
+# soname and inode, the plugin directory holds symlinks to the installed
+# libraries) and does not run the constructor a second time. Either way, the
+# constructor runs exactly once.
+#
+# For static linking, pkg-config appends the Libs.private field after Libs.
+# The DPDK drivers must be linked before the libraries they depend upon, so
+# both the drivers and the libraries are listed in Libs.private, wrapped in
+# --whole-archive so that drivers register themselves at load time. The
+# static files are listed with the explicit -l:libfoo.a syntax so that DPDK
+# itself is linked statically while its external dependencies may still be
+# linked as shared libraries. The DPDK libraries from the Libs field appear a
+# second time before Libs.private, but those occurrences are skipped thanks to
+# the --as-needed flag.
 
 platform_flags = []
 if not is_windows
@@ -47,10 +48,12 @@ pkg.generate(name: 'DPDK', # main DPDK pkgconfig file
         description: '''The Data Plane Development Kit (DPDK).
 Note that CFLAGS might contain an -march flag higher than typical baseline.
 This is required for a number of static inline functions in the public headers.''',
-        requires: ['libdpdk-libs'],
+        subdirs: [get_option('include_subdir_arch'), '.'],
+        extra_cflags: pkg_extra_cflags,
+        libraries: ['-Wl,--as-needed'] + dpdk_libraries + dpdk_shared_drivers,
         libraries_private: ['-Wl,--whole-archive'] +
             dpdk_static_drivers + dpdk_static_libraries +
-            ['-Wl,--no-whole-archive'] + platform_flags
+            ['-Wl,--no-whole-archive'] + dpdk_extra_ldflags + platform_flags
 )
 
 # For static linking with dependencies as shared libraries,
diff --git a/drivers/meson.build b/drivers/meson.build
index 7146f036c4c9..86458166a226 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -405,6 +405,8 @@ foreach subpath:subdirs
                 dependencies: static_deps)
 
         dpdk_static_drivers += static_lib
+        dpdk_shared_drivers += shared_lib
+        dpdk_shared_lib_deps += shared_dep
 
         set_variable('shared_@0@'.format(lib_name), shared_dep)
         set_variable('static_@0@'.format(lib_name), static_dep)
diff --git a/meson.build b/meson.build
index 554ba33e9c66..ce4a4217549d 100644
--- a/meson.build
+++ b/meson.build
@@ -45,6 +45,7 @@ dpdk_indirect_headers = []
 dpdk_drivers_headers = []
 dpdk_driver_classes = []
 dpdk_static_drivers = []
+dpdk_shared_drivers = []
 dpdk_extra_ldflags = []
 dpdk_libs_deprecated = []
 dpdk_apps_disabled = []
-- 
2.56.0

