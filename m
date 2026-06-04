Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB0ACD6E6E
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 23:57:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E879F402DD;
	Fri,  5 Jun 2026 01:57:42 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 97A2D40270
 for <dev@dpdk.org>; Fri,  5 Jun 2026 01:57:41 +0200 (CEST)
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654DHCHl2776346 for <dev@dpdk.org>; Thu, 4 Jun 2026 19:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=2
 EFreCdtjoT20CE+dLhGaLHEcNL1cfDAyoLCW6+L6xc=; b=q5SJv6Cquh3rf9FgX
 I7BfKqSgIvFCoMMUTdIGOxxBpsL7CuNxYKOARJAILL0PMqoLjlD20nuUXB8l+fhc
 PuSHXDD4DDF3lEDS8ot/9jeu0MY/8DW4nsNXscvwlGb+vfJ00guvyslXQS1pG6Oc
 gkM13Sp0A8YwAxwRrGgUHAebORNoNw2BhsjEOtxxgcKcT08eA63jWn2k1j8mLAPv
 fypjy6HjG6bsaNISJbtqkh8EcX8zp34S/q/G2ePR9bLsilcGX9pcmr3B08cAeDdr
 bTA1dRDp/MTN/DRea6D7dd251wVoGoBSv0HXa7pBIDlNLmbShFugWNkcMa6fdMTm
 QKbsQ==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4ej75hjcms-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 04 Jun 2026 19:57:40 -0400 (EDT)
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654KJrtO2756789 for <dev@dpdk.org>; Thu, 4 Jun 2026 19:57:40 -0400
Received: from esapsmtpat08.us.dell.com (esapsmtpat08.us.dell.com
 [143.166.211.148])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4ekga02fe7-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 04 Jun 2026 19:57:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1780617460; x=1812153460;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2EFreCdtjoT20CE+dLhGaLHEcNL1cfDAyoLCW6+L6xc=;
 b=q4ln7Bx3y/dvp/g8CXolS2EI6qTxUUZ1GKOaiXmgvMojwdvbm+D8VF9e
 BvC5M3kFZIAtns6SZjE0E212QdgWJqpVFLiNRfsenw8OkKsP6JZHCNaXM
 dm37Sud5o5eKObkPtdOhcEh22XZOGjM9a0wmnh7sF3A2ybPtCbQ6NmD2d
 MHNtZM9ZTdD+gD0Przef5yYKOjq5YfWkOOfwY6qp9KkisIHfblwLUoWUL
 KzMcSo8nSB4/FAV3GYCzm8D728AsJSUgWcKnda/47aqhMx5qheFVB7YO9
 oAQURpbitmytK6Vnb2wtwFBfDak9PkIVPmoMDmDCJ1jLdKMWvouj+7ltF A==;
X-CSE-ConnectionGUID: KiZb94D9TUm002Ndi2TVWQ==
X-CSE-MsgGUID: vYYXFf1WROiS63efeZJMfw==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtpat08.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 23:57:39 +0000
Received: from ieorr5-ppwem001.delllabs.net (100.64.0.132) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 4 Jun 2026 18:58:48 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem001.delllabs.net (100.64.0.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 4 Jun 2026 18:57:38 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 4 Jun 2026 18:57:37 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.com>
Subject: [PATCH v15 1/5] vhost: add user to mailmap and define to vhost hdr
Date: Thu, 4 Jun 2026 23:57:19 +0000
Message-ID: <20260604235723.1046607-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604235723.1046607-1-pravin.bathija@dell.com>
References: <20260604235723.1046607-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040234
X-Proofpoint-ORIG-GUID: Cf9K2UTsU9Pmkm4A_JBBuJhGe86zMSvk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDIzNSBTYWx0ZWRfX5NP8Y6j3jXjW
 kejMKLdrjhiUrEXypH6njpd+l6N8lvDUvS2c5z7ArBCiD/hXCvpNZLN8TJFULjEgZExgsqtrzta
 dF+SqCDEJ6Bsjy5Cjyp0QwKytg7RChz+kLnjaAXJ01ipWom5qIZYlg7Y7nMoI7WenmMBeQ8kRxl
 3HDXasU3aLiGNmBNzHNDNQ0DugtM6jUGtqt2Dck3STZA4O5pri5hD5uQjkKOCCpNo6mBiVsAz6x
 W5uw4kQW/K0RAqAsYMBoqplya7m5wrPGNnO+A6NzjzPEVNzwO9D7GwdRpcXhBZvRtFuRWh5br6C
 pEOwHxWPO3iyENYFGWACJ+X07UWrWHlxkv7A/CVOK1kY7ZvZSWNNpj0mniJC/hJPeIkgfYwgZsb
 v2pKKucV2dTsp7w8OGzVlHQuahrQsbkgfv5JBid9R4yiHAbt3WoZPZq7vRdl5wzcXyRJP1UvboF
 jdti7BXyHKsQGTxE8mw==
X-Authority-Analysis: v=2.4 cv=U/Siy+ru c=1 sm=1 tr=0 ts=6a2210f4 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=yMHKiRmgHdO7ybaHu+/uXg==:17
 a=FelO9ux0wxsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=m3zZTHMLHbwB7Lmtoed2:22 a=iLNU1ar6AAAA:8
 a=i0EeH86SAAAA:8 a=CPuvAHPoAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8
 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8 a=3CDqXdsAvEiB_ezhLkQA:9
 a=gbU3OgOOxF9bX48Letew:22 a=r6J0Z2L7KMegjY60bkqS:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Cf9K2UTsU9Pmkm4A_JBBuJhGe86zMSvk
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040235
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
Acked-by: Fengchengwen <fengchengwen@huawei.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.com>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
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

