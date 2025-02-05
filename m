Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC65C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 18:53:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEFE340647;
	Wed,  5 Feb 2025 19:53:18 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0D9C9402F0
 for <dev@dpdk.org>; Wed,  5 Feb 2025 19:53:16 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 5CB34203F59C; Wed,  5 Feb 2025 10:53:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5CB34203F59C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738781595;
 bh=uPqWQFd29NyI4KDhv4/x7mWDjBV6Zctzgx8LuzcT/Xk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MHI3eSALHp2ef5xBn9m280v8o+kqrmVC/hrlKUVt/GMafA9yS0WGTRtAo9/7Gcdin
 Xs2bNKOs9OfgHLuJ8LT6FbITGePCekKLg76C0jxF5rJZtcWUsTZtG2ClMfasukOTXd
 XJ8KeJsprgxjUy8eYAyB0hKZ8havJKNbuUbI35PU=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: anatoly.burakov@intel.com, bruce.richardson@intel.com, dev@dpdk.org,
 dsinghrawat@marvell.com, palok@marvell.com, stephen@networkplumber.org
Subject: [PATCH v3 2/2] drivers/net: add MSVC compiler flag for unused
 variables
Date: Wed,  5 Feb 2025 10:53:10 -0800
Message-Id: <1738781590-2408-3-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738781590-2408-1-git-send-email-andremue@linux.microsoft.com>
References: <1735238504-15597-3-git-send-email-andremue@linux.microsoft.com>
 <1738781590-2408-1-git-send-email-andremue@linux.microsoft.com>
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

Added MSVC specific compiler flag to ignore warnings about unused
variables, like is being done for other compilers.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 drivers/net/qede/base/meson.build | 57 +++++++++++++++++--------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/net/qede/base/meson.build b/drivers/net/qede/base/meson.build
index 4ad177b478..66251360bf 100644
--- a/drivers/net/qede/base/meson.build
+++ b/drivers/net/qede/base/meson.build
@@ -19,31 +19,38 @@ sources = [
 ]
 
 
-error_cflags = [
-        '-Wno-unused-parameter',
-        '-Wno-sign-compare',
-        '-Wno-missing-prototypes',
-        '-Wno-cast-qual',
-        '-Wno-unused-function',
-        '-Wno-unused-variable',
-        '-Wno-strict-aliasing',
-        '-Wno-missing-prototypes',
-        '-Wno-unused-value',
-        '-Wno-format-nonliteral',
-        '-Wno-shift-negative-value',
-        '-Wno-unused-but-set-variable',
-        '-Wno-missing-declarations',
-        '-Wno-maybe-uninitialized',
-        '-Wno-strict-prototypes',
-        '-Wno-shift-negative-value',
-        '-Wno-implicit-fallthrough',
-        '-Wno-format-extra-args',
-        '-Wno-visibility',
-        '-Wno-empty-body',
-        '-Wno-invalid-source-encoding',
-        '-Wno-sometimes-uninitialized',
-        '-Wno-pointer-bool-conversion',
-]
+if is_ms_compiler
+        error_cflags = [
+                '/wd4101', # unreferenced local variable
+        ]
+else
+        error_cflags = [
+                '-Wno-unused-parameter',
+                '-Wno-sign-compare',
+                '-Wno-missing-prototypes',
+                '-Wno-cast-qual',
+                '-Wno-unused-function',
+                '-Wno-unused-variable',
+                '-Wno-strict-aliasing',
+                '-Wno-missing-prototypes',
+                '-Wno-unused-value',
+                '-Wno-format-nonliteral',
+                '-Wno-shift-negative-value',
+                '-Wno-unused-but-set-variable',
+                '-Wno-missing-declarations',
+                '-Wno-maybe-uninitialized',
+                '-Wno-strict-prototypes',
+                '-Wno-shift-negative-value',
+                '-Wno-implicit-fallthrough',
+                '-Wno-format-extra-args',
+                '-Wno-visibility',
+                '-Wno-empty-body',
+                '-Wno-invalid-source-encoding',
+                '-Wno-sometimes-uninitialized',
+                '-Wno-pointer-bool-conversion',
+        ]
+endif
+
 c_args = cflags
 foreach flag: error_cflags
         if cc.has_argument(flag)
-- 
2.47.2.vfs.0.1

