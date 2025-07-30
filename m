Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4354AC87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 13:13:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0706240E03;
	Mon, 11 Aug 2025 15:13:11 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id A84C44025E
 for <dev@dpdk.org>; Wed, 30 Jul 2025 06:57:19 +0200 (CEST)
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TLb2qb017891
 for <dev@dpdk.org>; Wed, 30 Jul 2025 00:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=V
 +V5PndhSoetflHml2zZe3WHFyRzE702ZjhHun4xqfA=; b=U45Ou4zrzYvXtufAS
 P9ieKOd8YplTBRMkwjHRu0xwsNnfWBz9gaX+ZF84/utD8Jsy4VVcAUb7nIFX0SJm
 zQME0bbPQSqaXRVfYsrbeeZDzaKv0lHu1S2JkSVMc93YE6lNOw9utmoAndrXPsCh
 g90YU9ODQqcYfM0q8m1guHvqboHI1rmxrTJ22BPuJrY87M/iXQMgu1p/ldYgHr4A
 5QnxzqHcuM610Du9p67xtntqHCENV4W0sgE8NE2sSr3J8T7yLcWV2EVhb9QAgp1H
 NbA6Ac7ud+/5vRFrZaWaX0p1+JZ1dOMno03dU2kJiN3Fmy8rdcnjbJJaAid8xu+3
 rGlIQ==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4876cf1e15-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 30 Jul 2025 00:57:18 -0400 (EDT)
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TNia8A019737
 for <dev@dpdk.org>; Wed, 30 Jul 2025 00:57:17 -0400
Received: from esapsmtpat03.us.dell.com (esapsmtpat03.us.dell.com
 [143.166.211.152])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4877n8u1xb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Wed, 30 Jul 2025 00:57:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1753851437; x=1785387437;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=V+V5PndhSoetflHml2zZe3WHFyRzE702ZjhHun4xqfA=;
 b=S1Rd9aK5z6/YH8DHQJjN3cIf2XzSkweNbJu+wDH0dIlzExdDGG5jpGUj
 L7X88G0HlZVpDnpv+A1UApeFMXRq7JpX//PRnE0eEQAb8aVDd+UF0fqRG
 ehjicEFKqAFVvNPahvyOPiKQieJC0bR04ca3X8bssuaDIeJOYFDv8LnSe
 HQHKlzgcCIIqno3Y6qSSKce/xB9C5/95YBrLYPGiWtAYyw45W/Ms7s0Cz
 FC2epFF3r/w3SFWCJmgI2GzJWWMyQeaM01HNmOzE0Em0ZDI3sjug0hYY5
 DTmtmVZH4YKvmQnqxCPWuYZYwzAnoEEz0yxS/FbVZk65pzHeWf5m2xUX/ w==;
X-CSE-ConnectionGUID: cY9+EW+/QyiDN9R9b/w9QQ==
X-CSE-MsgGUID: MpEmEHD0T/i4FwC13t9gvw==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtpat03.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 04:57:17 +0000
Received: from ieorr5-ppwem001.delllabs.net (100.64.0.132) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 29 Jul 2025 23:58:07 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-ppwem001.delllabs.net (100.64.0.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 29 Jul 2025 23:57:15 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 29 Jul 2025 23:57:15 -0500
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH 1/3] mailmap: add user
Date: Wed, 30 Jul 2025 04:56:38 +0000
Message-ID: <20250730045640.414132-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730045640.414132-1-pravin.bathija@dell.com>
References: <20250730045640.414132-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 mlxlogscore=567 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300032
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDAzMiBTYWx0ZWRfX3pzYX9R1zI2o
 dE4CJRzRv6bBrlFRFysm0shwogYOvHBphyakoZIL8lsYOyUEX/VXa2ztepSRhF2Aumm6PR8Ejd2
 e7AL3A/p0FQXsr6B4OxHNeZcTTyKxkcuHlCbU1SgcGXhtFY4am9/3dyTkjoMQ+Fuvhm/xM6WpQu
 /O+yfSfPexWqqMcJRmlNuZKgGdeZ4JPDXCIV5+MGGZan5aj2FFCoT6Hzrq3IUSF/I93rmBTMDPa
 /LyukkViE78Vc3g/WMtIR/PiiRjdvRRpE6B0foV6PHYZ9vHwM7qlbBJjVCBNUs9kBFcaQQ23lQB
 TFPQ8RfwH5M3r5IDO/rFQCQFsdm/nQ5WYI93uNpp8zgXJGRAOzzdPzxfiqlax0bPrzPw8a37ORY
 Vs0HcExG0stJI7zFy8xWtHW9nqDG8Bn2u7ipPDEZBdMBnFx5x5NJFjtLg7UItb8y2jFGilms
X-Proofpoint-GUID: tFy0l09NIqblBuo6j8AckH-IWO7r6h2_
X-Proofpoint-ORIG-GUID: tFy0l09NIqblBuo6j8AckH-IWO7r6h2_
X-Authority-Analysis: v=2.4 cv=SseQ6OO0 c=1 sm=1 tr=0 ts=6889a62e cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=Exi4HLWdEtKd1bGGvbjpxg==:17
 a=Wb1JkmetP80A:10 a=ke5jqHz-1hQA:10 a=iLNU1ar6AAAA:8 a=QyXUC8HyAAAA:8
 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8 a=8AirrxEcAAAA:8
 a=ywhdLq5f-aV1tX3TMycA:9 a=hlJyneSgMmFPbskH-t2w:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 mlxscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=610 bulkscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300032
X-Mailman-Approved-At: Mon, 11 Aug 2025 15:13:08 +0200
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

add new user to mailmap

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 34a99f93a1..6b24ee3a30 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1262,6 +1262,7 @@ Prathisna Padmasanan <prathisna.padmasanan@intel.com>
 Praveen Kaligineedi <pkaligineedi@google.com>
 Praveen Shetty <praveen.shetty@intel.com>
 Pravin Pathak <pravin.pathak.dev@gmail.com> <pravin.pathak@intel.com>
+Pravin M Bathija <pravin.bathija@dell.com> <pravin.m.bathija.dev@gmail.com>
 Prince Takkar <ptakkar@marvell.com>
 Priyalee Kushwaha <priyalee.kushwaha@intel.com>
 Priyanka Jain <priyanka.jain@nxp.com>
-- 
2.43.0

