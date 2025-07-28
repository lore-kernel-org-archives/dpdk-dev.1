Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123B6C83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 15:19:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8111A40616;
	Mon, 28 Jul 2025 17:19:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id E819940609
 for <dev@dpdk.org>; Mon, 28 Jul 2025 17:19:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753715961; x=1785251961;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TkymB2nN/nmaTXyEGw3cRGSeSiXc2tgul/N2Rmr/4AM=;
 b=Pq0Dd5DKa15rIWAzeqRqas2McdBR5Gk0xQlPkF3IfUh0Duc9gN2HPeQY
 b4ftN0V1qKiWit49JZESOVYTQsvL00mJ4a4TLqRr1qYD7pZ3tpC1XkQva
 dNGWgVlGGvtR9Yvfv7B6+790RlvgqUeY7CoIgx//f9WkId6y20O046gQa
 7nAyLHXg+NWz8fWLL/vf81PYPzKwqulvy7Ts7Q8RbMxRMz2XbDSa4RilP
 5dpafHnrwxMaLeTUukKSf2hE6kPBLED3DOVH6smlp5EKPBdtuALHAR6eH
 65QG5sF+bmuipa/BLxDNA6jIhuiVaPiSX8Wg3MgcFIC8XSvDZrQmycwlo g==;
X-CSE-ConnectionGUID: +iFFmWORSs2B2qW8mA/5CA==
X-CSE-MsgGUID: wUfkdfphTZmn0P7ue42xJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="67404238"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="67404238"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 08:19:20 -0700
X-CSE-ConnectionGUID: qBhV+yPLSSeO/elJyPuBsw==
X-CSE-MsgGUID: ZrrpZTASSKmZ49Z7+TUy6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="199586036"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by orviesa001.jf.intel.com with ESMTP; 28 Jul 2025 08:19:20 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 2/3] vhost: : remove fallbacks for old Linux versions
Date: Mon, 28 Jul 2025 16:19:07 +0100
Message-ID: <20250728151908.338534-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250728151908.338534-1-bruce.richardson@intel.com>
References: <20250630132904.1704901-1-bruce.richardson@intel.com>
 <20250728151908.338534-1-bruce.richardson@intel.com>
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

All supported linux versions support F_ADD_SEALS (Linux 3.17+) and
MFD_HUGETLB (Linux 4.14+), so no need to have #ifdefs and fallbacks to
support systems which do not support those features.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/vhost/vhost_user.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index b73dec6a22..4bfb13fb98 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -36,10 +36,7 @@
 #ifdef RTE_LIBRTE_VHOST_POSTCOPY
 #include <linux/userfaultfd.h>
 #endif
-#ifdef F_ADD_SEALS /* if file sealing is supported, so is memfd */
 #include <linux/memfd.h>
-#define MEMFD_SUPPORTED
-#endif
 
 #include <eal_export.h>
 #include <rte_common.h>
@@ -1627,11 +1624,7 @@ inflight_mem_alloc(struct virtio_net *dev, const char *name, size_t size, int *f
 	char fname[20] = "/tmp/memfd-XXXXXX";
 
 	*fd = -1;
-#ifdef MEMFD_SUPPORTED
 	mfd = memfd_create(name, MFD_CLOEXEC);
-#else
-	RTE_SET_USED(name);
-#endif
 	if (mfd == -1) {
 		mfd = mkstemp(fname);
 		if (mfd == -1) {
-- 
2.48.1

