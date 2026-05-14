Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49231CD4F21
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 May 2026 02:03:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30D474067D;
	Thu, 14 May 2026 04:02:56 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id B2D43402E7
 for <dev@dpdk.org>; Thu, 14 May 2026 04:02:52 +0200 (CEST)
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64E1bXwl2392851 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=R
 Hf3Qe8PMPymFQlQCfrM0u1RZk8xe7tD8E5j9JH1BUY=; b=YLy5SOARcgmFGomKA
 NX60pWzC7oclIqTnNtrEIbdYPuTjOYswc5zd4elubIXTzHzdsAYA16CURPsNFlyu
 Hh7GZqYlvIusWH4VVWW8KIY07qf6dNcbwVt7bnm5TNWACJ7ClxC/4ki4t3kB7T7g
 IGiDXKQlfaeHI583fvtJNwj57JCaJwBb0efvi7A6y6MAebTmw/+y3mNOYrvUAgGG
 OxHoFxZQPnospEay++lxMMmYtmE+YU+z1Cm2wEnJAl+SJwGsqk2X3pHbQJ0W6ktp
 O/pYR+tCsXYOxR55H+Zf59vlh31eBj9Gt50Asilsps9l7oCe2EBbMiJgGS2cUgef
 ezxVg==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4e3nv0kqhd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:51 -0400 (EDT)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64E1wqW82149129 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:51 -0400
Received: from esapsmtpat04.us.dell.com (esapsmtpat04.us.dell.com
 [143.166.211.147])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4e54ue0845-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1778724172; x=1810260172;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RHf3Qe8PMPymFQlQCfrM0u1RZk8xe7tD8E5j9JH1BUY=;
 b=UfoJfnAcDxO7ZymuIAAyVOQRy0RAFfKJpELeYGwMYhpdo5wa4/rXc+s9
 /Q/wH8pYk3Rp6NLK1Pwp+FF7rOU5guO0IojED6rKIUV2qmrOBFRYvMXW2
 Q1JIo6dN86VmIw8fTAMr9v0ws5MlvwoGp6Lu0cTy5q2KeraOPybDQJBNs
 V/jaz7E+B0MUjSdw0qKRuCugKmPvNg25luXhsX1TDvxViVFxVFSz2TVu9
 TsaAqZgejdK414pBaw74+iEo7uGFnsriCOp2QYKB19OTz0BsgkQ7pQdgd
 0afYFamAa4YPx7wuCaDjJTY7dqGlHRo6rVL4y/nSTLpenz61kIgZSYtY/ g==;
X-CSE-ConnectionGUID: LCVfiNEhSc26XBk1KInv9Q==
X-CSE-MsgGUID: yjEoNb4ASeO6rXp107L5wQ==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtpat04.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 02:02:52 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 13 May 2026 21:03:48 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 13 May 2026 21:02:50 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Wed, 13 May 2026 21:02:49 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>
Subject: [PATCH v13 5/5] vhost_user: enable configure memory slots
Date: Thu, 14 May 2026 02:01:57 +0000
Message-ID: <20260514020157.1937404-6-pravin.bathija@dell.com>
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
X-Proofpoint-ORIG-GUID: e3ZvWXHNuTYJ-smIQLlnZ5Xh-klUWmrs
X-Authority-Analysis: v=2.4 cv=G5cs1dk5 c=1 sm=1 tr=0 ts=6a052d4b cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=xQoiRHjKKYbJmV+sD1MyuQ==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=2Lpba0WeoN7BYVdwMO11:22 a=iLNU1ar6AAAA:8
 a=-L3Ti0Wm1PsFXVv1eAcA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-GUID: e3ZvWXHNuTYJ-smIQLlnZ5Xh-klUWmrs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDAxOCBTYWx0ZWRfXxvSNs3kZnySH
 56GPPzNApdS44j2hH32eQWzF5pwtbtW+3ZQO+nby1O7QEoY4MuzbWlOvpqGyl4AbCdX0wvak7Mn
 uvktiPUJJgTRbcpQdKwFaWbjH+sLDDRqPActkYDtvPfl3YpvkJrNDma6V2miZw4YKKL62JTYW1T
 CJcG6NbI0wR4lENVAYueU/kVKv9JvA4M0JAYoYRznTKuaOTdJRX7QXo/v1SFpbxgmBpg8QTcbx8
 H5p2eT4vQ3MjIBw4wHz1rJGjcPcuHA2zfoO4gM1WP3I4jYdl89O8Z0IZifLVXr9Ggc86bSjHjHB
 OpDBzRMkGSrbY6fI5tD7l0YP3Nr6L8Q8wtooBhzT+ZbygVDeY8t5Jf0RHIwO042y0J9zFEq2DhX
 71wlo1VwdkX8UjW02LuqkvWwRMOkban2q/kUVQaRSSqWvKdUL+kdKwXimGUrqOuS3qv+NRO/L0q
 ynGPYhf5iLIxbUFHUrw==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140018
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

