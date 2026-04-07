Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2115AEDB7EB
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 22:41:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BC3F40649;
	Wed,  8 Apr 2026 00:41:30 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 69EE2402DF
 for <dev@dpdk.org>; Wed,  8 Apr 2026 00:41:28 +0200 (CEST)
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637LllR1139124 for <dev@dpdk.org>; Tue, 7 Apr 2026 18:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=x
 XmFL2PnBAs/4OZs7ekP9s2VrRxy8G5Cp1/LQZGXBWM=; b=e1Q0E4b1ds4ZKkLJ9
 3NI/Fipw9ZuiMg29WcOnyGmxRl9kN8b/3bV44S90uVY5vUiUp0/Fn+alFQ4WhGoy
 qWfXB1GtTIf/g5Gi1qc5jTcsAGP4iMK7NIc6Ddxo1XiOtvlu3QxOEC/85EcJzgEV
 MwjaA0bDwJnhcKSusS1TzrpZFuOKdHz20VK/jTmhKp5m4AMKW9f318l7OoZicCzP
 Z9/rUGoziaY+Qofzc1isBiVKxrg8WGDXjhsbZSHe67WmLRcSriDORbFRDVIcvYs9
 6KS7wtcYH5Y+gzKK1qrrdz9C4XsKIMLCiYgJme4wNErMoIgIDzBRDRxN/Xo/PwNM
 rG2Vw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4dda4xg7mb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 07 Apr 2026 18:41:27 -0400 (EDT)
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637Llsu03938245 for <dev@dpdk.org>; Tue, 7 Apr 2026 18:41:26 -0400
Received: from esapsmtplv02.us.dell.com (esapsmtplv02.us.dell.com
 [143.166.203.150])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4dda5g8mah-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 07 Apr 2026 18:41:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1775601686; x=1807137686;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xXmFL2PnBAs/4OZs7ekP9s2VrRxy8G5Cp1/LQZGXBWM=;
 b=B2e++b6pxCnBivrKNbIyqj/srMxRNU/bFQ8VTuJ66IfcSo1XwO0ckXHd
 snKl/Y241hS51/z3ujgCXy1WOGsRwPIB0oZtvUvnSGEQRj0qbBDsCI8H7
 xH5HOSt73Ymya6VmnETdWSL2rSbEwPWuTipTAcAj8PUD4xYG8AMNI9CXR
 QTyMJeBb/e9FA5yvQxgbu0enstAn7+QqGJ+H076Uksd5LTxfjMwmRzK3R
 m1DxfqOYGgtdW7U9Rj91AWwCYnfQHWcmmtPY+tsPCPYXYJjYPt+HxsUmq
 v4HvG9k5MqnDGTQhei0p2fIb2SPmsMGaKOFC+4f/8zL0rFlmpHq/PjraQ Q==;
X-CSE-ConnectionGUID: PyPibmF0TcaT/yh+3Ottfw==
X-CSE-MsgGUID: x03CwcM+Ss6cI8i0YVqaJA==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv02.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 22:41:26 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 17:42:18 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 17:41:24 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 7 Apr 2026 17:41:24 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH v10 1/5] vhost: add user to mailmap and define to vhost hdr
Date: Tue, 7 Apr 2026 22:42:01 +0000
Message-ID: <20260407224205.3910803-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407224205.3910803-1-pravin.bathija@dell.com>
References: <20260407224205.3910803-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_05,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070207
X-Authority-Analysis: v=2.4 cv=OpB/DS/t c=1 sm=1 tr=0 ts=69d58817 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=AlKjE2zswbbG9QqlC8cQbA==:17
 a=A5OVakUREuEA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=U3ti1ie9CgboSd2qXsAw:22 a=iLNU1ar6AAAA:8
 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8
 a=3CDqXdsAvEiB_ezhLkQA:9 a=gbU3OgOOxF9bX48Letew:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: hHT-XLsKNrLCgvq-ri2bA747hrkXfuzO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDIwOCBTYWx0ZWRfX8xFVKkDYHTAa
 R2NT7Ovc3N2OANbm0pEtEJkpoVhtZ7kifMtZM1kgUYCM+q46QABrfQyzZxevHVk5GFBJFpA7lm6
 QLiyqJQ+4Ae5llouYesHxCwgNK9eI4JMio/EneBMsiP48zBb+WXB78t6KXaI/K8qFP/CSDkuQRQ
 vkAv2rgL72PmcC8Qa33COiJa/Xl/3yWpqYYu6WE/pRg7yV9M09twCL1kg0WvlMkVewaZ5ZiLLjA
 OPGp4WX6oAPZUn0RSeq0O5cIqS2/RnbqX02XTBkICinH+XO6pkLtiJq7AOHKDblxdIVUWC8/t7L
 an5gjYewX+HEZWfKhoGxh/wKEhbJebG+ESFG587O+lneJccrl+d9bBKwu+o6Dkbx/0vKkfChuY0
 WRmeaxK0oQg1krWm3QDnRaEIwOZHeSjk3aKN/kw3kq9FEuUlk/oT4+PzhOAk6Rqy+U5A7xjnpyH
 NutbwcKEMz8/cmyshmg==
X-Proofpoint-ORIG-GUID: hHT-XLsKNrLCgvq-ri2bA747hrkXfuzO
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070208
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

