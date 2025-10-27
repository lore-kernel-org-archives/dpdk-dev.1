Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA56CCF9E9
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 03:17:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 258AE40649;
	Mon, 27 Oct 2025 04:16:27 +0100 (CET)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
 by mails.dpdk.org (Postfix) with ESMTP id 02E2D4069F;
 Mon, 27 Oct 2025 04:16:22 +0100 (CET)
X-QQ-mid: esmtpsz16t1761534980t9c6cfc46
X-QQ-Originating-IP: UpOxVTSXHSyPZEY+YFFp2v0LgC1lMnO+Wwl/oT8yoXI=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.107.118])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 27 Oct 2025 11:16:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 130919324389389893
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 16/19] net/txgbe: switch to use FDIR when ntuple filter is full
Date: Mon, 27 Oct 2025 11:15:39 +0800
Message-Id: <20251027031542.10512-17-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251027031542.10512-1-jiawenwu@trustnetic.com>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MFdGPHhuqhNo/WMYuIRYGEr/wUAE5QWkko7LwQKf6g+0XVadL7foswSf
 9ew5HmpZFbMunrxYHAUZcMz6lmsCyiMlt1ebh0kGurRiWAL1w22NEu7QkTGvvcFJbhuZMvD
 xf0N5G1m5pPtRpGxVm4BpbasdGSAKW6u1nWjdWDFhUDgH7RdsnRsTz0GShrc+XIWUg3rgJb
 g8OAG/NWvAPCYKZxipPgkB+Dt2BzKBEarh2vVk+VVTekLk6V6R1l7/mwfyoLaEjethmDKcS
 mA34OFckzcegimIknw32l+tms6y1NVj0aiK6oHTpyQ7I6IcTwmR68HlKMpC4CIY27IJants
 2VZAWVQjUmLHRbICzLTw+RBK98BCHiInD64xN3lkqdj/THT6/3oNoB6Q0jKqMhBEkbmSawP
 Gazx2JiWYJ9RN+QIUYlce1/k6u7SsR2fUQ12NTs1+/Nae1TpOHj4TbdHfcmVNh95TsSnL+9
 j5Rz8ZfYOH45ApkqrHxvlUNH1Q+KaBdol84I6R9toz4DB0R/ArjtwZ02S1zdjmBSAB2Ttuq
 hYPi20s0S+dzfsrGOfE6pmTJGr4VPTlALFbXCbOtZKh8l6Ge47G4zLzguLKjoqSPV8xJQ+d
 I+1/rnmlgDesBvWBc+rwBNPTAScgM0Ikx0TmSRK4XylTvNKvFgcMeFlMCGEeAXcIO+j/KcG
 o506nlZ0qok+l7Uc7Bk4B36qxLWnguy40T823iPYBr2DIvtTbre8omwGiZWGhrDsOdIruAQ
 SBwYWdEMm0m4ctuNE7EJVTg2k409Omw+DZogqvbHSG2lm//G68CBGrHKL4Yo++5b0v3jO8V
 pdFCFjJUPhzWM0B3ioVFWZ15eZDD8558BJL/yMAJRASUltFJxS4Sa9+3zFi7jkZvqpxIrr2
 1bzVcCQxzjW8BVBYGu88FuN2yAT+ZZOWhZ5gwsf3CbQO+UTVfvODZ5bYg5mA4yvik10f+K6
 smxaKDxgVg9ctY1SpqGCETDLYbxMVUSz6i+MLnwNAe9fu/3MqwWSc+rR+RCASkhFdQw/sTL
 mpK7p/2navS8tpS2jRCRSa9EJ5JX2b+XxF25MqcoKVPPVlEQCa
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

Using ntuple filter has less performance loss on the hardware compared
to FDIR filter. So when the flow rule both match ntuple filter and FDIR
filter, ntuple filter will be created first. But there are only maximum
128 flow rules can be created on ntuple filter, it is far less than the
requirements of many users. So switch to use FDIR when ntuple filters
are full.

