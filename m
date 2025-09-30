Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE16CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 10:00:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1309440A67;
	Tue, 30 Sep 2025 12:00:27 +0200 (CEST)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
 by mails.dpdk.org (Postfix) with ESMTP id 0BFFA40150
 for <dev@dpdk.org>; Tue, 30 Sep 2025 12:00:24 +0200 (CEST)
X-QQ-mid: esmtpgz13t1759226419tb3a18220
X-QQ-Originating-IP: oIBqtwcRoMImKmWaHAMJyu7BNAIfYNc16hEJMsrZUH8=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.164])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 30 Sep 2025 18:00:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9564367347419751474
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v4 02/20] net/txgbe: add new SW-FW mailbox interface
Date: Tue, 30 Sep 2025 17:59:34 +0800
Message-Id: <20250930095953.18508-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250930095953.18508-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250930095953.18508-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: N4WhQbLQyIqSIp83KxsxUFBxgME1huD3JVUJtEK+QF3c7Eeso1kkYDYE
 ZdoYYLw69aTBdr7Q/fQr/TdB154GqbPymdCHNXHerI8RKZ3I+OJ/IzISBc1sdQT521JwcDc
 JIAV7zTasmTIn+i0IDy1RILe4ONxVw2280AO7bNDvrSFpxakP72PAvg2YipAG7NCG4bgH5J
 s4zN7lTGzh7DO48s8RLWxER4wD3ljQjJa3C+WoPWhqM927G5fg3AsO5utRsFZ5rUBJkAnQ8
 3gmO6pdxyK87k8ZSk7djJkv2/d3Ea4ageZys5dRqCIC/pMPGyx/IAcnKD6bcfbvWbmB3/3z
 QNhyBLOUJUMg+nbaH7jY6B0RFm8lDt04ikKksxpJvTFd9hwULjN0G5+EEhbfAiEXCPCYg33
 ueEFttSW5KROz1KDn0pt0/bGwx7K7CBcnRfh6RAWdylFD1v00j3AVBc3SLMlm6XltLYADvk
 AyKRhPN2fN4oeh4uvL/jnM2pDmsNvOG3fpYpfeMWF12yp44GgqX9ZznbtgyNGedd8K9SokS
 OOYqMgmCAK9ZhFVxDd9hZDNYkZEjo7fUsAFUpjgAIvb2WcTHU5st2ge7C3dKk9Sw5/BeCu7
 IBMB++axuAn1OMuSli8Equ3bbkM/9xnOkpsMkE2l59zuC/CU1lMfJgYgzdfwrLsSdnqdKUA
 tA5HbOa2mu/9EkJTIL7aAeMvrpUK/PVvdtz33Fr0ua+dymyafeDw7BPcTdnEdUhi+pcDhTa
 mKPgQu4AkUA2rx7vJsui1v9an5uv8MKME3AvDD5yvNqjMfdJDQPMZePku/kklN9/PgHaq8z
 UeyiSg+CKwXYg1P1j8y09QulTp9HmcaQOdbqfDGoeq9S5zb1Q7T480tmvw4+6D4Iq5Lmk/r
 7jGcCH6ZD+/Yjg+wk3DsuCedtRbNIX5UxQe1nm7YiF8XOUAqPyuCODvsBaAwEyRYbWhemT8
 eWmFC/uW70as0P3lLPgwUvZUd/nDBB5F/9C3A9rris6ADElUyU4U557NrAn6cVJSl1OYoFm
 wmXjuPVDAkyawVIEYtNUJnslh7NXiHS1WGNrRi+bY3V2lUUi2s
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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
 drivers/net/txgbe/base/txgbe_mng.c    | 148 +++++++++++++++++++++++---
 drivers/net/txgbe/base/txgbe_mng.h    |  17 ++-
 drivers/net/txgbe/base/txgbe_regs.h   |   7 ++
 drivers/net/txgbe/base/txgbe_type.h   |   4 +
 6 files changed, 165 insertions(+), 20 deletions(-)

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
index 7dc8f21183..8839450b44 100644
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
@@ -114,7 +103,7 @@ txgbe_host_interface_command(struct txgbe_hw *hw, u32 *buffer,
 	u32 hdr_size = sizeof(struct txgbe_hic_hdr);
 	struct txgbe_hic_hdr *resp = (struct txgbe_hic_hdr *)buffer;
 	u16 buf_len;
-	s32 err;
+	s32 err = 0;
 	u32 bi;
 	u32 dword_len;
 
@@ -123,6 +112,12 @@ txgbe_host_interface_command(struct txgbe_hw *hw, u32 *buffer,
 		return TXGBE_ERR_HOST_INTERFACE_COMMAND;
 	}
 
+	/* Calculate length in DWORDs. We must be DWORD aligned */
+	if (length % sizeof(u32)) {
+		DEBUGOUT("Buffer length failure, not aligned to dword");
+		return TXGBE_ERR_INVALID_ARGUMENT;
+	}
+
 	/* Take management host interface semaphore */
 	err = hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWMBX);
 	if (err)
@@ -165,6 +160,117 @@ txgbe_host_interface_command(struct txgbe_hw *hw, u32 *buffer,
 	return err;
 }
 
