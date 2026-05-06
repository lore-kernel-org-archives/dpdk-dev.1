Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F388CD3427
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 03:38:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03DA640672;
	Wed,  6 May 2026 05:38:00 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 18347400D6
 for <dev@dpdk.org>; Wed,  6 May 2026 05:37:57 +0200 (CEST)
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6463ZZCb2601609 for <dev@dpdk.org>; Tue, 5 May 2026 23:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=x
 XmFL2PnBAs/4OZs7ekP9s2VrRxy8G5Cp1/LQZGXBWM=; b=VzRwqYLzurlnrTG2b
 SAQeK2MgUEMFnBFF4BOr5JJjQ2kuq5U+lM3F7ulP7oaRZugBv7upNBz4jfEazK0g
 VRD7eJ8qU/Z7vxOm7p44LCyi4EjMYluGzv0iC89rbBimyQwjSaQY/L2mRMvJp9Ft
 sKiaEDUJ+0GYtOSz2jEA0pq6PMBxjyxapGNYr9YIVM+j69vCKhZbw0+D95ie/tKo
 nn0MP+tyxKZ1IQkVJwc+AVKeWI+WqotQ3uEmgmReqEOGJH8Le6xeUB3SAQOK4lw4
 HVi6C+34SEdsZuGy8FCAMvZC9WhBb08pxAGQ0AjupzG7fmz2SbAhmpVgRHE1SOcz
 0r8pg==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4dwbtypf8d-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 05 May 2026 23:37:57 -0400 (EDT)
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6462UZZ4548036 for <dev@dpdk.org>; Tue, 5 May 2026 23:37:56 -0400
Received: from esapsmtpat07.us.dell.com (esapsmtpat07.us.dell.com
 [143.166.211.149])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4dyv1u1992-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 05 May 2026 23:37:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1778038677; x=1809574677;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xXmFL2PnBAs/4OZs7ekP9s2VrRxy8G5Cp1/LQZGXBWM=;
 b=Z87jcuzb43HQWmQsz6LT1k3m73Qx1WTQGSY/aocSSzBMxNeXHv/vrPfC
 e3dKse4c2uKcLQCkCKgU9Mt1Rb/qFSuiQ/3lF30uTldalI+pnS3vF7Oha
 bDCrHbebdc81PAwKNGkXEh8BRVLFesT5qWXlhqUi9Kr+490L13FZqdqk/
 xwxujIgOZs2wbGhECrIRspg14B5Tc12dv2gs5S2Ls6YsjNob5w0ZZQTAg
 Gizicr42RB+hSBhMUyex92u7gw6HFqW5ESWwYRVnU6fL1Mgwww9NStWv/
 KCUojdK52OIWRcmHjSK8AqsBOoF8x3QrwMiJbpJdRzQOonZKhoMBvY0ei Q==;
X-CSE-ConnectionGUID: WRW01T63QEC+QzH2qKdQTQ==
X-CSE-MsgGUID: hjuLB2SoTFKYqlh8RNu1Yg==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtpat07.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 03:37:56 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 5 May 2026 22:39:06 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 5 May 2026 22:37:54 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 5 May 2026 22:37:54 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>, <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>, <fengchengwen@huawei.com>
Subject: [PATCH v12 1/5] vhost: add user to mailmap and define to vhost hdr
Date: Wed, 6 May 2026 03:37:29 +0000
Message-ID: <20260506033733.972952-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506033733.972952-1-pravin.bathija@dell.com>
References: <20260506033733.972952-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060032
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDAzMiBTYWx0ZWRfX+rhUEqEUPNf+
 IE2DvMD6jsZxhLGl3BefJ0MwtlMo9naQKWshmNqN/wwweCdxJO1+ZVgsHR6b98S1RSgxhYjPd4J
 IkogzOkD4eUPZ0pD1Uw/cNqBcSNi5GfBGGK9i6YOSYi/dUnEeb7bVesDMEMlg5qVe/L0XQatp6c
 0mGwonhpZIPqZCrIEFxPKE0fQLYptGgUCtBHWlEtta8R9MGYuju0YszxbVHP3Ud2yTLQWec2EfK
 7MVMVOUl9tvqyJwfuOTuR4WvOHgmnFBG5sTDiUNeCi7ZfheSNhFOH/NVHF2KWl1rixCAxxTdLmK
 9QI0sREkQO0bhd6nsfBWlDzCD2WczesTWQS94RU0SlhNLndYbE7T/WK7hAUgN8wqPYeT2uCZz4H
 OdVQBH6iZpcvbaJqi5NvFdxmUwcrD2P6HTPL/pD+83IKtnj+W3yyA/v/7rt9rBWKlalpTIwwlKm
 IxiFbgZBgC0TxQyPplg==
X-Authority-Analysis: v=2.4 cv=UNXt2ify c=1 sm=1 tr=0 ts=69fab795 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=vdbZnCXtvJht7X5WT7bgSg==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=gLxAKuEMs0EQMVFiDJnH:22 a=iLNU1ar6AAAA:8
 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8
 a=3CDqXdsAvEiB_ezhLkQA:9 a=gbU3OgOOxF9bX48Letew:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 74xTuvvdfistELVHyLybVc4IL2EOdRgJ
X-Proofpoint-ORIG-GUID: 74xTuvvdfistELVHyLybVc4IL2EOdRgJ
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060032
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
index 0e0d83e1c6..cc44e27036 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1295,6 +1295,7 @@ Prateek Agarwal <prateekag@cse.iitb.ac.in>
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