Fixes: 77a72b4d9dc0 ("net/txgbe: support ntuple filter add and delete")
Cc: stable@dpdk.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.c | 5 ++++-
 drivers/net/txgbe/txgbe_ethdev.h | 1 +
 drivers/net/txgbe/txgbe_flow.c   | 8 ++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index f650c5b7a4..21f0711762 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -893,6 +893,7 @@ int txgbe_ntuple_filter_uninit(struct rte_eth_dev *eth_dev)
 	}
 	memset(filter_info->fivetuple_mask, 0,
 	       sizeof(uint32_t) * TXGBE_5TUPLE_ARRAY_SIZE);
+	filter_info->ntuple_is_full = false;
 
 	return 0;
 }
@@ -4495,7 +4496,8 @@ txgbe_add_5tuple_filter(struct rte_eth_dev *dev,
 		}
 	}
 	if (i >= TXGBE_MAX_FTQF_FILTERS) {
-		PMD_DRV_LOG(ERR, "5tuple filters are full.");
+		PMD_DRV_LOG(INFO, "5tuple filters are full, switch to FDIR");
+		filter_info->ntuple_is_full = true;
 		return -ENOSYS;
 	}
 
@@ -4526,6 +4528,7 @@ txgbe_remove_5tuple_filter(struct rte_eth_dev *dev,
 				~(1 << (index % (sizeof(uint32_t) * NBBY)));
 	TAILQ_REMOVE(&filter_info->fivetuple_list, filter, entries);
 	rte_free(filter);
+	filter_info->ntuple_is_full = false;
 
 	if (!txgbe_is_pf(TXGBE_DEV_HW(dev))) {
 		txgbevf_remove_5tuple_filter(dev, index);
diff --git a/drivers/net/txgbe/txgbe_ethdev.h b/drivers/net/txgbe/txgbe_ethdev.h
index 053aa1645f..1e7cc5ea80 100644
--- a/drivers/net/txgbe/txgbe_ethdev.h
+++ b/drivers/net/txgbe/txgbe_ethdev.h
@@ -245,6 +245,7 @@ struct txgbe_filter_info {
 	/* Bit mask for every used 5tuple filter */
 	uint32_t fivetuple_mask[TXGBE_5TUPLE_ARRAY_SIZE];
 	struct txgbe_5tuple_filter_list fivetuple_list;
+	bool ntuple_is_full;
 	/* store the SYN filter info */
 	uint32_t syn_info;
 	/* store the rss filter info */
diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index d3113b6fc8..cd05ceffed 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -580,8 +580,12 @@ txgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
 			  struct rte_eth_ntuple_filter *filter,
 			  struct rte_flow_error *error)
 {
+	struct txgbe_filter_info *filter_info = TXGBE_DEV_FILTER(dev);
 	int ret;
 
+	if (filter_info->ntuple_is_full)
+		return -ENOSYS;
+
 	ret = cons_parse_ntuple_filter(attr, pattern, actions, filter, error);
 
 	if (ret)
@@ -3200,6 +3204,7 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 	struct txgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct txgbe_rss_conf_ele *rss_filter_ptr;
 	struct txgbe_flow_mem *txgbe_flow_mem_ptr;
+	struct txgbe_filter_info *filter_info = TXGBE_DEV_FILTER(dev);
 	uint8_t first_mask = FALSE;
 
 	flow = rte_zmalloc("txgbe_rte_flow", sizeof(struct rte_flow), 0);
@@ -3245,6 +3250,8 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 			flow->rule = ntuple_filter_ptr;
 			flow->filter_type = RTE_ETH_FILTER_NTUPLE;
 			return flow;
+		} else if (filter_info->ntuple_is_full) {
+			goto next;
 		}
 		goto out;
 	}
@@ -3254,6 +3261,7 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 		goto out;
 	}
 
+next:
 	memset(&ethertype_filter, 0, sizeof(struct rte_eth_ethertype_filter));
 	ret = txgbe_parse_ethertype_filter(dev, attr, pattern,
 				actions, &ethertype_filter, error);
-- 
2.48.1

