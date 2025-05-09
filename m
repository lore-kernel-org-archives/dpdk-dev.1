Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35575C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 06:45:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF6DC40654;
	Fri,  9 May 2025 08:45:35 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2E4B44065B
 for <dev@dpdk.org>; Fri,  9 May 2025 08:45:34 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5496UnLM024731;
 Thu, 8 May 2025 23:45:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
 EMM2O136aLoVpQIXkoG7R1tuTn+wq8j811VzS5Ao7M=; b=RCWZKY74LDCtOO3B1
 8KHFQrd/vzFuT34ihS2EdfeMSDYHdiGW5BcxkftOiaRKFMLqmB1BfdNQaLEimNUK
 vuLCOynmPTJoUcjNUjG8a2C34/V+aQNG5ZVCCJwxflBPrQzSp0zzEqIlQIEOY9yO
 drtCv/tYoo+qZW9lcBwICNwcoRtwRsyRldyOq2y+kC0DA2XfUhvVA2iLURJfIt3G
 Ejv0r3Es+DAimOawBbTjruEqQyjag0Rym8dW72Wrg4U18nb1B4/Wx5Qrkvz0AVKX
 Fojz0pFd33myyaM6DXc0a5kkBnIkMmj6ouV2N48j3LJ53D12JCVPR8Ans+GNIbor
 gJXEQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46hcg080un-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 23:45:33 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 8 May 2025 23:45:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 8 May 2025 23:45:32 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id 9E5B63F704F;
 Thu,  8 May 2025 23:45:29 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>, <nsaxena@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v2 06/13] node: add next node in packet classification
Date: Fri, 9 May 2025 12:14:41 +0530
Message-ID: <20250509064448.724019-7-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250509064448.724019-1-adwivedi@marvell.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
 <20250509064448.724019-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 5oPL5WCmBz6ZDtW28bJDBB49YeRCwI7t
X-Proofpoint-ORIG-GUID: 5oPL5WCmBz6ZDtW28bJDBB49YeRCwI7t
X-Authority-Analysis: v=2.4 cv=BaPY0qt2 c=1 sm=1 tr=0 ts=681da48d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=CLRsz27iqT3RNSdrtEwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA2MyBTYWx0ZWRfX6DAk1IbPCEp/
 mFh7xnu1jFjWt4KEIwQNqe1d8+dXL/uz+W41wuVgm7NEE9saREjrUQjbzcH1sS8PS+5n20Z+wSJ
 6vtKLBvska5otLWCHvPLcGFnJdra6oDFbFvnNm67R7zxWQgV8SQb2j/b+r0YmpOwmj5LZD7oScC
 DlIZz6hXBwOVw/8NTDQZavgjcFMCKN0gWHX4srRfCtXIA78APl+f5CtVqZ0XwQXlVNT1DkFbjRl
 WHjLScSVUOEblA4RuJ06+5P+xEYOErwMjN4C7k2ANmYecyJerXz+jAwh9OKv2z38Aznhm9F3YYc
 T05LhaRqqSztvB6/LEM81FXnPIQVWeWpRGAMlJJhj8ePNFDlXgs7IWSvvzQWkVGmEOtScY8cjdC
 rC4gf9PWjfL7L2N6MgLvW/Jk0qJTSWZbR7h+3xAKcllMjGoJB/4+6QPNSjQAkMEr016HQwk0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_02,2025-05-08_04,2025-02-21_01
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

