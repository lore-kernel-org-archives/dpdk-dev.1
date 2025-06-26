Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDAAC77B7F
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 08:09:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EAC440E5A;
	Thu, 26 Jun 2025 10:09:12 +0200 (CEST)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
 by mails.dpdk.org (Postfix) with ESMTP id 5B4B540E40
 for <dev@dpdk.org>; Thu, 26 Jun 2025 10:09:10 +0200 (CEST)
X-QQ-mid: zesmtpsz9t1750925345t8130fba6
X-QQ-Originating-IP: LDUlBqCHzI7/niz+nfSZD5gMPNg6C3P3NW/HVAPMQ2U=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.27.0.255])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 26 Jun 2025 16:08:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13593135842151500755
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v3 02/15] net/txgbe: add new SW-FW mailbox interface
Date: Thu, 26 Jun 2025 16:02:07 +0800
Message-Id: <20250626080221.22488-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250626080221.22488-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250626080221.22488-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OWduOkdEogk26zbDQkvs3rHDjmLVCqFUBNkQN0LpMYNiWG9QOAoR4yoR
 U0DGUHNdFBnbLnsRpWG+viY1i649z1V5Xz+0UIpC9Hz5JmSmNEIhPM7ZTe9vyjySmzgpql7
 FDmpe7gEJq1pRVIrawq0Or7yBNncGCHNzw0rvOq6ef2B4IeY8BzpbrbfeOochaHN95W3HCj
 LL4rOWQVtrCzfEZDxzm+3GU3t8V2fI9U9Ox2Sq0AQpfU3Un26azVyxG2rWAo/c/7s9kz/fo
 rGRe6XEQOcPz6hADxbgLfxkSsUmkbaDD/qGKy2fYFwfeyxkLNvNKI4/EKRvlC/QNpWhknYo
 mE8JECVVgy1OX32jBhzE2QMxduQrhcyWj0wlBGpN/i6dFsVNESgOCGyg5bLVBiSOH94S51c
 vCWFZsxLBuNFkQxpasn2ELykdUePgMNiaLDtPzusUMAotROadXdApEQ2DVGOBbOo5jhoFUA
 yR4meCtdnxzz1RUpi4EOamixdbOCEFZ96LYTu7r3d0XR64y8oEQJQ+53CvDQFcj5T7IZabx
 PwkeZc2kW6YKZe8F6CY0MxfMkfkP8zqXiloqnZGHo2EQ3U9WOj30J9UdvE0KwzUk4YszYPF
 P8eFwmwNatGvfyXeuMGOBS3nN+P6aXpLwpjx+VLoj/9DBhRqgABAd5iXsbEe2IP/grAd0ew
 suhnjEcc/VIf/gYj2mlILrD/W9PjH9/e85Hfi1jS2O0o4g12NBR+hS8Yk54thaWU5os06/C
 6xKhueXM7fpBDdfFCkcxSL/q5mkmkoIJSYLkVrC3BkIhUVVP9gOSOd1Zi7pMpnCS+NfxIPY
 lMBgpQ1o7BGzW8DB+wERoqvjtAnPfiimGl0kDN5ycVBvFnwbwC6HzSAVHBaQpaRd1adBleT
 jzOqXOCjfOfYugQ0aUKuaV5m1VvNotp+myaagMBLWZRGwEvAkfiWGDAPOgMrbZ93PRNQ0lH
 xFAN9kc5BlEMQuZb6qXP7psQjGy4ihZ01C4ljTsek1+NfjxpChaUFFP52S/xYsdUuRo9EEw
 w+v0xHptR0hmgmSPQNWDKOVf1KsaxVFo5bTJDWTme9z+cmwVwaRG53YLw8Gd4=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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

Amber-Lite NICs adopt new mailbox interface for software-firmware
interaion to enable enhanced functionality.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_eeprom.c |   7 +-
 drivers/net/txgbe/base/txgbe_eeprom.h |   2 +
 drivers/net/txgbe/base/txgbe_mng.c    | 216 +++++++++++++++++++-------
 drivers/net/txgbe/base/txgbe_mng.h    |  17 +-
 drivers/net/txgbe/base/txgbe_regs.h   |   7 +
 drivers/net/txgbe/base/txgbe_type.h   |   4 +
 6 files changed, 193 insertions(+), 60 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_eeprom.c b/drivers/net/txgbe/base/txgbe_eeprom.c
