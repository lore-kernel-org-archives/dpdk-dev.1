Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5E0C5AD5A
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Aug 2026 02:07:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FFAA40DC9;
	Mon, 10 Aug 2026 04:07:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 5218A40C35
 for <dev@dpdk.org>; Mon, 10 Aug 2026 04:07:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786327648; x=1817863648;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Lm7u6rfLCCpN9bliI/+eH+HpZEqPWI+79L81C+/5ypc=;
 b=f2nuvMHXYlbxgXqDaPRv0WXENkgOWjlzSgjobekKd11jh0tb9djdfWUE
 BP77ZG4pY5YDnYYYlqp0MW9rGTHV/qErXBcS0IzQo6WNoVkVVV8sU5wdY
 1PS7PtyliX4rCYioWQEfm02d1Zkf38W2Nv7RWqxdYY/9HQWceyPlY5O+u
 r/qkHRRg/em1lZMG2lBJ8IZ/+ZA2QlMlEOjPsbp2tq74urU2EwbVybmU3
 RleSKBe0E1aPKCH16SRglqH0LAMqtFK3l+saoiYuSNjDZXRhP/oOnghV8
 stS82lfeT5MwQrOg5xO9FjxRzRYmopRGOmqnjIeyrqjeW186pIOoFIQa1 Q==;
X-CSE-ConnectionGUID: qaCJsS5MQxKUvflZHVH4Ew==
X-CSE-MsgGUID: zAqHCOikRqu9eNhIRLJ8tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="98197295"
X-IronPort-AV: E=Sophos;i="6.25,214,1779174000"; d="scan'208";a="98197295"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2026 19:07:27 -0700
X-CSE-ConnectionGUID: kIaQz7DHSsW7OiwOysTDQg==
X-CSE-MsgGUID: j3K6PPKuROizRfuPn7JWjQ==
X-ExtLoop1: 1
Received: from unknown (HELO tester12..) ([10.239.252.12])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2026 19:07:24 -0700
From: Hailin Xu <hailinx.xu@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: manjunathgouda.hosamani@intel.com,
	Hailin Xu <hailinx.xu@intel.com>
Subject: [PATCH v1] doc/ice: Add E835 to ice guide
Date: Mon, 10 Aug 2026 10:04:20 +0800
Message-Id: <20260810020420.128869-1-hailinx.xu@intel.com>
X-Mailer: git-send-email 2.34.1
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

Signed-off-by: Hailin Xu <hailinx.xu@intel.com>
---
 doc/guides/nics/ice.rst | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index b671422ad7..e908b11f6b 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -13,6 +13,7 @@ the following controllers,
 - Intel Ethernet Connection E823
 - Intel Ethernet Connection E825
 - Intel Ethernet Controller E830
+- Intel Ethernet Controller E835
 
 Linux Prerequisites
 -------------------
@@ -58,16 +59,16 @@ The full list of in-tree and out-of-tree Linux kernel drivers from kernel.org
 and Linux distributions that were tested and verified
 are listed in the Tested Platforms section of the Release Notes for each release.
 
-=====  =============  ===========  =========  ============  =======  =======
-DPDK   Kernel Driver  Default DDP  COMMS DDP  Wireless DDP  E810 FW  E830 FW
-=====  =============  ===========  =========  ============  =======  =======
-26.07     2.6.6         1.3.59      1.3.63       1.3.28      5.0      2.10
-26.03     2.4.5         1.3.53      1.3.61       1.3.25      4.91     1.20
-25.11     2.3.14        1.3.43      1.3.55       1.3.25      4.9      1.11
+=====  =============  ===========  =========  ============  =======  ============
+DPDK   Kernel Driver  Default DDP  COMMS DDP  Wireless DDP  E810 FW  E830&E835 FW
+=====  =============  ===========  =========  ============  =======  ============
+26.07     2.6.6         1.3.59      1.3.63       1.3.28      5.0        2.10
+26.03     2.4.5         1.3.53      1.3.61       1.3.25      4.91       1.20
+25.11     2.3.14        1.3.43      1.3.55       1.3.25      4.9        1.11
 24.11     1.15.4        1.3.36      1.3.46       1.3.14      4.6
 23.11     1.13.7        1.3.36      1.3.46       1.3.14      4.4
 22.11     1.10.1        1.3.30      1.3.37       1.3.10      4.1
-=====  =============  ===========  =========  ============  =======  =======
+=====  =============  ===========  =========  ============  =======  ============
 
 
 Dynamic Device Personalization (DDP) package loading
-- 
2.34.1

