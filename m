Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF2ECCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 14:22:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E75140A70;
	Tue, 28 Oct 2025 15:22:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id EBCC84067D
 for <dev@dpdk.org>; Tue, 28 Oct 2025 15:22:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761661335; x=1793197335;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Kc/nuWArAQ0uV8X/kuu+No3Y/nswmQQyNeplV2/rDTk=;
 b=HIopSid6Apv2pw1aNq5Bg9duq0RBX/CHaD4gEHQaXXfzSCtlUEdVwf3F
 C9HWcQtYmCinWmHvcG2XKmV277xdZh7GFARCZgPWliCYaC+LUEbsyMC2p
 wPK++8MNIJ/X7ES9OxqGSanehIEA6lFZl67G1LRlpllg7TedfQN3KJuK7
 NNWOxU1R8SfC+ntQpsAge6NTiNYoOM2uqc5MKmD0EYTcr9SJ0jB9EH5ll
 vyl5apsLBGkNniKRtl0BOUjNhfMdFeJU25G8b7p2eQLkxA8sG+cPnUQ9P
 Tz5MJKEybkCAYWY8ZUuKD+OVGOhyjECd4dKybGKes/Zq5J4sSmRO9HjxD w==;
X-CSE-ConnectionGUID: 0Csn/UixSXawnmaD0OvkiQ==
X-CSE-MsgGUID: /fguJ87GRU6hlzFsheV/yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67626446"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="67626446"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 07:22:14 -0700
X-CSE-ConnectionGUID: g+T2DWfOQZ641T/yEJaPzQ==
X-CSE-MsgGUID: gavZ24ZRRzeiuFj1ypneRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="185681816"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa008.fm.intel.com with ESMTP; 28 Oct 2025 07:22:13 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com
Subject: [PATCH v10 3/3] doc: note on unsupported completion queue sharing
Date: Tue, 28 Oct 2025 19:52:02 +0530
Message-Id: <20251028142202.137392-4-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028142202.137392-1-shaiq.wani@intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com>
 <20251028142202.137392-1-shaiq.wani@intel.com>
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

