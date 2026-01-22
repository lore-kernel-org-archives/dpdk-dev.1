Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1ACC44500
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 07:49:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7769C40611;
	Thu, 22 Jan 2026 08:49:03 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 963AD4060A
 for <dev@dpdk.org>; Thu, 22 Jan 2026 08:49:01 +0100 (CET)
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60M2Vu1e017221
 for <dev@dpdk.org>; Thu, 22 Jan 2026 02:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=Y
 i5QHAoQ6KZoP2SXZVIKMjyPk3zbIhTVz/MGI/fyTvk=; b=FK4ISgSI0Qx7v9MMm
 VO9MPshiCpMhVC6fKAPv5Os00tdkH72bUWbELRmH0VcDbtXMptBmVWYdbA+KsR6B
 0p+sUwQUDkcxXCMaXH6aHHppQF16DcmvkkqL0tA8y3hiY/uf+MZ6M44hl+aBh1Qt
 x5MQmqRBhHYMwGqhJrK5djdkHzs/tiTLPu8EPnveEY0dzxS3Xr5rlvnBbxG7kDGv
 MCzPgsKz/jJPkmoBFTrHR3mtF7cL007AI4Ot/u7BUvwwLcThJ+CVYBO9QfHDzZlN
 wJ2nTA3udLcjXmKSsuIPBv0SLTgffQBeezbIc527LcbGu8N10SvdjbrsrXYBGUvl
 b1GEg==
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4br5v64qje-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 22 Jan 2026 02:49:00 -0500 (EST)
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60M6PEDb002295
 for <dev@dpdk.org>; Thu, 22 Jan 2026 02:49:00 -0500
Received: from esapsmtpat02.us.dell.com (esapsmtpat02.us.dell.com
 [143.166.211.150])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4bu5yae5va-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 22 Jan 2026 02:49:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1769068140; x=1800604140;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Yi5QHAoQ6KZoP2SXZVIKMjyPk3zbIhTVz/MGI/fyTvk=;
 b=IKlu8xw9RpLim3yKmGeDw/WVJ+gXeAJ3kVVS0KOtTNZqDvmc1j0O1zPZ
 P1C23j1hVMCCs57sEl28CRzHwqW+Iz+OGKe1E+mPRhtK+S3/6BTx0LfNj
 3MxoN46WXRiFjKwhZg8rWTjMzkLQqk/VCQ8TAA6Bu+EgVOQh8oMuc+tZ2
 Jn2FkgUUmj3uU01/zGcye5+9vUIFPon2w7UgQ6m4tO8VEIobsfzOpSHi8
 +y5WPDa8hMI3CUnf4XNddaX4o0C8NlCpqKcloPgjPuWaRyKKSdfLNBONE
 VcmoAKm3pP1OYqxoW91lozWYvlijXYHCNHah6ALpfI5R24Va3iEgYkl9A Q==;
X-CSE-ConnectionGUID: cx2Tv6fKQQyavf+9xn/qDg==
X-CSE-MsgGUID: gtJ3oQ4HRSOkNTgwJrGuBA==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtpat02.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 07:49:00 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 22 Jan 2026 01:49:52 -0600
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 22 Jan 2026 01:48:59 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 22 Jan 2026 01:48:59 -0600
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <maxime.coquelin@redhat.com>,
 <fengchengwen@huawei.com>
Subject: [PATCH v6 5/5] vhost_user: enable configure memory slots
Date: Thu, 22 Jan 2026 07:49:06 +0000
Message-ID: <20260122074906.127942-6-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122074906.127942-1-pravin.bathija@dell.com>
References: <20260122074906.127942-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601220050
X-Authority-Analysis: v=2.4 cv=b6i/I9Gx c=1 sm=1 tr=0 ts=6971d66c cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=i8a7nF7jFa3EbZrjgrQYpA==:17
 a=vUbySO9Y5rIA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=-L3Ti0Wm1PsFXVv1eAcA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-ORIG-GUID: 0jBm27qNmIqJwc0GOnJz63egQ8e036Zp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA1MCBTYWx0ZWRfX/eDXdO2Af87B
 SJNlx35bjOyRJ0CYODvALY981nLQ1m1PU5QqDOE0Wv6R66cy2R39Yixd7WN108m39VTxyJOc2hA
 2JGAw4/n7oiuVaiELYQhxGdjsDu1dbqP02Xb9kkHin2iqut2EP9LcopEZpVB0MDTl6tr5b/k8LT
 HNiqadQOLLHd1hC27pe5f8ZHg9ogv/b9t554iN0w0tcAl1xOnsR44pF1v9i1Jl6WBN1qtaYfTCj
 9mAtVWRFdUqMkUQZjoFRgl6FxrBZQxNBBPABg4D3eOdTw7tCqYXkCByHQmBtyMBL1Iip1hjPjiW
 6tm+yktyJZYpLiEbd+Tf8oz76w0ntTxdCVMHoCc0Sr5XISscig+dwjqsj6D2JkZmCa1cj1M/wrB
 n/f0uLYUQTy1H5+f+FtpajU+w+WrwDlQ1mm7drAasEOfN62M4gDRLzI4BU9tu2s1f1UQnF9ega9
 7Qm4lRPJnS9PwtShElw==
X-Proofpoint-GUID: 0jBm27qNmIqJwc0GOnJz63egQ8e036Zp
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601220050
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

