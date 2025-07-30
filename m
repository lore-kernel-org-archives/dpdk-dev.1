Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A357AC87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 13:13:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E233A40DDC;
	Mon, 11 Aug 2025 15:13:09 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 762244025E
 for <dev@dpdk.org>; Wed, 30 Jul 2025 06:57:09 +0200 (CEST)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TLb2wp023648
 for <dev@dpdk.org>; Wed, 30 Jul 2025 00:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=rNteGg757/6ABBrxVw714Q+
 vTrlNGq5ewAf9jnGTSEk=; b=HTzhbCj5oPtk0BspZFFrcA+SrNQ4jY29ToKrvfH
 KXyAddfhfACHJFvuvoFf/i6zAeqF1F5Sdj+C08e7hj6mKBcE7XSUeFmVkiyipev/
 aeevBM8K7QpVbuaT/fTBYqDbiHuVtw9ryDNJiKOGl7O/3AdTLKK2MbLkdUuQpaii
 Df4HWbno7YjRTZLpV5xYJjEiRHvWXgtGJZUbdt/oMCwELAHKzd5AocGOmPdGY4VR
 bjeDGHYu/xfrJ0hRbe6l/5sREP6RGLr+I8efwnD0pxiSE8HUrHOAuhHNtnzkqbFE
 nzWdJQoko6Dlkqc2dcsUXWgdg60BSOPMyu+6TCUN5cUzZuA==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4876cf1emf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 30 Jul 2025 00:57:08 -0400 (EDT)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U1JfqL009282
 for <dev@dpdk.org>; Wed, 30 Jul 2025 00:57:08 -0400
Received: from esapsmtpat01.us.dell.com (esapsmtpat01.us.dell.com
 [143.166.211.146])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4876cb3ux1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Wed, 30 Jul 2025 00:57:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1753851428; x=1785387428;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rNteGg757/6ABBrxVw714Q+vTrlNGq5ewAf9jnGTSEk=;
 b=F0NsJ7lC2Sx+xXLz6uMEc0UPCE4hS6VkncQJRtOgvMIohVP/IPwJWcNN
 KGPVkSvhLlDcL2lRFUphHVwdzp3GJuOPGLHuo0Pl+/ysTmIrXGySU0jMK
 omBH79iTiFMZNDVzOGdKcr6snaZDiqT0CaI3nMvAbseABgsllQ6PcNSeU
 DsXsshn6UTXMpI8O7VswmGhOP9ybxgdYZEfz+bg2tYurIxyZ4sHYmDczE
 CAIBMRhg8e180LMGlmpeQofLD5kiJdxb3XgXDDv0yFuhm1ZWH4CYfHU/h
 HP82W3+xBQzGwff1mYLD8Pnexk93JVQqxdstYcuIPZo/aomf87F3Osutz g==;
X-CSE-ConnectionGUID: 63iDs5mNSCuPdyHdWJSCbw==
X-CSE-MsgGUID: BEs72Tc8SIq+e6Ku/wQYXA==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtpat01.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 04:57:07 +0000
Received: from ieorr5-ppwem001.delllabs.net (100.64.0.132) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 29 Jul 2025 23:58:08 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-ppwem001.delllabs.net (100.64.0.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 29 Jul 2025 23:57:05 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 29 Jul 2025 23:57:05 -0500
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH 0/3] *** vhost_user: configure memory slots ***
Date: Wed, 30 Jul 2025 04:56:37 +0000
Message-ID: <20250730045640.414132-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=552 bulkscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300032
X-Proofpoint-GUID: wUvNOvkNc1LiCiPMKKTFJwwHm2I7Bbru
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDAzMiBTYWx0ZWRfX/kNBqivSiQS9
 2PV0V4hExCApo3iXpmd0BL/Yc05s18mE6OhZe7U03VHX3oOtnJH83lDJ/HR4h0NQaeRUistS7A8
 7bYK2f6Fw6KJCz6rYj4PwSwb0bwWgdrgOVBIfSJTOcH1jayEkF3LNSzW9wdz3IaRrMQth6gOr7f
 iliwGdsu94ZpyyegI+wiLYZ9RfYy2ahxz6NkNlT+7eqmzCJNfTTmASXUgomqw1G8+ShX1BjLQ5w
 BKKo8ztt8Nl3YIBgtbHFpHouYsqSJwqiGJt8aranIAIEUUQ6A5fPAHS2Ht6DW6YOf1GmJN0Khw3
 m33KhuoAa7E7/T2+GWxyjk5VkkxnD24bLsvguG2xYivhlx0eoxviDPKq20rHSQBm2CgVwVcTcAR
 GO4v2e9tW8UVjIriACEN0KLAsPYbB6yodov6G2fhbXPLfgBXx5pYhfJo3vRvmQESe/mrYXfq
X-Proofpoint-ORIG-GUID: wUvNOvkNc1LiCiPMKKTFJwwHm2I7Bbru
X-Authority-Analysis: v=2.4 cv=a68w9VSF c=1 sm=1 tr=0 ts=6889a624 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=MDsIxxkBee3CUfGUG3hQZw==:17
 a=Wb1JkmetP80A:10 a=ke5jqHz-1hQA:10 a=4gVp8_51gQM-wQZJVKIA:9
 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 mlxlogscore=548 bulkscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 impostorscore=0 spamscore=0 clxscore=1011 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300032
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

add protocol feature support add and removal of memory
regions/slots dynamically.
this patch set has been tested with multiple instances of fio 
connected via libblkio to spdk target backed unix domain socket.
please apply this this patch-set to dpdk mainline as well as
version 25.03.0.

Pravin M Bathija (3):
  mailmap: add user
  vhost_user: configure memory slots
  vhost_user: support for memory regions

 .mailmap               |   1 +
 lib/vhost/rte_vhost.h  |   4 +
 lib/vhost/vhost_user.c | 325 +++++++++++++++++++++++++++++++++++------
 lib/vhost/vhost_user.h |  10 ++
 4 files changed, 296 insertions(+), 44 deletions(-)

-- 
2.43.0