index aeeae06dfc..eb53b35a19 100644
--- a/drivers/net/txgbe/base/txgbe_eeprom.c
+++ b/drivers/net/txgbe/base/txgbe_eeprom.c
@@ -366,8 +366,13 @@ s32 txgbe_calc_eeprom_checksum(struct txgbe_hw *hw)
 		err = hw->rom.readw_buffer(hw, i, seg, buffer);
 		if (err)
 			return err;
-		for (j = 0; j < seg; j++)
+		for (j = 0; j < seg; j++) {
+			if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
+				if (((i + j) >= (TXGBE_SHOWROM_I2C_PTR / 2)) &&
+				    ((i + j) < (TXGBE_SHOWROM_I2C_END / 2)))
+					buffer[j] = 0xffff;
 			checksum += buffer[j];
+		}
 	}
 
 	checksum = (u16)TXGBE_EEPROM_SUM - checksum + read_checksum;
diff --git a/drivers/net/txgbe/base/txgbe_eeprom.h b/drivers/net/txgbe/base/txgbe_eeprom.h
index c10ad45ec8..26cc53ab42 100644
--- a/drivers/net/txgbe/base/txgbe_eeprom.h
+++ b/drivers/net/txgbe/base/txgbe_eeprom.h
@@ -20,6 +20,8 @@
 #define TXGBE_PBANUM0_PTR		0x05
 #define TXGBE_PBANUM1_PTR		0x06
 #define TXGBE_SW_REGION_PTR             0x1C
+#define TXGBE_SHOWROM_I2C_PTR		0xB00
+#define TXGBE_SHOWROM_I2C_END		0xF00
 
 #define TXGBE_EE_CSUM_MAX		0x800
 #define TXGBE_EEPROM_CHECKSUM		0x2F
diff --git a/drivers/net/txgbe/base/txgbe_mng.c b/drivers/net/txgbe/base/txgbe_mng.c
index 7dc8f21183..dd8dbcd4a8 100644
--- a/drivers/net/txgbe/base/txgbe_mng.c
+++ b/drivers/net/txgbe/base/txgbe_mng.c
@@ -45,17 +45,6 @@ txgbe_hic_unlocked(struct txgbe_hw *hw, u32 *buffer, u32 length, u32 timeout)
 	u32 value, loop;
 	u16 i, dword_len;
 
-	if (!length || length > TXGBE_PMMBX_BSIZE) {
-		DEBUGOUT("Buffer length failure buffersize=%d.", length);
-		return TXGBE_ERR_HOST_INTERFACE_COMMAND;
-	}
-
-	/* Calculate length in DWORDs. We must be DWORD aligned */
-	if (length % sizeof(u32)) {
-		DEBUGOUT("Buffer length failure, not aligned to dword");
-		return TXGBE_ERR_INVALID_ARGUMENT;
-	}
-
 	dword_len = length >> 2;
 
 	txgbe_flush(hw);
