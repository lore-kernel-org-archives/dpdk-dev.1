Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFB6C44501
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 10:53:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA1D640270;
	Thu, 16 Jul 2026 12:53:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3E25A400D5
 for <dev@dpdk.org>; Thu, 16 Jul 2026 12:53:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784199224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rUeUgsEIuUg8B/zB1FOPqyAjH5ovVC4hOwfU2z3ACpo=;
 b=MDLt+FUtjISIsEByExyB+ybS2UXUhVtz+PL35sZXu87Kp6AaBq8afH6dMbzrB7JNW/zctJ
 XzzUPA3xN7HUlTI1kZYa1DkxbWcQUMkqPfDnAh1pXW1tprVzll95yVMh8i4w+k9cKvniha
 97VmmPwBSs1WK4vrN3MKoQ18Db+y4mI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-M_2baVwKOyGsq0wYZTQ6YA-1; Thu,
 16 Jul 2026 06:53:43 -0400
X-MC-Unique: M_2baVwKOyGsq0wYZTQ6YA-1
X-Mimecast-MFC-AGG-ID: M_2baVwKOyGsq0wYZTQ6YA_1784199222
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67B661955F3D; Thu, 16 Jul 2026 10:53:42 +0000 (UTC)
Received: from ringo.home (unknown [10.44.50.34])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0262E3003EFD; Thu, 16 Jul 2026 10:53:40 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org, Aaron Conole <aconole@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH dpdk] meson: bump the minimum required version to 0.60.0
Date: Thu, 16 Jul 2026 12:53:31 +0200
Message-ID: <20260716105330.1612578-2-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bS8JZebEqlzlPI5tqrFjoL2o95-fPrW8P4YafGohZZY_1784199222
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

Fix the following warnings:

doc/api/meson.build:24: WARNING: Project targets '>= 0.57.2' but uses
	feature introduced in '0.60.0': install_tag arg in custom_target.
doc/api/meson.build:71: WARNING: Project targets '>= 0.57.2' but uses
	feature introduced in '0.60.0': install_tag arg in custom_target.
doc/api/meson.build:86: WARNING: Project targets '>= 0.57.2' but uses
	feature introduced in '0.60.0': install_tag arg in custom_target.
doc/guides/meson.build:16: WARNING: Project targets '>= 0.57.2' but uses
	feature introduced in '0.60.0': install_tag arg in custom_target.

Run the CI with --fatal-meson-warnings to ensure future warnings get
detected.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---

Notes:
    NB: it would probably be nice to run builds with the latest meson release too.

 .ci/linux-build.sh | 1 +
 meson.build        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
index e0b914a14279..697b5ba9854a 100755
--- a/.ci/linux-build.sh
+++ b/.ci/linux-build.sh
@@ -163,6 +163,7 @@ fi
 
 OPTS="$OPTS -Dbuildtype=$buildtype"
 OPTS="$OPTS -Dwerror=true"
+OPTS="$OPTS --fatal-meson-warnings"
 
 if [ -d build ]; then
     meson configure build $OPTS
diff --git a/meson.build b/meson.build
index b01010ffa076..addfb28194c4 100644
--- a/meson.build
+++ b/meson.build
@@ -10,7 +10,7 @@ project('DPDK', 'c',
             'default_library=static',
             'warning_level=2',
         ],
-        meson_version: '>= 0.57.2'
+        meson_version: '>= 0.60.0'
         # meson_version_windows: '>= 1.5.2'
 )
 
-- 
2.55.0

