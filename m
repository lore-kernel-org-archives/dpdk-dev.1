Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A1EC71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 15:31:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB388402BC;
	Mon, 16 Jun 2025 17:31:15 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id CFC144021E
 for <dev@dpdk.org>; Mon, 16 Jun 2025 17:31:14 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 00AAC21176F8; Mon, 16 Jun 2025 08:31:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 00AAC21176F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1750087874;
 bh=t58p0IoDb+vipSKYiRDcsD1Hy1S4az+lYlaG85mr+BY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NOBnr1vKlCiBzvB9gvBHdAL8SOX7Y70xOUeEykz+MfzIJ6KFluW9B9QKZI0i/9R4n
 Jr8XrEJOmmJT+QaSTy3dHNaLTBpdY5hSw8oVFfPk7Cd13NZpeVHTIkMOcUj2GMPLIp
 T/ZP0ZnwoxzVh9sQFswvqvT3g1TDZAh6gdksBpCI=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: bruce.richardson@intel.com,
	dev@dpdk.org
Subject: [PATCH v2] buildtools: allow a different minimum meson version for
 Windows
Date: Mon, 16 Jun 2025 08:31:11 -0700
Message-Id: <1750087871-27179-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749831278-8286-1-git-send-email-andremue@linux.microsoft.com>
References: <1749831278-8286-1-git-send-email-andremue@linux.microsoft.com>
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

There is a minimum meson version specified in the DPDK meson project
section, which has been documented. This string is parsed by
buildtools\get-min-meson-version.py and this information is used by
lab automation to install the corresponding meson package on the
build machine.

Turns out that the meson version specified on the DPDK project
(0.57.x) is buggy on Windows: it has issues related to path
manipulation, and these issues are causing failures. Therefore,
a newer meson is required on Windows.

To avoid bringing the minimum requirements up for all operating
systems before a more appropriate release, this patch implements
a mechanism allowing a different version to be specified for Windows.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 buildtools/get-min-meson-version.py | 8 ++++++--
 meson.build                         | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/buildtools/get-min-meson-version.py b/buildtools/get-min-meson-version.py
index f0de8fdf2b..3769f3da73 100755
--- a/buildtools/get-min-meson-version.py
+++ b/buildtools/get-min-meson-version.py
@@ -11,12 +11,15 @@
 basedir = dirname(buildtools_path)
 
 with open(join(basedir, "meson.build")) as f:
+    keyword = "meson_version_windows" if os.name == "nt" else "meson_version"
+    pattern = fr"{keyword}:\s*'>=\s*([0-9\.]+)'"
+
     for ln in f.readlines():
-        if "meson_version" not in ln:
+        if keyword not in ln:
             continue
 
         ln = ln.strip()
-        ver_match = re.search(r"meson_version:\s*'>=\s*([0-9\.]+)'", ln)
+        ver_match = re.search(pattern, ln)
         if not ver_match:
             print(
                 f"Meson version specifier not in recognised format: '{ln}'",
@@ -24,3 +27,4 @@
             )
             sys.exit(1)
         print(ver_match.group(1), end="")
+        break
diff --git a/meson.build b/meson.build
index 5ff68cb3af..2423884df7 100644
--- a/meson.build
+++ b/meson.build
@@ -11,6 +11,7 @@ project('DPDK', 'c',
             'warning_level=2',
         ],
         meson_version: '>= 0.57.2'
+        # meson_version_windows: '>= 1.5.2'
 )
 
 fs = import('fs')
-- 
2.49.0.vfs.0.3

