Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095B0CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:00:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0618A40615;
	Fri, 16 Oct 2026 13:00:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id C1690402EE
 for <dev@dpdk.org>; Fri, 16 Oct 2026 13:00:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792148406; x=1823684406;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RJM0NWF0TtUA9XlIOtbe4ulyZu34yE4Tl4GrTWkqTG0=;
 b=WJPJj7ZJyaxaWr7h7M+ZKrcisjF++BRkYJronh8x6FurP1tMbbEqbsQl
 GAPpJpkE6iJ+ur3YJ/+M3Q6uzbHHJO5ueOB/T5aVjgIjl56NMFeIoicRX
 5mqh9ZlBeoeTwL4LnQ0JJG6znkJFqNmkBx149xnnx4M5HlAaVuJKGkti7
 6nCDOxaVsxzriuSiQwxoXu6HWRYKfp8XNIS0oHo1QlKBbsoZ+WJO/T9rV
 OggbHLjLH1/Dq8wxTPhJ6smbaanTTbmUuo4kTg9doAZq6DlrGBiDszBND
 K0A4SUVKcguF6S9bBEc6IgLK9wVCmU9gNiwbDVLUKR/+RJRaaQDa02CS8 Q==;
X-CSE-ConnectionGUID: F2K8jhYPSe+YEmPertp3qA==
X-CSE-MsgGUID: K6U4cn56Qay1GNpgbQxyyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="944132"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="944132"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 04:00:05 -0700
X-CSE-ConnectionGUID: eN6WWBZNSG2jpu1grTxe1w==
X-CSE-MsgGUID: 0KWpdxymSYKH34+yfRfCKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="3759375"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa011.fm.intel.com with ESMTP; 16 Oct 2026 04:00:05 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 03/12] build: prevent overlap of enable and disable lists
Date: Fri, 16 Oct 2026 11:59:41 +0100
Message-ID: <20261016105950.273068-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016105950.273068-1-bruce.richardson@intel.com>
References: <20261016105950.273068-1-bruce.richardson@intel.com>
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

For enable_libs/disable_libs option, and the driver and app equivalents,
detect if a component is in both enable and disable lists and error out
if so.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/meson.build     | 5 +++++
 drivers/meson.build | 5 +++++
 lib/meson.build     | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/app/meson.build b/app/meson.build
index 4515688471..7472d925b2 100644
--- a/app/meson.build
+++ b/app/meson.build
@@ -6,6 +6,11 @@ disable_apps = run_command(list_dir_globs, disable_apps, check: true).stdout().s
 
 enable_apps = ',' + get_option('enable_apps')
 enable_apps = run_command(list_dir_globs, enable_apps, check: true).stdout().split()
+foreach a:enable_apps
+    if disable_apps.contains(a)
+        error('Application "@0@" is in both "enable_apps" and "disable_apps".'.format(a))
+    endif
+endforeach
 require_apps = true
 if enable_apps.length() == 0
     require_apps = false
diff --git a/drivers/meson.build b/drivers/meson.build
index b761e19be5..440c3959cf 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -71,6 +71,11 @@ endforeach
 
 disable_drivers = run_command(list_dir_globs, disable_drivers, check: true).stdout().split()
 enable_drivers = run_command(list_dir_globs, enable_drivers, check: true).stdout().split()
+foreach d:enable_drivers
+    if disable_drivers.contains(d)
+        error('Driver "@0@" is in both "enable_drivers" and "disable_drivers".'.format(d))
+    endif
+endforeach
 require_drivers = true
 if enable_drivers.length() == 0
     require_drivers = false
diff --git a/lib/meson.build b/lib/meson.build
index af5c160cb8..0c5da21522 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -101,6 +101,11 @@ endforeach
 disable_libs = run_command(list_dir_globs, get_option('disable_libs'), check: true).stdout().split()
 
 enable_libs = run_command(list_dir_globs, get_option('enable_libs'), check: true).stdout().split()
+foreach l:enable_libs
+    if disable_libs.contains(l)
+        error('Library "@0@" is in both "enable_libs" and "disable_libs".'.format(l))
+    endif
+endforeach
 require_libs = true
 if enable_libs.length() == 0
     require_libs = false
-- 
2.53.0

