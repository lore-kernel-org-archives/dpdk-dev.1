Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB99CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 08:08:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 193E5402EA;
	Mon, 27 Oct 2025 09:08:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 5E90B402E3
 for <dev@dpdk.org>; Mon, 27 Oct 2025 09:08:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761552487; x=1793088487;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Kc/nuWArAQ0uV8X/kuu+No3Y/nswmQQyNeplV2/rDTk=;
 b=UrdgvB009DzNDTPGzMe7G2ZHUguvsp0JGRh7sx1BkCPm2V9xKidvH7ge
 uZ9OUk6unMMesa33POzmZiTA2QmxF+vmw+/hI4WchYdQJr6rDuR4/3k/R
 5Y7S7BenMccR1uwUJeUdxPs67HYoz3nayFu3xcQ33YFbJ3HAa/0juTj9n
 axbb3cTZoVH2hbnl7q/kIVQxuzjOKCkssMVo0FomHQzJ5775mrX2/tK2M
 SPizbsFMHS46n1d+oTMrfwkxi+cmpEGgQ8qySQhJd+4gVX6jWoLQsAQWr
 X4s6Phi2tDmLfkO24a4b9SGPhzg8rkRwRtCMo6IqhsU7UX7SQXOgDhuJJ w==;
X-CSE-ConnectionGUID: 9HF4beN+TFS0aBrbJmPv4A==
X-CSE-MsgGUID: 3nAaRHssSHyBYwBY9kYW3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81258183"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="81258183"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 01:08:06 -0700
X-CSE-ConnectionGUID: VPuzwR/iQKezT1XF9tO+VQ==
X-CSE-MsgGUID: OyOJafg+Q4uEd3t3w3Yppw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="215878866"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa001.fm.intel.com with ESMTP; 27 Oct 2025 01:08:04 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com
Subject: [PATCH v8 3/3] doc: note on unsupported completion queue sharing
Date: Mon, 27 Oct 2025 13:37:58 +0530
Message-Id: <20251027080758.48410-4-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027080758.48410-1-shaiq.wani@intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com>
 <20251027080758.48410-1-shaiq.wani@intel.com>
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

Added a note in the IDPF Poll Mode Driver documentation to clarify
that sharing a completion queue among multiple TX queues serviced
by different CPU cores is not supported in split queue mode.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 doc/guides/nics/idpf.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/guides/nics/idpf.rst b/doc/guides/nics/idpf.rst
index b99cc18188..47e38fcb13 100644
--- a/doc/guides/nics/idpf.rst
+++ b/doc/guides/nics/idpf.rst
@@ -79,6 +79,11 @@ Runtime Configuration
   Then the PMD will configure Tx queue with single queue mode.
   Otherwise, split queue mode is chosen by default.
 
+.. note::
+
+  In split queue mode, sharing a completion queue among multiple TX queues that are
+  serviced by different CPU cores is not supported.
+
 
 Driver compilation and testing
 ------------------------------
-- 
2.34.1

