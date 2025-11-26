Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38988D10397
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 08:57:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F323406FF;
	Wed, 26 Nov 2025 09:57:12 +0100 (CET)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 0BA36406BB
 for <dev@dpdk.org>; Wed, 26 Nov 2025 09:57:07 +0100 (CET)
X-QQ-mid: zesmtpgz5t1764147419t0b00dd4e
X-QQ-Originating-IP: XcOKpkbGKgUIl8n0tQY/x2BfM6RzNqqdyP4hirINWuA=
Received: from w-MS-7E16.trustnetic.com ( [36.20.107.59])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 26 Nov 2025 16:56:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17449370470882606608
EX-QQ-RecipientCnt: 3
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2] net/txgbe: fix the missing old mailbox interface calls
Date: Wed, 26 Nov 2025 16:56:49 +0800
Message-ID: <9E296F0580980C92+20251126085649.8665-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <A4E8D8476CBBC191+20251119085624.73210-1-jiawenwu@trustnetic.com>
References: <A4E8D8476CBBC191+20251119085624.73210-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NVJQPJyT+vHWG+kMHjmo5RqAJ4RvG7xOJ/3nep3aVghmoAxC7WOuKA09
 oHOsvxKexwWGE4Y8nSgZ5V8h5fx+GW6H52ljeTaHdzpBrhlGmLNiv8ruRAtO+yTmA/CVcLr
 wuLdHsILYCk1xXEY+qrydGq5xLN4ihPrLQ9gzxxLtRu2IIeBb45MyVHTa/WSbrFYR8vvWqy
 /LJzMeBCYK6EVWGJztfquN7CfaNIeKOVxc8KP/okSNt0Tf/ZtY4c3llyhlPE0qIzwA5MkQJ
 Zhkwyqp6ETpwt5DbhumY8QmgcsbnFjFsNoA2UhZC/mpAvsHHJo1rfL2mQ4EzSez9w2D9+A9
 oLMN8y7+/aEtZYtLs07V+DJIzbCCqkN+f3tv3DN9HPdjFRsnQsg8jWcTQy7YJYvYkGhUcEL
 bApRT10uF3XiZ4gisR/3L7ifrqje97/lCBZf5BHaDB9Z4EbwOE54Fp2zPeSCJN/n3BrC5KO
 qaD6M6ZNTAus0HIITGVZf5yV2EvNIicPeBeOHgIeNU4zNiOUMhRXdJm5NKFDYtB6DnrAGZs
 WJjdY5aB9el/v2RowH4mujmM4+Vi0CmGFAzE3Q+0kDewzVzHjswNooTE8VvWA8OWBbJGJLM
 5ljclHA1g+r9hhasxoGkCEVTLdm7diavhvyr39ro/W4ixSFBM1flvI566Luu4AdGCY/odO2
 3jKLj3bYjMpshOsU/bYSdVqsu/pH84JqTJra13XnkKelficBTVWy3ABbcDJffmSQaBCQydh
 hvI4nLvlwbX0xtThWzVjC6SwcggtPezi8sGCeLgYE0iNUOToOw6PZCTK7f+o64TkPzQ689Z
 BT43/PeobtZdjROqyhIqQFC+n5zIhQjaxvXifrLyszfRjz+3I6hzm0EGSZ1hnKfB0UXJT87
 lZJraIH9mZ6BW6Z9P4vLIwgSd4fN4KgwYPph24HYQOy2xNTjE0qgXAB5aLFzXflwqMbudii
 xCCNshMeCQrvOFT2Rqt8J06jwifnIpUJmXHVKRl2z8V0F86I3uBhGFGTVuMu37bXvOmep3p
 kdYUbWYDlQ/pxHs0GE5RxAW4umVeK17c4Vsqg+wg==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
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

For different devices, the mailbox flow between software and firmware is
different. There are several mailbox command in the txgbe driver, but only
txgbe_hic_sr_read() was changed to use the new flow.

It lead to other mailbox commands timeout for Amber-Lite devices, which
is required to use the new flow. So this patch fills in the missing part.

For the sake of code tidy, txgbe_hic_sr_read() should change to use the
locked function txgbe_host_interface_command(), and this function could
be change to pointer in struct txgbe_mbx_info for different devices.

