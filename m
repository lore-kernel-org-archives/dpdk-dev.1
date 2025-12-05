Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27619D2F7E7
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 12:13:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41F074027D;
	Fri,  5 Dec 2025 13:13:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 2AFDD40156
 for <dev@dpdk.org>; Fri,  5 Dec 2025 13:13:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764936793; x=1796472793;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CINbq5xzd23vcyrPTJEfsoBztA87+IsT6I1N5Z7Vyz0=;
 b=IfphUGOn40M2Gwn6acZlk6CWZ7aJhMpw3aAjrOQScntkwAh+sdQqvjUr
 vUzByHkQoy3B05aqcmBRtNyDb4RzyGkdG2M+UHbT/jsNGT76df1+1n11N
 kBgzEbfxatuAI+RR08fkn98su6Yo45ngo20gx1vy5/pr4VLu1MvTQ9sws
 0eymaVCj2n2ztYUv5XygktAfRzBwxAlgU4kwZhr0kiA7QyxNBZ9cwbecI
 3yN0+bBTviMKxmCDEfb7uw9r3T/3AFLAHheQ529muGNsqdTpLAqfp2iCd
 MTol9+NqSoIMtHnB5TYPKyLlwNvEn6vHDqCKxhhoEoRiOGaU6KvIgjT9q A==;
X-CSE-ConnectionGUID: l6lPL0vaSHOKEANAueOnnQ==
X-CSE-MsgGUID: Q3MnJL1jQLaDcukRCjhZvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="78320914"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; d="scan'208";a="78320914"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 04:13:12 -0800
X-CSE-ConnectionGUID: POD5CL7rSbG7y18IGpdqsQ==
X-CSE-MsgGUID: uG+OeIiXQzC+GMeGX6BfYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; d="scan'208";a="200233770"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa004.fm.intel.com with ESMTP; 05 Dec 2025 04:13:11 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] build: bump meson version to remove warnings
Date: Fri,  5 Dec 2025 12:13:01 +0000
Message-ID: <20251205121301.3443561-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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

The build of DPDK now uses features from version 0.6 of meson, which is
greater than the current minimum of 0.57.2. Although these features are
non-critical, they do cause warnings to be emitted on build. Increase
minimum meson version to 0.61 (== version in Ubuntu 22.04 LTS) to remove
these warnings.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index b01010ffa0..6b8cfa8b2e 100644
--- a/meson.build
+++ b/meson.build
@@ -10,7 +10,7 @@ project('DPDK', 'c',
             'default_library=static',
             'warning_level=2',
         ],
-        meson_version: '>= 0.57.2'
+        meson_version: '>= 0.61'
         # meson_version_windows: '>= 1.5.2'
 )
 
-- 
2.51.0

