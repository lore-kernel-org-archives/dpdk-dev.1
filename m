Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBC7CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 14:52:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18C644067B;
	Tue, 19 May 2026 16:52:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 7201D4025E;
 Tue, 19 May 2026 16:52:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779202364; x=1810738364;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hKH8sVaEcpWA/ETIqpEBr/YwS0anvx+G8tb09ED3Wyc=;
 b=Wwiu7Zlu7tiNNcP6qduIUCn0oLkb6aHt5Ynn672v4qqf6lDFftkkJHFV
 uY6oGy0e2h+Z8CVDrdKDXG7BaHKZlV0LP/CN/1Z2VeVB/JpTq7meKM4e5
 RAhUa016Qp87CPAV5XbEkLjex1yzOtgE/bjxG8m5FOKt0+HMkoBK8lCVZ
 IG2yf38A7qnjOLQTmxC+blcZZ4hhzIpAYwjzHrICpmO7R/BQBHB5cICrY
 5pmTsk/BeZsKTXMvq4wy5FXzgWqsKmXH6aprkhDTm8ppz4oj8j2bWF4pJ
 QM6uihT1ra+ov8tHgkRwKUL8sJyaAmwBzxr/kFylFSiuteqKPgeLQys9g w==;
X-CSE-ConnectionGUID: uDMNsDf2RuqLf2x3oDRy6Q==
X-CSE-MsgGUID: X5pRaBKtSxWZBkgBupw70g==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="90383755"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="90383755"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 07:52:44 -0700
X-CSE-ConnectionGUID: DmvUdnTkThuhTo7t+R4LFQ==
X-CSE-MsgGUID: 8xh/c8hzSvmplMPo9l3aVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="238794387"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 19 May 2026 07:52:42 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Chinh Cao <chinh.t.cao@intel.com>, stable@dpdk.org,
 Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 1/3] net/i40e/base: fix integer overflow in NVM timing logic
Date: Tue, 19 May 2026 14:52:21 +0000
Message-ID: <20260519145227.308814-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519145227.308814-1-ciara.loftus@intel.com>
References: <20260519145227.308814-1-ciara.loftus@intel.com>
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

From: Chinh Cao <chinh.t.cao@intel.com>

Rename gtime to gtime_start/gtime_current with elapsed tracking
to avoid signed/unsigned comparison overflow. Widen sr_size from
u16 to u32 and NVM buffer offset parameters from u16 to u32.
Add helper get_elapsed_time() for wrap-safe timer arithmetic.

Fixes: c61390d94d46 ("net/i40e/base: make semaphore timeout 32-bit")
Fixes: cb593a832630 ("net/i40e/base: reduce size of time variables")
Fixes: 8db9e2a1b232 ("i40e: base driver")
Cc: stable@dpdk.org

Signed-off-by: Chinh Cao <chinh.t.cao@intel.com>
Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/base/i40e_nvm.c       | 67 +++++++++++++-------
 drivers/net/intel/i40e/base/i40e_prototype.h |  2 +-
 drivers/net/intel/i40e/base/i40e_type.h      |  2 +-
 drivers/net/intel/i40e/i40e_ethdev.c         |  3 +-
 4 files changed, 49 insertions(+), 25 deletions(-)

diff --git a/drivers/net/intel/i40e/base/i40e_nvm.c b/drivers/net/intel/i40e/base/i40e_nvm.c
index 00a207ca81..fd1a987c56 100644
--- a/drivers/net/intel/i40e/base/i40e_nvm.c
+++ b/drivers/net/intel/i40e/base/i40e_nvm.c
@@ -49,6 +49,20 @@ enum i40e_status_code i40e_init_nvm(struct i40e_hw *hw)
 	return ret_code;
 }
 
+/**
+ * get_elapsed_time - Compute elapsed hardware timer ticks
+ * @from: The start timer value
+ * @to: The current timer value
+ *
+ * Returns the elapsed time as the difference between the current and start
+ * timer values. The subtraction is wrap-safe for unsigned 32-bit values,
+ * meaning it correctly handles timer wrap-around.
+ **/
+static u32 get_elapsed_time(u32 from, u32 to)
+{
+	return (u32)(to - from); /* wrap-safe */
+}
+
 /**
  * i40e_acquire_nvm - Generic request for acquiring the NVM ownership
  * @hw: pointer to the HW structure
@@ -61,7 +75,7 @@ enum i40e_status_code i40e_acquire_nvm(struct i40e_hw *hw,
 				       enum i40e_aq_resource_access_type access)
 {
 	enum i40e_status_code ret_code = I40E_SUCCESS;
-	u32 gtime, timeout;
+	u32 gtime_start, gtime_current, timeout, elapsed;
 	u32 time_left = 0;
 
 	DEBUGFUNC("i40e_acquire_nvm");
@@ -72,10 +86,12 @@ enum i40e_status_code i40e_acquire_nvm(struct i40e_hw *hw,
 	ret_code = i40e_aq_request_resource(hw, I40E_NVM_RESOURCE_ID, access,
 					    0, &time_left, NULL);
 	/* Reading the Global Device Timer */
