Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78241EDB7CC
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 08:06:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37569402C1;
	Tue,  7 Apr 2026 10:06:08 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id E180F402CE
 for <dev@dpdk.org>; Tue,  7 Apr 2026 10:06:06 +0200 (CEST)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LRu7j793668 for <dev@dpdk.org>; Tue, 7 Apr 2026 04:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=x
 XmFL2PnBAs/4OZs7ekP9s2VrRxy8G5Cp1/LQZGXBWM=; b=E/dBj39rE2rjoPg1y
 gnof7SKMnLuPyf7+BvwW0B7ZJBUNX2kLsbc+2CVSZUnNmKM7adx7e/fbDfvl4X93
 5rqOtpmII6vSCpVHbbAY+zim4xOVgOcrth/dcoLDZPs6R8FADmJjf8aFSTjNM3vV
 3fthvitfwoteBysifJYIzitdj+sCWi2GnmSv3AfNg18UKIKNeJa9l+I7Rt5Tvp9k
 TpLUg28DYZrVoaODHteRHY9k5yHcKGIAX1hx2AvMWVnkE3L4xV1jldsjJc128jmJ
 tZgqH/9bjHIds39NJshnTkTCyn4R0msUPv67fZUXkM4VN7HxBKz4LLNTuJPnhzU1
 Nftqw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4dcmrwtftg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 07 Apr 2026 04:06:05 -0400 (EDT)
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6377nj5J1471920 for <dev@dpdk.org>; Tue, 7 Apr 2026 04:06:05 -0400
Received: from esapsmtplv05.us.dell.com (esapsmtplv05.us.dell.com
 [143.166.203.153])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4dcvbr1kj4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 07 Apr 2026 04:06:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1775549165; x=1807085165;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xXmFL2PnBAs/4OZs7ekP9s2VrRxy8G5Cp1/LQZGXBWM=;
 b=EPy6fzK1RbZu5tb5NYTVGLk9yNCOavNH/KGIUFieCBhMFjkYrWyikV2q
 2ArDfDSaw5OIpFqngR/JjYzql0f7w8uqOqhYDrtXCfHKPn4FSOnUaipP3
 43qrLN5N/v5mn41eeMxUbHiFtHtJDrXd6wJdAlUxLv5SYhe/am4QEpGsx
 t0xAfv924KQx/44k+vv5blXzed46c1Wp0D1NyXOQpTgrJZ/rjPFKKs/pn
 OwyQ3BfKaHfeNiwRLXeC6c5IhoI60hIa+zNHdAViUnKpxrdDCw8RSnFFm
 6smxaAMHvhndFrjwLop8VLOhruBh2CBlizzwOjS68aUzrsx2DvMzrYKmU A==;
X-CSE-ConnectionGUID: /sAJoDJWRP6fQZ3UNgTvjQ==
X-CSE-MsgGUID: WqR1L7d0TdWVu1KM20ztiA==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv05.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 08:06:05 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 03:06:57 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 03:06:03 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 7 Apr 2026 03:06:03 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH v9 1/5] vhost: add user to mailmap and define to vhost hdr
Date: Tue, 7 Apr 2026 08:06:32 +0000
Message-ID: <20260407080636.3878354-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407080636.3878354-1-pravin.bathija@dell.com>
References: <20260407080636.3878354-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070073
X-Authority-Analysis: v=2.4 cv=a/gAM0SF c=1 sm=1 tr=0 ts=69d4baed cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=t4Iba6VQkoKuxR139xjPXA==:17
 a=A5OVakUREuEA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=aNt9FJNJ8fZyd9HhltU_:22 a=iLNU1ar6AAAA:8
 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8
 a=3CDqXdsAvEiB_ezhLkQA:9 a=gbU3OgOOxF9bX48Letew:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA3NCBTYWx0ZWRfXzsyaFvU4xnDy
 v+K9YYCTD3ew5abCXa7wXKySvJ6bJBZisBh/Gw52fyhwnk3UggpGIrKxr+0BcsjG7B1rlksFVIG
 NJMFB6pBaNSqSMMU5GB7UTzPf9w+u/82LHHuQyC6HSpuRSmlctS7ddZ0W//gQp+Xv33ap9jLHDN
 +2HlpBMyx3wLYNDDgXsP5o2m5VKq+EIPFRyyCHS4KuriEessluzJVAga8hkpbmxttXz2KTkexE+
 OgnvQBajhBf9idAF4JfC4kZ8FQZLncawY84cVjwiFVhbEAHKpOsyDJg+foH5guvp0OU4ZfpBN4K
 wC0ttnD0evE8zpj7Id5lcZHaMRluyfz6v2AGeH8LsE5Z9vSyDV9LA/mxp/BqNLTBeZQOWorUhO8
 jEuOxSRu1DPu/VrB9gpAzMBQrqsdbK/5ktWq4VfgpDdIn+pAGcrWyr5mA6h2kGLY3z1XNjV1TX1
 NNx/B8q61BfF2zxxsLw==
X-Proofpoint-ORIG-GUID: 1-jFRcuR2ZN-csthSFP-gONZWK-O__An
X-Proofpoint-GUID: 1-jFRcuR2ZN-csthSFP-gONZWK-O__An
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070074
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

