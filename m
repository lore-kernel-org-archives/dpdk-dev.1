Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6EFCCF9E5
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 03:17:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7A8640653;
	Mon, 27 Oct 2025 04:16:19 +0100 (CET)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 608C640650;
 Mon, 27 Oct 2025 04:16:14 +0100 (CET)
X-QQ-mid: esmtpsz16t1761534971t638cc688
X-QQ-Originating-IP: UB8MbF2d8x4c1g90JQxRNZ5KVLvBE90myoLNSrYO5Bw=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.107.118])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 27 Oct 2025 11:16:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7656829414150503077
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 11/19] net/txgbe: fix FDIR drop action for L4 match packets
Date: Mon, 27 Oct 2025 11:15:34 +0800
Message-Id: <20251027031542.10512-12-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251027031542.10512-1-jiawenwu@trustnetic.com>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M6I+dON63j224b6EZkIq9xNGNtX8CfJZMkixmJn8suRoAnjEiVpQrPzL
 E9xArnXmYaCyuSifq9hMXOQrPBpq0LyTnhWjGf56VaNEh6R8DoXKyf9l5qrR8AgQU4SDgrE
 s47pfX2Xs1eVqIZyNHLmM4cwewyQ9Ud3lcmF03Uqk8Rq/BYiH+0NaRNWEr6IwtIw5XWYzYR
 QMvNuTEbq+J7Ol8CigkRcZ1iQMp3VUbIX60Rj7bH4FaTKXOsx68bMbdB/wXub9rYlFQHf/N
 /aYNv8YfByVDhHtVVVRd/9IQ68pIqbxmVI/2DkNyBMDoE5TdLCkoFcO4SNKgT79WhKebe1q
 uk/etJyBXVjdhegQlSkPYoGOztc+vQinYvUzK1N8XKJ+v3u41fVb8Xoy61KXuGCpCm8VD+d
 M5mE3SJyJmu6/H0nhEh2veaXe9eUOk1z1wP+wB2k6u5FdWv1hBEx8+WVBpQB0smXONi7/+3
 K4txT6dd0UyR+aIgBkGW+DYTglgPJU1GPLfwKFpKH9PtZfS/HUtfAbo4aQN3ApLzhKwX0RP
 bhKSQ2XRHYZAy0DB1hJMwNIlvNNn+vHHLDWzeKxghTQ7boAWPG1JGExKyH/XGaFn3APVVav
 4NaGTQ4b9MoRovvXvcpl0Fse/93T0tTvyeazC0T8BEFVilDQ4irFYTushlEWi3ci2Nn5Iim
 QyUppgHrV0iAr22iWiL2EdM+EjAjRHvqY+0k2SFVFhxjhBhjPdQswtMGGu1ZtYTNeMgrf7s
 jXxDXuql6oGnpX717rJ9lq9RLABGDrQAvu4P26ZeI8EmQSUqYnN7XjyfU3dtMMf0ewdHh7L
 mv1eIVwvv2uhdkYeLSWgt3JG+JKBMk3ydMpehk4XqUsfLH5Ds9e/r9wI2KcUkCb/G8mpSL7
 oP2brTpH+bS8XSFS6pgLCw1Pg/pFZoVl/5xqyEXUTGemsOFYGVH4Ta3ABnZxhouJkgmAtVj
 bOQ27A59sq9YXkWu++a80urDJR0VNpYVsEmHa9LjsrLBQsm5c0xgh/+vW/GdCTHOOMCw4e1
 ioB/8VftpNg0kB7RrBKRUnnQ8rTRw=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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

FDIR flow rules support to drop packets without being limited to L3
packets. Remove the redundant limitation.

Fixes: b973ee26747a ("net/txgbe: parse flow director filter")
Cc: stable@dpdk.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/txgbe_flow.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 25cf0db316..7cf079a1cf 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -2839,7 +2839,6 @@ txgbe_parse_fdir_filter(struct rte_eth_dev *dev,
 			struct rte_flow_error *error)
 {
 	int ret;
-	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	struct rte_eth_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(dev);
 
 	ret = txgbe_parse_fdir_filter_normal(dev, attr, pattern,
@@ -2853,12 +2852,6 @@ txgbe_parse_fdir_filter(struct rte_eth_dev *dev,
 		return ret;
 
 step_next:
-
-	if (hw->mac.type == txgbe_mac_sp &&
-		rule->fdirflags == TXGBE_FDIRPICMD_DROP &&
-		(rule->input.src_port != 0 || rule->input.dst_port != 0))
-		return -ENOTSUP;
-
 	if (fdir_conf->mode == RTE_FDIR_MODE_NONE) {
 		fdir_conf->mode = rule->mode;
 		ret = txgbe_fdir_configure(dev);
-- 
2.48.1

