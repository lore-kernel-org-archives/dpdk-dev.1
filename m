Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7238CD6E4E
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 12:44:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0091440E1F;
	Thu, 13 Nov 2025 13:44:45 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id BC2B240DF6
 for <dev@dpdk.org>; Thu, 13 Nov 2025 13:44:43 +0100 (CET)
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD70N3Y013931
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=nvtVk9eSdRGx/37wtDklQ3I
 1EHI1CTCtdZV/pXEwTHQ=; b=OmXvTshW6WuNcaa9K7aCpiWQVrmCGFaBdmEAUyx
 QBiddGOadk/CN6QH5eJz5w0y24J/Dt7g58mjChAC1XQzMmNIoUnb4BeyFRnJZuF0
 tPvcibweJBIlPR1eRxQBUwlPLrNsLrvVITG/XSbxlsIfa5/4+umP77QwuGzd552r
 QUNJFmp7IiPazgUEOiDspldOzwfOOs/PiywiTpIvSDVl/v6XtjSRkX0GIhlzd3ne
 1cIZISZysjVe04GZwdXZWHBz2S3Qo8C9yg7qySi27m+ktKDo7LU+Y66pDatsL0NH
 J2FNHSLd/jSnh9Ll35f/9z1J8B1Fey45Pr/ysZzWy3wDCag==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4aa22qsadj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:44:42 -0500 (EST)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADAlrtJ021718
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:44:42 -0500
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com
 [143.166.203.146])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4addw4sbnk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:44:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1763037882; x=1794573882;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nvtVk9eSdRGx/37wtDklQ3I1EHI1CTCtdZV/pXEwTHQ=;
 b=T/V/OLM8rtZvJdN8AsyReUa8Vu+Es6rHDVwIu6rio6Wv9HyptdiJlM6I
 sRy8zk5ZtuzBodQIEEYB8nKsJCRUbKxlLOiSQ+et7TNsMgeDEQbXnIhna
 CHiQB67DaD2RxVNcu5xqlwo7s9Z7qmEorxHHvD07e1ATxAASTjjm9StKt
 UPrLFUG1bhPIg+aIctvbShlAZGWS3Sy8sM5kL+/WOikAu0MpdyKRSFw1C
 tdvJAlSG3BVDFENn7DAo2r9zQ0bgtSrG7qP1FTirbUSCwn3CRRZDxROey
 RQrNUcP5kxKDve38VnqJY1yZCcmnFEqzIh1Ozq105sD3mGuGmnnq8kNiQ w==;
X-CSE-ConnectionGUID: Y1ElcXyTQOKkwODr395wxw==
X-CSE-MsgGUID: 9DzvGDrBS9ufKhnRZ3zePA==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv06.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 12:44:41 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 13 Nov 2025 06:45:35 -0600
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 13 Nov 2025 06:44:40 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 13 Nov 2025 06:44:39 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v5 0/4] Support add/remove memory region & get-max-slots
Date: Thu, 13 Nov 2025 12:44:21 +0000
Message-ID: <20251113124425.2913881-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511130079
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA2NSBTYWx0ZWRfX3PwbDnSuMEOC
 jnii+OTLRQlSz8StjVc3uHtkJ/p/fhF1D5L5vc9DaCyp81kyW8anEGs/4mE02gUJLnTeJZl9SgT
 DAyCuxhB+yrh6gFaGFtYGe81a9JwhFAUDg0TFMl/BdRSwtU16D0umLN3re4o1aer6gu9gva2+YF
 u0Xi3iayuYefQUA8avzRWHv8FbM1nW/dPO8Dv7s5Xa5XiLgIMkH/7t6pEp+eeHUDf+uOnWaLwUp
 FsPGk/8v4qGxEZoqkLfrSpso5wXkE5x6osOBiDr6bzDwNx5GdYdzmEn1siPCFT8d8URXnD+J1Yj
 rdffylAx1sBY8LCO/uX/sGLCroHzGD9uPnZtJResEhoufE6rQ59j4KG/nbdpFfTbJw6rCpTHKJc
 CI8Z47eyCYl53VB1SokQthJZmBo+/Q==
X-Proofpoint-ORIG-GUID: GCs3oEVI6_5dTQtHiFnN_8v-gsEXgX2L
X-Proofpoint-GUID: GCs3oEVI6_5dTQtHiFnN_8v-gsEXgX2L
X-Authority-Analysis: v=2.4 cv=BMO+bVQG c=1 sm=1 tr=0 ts=6915d2ba cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6-Zxzzo7zUZZ86AKt5UA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080065
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

This is version v5 of the patchset and it incorporates the
recommendations made by Feng Cheng Wen.
The patchset includes support for adding and removal of memory
regions, getting max memory slots and other changes to vhost-user
messages.  These messages are sent from vhost-user front-end (qemu
or libblkio) to a vhost-user back-end (dpdk, spdk). Support functions
for these message functions have been implemented in the interest of
writing optimized code. Older functions, part of vhost-user back-end
have also been optimized using these newly defined support functions.
This implementation has been extensively tested by doing Read/Write
I/O from multiple instances of fio + libblkio (front-end) talking to
spdk/dpdk (back-end) based drives.  Also tested with qemu front-end
talking to dpdk + testpmd (back-end) performing add/removal of memory
regions.
Comparing the changes to v4, I have removed the patch that increased the
number of memory regions from 8 to 128. This will be submitted as a
separate feature at a later point after incorporating additional optimizations.


Pravin M Bathija (4):
  vhost: add user to mailmap and define to vhost hdr
  vhost_user: header defines for add/rem mem region
  vhost_user: support function defines for back-end
  vhost_user: Function defs for add/rem mem regions

 .mailmap               |   1 +
 lib/vhost/rte_vhost.h  |   4 +
 lib/vhost/vhost_user.c | 399 ++++++++++++++++++++++++++++++++++++-----
 lib/vhost/vhost_user.h |  10 ++
 4 files changed, 372 insertions(+), 42 deletions(-)

-- 
2.43.0