+static s32
+txgbe_host_interface_command_aml(struct txgbe_hw *hw, u32 *buffer,
+				 u32 length, u32 timeout, bool return_data)
+{
+	u32 hdr_size = sizeof(struct txgbe_hic_hdr);
+	struct txgbe_hic_hdr *resp = (struct txgbe_hic_hdr *)buffer;
+	struct txgbe_hic_hdr *recv_hdr;
+	u16 buf_len;
+	s32 err = 0;
+	u32 bi, i;
+	u32 dword_len;
+	u8 send_cmd;
+
+	if (length == 0 || length > TXGBE_PMMBX_BSIZE) {
+		DEBUGOUT("Buffer length failure buffersize=%d.", length);
+		return TXGBE_ERR_HOST_INTERFACE_COMMAND;
+	}
+
+	/* Calculate length in DWORDs. We must be DWORD aligned */
+	if (length % sizeof(u32)) {
+		DEBUGOUT("Buffer length failure, not aligned to dword");
+		return TXGBE_ERR_INVALID_ARGUMENT;
+	}
+
+	/* try to get lock */
+	while (rte_atomic32_test_and_set(&hw->swfw_busy)) {
+		timeout--;
+		if (!timeout)
+			return TXGBE_ERR_TIMEOUT;
+		usec_delay(1000);
+	}
+
+	/* index to unique seq id for each mbox message */
+	resp->index = hw->swfw_index;
+	send_cmd = resp->cmd;
+
+	/* Calculate length in DWORDs */
+	dword_len = length >> 2;
+
+	/* write data to SW-FW mbox array */
+	for (i = 0; i < dword_len; i++) {
+		wr32a(hw, TXGBE_AML_MNG_MBOX_SW2FW,
+				i, rte_cpu_to_le_32(buffer[i]));
+		/* write flush */
+		rd32a(hw, TXGBE_AML_MNG_MBOX_SW2FW, i);
+	}
+
+	/* amlite: generate interrupt to notify FW */
+	wr32m(hw, TXGBE_AML_MNG_MBOX_CTL_SW2FW,
+			  TXGBE_AML_MNG_MBOX_NOTIFY, 0);
+	wr32m(hw, TXGBE_AML_MNG_MBOX_CTL_SW2FW,
+			  TXGBE_AML_MNG_MBOX_NOTIFY, TXGBE_AML_MNG_MBOX_NOTIFY);
+
+	/* Calculate length in DWORDs */
+	dword_len = hdr_size >> 2;
+
+	/* polling reply from FW */
+	timeout = 50;
+	do {
+		timeout--;
+		usec_delay(1000);
+
+		/* read hdr */
+		for (bi = 0; bi < dword_len; bi++)
+			buffer[bi] = rd32a(hw, TXGBE_AML_MNG_MBOX_FW2SW, bi);
+
+		/* check hdr */
+		recv_hdr = (struct txgbe_hic_hdr *)buffer;
+
+		if (recv_hdr->cmd == send_cmd &&
+		    recv_hdr->index == hw->swfw_index)
+			break;
+	} while (timeout);
+
+	if (!timeout) {
+		PMD_DRV_LOG(ERR, "Polling from FW messages timeout, cmd is 0x%x, index is %d",
+			send_cmd, hw->swfw_index);
+		err = TXGBE_ERR_TIMEOUT;
+		goto rel_out;
+	}
+
+	/* expect no reply from FW then return */
+	/* release lock if return */
+	if (!return_data)
+		goto rel_out;
+
+	/* If there is any thing in data position pull it in */
+	buf_len = recv_hdr->buf_len;
+	if (buf_len == 0)
+		goto rel_out;
+
+	if (length < buf_len + hdr_size) {
+		DEBUGOUT("Buffer not large enough for reply message.");
+		err = TXGBE_ERR_HOST_INTERFACE_COMMAND;
+		goto rel_out;
+	}
+
+	/* Calculate length in DWORDs, add 3 for odd lengths */
+	dword_len = (buf_len + 3) >> 2;
+	for (; bi <= dword_len; bi++)
+		buffer[bi] = rd32a(hw, TXGBE_AML_MNG_MBOX_FW2SW, bi);
+
+rel_out:
+	/* index++, index replace txgbe_hic_hdr.checksum */
+	hw->swfw_index = resp->index == TXGBE_HIC_HDR_INDEX_MAX ?
+					0 : resp->index + 1;
+	rte_atomic32_clear(&hw->swfw_busy);
+
+	return err;
+}
+
 /**
  *  txgbe_hic_sr_read - Read EEPROM word using a host interface cmd
  *  assuming that the semaphore is already obtained.
@@ -179,6 +285,12 @@ s32 txgbe_hic_sr_read(struct txgbe_hw *hw, u32 addr, u8 *buf, int len)
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
@@ -191,18 +303,22 @@ s32 txgbe_hic_sr_read(struct txgbe_hw *hw, u32 addr, u8 *buf, int len)
 	command.address = cpu_to_be32(addr);
 	command.length = cpu_to_be16(len);
 
-	err = txgbe_hic_unlocked(hw, (u32 *)&command,
-			sizeof(command), TXGBE_HI_COMMAND_TIMEOUT);
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
+		err = txgbe_host_interface_command_aml(hw, (u32 *)&command,
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
 
diff --git a/drivers/net/txgbe/base/txgbe_mng.h b/drivers/net/txgbe/base/txgbe_mng.h
index 16775862d6..613aa7b88a 100644
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
+	};
 };
 
 struct txgbe_hic_hdr2_req {
 	u8 cmd;
 	u8 buf_lenh;
 	u8 buf_lenl;
-	u8 checksum;
+	union {
+		u8 checksum;
+		u8 index;
+	};
 };
 
 struct txgbe_hic_hdr2_rsp {
 	u8 cmd;
 	u8 buf_lenl;
 	u8 buf_lenh_status;     /* 7-5: high bits of buf_len, 4-0: status */
-	u8 checksum;
+	union {
+		u8 checksum;
+		u8 index;
+	};
 };
 
 union txgbe_hic_hdr2 {
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 8da976dcc4..3b0bf08ea2 100644
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
index 731a7b4373..a34c782ec8 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -814,6 +814,10 @@ struct txgbe_hw {
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

