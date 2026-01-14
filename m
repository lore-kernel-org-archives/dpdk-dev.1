Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DFBD37E56
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:48:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B565D40EE5;
	Wed, 14 Jan 2026 16:46:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 0183D40E8A
 for <dev@dpdk.org>; Wed, 14 Jan 2026 16:46:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768405563; x=1799941563;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/HyM5qHXXr1QpLxUblE/8iMqvY9+5yF8k+LKQzjUrJQ=;
 b=gAsH8QnHYD4TS2xktaECiKJ5wWAoe/3zq4sdarhInBhdTaeGJASs4sqF
 x6yI2QnP45MVPj7Ojh5NCKJ3cB4BHOpGFw2jdHRC9nwYt0RSximHhr5Wq
 e5E7+BUVkAQ9RSgVLZjM3nhCMPyvYP8jJKFhQPKBPHORTF6jeL7XAbvHj
 DBQ0zgYgSVXY9fTS4mTaNsRvyYIbJrN5WIpFunDJr8Fpbb8OvI5FZ5N3W
 oHDFosC4cOUWDKQnLE+c+oAOnLQBvOooLr54rtzfKxwJv+JEZ/PDPywva
 +hvcBekaSs0CGgN4vy20of7Fyf0m5203+U8ekwyN40vIlKS+gXqZbBWh/ A==;
X-CSE-ConnectionGUID: mTnLjJasTome9aLB7TQAeA==
X-CSE-MsgGUID: Lihycxb9T8Gv1Y2/4vWmmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69871024"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69871024"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 07:46:02 -0800
X-CSE-ConnectionGUID: 57b8TnX4TmKSe3UuNf5Dbw==
X-CSE-MsgGUID: HeYsln6QSgSz8fRARt2HaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203925228"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 14 Jan 2026 07:46:00 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 31/31] build: enable shadowed variable warnings
Date: Wed, 14 Jan 2026 15:44:45 +0000
Message-ID: <20260114154450.2969716-32-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114154450.2969716-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20260114154450.2969716-1-bruce.richardson@intel.com>
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
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
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
2.51.0

