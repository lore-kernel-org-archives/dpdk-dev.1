Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500C2D116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:48:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C61240E1C;
	Mon,  1 Dec 2025 12:45:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 5980C4042F
 for <dev@dpdk.org>; Mon,  1 Dec 2025 12:45:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589537; x=1796125537;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/HyM5qHXXr1QpLxUblE/8iMqvY9+5yF8k+LKQzjUrJQ=;
 b=gKMV1QKeBtVhFvNYC7jdAiENYeVmB3i3PCOQmnMHJfFf/cATBehebRt3
 I9cARl6RCGe8TYcnR2Et3y3Vk+0/rlRCY3IANwsee4ly5A4OTHzWfFMzM
 KU+USI8ETt60s/QcPWzJkHkLfNOZaqNeeypMkzMdd2+w09tiCMTYNeVkb
 v7fEomEJI/GVj4yUGKiQySm5TcQlSXmuqqZq3XxMWY63hkZG7zvXuTcXI
 okCD8rB8wDUSCTMiK1CzMKUOF7xyZF3n+BRWTnJlVvyDm4qpgtNpxwyvo
 5bzG5RVQ6hXEeCQXqYfXvmOXS6V6nOSCjEdKmwWGrBSGJv4EDr1vn5aX4 Q==;
X-CSE-ConnectionGUID: B1FY5sefT6OCWgwJwpc/3A==
X-CSE-MsgGUID: iX6CkogrT5qY00S36FVVnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991789"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991789"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:36 -0800
X-CSE-ConnectionGUID: lpascsCQS+u5DQ+aC9AqaA==
X-CSE-MsgGUID: h2Q7Pd3nTtqHUzBlJu++EQ==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:35 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 31/31] build: enable shadowed variable warnings
Date: Mon,  1 Dec 2025 11:44:48 +0000
Message-ID: <20251201114448.1441377-32-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
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