@@ -113,54 +102,148 @@ txgbe_host_interface_command(struct txgbe_hw *hw, u32 *buffer,
 {
 	u32 hdr_size = sizeof(struct txgbe_hic_hdr);
 	struct txgbe_hic_hdr *resp = (struct txgbe_hic_hdr *)buffer;
+	struct txgbe_hic_hdr *recv_hdr;
 	u16 buf_len;
-	s32 err;
-	u32 bi;
+	s32 err = 0;
+	u32 bi, i;
 	u32 dword_len;
+	u8 send_cmd;
 
 	if (length == 0 || length > TXGBE_PMMBX_BSIZE) {
 		DEBUGOUT("Buffer length failure buffersize=%d.", length);
 		return TXGBE_ERR_HOST_INTERFACE_COMMAND;
 	}
 
-	/* Take management host interface semaphore */
-	err = hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWMBX);
-	if (err)
-		return err;
+	/* Calculate length in DWORDs. We must be DWORD aligned */
+	if (length % sizeof(u32)) {
+		DEBUGOUT("Buffer length failure, not aligned to dword");
+		return TXGBE_ERR_INVALID_ARGUMENT;
+	}
 
-	err = txgbe_hic_unlocked(hw, buffer, length, timeout);
-	if (err)
-		goto rel_out;
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
+		/* try to get lock */
+		while (rte_atomic32_test_and_set(&hw->swfw_busy)) {
+			timeout--;
+			if (!timeout)
+				return TXGBE_ERR_TIMEOUT;
+			usec_delay(1000);
+		}
+
+		/* index to unique seq id for each mbox message */
+		resp->cksum_or_index.index = hw->swfw_index;
+		send_cmd = resp->cmd;
+
+		/* Calculate length in DWORDs */
+		dword_len = length >> 2;
+
+		/* write data to SW-FW mbox array */
+		for (i = 0; i < dword_len; i++) {
+			wr32a(hw, TXGBE_AML_MNG_MBOX_SW2FW,
+					i, rte_cpu_to_le_32(buffer[i]));
+			/* write flush */
+			rd32a(hw, TXGBE_AML_MNG_MBOX_SW2FW, i);
+		}
+
+		/* amlite: generate interrupt to notify FW */
+		wr32m(hw, TXGBE_AML_MNG_MBOX_CTL_SW2FW,
+				  TXGBE_AML_MNG_MBOX_NOTIFY, 0);
+		wr32m(hw, TXGBE_AML_MNG_MBOX_CTL_SW2FW,
+				  TXGBE_AML_MNG_MBOX_NOTIFY, TXGBE_AML_MNG_MBOX_NOTIFY);
+
+		/* Calculate length in DWORDs */
+		dword_len = hdr_size >> 2;
+
+		/* polling reply from FW */
+		timeout = 50;
+		do {
+			timeout--;
+			usec_delay(1000);
+
+			/* read hdr */
+			for (bi = 0; bi < dword_len; bi++)
+				buffer[bi] = rd32a(hw, TXGBE_AML_MNG_MBOX_FW2SW, bi);
+
+			/* check hdr */
+			recv_hdr = (struct txgbe_hic_hdr *)buffer;
+
+			if (recv_hdr->cmd == send_cmd &&
+			    recv_hdr->cksum_or_index.index == hw->swfw_index)
+				break;
+		} while (timeout);
+
+		if (!timeout) {
+			PMD_DRV_LOG(ERR, "Polling from FW messages timeout, cmd is 0x%x, index is %d",
+				send_cmd, hw->swfw_index);
+			err = TXGBE_ERR_TIMEOUT;
+			goto rel_out;
+		}
+
+		/* expect no reply from FW then return */
+		/* release lock if return */
+		if (!return_data)
+			goto rel_out;
+
+		/* If there is any thing in data position pull it in */
+		buf_len = recv_hdr->buf_len;
+		if (buf_len == 0)
+			goto rel_out;
+
+		if (length < buf_len + hdr_size) {
+			DEBUGOUT("Buffer not large enough for reply message.");
+			err = TXGBE_ERR_HOST_INTERFACE_COMMAND;
+			goto rel_out;
+		}
 
-	if (!return_data)
-		goto rel_out;
+		/* Calculate length in DWORDs, add 3 for odd lengths */
+		dword_len = (buf_len + 3) >> 2;
+		for (; bi <= dword_len; bi++)
+			buffer[bi] = rd32a(hw, TXGBE_AML_MNG_MBOX_FW2SW, bi);
+	} else {
+		/* Take management host interface semaphore */
+		err = hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWMBX);
+		if (err)
+			return err;
 
-	/* Calculate length in DWORDs */
-	dword_len = hdr_size >> 2;
+		err = txgbe_hic_unlocked(hw, buffer, length, timeout);
+		if (err)
+			goto rel_out;
 
-	/* first pull in the header so we know the buffer length */
-	for (bi = 0; bi < dword_len; bi++)
-		buffer[bi] = rd32a(hw, TXGBE_MNGMBX, bi);
+		if (!return_data)
+			goto rel_out;
 
-	buf_len = resp->buf_len;
-	if (!buf_len)
-		goto rel_out;
+		/* Calculate length in DWORDs */
+		dword_len = hdr_size >> 2;
 
-	if (length < buf_len + hdr_size) {
-		DEBUGOUT("Buffer not large enough for reply message.");
-		err = TXGBE_ERR_HOST_INTERFACE_COMMAND;
-		goto rel_out;
-	}
+		/* first pull in the header so we know the buffer length */
+		for (bi = 0; bi < dword_len; bi++)
+			buffer[bi] = rd32a(hw, TXGBE_MNGMBX, bi);
+
+		buf_len = resp->buf_len;
+		if (!buf_len)
+			goto rel_out;
 
