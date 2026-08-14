Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45667C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 15:38:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 406F040A6C;
	Fri, 14 Aug 2026 17:38:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id B23494067C
 for <dev@dpdk.org>; Fri, 14 Aug 2026 17:38:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786721894; x=1818257894;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g6qm1q7EqrZUf8cnJLWxJeo4fg1mZ3DY1f/nILMQsFg=;
 b=Zk9/2Fij7o/BFZIRblP7sI6M38YT9QgmzHL8TsFjqfhp06Y7tA0Zy4nv
 oQrW7qEL4+bn+9d+U7Q2zBOuK7OKv9ebMsL+4W2znN9DZeqsTUo1k4pri
 vAK//TUFX8VGnu4NAmsfphgCMhKLBdrpRSWbx+N8MteHgu3btIXNs9+oq
 f59qAcWWC+ZX+qUkOiSxr9nVGO01Qhx8P4seOrjeMvTZLzZ4dtsXll8TN
 HoChIY3MYXDWmEnNkorQgJwNUcsxxYsYMfcdOBg55MfvxzXgDtE4iG+uU
 DC7ejACFYDZ9VIyjAOXV8oCnXJVxmLqflpCgU6rZhLWxyFbkjDtogjKQu A==;
X-CSE-ConnectionGUID: HIbzJDpVRBiPB4HT116otw==
X-CSE-MsgGUID: SJtRnR7SQAGzbi65zOeBCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="87430619"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="87430619"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 08:38:13 -0700
X-CSE-ConnectionGUID: qdp4UlPNTYyYBOEQAinL3Q==
X-CSE-MsgGUID: nJC3iOP7RVW89ThSuTCW4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="264297116"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa007.jf.intel.com with ESMTP; 14 Aug 2026 08:38:12 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 8/8] net/ice: consolidate the sources list
Date: Fri, 14 Aug 2026 16:37:51 +0100
Message-ID: <20260814153755.940302-9-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814153755.940302-1-bruce.richardson@intel.com>
References: <20260814153755.940302-1-bruce.richardson@intel.com>
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

