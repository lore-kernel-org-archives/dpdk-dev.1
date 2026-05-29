Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D110CD4F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 15:36:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B8DA4066A;
	Fri, 29 May 2026 17:36:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 9C927400D6
 for <dev@dpdk.org>; Fri, 29 May 2026 17:36:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780068999; x=1811604999;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=EMe91xjzvkNpunV65eDAO7/ncxWEwKfZHQvM+Zbu+PI=;
 b=HYcjy2gMfr+DLV8nqtdqzps704TJwPta5Cs3MNrqxREYtINi0IKjjwds
 x5Di9zt8PLqIISNfR2YgvjkFXmLkkhJnalL53fT40Tvf+L6abDzUQdI7v
 9T6p7/yVCI43xCU6jQHmkFcq0sJn5DgZhCBoBas/CK4FG5WFhnniknavT
 Pjmn1Q7rbZJCpKwqRai3Aj4ZZB5nfUZVOXYsPWSBaf1MYzGKXL385o7jQ
 DtfPgLAXAt7SFphAtk2Y/VS8VxqHy5+uhzVR/yWx+VtSHifjXajO4e8uK
 wmasIp1YmX/OxM8VVpC/WtVRsYBPXwr/gu4JOU1qYXVL7K7SCUINEqFcT g==;
X-CSE-ConnectionGUID: Mplm+69MR7KQBke5Mjy1oQ==
X-CSE-MsgGUID: ZwnY0ARqTYul/HjLg0RKoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="84549765"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="84549765"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 08:36:38 -0700
X-CSE-ConnectionGUID: dpm8aVirRjOeCi8a6iCmyg==
X-CSE-MsgGUID: 3MNYe86jScOaCjCAfUrDrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="281001197"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 29 May 2026 08:36:38 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v6 01/27] build: add build defines for component name and class
Date: Fri, 29 May 2026 16:36:03 +0100
Message-ID: <98e5691ed76afe4a61d0dd1003f7ea9d9006ae67.1780068633.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780068633.git.anatoly.burakov@intel.com>
 <cover.1780068633.git.anatoly.burakov@intel.com>
References: 
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

From: Bruce Richardson <bruce.richardson@intel.com>

When building each component, pass in -D flags to define for it the
component class and name. This allows any files which may be used
multiple times to identify what component is including them.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/meson.build | 2 ++
 lib/meson.build     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/meson.build b/drivers/meson.build
index 6ae102e943..35f8447e06 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -263,6 +263,8 @@ foreach subpath:subdirs
 
         enabled_drivers += name
         lib_name = '_'.join(['rte', class, name])
+        cflags += '-DRTE_COMPONENT_CLASS=pmd_' + class
+        cflags += '-DRTE_COMPONENT_NAME=' + name
         cflags += '-DRTE_LOG_DEFAULT_LOGTYPE=' + '.'.join([log_prefix, name])
         if annotate_locks and cc.get_id() == 'clang'
             cflags += '-DRTE_ANNOTATE_LOCKS'
diff --git a/lib/meson.build b/lib/meson.build
index 8f5cfd28a5..af5c160cb8 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -237,6 +237,8 @@ foreach l:libraries
         cflags += '-DRTE_USE_FUNCTION_VERSIONING'
     endif
     cflags += '-DRTE_LOG_DEFAULT_LOGTYPE=lib.' + l
+    cflags += '-DRTE_COMPONENT_CLASS=lib'
+    cflags += '-DRTE_COMPONENT_NAME=' + name
     if annotate_locks and cc.get_id() == 'clang'
         cflags += '-DRTE_ANNOTATE_LOCKS'
         cflags += '-Wthread-safety'
-- 
2.47.3

