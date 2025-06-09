Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57927C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:26:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D40540E31;
	Mon,  9 Jun 2025 12:25:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 2B4D640E1D
 for <dev@dpdk.org>; Mon,  9 Jun 2025 12:25:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749464749; x=1781000749;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=YARxjtMMuvs8X/MIJljB/iB2a6MoATa86L5ZJPfb5Fk=;
 b=G5zXmDzMmj0o6qob2lvqTmSyGm78JxRgnNoDv5T/ISOY64ihwjJ3jZ0D
 nDNSstLeHlW/V8QK17E/kYbJSUEAmtZSSpsjvMLrIrwBe6pnLQYCPGRnj
 4D52SXajTSsIyjiE7ICbLyqqZvuVcFBWr3AU75rof0YLZVVShnrY9zsD2
 gJOEPF38wKtQDjfRfr6N1xgcaanBFJRSUnVC686SId6YH6/VoeGzjVzEa
 IuWCYtNjCOIsBDHyafKkj4CtRah/gX6Uvb5/eIpa/n9IwE45vtXryeDdq
 zvSvWXtpXrfRD5tiEUV/tsJtP0byooBy07O70eISlmN+5W8mRPdZ8ZxRr g==;
X-CSE-ConnectionGUID: h1iFSZczTP+Kqritu74XXQ==
X-CSE-MsgGUID: jhU4AD0mQ4yFIGnnudOpag==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="51448510"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="51448510"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:25:48 -0700
X-CSE-ConnectionGUID: Sb4uf66oT7CMnYYzNM4YYA==
X-CSE-MsgGUID: HYRny8kQQVy42yHvDnIR4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="146356451"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa006.fm.intel.com with ESMTP; 09 Jun 2025 03:25:47 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 4/5] net/ixgbe: add ACI debug printouts
Date: Mon,  9 Jun 2025 11:25:37 +0100
Message-ID: <fd06f7e3510664c6e8751b754cf170296426cc66.1749464704.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749464704.git.anatoly.burakov@intel.com>
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

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Add more verbose printouts for ACI when debugging is enabled.

Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/base/ixgbe_e610.c     | 110 ++++++++++++++++++
 drivers/net/intel/ixgbe/base/ixgbe_e610.h     |   2 +
 drivers/net/intel/ixgbe/base/ixgbe_osdep.h    |   1 +
 .../net/intel/ixgbe/base/ixgbe_type_e610.h    |   1 +
 4 files changed, 114 insertions(+)

diff --git a/drivers/net/intel/ixgbe/base/ixgbe_e610.c b/drivers/net/intel/ixgbe/base/ixgbe_e610.c
index cf45db3bc4..06a69d1d62 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_e610.c
+++ b/drivers/net/intel/ixgbe/base/ixgbe_e610.c
@@ -31,6 +31,99 @@ void ixgbe_shutdown_aci(struct ixgbe_hw *hw)
 	ixgbe_destroy_lock(&hw->aci.lock);
 }
 
