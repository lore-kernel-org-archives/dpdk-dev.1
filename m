Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55541CD6E6E
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 23:58:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A25F240676;
	Fri,  5 Jun 2026 01:57:57 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id AFA0340270
 for <dev@dpdk.org>; Fri,  5 Jun 2026 01:57:54 +0200 (CEST)
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654LoOY4671702 for <dev@dpdk.org>; Thu, 4 Jun 2026 19:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=w
 J9Pt/hsOn8QghHFVQR6VjG7J9F4pOKtAPLIvqBGDAY=; b=FdFtDjsBAB6TGvatf
 f8Qy6whnAsDQUY2g6lPzehGiZCnblI0QRIWxoBcY1GTAVWcebvweyq4q9JK2Ueg4
 ZV8fxGhWAT6N4cb0SOzBVCYa5ptv/AzNojUOmtIMnBoIgAyhJAJHViDslMLoMG00
 d5XYv0JTTNjEdF2rNb3YBQmggCixvbguuaP3Owjg0VUk/s9jvdmKnEckDbLL6qZ2
 U4GQ5pseHzH7CtpLb4YMM46B+gMZg97QDNneFvt6ozxwo35RYfx4u7dVxjwbVe7i
 mIst1awSuu5EkahmcMv5PeLbmTjMtcFuLnvaC481y3khcZ4LtBruFRmcrzfjtNtK
 9cdBA==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4ej75q2b8u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 04 Jun 2026 19:57:53 -0400 (EDT)
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654M0nuR1586819 for <dev@dpdk.org>; Thu, 4 Jun 2026 19:57:53 -0400
Received: from esapsmtpat08.us.dell.com (esapsmtpat08.us.dell.com
 [143.166.211.148])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4ekhsk9921-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 04 Jun 2026 19:57:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1780617473; x=1812153473;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wJ9Pt/hsOn8QghHFVQR6VjG7J9F4pOKtAPLIvqBGDAY=;
 b=VZ+6tE0xMFW+XesQR6bHs/Kyvj0ZmWn0Mo5XbUGPK1OLipm0Py/Xhj90
 IXJZaMHK78raH19YFcOxF0YKgXRhGYMCluHTwAOqqLR2XBHhxWUdqpJKD
 5qWdd2o9UpMoVzbfFvcUeNe6L82CiZ7M4L20+8nPaW1rmIZFxw1w84yuw
 yA6papBoDkvjq5Yc9LkHLlC9kn7Fqj5E+ZqA2z03HPwbVW2O99tRg9Dz5
 zQaD1EZbrT6YpezdCxncBsK36EFNL3cjnf083vkLi3rdU9bYTEYnREVJk
 RM4SMc0sdBEpKDHu70vWe+chahmLHjVQUGpPeoCF90ncUSM1sQhI9KC3H Q==;
X-CSE-ConnectionGUID: AJzIswubSEqIw9eawquI5A==
X-CSE-MsgGUID: F5h9CxXbQbSxC/WpCxHlMg==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtpat08.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 23:57:53 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 4 Jun 2026 18:59:02 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 4 Jun 2026 18:57:52 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 4 Jun 2026 18:57:51 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.com>
Subject: [PATCH v15 5/5] vhost: enable configure memory slots
Date: Thu, 4 Jun 2026 23:57:23 +0000
Message-ID: <20260604235723.1046607-6-pravin.bathija@dell.com>
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
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040234
X-Proofpoint-GUID: dg6od-sjK0fd3tIZZSwgnAO16v_09prZ
X-Proofpoint-ORIG-GUID: dg6od-sjK0fd3tIZZSwgnAO16v_09prZ
X-Authority-Analysis: v=2.4 cv=FpU1OWrq c=1 sm=1 tr=0 ts=6a221101 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=yMHKiRmgHdO7ybaHu+/uXg==:17
 a=FelO9ux0wxsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=gLxAKuEMs0EQMVFiDJnH:22 a=iLNU1ar6AAAA:8
 a=CPuvAHPoAAAA:8 a=i0EeH86SAAAA:8 a=20KFwNOVAAAA:8 a=rZn8xLF9xNrzFNIxwagA:9
 a=hlJyneSgMmFPbskH-t2w:22 a=r6J0Z2L7KMegjY60bkqS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDIzNSBTYWx0ZWRfX6FacZoDBtKJb
 S+mwVzhQ0GgB/hCOftvJ91ljQJFt4Mg0DDq/nohJ2car4Qt20Bha22Ax6wOvZ59J02Oqj1hJiJN
 Hwp/BSsCOFbCzjHmaFrvQMZxmm3Yntr5PskVVIvevJooHtlZqzHmXz+c0YHEzFy66QVE8L69Elt
 BLMeY7b07jwQVwClso5JriPHuSYmEkHThfp47zfVbN177uQSkG/KIs8a2S4ZGckNWLvSAlAhLrX
 QOkCyVPLY6ju55VcYlmBQaSyQlTMzW+TU/uMnPphUCBGnHQeM49R5sOAVRDq0tC77FMjHrGBdtY
 A90Vxh5vRed3LLIOU/bgHbHPKnWA0dUXtrSbC7/c+tky4azSbbZDmoj9U81s1+/w0nRWKUvzyg8
 lMRJ59GQh9oC0W2df18HWDjY9Vo92C2iqAJNc6Zo8oW94i0BCP/Vka8Htud7UMPP4PacXtr4rHw
 VuLl4EQJf+W1AOZXrBQ==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0
 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
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

This patch enables configure memory slots in the header define
VHOST_USER_PROTOCOL_FEATURES.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.com>
Reviewed-by: Fengchengwen <fengchengwen@huawei.com>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 lib/vhost/vhost_user.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h
index 6435816534..732aa4dc02 100644
--- a/lib/vhost/vhost_user.h
+++ b/lib/vhost/vhost_user.h
@@ -32,6 +32,7 @@
 					 (1ULL << VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD) | \
 					 (1ULL << VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) | \
 					 (1ULL << VHOST_USER_PROTOCOL_F_PAGEFAULT) | \
+					 (1ULL << VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS) | \
 					 (1ULL << VHOST_USER_PROTOCOL_F_STATUS))
 
 typedef enum VhostUserRequest {
-- 
2.43.0

