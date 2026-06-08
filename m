Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097C8CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:55:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E179A40664;
	Mon,  8 Jun 2026 16:55:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 3570040265
 for <dev@dpdk.org>; Mon,  8 Jun 2026 16:55:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780930533; x=1812466533;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YpIDUO+7Y6H2mzqZgJuDtHTb6BhZykB8unhXvBsOxNc=;
 b=eDKnA2wiaO51n5QmKkj4Muuml8UBwczrL7qfz/c9uF/bM/FkFmUiJHlT
 duQJ0t4RqZnU5A4If2LiE5fepISaK8VWqWp/jasOZzc94wzVXzxRK5cqf
 1wdsMh19MMNFdXSI5XEGraedhmQQyXJ1zuw88/Y3FXuWuriIlzSRoGc4u
 ahjQufDR4J4LJU+CDc/jb9rjfjeGLMmpRBcQvOhP5QDzRCyAavAFeqOHl
 W5GSGPui/Ix550dUUr9E+q518yusSqDMD5a9KFrra384YRJRRqahzW+uS
 duwiwcVdM4gTd6fZPbR0h45vFQKV1IrxdJH2W3o/emVl8ALMiJDF/FI+f g==;
X-CSE-ConnectionGUID: KxY9ZeuUSHm547sd0nlwPA==
X-CSE-MsgGUID: F/nv2/zQSseveNG4QzLG7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="93055938"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="93055938"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 07:55:31 -0700
X-CSE-ConnectionGUID: jj2VjFlNTjy+weXJZIjzxg==
X-CSE-MsgGUID: anpUDgOkQBqJLR9t3okIYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="247436446"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa004.fm.intel.com with ESMTP; 08 Jun 2026 07:55:30 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
Subject: [PATCH 1/3] net/iavf: downgrade opcode 0 ARQ log to debug
Date: Mon,  8 Jun 2026 14:55:16 +0000
Message-ID: <20260608145518.1705524-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608145518.1705524-1-ciara.loftus@intel.com>
References: <20260608145518.1705524-1-ciara.loftus@intel.com>
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

From: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>

After admin queue reinitialisation, completions from uninitialised
ARQ ring descriptor memory may arrive before any real PF response.
These carry opcode 0 (`VIRTCHNL_OP_UNKNOWN`) and trigger a WARNING
log on every poll iteration, flooding the log during reset recovery.

Treat opcode 0 as a distinct case and log it at DEBUG level, while
retaining WARNING for genuine opcode mismatches.

Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 94ccfb5d6e..cd90d35023 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -299,8 +299,15 @@ iavf_read_msg_from_pf(struct iavf_adapter *adapter, uint16_t buf_len,
 		/* async reply msg on command issued by vf previously */
 		result = IAVF_MSG_CMD;
 		if (opcode != vf->pend_cmd) {
-			PMD_DRV_LOG(WARNING, "command mismatch, expect %u, get %u",
-					vf->pend_cmd, opcode);
+			if (opcode == VIRTCHNL_OP_UNKNOWN)
+				PMD_DRV_LOG(DEBUG,
+					    "Spurious msg with opcode 0, pending cmd %u",
+					    vf->pend_cmd);
+			else
+				PMD_DRV_LOG(WARNING,
+					    "command mismatch, expect %u, get %u",
+					    vf->pend_cmd, opcode);
+
 			result = IAVF_MSG_ERR;
 		}
 	}
-- 
2.43.0

