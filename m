Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6ACCCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:45:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60D9C4066D;
	Tue, 11 Nov 2025 12:45:40 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 2A6A740665
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:45:39 +0100 (CET)
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB60bta017662
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=KXng8pTOGvfAkPxu5j0gBdS
 bVNAspPq6W2q5wehQhJg=; b=QzE/QmSsi01GExuzV3NSaQE4QU3t2kWDK/l0j+d
 4VzvN6J3TRxtZzH9m2tSitFeA7BGvdPvxPVMEa3tCjz/4TEqc29UaCCJv4zylZE3
 4w3vUigY4icms96vKmlpsMTHlSnKZcP7g7T/DjvNcy7ir7avvClyngvVxNBxe3o/
 GLb5mqLd4AYygRo5oh04FXoBn+NGpMJn8K1zYNvFE/jiRcr96QjOoAByfSGNZzmD
 UaBzskCYyysrffLnMSxfkVIXvN67Rqx6ICRBqH/OxALoYCZk+p9/GtBwS2ShIJNt
 uVZTmK0E7wrAkYGlpSNy1zole26NTJbuAKD4butGK/Hpd8w==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4aa22qc4gb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:38 -0500 (EST)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB8lnML026022
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:37 -0500
Received: from esapsmtplv09.us.dell.com (esapsmtplv09.us.dell.com
 [143.166.203.151])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4ac1xphwr9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1762861537; x=1794397537;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KXng8pTOGvfAkPxu5j0gBdSbVNAspPq6W2q5wehQhJg=;
 b=ggiuhxD0MLOaiXtAH5ANk2Plx4ASYORaSnC1DD7yTOP19v+RRHhH7IeM
 zkYa9qTAHZWVN40PU6pnl6txm+S4jJg7mqfLuQ3JqizrTIYzEIrgYkNG8
 cXzk0jfOkpmthrHKBrIii4Yn+YBNMbLK9WkSv3RKzplIAD0VW02OCdzQ5
 wiV+K98e+UqbuRDmw96ZmO43evPRB+TV9Hh6Y4FDQNuNyycdYIQkd53az
 jqvLN9WuKe0NbKklwsePgNiS6TL69BLxDvF6ahicjgcZxYQGV+r+1l7Z8
 zY8AC0aT7nkufEMd+jPVCSg6bndZ//7X35q5HwMxGSL640yYURJxAzz5i Q==;
X-CSE-ConnectionGUID: 2xbu22QGQWCEJLoGK6ZF1A==
X-CSE-MsgGUID: 8uM/aDtaToi9EQEFwtVgjg==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 11:45:37 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:46:29 -0600
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:45:35 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 11 Nov 2025 05:45:35 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v4 0/5] Support add/remove memory region & get-max-slots
Date: Tue, 11 Nov 2025 11:45:16 +0000
Message-ID: <20251111114521.2902867-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511110068
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA2NSBTYWx0ZWRfXym/ntKKUC7kZ
 1u/589xSyBTIQiwYvtbYmBBMgx/mAd1Yclh8psawRFXPvBYuRn6hX66/FlA7wvi/+RdHZT3z4v/
 wXeiUQ+hrsPUM4/IDm3Zve5M+vvZwB0/fpm+XHvj4lTmo47Lr5g78NUGzLsudchZbqL2Erucla+
 oovdebAPa/Va7FUTr3Ep/kWnD9OLRbZKHnFoYUNUEWzjCLQl1V27yMOtCu0lJXWA08g96TdrSMO
 yGMJFsYCk16v3nvohjCA9KcvoxFve42ss6GHkjJxI3PYwPPEXQju10ullmfkgOOS92jKr7qV5h8
 999XbpohbWJEEg4vOMOOzOKT4lu74E7vpxr6CHM1sZt14ms2fg6OMFwVOpfjGj+/HjEvtYd7deX
 17LfdfgHL9B1jbINq0DMDx0yutNwDw==
X-Proofpoint-ORIG-GUID: 0krBP-8FopJgmetBn8hDkubbKoRA3J-Q
X-Proofpoint-GUID: 0krBP-8FopJgmetBn8hDkubbKoRA3J-Q
X-Authority-Analysis: v=2.4 cv=BMO+bVQG c=1 sm=1 tr=0 ts=691321e2 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=1BWgYg405ukQaXe9BCXDPw==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jUkc5JkrpLFZSdxVQEcA:9 a=gbU3OgOOxF9bX48Letew:22
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

