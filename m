Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB77CCF9E9
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 03:17:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22F1E40A89;
	Mon, 27 Oct 2025 04:16:33 +0100 (CET)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id C357340A77;
 Mon, 27 Oct 2025 04:16:29 +0100 (CET)
X-QQ-mid: esmtpsz16t1761534986t690a4c07
X-QQ-Originating-IP: R0qbHyIFnHItY+DqT5jutDn9gl8W3x4uVXTsxpcZe6k=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.107.118])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 27 Oct 2025 11:16:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17574007083870610212
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 19/19] net/txgbe: remove unsupported flow action mark
Date: Mon, 27 Oct 2025 11:15:42 +0800
Message-Id: <20251027031542.10512-20-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251027031542.10512-1-jiawenwu@trustnetic.com>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N7h1OCCDntujmU+gap7mnFj+glCv+pdDV+4PkNgHrrBZcZYcYvqw2iAr
 JpM5hQ+DxIcoYDt0pRkPCGeNP2aF+BGxCxUqsbI8EtXdiZqHUSqhL0w6Ys6G6cx9pv5mtCH
 Wy3hggq87skK8VLpiu3730l0F/ezjffZNgG3IWv1xZ/SFrCKBUtZKXxzmbMFbdiMCK+OkBC
 eAX96rqS6/9K7wm5lGQDSssEsG0rQkx/AMvfDCT/TlvdmcZEGRVCGOVWQYNfM64M4TL51bj
 gh4noUtuvBWJSSNXshCMjkef42K0UJ4PHnIZcpg9nhzHES9B2NZA3eryLotyQ42Wa4o2bSQ
 u60t07CSiNNqnUyLQ0hV57utBTy6KurqaWgFuxT6e+7bksnw2XI/upedJTKIX0UMUcrgO6L
 wZ8KmjcSEue8toncQrWM6tfJjlsMtg9h1KnP/glK7bXkdTfXMpC8XbLk1nSBewduIZ+szlH
 vZ/67lzvlPrw9LcApfdm2MaBregfR9jL4OyfGF6LqCnAynvJUGKd5RvulQ7n7e/ystaCYVI
 VfQ0LPO+b+RPoYHeJKRDnuGyEo89fjY7I6S/7U6Uw0+A1c3U4ZByqqUUSqQWH812k2mRyUb
 aGiYPyKZkx1h7GXrTZRVXNJEeneCQ8iQxT419JEo5Bk1nRV7vrgAybTturiGD3nuKA2dZNY
 57b7XXwhVc+pAIp0agw9P6Hd3iu2SwYAY3e12b2xl1TSu6pW/8kofnCsaBzPtzGntLU4Dk/
 WktLTBfUjnRCkoP+ESbI2zUD1y0AgSdtbTMgxqXqSgEyu5/BZkXzZ0O/LwN+7M51bgxqFqR
 b6aK/GZFckDknDgnUx+Cdq1XJtF1MfgdNO61z5Z2Uocc+nFR2WpIqHqWXktXOKL5YReJVbn
 L/ZDMWRrRndq0hXVlkMd5DJfLnfQ5GaUVau4/nWYHcbbeiUYC2BIW0812zQVkyMfrUZIYd4
 AWX+KxIACPc7yGRZ8P2CVI0htLK1GZHVcJIvu2R9xUjL7vDUi5xos5uGGy+0gLF7wEpT1BN
 DLZpSuhmTXVUUm9F8v/r0UnlV0AcdhBBn+MhJZWg==
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

Flow action "mark" is not supported, just remove it.

Fixes: b973ee26747a ("net/txgbe: parse flow director filter")
Cc: stable@dpdk.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/txgbe_flow.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 5647165d52..a97588e57a 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -1358,7 +1358,6 @@ txgbe_parse_fdir_act_attr(const struct rte_flow_attr *attr,
 {
 	const struct rte_flow_action *act;
 	const struct rte_flow_action_queue *act_q;
-	const struct rte_flow_action_mark *mark;
 
 	/* parse attr */
 	/* must be input direction */
@@ -1423,10 +1422,9 @@ txgbe_parse_fdir_act_attr(const struct rte_flow_attr *attr,
 		rule->fdirflags = TXGBE_FDIRPICMD_DROP;
 	}
 
-	/* check if the next not void item is MARK */
+	/* nothing else supported */
 	act = next_no_void_action(actions, act);
-	if (act->type != RTE_FLOW_ACTION_TYPE_MARK &&
-		act->type != RTE_FLOW_ACTION_TYPE_END) {
+	if (act->type != RTE_FLOW_ACTION_TYPE_END) {
 		memset(rule, 0, sizeof(struct txgbe_fdir_rule));
 		rte_flow_error_set(error, EINVAL,
 			RTE_FLOW_ERROR_TYPE_ACTION,
@@ -1436,21 +1434,6 @@ txgbe_parse_fdir_act_attr(const struct rte_flow_attr *attr,
 
 	rule->soft_id = 0;
 
-	if (act->type == RTE_FLOW_ACTION_TYPE_MARK) {
-		mark = (const struct rte_flow_action_mark *)act->conf;
-		rule->soft_id = mark->id;
-		act = next_no_void_action(actions, act);
-	}
-
-	/* check if the next not void item is END */
-	if (act->type != RTE_FLOW_ACTION_TYPE_END) {
-		memset(rule, 0, sizeof(struct txgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ACTION,
-			act, "Not supported action.");
-		return -rte_errno;
-	}
-
 	return 0;
 }
 
@@ -1562,8 +1545,6 @@ txgbe_fdir_parse_flow_type(struct txgbe_atr_input *input, u8 ptid, bool tun)
  * The next not void item must be END.
  * ACTION:
  * The first not void action should be QUEUE or DROP.
- * The second not void optional action should be MARK,
- * mark_id is a uint32_t number.
  * The next not void action should be END.
  * UDP/TCP/SCTP pattern example:
  * ITEM		Spec			Mask
-- 
2.48.1

