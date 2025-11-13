Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D47DCD6E4D
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 12:42:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EACC406A2;
	Thu, 13 Nov 2025 13:42:39 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 1ABEB40151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 13:42:36 +0100 (CET)
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADB4wZl009164
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=nvtVk9eSdRGx/37wtDklQ3I
 1EHI1CTCtdZV/pXEwTHQ=; b=XEsZ5ie3Bh2/XGwUvCs0wwdXNiIY2UIGs1Rq8NB
 SKAsQES9Ut6uspnY4XyOaKwqO/OgKTszq1k8vmXBcrO7PFz4+1AM66J8vWJM0YOV
 VWYf1+CQUEwU9aeU6tWBUDQJgVAEHpLkiFKN55I7ynLNaKHKI7YzdnKIsRlqWn/c
 uLLE73VNKZS8AH10VxbT2zoo/wtyiufiwX/Kj3zy4Xytua0XWIj3WZFedT5ZWOhc
 0xlUBxtiN1V3amIsuWUHrrzJ02CAMfR0u4uzTzIHM8oDvRpsmiusg5yQ0RLpi9LE
 GgCvLtPAXQvAusqT6OZgIdy55uWJFk7vbsxUhrnmZvKPpbA==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4aa1t7s8aj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:42:36 -0500 (EST)
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD7hMcl009508
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:42:35 -0500
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com
 [143.166.203.146])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4adb6hkcat-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:42:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1763037755; x=1794573755;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nvtVk9eSdRGx/37wtDklQ3I1EHI1CTCtdZV/pXEwTHQ=;
 b=qk8KXCEb8Cdd0RShChMjQiF3LaSuYYmqzASgumFysbr47ulp0KFv9Gl4
 8ZDokwkyL19w7fAmUdmH0CdnkfNOMZDLOKkCshmlDo8/B7MXXKV4a7Tyv
 j3o6hCVahj4srVd672+Uh0OMGFaMPVrYPGktKB9UnNUmPG6QFvzCCpymq
 ndi8n4KZz6YAUpLGAh/4s1iZj8BTBBx4DhxoJhKwgWE4YQ+40rpDIwoa3
 SwM8RI9WaLFb8cD2VBmW7v71ZmmJRv917hxgLO63xZIO1Br7E44jiPMos
 /2rqeK1IC+r8671jya7LUxP9CjCkY2EX4GhEk+HSC5KjqCTqS4EaXAo4N A==;
X-CSE-ConnectionGUID: nv7TW+RQRPGUlD3lNj+mKg==
X-CSE-MsgGUID: Hbl07qt1R2uzEpcs+slWuw==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv06.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 12:42:33 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 13 Nov 2025 06:43:27 -0600
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 13 Nov 2025 06:42:32 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 13 Nov 2025 06:42:32 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v5 0/4] Support add/remove memory region & get-max-slots
Date: Thu, 13 Nov 2025 12:42:06 +0000
Message-ID: <20251113124210.2913846-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511130053
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA2MiBTYWx0ZWRfX7tG+fNgejy8o
 Qud+koFazaHkpf6ZsZCvuQi/cGIMqn0F5NG/J6AImVqoATvwTC7bSwSOtqhtIXTBPyo4ZHdG1Fx
 dCbUZ7UHtRuc308deiHrA74eT/4+X6LD8KqlhCW3OXNsyYWXtEM16t4Mh6t2uFM6D8h3B6gRjTH
 6vGAvqA2/fuAfRVCnr94VQcgmvmjdTj3ZSqYmHPV2W6MP12W2/8AM2QhL61oiojeP177ys3XcDE
 90kT0YgaJ7cCpCH4HDU+czEeh2CnrKQJlPADFRu6sFIZbc4eG9MwfJYQ/ovSaaziBYWpF8dqqoM
 g8adEPtFsTTtkEVuArWbYJ0JhDFaTjvB/kOr19T1VujPkKI7KCi7ZcvoTSAL46teR3tB7K57hwn
 sSoFMZqCKVVhCYydNkxKSQaxa+9+JA==
X-Proofpoint-GUID: BMzybXJfykPGMzyOBXnfet2cxqNI_pbN
X-Proofpoint-ORIG-GUID: BMzybXJfykPGMzyOBXnfet2cxqNI_pbN
X-Authority-Analysis: v=2.4 cv=SLxPlevH c=1 sm=1 tr=0 ts=6915d23c cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6-Zxzzo7zUZZ86AKt5UA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015 impostorscore=0 adultscore=0
 phishscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080062
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

