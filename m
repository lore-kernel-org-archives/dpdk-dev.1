Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A54EB270F
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 10:24:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F3504060C;
	Wed, 11 Feb 2026 11:24:22 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 448F84060B
 for <dev@dpdk.org>; Wed, 11 Feb 2026 11:24:21 +0100 (CET)
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61B1GO9M325485 for <dev@dpdk.org>; Wed, 11 Feb 2026 05:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=8
 uhhz/p1f7/k30WlKF5mIteBNqs3toGV06Z0wOOQSmk=; b=ENfNuoe1pcD8KRVeh
 CpSDkvjgTuuEsfbUKnxMkF3wukGe6AUBBz9VA/UqmT7VMR/Jg46uLQGgr7a48wjg
 qyBNAsWZf9fLJnjiyH/v7WY2K+nyb55BiBchJPP/fKV9VUQFldKIXrjvv0PuBFcb
 F0Va9/1j7800caCpdyg3soNBVN7BgUQzwJedfE4F7vvPFM4a1Jg9KVsq3EELKRC2
 StCgJAq9lBvZAADJNfFKpqYzoieT3R1hLosSzmrxYCFkGwOOW3CUANSmCBEYCGBm
 FlYynbn7aPZeXAKT+WhqnMeM9/Oq9jjmZRmuT9OsIUVzrWitfiQLeOPFkb6zf0Mv
 myevA==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4c60u68eea-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 11 Feb 2026 05:24:18 -0500 (EST)
Received: from pps.filterd (m0371675.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61B9xsB81814388 for <dev@dpdk.org>; Wed, 11 Feb 2026 05:24:17 -0500
Received: from esapsmtplv01.us.dell.com (esapsmtplv01.us.dell.com
 [143.166.203.147])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4c8njc9q7c-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Wed, 11 Feb 2026 05:24:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1770805457; x=1802341457;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8uhhz/p1f7/k30WlKF5mIteBNqs3toGV06Z0wOOQSmk=;
 b=dtVpNuDYFKhvvjsc/GVsKRiDDX07CFacMODknG6ndLSe7Wrl0WOZeRYb
 vfcEwrG6XglMsuoUEtPm3ZB0eBZdA/ciXLeUACxBbCvzQZTlRNg4q2ehZ
 9conLyN9xmySJVsZYT1IUWedv7mMuE3D6Ublua58KkFykZcda73sRVMuR
 GwHt98g/4/VUZEa45m5ZsAlkhFvMcs8lG0kz1xD/99J4bK27vubo6ewhI
 rVFeQ1/W3iXmBg8MFTG8IFqQteoQaa+/yAKUB9MG2zBZ78+S24Gd55nIA
 rwTqZudXH6GrjQ5BbR1Og2KEXqw7iCZgEln0lIlgSQthGR/iJ5sCKnqCB Q==;
X-CSE-ConnectionGUID: u9JjSTCXQMC9suG0rGm/Ag==
X-CSE-MsgGUID: t235jy6ZTk6O0INMW085MQ==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv01.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:24:10 +0000
Received: from ieorr5-ppwem001.delllabs.net (100.64.0.132) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 11 Feb 2026 04:25:20 -0600
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem001.delllabs.net (100.64.0.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 11 Feb 2026 04:24:10 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Wed, 11 Feb 2026 04:24:09 -0600
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <maxime.coquelin@redhat.com>,
 <fengchengwen@huawei.com>
Subject: [PATCH v7 1/5] vhost: add user to mailmap and define to vhost hdr
Date: Wed, 11 Feb 2026 10:24:29 +0000
Message-ID: <20260211102433.694516-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260211102433.694516-1-pravin.bathija@dell.com>
References: <20260211102433.694516-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110085
X-Proofpoint-GUID: l4t_8IHj7ppZsYEuQrJn8l7-xEzDei3y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA4NSBTYWx0ZWRfX1xdQHBwk30fw
 w9uBvbMy1Ey4vKmnQ7co46HJ2d7n3DngFeYDy9avVBW4HCfYZW8HDQTYQGvCDfja+A2AR2T7S1Y
 2iBv+xatwYSad6NlDwR0Lm2s6EKbf2/E0UQNaRGvkxDhjrVVkt6FuTN8xS0Y7SB1buJq8J1flZC
 dBaNu84DSamrKXRvscyO1IFmH1PNWpfFM3r2OWKli1N+THle7j/x51T1A+zsq9LO6GPTzjv3Nhk
 dhqvh5OvTwYXWchvH5XWfCH53HozOjy/3/Z9h1irjJJdp1pfNMkW2+Vq6s5K6fTu1kaAPWt3YTD
 P96GNXZdnH3BAuf0GKQdr23qU8fpupCQkBcmE2uyeqvacfL6AosnfbPiniIrxeMk/4ZbFvBdFYx
 kyx4XNguAboVLqmx/dofx/cahOSJLHxY2Wjm33e1nm0Xz/Z/2U/xZmxXmtjalB9j+OTzlRq/pNP
 3e2oaaiw4qegXoXpFuQ==
X-Proofpoint-ORIG-GUID: l4t_8IHj7ppZsYEuQrJn8l7-xEzDei3y
X-Authority-Analysis: v=2.4 cv=WIhyn3sR c=1 sm=1 tr=0 ts=698c58d2 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=L/h6WUVEnF1aJ0/14Ndw0A==:17
 a=HzLeVaNsDn8A:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=iLNU1ar6AAAA:8
 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8
 a=3CDqXdsAvEiB_ezhLkQA:9 a=gbU3OgOOxF9bX48Letew:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110085
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
index fc53ed2a55..1ca895ef1e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1286,6 +1286,7 @@ Prateek Agarwal <prateekag@cse.iitb.ac.in>
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

