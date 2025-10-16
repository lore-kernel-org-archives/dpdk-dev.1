Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9F3CCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 11:19:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7760D410F2;
	Thu, 16 Oct 2025 13:19:24 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id D778F40EDF
 for <dev@dpdk.org>; Thu, 16 Oct 2025 13:19:22 +0200 (CEST)
X-QQ-mid: esmtpsz17t1760613558te377fa84
X-QQ-Originating-IP: lB4LoDXWGAtZcC8jpDj0c6ASu/l+ig1+biGdSD5AyQ0=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.206.160.146])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 16 Oct 2025 19:19:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16683632476136254623
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v5 02/21] net/txgbe: add new SW-FW mailbox interface
Date: Thu, 16 Oct 2025 19:17:16 +0800
Message-Id: <20251016111736.25372-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251016111736.25372-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20251016111736.25372-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MCqxCcyBE+BGM9C5NSZQUswS7cyczpkv/2H4kRpJy8OrjYfPZlYXQec+
 miTe/msYhWqoyzx2drjOsy80uJmMRxh7ZWfaIaMG102t+06QNbtB8f+gecrh2E4ZPlLpRXt
 t4yBvC0eQZuWAHqkXPjh5fbyNl3z/fHxOT11FHbBlZZBwGqTresdYeHO5ugSIKO+ROArTEF
 K6g6DRX4PUvwXgTrta2zAdQM0vFi6G9lvvuwqh291Cm1gzFSDggrqSAD4Wn3qmb+z0r3DKz
 7BKf2kGvXgT4AFIJf0DVOs+t1zBdY9EDsfR/pEfMWYFY190rwYrlN1Ut6sVffYeGKpJ/OVQ
 pRduwm5uTtjCFo9HeElb2Qb5+2N2iEHE+N4Q/R1d008NYWbMxpeCo9YI3l2ejK1pR5N1kQi
 IxNUWVFaM/JVOpMLWBIT/qMEid9DnKjQJw61p8AAHMr+ALbdcpTtxT4EsSuw77sFSVeJ1MS
 X9ta1ITgFSY2uSNVULUOYnrTqqakPmHZvPBYSwLLa3DmpBYkc/RfRr0AnR7uvRGydQBJb14
 NI6Lo58qeMveMV0H/MPeJCpQDsHUyRYil8xFmI8ZNrG2UjymrEmVUcDUgtQAxsQGC/1eQ+b
 wYt9vEyObvG/kPZkxM5ePYEvoTVaJrw0lJuDYIJnRvCDybo6yb5hNlbJgaCuVoBgXl4DtW9
 gUmQ/Jf/HicqmhS9wRz1QMUrJSYj5fu60eOYKYQRK8KE+xQbt4rqcvvmwKAmasFd/yH8XhU
 7KoVlHx3ShjXNURTcdwu/ohrQbL+uE9h2ruE3H+8RcUVtp+YUUt5tJBnZqGIZNupJ0UfRvF
 WlWJhkJgrnbgBBceb1EDk3s/wBVrKupkOOJKecvVw+Eg5b742vmy8HcUDFXeNuz47mSqD7e
 pGpqE4j7fH4WpxtuR5kOo4PDGLZ8pEBNQ3u/KpoeMtgNtubI8+8Xr90iEf/7VNgKQmoaEaV
 RwWx/6JtPVrE2nJ6Fp951YfhcSwuPYXhPcSr5H+L0apqQBIyuiQr1ula7bbDf0FhfB9ytcn
 uzau9Jpx2NHNy0qduZ8GOxquq2PBWiiEUlcnNzJcRxJNi1BGNF7R/weJrtHEwKdcHDpCubA
 Q==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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

