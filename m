Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5808CCF9E9
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 03:17:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A61FB4065F;
	Mon, 27 Oct 2025 04:16:14 +0100 (CET)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id D8061402E0;
 Mon, 27 Oct 2025 04:16:08 +0100 (CET)
X-QQ-mid: esmtpsz16t1761534965t0cf78c14
X-QQ-Originating-IP: EcH3ytZmhZp2atFHIP9NMfKLZFJ0U8nY7cYi4FuP5II=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.107.118])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 27 Oct 2025 11:16:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4470728718606443959
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 08/19] net/txgbe: add device arguments for FDIR
Date: Mon, 27 Oct 2025 11:15:31 +0800
Message-Id: <20251027031542.10512-9-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251027031542.10512-1-jiawenwu@trustnetic.com>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Ngk7ShESHkQuu/cJJY/orTD8Q/BZGQYGd3yWmfvVKA712mQynd/nw66l
 qGhRcD5uNnxYUzTvT24Ie/yYgkIuiY3gsYVTA95tEF/OeixIErn+iL6jdEd6w/GL4pkFFBL
 ttvbDFIaZVdwwZbsD9AmQ9rptxi5PdqZYnoBSy8yJpj7szJ60CHao+Dsz2BTgoay2WDuS2b
 WGJ32sBrWiWTqKbWV7T8mmduDyRyNA0QW5uakVcW4+5w4LGCr9//QbzMXKdESxMyatv5BnI
 fOxepMKc2ddvTXPOcZ4vtC7EdAS9xbw7wxJwZghCJNMw6ue0IgDul5sDGp46M0QaHK6RBA6
 MOC+LwmpsbISQApU9bmVj4MmOqDWLEe/esnh36qLtpLOMDhk+OlNkfd122iAdP8Tjdg46Rz
 U49sq70tz6X3f88YLdsc1F1A0ualThhcIGISKVixmplQhSqT9FhlI/KgGp2D26EjcDQh9QO
 wS351GxxuvDvH+JNh/pnO25+mwF6Ok6wYt7fpFX82vrg432DmD+rjButFJbhCAfkBMnrRZ3
 iYVASkklVxQzpYqDB9+HAbDpoQJCVe9+x9xCryYNk0DyR3uo3nc4AMGwvk9g3JJQZuFk1U8
 KdFNTCq+5Pw6WG2muXIkDVO1Akzm1RPFR8YuDDstOwHCrhSE2/utLuziR6tDmrc7rgJOh6B
 ZccFTTW/oWrC6AS8RHT5yDYSA7moHKNqFYLxCuKy3Qq9Guo6VYPs9kw6mMbMy2gD1uRBH0H
 Yx0KWK+d+LPOd0J4rTVwmUPc7Y/v3nmb9boDt1BPRbmkqTARDXKM6C3/v7NPRiEHerdrCB5
 L48N9nX7RYY1JXhkJD3qlr+fvzHsp/XCBXybczFI4vZ+AfAe+6obSeUsb4NwWfuoUcZ0uGX
 VoytLfYeOHRT0dsz6givY1Hcvxpo/YvYjXBuAttt2YoO71C3FMcXMRNR1Ohxd5F6a58JR9E
 nJQxTj5UuNf2BY3o9RIuhsYIbDRgdnw8wOKIZkD7FMWA+X4Q5Z3XjDrgFSmevAdI6EG9YuW
 U+bOnkMMb89zupnSpVU5Eb3XBUF1MPla3BmhgmB2ubLifIcWHWoZfz1TVURuc=
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

Since FDIR configuration is deprecated in generic ethdev device
configuration and move it into the device private data, there is no way
to configure the FDIR parameters.

Two device arguments "pkt-filter-size" and "pkt-filter-drop-queue" are
added, they just continue to use the previous naming convention.