+/**
+ * ixgbe_aci_debug_array - dump a buffer of data row by row
+ * @row_size: size in bytes of data dumped in a single row
+ * @buf: data to be dumped into the debug log
+ * @buf_size: size of buffer
+ *
+ * Debug function for dumping a binary blob of data row by row.
+ */
+STATIC void ixgbe_aci_debug_array(struct ixgbe_hw *hw, u16 row_size, u8 *buf,
+				  u16 buf_size)
+{
+	char debug_portion[IXGBE_ACI_MAX_DEBUG_STRING_LENGTH] = {'\0'};
+	char debug_string[IXGBE_ACI_MAX_DEBUG_STRING_LENGTH] = {'\0'};
+	u16 i = 0, j = 0;
+	s16 remaining_space = IXGBE_ACI_MAX_DEBUG_STRING_LENGTH - 1;
+	s16 nbytes = 0;
+	if (!hw)
+		return;
+	if (buf && buf_size && row_size) {
+		if (buf_size >= row_size) {
+			for (i = 0; i < (buf_size - row_size); i += row_size) {
+				nbytes = snprintf(debug_string, sizeof(debug_string), "0x%04X : ", i);
+				remaining_space = IXGBE_ACI_MAX_DEBUG_STRING_LENGTH - nbytes - 1;
+				for (j = 0; j < row_size; j++) {
+					nbytes = snprintf(debug_portion, sizeof(debug_portion), "0x%02X ", buf[i + j]);
+					strncat(debug_string, debug_portion, remaining_space);
+					remaining_space -= nbytes;
+					if (remaining_space <= 0) break;
+				}
+				strncat(debug_string, "\n", remaining_space);
+				DEBUGOUT1("%s", debug_string);
+				memset(debug_string, 0, IXGBE_ACI_MAX_DEBUG_STRING_LENGTH);
+			}
+		}
+		if (i < buf_size) {
+			nbytes = snprintf(debug_string, sizeof(debug_string), "0x%04X : ", i);
+			remaining_space = IXGBE_ACI_MAX_DEBUG_STRING_LENGTH - nbytes - 1;
+			for (j = 0; j < (buf_size - i); j++) {
+				nbytes = snprintf(debug_portion, sizeof(debug_portion), "0x%02X ", buf[i + j]);
+				strncat(debug_string, debug_portion, remaining_space);
+				remaining_space -= nbytes;
+				if (remaining_space <= 0) break;
+			}
+			strncat(debug_string, "\n", remaining_space);
+			DEBUGOUT1("%s", debug_string);
+		}
+	}
+}
+
+/**
+ * ixgbe_aci_debug - dump the ACI data with the descriptor contents.
+ * @hw: pointer to the hardware structure
+ * @desc: pointer to control queue descriptor
+ * @buf: pointer to command buffer
+ * @buf_len: max length of buf
+ *
+ * Debug function for dumping logs about ACI command with descriptor contents.
+ */
+void ixgbe_aci_debug(struct ixgbe_hw *hw, void *desc, void *buf, u16 buf_len)
+{
+	struct ixgbe_aci_desc *aci_desc = (struct ixgbe_aci_desc *)desc;
+	u16 datalen, flags;
+
+	if (!hw || !desc)
+		return;
+
+	datalen = IXGBE_LE16_TO_CPU(aci_desc->datalen);
+	flags = IXGBE_LE16_TO_CPU(aci_desc->flags);
+
+	DEBUGOUT4("CQ CMD: opcode 0x%04X, flags 0x%04X, datalen 0x%04X, retval 0x%04X\n",
+		  IXGBE_LE16_TO_CPU(aci_desc->opcode), flags, datalen,
+		  IXGBE_LE16_TO_CPU(aci_desc->retval));
+	DEBUGOUT2("\tcookie (h,l) 0x%08X 0x%08X\n",
+		  IXGBE_LE32_TO_CPU(aci_desc->cookie_high),
+		  IXGBE_LE32_TO_CPU(aci_desc->cookie_low));
+	DEBUGOUT2("\tparam (0,1)  0x%08X 0x%08X\n",
+		  IXGBE_LE32_TO_CPU(aci_desc->params.generic.param0),
+		  IXGBE_LE32_TO_CPU(aci_desc->params.generic.param1));
+	DEBUGOUT2("\taddr (h,l)   0x%08X 0x%08X\n",
+		  IXGBE_LE32_TO_CPU(aci_desc->params.generic.addr_high),
+		  IXGBE_LE32_TO_CPU(aci_desc->params.generic.addr_low));
+
+	/* Dump buffer if 1) one exists and 2) is either a response indicated
+	 * by the DD and/or CMP flag set or a command with the RD flag set.
+	 */
+	if (buf && aci_desc->datalen != 0 &&
+	    (flags & (IXGBE_ACI_FLAG_DD | IXGBE_ACI_FLAG_CMP) ||
+	     flags & IXGBE_ACI_FLAG_RD)) {
+		DEBUGOUT("Buffer:\n");
+		ixgbe_aci_debug_array(hw, 16, (u8 *)buf, min(buf_len, datalen));
+	}
+}
+
 /**
  * ixgbe_should_retry_aci_send_cmd_execute - decide if ACI command should
  * be resent
@@ -94,10 +187,12 @@ ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw, struct ixgbe_aci_desc *desc,
 		/* It's necessary to check if mechanism is enabled */
 		hicr = IXGBE_READ_REG(hw, PF_HICR);
 		if (!(hicr & PF_HICR_EN)) {
+			DEBUGOUT("CSR mechanism is not enabled\n");
 			status = IXGBE_ERR_ACI_DISABLED;
 			break;
 		}
 		if (hicr & PF_HICR_C) {
+			DEBUGOUT("CSR mechanism is busy\n");
 			hw->aci.last_status = IXGBE_ACI_RC_EBUSY;
 			status = IXGBE_ERR_ACI_BUSY;
 			break;
@@ -105,6 +200,7 @@ ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw, struct ixgbe_aci_desc *desc,
 		opcode = desc->opcode;
 
 		if (buf_size > IXGBE_ACI_MAX_BUFFER_SIZE) {
+			DEBUGOUT("buf_size is too big\n");
 			status = IXGBE_ERR_PARAM;
 			break;
 		}
@@ -117,6 +213,7 @@ ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw, struct ixgbe_aci_desc *desc,
 			if ((buf && buf_size == 0) ||
 			    (buf == NULL && buf_size)) {
 				status = IXGBE_ERR_PARAM;
+				DEBUGOUT("Error: Invalid argument buf or buf_size\n");
 				break;
 			}
 			if (buf && buf_size)
@@ -156,6 +253,8 @@ ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw, struct ixgbe_aci_desc *desc,
 			}
 		}
 
+		ixgbe_aci_debug(hw, (void *)desc, tmp_buf, (u16)tmp_buf_size);
+
 		/* Descriptor is written to specific registers */
 		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
 			IXGBE_WRITE_REG(hw, PF_HIDA(i),
@@ -195,6 +294,7 @@ ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw, struct ixgbe_aci_desc *desc,
 				raw_desc[i] = IXGBE_READ_REG(hw, PF_HIDA(i));
 				raw_desc[i] = IXGBE_CPU_TO_LE32(raw_desc[i]);
 			}
