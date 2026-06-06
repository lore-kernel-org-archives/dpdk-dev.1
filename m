Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84D9CD8C88
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Jun 2026 02:52:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9552B402D5;
	Sat,  6 Jun 2026 04:52:22 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 62E564028F
 for <dev@dpdk.org>; Sat,  6 Jun 2026 04:52:20 +0200 (CEST)
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 655LPVr72776350 for <dev@dpdk.org>; Fri, 5 Jun 2026 22:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=2
 EFreCdtjoT20CE+dLhGaLHEcNL1cfDAyoLCW6+L6xc=; b=eMlPXLC6VQyjSrs34
 iMKDG+EE55pNLpQc+DbkKM+fvo7YezrfuERQQByGFl6WmgrhesX/ktWRzvzlRKKE
 ME+S8Cma+74tRNLgXjt/U7xsPOtcmb72QPnwHPPfS/OqYLAetHefi5VgnLtOQtnn
 O7nBkZ+UCd7WpTz0Do8Ffk2X7ZZzRALxwJ2scYBY4BFDfpiw/ogMPkg6RTz5aFMy
 J1zqwynWCHPJxwQANT50gnN3SFrNCWB9jrrHDsBXVBVt5smzwSNLnR/68R7h/dA8
 ims5lmN20DGjLJfXNUaajacVZTkjQTwROvSLFG8s0VbnEt/ffaVwZNNUxE2bQ03Y
 /n6Eg==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4ej75hqu8k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 05 Jun 2026 22:52:19 -0400 (EDT)
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 655MFH0e2491284 for <dev@dpdk.org>; Fri, 5 Jun 2026 22:52:18 -0400
Received: from esapsmtpat04.us.dell.com (esapsmtpat04.us.dell.com
 [143.166.211.147])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4em6qrk7yb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Fri, 05 Jun 2026 22:52:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1780714338; x=1812250338;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2EFreCdtjoT20CE+dLhGaLHEcNL1cfDAyoLCW6+L6xc=;
 b=GoVAK9xPWqQxqu6pUzDMdRzIPUtO/c1xZxyXhXbwBJLFdzs8yARCYZtQ
 YX5G+EYTpFsTghUH6hssqnxVkqwyF2rGSvBRpB6fpA/KNYA2H5fOkfl6W
 jJN6bJLj5EfCh0Q+BFO9l7halCUdZm0LvVuLoFVgbAW0j2hpu3Wsr9hBd
 fU1BchsC73/nXDhLs4Jbq66SSVT4yjWDxLBY+lVUKOQ/GADec6pUpB1KT
 5Q+jTuVNdIbsfu1LIKLayxNZKFbg6oG7uzVcHU+jYt6faQOyl2hJ8W5ds
 q5k8ta4yjYtoGehOQ8IoTkatheAiw7/4eCqdD7TfOJaqFDsYP5Maz4bMa Q==;
X-CSE-ConnectionGUID: 2DtQhiDCSiOuEjU27VtqEQ==
X-CSE-MsgGUID: 97GlNBS7RFu4col3uhdLog==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtpat04.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2026 02:52:17 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 5 Jun 2026 21:53:19 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 5 Jun 2026 21:52:16 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 5 Jun 2026 21:52:16 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>, <maxime.coquelin@redhat.com>,
 <fengchengwen@huawei.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.com>
Subject: [PATCH v16 1/5] vhost: add user to mailmap and define to vhost hdr
Date: Sat, 6 Jun 2026 02:52:07 +0000
Message-ID: <20260606025211.1082615-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260606025211.1082615-1-pravin.bathija@dell.com>
References: <20260606025211.1082615-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060026
X-Proofpoint-ORIG-GUID: NepwyopKdEDQFKH0xNZRa3nN7S8xeIsn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDAyNSBTYWx0ZWRfX4tNobcKc2f76
 QfQzEjrpV2hkRkrx5UXkyfLCakTff9jpVXV0KTsE6+E5vio7s5Oo+Bx81mwAw1Pjlmm0fbzw8fS
 5TGJ9zWc1r+OvGJeCu9429zwJKUhz4s8koZnnC8g3ggnogPJ80Q2tPsR9D2siZnfY/hnnMVLcVV
 WGJEz+fw/VtiJK3FhVvyfYKafY29oAszexayeHVmMD6L1ttIX2uh/w90N5mKVD+oFZPibkJYPub
 Ikxi8R+KwSSY2Dr5SXqigBJ9gbkgB6+l87Fx8kM5H02IW1naZYmZigGNZzQPln0cGcKLzn/kz7P
 d4D7vypQ1UHDjmNXZGma5MFcgGA0fb1m8JW7WAjrIfKnGS5CKzPgvd+Haz5R3AfSYYpw9D1Id+J
 iSC+SBkgMiXzz0nKaAbtRUDN2dYR3UtfShSKyAE5YiSYg6ebg6hMZofFPDw4d9fPi+za46dDt2i
 7VUCowyjHDlJGOFC3gQ==
X-Authority-Analysis: v=2.4 cv=U/Siy+ru c=1 sm=1 tr=0 ts=6a238b63 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=xQoiRHjKKYbJmV+sD1MyuQ==:17
 a=FelO9ux0wxsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=m3zZTHMLHbwB7Lmtoed2:22 a=iLNU1ar6AAAA:8
 a=i0EeH86SAAAA:8 a=CPuvAHPoAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8
 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8 a=3CDqXdsAvEiB_ezhLkQA:9
 a=gbU3OgOOxF9bX48Letew:22 a=r6J0Z2L7KMegjY60bkqS:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: NepwyopKdEDQFKH0xNZRa3nN7S8xeIsn
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060025
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