-	/* Calculate length in DWORDs, add 3 for odd lengths */
-	dword_len = (buf_len + 3) >> 2;
+		if (length < buf_len + hdr_size) {
+			DEBUGOUT("Buffer not large enough for reply message.");
+			err = TXGBE_ERR_HOST_INTERFACE_COMMAND;
+			goto rel_out;
+		}
 
-	/* Pull in the rest of the buffer (bi is where we left off) */
-	for (; bi <= dword_len; bi++)
-		buffer[bi] = rd32a(hw, TXGBE_MNGMBX, bi);
+		/* Calculate length in DWORDs, add 3 for odd lengths */
+		dword_len = (buf_len + 3) >> 2;
 
+		/* Pull in the rest of the buffer (bi is where we left off) */
+		for (; bi <= dword_len; bi++)
+			buffer[bi] = rd32a(hw, TXGBE_MNGMBX, bi);
+	}
 rel_out:
-	hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWMBX);
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
+		/* index++, index replace txgbe_hic_hdr.checksum */
+		hw->swfw_index = resp->cksum_or_index.index == TXGBE_HIC_HDR_INDEX_MAX ?
+					  0 : resp->cksum_or_index.index + 1;
+		rte_atomic32_clear(&hw->swfw_busy);
+	} else {
+		hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWMBX);
+	}
 
 	return err;
 }
@@ -179,6 +262,12 @@ s32 txgbe_hic_sr_read(struct txgbe_hw *hw, u32 addr, u8 *buf, int len)
 	struct txgbe_hic_read_shadow_ram command;
 	u32 value;
 	int err, i = 0, j = 0;
+	u32 mngmbx_addr;
+
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
+		mngmbx_addr = TXGBE_AML_MNG_MBOX_FW2SW;
+	else
+		mngmbx_addr = TXGBE_MNGMBX;
 
 	if (len > TXGBE_PMMBX_DATA_SIZE)
 		return TXGBE_ERR_HOST_INTERFACE_COMMAND;
@@ -187,22 +276,27 @@ s32 txgbe_hic_sr_read(struct txgbe_hw *hw, u32 addr, u8 *buf, int len)
 	command.hdr.req.cmd = FW_READ_SHADOW_RAM_CMD;
 	command.hdr.req.buf_lenh = 0;
 	command.hdr.req.buf_lenl = FW_READ_SHADOW_RAM_LEN;
-	command.hdr.req.checksum = FW_DEFAULT_CHECKSUM;
 	command.address = cpu_to_be32(addr);
 	command.length = cpu_to_be16(len);
+	if (hw->mac.type == txgbe_mac_raptor)
+		command.hdr.req.cksum_or_index.checksum = FW_DEFAULT_CHECKSUM;
 
-	err = txgbe_hic_unlocked(hw, (u32 *)&command,
-			sizeof(command), TXGBE_HI_COMMAND_TIMEOUT);
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
+		err = txgbe_host_interface_command(hw, (u32 *)&command,
+				sizeof(command), TXGBE_HI_COMMAND_TIMEOUT, false);
+	else
+		err = txgbe_hic_unlocked(hw, (u32 *)&command,
+				sizeof(command), TXGBE_HI_COMMAND_TIMEOUT);
 	if (err)
 		return err;
 
 	while (i < (len >> 2)) {
-		value = rd32a(hw, TXGBE_MNGMBX, FW_NVM_DATA_OFFSET + i);
+		value = rd32a(hw, mngmbx_addr, FW_NVM_DATA_OFFSET + i);
 		((u32 *)buf)[i] = value;
 		i++;
 	}
 
-	value = rd32a(hw, TXGBE_MNGMBX, FW_NVM_DATA_OFFSET + i);
+	value = rd32a(hw, mngmbx_addr, FW_NVM_DATA_OFFSET + i);
 	for (i <<= 2; i < len; i++)
 		((u8 *)buf)[i] = ((u8 *)&value)[j++];
 
