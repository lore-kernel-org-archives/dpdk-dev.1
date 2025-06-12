Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AABC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 12:12:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B59C940ECF;
	Thu, 12 Jun 2025 14:12:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id A21BB4021F
 for <dev@dpdk.org>; Thu, 12 Jun 2025 14:12:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749730345; x=1781266345;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=j+CQ/xVB9OzrLaJjhzhhW3iHQQgZ5yzOobi8w4xkJcY=;
 b=R56OvoI18D+NU50sN/ycFOyzoqdzbjFmvYTw5L6JNki47CkTS4MizVug
 IiQ0wXLxpQ7CAyymfz0LJkN74bAF5oJdLKt42KxuzDsik5wNVyy1DkrVh
 pkKOedXdXx72t5SfaV7N287GPp7sv8eecrR8gjDyluO3K/SUbJ4tEk9Yy
 1NyEgxl0bRfS80u45Y0wBnaerce8VjgpUiSgxGxs6mkv387xO34KNEOk9
 X65gLel/4iKQSsZ+Voqb/ptiUD6gLDUYwCLlefSouK1Ifs16KFjP4jOR8
 4sED6odw/Q4+5EWOjK6VVrEssE6BYSFPqpA/Q0rfYf1cxjGR1BzPC5bua w==;
X-CSE-ConnectionGUID: n/uEFPC2S0GqKlDXNR/juA==
X-CSE-MsgGUID: ekhS5jetSuGJ8GrcJtvXAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="63250382"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="63250382"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 05:12:23 -0700
X-CSE-ConnectionGUID: 0NI/0NJ4Rh2jOTLkbqyvhg==
X-CSE-MsgGUID: L5VrqQxSTXuY+kwYUFkVOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="178407214"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa002.jf.intel.com with ESMTP; 12 Jun 2025 05:12:21 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH 1/2] doc: update recommended matching list for cpfl PMD
Date: Thu, 12 Jun 2025 17:43:21 +0530
Message-Id: <20250612121322.146355-1-shaiq.wani@intel.com>
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

Updated the recommended MEV-ts release version corresponding
to DPDK release in the cpfl driver documentation.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 doc/guides/nics/cpfl.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/guides/nics/cpfl.rst b/doc/guides/nics/cpfl.rst
index 3bfab2136d..aa5bed4136 100644
--- a/doc/guides/nics/cpfl.rst
+++ b/doc/guides/nics/cpfl.rst
@@ -39,6 +39,8 @@ Here is the suggested matching list which has been tested and verified.
    +------------+------------------+
    |    24.11   |       1.6        |
    +------------+------------------+
+   |    25.07   |       2.0        |
+   +------------+------------------+
 
 
 Configuration
-- 
2.34.1

