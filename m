Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5BCEDB7CC
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 07:41:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DE5B402AC;
	Tue,  7 Apr 2026 09:41:57 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id D5E3440293
 for <dev@dpdk.org>; Tue,  7 Apr 2026 09:41:55 +0200 (CEST)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LS1JE793867 for <dev@dpdk.org>; Tue, 7 Apr 2026 03:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=x
 XmFL2PnBAs/4OZs7ekP9s2VrRxy8G5Cp1/LQZGXBWM=; b=TnVDjX6neZOiV7p4a
 2l3cup9j/iCi7Rr/Wwhq7w2CVs6MhwwiA/SCZ3aj2BrTdegx88LW10E4KGNlgOAU
 JrYraoas4yyFxjkdy2822lcI4d3VutbLyx9x4EQGPc3SBa26uA+d1DAFfgFaVy+V
 l9H6gvpG7yc0jGSYmOpt3wN1eeirLsNulZqrXe27t3YD4Tvyc4tVPF5HeaJLxjET
 3pLPzpOVx6/wDD95XVXAEaoHIYe3NjfKJSmbaPdbe1Zv6ebxPOjNXNeDoGHIiKoz
 VTdq49IlHPYbzi0fozZy5vgMvtX2Chv6j1wHA/Df5cDsC/qrFgWrimBAda+o5/KA
 noicw==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4dcmrwtb03-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 07 Apr 2026 03:41:54 -0400 (EDT)
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6377djQ4420397 for <dev@dpdk.org>; Tue, 7 Apr 2026 03:41:54 -0400
Received: from esapsmtplv04.us.dell.com (esapsmtplv04.us.dell.com
 [143.166.203.152])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4dcu19t8k1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 07 Apr 2026 03:41:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1775547714; x=1807083714;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xXmFL2PnBAs/4OZs7ekP9s2VrRxy8G5Cp1/LQZGXBWM=;
 b=G4s3Ed/zuAC+ubzjCxO3lzPifivGcFcumusgpvlj/Jm8Ij5/cJiPZB+I
 8z3YZnLqoD4X1RkaY3mn1Ufv9MrdODXwZeyg2huQZ22Vcuy38L+pCBb5x
 c4TAaAH8BftWb1h9JAdjBHty4M9/CNyTPEEhOunlx4ly6B+X+oHfEn7Uq
 jITLy/WeRJ6b0fNTjlGzhKW5HgiSz88ahplJ8WQGv80PibbiT8yx7gv7x
 THVbN42EVYU9WNbxvCpIgsSEcbXaIFd1fLp8ztuukvAECI28Q/9OA+ptp
 r6byXJwUzc+r52sF3xi535aYv6vebsr4YwqEjG3ojEqNF29oEYG5eu1dW A==;
X-CSE-ConnectionGUID: Har+4oV0REK6+/iIsw/GUA==
X-CSE-MsgGUID: cyq0Ef/DT22uj5bWGdORPw==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv04.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 07:41:53 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 02:42:57 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 02:41:51 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 7 Apr 2026 02:41:51 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH v9 1/5] vhost: add user to mailmap and define to vhost hdr
Date: Tue, 7 Apr 2026 07:42:19 +0000
Message-ID: <20260407074223.3876085-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407074223.3876085-1-pravin.bathija@dell.com>
References: <20260407074223.3876085-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070068
X-Authority-Analysis: v=2.4 cv=a/gAM0SF c=1 sm=1 tr=0 ts=69d4b542 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=XtseytAk/c9oG0Kwoj6KRQ==:17
 a=A5OVakUREuEA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=aNt9FJNJ8fZyd9HhltU_:22 a=iLNU1ar6AAAA:8
 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8
 a=3CDqXdsAvEiB_ezhLkQA:9 a=hlJyneSgMmFPbskH-t2w:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA2OSBTYWx0ZWRfX3jizxAmQaBJ6
 iVRLIgjJ7ULqNJfF1DZodrsIxJGGmhG8GNao/mOsxc532qRCYiqTJFxMvHwj9LjFxTC0VfwF35T
 GNGRq1/O36XnnuSUcj4LRHhd993BwV7lzFFY7/SIEvv+TVY+JqLCMxcFLc9tB/GYjDzDoPDdAj8
 aD6JEDtsbPOQogJvkZxgR55VlgwDDe4WYl1+Ct2wUlrXiYMMZMY/Lah38JUT3Ehdgu8JOPAEAa4
 scfghYCkz3q7t26GB2HpExlbmqW8XZLF8QmEDf0eXGTXLRznyqVLDeryt4vBe5zjA5wvUyJslP0
 LS6FvhGPU08lDaELfBnw1fVbwMrYwB/Pyaeu5f6IG2xL6sZ9i5Bi8O+ktn+cFCZH6kaSEBCzqrv
 aIDI0YCH1ScfeeKwBm/CnSUnArrBTyhkfDb2B2GGG38aQRPBt19omhauCmnSTk8mukDAANuvkcU
 aSJCWY6AeBUlszFGJMw==
X-Proofpoint-ORIG-GUID: HHHf57or94AMKhmI-qicK3DV6pzsuev1
X-Proofpoint-GUID: HHHf57or94AMKhmI-qicK3DV6pzsuev1
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070069
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

