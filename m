Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAB9CD37AC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 May 2026 02:02:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06A6C402F1;
	Thu, 14 May 2026 04:02:49 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 3960F402F1
 for <dev@dpdk.org>; Thu, 14 May 2026 04:02:47 +0200 (CEST)
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DG71Le2404778 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=x
 XmFL2PnBAs/4OZs7ekP9s2VrRxy8G5Cp1/LQZGXBWM=; b=HZS3cZFgOK48tjfmy
 Jd9TeQrsjZ3L3UuGRBSFdHFLFKXOkhduVAO4RspX2imxX9+JFbB52Xlzh6imNGJX
 8qgZ3mpX/t5rB958xEmytTQ6LpAeORZ0SnHPwkfMrsV8ZRBRKUh/AzCuuh70T9kJ
 4X2Qz0NtDoC2oq7c6wGQx35ugcyXaYIU+3KMWEpC91qPIZrSTs+qauIPRTh7ZvCx
 tRiA+z9h07FXAg2pYi2rkjkTizD3Vxn3q2vnC/Kx57tjR+w3JM8zP0n1yVUq6pRo
 AqIzBtR5MDBSpKwGyGodjcM+TNcdd1nTjgll5slYrDidJBMlfsRHkpIXOX17tjY2
 IU8KQ==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4e3nux3r53-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:46 -0400 (EDT)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64E1wqW62149129 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:46 -0400
Received: from esapsmtpat04.us.dell.com (esapsmtpat04.us.dell.com
 [143.166.211.147])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4e54ue0845-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1778724166; x=1810260166;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xXmFL2PnBAs/4OZs7ekP9s2VrRxy8G5Cp1/LQZGXBWM=;
 b=dlObnPxv2FR72rlLDCkOM1ZDmj8F47YV/lXuKv7ozlKRNxQrZvrlx8tr
 yXGCKeGZAax4qGS982XltYHDODFgvYm+0/dh7VJUlFDObTpfmvtQrzEjm
 0EgqzY/TooPQ27IJgJsYnjDuAQXDs4cpLKVMyw561d0gMZN6PeG5k8f+h
 3lV7TGYLZ7zLGOF+Nxr3N6t3vV89SJTV4vU49uEM2F0raDQRr/DN/ar69
 XrsNcSK4K55OPVaArFW14agYgL7xLjfZXAwnUdXkwp0cW0kwlSkIhFCDs
 +qqPno4L9pDpZA1I+E6T+Cg4pUb8lWTlFpZ/8xzLppC+48b8yubmg/jlI w==;
X-CSE-ConnectionGUID: N29szcpxSOm/SKlflbuaMw==
X-CSE-MsgGUID: gZe55N3FQhytappyr6WBlQ==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtpat04.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 02:02:45 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 13 May 2026 21:03:42 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 13 May 2026 21:02:44 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Wed, 13 May 2026 21:02:43 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>
Subject: [PATCH v13 1/5] vhost: add user to mailmap and define to vhost hdr
Date: Thu, 14 May 2026 02:01:53 +0000
Message-ID: <20260514020157.1937404-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514020157.1937404-1-pravin.bathija@dell.com>
References: <20260514020157.1937404-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140018
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDAxOCBTYWx0ZWRfXx7kvHAKloRgh
 pxt1i9xNt9l7VljsaP4Gf1p08Wi55nAUqWycBH/6IdqVkghHdG2kaZe4lcL8Ui0rp5L4asXlP/y
 2eevgIePS6ZrARLIu9y20gi9gsHkGdmigm32tT4DA5V9KDlAwb8lufYog8KbwnMj5+sUxt4pahQ
 6AGsCsl2+oyS3piFQ73a3rTCHQ/e0DGNbip5Guc91KBNwPyHNuMzRxeB0fJvY4jyhXSiyC2GAGf
 toAXYTGK96X9fNoB2G2vmU/CIbMrfENtKNJE3KChRGXRcPFwrucKHNnK8/VvjwsMQ+p2uK6tE9i
 joD6bSOCR4A3wTmkqcgKFCDXPxt3Js4r9uQWKlpOaqjuaGD8AO0Bb3yDyL5CMwvejljoW+SEt0d
 dnkZy8zUb3YSK/kibvi7CgxzOAs92xrFtBvxzpSHI0iordx9KBtUuXsMPKQiKPxRZGSoqBgFRJx
 4Zsz/Vxvx0+NSFQ+7SQ==
X-Proofpoint-GUID: 19FH3mG8KQXeysKhmqyVY79-zGwoLKYR
X-Authority-Analysis: v=2.4 cv=MO1QXsZl c=1 sm=1 tr=0 ts=6a052d46 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=xQoiRHjKKYbJmV+sD1MyuQ==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=PpEg0BoV_A2aca28hXd0:22 a=iLNU1ar6AAAA:8
 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8
 a=3CDqXdsAvEiB_ezhLkQA:9 a=gbU3OgOOxF9bX48Letew:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 19FH3mG8KQXeysKhmqyVY79-zGwoLKYR
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 phishscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605050000 definitions=main-2605140018
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

