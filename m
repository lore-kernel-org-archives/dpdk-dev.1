Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2146BFF885A
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 05:30:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BEF940272;
	Tue,  5 May 2026 07:30:32 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 30EAD40270
 for <dev@dpdk.org>; Tue,  5 May 2026 07:30:30 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6454WUr1285371; Mon, 4 May 2026 22:30:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=g
 y6HO0lHF01MkYlTDhUHXn+yIiGVu2UV19kErn13pSg=; b=P2s4ZoWAFdhJQOVgV
 hOymOXcvVG93zketPVvUPIQgr/MY/wSkIyLjl8ucmeVfil9txCQuXrUovj7SX3wb
 lTHw3eaAGc1WykoL58m0hFrGQlvtceBf59+5GgY957j58591uHeRtHjklX+gz0vd
 1uErUoetAyb3UwJwWxF4o7Y6AMM6D1K9gP2H+gF09Xijm37jhJk5hBinBCZko/B0
 Ed2H3jfXadXerAxQOM9AkLAq0P1mCTjPs1meowpXWqE7hrVoVRlEBuTRRg8myVMR
 /pjfN/tzuwvH4XrDRxODbCqZJFXkGcL+vqDB1cQzGUJzB9RFa2hv2DXcK5Y0h+pS
 3Uyqw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dx218vt37-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 22:30:29 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 4 May 2026 22:30:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 4 May 2026 22:30:28 -0700
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id A5B993F70B3;
 Mon,  4 May 2026 22:30:25 -0700 (PDT)
From: rkudurumalla <rkudurumalla@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Sunil Kumar Kori <skori@marvell.com>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>, <ndabilpuram@marvell.com>,
 <mb@smartsharesystems.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>,
 Tomasz Duszynski <tduszynski@marvell.com>
Subject: [PATCH v2 1/5] trace: change scope of conditional block
Date: Tue, 5 May 2026 11:00:19 +0530
Message-ID: <20260505053023.3854665-1-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251024054830.933910-8-tduszynski@marvell.com>
References: <20251024054830.933910-8-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA0OCBTYWx0ZWRfX2oZTbiP/pkRg
 unaaRwnirAILtwVRtfNpjUJew3k/tkGAN+WJmB+X48N0cT+aHls1w3PBtwGTDmUg5Gnt7Yf9a2q
 vmcqApAMzbQsKCikyeMiauhvugKVTNR+UYeB2qc1UgYj6VGMr3ZaUGnmnU6eAWTS0bjpMgytlwG
 M/B/qSXKuJAwFpVMOPWE6bay/YCZUi2uVVt8wprFrTVTaC3ZhRXkP9cmx8l4KVH255A+tjIPaj2
 JPbrqxmng12+uss5CqdFwFM6Ahz1FIjukqcnTwTSmCfT0K8LnpDZ/lBgO7OlLq4FSNd49vf/RFc
 aSdX8gxlrAeVVFGmaxa+j4Z/luPItxLqG4dRc4v1NPeA0sje+dU0bO3gk3Hy41e2kNRUu8s6rbz
 hI5NWY1804mJJf0Yn1/oD/kdfFk6zZF37jo+CKNqI31g9BsrZ5cgGIzg1Q7nOexinQ6Ihu/mMY2
 JqXfjW+0EwM3aR8pwXw==
X-Proofpoint-ORIG-GUID: lrmWWr9Qg8Mq6vVz6L805ts29T4Y7YjS
X-Authority-Analysis: v=2.4 cv=coqrVV4i c=1 sm=1 tr=0 ts=69f98075 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=Kcy3tOko_B9AbsjGbs8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: lrmWWr9Qg8Mq6vVz6L805ts29T4Y7YjS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_01,2026-04-30_02,2025-10-01_01
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

If ALLOW_EXPERIMENTAL_API isn't defined warnings should show up but
build itself should not fail (unless -Dwerror=true).

In order to avoid build failures change the scope of conditional block.

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 lib/eal/include/rte_trace_point.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/eal/include/rte_trace_point.h b/lib/eal/include/rte_trace_point.h
index c0ebf1ce13..394b2619c5 100644
--- a/lib/eal/include/rte_trace_point.h
+++ b/lib/eal/include/rte_trace_point.h
@@ -289,7 +289,6 @@ int __rte_trace_point_register(rte_trace_point_t *trace, const char *name,
 #ifndef __DOXYGEN__
 
 #ifndef _RTE_TRACE_POINT_REGISTER_H_
-#ifdef ALLOW_EXPERIMENTAL_API
 
 #define __RTE_TRACE_EVENT_HEADER_ID_SHIFT (48)
 
@@ -314,6 +313,8 @@ struct __rte_trace_header {
 	uint8_t mem[];
 };
 
+#ifdef ALLOW_EXPERIMENTAL_API
+
 RTE_DECLARE_PER_LCORE(void *, trace_mem);
 
 static __rte_always_inline void *
-- 
2.25.1

