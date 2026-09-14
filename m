Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F44C88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 16:22:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FE4140E26;
	Mon, 14 Sep 2026 18:22:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0673F40A7F;
 Mon, 14 Sep 2026 18:22:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789402963; x=1820938963;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1lWuQTcmloBcMgJs3dfk4SFNktRStAzobUQL07xwApI=;
 b=jmEmetbgtOl78u/defEsqMXP+ynGmvmaH3NXOYN4fiSG1ZzocHsnpWg5
 pJflnBeFnA71vQPMSfAKxLK2MoF/vLxrdic/m83/37sPwrg0SUAE9a24a
 +vSBNXP1ahbwwWo06x0o90GhanELV5P66ljLAV8UyJbmeQoYVE5DU+lCW
 bNtJBdkkUVRLP3qPzFHHo7TOMINXg3ogMcUnd/8cbFWUngXGQJZDICMVd
 8NWJw07NDRGj0oSBfKB7FSqVWKjI1cBgEC7NJbkO1X4lpWRDqELJgPmXs
 aTCxgsD6gQ7NBEtXeUTY3hscLIqE6gml55Y5d/Iy7USfQj2NoV9Fi7MiF Q==;
X-CSE-ConnectionGUID: vb/XzFoSS6aOLkQ1EvvjTg==
X-CSE-MsgGUID: xJgYgVXRTU+vyhI0nl9igQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100352851"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="100352851"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 09:22:40 -0700
X-CSE-ConnectionGUID: Mx2uxGZ+Q+acQ4BWqPh85g==
X-CSE-MsgGUID: X6gy2nptTR6M3h+LQ0Xtiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="277953012"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.210])
 by fmviesa005.fm.intel.com with ESMTP; 14 Sep 2026 09:22:39 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH 1/2] net/idpf: fix overflow on store of single-queue settings
Date: Mon, 14 Sep 2026 17:22:33 +0100
Message-ID: <20260914162234.4058977-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <bug-2042-3@https.bugs.dpdk.org/>
References: <bug-2042-3@https.bugs.dpdk.org/>
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

The Rx and Tx single queue settings in idpf driver are both boolean
values, but the parse_bool function writes to them as int. This causes
an extra 3 bytes to be written beyond the variable itself.
Fix by changing store type to bool.

Bugzilla ID: 2042
Fixes: 549343c25db8 ("net/idpf: support device initialization")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
===
Note: this fix is superceded by the kvargs numeric args patchset [1].
However, that patchset relies on new kvargs features unlikely to be
backported, so this standalone fix is useful for backporting or if the
whole other set doesn't make the 26.11 release.

[1] https://patches.dpdk.org/project/dpdk/list/?series=39247
---
 drivers/net/intel/idpf/idpf_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index c13505416a..9fd5b28adb 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -1247,7 +1247,7 @@ parse_vport(const char *key, const char *value, void *args)
 static int
 parse_bool(const char *key, const char *value, void *args)
 {
-	int *i = args;
+	bool *i = args;
 	char *end;
 	int num;
 
@@ -1261,7 +1261,7 @@ parse_bool(const char *key, const char *value, void *args)
 		return -EINVAL;
 	}
 
-	*i = num;
+	*i = (num == 1);
 	return 0;
 }
 
-- 
2.53.0