+			ixgbe_aci_debug(hw, (void *)raw_desc, NULL, 0);
 		}
 
 		/* Read async Admin Command response */
@@ -203,13 +303,18 @@ ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw, struct ixgbe_aci_desc *desc,
 				raw_desc[i] = IXGBE_READ_REG(hw, PF_HIDA_2(i));
 				raw_desc[i] = IXGBE_CPU_TO_LE32(raw_desc[i]);
 			}
+			ixgbe_aci_debug(hw, (void *)raw_desc, NULL, 0);
 		}
 
 		/* Handle timeout and invalid state of HICR register */
 		if (hicr & PF_HICR_C) {
+			DEBUGOUT1("Error: Admin Command 0x%X command timeout\n",
+				  desc->opcode);
 			status = IXGBE_ERR_ACI_TIMEOUT;
 			break;
 		} else if (!(hicr & PF_HICR_SV) && !(hicr & PF_HICR_EV)) {
+			DEBUGOUT1("Error: Admin Command 0x%X invalid state of HICR register\n",
+				  desc->opcode);
 			status = IXGBE_ERR_ACI_ERROR;
 			break;
 		}
@@ -221,11 +326,14 @@ ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw, struct ixgbe_aci_desc *desc,
 		 */
 		if (desc->opcode != opcode &&
 		    opcode != IXGBE_CPU_TO_LE16(ixgbe_aci_opc_get_fw_event)) {
+			DEBUGOUT("Error: Admin Command failed because of bad opcode was returned\n");
 			status = IXGBE_ERR_ACI_ERROR;
 			break;
 		}
 
 		if (desc->retval != IXGBE_ACI_RC_OK) {
+			DEBUGOUT1("Error: Admin Command failed with error %x\n",
+				  desc->retval);
 			hw->aci.last_status = (enum ixgbe_aci_err)desc->retval;
 			status = IXGBE_ERR_ACI_ERROR;
 			break;
@@ -239,6 +347,8 @@ ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw, struct ixgbe_aci_desc *desc,
 				tmp_buf[i] = IXGBE_CPU_TO_LE32(tmp_buf[i]);
 			}
 			memcpy(buf, tmp_buf, buf_size);
+			ixgbe_aci_debug(hw, (void *)raw_desc, tmp_buf,
+					(u16)tmp_buf_size);
 		}
 	} while (0);
 
diff --git a/drivers/net/intel/ixgbe/base/ixgbe_e610.h b/drivers/net/intel/ixgbe/base/ixgbe_e610.h
index f60268cf91..e950f89e80 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_e610.h
+++ b/drivers/net/intel/ixgbe/base/ixgbe_e610.h
@@ -10,6 +10,8 @@
 void ixgbe_init_aci(struct ixgbe_hw *hw);
 void ixgbe_shutdown_aci(struct ixgbe_hw *hw);
 
+void ixgbe_aci_debug(struct ixgbe_hw *hw, void *desc, void *buf, u16 buf_len);
+
 s32 ixgbe_aci_send_cmd(struct ixgbe_hw *hw, struct ixgbe_aci_desc *desc,
 		       void *buf, u16 buf_size);
 bool ixgbe_aci_check_event_pending(struct ixgbe_hw *hw);
diff --git a/drivers/net/intel/ixgbe/base/ixgbe_osdep.h b/drivers/net/intel/ixgbe/base/ixgbe_osdep.h
index 53d0422193..4dfed02137 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_osdep.h
+++ b/drivers/net/intel/ixgbe/base/ixgbe_osdep.h
@@ -39,6 +39,7 @@
 #define DEBUGOUT1(S, ...)       DEBUGOUT(S, ##__VA_ARGS__)
 #define DEBUGOUT2(S, ...)       DEBUGOUT(S, ##__VA_ARGS__)
 #define DEBUGOUT3(S, ...)       DEBUGOUT(S, ##__VA_ARGS__)
+#define DEBUGOUT4(S, ...)       DEBUGOUT(S, ##__VA_ARGS__)
 #define DEBUGOUT6(S, ...)       DEBUGOUT(S, ##__VA_ARGS__)
 #define DEBUGOUT7(S, ...)       DEBUGOUT(S, ##__VA_ARGS__)
 
diff --git a/drivers/net/intel/ixgbe/base/ixgbe_type_e610.h b/drivers/net/intel/ixgbe/base/ixgbe_type_e610.h
index e804172252..9348294735 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_type_e610.h
+++ b/drivers/net/intel/ixgbe/base/ixgbe_type_e610.h
@@ -361,6 +361,7 @@
 #define IXGBE_ACI_DESC_COOKIE_L_DWORD_OFFSET	3
 #define IXGBE_ACI_SEND_DELAY_TIME_MS		10
 #define IXGBE_ACI_SEND_MAX_EXECUTE		3
+#define IXGBE_ACI_MAX_DEBUG_STRING_LENGTH	128
 /* [ms] timeout of waiting for sync response */
 #define IXGBE_ACI_SYNC_RESPONSE_TIMEOUT		100000
 /* [ms] timeout of waiting for async response */
-- 
2.47.1

