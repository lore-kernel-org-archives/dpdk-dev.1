Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB98D41D6B
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 17:17:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA48740E30;
	Thu, 11 Dec 2025 18:17:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 2717540E0B;
 Thu, 11 Dec 2025 18:17:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765473439; x=1797009439;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zak2r227pkxmQeEKNAWyrMukN22aeZirlsJrvqJJCu0=;
 b=jhqMYKVZF7Wm8am+Vfz3tr5G0CNCmzbfFzCAwSZ8ITCwuaRcxMaC7Q8L
 9LVOHhrmBurvC9wgZfrqIktfs/HUZ3R2D4LGNj7520/FaJgZaaCUZnnn+
 2hT4CR/ojuanyoKDkjaa3qNyxzKrp1CUYfncz9dd46Cn0z+vymTahdsZM
 7v9lUdOK5AAwARsjiYh0c3UxfrUd01FvnhkiRaLPdHuCczVFqNVBSI/MS
 0ds0HfbaTvhTZm+X1i4jw/ScAckYreOVrZh227WbrnUe6i8alE1tI67K7
 vQpDcPLJwGRPZG+xPoXnkf2z/RaZUPCt/JEI8MP4R3ZtEGTUrWFvfPh47 w==;
X-CSE-ConnectionGUID: utSN9F4sTqubf9LnxV54Mg==
X-CSE-MsgGUID: rYch5C3DSpC/uEGqEMBHyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="85069984"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="85069984"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 09:17:18 -0800
X-CSE-ConnectionGUID: 0JpbLMD+SYK2MR+gk9NAiA==
X-CSE-MsgGUID: RBbZ8hU5SkyI+lJekHsBfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="196461567"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa007.fm.intel.com with ESMTP; 11 Dec 2025 09:17:17 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH v4 04/11] app/test: fix timer loop hang on secondary process
 failure
Date: Thu, 11 Dec 2025 17:17:02 +0000
Message-ID: <20251211171709.714229-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251211171709.714229-1-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251211171709.714229-1-bruce.richardson@intel.com>
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

When the secondary process run from timer_secontary_autotest fails, the
timer loop is never stopped so the whole process hangs until timeout.
Fix this by setting the stop flag before checking for success or failure
of the secondary process.

Fixes: 50247fe03fe0 ("test/timer: exercise new APIs in secondary process")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_timer_secondary.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/app/test/test_timer_secondary.c b/app/test/test_timer_secondary.c
index 864f175d6a..fb2cc43895 100644
--- a/app/test/test_timer_secondary.c
+++ b/app/test/test_timer_secondary.c
@@ -160,11 +160,12 @@ test_timer_secondary(void)
 		TEST_ASSERT_SUCCESS(ret, "Failed to launch timer manage loop");
 
 		ret = timer_secondary_spawn_wait(*sec_lcorep);
-		TEST_ASSERT_SUCCESS(ret, "Secondary process execution failed");
+		/* must set exit flag even on error case, so check ret later */
 
 		rte_delay_ms(500);
-
 		test_info->exit_flag = 1;
+
+		TEST_ASSERT_SUCCESS(ret, "Secondary process execution failed");
 		rte_eal_wait_lcore(*mgr_lcorep);
 
 #ifdef RTE_LIBRTE_TIMER_DEBUG
-- 
2.51.0

