Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7ADBC77B7C
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 13:34:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E30FC40A6B;
	Tue, 24 Jun 2025 15:34:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 8433E40A70
 for <dev@dpdk.org>; Tue, 24 Jun 2025 15:34:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750772064; x=1782308064;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0IpBQ7w6ZNWOkh4Vw4YgHY5sAyKERc5EIZuAtT4YPyQ=;
 b=RqvtPS6Zas0s6okCwXCrqWfpx+Sc16mjcX58zi+OS6Vg7/W6SCkFj+Tz
 wUNTyVKtHYSF4GnUJJbYcGChXlmC+cNSVYiHM3iAhh/Eh0RMkUYM+YpKA
 yl2BRjpvw2S5VwVS5wQ41NpQcuX2EAKD4lXul+38g4NB4mb7ljc/VHAGl
 XN+Kejtm3niU+E7jGKwS4cHEXxp2LY0t5PvdHEV+ESawAAKjDRHXQwE+0
 cXsDsyUZ7se7hJrFkHrcnABL6O+hikfQXaNDrj/+JXI1ShM6KEc+V+G0p
 rHDO4ZqjcW7J4Z0RilMOStJaMaL2VzNZxOL0FhXmAje6aWOWuD+JFkNHg A==;
X-CSE-ConnectionGUID: tYo5d9bqQ2KiUP1EDPel2g==
X-CSE-MsgGUID: vNJjayCGRc6m9Uy4IMYLWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53112037"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="53112037"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 06:34:24 -0700
X-CSE-ConnectionGUID: elWdYoyDSIG7tFAe+g5R3A==
X-CSE-MsgGUID: kY92ZLvZTh6CNfQBNLsd5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="157410757"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa004.fm.intel.com with ESMTP; 24 Jun 2025 06:34:21 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 1/2] doc/eal: add doc entry for service core list flag
Date: Tue, 24 Jun 2025 14:34:07 +0100
Message-ID: <20250624133409.550372-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250624133409.550372-1-bruce.richardson@intel.com>
References: <20250624133409.550372-1-bruce.richardson@intel.com>
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

In the list of EAL arguments, only the "-s" flag for service cores was
documented. Add an entry for the "-S" one too, which takes a core list
instead of a core mask.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/linux_gsg/eal_args.include.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux_gsg/eal_args.include.rst
index 359721eb6a..6ee79877c1 100644
--- a/doc/guides/linux_gsg/eal_args.include.rst
+++ b/doc/guides/linux_gsg/eal_args.include.rst
@@ -79,6 +79,11 @@ Lcore-related options
 
     Hexadecimal bitmask of cores to be used as service cores.
 
+*   ``-S <service core list>``
+
+    List of cores to be used as service cores.
+
+
 Device-related options
 ~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.48.1

