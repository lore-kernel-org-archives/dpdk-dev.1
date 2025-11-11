Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0D3CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:40:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5291A4026A;
	Tue, 11 Nov 2025 12:40:31 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 239D840144
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:40:30 +0100 (CET)
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB52sCJ014135
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:40:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=KXng8pTOGvfAkPxu5j0gBdS
 bVNAspPq6W2q5wehQhJg=; b=RiikNAoqluCVQw+ve5lYghXr01PtRF86Ari0pAi
 MnCIX/ARnz7ixh4FL4zousQRAf9gRIAHU4FJypdN8Npe5OpfwzW99CFFL+9F06LQ
 tgJlCIwJnWoU6cTJDcNZCNWwAyAMaeFrugByGXL+ter8TB/xTK5aYvO0rs7Hbb2h
 tW7/lJl7mwmCK8Z/gdH39V2Rjwy/8Hly+XYbnpb7U4Ady9oxu4iVSzZlv1WOw11P
 jPRGdqtyrOsA9o+U1fxBukdn6akXXIH2ISmHZgC6G/3crEZYHJqViSAp/H3l/EQm
 hTJY7N+5QeYfXeOckE32dwbtq5RlqNn9DJ/tE05x8tBjgXA==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4aa3dskwyk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:40:29 -0500 (EST)
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB6mbId006861
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:40:29 -0500
Received: from esapsmtplv05.us.dell.com (esapsmtplv05.us.dell.com
 [143.166.203.153])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4abxg348et-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:40:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1762861228; x=1794397228;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KXng8pTOGvfAkPxu5j0gBdSbVNAspPq6W2q5wehQhJg=;
 b=bL3rWAlB2hsAPZjetzjV2C1qA3xuCEjr1VeDXlMzLukceBUzFTNFx1JZ
 Qyn3fa70CbmnognPWIfiXmOcNDZjBXYSzrdGqh3W3byutGCDC5AipzQv5
 iICFTiXRwD4/LQawINVE3zXPRDwFLO/SxDN5y3boTvnh4QDrjcMbhk57Z
 HWB+A/OIhOuB9f6nFf2nxNWwIUC8lLglQpkHYmYehpX3fsNfzZgBjiFfv
 1sR658/oa3pIuHIftyAIQUSockgzaG01aWZ5l7XY+iE/ocdoyYm9x12Gt
 v9i5V9p0UXCx3TIycj5arLSJkq+8MbwRcRulSSN5fnwQavdxgdwq+aChr Q==;
X-CSE-ConnectionGUID: dpkZzWWWS7O54Qrk5EJLyQ==
X-CSE-MsgGUID: 6Mu/fDXWSP6VhjvOuDQXwg==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv05.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 11:40:20 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:41:12 -0600
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:40:19 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 11 Nov 2025 05:40:18 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v4 0/5] Support add/remove memory region & get-max-slots
Date: Tue, 11 Nov 2025 11:39:57 +0000
Message-ID: <20251111114002.2902696-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511110034
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3NyBTYWx0ZWRfXzFoHMQN/Qux2
 XdSOr0uv5/PYkRbofU2wG7ZQTnuaQp3tOqYL1dTRfF+Q2J7hirDTagGXFd7K2dMoFcBMF5l8VEm
 +1cJqxSnApBck8IUrYI0UfS8pwKBOay2MiECo6MH4wFmhoFAK8WIB2COgMI/2JReBg+0Yv9jozs
 +wM42OGqhqE1OWqw2SGqpyw0T9+5kppB0rl8IbBB8HJu4ruZCu7iPD+dALIBV+begVzWmxoBNz7
 ajM2yz2GyfqWJyG8e7X+P//OPMHUZ03dg8Abti7cpImu2mHwuEhgWbPbjEvTioAQ/vXC3YcdGif
 fJ5gNS+uamTJcxYF+rcuWwMldVGljWtvEdKKHvDQwRjNjBWKZLZBhckQKa1pba1PEVfJOkHlZjs
 gYqPMbWQE4LzwHbQ2ZCRssJmlBwF5w==
X-Proofpoint-ORIG-GUID: 4DYHcpeHyp15Pegi2bWiwEGmN2QZl5Pv
X-Proofpoint-GUID: 4DYHcpeHyp15Pegi2bWiwEGmN2QZl5Pv
X-Authority-Analysis: v=2.4 cv=Ud9ciaSN c=1 sm=1 tr=0 ts=691320ad cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=t4Iba6VQkoKuxR139xjPXA==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jUkc5JkrpLFZSdxVQEcA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080077
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

This is version v4 of the patchset and it incorporates the
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
regions. The last patch also includes increasing the number of memory
regions from 8 to 128. This has been also extensively tested using the
above test approaches.

Pravin M Bathija (5):
  vhost: add user to mailmap and define to vhost hdr
  vhost_user: header defines for add/rem mem region
  vhost_user: support function defines for back-end
  vhost_user: Function defs for add/rem mem regions
  vhost_user: Increase number of memory regions

 .mailmap               |   1 +
 lib/vhost/rte_vhost.h  |   4 +
 lib/vhost/vhost_user.c | 399 ++++++++++++++++++++++++++++++++++++-----
 lib/vhost/vhost_user.h |  12 +-
 4 files changed, 373 insertions(+), 43 deletions(-)

-- 
2.43.0

