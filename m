Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C828FF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 10:26:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9ABB740661;
	Wed, 29 Apr 2026 12:26:10 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 4D6F340431;
 Wed, 29 Apr 2026 12:26:08 +0200 (CEST)
X-QQ-mid: esmtpgz10t1777458365t0d9f08d9
X-QQ-Originating-IP: /Q6qLEupgzjn6cr3/tIMkMQbWgv0Go4oitEkUiGF19E=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.191.108])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 29 Apr 2026 18:25:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5621335584475631453
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 02/20] net/ngbe: remove duplicate xstats counters
Date: Wed, 29 Apr 2026 18:24:56 +0800
Message-Id: <20260429102515.58880-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260429102515.58880-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260429102515.58880-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MolY1goi3EMG5HnYmUE/+pv+8K8T0rBla6Nh/vinpFtSAxspb7xAS7VO
 ACnBXG1Ln1nbV1odl5khpXs3Z9pimEFvt6+cM/8a/6JHQNbPWabFBYbSVnAzTEhsLvpTUD6
 WHBtx/lFevOCfqPLJ4bTUoOTaIjdCHJeOYLbSHtiYiHHBc+1tjimSyEvekFLJQxC7F+BjTt
 N4IiVHyZHmyqcaj8zV7gOoOUujp6ALWDaQPKGHsVDpb/CWXh+ezmWEmCfdap0Nn1n0G4glI
 69D+sdO0NYEPlXyqlsQDnLZIWRHOxQsscD4bD4faUktU3+h6Lrcyhs31oK4Pu7AiQtChy7w
 51wFLSzZDBYfZNlwpGcPTF+jtf7yzWTG6k6Q7Qv/PY5CN8vaCA3y/VF6sb0AtUSzSnWbR6p
 eVV6J6g5C0UOu5tut6B4IxJBZKyyE67MxH4C3TJl/FrK7yAO6hsngAxh/NkjG72NKLX0Dve
 dzP8eHIAI29C3vm18puuWgbmvJZniirZzIEbe4CosfL2Mhe3+A/l5EL+Si+DjUqqswKQilq
 GnKgksD2rvjUurdXOVxVgy2d5FYqgmmNWsjvP01m7uWnUfXXZokzrXdWX46o1Wn2CqkOJdg
 VImbhe2BR7jYiCzUlT6KR4VyCM+ITY2/b/TLWcnpTQ9Ggd5mxvfplnT2u4Hxuw7NCQTFH/7
 T6Ewh7paobpsPIh6NmoSHdFOzO6FNTHei5NkdswGNfCJ6DZjM9Bl6VREFMmkZJzw6y770cS
 xewi2ZCY1r3OnH0KGeS2RHXjukpR4DNYNljPyyaRPsnbt9I2OsbS4QeG63/4I0myUVWfd/j
 iJNDwjEGK6z82JhdVNTNQ6g027J5/ohxRabQ8Hu7KfM0Rvr5a9wWgpmYsOhrQGQak3J5Rj4
 VQ45N8OXcj4KMTzhYI+zulTl9zLJK4j7DZS2qKChpHz2+aGuSDZzQvMpjkihIJ6defXy7/q
 6qaSHrLEPVy+dvTSgm5+V7lvFGB8yptMDj+XBYg8D15ZfTmNyDgKFgNA8bH8Y3xR8T2CsG5
 2B5FdHGKLKDnMvV54M0a7Z7jzUe26hKz7XGs+dQiykFcGCJsq+nIek82MyEWwheCHVKfaDx
 5nat2W3T6X8/HrIIOZ8uPGcdj2MpWGLT8oHqV2aN/Pa
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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

Remove four redundant counters (tx_xon_packets, rx_xon_packets,
tx_xoff_packets and rx_xoff_packets) from xstats, as they were duplicates
of tx_flow_control_xon_packets and others. Both sets were reading the same
registers but being output twice under different names. After removing
these entries, the flow control counters in DPDK now align with those in
our Linux kernel driver.

Fixes: 8b433d04adc9 ("net/ngbe: support device xstats")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/ngbe/ngbe_ethdev.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ngbe/ngbe_ethdev.c b/drivers/net/ngbe/ngbe_ethdev.c
index 8b9d6371fb..6df53f3266 100644
--- a/drivers/net/ngbe/ngbe_ethdev.c
+++ b/drivers/net/ngbe/ngbe_ethdev.c
@@ -227,11 +227,6 @@ static const struct rte_ngbe_xstats_name_off rte_ngbe_stats_strings[] = {
 	HW_XSTAT(tx_size_1024_to_max_packets),
 
 	/* Flow Control */
-	HW_XSTAT(tx_xon_packets),
-	HW_XSTAT(rx_xon_packets),
-	HW_XSTAT(tx_xoff_packets),
-	HW_XSTAT(rx_xoff_packets),
-
 	HW_XSTAT_NAME(tx_xon_packets, "tx_flow_control_xon_packets"),
 	HW_XSTAT_NAME(rx_xon_packets, "rx_flow_control_xon_packets"),
 	HW_XSTAT_NAME(tx_xoff_packets, "tx_flow_control_xoff_packets"),
-- 
2.21.0.windows.1

