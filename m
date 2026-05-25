Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98562CD5BD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 14:07:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20861402F2;
	Mon, 25 May 2026 16:06:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 3215D40276
 for <dev@dpdk.org>; Mon, 25 May 2026 16:06:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779718015; x=1811254015;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=EMe91xjzvkNpunV65eDAO7/ncxWEwKfZHQvM+Zbu+PI=;
 b=M9aTFoQiip0HTryUuPHFgWi6BSMEy4qKezDB9M7sb54qUniEi/xB3HO2
 q0MJXyhRce0pCVUUWuqyIJ7ty1IRPS1EG0noTihV2L2swg1mYqjY/wyCY
 Ke/TjHLgTuew41EW2KBJkJw4tl37LpXjaTwlMvm3akkPfhhQCxC5nzVED
 eyY+SI7sawq6STtnNklQ/zgfA1QeMxXHuzu0fLmOAR6ByOonLg8cBoqxa
 hTAZzVU8FuMEY6zKCZOe4+NMuxE+VX2E4lbCNoM3l5/2JQfVAJ/80JSyg
 PTY75Hk38vLRQALveYCb48ZHZ6Y+deJ8/Z8SyjOeIe6gb4D1SieV9+zg/ A==;
X-CSE-ConnectionGUID: cQM7ahFfQKK/WCdu3XeuPA==
X-CSE-MsgGUID: /guMws6dQsaniQgOD8NhVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="84392472"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="84392472"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 07:06:54 -0700
X-CSE-ConnectionGUID: QhJf4u53TPWM11ae/VGImw==
X-CSE-MsgGUID: 93uCwwEdR6uKGDM3NUxUjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="246692289"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 25 May 2026 07:06:53 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v5 01/27] build: add build defines for component name and class
Date: Mon, 25 May 2026 15:06:20 +0100
Message-ID: <a0fb6a1e2c47d0d42b006a236bb7e6b3ae734a2d.1779717943.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779717943.git.anatoly.burakov@intel.com>
 <cover.1779717943.git.anatoly.burakov@intel.com>
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

