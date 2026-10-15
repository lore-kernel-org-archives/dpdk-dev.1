Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FABCC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 10:10:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E204940430;
	Thu, 15 Oct 2026 12:10:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 912DA40041
 for <dev@dpdk.org>; Thu, 15 Oct 2026 12:10:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792059008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4FpNDRY33BaijJPtWXxDuGzVQ+l9ms9vUedg2t0e0eI=;
 b=Y7DEIu5qYzV1JDm0DwAChdsni50vVEhGo4560MdGTCqTWbTvBerOc4v9Ydq4rZjBDJZ/EF
 wVUZbHs46Myaw1mNR7TLLh9x2r6dZ4S6voeRUJnOXSrxBrMlvoweeL+D29XiwHuAdSMUvS
 kZM/pnBrOfHiyV4LnUbyGIbziAfgmb4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-0AsiOquZPA6N0G7Ynp2ZIw-1; Thu,
 15 Oct 2026 10:10:07 +0000
X-MC-Unique: 0AsiOquZPA6N0G7Ynp2ZIw-1
X-Mimecast-MFC-AGG-ID: 0AsiOquZPA6N0G7Ynp2ZIw_1792059006
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89A7D180059B; Thu, 15 Oct 2026 10:10:06 +0000 (UTC)
Received: from ringo.home (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 79A801800677; Thu, 15 Oct 2026 10:10:05 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH dpdk 1/2] meson: rename static drivers list
Date: Thu, 15 Oct 2026 12:09:23 +0200
Message-ID: <20261015100921.2944274-6-rjarry@redhat.com>
In-Reply-To: <20261015100921.2944274-5-rjarry@redhat.com>
References: <20261015100921.2944274-5-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FqTjN45JcVLvnJHEVud-N9ve6NP3er9Q9hnGEJ65Fx0_1792059006
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

This list contains a list of *static* driver libraries. Reflect that in
its name.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 app/meson.build                   | 2 +-
 buildtools/pkg-config/meson.build | 2 +-
 buildtools/subproject/meson.build | 2 +-
 drivers/meson.build               | 2 +-
 examples/meson.build              | 2 +-
 meson.build                       | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/app/meson.build b/app/meson.build
index 451568847132..f4c3f5a5ccd5 100644
--- a/app/meson.build
+++ b/app/meson.build
@@ -107,7 +107,7 @@ foreach app:apps
     dpdk_apps_enabled += app
     link_libs = []
     if get_option('default_library') == 'static'
-        link_libs = dpdk_static_libraries + dpdk_drivers
+        link_libs = dpdk_static_libraries + dpdk_static_drivers
     endif
 
     exec = executable('dpdk-' + name,
diff --git a/buildtools/pkg-config/meson.build b/buildtools/pkg-config/meson.build
index a0a265ad92c7..14ea3097c461 100644
--- a/buildtools/pkg-config/meson.build
+++ b/buildtools/pkg-config/meson.build
@@ -49,7 +49,7 @@ Note that CFLAGS might contain an -march flag higher than typical baseline.
 This is required for a number of static inline functions in the public headers.''',
         requires: ['libdpdk-libs'],
         libraries_private: ['-Wl,--whole-archive'] +
-            dpdk_drivers + dpdk_static_libraries +
+            dpdk_static_drivers + dpdk_static_libraries +
             ['-Wl,--no-whole-archive'] + platform_flags
 )
 
diff --git a/buildtools/subproject/meson.build b/buildtools/subproject/meson.build
index 8ae081e1698a..57022f07be7c 100644
--- a/buildtools/subproject/meson.build
+++ b/buildtools/subproject/meson.build
@@ -13,7 +13,7 @@ if get_option('default_library') == 'static'
             compile_args: subproject_cflags,
             # static library deps in DPDK build don't include "link_with" parameters,
             # so explicitly link-in both libs and drivers
-            link_whole: dpdk_static_libraries + dpdk_drivers,
+            link_whole: dpdk_static_libraries + dpdk_static_drivers,
             link_args: dpdk_extra_ldflags)
 else
     dpdk_dep = declare_dependency(
diff --git a/drivers/meson.build b/drivers/meson.build
index 102a8262e588..7146f036c4c9 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -404,7 +404,7 @@ foreach subpath:subdirs
                 include_directories: includes,
                 dependencies: static_deps)
 
-        dpdk_drivers += static_lib
+        dpdk_static_drivers += static_lib
 
         set_variable('shared_@0@'.format(lib_name), shared_dep)
         set_variable('static_@0@'.format(lib_name), static_dep)
diff --git a/examples/meson.build b/examples/meson.build
index 544ec5eadd82..4c142a010d48 100644
--- a/examples/meson.build
+++ b/examples/meson.build
@@ -3,7 +3,7 @@
 
 link_whole_libs = []
 if get_option('default_library') == 'static'
-    link_whole_libs = dpdk_static_libraries + dpdk_drivers
+    link_whole_libs = dpdk_static_libraries + dpdk_static_drivers
 endif
 
 # list of all example apps. Keep 1-3 per line, in alphabetical order.
diff --git a/meson.build b/meson.build
index 6b8cfa8b2e90..554ba33e9c66 100644
--- a/meson.build
+++ b/meson.build
@@ -44,7 +44,7 @@ dpdk_headers = []
 dpdk_indirect_headers = []
 dpdk_drivers_headers = []
 dpdk_driver_classes = []
-dpdk_drivers = []
+dpdk_static_drivers = []
 dpdk_extra_ldflags = []
 dpdk_libs_deprecated = []
 dpdk_apps_disabled = []
-- 
2.56.0

