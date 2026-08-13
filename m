Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5315C5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 11:15:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCF4540E09;
	Thu, 13 Aug 2026 13:15:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 1FCF44026A
 for <dev@dpdk.org>; Thu, 13 Aug 2026 13:15:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786619723; x=1818155723;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0uiSpyh/y3q/s+89qIfUInedmJ0qPkH7/WnZIx5V3A4=;
 b=kbOvKf3P+M/um53FvnR7k8RUIwKL6TNr/NWf7ceZyoxOpwqDL2dZQymR
 3fwKOx1qlk/qDzoSCjxUdMBkWQyP4P5oJMhe8v6JIOaPUF5+POdya2Kp3
 BFcWMvBft5o53mi/nDxcXG2TXMPTmwsNoKWmVUN650NMmsxWu3Tks9M9W
 XtX34NQ7nmyrHGnk7/8I2CLiTUTFWFB3bnelObnp799GFFng87drUQNcq
 BuxDyfcEP8X/z89FKz/Ich0/2EQO0D8R6b/akT5vpgUtce6w2yCk+6mT9
 WbxCe84AARJj6S3rTS9KE7ibam+l34JQV6V+Xw8Qsg+7WLLCp+lm5m5PF g==;
X-CSE-ConnectionGUID: LmVc9DfDRZ2aM7MXN2nOjw==
X-CSE-MsgGUID: C3hSDyCcTk2+d4rGXF/VvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87114218"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="87114218"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 04:15:22 -0700
X-CSE-ConnectionGUID: yRrJU3qPR4iLeq14zYeAhg==
X-CSE-MsgGUID: 1G7q57BATyeb9MgVINwzWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="265898630"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa004.fm.intel.com with ESMTP; 13 Aug 2026 04:15:21 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, mb@smartsharesystems.com,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] net/ice/base: allow array bounds warnings
Date: Thu, 13 Aug 2026 12:15:08 +0100
Message-ID: <20260813111509.1446335-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F659AF@smartserver.smartshare.dk>
References: <98CBD80474FA8B44BF855DF32C47DC35F659AF@smartserver.smartshare.dk>
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

Since there are no zero-length arrays in the base code any more, remove
the -Wno-array-bounds build flag.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/base/meson.build | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/intel/ice/base/meson.build b/drivers/net/intel/ice/base/meson.build
index fd079c41cf..da961f0752 100644
--- a/drivers/net/intel/ice/base/meson.build
+++ b/drivers/net/intel/ice/base/meson.build
@@ -44,11 +44,6 @@ else
     ]
 endif
 
-# Bugzilla ID: 678
-if (toolchain == 'gcc' and cc.version().version_compare('>=11.0.0'))
-    error_cflags += ['-Wno-array-bounds']
-endif
-
 foreach flag: error_cflags
     if cc.has_argument(flag)
         base_cflags += flag
-- 
2.53.0

