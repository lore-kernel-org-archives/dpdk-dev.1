Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3D3C2A072
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 06:24:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2815E4060C;
	Mon,  5 Jan 2026 07:24:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id A75DB402F0
 for <dev@dpdk.org>; Mon,  5 Jan 2026 07:24:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767594251; x=1799130251;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Kc/nuWArAQ0uV8X/kuu+No3Y/nswmQQyNeplV2/rDTk=;
 b=XHvnRFULMN8TS+1tBn1yCsy1i5gHuIJHu5dqZU1S91IdBVUVhrOag/9O
 jQ/TuCbBqoI5hLSqZZWr5wjjsNqcKf3VGMieKP9i1jSML1ZKqf+5hREUw
 RpREvdd4tiQCWtyukjr/oNcugtPl0knUq9I3xxzOQF9yp/cT/enUO1fXe
 99uk4LsN9AcVSZnYEfZ45B3TpSWtScd4kMa4pRDSo4RWyVXjLrLmDjfnF
 KiKuoKd9drsgy6aS/cw+D7Gbwb01GXSkr1p+a57/CCYKWgp9VOmARHPQ+
 Dq6bswtGTpuOwr5tbt0t9QDRjkC1IWgqekL+g7y2X5Y9ng4/8vidqAJnC g==;
X-CSE-ConnectionGUID: PD1PwidLTPeNs2N/+EIH2g==
X-CSE-MsgGUID: uVwrmt48QA+yZqog1pC5kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11661"; a="79592948"
X-IronPort-AV: E=Sophos;i="6.21,202,1763452800"; d="scan'208";a="79592948"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jan 2026 22:24:10 -0800
X-CSE-ConnectionGUID: Wd2Xg1WXS4yVKGh+OhXklA==
X-CSE-MsgGUID: JeLneXt1TWSx84t/D/Qprw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,202,1763452800"; d="scan'208";a="201552744"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa010.jf.intel.com with ESMTP; 04 Jan 2026 22:24:09 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v11 3/3] doc: note on unsupported completion queue sharing
Date: Mon,  5 Jan 2026 11:52:57 +0530
Message-Id: <20260105062257.102370-4-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260105062257.102370-1-shaiq.wani@intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com>
 <20260105062257.102370-1-shaiq.wani@intel.com>
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

