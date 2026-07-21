Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5F5C44532
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 15:14:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9931040B91;
	Tue, 21 Jul 2026 17:13:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 3F26940691
 for <dev@dpdk.org>; Tue, 21 Jul 2026 17:13:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784646814; x=1816182814;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8P7c1nFc2eq42GeQyKf1icocHv43hugCuz1r2nmRvS0=;
 b=EMlpjYKphEVXNjPjosLXxfNj/cNkkWZuHPas9TT+Hr/LwoY0sYZfFASn
 GapYcmFNJeB9gH9GjZY0wYHyWLp7YngtqqAdJtzwSOjda9BVl5b3R3j13
 9+Y12uND+xVJv9D/E03OjIVe8qDLiFfrhJblUVNJcqBu0HM+Fjxlap2aW
 4fixCZaslak8/kvl97mS6G5LSy7p5o8kWJYW8TqZixyI6yTHOzU4blBOY
 zEpbvnpWp6N7ZN+Bsk0TObJ3JBs4a7kk726LtZMOhgpYg0Oi0GJEoEEoj
 goVd7qq4+mD4E7zKcVfDbx1EMHTZ5N6peLzRIkRr5lLHqdA0DoiQhs7Gl A==;
X-CSE-ConnectionGUID: tIFe8J6UTO6987LSkRbRKg==
X-CSE-MsgGUID: 1FPWPOtyR72bZL1JRbl27Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85107726"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="85107726"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 08:13:34 -0700
X-CSE-ConnectionGUID: 6awf9jWHQzCqec48KbvVng==
X-CSE-MsgGUID: jUKD9/yUQQe8drFyARziSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="281070976"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 21 Jul 2026 08:13:33 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 6/6] doc/rel_notes: minor style fixes
Date: Tue, 21 Jul 2026 16:13:25 +0100
Message-ID: <20260721151325.2698283-7-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721151325.2698283-1-bruce.richardson@intel.com>
References: <20260721151325.2698283-1-bruce.richardson@intel.com>
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

Some minor fixes for the release note text.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/rel_notes/release_26_07.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index fca135569f..47cf73e825 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -80,7 +80,7 @@ New Features
   Added EAL options affecting the initial bus probing to find devices.
 
   * ``-A`` or ``--no-auto-probing`` disables the initial bus probing: no device is probed during
-    ``rte_eal_init`` and the application is responsible for probing each device,
+    ``rte_eal_init`` and the application is responsible for probing each device.
   * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
 
 * **Added RISC-V vector paths.**
@@ -144,7 +144,7 @@ New Features
 
 * **Added no-IOMMU mode to UACCE bus.**
 
-  Added no-IOMMU mode for devices without or not enabling IOMMU/SVA.
+  Added no-IOMMU mode for devices that do not have or do not enable IOMMU/SVA support.
 
 * **Added unplug operation support to VMBUS bus.**
 
-- 
2.53.0

