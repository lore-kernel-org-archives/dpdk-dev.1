Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108D8CA1002
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 15:06:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 425B74278F;
	Thu,  4 Sep 2025 17:06:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 1DB524275D
 for <dev@dpdk.org>; Thu,  4 Sep 2025 17:06:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756998374; x=1788534374;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lxw1GVCKvV4L+v4w2Nf/NW+8YwwJVjH5/v9sEzovmlk=;
 b=lpk3MBNbqlv66bU5on7k13iIYhkSbq4qmEv8Z6fN8TDHLSzwU+gx549I
 cJHMm/UHNJcFJkNQeQTwm7QiEaQfUyah7aYNzPPKnX3SWQWXV7BmR30a8
 52cdExKIj3SQYRmPNn7MbfPsv9uwBrLjmtezWpDkK6yl1kdczYrHJ/xkh
 UaDH9BxDtNKv5eWozkw9yDI+H/b3b6+Ex3tgMp+R+7T7ViNdOMji1FZU0
 7N2kn44d9MeUvnz8y0pQ4dgpx4YW4/Kx55hs6o9p5A1ZaNfGchwhAkooa
 yF+GzZ3BdqcSgJxg51zoOtl8axK/5i6/QLp1f7p67Eq7qD99LoaqZzUXp g==;
X-CSE-ConnectionGUID: fJG4F563ShqDIqO/f4vf6w==
X-CSE-MsgGUID: T3nzbmaASPGLISZ8WH48uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="70438553"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="70438553"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 08:06:13 -0700
X-CSE-ConnectionGUID: yuqQlbzgTRCLQ4yPOqbJbQ==
X-CSE-MsgGUID: xHPjBPjsSXae5TFAklHrZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="177180461"
Received: from silpixa00401920.ir.intel.com (HELO
 silpixa00401920.ger.corp.intel.com) ([10.237.222.93])
 by orviesa005.jf.intel.com with ESMTP; 04 Sep 2025 08:06:13 -0700
From: Harry van Haaren <harry.van.haaren@intel.com>
To: dev@dpdk.org
Cc: harryhaaren@gmail.com,
	Harry van Haaren <harry.van.haaren@intel.com>
Subject: [PATCH] maintainers: update service cores and event/sw pmd
Date: Thu,  4 Sep 2025 16:06:05 +0100
Message-ID: <20250904150605.1147639-1-harry.van.haaren@intel.com>
X-Mailer: git-send-email 2.43.0
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

Remove myself from DPDK maintainership, as I will no longer be
working at Intel or directly with DPDK.

Signed-off-by: Harry van Haaren <harry.van.haaren@intel.com>

---

I'll take this opportunity to thank Intel & DPDK community!
Its been great to be involved in DPDK, building some super-fast,
relevant and just-cool optimized software. For all who discussed
tech topics over a $BEVERAGE at a Userspace/other events, thanks!
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7aca98c537..2feb28ee4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -254,7 +254,6 @@ F: examples/multi_process/
 F: doc/guides/sample_app_ug/multi_process.rst
 
 Service Cores
-M: Harry van Haaren <harry.van.haaren@intel.com>
 F: lib/eal/include/rte_service.h
 F: lib/eal/include/rte_service_component.h
 F: lib/eal/common/rte_service.c
@@ -1486,7 +1485,6 @@ F: drivers/event/dpaa2/
 F: doc/guides/eventdevs/dpaa2.rst
 
 Software Eventdev PMD
-M: Harry van Haaren <harry.van.haaren@intel.com>
 F: drivers/event/sw/
 F: doc/guides/eventdevs/sw.rst
 F: examples/eventdev_pipeline/
-- 
2.43.0

