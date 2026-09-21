Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2704FC982E1
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 11:48:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79227427E4;
	Mon, 21 Sep 2026 13:48:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3FE03427BD
 for <dev@dpdk.org>; Mon, 21 Sep 2026 13:48:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789991298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9p7MeU0ul6Zt0/Rfv37rxdLy26y68exU81D0q2E6TcU=;
 b=WucOn0zA3Evx6uiIk9/NoQatXj7t9WGysMlljSTnxfQOkxH3byrDquFbjEYX5XFPh3B9eK
 2+hzSvhwR7vRYfHxZeWzlgow1dI0H5MtZx2qO59KGV/Ec5QYIonD+Opd2ogWdPgppzU98f
 338OGJHD6FuDRv5LVjQIU0YYX/YhFNU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-VT48KHLDMpy7weVPPyiIng-1; Mon,
 21 Sep 2026 07:48:15 -0400
X-MC-Unique: VT48KHLDMpy7weVPPyiIng-1
X-Mimecast-MFC-AGG-ID: VT48KHLDMpy7weVPPyiIng_1789991294
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0E0E1800A40; Mon, 21 Sep 2026 11:48:14 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C62651800348; Mon, 21 Sep 2026 11:48:13 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Aaron Conole <aconole@redhat.com>
Subject: [PATCH v3 8/9] ci: make ABI reference generation faster
Date: Mon, 21 Sep 2026 13:47:35 +0200
Message-ID: <20260921114737.2334589-9-david.marchand@redhat.com>
In-Reply-To: <20260921114737.2334589-1-david.marchand@redhat.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260921114737.2334589-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2XdMmV2MfAWhgfSleZszs8XeRl-CguYYIg1_zDu42IM_1789991294
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
Changes since v2:
- removed unneeded -Dtests=

---
 .ci/linux-build.sh            | 10 +++++++++-
 devtools/test-meson-builds.sh |  5 ++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
index e0b914a142..c789111a79 100755
--- a/.ci/linux-build.sh
+++ b/.ci/linux-build.sh
@@ -201,9 +201,17 @@ if [ "$ABI_CHECKS" = "true" ]; then
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
         refsrcdir=$(readlink -f $(pwd)/../dpdk-$REF_GIT_TAG)
         git clone --single-branch -b "$REF_GIT_TAG" $REF_GIT_REPO $refsrcdir
-        meson setup $OPTS -Dexamples= $refsrcdir $refsrcdir/build
+        meson setup $REF_OPTS $refsrcdir $refsrcdir/build
         ninja -C $refsrcdir/build
         DESTDIR=$(pwd)/reference meson install -C $refsrcdir/build
         find reference/usr/local -name '*.a' -delete
diff --git a/devtools/test-meson-builds.sh b/devtools/test-meson-builds.sh
index 11e4be3f88..501034f398 100755
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
+				-Ddisable_apps=* -Dexamples=
 			compile $abirefdir/build
 			install_target $abirefdir/build $abirefdir/$targetdir
 
-- 
2.54.0

