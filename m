Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54CEC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 07:14:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD2E942E6C;
	Thu, 19 Jun 2025 09:14:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 552FB42E60
 for <dev@dpdk.org>; Thu, 19 Jun 2025 09:14:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750317260; x=1781853260;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=hcGg0kCeNTOUZh7KarzbdlWZRw+6gWyFzre0SiSOSsw=;
 b=GR3sh2GNr/msMQfbhILYu9HwBcLVS88ewE98Ri9GA9AGVZ+5ex0/teIH
 S69Y7jkLpsFao+sdKTyNjKofgH8IlFvXigSSBp+kzaYj9kNAC+x61POv9
 hCGmPBAoeGaWirY0xthhbCPN+Qf2KVvtSlxXpghHbcqvS8GfP15uV8CJK
 qM/lhE8ePU43QVXxlI3MrvkBAgX8CrCY89LoWHnCoX3FV2i/9p7SyKFYr
 QsVL83woCJHTAfZIX17sE8FCmaIX+409uol1QACSwpTIFmjyqQIaruSaD
 0zEVVf6SNzuVt7oLLdQQMl19PsFWOzy+CgWWLh1JbzLRQevRMm/RIXxrQ g==;
X-CSE-ConnectionGUID: otRtt9q/RFWnN9+p01CT1w==
X-CSE-MsgGUID: y5ZVafOzTyqN4mRLnijPbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="55193469"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; d="scan'208";a="55193469"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 00:14:19 -0700
X-CSE-ConnectionGUID: vVnibCVgTsmoSQ0V714fKQ==
X-CSE-MsgGUID: mgLlQu4ARB6Nj28kp4fZ5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; d="scan'208";a="150990843"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa008.fm.intel.com with ESMTP; 19 Jun 2025 00:14:15 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v2 2/2] doc: update recommended matching list for idpf PMD
Date: Thu, 19 Jun 2025 12:45:02 +0530
Message-Id: <20250619071502.442214-3-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250619071502.442214-1-shaiq.wani@intel.com>
References: <20250612121322.146355-1-shaiq.wani@intel.com>
 <20250619071502.442214-1-shaiq.wani@intel.com>
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

Updated the recommended MEV-ts release versions corresponding to
DPDK releases in the idpf driver documentation.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 doc/guides/nics/idpf.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/nics/idpf.rst b/doc/guides/nics/idpf.rst
index b55de3abd3..b99cc18188 100644
--- a/doc/guides/nics/idpf.rst
+++ b/doc/guides/nics/idpf.rst
@@ -33,6 +33,10 @@ Here is the suggested matching list which has been tested and verified.
    +------------+---------------+------------------+
    |    23.11   |    0.0.720    |       1.0        |
    +------------+---------------+------------------+
+   |    24.11   |    0.0.754    |       1.6        |
+   +------------+---------------+------------------+
+   |    25.07   |    0.0.772    |       2.0        |
+   +------------+---------------+------------------+
 
 
 Configuration
-- 
2.34.1

