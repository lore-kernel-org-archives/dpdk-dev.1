Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5502CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 15:55:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E380340EE5;
	Fri,  7 Nov 2025 16:52:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 2AE7A40A4B
 for <dev@dpdk.org>; Fri,  7 Nov 2025 16:51:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762530720; x=1794066720;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gbtXGopsICbzmhos2q2kecl4Dw6SrGHoCMt3yFs8QwE=;
 b=Co1jNkua5yRBkORCrKs/3Ft7CpjQftajOb0zVz2i3jLmuDMHhOt5WPpZ
 zvu9cdpaBzWrgtt+3k+R6ujR1FQFObRMSHXydWWGL5CfzT6SOmwgNch4d
 wFhZZgm0J0e9HWc7rFlFoQrgd+SJJ5+zwCjWoRvQTELvG95DvDJFhI+LS
 CCPoCkvNfuz3VTzVjqUDX9uN91d2HieElY/GB3oH+csHMGV1ItUA4zUqz
 5l0yv2RTc1yY7YV+R1l4Y1VUk4H/EyGXKB9j8Yka28iv3V7WUgVSULB7r
 jVbGtmGOsUU1CeIbMH/iQYBr5Oh1yjGVj7+Qvc2JNSYgnbDe8vVyStlIf A==;
X-CSE-ConnectionGUID: uOp1qXGDRQG/xjcF2pXXCg==
X-CSE-MsgGUID: dm11fSBxRuK0zt6o/AhnrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="64380169"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="64380169"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 07:51:59 -0800
X-CSE-ConnectionGUID: YR8sdH4IS++FJ2zrfZg4hQ==
X-CSE-MsgGUID: qcniwOjwTCa4grfWUuvHcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="187321833"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 07 Nov 2025 07:51:58 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH v2 33/33] build: enable shadowed variable warnings
Date: Fri,  7 Nov 2025 15:50:29 +0000
Message-ID: <20251107155034.436809-34-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251107155034.436809-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
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

Enable -Wshadow globally for DPDK builds.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 config/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config/meson.build b/config/meson.build
index 927dc18d21..dff4c44fad 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -329,6 +329,7 @@ global_cflags = [
         '-Wnested-externs',
         '-Wold-style-definition',
         '-Wpointer-arith',
+        '-Wshadow',
         '-Wsign-compare',
         '-Wstrict-prototypes',
         '-Wundef',
-- 
2.48.1

