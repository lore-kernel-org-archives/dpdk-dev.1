Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43696CCFA00
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 04:23:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E14740665;
	Tue,  4 Nov 2025 05:23:06 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 94E8040667
 for <dev@dpdk.org>; Tue,  4 Nov 2025 05:23:04 +0100 (CET)
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3MVrlx016241
 for <dev@dpdk.org>; Mon, 3 Nov 2025 23:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=Z
 sn+Z/QCduCaKMuDFmvL4M4O5YmHf8Qe2svD+a5KYO0=; b=UYWIZDZqxkrmonKBn
 suovKuFRLA0Rr2c0qAMgCYBEP4wXIa6+GPR2Jw78J7KmLChicx2ODFiA/nLhar1Z
 wX0s9RjKNY/wR/58TizaMBzL24Egip3QZBcGmj+fhBYJnwPCoYeKV8Xj88AQWbN+
 pAiilJBmORNa/737PrVnVNKokzUnMiFGc+jUEcSXNp4qb/cqNboJsDi6hjn7Y2/k
 rqnWosk6jTUIVT7FoXsPRSPDoc7Cz09ONDGkoN1u53C5jqfgQEORtu5A+nCWeNXh
 UOXbYi+lkQ40oYcIAa1SI1jzrejKz1WryQgpbY11xLo5R5/+jtXK3r4T53ExfywA
 +gB7A==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4a5de8axvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 03 Nov 2025 23:23:03 -0500 (EST)
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A42pWaN023770
 for <dev@dpdk.org>; Mon, 3 Nov 2025 23:23:02 -0500
Received: from esapsmtplv08.us.dell.com (esapsmtplv08.us.dell.com
 [143.166.203.145])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4a70dj7j0f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Mon, 03 Nov 2025 23:23:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1762230182; x=1793766182;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Zsn+Z/QCduCaKMuDFmvL4M4O5YmHf8Qe2svD+a5KYO0=;
 b=lKat3H7TZ1VK+LHB9PWhF/DEpX8CPgC4KBwFCNsDGiePx7tG+kE40COd
 f4LbNzEQLy1LUTutW5NQg1iIdNfcdn3/sv4qVSRoA4FBFXhbCxMz5gniu
 fmfOKeAfiFyfjc4QaQnAVUKa9UvEjK/y2Ffzo17Ge2Ox1lzo3sqCZeDlv
 yRK4pc191xM20/73ZBeUqGZ8vJHm6msQNoNwmQ5rEdOWXLPCJwo29ua3J
 Hh1t9ENikt8S0iLkUOxSJtG76lqFL7yLAUt+rT6ubeubxLrOaWZ72u2dT
 fx9bRWcw+v9kYBOWI6IiJMYKkfL4b+vfrrKAUgQO+ZZjHc4UnFtil0bm3 w==;
X-CSE-ConnectionGUID: wlyJ3e+eSQG9C6cMEBfyvQ==
X-CSE-MsgGUID: vQL5dCLSQo+VckHBQa6nnA==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv08.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 04:23:02 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 3 Nov 2025 22:24:01 -0600
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 3 Nov 2025 22:23:00 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Mon, 3 Nov 2025 22:23:00 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v3 5/5] vhost_user: Increase number of memory regions
Date: Tue, 4 Nov 2025 04:21:41 +0000
Message-ID: <20251104042142.2787631-6-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104042142.2787631-1-pravin.bathija@dell.com>
References: <20251104042142.2787631-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511030152
X-Proofpoint-GUID: q6GXIToeGKh2MWKVHhSMdua_Uzn6Dnzu
X-Proofpoint-ORIG-GUID: q6GXIToeGKh2MWKVHhSMdua_Uzn6Dnzu
X-Authority-Analysis: v=2.4 cv=aYtsXBot c=1 sm=1 tr=0 ts=69097fa7 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=7aFXbidJGpJUqALx8qt4zQ==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=v3BNB8zNHenIr8u7HDwA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDA1NyBTYWx0ZWRfXzVWccMM+S9B+
 yAqg7jLhr62Quast3ACfEqYy26THPIR2ef/SawpUDoUVmjNMi4V77yYbwPLd9AGv4+j900P8x51
 +FMeV+c0W75+l/uRfYGw7BI+PDZIEfc05tEds0PtlizX1F32xn7dylTRzr3OcajqMNA1sALmWGq
 Lo1B7nhMwfDG6CXeCqMIMsF6qQll4T4y1tOhGHWSGCDoSS9Xj7NZRrKdC7cVBZZONYFOErdryx3
 j+l+Z8Lr5gQ9EKK4cVQcnfRmKqGhi5yHOtRQzfos/VTrlFQCZAlvBpFj0D3Cr1zdS3YgfxpZ4Bn
 8eW9CN837Jjn/VPR6RxgHxUvN5v9DQVz4aCUZnE4ZRmns3vAmEyyd1tzwXwY4dM6f3GJ4C2quan
 WfiQyi9nBCjIssP0/xNmKYO/ZKnfGw==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010057
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

In this patch the number of memory regions are increased from
8 to 128. When a vhost-user front-end such as qemu or libblkio
queries the back-end such as dpdk with the message, get max number
of memory slots, the back-end replies with this number 128 instead
of the previously defined 8. The back-end also allocates that many
slots in the memory table where regions are added/removed as
requested by the vhost-user front-end. This also helps the vhost-
user front-end to limit the number of memory regions when sending
the set mem table message ar adding memory regions.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/vhost_user.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h
index 5a0e747b58..c6ad5b76d6 100644
--- a/lib/vhost/vhost_user.h
+++ b/lib/vhost/vhost_user.h
@@ -11,7 +11,7 @@
 
 /* refer to hw/virtio/vhost-user.c */
 
-#define VHOST_MEMORY_MAX_NREGIONS 8
+#define VHOST_MEMORY_MAX_NREGIONS 128
 
 #define VHOST_USER_NET_SUPPORTED_FEATURES \
 	(VIRTIO_NET_SUPPORTED_FEATURES | \
-- 
2.43.0