Fixes: 5007ac13189d ("ethdev: remove deprecated Flow Director configuration")
Cc: stable@dpdk.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_type.h |  4 ++++
 drivers/net/txgbe/txgbe_ethdev.c    | 20 ++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index 07b443c2e0..b5dbc9b755 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -743,6 +743,8 @@ struct txgbe_phy_info {
 #define TXGBE_DEVARG_FFE_MAIN		"ffe_main"
 #define TXGBE_DEVARG_FFE_PRE		"ffe_pre"
 #define TXGBE_DEVARG_FFE_POST		"ffe_post"
+#define TXGBE_DEVARG_FDIR_PBALLOC	"pkt-filter-size"
+#define TXGBE_DEVARG_FDIR_DROP_QUEUE	"pkt-filter-drop-queue"
 #define TXGBE_DEVARG_TX_HEAD_WB		"tx_headwb"
 #define TXGBE_DEVARG_TX_HEAD_WB_SIZE	"tx_headwb_size"
 #define TXGBE_DEVARG_RX_DESC_MERGE	"rx_desc_merge"
@@ -756,6 +758,8 @@ static const char * const txgbe_valid_arguments[] = {
 	TXGBE_DEVARG_FFE_MAIN,
 	TXGBE_DEVARG_FFE_PRE,
 	TXGBE_DEVARG_FFE_POST,
+	TXGBE_DEVARG_FDIR_PBALLOC,
+	TXGBE_DEVARG_FDIR_DROP_QUEUE,
 	TXGBE_DEVARG_TX_HEAD_WB,
 	TXGBE_DEVARG_TX_HEAD_WB_SIZE,
 	TXGBE_DEVARG_RX_DESC_MERGE,
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index cbb2ea815f..e9bbf8ea72 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -524,8 +524,12 @@ txgbe_handle_devarg(__rte_unused const char *key, const char *value,
 }
 
 static void
-txgbe_parse_devargs(struct txgbe_hw *hw, struct rte_devargs *devargs)
+txgbe_parse_devargs(struct rte_eth_dev *dev)
 {
+	struct rte_eth_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(dev);
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_devargs *devargs = pci_dev->device.devargs;
+	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	struct rte_kvargs *kvlist;
 	u16 auto_neg = 1;
 	u16 poll = 0;
@@ -535,6 +539,9 @@ txgbe_parse_devargs(struct txgbe_hw *hw, struct rte_devargs *devargs)
 	u16 ffe_main = 27;
 	u16 ffe_pre = 8;
 	u16 ffe_post = 44;
+	/* FDIR args */
+	u8 pballoc = 0;
+	u8 drop_queue = 127;
 	/* New devargs for amberlite config */
 	u16 tx_headwb = 1;
 	u16 tx_headwb_size = 16;
@@ -563,6 +570,10 @@ txgbe_parse_devargs(struct txgbe_hw *hw, struct rte_devargs *devargs)
 			   &txgbe_handle_devarg, &ffe_pre);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_POST,
 			   &txgbe_handle_devarg, &ffe_post);
+	rte_kvargs_process(kvlist, TXGBE_DEVARG_FDIR_PBALLOC,
+			   &txgbe_handle_devarg, &pballoc);
+	rte_kvargs_process(kvlist, TXGBE_DEVARG_FDIR_DROP_QUEUE,
+			   &txgbe_handle_devarg, &drop_queue);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_TX_HEAD_WB,
 			   &txgbe_handle_devarg, &tx_headwb);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_TX_HEAD_WB_SIZE,
@@ -583,6 +594,9 @@ txgbe_parse_devargs(struct txgbe_hw *hw, struct rte_devargs *devargs)
 	hw->phy.ffe_main = ffe_main;
 	hw->phy.ffe_pre = ffe_pre;
 	hw->phy.ffe_post = ffe_post;
+
+	fdir_conf->pballoc = pballoc;
+	fdir_conf->drop_queue = drop_queue;
 }
 
 static int
@@ -671,7 +685,7 @@ eth_txgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 	hw->isb_dma = TMZ_PADDR(mz);
 	hw->isb_mem = TMZ_VADDR(mz);
 
-	txgbe_parse_devargs(hw, pci_dev->device.devargs);
+	txgbe_parse_devargs(eth_dev);
 	/* Initialize the shared code (base driver) */
 	err = txgbe_init_shared_code(hw);
 	if (err != 0) {
@@ -6034,6 +6048,8 @@ RTE_PMD_REGISTER_PARAM_STRING(net_txgbe,
 			      TXGBE_DEVARG_FFE_MAIN "=<uint16>"
 			      TXGBE_DEVARG_FFE_PRE "=<uint16>"
 			      TXGBE_DEVARG_FFE_POST "=<uint16>"
+			      TXGBE_DEVARG_FDIR_PBALLOC "=<0|1|2>"
+			      TXGBE_DEVARG_FDIR_DROP_QUEUE "=<uint8>"
 			      TXGBE_DEVARG_TX_HEAD_WB "=<0|1>"
 			      TXGBE_DEVARG_TX_HEAD_WB_SIZE "=<1|16>"
 			      TXGBE_DEVARG_RX_DESC_MERGE "=<0|1>");
-- 
2.48.1

