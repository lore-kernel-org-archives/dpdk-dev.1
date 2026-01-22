Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606AFC44500
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 07:49:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6F6C4013F;
	Thu, 22 Jan 2026 08:48:56 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 4F1F5400D5
 for <dev@dpdk.org>; Thu, 22 Jan 2026 08:48:54 +0100 (CET)
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60M5Up20019656
 for <dev@dpdk.org>; Thu, 22 Jan 2026 02:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=5
 Tjs3bhO8yFb0lxWCs6GN6rDJC69pabPUxdzaj4q4zo=; b=tWaJ2n3XsYxjQINnQ
 mSugTerakaltR4TnOE8mFY28lFKavgFQbBlaRuYwHZn60e8HfOkieI5t2bqSeC2u
 6sYvxyyxJKS37BVzCGkZcL1JCY5aaBO9Vv0wIlj83gR37cG8UY6DjKEdSpQajpn9
 AbvB1BEItXFhnBG1q9xRvJfzBgecX++6ls740i4km6SI6Jl6TLySYHRS4oZ+B5cC
 yrmVlFd99Wyu9XGvgstzlTyf8xGUvOjcBW4b5nEQY+yDpRrdmRpO3BCnvXRkcBGy
 7XCfoMfwW7Zi6U/wnhnZe3HeoCAjZX4hEcFfhLx+yo3MEQmCGehPskCdmmVpQj7D
 ZIsZA==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4br6h8vjnd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 22 Jan 2026 02:48:53 -0500 (EST)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60M6RfXZ017224
 for <dev@dpdk.org>; Thu, 22 Jan 2026 02:48:53 -0500
Received: from esapsmtplv09.us.dell.com (esapsmtplv09.us.dell.com
 [143.166.203.151])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4budb6sq5e-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 22 Jan 2026 02:48:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1769068133; x=1800604133;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5Tjs3bhO8yFb0lxWCs6GN6rDJC69pabPUxdzaj4q4zo=;
 b=KhZziWYBuNOzajb+HWz5odIAnIMShIrF/InCVnic7/OOvMlil0h9EQfk
 UZPKnqYgt/ADf5u6agjQsQyBYtffuw2TLsEdTnJ/3yxWoGMiJOd+v5dvV
 3GdUovTKahSJHeZ2xIiVF1AuIxOITHXARKeyRdjnflipNMYnopjOBqq6D
 e6n3OQiYvZwXpQMM+g4bcc7CwiFc1H63dI2j7PuXKtLgqr8wuKXOIN/lq
 qwMo9ui74ivnPisu4265aLJDZMmiiZTbnDMyCiCSTuLf6P5PkwsqN2mbw
 xOy/r15EyuISFO3OOYyL8asvpKZEg1psR7WnL9PcEPhT+p173b0Mn4pb/ w==;
X-CSE-ConnectionGUID: cj2KIfGcRduuKa0MEEcd0w==
X-CSE-MsgGUID: 5WuTd/Y5RGqTdqPYT8W5PA==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 07:48:52 +0000
Received: from ieorr5-ppwem001.delllabs.net (100.64.0.132) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 22 Jan 2026 01:49:55 -0600
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem001.delllabs.net (100.64.0.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 22 Jan 2026 01:48:51 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 22 Jan 2026 01:48:50 -0600
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <maxime.coquelin@redhat.com>,
 <fengchengwen@huawei.com>
Subject: [PATCH v6 1/5] vhost: add user to mailmap and define to vhost hdr
Date: Thu, 22 Jan 2026 07:49:02 +0000
Message-ID: <20260122074906.127942-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122074906.127942-1-pravin.bathija@dell.com>
References: <20260122074906.127942-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601220050
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA1MCBTYWx0ZWRfX1iCXBv5Y0bsC
 uy1F5fs8nThckhtdGFmbY8SrUjQQ4zE8jWCoRQuvekY4fXJTDJYFk25WRjn3Tw47u2mCZBpibaS
 Z9VS3MuGi3pXFVYMdRSrmUjjExIAwuOiTY8K7PspSruItokZ2fhHnzy1ad6rraSSMtB9bZwA0RZ
 krvwLufIei8ve2WcwwPQTfgBNVjy9hv9CQttSfg+d/QmN8YqSU1JIvTmnKXIPLEJmGiTAGxVfJf
 gwcj9LYB3+lgYidn3csnEeXSNkVEItB1bzyUgeMOCLM3CLx9UgGW5bfgA8Wob5Q0M9se2RJoJw7
 qtwNMjqTawUbjMwWuQ5sTsCyDs2O29m8Oq6ymAbBeMQi/VBFUHc/Zk4oYZ4Nd8tDWyk3tAcSvEd
 qPaQDjOAO+5M3hc0fna78AF6evQL2ocJfZ2yy+Lr/JMONLZfy5erhje3FOb2bjcWqrKuiMUAYL8
 bf0M+yuzLPAXhIzVTFA==
X-Authority-Analysis: v=2.4 cv=LbUxKzfi c=1 sm=1 tr=0 ts=6971d665 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=1BWgYg405ukQaXe9BCXDPw==:17
 a=vUbySO9Y5rIA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8
 a=M5GUcnROAAAA:8 a=3CDqXdsAvEiB_ezhLkQA:9 a=hlJyneSgMmFPbskH-t2w:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 11k8Qa1CBMz6NDWS0uC0MfMxhD53_WTt
X-Proofpoint-ORIG-GUID: 11k8Qa1CBMz6NDWS0uC0MfMxhD53_WTt
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601220050
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

From: Pravin M Bathija <pravin.bathija@dell.com>

- add user to mailmap file.
- define a bit-field called VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
  that depicts if the feature/capability to add/remove memory regions
  is supported. This is a part of the overall support for add/remove
  memory region feature in this patchset.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 .mailmap              | 1 +
 lib/vhost/rte_vhost.h | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/.mailmap b/.mailmap
index d838ffb4db..bc6d111a92 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1284,6 +1284,7 @@ Prateek Agarwal <prateekag@cse.iitb.ac.in>
 Prathisna Padmasanan <prathisna.padmasanan@intel.com>
 Praveen Kaligineedi <pkaligineedi@google.com>
 Praveen Shetty <praveen.shetty@intel.com>
+Pravin M Bathija <pravin.bathija@dell.com>
 Pravin Pathak <pravin.pathak.dev@gmail.com> <pravin.pathak@intel.com>
 Prince Takkar <ptakkar@marvell.com>
 Priyalee Kushwaha <priyalee.kushwaha@intel.com>
diff --git a/lib/vhost/rte_vhost.h b/lib/vhost/rte_vhost.h
index 2f7c4c0080..a7f9700538 100644
--- a/lib/vhost/rte_vhost.h
+++ b/lib/vhost/rte_vhost.h
@@ -109,6 +109,10 @@ extern "C" {
 #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12
 #endif
 
+#ifndef VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
+#define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS 15
+#endif
+
 #ifndef VHOST_USER_PROTOCOL_F_STATUS
 #define VHOST_USER_PROTOCOL_F_STATUS 16
 #endif
-- 
2.43.0

