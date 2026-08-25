Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272F0C61DBE
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 15:16:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FE2440A71;
	Tue, 25 Aug 2026 17:16:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id C12B840679
 for <dev@dpdk.org>; Tue, 25 Aug 2026 17:16:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787670963; x=1819206963;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DDMS1Na3Gu0Apr/Ige/z1OmKFHxRujvoKPoRWTA8pws=;
 b=FSXzt6zDkfZoNBPraix9vcDfylTTafJZ+wRJnNibcFMM/KKwdcVpjpL3
 8rWsV2LZolYZvI+ARCTk+shd1wCXHlKGDZdh9tmjfVS7IYlbtWZ8izRce
 40BwjIJtmHUDPmlP/HSKDRf/4y71ukLjaeSSVWuuvKHmsk4LQhOEfLhEk
 ZxW3FU5Gq9bUKJU6Vq+Mw3czwiq9HXDFmjlbN/6QYAQ5lA6ojuVTJtBen
 jN7V+XNi2fe/WT/xVxJFcQ8kwSZKtjviFdId8DM/HgoPo7ILhIem7OwKI
 u8jrknv0K78oeGy+CNIAWWS/JexrZZqrOqAUecd62JZEOL1M/pNfrzirs A==;
X-CSE-ConnectionGUID: MKeY6BP+T7ukIn9ZSMg6QQ==
X-CSE-MsgGUID: TaKz4KomT4WIiF0iDeEq8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88270727"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="88270727"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 08:15:49 -0700
X-CSE-ConnectionGUID: f6EGga2kSLKv6zX0GVZXrw==
X-CSE-MsgGUID: O7WB7CUTQcKJLmLFGgwVhQ==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 25 Aug 2026 08:15:47 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 8/8] net/ice: consolidate the sources list
Date: Tue, 25 Aug 2026 16:15:23 +0100
Message-ID: <20260825151533.535102-9-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825151533.535102-1-bruce.richardson@intel.com>
References: <20260814153755.940302-1-bruce.richardson@intel.com>
 <20260825151533.535102-1-bruce.richardson@intel.com>
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

The sources list for DCF part of ice driver was separated out for no
functional reason. Merge these into the main sources list for ice
driver.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/meson.build | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
index b12077f7bd..29fb91634e 100644
--- a/drivers/net/intel/ice/meson.build
+++ b/drivers/net/intel/ice/meson.build
@@ -3,6 +3,11 @@
 
 sources = files(
         'ice_acl_filter.c',
+        'ice_dcf.c',
+        'ice_dcf_vf_representor.c',
+        'ice_dcf_ethdev.c',
+        'ice_dcf_parent.c',
+        'ice_dcf_sched.c',
         'ice_diagnose.c',
         'ice_ethdev.c',
         'ice_fdir_filter.c',
@@ -35,14 +40,6 @@ elif arch_subdir == 'arm' and dpdk_conf.get('RTE_ARCH_64')
     sources += files('ice_rxtx_vec_neon.c')
 endif
 
-sources += files(
-        'ice_dcf.c',
-        'ice_dcf_vf_representor.c',
-        'ice_dcf_ethdev.c',
-        'ice_dcf_parent.c',
-        'ice_dcf_sched.c',
-)
-
 require_iova_in_mbuf = false
 
 base_sources = files(
-- 
2.53.0