@@ -230,9 +324,10 @@ s32 txgbe_hic_sr_write(struct txgbe_hw *hw, u32 addr, u8 *buf, int len)
 	command.hdr.req.cmd = FW_WRITE_SHADOW_RAM_CMD;
 	command.hdr.req.buf_lenh = 0;
 	command.hdr.req.buf_lenl = FW_WRITE_SHADOW_RAM_LEN;
-	command.hdr.req.checksum = FW_DEFAULT_CHECKSUM;
 	command.address = cpu_to_be32(addr);
 	command.length = cpu_to_be16(len);
+	if (hw->mac.type == txgbe_mac_raptor)
+		command.hdr.req.cksum_or_index.checksum = FW_DEFAULT_CHECKSUM;
 
 	while (i < (len >> 2)) {
 		value = ((u32 *)buf)[i];
@@ -259,7 +354,8 @@ s32 txgbe_close_notify(struct txgbe_hw *hw)
 	buffer.hdr.req.cmd = FW_DW_CLOSE_NOTIFY;
 	buffer.hdr.req.buf_lenh = 0;
 	buffer.hdr.req.buf_lenl = 0;
-	buffer.hdr.req.checksum = FW_DEFAULT_CHECKSUM;
+	if (hw->mac.type == txgbe_mac_raptor)
+		buffer.hdr.req.cksum_or_index.checksum = FW_DEFAULT_CHECKSUM;
 
 	/* one word */
 	buffer.length = 0;
@@ -289,7 +385,8 @@ s32 txgbe_open_notify(struct txgbe_hw *hw)
 	buffer.hdr.req.cmd = FW_DW_OPEN_NOTIFY;
 	buffer.hdr.req.buf_lenh = 0;
 	buffer.hdr.req.buf_lenl = 0;
-	buffer.hdr.req.checksum = FW_DEFAULT_CHECKSUM;
+	if (hw->mac.type == txgbe_mac_raptor)
+		buffer.hdr.req.cksum_or_index.checksum = FW_DEFAULT_CHECKSUM;
 
 	/* one word */
 	buffer.length = 0;
@@ -343,11 +440,14 @@ s32 txgbe_hic_set_drv_ver(struct txgbe_hw *hw, u8 maj, u8 min,
 	fw_cmd.ver_min = min;
 	fw_cmd.ver_build = build;
 	fw_cmd.ver_sub = sub;
-	fw_cmd.hdr.checksum = 0;
 	fw_cmd.pad = 0;
 	fw_cmd.pad2 = 0;
-	fw_cmd.hdr.checksum = txgbe_calculate_checksum((u8 *)&fw_cmd,
+	if (hw->mac.type == txgbe_mac_raptor) {
+		fw_cmd.hdr.cksum_or_index.checksum = 0;
+		fw_cmd.hdr.cksum_or_index.checksum = txgbe_calculate_checksum((u8 *)&fw_cmd,
 				(FW_CEM_HDR_LEN + fw_cmd.hdr.buf_len));
+	}
+
 
 	for (i = 0; i <= FW_CEM_MAX_RETRIES; i++) {
 		ret_val = txgbe_host_interface_command(hw, (u32 *)&fw_cmd,
@@ -390,9 +490,11 @@ txgbe_hic_reset(struct txgbe_hw *hw)
 	reset_cmd.hdr.cmd_or_resp.cmd_resv = FW_CEM_CMD_RESERVED;
 	reset_cmd.lan_id = hw->bus.lan_id;
 	reset_cmd.reset_type = (u16)hw->reset_type;
-	reset_cmd.hdr.checksum = 0;
-	reset_cmd.hdr.checksum = txgbe_calculate_checksum((u8 *)&reset_cmd,
-				(FW_CEM_HDR_LEN + reset_cmd.hdr.buf_len));
+	if (hw->mac.type == txgbe_mac_raptor) {
+		reset_cmd.hdr.cksum_or_index.checksum = 0;
+		reset_cmd.hdr.cksum_or_index.checksum = txgbe_calculate_checksum((u8 *)&reset_cmd,
+					(FW_CEM_HDR_LEN + reset_cmd.hdr.buf_len));
+	}
 
 	for (i = 0; i <= FW_CEM_MAX_RETRIES; i++) {
 		err = txgbe_host_interface_command(hw, (u32 *)&reset_cmd,
@@ -449,7 +551,8 @@ s32 txgbe_hic_get_lldp(struct txgbe_hw *hw)
 	buffer.hdr.cmd = FW_LLDP_GET_CMD;
 	buffer.hdr.buf_len = 0x1;
 	buffer.hdr.cmd_or_resp.cmd_resv = FW_CEM_CMD_RESERVED;
-	buffer.hdr.checksum = FW_DEFAULT_CHECKSUM;
+	if (hw->mac.type == txgbe_mac_raptor)
+		buffer.hdr.cksum_or_index.checksum = FW_DEFAULT_CHECKSUM;
 	buffer.func = hw->bus.lan_id;
 
 	err = txgbe_host_interface_command(hw, (u32 *)&buffer, sizeof(buffer),
@@ -480,7 +583,8 @@ s32 txgbe_hic_set_lldp(struct txgbe_hw *hw, bool on)
 		buffer.hdr.cmd = FW_LLDP_SET_CMD_OFF;
 	buffer.hdr.buf_len = 0x1;
 	buffer.hdr.cmd_or_resp.cmd_resv = FW_CEM_CMD_RESERVED;
-	buffer.hdr.checksum = FW_DEFAULT_CHECKSUM;
+	if (hw->mac.type == txgbe_mac_raptor)
+		buffer.hdr.cksum_or_index.checksum = FW_DEFAULT_CHECKSUM;
 	buffer.func = hw->bus.lan_id;
 
 	return txgbe_host_interface_command(hw, (u32 *)&buffer, sizeof(buffer),
diff --git a/drivers/net/txgbe/base/txgbe_mng.h b/drivers/net/txgbe/base/txgbe_mng.h
index 16775862d6..5300970912 100644
--- a/drivers/net/txgbe/base/txgbe_mng.h
+++ b/drivers/net/txgbe/base/txgbe_mng.h
@@ -60,6 +60,8 @@
 #define TXGBE_CHECKSUM_CAP_ST_PASS      0x80658383
 #define TXGBE_CHECKSUM_CAP_ST_FAIL      0x70657376
 
+#define TXGBE_HIC_HDR_INDEX_MAX         255
+
 /* Host Interface Command Structures */
 struct txgbe_hic_hdr {
 	u8 cmd;
@@ -68,21 +70,30 @@ struct txgbe_hic_hdr {
 		u8 cmd_resv;
 		u8 ret_status;
 	} cmd_or_resp;
-	u8 checksum;
+	union {
+		u8 checksum;
+		u8 index;
+	} cksum_or_index;
 };
 
 struct txgbe_hic_hdr2_req {
 	u8 cmd;
 	u8 buf_lenh;
 	u8 buf_lenl;
-	u8 checksum;
+	union {
+		u8 checksum;
+		u8 index;
+	} cksum_or_index;
 };
 
 struct txgbe_hic_hdr2_rsp {
 	u8 cmd;
 	u8 buf_lenl;
 	u8 buf_lenh_status;     /* 7-5: high bits of buf_len, 4-0: status */
-	u8 checksum;
+	union {
+		u8 checksum;
+		u8 index;
+	} cksum_or_index;
 };
 
 union txgbe_hic_hdr2 {
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index a27860ac84..a608206f28 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -263,6 +263,13 @@
 #define   TXGBE_MNGMBXCTL_FWACK    MS(3, 0x1)
 #define TXGBE_MNGMBX               0x01E100
 
+/* amlite: swfw mailbox changes */
+#define TXGBE_AML_MNG_MBOX_CTL_SW2FW    0x01E0A0
+#define TXGBE_AML_MNG_MBOX_SW2FW        0x01E200
+#define TXGBE_AML_MNG_MBOX_CTL_FW2SW    0x01E0A4
+#define TXGBE_AML_MNG_MBOX_FW2SW        0x01E300
+#define   TXGBE_AML_MNG_MBOX_NOTIFY     MS(31, 0x1)
+
 /******************************************************************************
  * Port Registers
  ******************************************************************************/
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index 1a5e4326a7..ab7e45a0bf 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -821,6 +821,10 @@ struct txgbe_hw {
 		u64 tx_qp_bytes;
 		u64 rx_qp_mc_packets;
 	} qp_last[TXGBE_MAX_QP];
+
+	/*amlite: new SW-FW mbox */
+	u8 swfw_index;
+	rte_atomic32_t swfw_busy;
 };
 
 struct txgbe_backplane_ability {
-- 
2.21.0.windows.1

