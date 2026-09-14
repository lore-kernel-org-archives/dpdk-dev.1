Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F549C88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 15:46:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4569B40E2B;
	Mon, 14 Sep 2026 17:46:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 34D164064A;
 Mon, 14 Sep 2026 17:46:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789400766; x=1820936766;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TafSih8r0IxIDAvI3lOzOidXgQCjxcq9ZyodUfPRgo0=;
 b=HVM8jQImt2zon+Yhfsy0vfa7RY8XYgJk7u7qKIeLv+sc14q7rdPADw6G
 f3m9UYsiD5qMg2tmXCdRR1WGDCx2twBxo73HcQOdJTiQvy8x//grrs675
 xLuLRWy7M/8cpVX6hzaiF4ItVgtRwLCLh/UfpqZYAaD61eHQZQ5bY4dmo
 YS3ZefA4BPVUaTAHdYeb78IqtSESggm1+Uof+BLfeU3W6b9Zw679QMQp1
 Jn3P/CzHWnV74pex+Pz60C28OsYuVL0Zlq/WUxWZBRgJPAxBf98ysz4s7
 Yc24yRVh/R1JaN/Wph1aRFzGXeqGh3Gwe2Uj0FziUD2xyeAzxj1cKnpEp Q==;
X-CSE-ConnectionGUID: beKfD6dQR0qGpnQokSJP1g==
X-CSE-MsgGUID: DJC69jcYRyCdKYWzVXIjBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="115290509"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="115290509"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 08:46:05 -0700
X-CSE-ConnectionGUID: Z2Gj6EaPQAK3X78rAoxl4g==
X-CSE-MsgGUID: wr8yc7f1QJCo702yL0oRmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="270044922"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.210])
 by fmviesa008.fm.intel.com with ESMTP; 14 Sep 2026 08:46:03 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/ice: fix storing field offset arg
Date: Mon, 14 Sep 2026 16:45:59 +0100
Message-ID: <20260914154559.4045256-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <bug-2038-3@https.bugs.dpdk.org>
References: <bug-2038-3@https.bugs.dpdk.org>
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

The field offset argument type inside ice driver is of "int" type, but
when parsing and storing the value from a devarg, a uint8_t type is
used, leading to 3 bytes being potentially uninitialized. Fix this by
storing to an int type instead.

Bugzilla ID: 2038
Fixes: df539aaf35cb ("net/ice: refactor flex descriptor protocol field extraction")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
Note: this fix is superceded by the kvargs numeric args patchset [1].
However, that patchset relies on new kvargs features unlikely to be
backported, so this standalone fix is useful for backporting or if the
whole other set doesn't make the 26.11 release.

[1] https://patches.dpdk.org/project/dpdk/list/?series=39247
---
 drivers/net/intel/ice/ice_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 3938186228..2f97140bef 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -735,7 +735,7 @@ static int
 handle_field_offs_arg(__rte_unused const char *key, const char *value,
 				void *offs_args)
 {
-	uint8_t *offset = offs_args;
+	int *offset = offs_args;
 
 	if (value == NULL || offs_args == NULL)
 		return -EINVAL;
-- 
2.53.0

