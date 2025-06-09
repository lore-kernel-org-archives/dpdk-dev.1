Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32953C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:17:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D193240E0C;
	Mon,  9 Jun 2025 12:16:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id D9CFB40DCE
 for <dev@dpdk.org>; Mon,  9 Jun 2025 12:16:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749464215; x=1781000215;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=nco8Ye4jAfpFGALtJwNugzQNQfJA/cnYl9ipa9IgONo=;
 b=STarVi9oZpE9nPVLP91AfR5gCGo1KddEt0wl+7qC7ss79AFMKp5EPz2z
 fb0TAUOGbhV4QnbPCM1kj4WNbwhJnYkCdjycTQUamg/sKhZRdr7L5U0hm
 PGVNt5A3wbkuwihkMCM5/+CWZLhyO243fdNDmvLbxd7TJttxdgrfbuE4L
 Hw0A7/VVhhV3JGdz8VOlkTRD8Iwf82tU+No63Ij/utbEclc6RpMzGhS77
 uqd+bUWP4LhPAeG5WVV3VVtCglPWYZZaF2HAr5pCfGuS7jz1IQvS1MjJ2
 1d9rCD8SjoG8X0iT/bN5ZBL7CgChjTCdz0GUrZDnaI8kVlzAb2kcEgrhU Q==;
X-CSE-ConnectionGUID: ILCOYw4XSweCuHZY+10G0A==
X-CSE-MsgGUID: QBELt8oASriw1uTmyaVD2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="74067653"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="74067653"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:16:54 -0700
X-CSE-ConnectionGUID: IpqRA/QfTxG8lKjpgvyGjg==
X-CSE-MsgGUID: Lx43aA29RWSdROwfZkb66A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151345674"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa005.fm.intel.com with ESMTP; 09 Jun 2025 03:16:53 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 2/2] net/e1000: update README
Date: Mon,  9 Jun 2025 11:16:42 +0100
Message-ID: <9a5149bae160064c943ac8e9d8e557e9e1c5e3f1.1749464159.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749464159.git.anatoly.burakov@intel.com>
References: 
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

Update the last shared code update date.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/e1000/base/README b/drivers/net/intel/e1000/base/README
index 23a6604121..976391b170 100644
--- a/drivers/net/intel/e1000/base/README
+++ b/drivers/net/intel/e1000/base/README
@@ -1,9 +1,9 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2020 Intel Corporation
+ * Copyright(c) 2010-2025 Intel Corporation
  */
 
 This directory contains source code of the base driver code for em/igb/igc,
-with this snapshot generated on 2025-01-24-09.44.
+with this snapshot generated on 2025-06-04-14.40.
 
 This driver is valid for the product(s) listed below
 * Intel® Ethernet Controller 82540
-- 
2.47.1

