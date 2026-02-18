Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6504E9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:42:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62F2A40695;
	Wed, 18 Feb 2026 17:42:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id E5B0E40666
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:41:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771432913; x=1802968913;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=JSpJsL5CO9BjVLNuNhK7r5sB8Pm1ZVk4eOCT8n/Qcn4=;
 b=PqTmzULTyjiwUpJTskhzI54C3xHBlmUUjFbwuZiPfUXM5e6SWpSya9jj
 XHBfP9YCdrEi0MroDyNYTnqKrlvYFN9P5IcekDOQcun3L+LztawhEOhjJ
 4rNdEfYWRCq4k1LgmYHmvcH2IKB5xLgX2NZLyt4ElsnLlDNDGg0R9Xe9J
 ujf6VxmX+1Eb9/Zv6ZTCNGCjv2Xhp/hIwRafP7lJHau9Uxkz2mX6P4jOG
 P6XZzJM0l3orBK8WglDg4gd6bjnDUCyRF+7KKVWl0b0SI7ohwh23UjOQC
 e5SBYe6mDvoiURSkT+ISOGzTrZ4yxST/2SBz4sV/LUxWU6y/1ZqAWr4CA w==;
X-CSE-ConnectionGUID: igm+ptUpSeianf81zyIqNA==
X-CSE-MsgGUID: l5QYmLV0RwOKusq2nFYhJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="72601872"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="72601872"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 08:41:53 -0800
X-CSE-ConnectionGUID: bFn0cs9ATlWtSJU0o+++bg==
X-CSE-MsgGUID: HjmfbsXrQAOXW4IxZygnHg==
X-ExtLoop1: 1
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa003.fm.intel.com with ESMTP; 18 Feb 2026 08:41:51 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v6 8/8] doc: update release notes
Date: Wed, 18 Feb 2026 22:07:50 +0530
Message-Id: <20260218163750.1408973-9-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260218163750.1408973-1-shaiq.wani@intel.com>
References: <20260202094244.447966-2-shaiq.wani@intel.com>
 <20260218163750.1408973-1-shaiq.wani@intel.com>
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

Add L2TPv2 over UDP support for ice PMD in the release notes.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 doc/guides/rel_notes/release_26_03.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index b4499ec066..a159f3122e 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -77,6 +77,10 @@ New Features
 
   * Added support for pre and post VF reset callbacks.
 
+* **Updated Intel ice driver.**
+
+  * Added Flow Director (FDIR) support for L2TPv2 over UDP.
+
 * **Updated Marvell cnxk net driver.**
 
   * Added out-of-place support for CN20K SoC.
-- 
2.34.1

