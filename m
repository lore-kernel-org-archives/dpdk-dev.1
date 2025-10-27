Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A78CCF9E9
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 03:16:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42AB040663;
	Mon, 27 Oct 2025 04:16:13 +0100 (CET)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 37FB840651;
 Mon, 27 Oct 2025 04:16:09 +0100 (CET)
X-QQ-mid: esmtpsz16t1761534967t571012b9
X-QQ-Originating-IP: IKWxYhk4ayCgoKNVU9jJijSLdh8ATYKYj5yhKu1CVzI=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.107.118])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 27 Oct 2025 11:16:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2097224516378831201
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 09/19] net/txgbe: fix the maxinum number of FDIR filter
Date: Mon, 27 Oct 2025 11:15:32 +0800
Message-Id: <20251027031542.10512-10-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251027031542.10512-1-jiawenwu@trustnetic.com>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MmpliBmRb3iCFg9xO5fV1ywm8igQMlqs3CkvzOkHTVtqP2vOW9abYHcY
 CCcryfXHGFCHLRb04IiIxkupCoRzbVmu8vaoXzfZsXndfy8qmPnle7q91799aZVEI6WuZv/
 cUWVRVAXA0W+8OV5AmpL5gWpWMoSnE1O2nxLglXZNkQDAcGVRwWLjg+b7+E6PkpMzNLHmDo
 fWIPMfhqYEBxqdlhfRJpF/OAdui/RKmI+hdlPg3mgvCQXwT/KjjiayXiqFNMweyKh4pPv4Q
 pHLoEh00aQVEvmymA6tozK4T+zR0e1sQOWjV3YcFA43XfY9iithe1N7VAFNHcJT1P9VFFVx
 xcEKC4RQ9/W7SPnC1GRhypWGWSqBaCWCnhpztVFk5IaPc7vESIhZhdoRJJS1PccOOfCgH9+
 ppyDH+fCJa16zRlUnKZ8fq7V6AwbZHTaLB6Kn2l9CqjfuYKtHqvYLLNvg4AM+OSx2mChTdY
 Q2/adB1g1u4apr9bM/yr/ntXtqhMt/BNlasWeI4q4YHk9zLJlOWRV5T8/X9Vpgj3pO6Ua0M
 SAW8/L6MyAHmv3Vgl5QR5aEV7r5pjJLqgGigBfT/YCUKGeB6I3w1aFDXsJtFlVg//+ROqPT
 f75Ri7S1pwtW/JIXWPzC4PxfNdjFTC7wjOUeCX7DAhwxVRQAFyFZG98ocsy1WVEGZ4N++U1
 u0kJLPygJffkt0HwLlabzt6ze0jNe4pD9R7V3Q0o8cOwih6llMOi+BGKrZrdzJs05bsmmnd
 T5D8zwf/RLNbxiiRRxZq4UgzaaFeR5FrlH0mrU4DqvT6ohMhqKZDVZfshYK2MEEiWE4hh9l
 WNSgKtVPmrbxRySyg4d7Es4md5Muw+XSrWjfDWODlml5ep55C7McPLtoITXCRK0znXvenbU
 qbRtYU0XYxxoQgChH0uzgBRYvIOOPR4SXqN+fXUBYIvJCoHiB1Wv3/OfR4kqrUjdyv2Hkvk
 G5AZqs82BcFKpj/CWdQT8lPvU/Lpgl33ySOSsDJAPS4FpcJvNlzX6ZIIcPxAwQoivn8ACYZ
 K6sKBnNa6rH5Vx5vrE4qL8lO27yDqzYySryGSBuxjRAN5xvClk
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

FDIR is determined the maximum value on the hardware based on the
memory space allocated (i.e. fdir_conf.pballoc). But the hash map of
FDIR is created based on TXGBE_MAX_FDIR_FILTER_NUM. These two do not
match. It resulted in the absence of error when creating more FDIR rules
than the maximum allowed by the hardware.

Fixes: 635c21354f9a ("net/txgbe: add flow director filter init and uninit")
Cc: stable@dpdk.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.c | 6 ++++--
 drivers/net/txgbe/txgbe_fdir.c   | 4 +++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index e9bbf8ea72..f650c5b7a4 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -935,11 +935,13 @@ static int txgbe_l2_tn_filter_uninit(struct rte_eth_dev *eth_dev)
 
 static int txgbe_fdir_filter_init(struct rte_eth_dev *eth_dev)
 {
+	struct rte_eth_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(eth_dev);
 	struct txgbe_hw_fdir_info *fdir_info = TXGBE_DEV_FDIR(eth_dev);
 	char fdir_hash_name[RTE_HASH_NAMESIZE];
+	u16 max_fdir_num = (1024 << (fdir_conf->pballoc + 1)) - 2;
 	struct rte_hash_parameters fdir_hash_params = {
 		.name = fdir_hash_name,
-		.entries = TXGBE_MAX_FDIR_FILTER_NUM,
+		.entries = max_fdir_num,
 		.key_len = sizeof(struct txgbe_atr_input),
 		.hash_func = rte_hash_crc,
 		.hash_func_init_val = 0,
@@ -956,7 +958,7 @@ static int txgbe_fdir_filter_init(struct rte_eth_dev *eth_dev)
 	}
 	fdir_info->hash_map = rte_zmalloc("txgbe",
 					  sizeof(struct txgbe_fdir_filter *) *
-					  TXGBE_MAX_FDIR_FILTER_NUM,
+					  max_fdir_num,
 					  0);
 	if (!fdir_info->hash_map) {
 		PMD_INIT_LOG(ERR,
diff --git a/drivers/net/txgbe/txgbe_fdir.c b/drivers/net/txgbe/txgbe_fdir.c
index 0efd43b59a..631dec69e8 100644
--- a/drivers/net/txgbe/txgbe_fdir.c
+++ b/drivers/net/txgbe/txgbe_fdir.c
@@ -959,6 +959,7 @@ txgbe_fdir_filter_restore(struct rte_eth_dev *dev)
 int
 txgbe_clear_all_fdir_filter(struct rte_eth_dev *dev)
 {
+	struct rte_eth_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(dev);
 	struct txgbe_hw_fdir_info *fdir_info = TXGBE_DEV_FDIR(dev);
 	struct txgbe_fdir_filter *fdir_filter;
 	struct txgbe_fdir_filter *filter_flag;
@@ -967,7 +968,8 @@ txgbe_clear_all_fdir_filter(struct rte_eth_dev *dev)
 	/* flush flow director */
 	rte_hash_reset(fdir_info->hash_handle);
 	memset(fdir_info->hash_map, 0,
-	       sizeof(struct txgbe_fdir_filter *) * TXGBE_MAX_FDIR_FILTER_NUM);
+	       sizeof(struct txgbe_fdir_filter *) *
+	       ((1024 << (fdir_conf->pballoc + 1)) - 2));
 	filter_flag = TAILQ_FIRST(&fdir_info->fdir_list);
 	while ((fdir_filter = TAILQ_FIRST(&fdir_info->fdir_list))) {
 		TAILQ_REMOVE(&fdir_info->fdir_list,
-- 
2.48.1

