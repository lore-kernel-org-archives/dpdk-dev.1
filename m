Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1731C5B549
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 06:37:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50EB8402E8;
	Mon,  2 Jun 2025 08:37:33 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 64BA7402E2
 for <dev@dpdk.org>; Mon,  2 Jun 2025 08:37:29 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5521jDh9013863;
 Sun, 1 Jun 2025 23:37:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
 EMM2O136aLoVpQIXkoG7R1tuTn+wq8j811VzS5Ao7M=; b=asRGWY9UYbtnCGu5P
 XIJq4keXffNISbDtKjUt7wEOlfxfSCejorXO31s0oV68Y2Ig+LjyE97zkY5chXSZ
 e1DqqljMafEezetJw+yS5jcMQTzePly6kEGiKykva7q88q/QjmBjzMNvpHDqogqC
 t0QTZch7MhPLbzPIBa1gBjVFlnwFpWxABxKW9vmCA3TYTyRaoH+xjcBle+mxW6V4
 o5c8zcakUnhlTgiN0LUYO1dgCGRGlMemePfv+FW/i1ywWO5N8aAcjRufryVlG0RJ
 Kpno/IABv+fudUJUnsRhF2BFLZJNbXHjkoL6ogxYc2wIV0+R0l+luV5L7LbICUh2
 N5CfA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 470bpa1t8e-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 01 Jun 2025 23:37:28 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 1 Jun 2025 23:37:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 1 Jun 2025 23:37:27 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id 5DA1B3F704B;
 Sun,  1 Jun 2025 23:37:24 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>, <nsaxena@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v3 06/14] node: add next node in packet classification
Date: Mon, 2 Jun 2025 12:06:31 +0530
Message-ID: <20250602063639.198550-7-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250602063639.198550-1-adwivedi@marvell.com>
References: <20250509064448.724019-1-adwivedi@marvell.com>
 <20250602063639.198550-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=MJNgmNZl c=1 sm=1 tr=0 ts=683d46a8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=CLRsz27iqT3RNSdrtEwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: lhIsHjf3JjqhiaRwe2MG4PCYKVRvmPpH
X-Proofpoint-GUID: lhIsHjf3JjqhiaRwe2MG4PCYKVRvmPpH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDA1NSBTYWx0ZWRfX9HvRsKVekyGC
 Ext9W1tClmB4wEhtL8XFXcTLhETkodCGyCxP40DLVJ/LkaD7HdRSQa0JQPjTd5VrugojUMuZm+p
 VknsVd3vYSLMrcPgV4AzzvioeDBVFRRkU5iiF1XkF78DSjKleMSaZMLLVZrGOZWE//f1BITjf+n
 S6+em8X9/D4AFPnwJWMalcRwBPSGOaoQiBAgFHj0MjTEgWSl1Mh6O/4rF72XbkYmQgA5Z1UCdgX
 moeWENJWJARpbVaFmLZT6V0094eYucqNZBm7nB5gUHXIlpOlhhoZOkLg35YYS20Ue6/Jg1sloPi
 CTUhR6+rD7xN7OCdjCtNThtBMn8Aqyfkz5ydaXW59bWcDAdp057iI/nZXvyLTa1EavvpvDnkXxE
 uk7ycypB4xMKAHe0IDym/Dgec37d99VC0D90C5c01LiAcnJE6OSyZ8ITud2Rjelpjw9jGFH+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_02,2025-05-30_01,2025-03-28_01
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

The ip4_lookup_fib is added as next node in packet classification.

Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
---
 lib/node/pkt_cls.c              | 1 +
 lib/node/rte_node_pkt_cls_api.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/lib/node/pkt_cls.c b/lib/node/pkt_cls.c
index 5d6409fdbf..f6e76989bc 100644
--- a/lib/node/pkt_cls.c
+++ b/lib/node/pkt_cls.c
@@ -233,6 +233,7 @@ struct rte_node_register pkt_cls_node = {
 		[RTE_NODE_PKT_CLS_NEXT_PKT_DROP] = "pkt_drop",
 		[RTE_NODE_PKT_CLS_NEXT_IP4_LOOKUP] = "ip4_lookup",
 		[RTE_NODE_PKT_CLS_NEXT_IP6_LOOKUP] = "ip6_lookup",
+		[RTE_NODE_PKT_CLS_NEXT_IP4_LOOKUP_FIB] = "ip4_lookup_fib",
 	},
 };
 RTE_NODE_REGISTER(pkt_cls_node);
diff --git a/lib/node/rte_node_pkt_cls_api.h b/lib/node/rte_node_pkt_cls_api.h
index 36276db63c..8f935bebbe 100644
--- a/lib/node/rte_node_pkt_cls_api.h
+++ b/lib/node/rte_node_pkt_cls_api.h
@@ -27,6 +27,7 @@ enum rte_node_pkt_cls_next {
 	RTE_NODE_PKT_CLS_NEXT_PKT_DROP,
 	RTE_NODE_PKT_CLS_NEXT_IP4_LOOKUP,
 	RTE_NODE_PKT_CLS_NEXT_IP6_LOOKUP,
+	RTE_NODE_PKT_CLS_NEXT_IP4_LOOKUP_FIB,
 	RTE_NODE_PKT_CLS_NEXT_MAX,
 };
 
-- 
2.25.1

