Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBA4EDB7CC
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 08:06:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D36E040663;
	Tue,  7 Apr 2026 10:06:28 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id D8E63402C1
 for <dev@dpdk.org>; Tue,  7 Apr 2026 10:06:25 +0200 (CEST)
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6377UO1L779301 for <dev@dpdk.org>; Tue, 7 Apr 2026 04:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=Y
 i5QHAoQ6KZoP2SXZVIKMjyPk3zbIhTVz/MGI/fyTvk=; b=WmI25NT3CUo3obcHN
 kavUYj8S5MwxQLLK75qQWZ3nLFni8uU37++OdndYccJWLB3fcCYo0pEJMN0787cA
 UeeoP2r7hNK/ZBrvnudSZL85YgI261vJpq2m7kKvm//Gj9+XAgT1Px4IDrsVZmjB
 WDwaqURVegtyzYkTUZoGl47htjiTDzTvht9vPqhs8ru/Lvr2K98d7eU/84pYUrB3
 bzlgNCcSy+GL+9/xwTD7MZUf0uhvXOffRPAkrhcLbINm8JiUUbPwWAHcVA3K4n4J
 WUg9tW5w6tjl6g3Oh3tq7VL8Qv5RPhtgxscQBX69GVYegsTyieAGwMFV+rQZNyHO
 WHPEg==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4dcmsytg4c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 07 Apr 2026 04:06:23 -0400 (EDT)
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6377hTAa958624 for <dev@dpdk.org>; Tue, 7 Apr 2026 04:06:22 -0400
Received: from esapsmtplv05.us.dell.com (esapsmtplv05.us.dell.com
 [143.166.203.153])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4dcwsp0ad6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 07 Apr 2026 04:06:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1775549182; x=1807085182;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Yi5QHAoQ6KZoP2SXZVIKMjyPk3zbIhTVz/MGI/fyTvk=;
 b=KGsuMyUV6X6acw+skEHxMC12aFMJNX2r0qWS5VibOcW72yTFhTQ3d7KI
 14IAANkxDh0jvgGC+HVvSo9KozJLFWgarQBUd2wXm1Zb2SEbLmutBFKF6
 EO9MJesy6aK6/DOIhEl/K7ON96wGZqpF9gc7ZqmxpDJ0jcsboOQH5vTsH
 Nj+tNopYb/KImP7a8PJ/4Xy4bepzPlxktXjQESD7TtpuvGsUW93IGhBt0
 Dw82of9fIBjiC6DfbFEfakzBUiMVhn7mxtKN9fzl6bbOICTc0xA4fHTkq
 5MGvLlvNA1Y9ULZL6aYvRwsRm0msPtaFskEAS8vS4tCJlF8CBDAFz/MwM Q==;
X-CSE-ConnectionGUID: Oln5lg+zTD2zuIqez9keDA==
X-CSE-MsgGUID: 6AGWik4iT2qo3sRjqQtgaA==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv05.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 08:06:22 +0000
Received: from ieorr5-ppwem001.delllabs.net (100.64.0.132) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 03:07:14 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-ppwem001.delllabs.net (100.64.0.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 03:06:20 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 7 Apr 2026 03:06:20 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH v9 5/5] vhost_user: enable configure memory slots
Date: Tue, 7 Apr 2026 08:06:36 +0000
Message-ID: <20260407080636.3878354-6-pravin.bathija@dell.com>
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
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070073
X-Authority-Analysis: v=2.4 cv=OYioyBTY c=1 sm=1 tr=0 ts=69d4baff cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=t4Iba6VQkoKuxR139xjPXA==:17
 a=A5OVakUREuEA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=fe1keu9KhAX5AoWrZvs2:22 a=iLNU1ar6AAAA:8
 a=-L3Ti0Wm1PsFXVv1eAcA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-GUID: 99SnYmsMKKOdCvQEflGtkMUPtVZ7jDXV
X-Proofpoint-ORIG-GUID: 99SnYmsMKKOdCvQEflGtkMUPtVZ7jDXV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA3NCBTYWx0ZWRfXzT5iDyhTgkdZ
 O9VXk3TWZO6P5ygJR6TvAs7WLXzhMs/+qgJn+7ewvDI9iQwEL5DZN/kHevB1ZEMXZI4kXVOxSXN
 WsOwNEFAKAIlfdX8uO/lA7qjzlLTg/fUqMZi9aIUXG5bMgpnvwD9QY90KedzpciKRhcLLBYMUpG
 Ejqkl1/b/56+uXehwvbodVgfULYLLPPd5hztGwXMO8nH25votvb15jeEd8zafhm8QpT2xrnZuaz
 aCOsZkVapyhrrH4aKgxucmOyAabAbcLBB+fE0M+xmSTQaBekrGPideUCzcfr2iHoAlRTrsk9yxf
 ShuoFtnVjUaoljRMmtxmulDx+zlK5y0dqRVrLeGTEB82SHwmt59jGCkoTUvjnspSDFQHEVxHCj7
 p7myz7nBw3t8lPU4tQ+UGhfBZdZ1ziUfLGA8f8VZQg4FUYKwIzBVW4WytRdL410oj6rQoW2IQce
 1bk0KxaA8I/MgDtm0EA==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070074
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
index f8d921f7f1..5a0e747b58 100644
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

