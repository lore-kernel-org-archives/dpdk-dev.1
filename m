Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE18C44514
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:31:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8492440E2C;
	Fri, 17 Jul 2026 11:30:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B8B8840E25
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:30:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784280655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ApFBhRsox7DANTHFW6nVI8bydVLjzp0gOfgLLRf+tow=;
 b=g1isHh+KYNGp38kLKjSFSTAUi8muPAz9WTZH3pvP2J9vZ7xltdC6cZYgV9c3OyJ6VPgu2Q
 0phOdZpZblvUHMM0lClOXX9DlX+6Cg7SZbdWlGgu0oFf1pPjCDcu4kG78nZA0s26Z59Hdb
 HQy4n+9SSDEmuedLMi0bCjkJhWMgaeo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-F402iixXPpaqGlCxiQwVeg-1; Fri,
 17 Jul 2026 05:30:51 -0400
X-MC-Unique: F402iixXPpaqGlCxiQwVeg-1
X-Mimecast-MFC-AGG-ID: F402iixXPpaqGlCxiQwVeg_1784280650
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B63119540CA; Fri, 17 Jul 2026 09:30:50 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 50A2C30040BF; Fri, 17 Jul 2026 09:30:49 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Aaron Conole <aconole@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 09/10] ci: make ABI reference generation faster
Date: Fri, 17 Jul 2026 11:30:04 +0200
Message-ID: <20260717093006.229370-10-david.marchand@redhat.com>
In-Reply-To: <20260717093006.229370-1-david.marchand@redhat.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -we8OdHIvBbCFCg64mRkuhlCD15MnJ75DwXWm_YoQ1E_1784280650
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

Regenerating ABI is not something we do often, but when working on ABI
topics, a lot of time may be wasted on waiting for the reference being
generated.

We only care about shared libraries, avoid building final applications
or examples.
And we don't need to double check headers in the ABI reference.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 .ci/linux-build.sh            | 11 ++++++++++-
 devtools/test-meson-builds.sh |  5 ++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
index e0b914a142..a5e602ed83 100755
--- a/.ci/linux-build.sh
+++ b/.ci/linux-build.sh
@@ -201,9 +201,18 @@ if [ "$ABI_CHECKS" = "true" ]; then
     fi
 
     if [ ! -d reference ]; then
+        REF_OPTS="$OPTS"
+        # We only care about the drivers and libs, disable developer checks and
+        # don't try to link apps.
+        REF_OPTS="$REF_OPTS -Dcheck_includes=false"
+        REF_OPTS="$REF_OPTS -Ddeveloper_mode=disabled"
+        REF_OPTS="$REF_OPTS -Ddisable_apps=*"
+        REF_OPTS="$REF_OPTS -Denable_docs=false"
+        REF_OPTS="$REF_OPTS -Dexamples="
+        REF_OPTS="$REF_OPTS -Dtests=false"
         refsrcdir=$(readlink -f $(pwd)/../dpdk-$REF_GIT_TAG)
         git clone --single-branch -b "$REF_GIT_TAG" $REF_GIT_REPO $refsrcdir
-        meson setup $OPTS -Dexamples= $refsrcdir $refsrcdir/build
+        meson setup $REF_OPTS $refsrcdir $refsrcdir/build
         ninja -C $refsrcdir/build
         DESTDIR=$(pwd)/reference meson install -C $refsrcdir/build
         find reference/usr/local -name '*.a' -delete
diff --git a/devtools/test-meson-builds.sh b/devtools/test-meson-builds.sh
index 11e4be3f88..8ca7091b47 100755
--- a/devtools/test-meson-builds.sh
+++ b/devtools/test-meson-builds.sh
@@ -206,8 +206,11 @@ build () # <directory> <target cc | cross file> <ABI check> [meson options]
 			fi
 
 			rm -rf $abirefdir/build
+			# We only care about the drivers and libs, disable
+			# developer checks and don't try to link apps.
 			config $abirefdir/src $abirefdir/build ABI $cross \
-				-Dexamples= $*
+				$* -Dcheck_includes=false -Ddeveloper_mode=disabled \
+				-Ddisable_apps=* -Dexamples= -Dtests=false
 			compile $abirefdir/build
 			install_target $abirefdir/build $abirefdir/$targetdir
 
-- 
2.54.0

