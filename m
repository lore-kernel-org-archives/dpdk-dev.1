Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50088CD6E6D
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 16:19:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A169040657;
	Thu,  4 Jun 2026 18:19:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 804C0402CC
 for <dev@dpdk.org>; Thu,  4 Jun 2026 18:19:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780589980; x=1812125980;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=SHVzG5aW4XQoqAZih7+izG7H3f/75Ru73JxWaqFLMkU=;
 b=Ux19gmH966yTbzkPwQQ4BO6q98mqZ0zR3iV8pOuiOvWFKSo949iMhH26
 EA7qJk6JNOuiUv1L1oHoMfegUymkc/WbJ9Fpf3Mr+Hvesm6TTS4ZCZJUu
 KKEh/BRFBMQSv1tj0wFHUEBnxLBAlL5XNoMlth9/w63R/MY1z7gZZnaes
 1VZNXoQwoNpVboZ+QWlggfA3H7yFLC/IvpsZo7V1rCHwnQBs2ooEtOqRw
 cWj2wEoRYdtHIa+F8ujMmOANdbPIqAawmbYVYg/xhcvPEDZbS9SXPutUl
 CrMHBLF1RUe3L5+TWuHcfq4h5VUjDQ+jkdEDn5Si/ll7MRbaDsxyyW6My A==;
X-CSE-ConnectionGUID: 7l9zwu+pRK6aPsRBvJTJpw==
X-CSE-MsgGUID: HxqqegRMRx+5ZP77IQN2hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85045106"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="85045106"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 09:19:39 -0700
X-CSE-ConnectionGUID: 4C23cGPiTwWVCP7ohP6DgA==
X-CSE-MsgGUID: BjYTqWpZSNKi0euHDJNExA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="240403947"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 04 Jun 2026 09:19:39 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v7 01/27] build: add build defines for component name and class
Date: Thu,  4 Jun 2026 17:19:05 +0100
Message-ID: <46976b6c484fb9d4c725903f4f3a36abd37910a2.1780589913.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780589913.git.anatoly.burakov@intel.com>
 <cover.1780589913.git.anatoly.burakov@intel.com>
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
index e8873bf627..4d95604ecd 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -264,6 +264,8 @@ foreach subpath:subdirs
 
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