Fixes: 6a139ade82e7 ("net/txgbe: add new SW-FW mailbox interface")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml.c    |  4 ++++
 drivers/net/txgbe/base/txgbe_aml40.c  |  4 ++++
 drivers/net/txgbe/base/txgbe_eeprom.c | 16 +++++++-------
 drivers/net/txgbe/base/txgbe_hw.c     |  4 ++++
 drivers/net/txgbe/base/txgbe_mng.c    | 32 ++++++++++++---------------
 drivers/net/txgbe/base/txgbe_mng.h    |  4 ++++
 drivers/net/txgbe/base/txgbe_type.h   |  2 ++
 7 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml.c b/drivers/net/txgbe/base/txgbe_aml.c
index 867cf4c2d3..b376eca5b5 100644
--- a/drivers/net/txgbe/base/txgbe_aml.c
+++ b/drivers/net/txgbe/base/txgbe_aml.c
@@ -17,6 +17,7 @@ void txgbe_init_ops_aml(struct txgbe_hw *hw)
 {
 	struct txgbe_mac_info *mac = &hw->mac;
 	struct txgbe_phy_info *phy = &hw->phy;
+	struct txgbe_mbx_info *mbx = &hw->mbx;
 
 	txgbe_init_ops_generic(hw);
 
@@ -27,6 +28,9 @@ void txgbe_init_ops_aml(struct txgbe_hw *hw)
 	mac->init_mac_link_ops = txgbe_init_mac_link_ops_aml;
 	mac->get_link_capabilities = txgbe_get_link_capabilities_aml;
 	mac->check_link = txgbe_check_mac_link_aml;
+
+	/* FW interaction */
+	mbx->host_interface_command = txgbe_host_interface_command_aml;
 }
 
 s32 txgbe_check_mac_link_aml(struct txgbe_hw *hw, u32 *speed,
diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index c7d64cade6..733bbac13a 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -18,6 +18,7 @@ void txgbe_init_ops_aml40(struct txgbe_hw *hw)
 {
 	struct txgbe_mac_info *mac = &hw->mac;
 	struct txgbe_phy_info *phy = &hw->phy;
+	struct txgbe_mbx_info *mbx = &hw->mbx;
 
 	txgbe_init_ops_generic(hw);
 
@@ -28,6 +29,9 @@ void txgbe_init_ops_aml40(struct txgbe_hw *hw)
 	mac->init_mac_link_ops = txgbe_init_mac_link_ops_aml40;
 	mac->get_link_capabilities = txgbe_get_link_capabilities_aml40;
 	mac->check_link = txgbe_check_mac_link_aml40;
+
+	/* FW interaction */
+	mbx->host_interface_command = txgbe_host_interface_command_aml;
 }
 
 s32 txgbe_check_mac_link_aml40(struct txgbe_hw *hw, u32 *speed,
diff --git a/drivers/net/txgbe/base/txgbe_eeprom.c b/drivers/net/txgbe/base/txgbe_eeprom.c
index eb53b35a19..b1d90f6f6b 100644
--- a/drivers/net/txgbe/base/txgbe_eeprom.c
+++ b/drivers/net/txgbe/base/txgbe_eeprom.c
@@ -137,7 +137,7 @@ void txgbe_release_eeprom_semaphore(struct txgbe_hw *hw)
 s32 txgbe_ee_read16(struct txgbe_hw *hw, u32 offset,
 			      u16 *data)
 {
-	const u32 mask = TXGBE_MNGSEM_SWMBX | TXGBE_MNGSEM_SWFLASH;
+	const u32 mask = TXGBE_MNGSEM_SWFLASH;
 	u32 addr = (offset << 1);
 	int err;
 
@@ -164,7 +164,7 @@ s32 txgbe_ee_read16(struct txgbe_hw *hw, u32 offset,
 s32 txgbe_ee_readw_buffer(struct txgbe_hw *hw,
 				     u32 offset, u32 words, void *data)
 {
-	const u32 mask = TXGBE_MNGSEM_SWMBX | TXGBE_MNGSEM_SWFLASH;
+	const u32 mask = TXGBE_MNGSEM_SWFLASH;
 	u32 addr = (offset << 1);
 	u32 len = (words << 1);
 	u8 *buf = (u8 *)data;
@@ -195,7 +195,7 @@ s32 txgbe_ee_readw_buffer(struct txgbe_hw *hw,
 s32 txgbe_ee_readw_sw(struct txgbe_hw *hw, u32 offset,
 			      u16 *data)
 {
-	const u32 mask = TXGBE_MNGSEM_SWMBX | TXGBE_MNGSEM_SWFLASH;
+	const u32 mask = TXGBE_MNGSEM_SWFLASH;
 	u32 addr = hw->rom.sw_addr + (offset << 1);
 	int err;
 
@@ -220,7 +220,7 @@ s32 txgbe_ee_readw_sw(struct txgbe_hw *hw, u32 offset,
  **/
 s32 txgbe_ee_read32(struct txgbe_hw *hw, u32 addr, u32 *data)
 {
-	const u32 mask = TXGBE_MNGSEM_SWMBX | TXGBE_MNGSEM_SWFLASH;
+	const u32 mask = TXGBE_MNGSEM_SWFLASH;
 	int err;
 
 	err = hw->mac.acquire_swfw_sync(hw, mask);
@@ -245,7 +245,7 @@ s32 txgbe_ee_read32(struct txgbe_hw *hw, u32 addr, u32 *data)
 s32 txgbe_ee_write16(struct txgbe_hw *hw, u32 offset,
 			       u16 data)
 {
-	const u32 mask = TXGBE_MNGSEM_SWMBX | TXGBE_MNGSEM_SWFLASH;
+	const u32 mask = TXGBE_MNGSEM_SWFLASH;
 	u32 addr = (offset << 1);
 	int err;
 
@@ -272,7 +272,7 @@ s32 txgbe_ee_write16(struct txgbe_hw *hw, u32 offset,
 s32 txgbe_ee_writew_buffer(struct txgbe_hw *hw,
 				      u32 offset, u32 words, void *data)
 {
-	const u32 mask = TXGBE_MNGSEM_SWMBX | TXGBE_MNGSEM_SWFLASH;
+	const u32 mask = TXGBE_MNGSEM_SWFLASH;
 	u32 addr = (offset << 1);
 	u32 len = (words << 1);
 	u8 *buf = (u8 *)data;
@@ -301,7 +301,7 @@ s32 txgbe_ee_writew_buffer(struct txgbe_hw *hw,
 s32 txgbe_ee_writew_sw(struct txgbe_hw *hw, u32 offset,
 			       u16 data)
 {
-	const u32 mask = TXGBE_MNGSEM_SWMBX | TXGBE_MNGSEM_SWFLASH;
+	const u32 mask = TXGBE_MNGSEM_SWFLASH;
 	u32 addr = hw->rom.sw_addr + (offset << 1);
 	int err;
 
@@ -326,7 +326,7 @@ s32 txgbe_ee_writew_sw(struct txgbe_hw *hw, u32 offset,
  **/
 s32 txgbe_ee_write32(struct txgbe_hw *hw, u32 addr, u32 data)
 {
-	const u32 mask = TXGBE_MNGSEM_SWMBX | TXGBE_MNGSEM_SWFLASH;
+	const u32 mask = TXGBE_MNGSEM_SWFLASH;
 	int err;
 
 	err = hw->mac.acquire_swfw_sync(hw, mask);
diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 5017886896..0f3db3a1ad 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -2998,6 +2998,7 @@ void txgbe_init_ops_sp(struct txgbe_hw *hw)
 {
 	struct txgbe_mac_info *mac = &hw->mac;
 	struct txgbe_phy_info *phy = &hw->phy;
+	struct txgbe_mbx_info *mbx = &hw->mbx;
 
 	txgbe_init_ops_generic(hw);
 
@@ -3008,6 +3009,9 @@ void txgbe_init_ops_sp(struct txgbe_hw *hw)
 	mac->init_mac_link_ops = txgbe_init_mac_link_ops_sp;
 	mac->get_link_capabilities = txgbe_get_link_capabilities_sp;
 	mac->check_link = txgbe_check_mac_link_sp;
+
+	/* FW interaction */
+	mbx->host_interface_command = txgbe_host_interface_command_sp;
 }
 
 /**
diff --git a/drivers/net/txgbe/base/txgbe_mng.c b/drivers/net/txgbe/base/txgbe_mng.c
index 05eb07c0e2..a1974820b6 100644
--- a/drivers/net/txgbe/base/txgbe_mng.c
+++ b/drivers/net/txgbe/base/txgbe_mng.c
@@ -79,7 +79,7 @@ txgbe_hic_unlocked(struct txgbe_hw *hw, u32 *buffer, u32 length, u32 timeout)
 }
 
 /**
- *  txgbe_host_interface_command - Issue command to manageability block
+ *  txgbe_host_interface_command_sp - Issue command to manageability block
  *  @hw: pointer to the HW structure
  *  @buffer: contains the command to write and where the return status will
  *   be placed
@@ -96,9 +96,9 @@ txgbe_hic_unlocked(struct txgbe_hw *hw, u32 *buffer, u32 length, u32 timeout)
  *  else returns semaphore error when encountering an error acquiring
  *  semaphore or TXGBE_ERR_HOST_INTERFACE_COMMAND when command fails.
  **/
-static s32
-txgbe_host_interface_command(struct txgbe_hw *hw, u32 *buffer,
-				 u32 length, u32 timeout, bool return_data)
+s32
+txgbe_host_interface_command_sp(struct txgbe_hw *hw, u32 *buffer,
+				u32 length, u32 timeout, bool return_data)
 {
 	u32 hdr_size = sizeof(struct txgbe_hic_hdr);
 	struct txgbe_hic_hdr *resp = (struct txgbe_hic_hdr *)buffer;
@@ -160,7 +160,7 @@ txgbe_host_interface_command(struct txgbe_hw *hw, u32 *buffer,
 	return err;
 }
 
-static s32
+s32
 txgbe_host_interface_command_aml(struct txgbe_hw *hw, u32 *buffer,
 				 u32 length, u32 timeout, bool return_data)
 {
@@ -303,12 +303,8 @@ s32 txgbe_hic_sr_read(struct txgbe_hw *hw, u32 addr, u8 *buf, int len)
 	command.address = cpu_to_be32(addr);
 	command.length = cpu_to_be16(len);
 
-	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
-		err = txgbe_host_interface_command_aml(hw, (u32 *)&command,
-				sizeof(command), TXGBE_HI_COMMAND_TIMEOUT, false);
-	else
-		err = txgbe_hic_unlocked(hw, (u32 *)&command,
-				sizeof(command), TXGBE_HI_COMMAND_TIMEOUT);
+	err = hw->mbx.host_interface_command(hw, (u32 *)&command,
+			sizeof(command), TXGBE_HI_COMMAND_TIMEOUT, false);
 	if (err)
 		return err;
 
@@ -381,7 +377,7 @@ s32 txgbe_close_notify(struct txgbe_hw *hw)
 	buffer.length = 0;
 	buffer.address = 0;
 
-	status = txgbe_host_interface_command(hw, (u32 *)&buffer,
+	status = hw->mbx.host_interface_command(hw, (u32 *)&buffer,
 					      sizeof(buffer),
 					      TXGBE_HI_COMMAND_TIMEOUT, false);
 	if (status)
@@ -411,7 +407,7 @@ s32 txgbe_open_notify(struct txgbe_hw *hw)
 	buffer.length = 0;
 	buffer.address = 0;
 
-	status = txgbe_host_interface_command(hw, (u32 *)&buffer,
+	status = hw->mbx.host_interface_command(hw, (u32 *)&buffer,
 					      sizeof(buffer),
 					      TXGBE_HI_COMMAND_TIMEOUT, false);
 	if (status)
@@ -466,7 +462,7 @@ s32 txgbe_hic_set_drv_ver(struct txgbe_hw *hw, u8 maj, u8 min,
 				(FW_CEM_HDR_LEN + fw_cmd.hdr.buf_len));
 
 	for (i = 0; i <= FW_CEM_MAX_RETRIES; i++) {
-		ret_val = txgbe_host_interface_command(hw, (u32 *)&fw_cmd,
+		ret_val = hw->mbx.host_interface_command(hw, (u32 *)&fw_cmd,
 						       sizeof(fw_cmd),
 						       TXGBE_HI_COMMAND_TIMEOUT,
 						       true);
@@ -511,7 +507,7 @@ txgbe_hic_reset(struct txgbe_hw *hw)
 				(FW_CEM_HDR_LEN + reset_cmd.hdr.buf_len));
 
 	for (i = 0; i <= FW_CEM_MAX_RETRIES; i++) {
-		err = txgbe_host_interface_command(hw, (u32 *)&reset_cmd,
+		err = hw->mbx.host_interface_command(hw, (u32 *)&reset_cmd,
 						       sizeof(reset_cmd),
 						       TXGBE_HI_COMMAND_TIMEOUT,
 						       true);
@@ -568,7 +564,7 @@ s32 txgbe_hic_get_lldp(struct txgbe_hw *hw)
 	buffer.hdr.checksum = FW_DEFAULT_CHECKSUM;
 	buffer.func = hw->bus.lan_id;
 
-	err = txgbe_host_interface_command(hw, (u32 *)&buffer, sizeof(buffer),
+	err = hw->mbx.host_interface_command(hw, (u32 *)&buffer, sizeof(buffer),
 					   TXGBE_HI_COMMAND_TIMEOUT, true);
 	if (err)
 		return err;
@@ -599,7 +595,7 @@ s32 txgbe_hic_set_lldp(struct txgbe_hw *hw, bool on)
 	buffer.hdr.checksum = FW_DEFAULT_CHECKSUM;
 	buffer.func = hw->bus.lan_id;
 
-	return txgbe_host_interface_command(hw, (u32 *)&buffer, sizeof(buffer),
+	return hw->mbx.host_interface_command(hw, (u32 *)&buffer, sizeof(buffer),
 					    TXGBE_HI_COMMAND_TIMEOUT, false);
 }
 
@@ -619,7 +615,7 @@ s32 txgbe_hic_ephy_set_link(struct txgbe_hw *hw, u8 speed, u8 autoneg, u8 duplex
 	buffer.duplex = duplex;
 
 	for (i = 0; i <= FW_CEM_MAX_RETRIES; i++) {
-		status = txgbe_host_interface_command(hw, (u32 *)&buffer,
+		status = hw->mbx.host_interface_command(hw, (u32 *)&buffer,
 						      sizeof(buffer),
 						      TXGBE_HI_COMMAND_TIMEOUT_SHORT, true);
 		if (status != 0) {
diff --git a/drivers/net/txgbe/base/txgbe_mng.h b/drivers/net/txgbe/base/txgbe_mng.h
index 53c5cd5487..da5efecefd 100644
--- a/drivers/net/txgbe/base/txgbe_mng.h
+++ b/drivers/net/txgbe/base/txgbe_mng.h
@@ -208,6 +208,10 @@ struct txgbe_hic_write_lldp {
 	u16 pad3;
 };
 
+s32 txgbe_host_interface_command_sp(struct txgbe_hw *hw, u32 *buffer,
+				u32 length, u32 timeout, bool return_data);
+s32 txgbe_host_interface_command_aml(struct txgbe_hw *hw, u32 *buffer,
+				u32 length, u32 timeout, bool return_data);
 s32 txgbe_hic_sr_read(struct txgbe_hw *hw, u32 addr, u8 *buf, int len);
 s32 txgbe_hic_sr_write(struct txgbe_hw *hw, u32 addr, u8 *buf, int len);
 s32 txgbe_close_notify(struct txgbe_hw *hw);
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index b5dbc9b755..ede780321f 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -786,6 +786,8 @@ struct txgbe_mbx_info {
 	s32  (*check_for_msg)(struct txgbe_hw *hw, u16 mbx_id);
 	s32  (*check_for_ack)(struct txgbe_hw *hw, u16 mbx_id);
 	s32  (*check_for_rst)(struct txgbe_hw *hw, u16 mbx_id);
+	s32  (*host_interface_command)(struct txgbe_hw *hw, u32 *buffer,
+				u32 length, u32 timeout, bool return_data);
 
 	struct txgbe_mbx_stats stats;
 	u32 timeout;
-- 
2.48.1

