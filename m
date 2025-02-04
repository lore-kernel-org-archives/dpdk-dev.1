Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1137AC02197
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:18:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4268C42E68;
	Tue,  4 Feb 2025 16:12:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id CF46D42E51
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:12:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681958; x=1770217958;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mx6PV+nznPWHjE9wVam8RnH8ZRoEKZm81h5cNO6uhb4=;
 b=LCznyFtGeJOx+sbc/+WvpfFels2FSOwuBWU9pyk7WuaOyAMxNbc9ymV1
 YtZTt0/bzCsh2PauZwbNCk8f+HAIl8P5RwY8qokSxlT2PoxTRWLAYaRTu
 E4KNg0RIdI413c/HA1nGuMoDxfedFlBVdEIbrNCNoWDt9JUHKHXISeeVk
 Uq4J5DI00Y9XG913ZTyVliU+S4qR3CLqGwhOVG5nGwKvFoDvQ92NlQfgc
 UI+NtHdqU3JReVM9vFtJdiDuveq59urcjsMGmPrTVxd5CC0GCixtYm5rO
 Iyy6qZwTa+eGnasXxFDKQzy3FYeYqWR7NR+Z+ifhHUuVcnWDUc2ztWO0o Q==;
X-CSE-ConnectionGUID: r/yIyoJERtONqfNggjapwA==
X-CSE-MsgGUID: YU2wF8IwRoKUG7iHoLLxsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097214"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097214"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:37 -0800
X-CSE-ConnectionGUID: vH2mz41zQ+mEbQvZBvJnTw==
X-CSE-MsgGUID: AD2wycWHT1eu0DhpuerRaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792803"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:35 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 54/54] net/e1000/base: update readme
Date: Tue,  4 Feb 2025 15:11:00 +0000
Message-ID: <394cd6fa8f7ae6f376b74a3567838f28284fd0e3.1738681726.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Update README with more up-to-date information.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/README | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/e1000/base/README b/drivers/net/intel/e1000/base/README
index b84ee5ad6e..2a0696f3c4 100644
--- a/drivers/net/intel/e1000/base/README
+++ b/drivers/net/intel/e1000/base/README
@@ -2,9 +2,9 @@
  * Copyright(c) 2010-2020 Intel Corporation
  */
 
-This directory contains source code of FreeBSD em & igb drivers of version
-cid-gigabit.2020.06.05.tar.gz released by ND. The sub-directory of base/
-contains the original source package.
+This directory contains source code of FreeBSD em, igb, and igc drivers of
+snapshot generated on 2025-01-24-09.44. The sub-directory of base/ contains the
+original source package.
 
 This driver is valid for the product(s) listed below
 * Intel® Ethernet Controller 82540
@@ -24,6 +24,8 @@ This driver is valid for the product(s) listed below
 * Intel® Ethernet Controller I350 Series
 * Intel® Ethernet Controller I210 Series
 * Intel® Ethernet Controller I211
+* Intel® Ethernet Controller I225
+* Intel® Ethernet Controller I226
 * Intel® Ethernet Controller I354 Series
 * Intel® Ethernet Controller DH89XXCC Series
 
-- 
2.43.5

