Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164D2CCD193
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 15:56:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB26840280;
	Mon, 20 Oct 2025 17:56:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 3A6CC400D6
 for <dev@dpdk.org>; Mon, 20 Oct 2025 17:56:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760975777; x=1792511777;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=G6cfqs0MRPc81luImOF6qhzCx8cM27XlU2AXi2Uwj+4=;
 b=T26nUh95oUCFtI8OAOCXdTMSmKjbhHQUxLenpGMddNzMVII0/36TAmTJ
 ee6AM/ynWXsTWZbkrowtHMdcmX7wIuv2jN8o1oDht0/ArxBm4icsv3W0X
 lDItrkJ3K1SN18goV3qdejOlOkejaeKHK7OAlAbELhC0r+awS3UwwEsNs
 yV6YCJKML5P/T4vyLnHA2rxJ+DrjATWCDhOwpJz7pKgZBu0yZ7XzOZ6ak
 RkfRHgAHJb4JjdTUAtaFnqw0wrEcYU44Q+t+CeFwX2kfPZ2iWKnwhNC7L
 uopbHRdEowPLyCryUo34kQPrVbuuePt/PCZttRxnJM95a8ACP2U76X6n9 A==;
X-CSE-ConnectionGUID: q3kuiYNTSbKOG1VXz2rmSA==
X-CSE-MsgGUID: 2hZm+3rNTU2eZV3QqqcH3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65707174"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="65707174"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 08:55:45 -0700
X-CSE-ConnectionGUID: o34+yGA5RiutLYey6GcpjQ==
X-CSE-MsgGUID: tdwrsODFStGH4HdibwPfWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="188455938"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 20 Oct 2025 08:55:43 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] devtools/test-meson-builds: reduce output size
Date: Mon, 20 Oct 2025 16:55:36 +0100
Message-ID: <20251020155536.1965938-1-bruce.richardson@intel.com>
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

The various builds done by the "test-meson-builds.sh" script can take a
large amount of space on disk. Some simple changes allow us to reduce
the space used significantly. Specifically:
* use the default "release" build, which does not include debug
  information, for builds where we won't check ABI.
* use shared linkage rather than static for the 32-bit builds.

After making these changes a set of builds produced by test-meson-builds
shrank from ~17G to ~7G on my system.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 devtools/test-meson-builds.sh | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/devtools/test-meson-builds.sh b/devtools/test-meson-builds.sh
index 4fff1f7177..f1053bd7be 100755
--- a/devtools/test-meson-builds.sh
+++ b/devtools/test-meson-builds.sh
@@ -103,13 +103,19 @@ load_env () # <target compiler>
 	command -v $targetcc >/dev/null 2>&1 || return 1
 }
 
-config () # <dir> <builddir> <meson options>
+config () # <dir> <builddir> <ABI check> <meson options>
 {
 	dir=$1
 	shift
 	builddir=$1
 	shift
+	abicheck=$1
+	shift
+
 	if [ -f "$builddir/build.ninja" ] ; then
+		if [ "$abicheck" != ABI ] ; then
+			return
+		fi
 		# for existing environments, switch to debugoptimized if unset
 		# so that ABI checks can run
 		if ! $MESON configure $builddir |
@@ -130,7 +136,9 @@ config () # <dir> <builddir> <meson options>
 	else
 		options="$options -Dexamples=l3fwd" # save disk space
 	fi
-	options="$options --buildtype=debugoptimized"
+	if [ "$abicheck" = ABI ] ; then
+		options="$options --buildtype=debugoptimized"
+	fi
 	for option in $DPDK_MESON_OPTIONS ; do
 		options="$options -D$option"
 	done
@@ -181,7 +189,7 @@ build () # <directory> <target cc | cross file> <ABI check> [meson options]
 		cross=
 	fi
 	load_env $targetcc || return 0
-	config $srcdir $builds_dir/$targetdir $cross --werror $*
+	config $srcdir $builds_dir/$targetdir $abicheck $cross --werror $*
 	compile $builds_dir/$targetdir
 	if [ -n "$DPDK_ABI_REF_VERSION" -a "$abicheck" = ABI ] ; then
 		abirefdir=${DPDK_ABI_REF_DIR:-reference}/$DPDK_ABI_REF_VERSION
@@ -255,14 +263,11 @@ build build-x86-generic cc skipABI -Dcheck_includes=true \
 if check_cc_flags '-m32' ; then
 	target_override='i386-pc-linux-gnu'
 	if [ -d '/usr/lib/i386-linux-gnu' ] ; then
-		# 32-bit pkgconfig on Debian/Ubuntu, use cross file
-		build build-32b $srcdir/config/x86/cross-32bit-debian.ini ABI
+		build build-32b $srcdir/config/x86/cross-32bit-debian.ini ABI $use_shared
 	elif [ -d '/usr/lib32' ] ; then
-		# 32-bit pkgconfig on Arch
-		build build-32b $srcdir/config/x86/cross-32bit-arch.ini ABI
+		build build-32b $srcdir/config/x86/cross-32bit-arch.ini ABI $use_shared
 	else
-		# 32-bit pkgconfig on RHEL/Fedora (lib vs lib64)
-		build build-32b $srcdir/config/x86/cross-32bit-fedora.ini ABI
+		build build-32b $srcdir/config/x86/cross-32bit-fedora.ini ABI $use_shared
 	fi
 	target_override=
 fi
-- 
2.48.1

