Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4DAC02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:18:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F087842E7E;
	Tue,  4 Feb 2025 16:12:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 0EDB142E3A;
 Tue,  4 Feb 2025 16:12:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681953; x=1770217953;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1S2ffpMXypHD6YG2oIMQVMI2COlsTEWfj7Tml6FPnTE=;
 b=FArRFf78U/rEA0qL12AdRTXWB5HDLoiRXV8WoE2l58ORYc9kFqt8LtDU
 Ytbxu167W4B26haJvevnsI7K6E7J3xRGFy7SGCoXTGGZ++oQu6iaEKyO3
 BWNM1xGt8gHBGwp+iQQmnrirmaix3/bQD3he5QH6uZ0Ilqq1VOxwNyoza
 uIKfcjNsTRmXA8TgUZvYB0WaL1RCGVxAgFx6YGsG9OyvQE9utozfP6B9w
 BPdOIQWsY5xZq/ddCsQ34IsTlhoLToBWGl/TVUsTuXkQME3AymGjdNhjF
 WMuUHDbqNfR5QEz6tMul3EI7gqEbgvDum4iw6ZpjhAoPFyb0isn5HnzWD A==;
X-CSE-ConnectionGUID: LM0RQdv0T/C2ZfRMwHhj4A==
X-CSE-MsgGUID: CerYYWzXQ920KwDDOOwneg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097202"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097202"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:32 -0800
X-CSE-ConnectionGUID: KpUvJFyzRv6aEaxTGRQ0Ig==
X-CSE-MsgGUID: NPAcYXvSSgiGQYiP8s3YHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792790"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:30 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	stable@dpdk.org
Subject: [PATCH v2 50/54] net/e1000/base: fix uninitialized variable usage
Date: Tue,  4 Feb 2025 15:10:56 +0000
Message-ID: <784295875c8f8a2d765be0ed3f302a241b54bd06.1738681726.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
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

From: Jakub Buchocki <101559614+jbuchocx@users.noreply.github.com>

Coverity has detected potential usage of uninitialized values inside the
array. Fix the warning by initializing array.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Jakub Buchocki <jakubx.buchocki@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_vf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_vf.c b/drivers/net/intel/e1000/base/e1000_vf.c
index bb314e2f12..e0c95aa130 100644
--- a/drivers/net/intel/e1000/base/e1000_vf.c
+++ b/drivers/net/intel/e1000/base/e1000_vf.c
@@ -374,7 +374,7 @@ STATIC void e1000_write_msg_read_ack(struct e1000_hw *hw,
 void e1000_update_mc_addr_list_vf(struct e1000_hw *hw,
 				  u8 *mc_addr_list, u32 mc_addr_count)
 {
-	u32 msgbuf[E1000_VFMAILBOX_SIZE];
+	u32 msgbuf[E1000_VFMAILBOX_SIZE] = {0};
 	u16 *hash_list = (u16 *)&msgbuf[1];
 	u32 hash_value;
 	u32 i;
-- 
2.43.5

