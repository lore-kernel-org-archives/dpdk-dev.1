Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52896CCF9E9
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 03:16:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96DE54064A;
	Mon, 27 Oct 2025 04:16:08 +0100 (CET)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id A04B6402E8;
 Mon, 27 Oct 2025 04:16:05 +0100 (CET)
X-QQ-mid: esmtpsz16t1761534963t5ea2c122
X-QQ-Originating-IP: rYzzjmsg3xvGT1tWl4+hCwBQMx85NOq4ryPJdFNIVSk=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.107.118])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 27 Oct 2025 11:16:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2389872119335049796
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 07/19] net/txgbe: remove duplicate txq assignment
Date: Mon, 27 Oct 2025 11:15:30 +0800
Message-Id: <20251027031542.10512-8-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251027031542.10512-1-jiawenwu@trustnetic.com>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MIAHdi1iQo+zjzRFprfOyU5UO4OMCuFfqKXX3d4lzyU9hDOzZrIgCtvy
 53b4SQdQbP0rrploaM3/0HQd0s8GmDRYREuPVYhVEUX7iPrXPfrdk74PjLICaj+tE/ttAxE
 cK9bh+FQoBzkp5GGgu3tPrPbY+q1bJMZY00BAsLX3Z3IDlHfOggd5Su0DvuCRhbyuY+fKHq
 wjV/XWtwjgF2ySnPbRbE+6og/Wjb5x8RYimCH5DQUZf8jXhqbWkhbZEZq2heBNLfj5c6AjI
 zjEyXgDWKhBteVzckGq8RCjgofMx9WHj0j//MgkSMGQkqkejWTSeiTOEve8gqN79awmiHnF
 670G26xqZuFrStN6JSkq+mJWyi3NmkVCUdTGovUNJ/0Y2g/U5s0aUYZirSW0s6yM2Sa0XYZ
 1s1hMhoJ2jfQ7ljyWv3BM+V7mDIqummt5pwM9Nh9Zj+d6fOEZDdPd3pHy1ubVeL2o7FaYsu
 1u6/HDZZSxUtuccUQpxF5ZB/cueUG54XMhIZ4HyumzzkC+8mUsFoUu7DGhk30vYQj7eO5pc
 dOChmIb9FUHZNOnxMkrmBCeCzOPZj1fNo2pk/T/m2SZh9BeeaDyyBJkKJw1UigFr+mf/SuH
 GExw5y+6y2rUVlnUhEjYfRCGnPz5cO/P5FthTUXS2uRahpQYPHM9NbCpnAHW75H6U5ixrOi
 Up5Jn8k0DHTLkQINh1RU7H0WY1+enHvCac8j/6BtegKGddPg30OvsmsKzkhWyyZlMQco7ea
 iWc+Ecx3hkUqhN70d+qQ7GhxXSiigKGcEjGAPXHmUiWlQCcREicEc3p2WtHfRzexOEcH5KO
 u+1Ku4+BBoEOsLmCF32NY30ebYlQPDTifwFwdA2VOLnCLtq9HrUzJVp4OzY3kzIwcTu7Mwv
 zxvBe8h1CQl6Z7Kvdi7ykHdNluzBHaRl0GDrES9t6aVCLEaprLUz9+p96GXEV2kXhRzwe4t
 IddOwFH8R4/thzOBOJB2iNaTGTbLDL7wd1gkpfeq9vU+ZAfSb5xcrk7JmQdtryoLaE9OrXv
 ysxM2+EgXZaU710mRqkiMoMdktHYGltvLk5LVywDLNUw8sMLvsnCizGGMZo/c=
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

Duplicate code was introduced in the previous patch, cleanup it.

Fixes: 0eabdfcd4af4 ("net/txgbe: enable Tx descriptor error interrupt")
Cc: stable@dpdk.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/txgbe_rxtx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index a3472bcf34..78199ea00b 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -889,7 +889,6 @@ txgbe_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	tx_offload.data[0] = 0;
 	tx_offload.data[1] = 0;
-	txq = tx_queue;
 	sw_ring = txq->sw_ring;
 	txr     = txq->tx_ring;
 	tx_id   = txq->tx_tail;
-- 
2.48.1


