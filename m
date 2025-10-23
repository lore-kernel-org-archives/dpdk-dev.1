Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E18CCCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 12:14:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16D8240650;
	Thu, 23 Oct 2025 14:14:55 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 3784E402F1
 for <dev@dpdk.org>; Thu, 23 Oct 2025 14:14:51 +0200 (CEST)
X-QQ-mid: esmtpgz12t1761221688t77033669
X-QQ-Originating-IP: MvBnl1iOEPe5/t/iGzON2YYIzTkS22Aetxtzy+VHIHk=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.187.129])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Oct 2025 20:14:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17289353595723724177
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH 4/6] net/txgbe: add BME reset for Amber-Lite 25G VF
Date: Thu, 23 Oct 2025 20:13:53 +0800
Message-Id: <20251023121356.21944-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251023121356.21944-1-zaiyuwang@trustnetic.com>
References: <20251023121356.21944-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MWdgP8+gtiFRmx9CkCrwcBqokTvyqby2cWs7ajnhk8HVdcLhX9zuB6NG
 rzadjlaMIY1da+3pJFE8V6CvoH9X7P49CnSSTT5DNDZuPfDTzz0ghaS1Bzi+CUJDoPJyE2E
 oloCyVJcpWiR3TM8oCxi4AzVFVgseJL6Qf36Ryjt2Tmue/0bLUTkfXLJtPWmV9L53mk/i2I
 29MsftOgy6CMkEt9IyEvnD7Qs34euZ0y3RnuvzTkH3llmuhUpA/VOWIUZzE58YL+KKst25w
 KhCkCL5AOboiTZCmmCRoF6YnSYaR781k4v9Mgla+xG2FPKnqR4z8I5n97cb2kORHtT0wlKt
 7sbQ8Nf+EIwoFuQOYkut76IoiUR+M+b1F69V/Yla2O62JgTeZYisYYrc2aqGx+cYclMresG
 0h9VrFq+mbZGxkyi5bKzJqOyV9UlyNdgZapR19WM+I4lLJlsXLo+oqCXZAfnF/dRrjXyVJ5
 HpxdLT37+aEbJaWC/+zXwxz5Rs6yTFnL3IrZujKxWGMohhfF3fYSJPCY0dsYuCY3gt6DZPT
 R+y7nnL0dvSCeI5XC842h5+tDi5bcWfs0rMFcMygBBhPcIhko1fljCpijOCbYAQZImBu0wQ
 6zMA1jBbKmfvA1OM/P/1yJv64F3gQ0a3XBPhu3LmkQhvJWVPV1bz8B7IfVzbRNH0mOLAXG2
 fFlYjup561aBBiKDLM4eLHOz+/CLXeVBZgMzvXkkWmA2zSo12lhW7BhHmnJXcJyBgsYV9yd
 5aH913g0qTHOT8eYr/6chcXYI1w4qecy1FvJMRlpV9U2IrocWp3Xs0rq83ZC2QQ/pRGRhwQ
 Y17v0FFaCj/Wv13wys7fGQllOodzgyMsD/3evHTmB+Gh82EWN5E6YKZeisAF0xM43ICGnHh
 TkBzvj+na966BWeUw5J994B4hVu9RtgBvRRkpb4nFyswbUxLz64dsoHJEZhdhTIDRz/tb79
 kN8tgAuYRFsPoQBLnV6ZkZAC/9l+h4TZjuWeJfiJ6CMsOV4hBuV/eTEYj/f/wfBSPa/7y/0
 WDL+IEKvzdLcQvLmr9gCEvjhK2gR/NXPrKtJoNCWHYAEiv+FduCtCug0dbL9NYyxQUZ8FU8
 g==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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

During VF reset, the PCIE BME (bus master enable) register needs to be
reconfigured to ensure proper NIC functionality.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_regs.h | 2 ++
 drivers/net/txgbe/base/txgbe_vf.c   | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index cfe9b94e78..638404bdff 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1273,6 +1273,8 @@ enum txgbe_5tuple_protocol {
 #define TXGBE_BMECTL                    0x012020
 #define TXGBE_BMEPEND                   0x000168
 
+#define TXGBE_BME_AML                   0x0004B8
+
 /* P2V Mailbox */
 #define TXGBE_MBMEM(i)           (0x005000 + 0x40 * (i)) /* 0-63 */
 #define TXGBE_MBCTL(i)           (0x000600 + 4 * (i)) /* 0-63 */
diff --git a/drivers/net/txgbe/base/txgbe_vf.c b/drivers/net/txgbe/base/txgbe_vf.c
index 5e41ba1a3e..efa32ca10a 100644
--- a/drivers/net/txgbe/base/txgbe_vf.c
+++ b/drivers/net/txgbe/base/txgbe_vf.c
@@ -133,6 +133,10 @@ s32 txgbe_reset_hw_vf(struct txgbe_hw *hw)
 		usec_delay(5);
 	}
 
+	/* amlite: bme */
+	if (hw->mac.type == txgbe_mac_aml_vf)
+		wr32(hw, TXGBE_BME_AML, 0x1);
+
 	if (!timeout)
 		return TXGBE_ERR_RESET_FAILED;
 
-- 
2.21.0.windows.1

