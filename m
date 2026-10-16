Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED9DCC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:00:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37F5D40430;
	Fri, 16 Oct 2026 13:00:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 4A50D400D5;
 Fri, 16 Oct 2026 13:00:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792148405; x=1823684405;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ePN3XWECpQZQx1KogbrJ0CWM+2QfUrmV0Pm8D8f759k=;
 b=BiD1ZbytgpM3F+rvr1zhIgJP+u+SDCEfejCv/RoTuGnz0qblZTQQmg4j
 6u5SWNSpo+YlsZrF5LRds/TJaDFJqzPpf3LFGi/qC/vl4XguV+YPCdOlk
 RYrTN4L8SEHx453v0ixf/XzWQMg9GVcf1TFJLXtqAts0H3wUENtcO+jXA
 viIJ/kP/usYTd113qTwYiAd5GaXf3CZ4Xq5L2Fv1WpzRNfUrOYcy5CqUL
 Uo6xzrBBLzMoYYXupae2VclCzxDRfmp7/XO1LieLaz2Okkody56Sq2ZA8
 J84FOL2yIcH3lTdg+r0f9XQO96EAKau6KsMQ2B2twj7VR83vI2Q1BMzsr g==;
X-CSE-ConnectionGUID: JQRL5H97Rey4gNkO383AeQ==
X-CSE-MsgGUID: XY3XgZhGSaKfO0eN79VAfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="944130"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="944130"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 04:00:04 -0700
X-CSE-ConnectionGUID: O5gCtIN1SRmlg0S0ZMcThw==
X-CSE-MsgGUID: ebyMsGLlRUuhtoMxkPbqlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="3759363"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa011.fm.intel.com with ESMTP; 16 Oct 2026 04:00:03 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [RFC PATCH 01/12] build: fix name of base library object
Date: Fri, 16 Oct 2026 11:59:39 +0100
Message-ID: <20261016105950.273068-2-bruce.richardson@intel.com>
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

The generation of the base code objects, in the case where the base code
needs separate C files, used the lib_name value, but that was not
actually assigned till later in the loop, meaning the name used was for
the previous driver built. Fix this by moving the 3-line block up in the
loop.

Fixes: 8fa3af6c05f8 ("build: add generic support for base code in drivers")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/meson.build | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/meson.build b/drivers/meson.build
index 102a8262e5..02adf51173 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -249,6 +249,10 @@ foreach subpath:subdirs
             continue
         endif
 
+        enabled_drivers += name
+        lib_name = '_'.join(['rte', class, name])
+        dpdk_conf.set(lib_name.to_upper(), 1)
+
         # not all drivers base code is lock annotation safe, so do base code builds before
         # adding on the lock annotation flags. NOTE: If no custom cflags, the lock annotation
         # checks will be done though.
@@ -263,10 +267,6 @@ foreach subpath:subdirs
             sources += base_sources
         endif
 
-        enabled_drivers += name
-        lib_name = '_'.join(['rte', class, name])
-        dpdk_conf.set(lib_name.to_upper(), 1)
-
         if developer_mode and is_windows and use_function_versioning
             message('@0@: Function versioning is not supported by Windows.'.format(name))
         endif
-- 
2.53.0

