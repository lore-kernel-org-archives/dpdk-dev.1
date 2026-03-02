Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CB8D58E5D
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 06:18:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8C4D402B0;
	Mon,  2 Mar 2026 07:18:14 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7FBE34028C;
 Mon,  2 Mar 2026 07:18:12 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 621Nvn981306167; Sun, 1 Mar 2026 22:18:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=N
 NjV1gNhC2sY4WXpOCa3ugQdvsCz6anASH3BpuiJUWs=; b=UojOqTGYzGtY6itnS
 XAELN86PBYfPeIJhlYe6Iju6dALv/x/WK76rMRpoQlkwBpS7JlTlr0NxqB4fRsIz
 AZE4naFRUE0guZEhszhAv3PCae+BcO/rX9kLJI2xD1aDyqfaVv/A1eReHbgpA+Ak
 v7SVC56PFuND0eZpxheRxvpAAtDHxFSVNUp8xdUiLQWokV5eA4VwYq2hXMyKqm2o
 7yJt45wzIDNIZDefhnsnNfiFa2/fdnzffDZa5Ah6UlXz30mn7c1P2BD4Uzxe5w+d
 Qs5jndKC7AkK4rLsACnLiBBIgIESeKZDFhMnzN7xZQisMD/0rP1qjoOYBl7UFKdB
 agVgA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cmng8s4jp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 01 Mar 2026 22:18:11 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 1 Mar 2026 22:18:10 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 1 Mar 2026 22:18:10 -0800
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id 89A273F7077;
 Sun,  1 Mar 2026 22:18:08 -0800 (PST)
From: rkudurumalla <rkudurumalla@marvell.com>
To: Pawel Wodkowski <pawelwod@gmail.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <ndabilpuram@marvell.com>, "Rakesh
 Kudurumalla" <rkudurumalla@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v6 1/1] examples/l2fwd-jobstats: fix timer stats display with
 lock contention
Date: Mon, 2 Mar 2026 11:48:05 +0530
Message-ID: <20260302061805.1666176-1-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240811155957.576645-1-rkudurumalla@marvell.com>
References: <20240811155957.576645-1-rkudurumalla@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: k5MAMXilNRQ_WRg9RusE6_12UroqySjm
X-Proofpoint-GUID: k5MAMXilNRQ_WRg9RusE6_12UroqySjm
X-Authority-Analysis: v=2.4 cv=UeZciaSN c=1 sm=1 tr=0 ts=69a52ba3 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=IMbF4wEfJt4oOEi9Lk4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA1MyBTYWx0ZWRfXx/K4ATVv93Qc
 skC14s8vBjPyI8W1gRQlz5d3WvFV8V9cCWhKh8NL5ttWAbyKFkEfkHXkgadP1KngkUhepVGMjXg
 39+LkTIYCGg9dqAOkdlIuYyr199U+c39v2q2LRm9M90cR/vzlJkqumeN2a3vSu/mcjZfWseSdEq
 kKiX7VrEqS2BKUTN2dtbgi/TmaSwIIb9VU8LhUQzfUfRHn+Kn+O/YxqX2xO0vocuU5DXeibR7aI
 kpsc40b1qxgfoIvuNI6jbRpWfqIxplZOBcq4SAe2FuR37j0J6rPuBI9A/8amH+WR/e+i1rKJv4d
 SUYLo93saOsVAo0tDe+g44Zum/UZGWPrkm3W9Nttwhz79VMKwDb5O/1uWBmyveS/BFROJcNm4gb
 Bne3CxPzQ0B4ExR3lS6OUNShjtQaQ6RUXEj/6y7yvZis5vT7NHfLE4Kdk0+pZbIy1e6TikHMGUz
 B0ad9u7DaIrEqRxwPTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
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

From: Rakesh Kudurumalla <rkudurumalla@marvell.com>

Race condition between jobstats and time metrics
for forwarding and flushing is maintained using spinlock.
Timer metrics are not displayed properly due to the
frequent unavailability of the lock.

This patch fixes the issue by introducing a delay before
acquiring the lock in the loop. This delay allows for better
availability of the lock, ensuring that show_lcore_stats() can
periodically update the statistics even when forwarding
jobs are running.

Fixes: 204896f8d66c ("examples/l2fwd-jobstats: add new example")
Cc: stable@dpdk.org

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 examples/l2fwd-jobstats/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/examples/l2fwd-jobstats/main.c b/examples/l2fwd-jobstats/main.c
index a7cd5b4840..036bd4f951 100644
--- a/examples/l2fwd-jobstats/main.c
+++ b/examples/l2fwd-jobstats/main.c
@@ -541,7 +541,9 @@ l2fwd_main_loop(void)
 		} while (likely(stats_read_pending == 0));
 
 		rte_spinlock_unlock(&qconf->lock);
-		rte_pause();
+		while (rte_atomic_load_explicit(&qconf->stats_read_pending,
+					rte_memory_order_relaxed) != 0)
+			rte_pause();
 	}
 	/* >8 End of minimize impact of stats reading. */
 }
-- 
2.25.1

