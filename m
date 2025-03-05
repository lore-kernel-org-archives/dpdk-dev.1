Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A922C282DE
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 16:38:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB5DC40651;
	Wed,  5 Mar 2025 17:38:21 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 81E2B4042E
 for <dev@dpdk.org>; Wed,  5 Mar 2025 17:38:18 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id C3746210EAE8; Wed,  5 Mar 2025 08:38:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C3746210EAE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741192697;
 bh=Nnzy3S5FtD7aJMSgOeJjTKHjT5BhELfvQL71HpjSq5E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cM0kKs7CmbiOwM/ky5vlWPRxwcRth1RTyu6HJIOgGgW7f3ey6c1F7/HIvRZdYL97h
 Sc6NNg0gNcfJSmHZnHhjKnYzmchvGOrYyj4P0qPFdacjCMj8bZRW6Dx3wtim4k7Ttw
 yE13G5fZOCSLlrLqdJm9AqlL7468uU9riMoq9Hw4=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	mb@smartsharesystems.com
Subject: [PATCH v3 4/5] net/intel: use portable version of
 __builtin_add_overflow
Date: Wed,  5 Mar 2025 08:38:09 -0800
Message-Id: <1741192690-26243-5-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741192690-26243-1-git-send-email-andremue@linux.microsoft.com>
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
 <1741192690-26243-1-git-send-email-andremue@linux.microsoft.com>
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

__builtin_add_overflow is gcc specific. It should be replaced with
a portable version that can also be used with other compilers.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 drivers/net/intel/ice/base/ice_nvm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_nvm.c b/drivers/net/intel/ice/base/ice_nvm.c
index 56c6c96a95..1002a6b59f 100644
--- a/drivers/net/intel/ice/base/ice_nvm.c
+++ b/drivers/net/intel/ice/base/ice_nvm.c
@@ -3,6 +3,7 @@
  */
 
 #include "ice_common.h"
+#include <rte_math.h>
 
 #define GL_MNG_DEF_DEVID 0x000B611C
 
@@ -469,8 +470,6 @@ int ice_read_sr_word(struct ice_hw *hw, u16 offset, u16 *data)
 	return status;
 }
 
-#define check_add_overflow __builtin_add_overflow
-
 /**
  * ice_get_pfa_module_tlv - Reads sub module TLV from NVM PFA
  * @hw: pointer to hardware structure
@@ -500,7 +499,7 @@ ice_get_pfa_module_tlv(struct ice_hw *hw, u16 *module_tlv, u16 *module_tlv_len,
 		return status;
 	}
 
-	if (check_add_overflow(pfa_ptr, (u16)(pfa_len - 1), &max_tlv)) {
+	if (rte_add_overflow(pfa_ptr, (u16)(pfa_len - 1), &max_tlv)) {
 		ice_debug(hw, ICE_DBG_INIT, "PFA starts at offset %u. PFA length of %u caused 16-bit arithmetic overflow.\n",
 				  pfa_ptr, pfa_len);
 		return ICE_ERR_INVAL_SIZE;
@@ -541,8 +540,8 @@ ice_get_pfa_module_tlv(struct ice_hw *hw, u16 *module_tlv, u16 *module_tlv_len,
 			return ICE_ERR_INVAL_SIZE;
 		}
 
-		if (check_add_overflow(next_tlv, (u16)2, &next_tlv) ||
-		    check_add_overflow(next_tlv, tlv_len, &next_tlv)) {
+		if (rte_add_overflow(next_tlv, (u16)2, &next_tlv) ||
+		    rte_add_overflow(next_tlv, tlv_len, &next_tlv)) {
 			ice_debug(hw, ICE_DBG_INIT, "TLV of type %u and length 0x%04x caused 16-bit arithmetic overflow. The PFA starts at 0x%04x and has length of 0x%04x\n",
 					  tlv_sub_module_type, tlv_len, pfa_ptr, pfa_len);
 			return ICE_ERR_INVAL_SIZE;
-- 
2.48.1.vfs.0.0

