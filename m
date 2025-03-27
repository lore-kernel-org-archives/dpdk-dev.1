Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DB9C36010
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 14:52:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA2DF40E4D;
	Thu, 27 Mar 2025 15:52:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 16A0340E40;
 Thu, 27 Mar 2025 15:52:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743087143; x=1774623143;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BL35EVzdZGEul6wcRjxm2061mFxqgSMI2O/XioYuyr4=;
 b=D799OXaSKycQpAaANPa5tR+RgWC/L2AXryrpUAChpJQKmtaulGku1Inh
 U8ZFKGoi8nX7gLGYFe01GX86dnGPUnzWEknsWv8ibxKtC7iRRVB1h5CBt
 vzCSK1afKJZYpmQqCVy05MWSEwcON0DlFaluYa51P5p6VzAbeFI90jG/N
 yFUXU6Cw6u882rQEA3VmHAwfJ8KTmyo/ZkuEW7alsd722quRi0kI5xIDJ
 MN/CLa3x9DFk2+GIKB2Bp3H6y/4DgySY8X6Hym1uyAZWxAij9GREZxxT8
 EYRQgOqJAC2S4DYs2CsvmnzQmpUNwaqnIQdmNxp0x0jOdg/qidCzCpRq2 Q==;
X-CSE-ConnectionGUID: 2H8Mh8mLSG6hI46+EV405Q==
X-CSE-MsgGUID: HBd7OPZ/QkqLEXVqB+TEoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="48207075"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="48207075"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 07:52:22 -0700
X-CSE-ConnectionGUID: ScHbmnNeTHSQ1CY8Fu6xvg==
X-CSE-MsgGUID: +GVGAQPGRo2b4bBTo6ScYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="162400028"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa001.jf.intel.com with ESMTP; 27 Mar 2025 07:52:20 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Stefan Wegrzyn <stefan.wegrzyn@intel.com>,
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH v3 5/9] net/ixgbe/base: fix lock checker errors
Date: Thu, 27 Mar 2025 14:51:57 +0000
Message-ID: <20250327145202.2220153-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250327145202.2220153-1-bruce.richardson@intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250327145202.2220153-1-bruce.richardson@intel.com>
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

When building on FreeBSD, errors are reported in the base code by the
lock checker (-Wthread-safety). For example:

../drivers/net/intel/ixgbe/base/ixgbe_osdep.c:42:1: error: mutex 'lock->mutex' is still held at the end of function [-Werror,-Wthread-safety-analysis]
   42 | }
      | ^

These errors are due to the checker not recognising the lock wrapper
functions. We can avoid these errors by converting these functions into
macros.

Fixes: 30b19d1b5c43 ("net/ixgbe/base: add definitions for E610")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ixgbe/base/ixgbe_osdep.c | 20 --------------------
 drivers/net/intel/ixgbe/base/ixgbe_osdep.h |  8 ++++----
 2 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/net/intel/ixgbe/base/ixgbe_osdep.c b/drivers/net/intel/ixgbe/base/ixgbe_osdep.c
index d3d7e8e116..778f74e644 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_osdep.c
+++ b/drivers/net/intel/ixgbe/base/ixgbe_osdep.c
@@ -25,23 +25,3 @@ ixgbe_free(struct ixgbe_hw __rte_unused *hw, void *addr)
 {
 	free(addr);
 }
-
-void ixgbe_init_lock(struct ixgbe_lock *lock)
-{
-	pthread_mutex_init(&lock->mutex, NULL);
-}
-
-void ixgbe_destroy_lock(struct ixgbe_lock *lock)
-{
-	pthread_mutex_destroy(&lock->mutex);
-}
-
-void ixgbe_acquire_lock(struct ixgbe_lock *lock)
-{
-	pthread_mutex_lock(&lock->mutex);
-}
-
-void ixgbe_release_lock(struct ixgbe_lock *lock)
-{
-	pthread_mutex_unlock(&lock->mutex);
-}
diff --git a/drivers/net/intel/ixgbe/base/ixgbe_osdep.h b/drivers/net/intel/ixgbe/base/ixgbe_osdep.h
index 398c38bffd..6e35991f49 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_osdep.h
+++ b/drivers/net/intel/ixgbe/base/ixgbe_osdep.h
@@ -167,9 +167,9 @@ void *ixgbe_calloc(struct ixgbe_hw *hw, size_t count, size_t size);
 void *ixgbe_malloc(struct ixgbe_hw *hw, size_t size);
 void ixgbe_free(struct ixgbe_hw *hw, void *addr);
 
-void ixgbe_init_lock(struct ixgbe_lock *lock);
-void ixgbe_destroy_lock(struct ixgbe_lock *lock);
-void ixgbe_acquire_lock(struct ixgbe_lock *lock);
-void ixgbe_release_lock(struct ixgbe_lock *lock);
+#define ixgbe_init_lock(lock) pthread_mutex_init(&(lock)->mutex, NULL)
+#define ixgbe_destroy_lock(lock) pthread_mutex_destroy(&(lock)->mutex)
+#define ixgbe_acquire_lock(lock) pthread_mutex_lock(&(lock)->mutex)
+#define ixgbe_release_lock(lock)	pthread_mutex_unlock(&(lock)->mutex)
 
 #endif /* _IXGBE_OS_H_ */
-- 
2.45.2