-	gtime = rd32(hw, I40E_GLVFGEN_TIMER);
+	gtime_start = rd32(hw, I40E_GLVFGEN_TIMER);
+	gtime_current = gtime_start;
+	elapsed = 0;
 
 	/* Store the timeout */
-	hw->nvm.hw_semaphore_timeout = I40E_MS_TO_GTIME(time_left) + gtime;
+	hw->nvm.hw_semaphore_timeout = I40E_MS_TO_GTIME(time_left) + gtime_start;
 
 	if (ret_code)
 		i40e_debug(hw, I40E_DEBUG_NVM,
@@ -84,17 +100,20 @@ enum i40e_status_code i40e_acquire_nvm(struct i40e_hw *hw,
 
 	if (ret_code && time_left) {
 		/* Poll until the current NVM owner timeouts */
-		timeout = I40E_MS_TO_GTIME(I40E_MAX_NVM_TIMEOUT) + gtime;
-		while ((s32)(gtime - timeout) < 0 && time_left) {
+		timeout = I40E_MS_TO_GTIME(I40E_MAX_NVM_TIMEOUT);
+
+		while (elapsed < timeout && time_left) {
 			i40e_msec_delay(10);
-			gtime = rd32(hw, I40E_GLVFGEN_TIMER);
+			gtime_current = rd32(hw, I40E_GLVFGEN_TIMER);
+			elapsed = get_elapsed_time(gtime_start, gtime_current);
 			ret_code = i40e_aq_request_resource(hw,
 							I40E_NVM_RESOURCE_ID,
 							access, 0, &time_left,
 							NULL);
 			if (ret_code == I40E_SUCCESS) {
 				hw->nvm.hw_semaphore_timeout =
-					    I40E_MS_TO_GTIME(time_left) + gtime;
+					I40E_MS_TO_GTIME(time_left) +
+					gtime_current;
 				break;
 			}
 		}
@@ -110,7 +129,6 @@ enum i40e_status_code i40e_acquire_nvm(struct i40e_hw *hw,
 	return ret_code;
 }
 
-
 /**
  * i40e_acquire_nvm_ex - Specific request only for
  * OID_INTEL_FLASH_INFO_TIMEOUT for acquiring the NVM ownership
@@ -121,13 +139,12 @@ enum i40e_status_code i40e_acquire_nvm(struct i40e_hw *hw,
  * This function will request NVM ownership for reading
  * via the proper Admin Command.
  **/
-
 enum i40e_status_code i40e_acquire_nvm_ex(struct i40e_hw *hw,
 				       enum i40e_aq_resource_access_type access,
 					   u32 custom_timeout)
 {
 	enum i40e_status_code ret_code = I40E_SUCCESS;
-	u32 gtime, timeout;
+	u32 gtime_start, gtime_current, timeout, elapsed;
 	u32 time_left = 0;
 
 	DEBUGFUNC("i40e_acquire_nvm");
@@ -138,10 +155,12 @@ enum i40e_status_code i40e_acquire_nvm_ex(struct i40e_hw *hw,
 	ret_code = i40e_aq_request_resource(hw, I40E_NVM_RESOURCE_ID, access,
 					    0, &time_left, NULL);
 	/* Reading the Global Device Timer */
-	gtime = rd32(hw, I40E_GLVFGEN_TIMER);
+	gtime_start = rd32(hw, I40E_GLVFGEN_TIMER);
+	gtime_current = gtime_start;
+	elapsed = 0;
 
 	/* Store the timeout */
-	hw->nvm.hw_semaphore_timeout = I40E_MS_TO_GTIME(time_left) + gtime;
+	hw->nvm.hw_semaphore_timeout = I40E_MS_TO_GTIME(time_left) + gtime_start;
 
 	if (ret_code)
 		i40e_debug(hw, I40E_DEBUG_NVM,
@@ -151,17 +170,20 @@ enum i40e_status_code i40e_acquire_nvm_ex(struct i40e_hw *hw,
 
 	if (ret_code && time_left) {
 		/* Poll until the current NVM owner timeouts */
-		timeout = I40E_MS_TO_GTIME(custom_timeout) + gtime;
-		while ((gtime < timeout) && time_left) {
+		timeout = I40E_MS_TO_GTIME(custom_timeout);
+
+		while (elapsed < timeout && time_left) {
 			i40e_msec_delay(10);
-			gtime = rd32(hw, I40E_GLVFGEN_TIMER);
+			gtime_current = rd32(hw, I40E_GLVFGEN_TIMER);
+			elapsed = get_elapsed_time(gtime_start, gtime_current);
 			ret_code = i40e_aq_request_resource(hw,
 							I40E_NVM_RESOURCE_ID,
 							access, 0, &time_left,
 							NULL);
 			if (ret_code == I40E_SUCCESS) {
 				hw->nvm.hw_semaphore_timeout =
-					    I40E_MS_TO_GTIME(time_left) + gtime;
+					I40E_MS_TO_GTIME(time_left) +
+					gtime_current;
 				break;
 			}
 		}
@@ -245,7 +267,7 @@ static enum i40e_status_code i40e_poll_sr_srctl_done_bit(struct i40e_hw *hw)
  * Reads one 16 bit word from the Shadow RAM using the GLNVM_SRCTL register.
  **/
 STATIC enum i40e_status_code i40e_read_nvm_word_srctl(struct i40e_hw *hw,
-						      u16 offset,
+						      u32 offset,
 						      u16 *data)
 {
 	enum i40e_status_code ret_code = I40E_ERR_TIMEOUT;
@@ -516,11 +538,12 @@ i40e_read_nvm_module_data(struct i40e_hw *hw, u8 module_ptr, u16 module_offset,
  * method. The buffer read is preceded by the NVM ownership take
  * and followed by the release.
  **/
-STATIC enum i40e_status_code i40e_read_nvm_buffer_srctl(struct i40e_hw *hw, u16 offset,
+STATIC enum i40e_status_code i40e_read_nvm_buffer_srctl(struct i40e_hw *hw, u32 offset,
 							u16 *words, u16 *data)
 {
 	enum i40e_status_code ret_code = I40E_SUCCESS;
-	u16 index, word;
+	u32 index;
+	u16 word;
 
 	DEBUGFUNC("i40e_read_nvm_buffer_srctl");
 
@@ -549,7 +572,7 @@ STATIC enum i40e_status_code i40e_read_nvm_buffer_srctl(struct i40e_hw *hw, u16
  * method. The buffer read is preceded by the NVM ownership take
  * and followed by the release.
  **/
-STATIC enum i40e_status_code i40e_read_nvm_buffer_aq(struct i40e_hw *hw, u16 offset,
+STATIC enum i40e_status_code i40e_read_nvm_buffer_aq(struct i40e_hw *hw, u32 offset,
 						     u16 *words, u16 *data)
 {
 	enum i40e_status_code ret_code;
@@ -608,7 +631,7 @@ STATIC enum i40e_status_code i40e_read_nvm_buffer_aq(struct i40e_hw *hw, u16 off
  * method.
  **/
 enum i40e_status_code __i40e_read_nvm_buffer(struct i40e_hw *hw,
-					     u16 offset,
+					     u32 offset,
 					     u16 *words, u16 *data)
 {
 	if (hw->flags & I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE)
@@ -767,7 +790,7 @@ enum i40e_status_code i40e_calc_nvm_checksum(struct i40e_hw *hw, u16 *checksum)
 	u16 checksum_local = 0;
 	u16 vpd_module = 0;
 	u16 *data;
-	u16 i = 0;
+	u32 i = 0;
 
 	DEBUGFUNC("i40e_calc_nvm_checksum");
 
diff --git a/drivers/net/intel/i40e/base/i40e_prototype.h b/drivers/net/intel/i40e/base/i40e_prototype.h
index e7e6d4c427..6f6bafa43c 100644
--- a/drivers/net/intel/i40e/base/i40e_prototype.h
+++ b/drivers/net/intel/i40e/base/i40e_prototype.h
@@ -482,7 +482,7 @@ enum i40e_status_code i40e_write_nvm_aq(struct i40e_hw *hw, u8 module,
 					bool last_command);
 enum i40e_status_code __i40e_read_nvm_word(struct i40e_hw *hw, u16 offset,
 					   u16 *data);
-enum i40e_status_code __i40e_read_nvm_buffer(struct i40e_hw *hw, u16 offset,
+enum i40e_status_code __i40e_read_nvm_buffer(struct i40e_hw *hw, u32 offset,
 					     u16 *words, u16 *data);
 enum i40e_status_code __i40e_write_nvm_word(struct i40e_hw *hw, u32 offset,
 					  void *data);
diff --git a/drivers/net/intel/i40e/base/i40e_type.h b/drivers/net/intel/i40e/base/i40e_type.h
index 968e1982a6..05a08b2057 100644
--- a/drivers/net/intel/i40e/base/i40e_type.h
+++ b/drivers/net/intel/i40e/base/i40e_type.h
@@ -449,7 +449,7 @@ enum i40e_aq_resource_access_type {
 struct i40e_nvm_info {
 	u32 hw_semaphore_timeout; /* usec global time (GTIME resolution) */
 	u32 timeout;              /* [ms] */
-	u16 sr_size;              /* Shadow RAM size in words */
+	u32 sr_size;              /* Shadow RAM size in words */
 	bool blank_nvm_mode;      /* is NVM empty (no FW present)*/
 	u16 version;              /* NVM package version */
 	u32 eetrack;              /* NVM data version */
diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 100a751225..13f3c23fef 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -11357,7 +11357,8 @@ static int i40e_get_eeprom(struct rte_eth_dev *dev,
 {
 	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	uint16_t *data = eeprom->data;
-	uint16_t offset, length, cnt_words;
+	uint32_t offset, length;
+	uint16_t cnt_words;
 	int ret_code;
 
 	offset = eeprom->offset >> 1;
-- 
2.43.0

