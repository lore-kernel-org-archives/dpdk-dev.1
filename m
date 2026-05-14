Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95201CD4F39
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 May 2026 22:46:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1517340647;
	Fri, 15 May 2026 00:46:41 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 6AAEC402D1
 for <dev@dpdk.org>; Fri, 15 May 2026 00:46:39 +0200 (CEST)
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EJ1nvE3624750 for <dev@dpdk.org>; Thu, 14 May 2026 18:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=x
 XmFL2PnBAs/4OZs7ekP9s2VrRxy8G5Cp1/LQZGXBWM=; b=YvtkF2xsb4oHkkoet
 Hsd9DP7+ty6SAfE85+Xdp3Us3HKKSHWGZzTPSj3JJHHm1RzjSwj4HSzcMS+8YO2m
 5mxJR4M9QEa4hALwm1x8uyNoo/kogRCJxI7C559xGrqotfV4VGjdx4L9jGNXaORn
 Dfg4dQKuCm3AIVdnRED9VryqzJKaGlF+OkaRonLitVn9lDdzLnStbTnh2WGsfp1r
 gwKlHycgeryfaQGGvaB6IMIthhllNd7e0qRCyZlnKhORNKISv1PJsq8qjUH1bJ3t
 WS/jseNQVt1IAO8kLc1efjl76pzBFMCD0Pl9ZE2LgjZUtYraoLywKwbvmOhuLNt2
 fZWrA==
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4e5m6e0qev-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 14 May 2026 18:46:38 -0400 (EDT)
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64ELmSgA794030 for <dev@dpdk.org>; Thu, 14 May 2026 18:46:37 -0400
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com
 [143.166.203.146])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4e5m6m2a9f-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 14 May 2026 18:46:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1778798797; x=1810334797;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xXmFL2PnBAs/4OZs7ekP9s2VrRxy8G5Cp1/LQZGXBWM=;
 b=I4mshaajMo/R0rS9kJlwsLAFxhcIILpmNepuNj2TarzEHLLhhVNhU14Q
 5Xms0oVN7e8nHJwk3FDzC7AlG9lwX9xEvLzKzhC4vatB/rW2k1PV1fJsO
 sn5XJCXrih8oQbrns9AoGuK3x7CHr8e9mpaCueNMztlnNU/Cji/NsiwNP
 SBDT+YKxESTD5/xZ6d5Zk5jgaxnAGEz/tWJtusW3VM+oNFL50Fym80G7b
 MkUyXy1H2RtYIb/L2c4xfHwZf6Rh2wefurjiTAoDsrKE4Lm9jAuXGXTHH
 lt0meJ5huIOMlAxxT6MseNFYqvVzxtAa6BPIVbRdNUEaCYAF7SkZ0Wnwk g==;
X-CSE-ConnectionGUID: 64YR9MykRTGU02a2DU/jQQ==
X-CSE-MsgGUID: kp9MHG9jRouILb5DtMt8Vw==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv06.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 22:46:36 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 14 May 2026 17:47:51 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 14 May 2026 17:46:35 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 14 May 2026 17:46:35 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>
Subject: [PATCH v13 1/5] vhost: add user to mailmap and define to vhost hdr
Date: Thu, 14 May 2026 22:46:23 +0000
Message-ID: <20260514224627.2014566-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514224627.2014566-1-pravin.bathija@dell.com>
References: <20260514224627.2014566-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140223
X-Proofpoint-ORIG-GUID: aVz2MLRlU_LIdVJiaL4PeFIA7oC73z6G
X-Proofpoint-GUID: aVz2MLRlU_LIdVJiaL4PeFIA7oC73z6G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDIyMyBTYWx0ZWRfX1Frg4+nljmTG
 sHjPJ7l486OpqVsHNGqe+GHS7zbDuNZmhhUSzBwQnWvmF0gniCbu2VoSQpX2Bu9XXB2O7kRroGW
 Q8Q+SzOyuSXHOhG8/M0Yc0LqWSk42JMr+WrZ6Q79uJWNm+NVidQtQkolsLCzX1KUt2Ys1PHffKV
 BnxA5QDBZ3SxQIYS8IX7k9JZU9zOVaAQpQovZ4HVyVdNjidEbwfMdvl9q25WjgkRJMBfSAaLH7p
 4rEgvpfdqG2b1agVroqtKcSIBafVRupQiSCjXAOPHgUl0LNhH+YCxol+SY1/9ItdbcSyAL0dCNF
 9fdPz/xjVZ4bwGubcGQjS6SAuO0tW65mGg8/qIpUrNf3H6c8HzVGrOd7WXEdL4kA5L8ZczbxAM3
 /eJ0JL+VgkM+vb3LmjGt2D3/YG75J9IbuVZupWCH2eawi3y3hE0LILoC9xxvCBOA2b6w+FGttyq
 haMdoHduw6FL4Po9ikg==
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a0650ce cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=sEWawkeXllE7TocFc0N_:22 a=iLNU1ar6AAAA:8
 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8
 a=3CDqXdsAvEiB_ezhLkQA:9 a=hlJyneSgMmFPbskH-t2w:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140223
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

