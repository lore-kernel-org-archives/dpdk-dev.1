Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CE5CCA464
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:39:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CDB2406B7;
	Fri, 16 Oct 2026 13:39:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 5F22740291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 13:39:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792150775; x=1823686775;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=MpGCo/cEMb0IBfHCggvHrIEB0BZLWY5yz3Flh7Imzss=;
 b=PJAUz4IWaliV422Jsuvz2Xjj/lf63X96AKPDMSQO/OkzwEL3C9bP8geT
 U3suPaJ+mEa9rjl4UrFk2aPC7XikqcsKYxJZFQUrD6pPz7nbhgDOIkCzF
 gmYe8/cuLQzCJ8ezFvrGwRnoZlcB4NIgW3Pt+Hu6hlvLdWjKAb/W56WjT
 JdbE3vXM6tcBzQYB9PZhdaDtDjuOaq9VjWRHGF8HDRO4ahEWUNm258hgn
 lcZ9VPzXGWFhaIl6T9nVMUFQVRLeDZ45QFWct2rdQN3LKkIdo77nsy6i9
 gO4Pl2Hr7adTFfwOSBplXt4K2jb/P7As76LB3AAWzqozGtsL6SBqK86zy w==;
X-CSE-ConnectionGUID: 2flPBbbXTJGC/6TbwEJ5gw==
X-CSE-MsgGUID: b+uTxrHfRBSbcBs1pgWtzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="940159"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="940159"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 04:39:35 -0700
X-CSE-ConnectionGUID: n0nk/dAFTi2AhlEm7Kt9Ow==
X-CSE-MsgGUID: IRL2I0cvSye0G1QgBftTnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2178436"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa001.fm.intel.com with ESMTP; 16 Oct 2026 04:39:35 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 2/2] net/i40e/base: avoid implicit conversions
Date: Fri, 16 Oct 2026 12:39:29 +0100
Message-ID: <641e772507175f298fd7411ef8dd3c25cc56b12d.1792150724.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792150724.git.anatoly.burakov@intel.com>
References: 
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

From: Szymon T Cudzilo <szymon.t.cudzilo@intel.com>

Avoid doing implicit conversion as reported by static analysis tools.

Signed-off-by: Szymon T Cudzilo <szymon.t.cudzilo@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/base/i40e_nvm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/i40e/base/i40e_nvm.c b/drivers/net/intel/i40e/base/i40e_nvm.c
index fd1a987c56..c11ebb135a 100644
--- a/drivers/net/intel/i40e/base/i40e_nvm.c
+++ b/drivers/net/intel/i40e/base/i40e_nvm.c
@@ -1414,8 +1414,8 @@ STATIC enum i40e_status_code i40e_nvmupd_state_writing(struct i40e_hw *hw,
 	 */
 	if (status && (hw->aq.asq_last_status == I40E_AQ_RC_EBUSY) &&
 	    !retry_attempt) {
+		enum i40e_admin_queue_err old_asq_status = hw->aq.asq_last_status;
 		enum i40e_status_code old_status = status;
-		u32 old_asq_status = hw->aq.asq_last_status;
 		u32 gtime;
 
 		gtime = rd32(hw, I40E_GLVFGEN_TIMER);
@@ -1656,7 +1656,7 @@ STATIC enum i40e_status_code i40e_nvmupd_exec_aq(struct i40e_hw *hw,
 		}
 
 		if (hw->nvm_buff.va) {
-			buff = hw->nvm_buff.va;
+			buff = (u8 *)hw->nvm_buff.va;
 			i40e_memcpy(buff, &bytes[aq_desc_len], aq_data_len,
 				I40E_NONDMA_TO_NONDMA);
 		}
@@ -1667,19 +1667,19 @@ STATIC enum i40e_status_code i40e_nvmupd_exec_aq(struct i40e_hw *hw,
 
 	/* and away we go! */
 	status = i40e_asq_send_command(hw, aq_desc, buff,
-				       buff_size, &cmd_details);
+				       (u16)buff_size, &cmd_details);
 	if (status) {
 		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "i40e_nvmupd_exec_aq err %s aq_err %s\n",
-			   i40e_stat_str(hw, status),
-			   i40e_aq_str(hw, hw->aq.asq_last_status));
+			   "i40e_nvmupd_exec_aq err %d aq_err %d\n",
+			   status,
+			   hw->aq.asq_last_status);
 		*perrno = i40e_aq_rc_to_posix(status, hw->aq.asq_last_status);
 		return status;
 	}
 
 	/* should we wait for a followup event? */
 	if (cmd->offset) {
-		hw->nvm_wait_opcode = cmd->offset;
+		hw->nvm_wait_opcode = (u16)cmd->offset;
 		hw->nvmupd_state = I40E_NVMUPD_STATE_INIT_WAIT;
 	}
 
@@ -1739,7 +1739,7 @@ STATIC enum i40e_status_code i40e_nvmupd_get_aq_result(struct i40e_hw *hw,
 
 		bytes += len;
 		remainder -= len;
-		buff = hw->nvm_buff.va;
+		buff = (u8 *)hw->nvm_buff.va;
 	} else {
 		buff = (u8 *)hw->nvm_buff.va + (cmd->offset - aq_desc_len);
 	}
-- 
2.52.0

