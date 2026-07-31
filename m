Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3126BC55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 01:19:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0367740262;
	Fri, 31 Jul 2026 03:19:10 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id E803440151;
 Fri, 31 Jul 2026 03:19:08 +0200 (CEST)
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UMsCE41054738; Thu, 30 Jul 2026 21:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=X9IohGccge7V38P3/u4iuxR
 4ln0gJeciH0gaGtOHzgc=; b=IZ0mdoFMvx0A9cUqzGniJIqGSRWExMtuV4rqhNG
 l3RVYNL59hZ6At9iJBTLkTY0GW7eYYrJ/U4LWKoR4yU2gYM8mgyge2/6uFz3TErL
 DGqKbEApZ5IgVyPmGHmVzZ0tN9+SV28U9vdxE4+1f3UWOP9NmazjZAda1L5EuGiT
 tSG14o1JD7w0p+gd4XVMGsEBA2agWvBVeY6HN+lYcLBuZTgChdYnxWfy2g83uYsq
 tdwrhDrsVCYRAlEdOpzLgXBwoQxUZOA7ObqhYg14/aWQnIRJEw7yrYv2CrVu7TAV
 N5ttWT+wVO3hrVGcqqj6NUUQRTbMCMppLuYyXhmpT1U4JBQ==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4fqpgvpkv6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 21:19:07 -0400 (EDT)
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V0mZgR1672721; Thu, 30 Jul 2026 21:19:07 -0400
Received: from esapsmtpat09.us.dell.com (esapsmtpat09.us.dell.com
 [143.166.211.151])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4fr81ghees-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2026 21:19:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1785460747; x=1816996747;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=X9IohGccge7V38P3/u4iuxR4ln0gJeciH0gaGtOHzgc=;
 b=PRCBEPUWuoOXJQcpaxsCnNWV5DfVGGVDcR6xkMOAL7rr6OJYGU9PbBVM
 +BSkY5NaXD5/Nt7yeB/y96FeUXshu7Efn6RFAaMOpGxaAfw8oUXSP1YeY
 O6mG2LUTUaJc1PR8nOH9blIHPH4lVdBi3U6A7bnZYR+44XKjc8IUeTruV
 zTCC3GeEhuQc4wOhxBG0lXIa/uMeUJjYs/zMbJhuzKajdJ48uw2LwPXF7
 5HuR4SdNFNBmfB4NkGOa3Lh5kKnxB9k6hEBHJUbGvHY2RuC/sI25TW4kk
 XxlX6rTEAKmCRvIVnwCBfDWF8f8Oxf8o+FM9Fd1u9vS2HY0TnZYy3QLpx w==;
X-CSE-ConnectionGUID: JbjhbDM0Tia5KZkplfDDSQ==
X-CSE-MsgGUID: vrGnCCt8RHyxG5BNZ+3Vjw==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtpat09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 01:19:06 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 30 Jul 2026 20:20:09 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 30 Jul 2026 20:19:04 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 30 Jul 2026 20:19:04 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>, <maxime.coquelin@redhat.com>,
 <fengchengwen@huawei.com>
CC: <stable@dpdk.org>, <pravin.bathija@dell.com>, <thomas@monjalon.net>
Subject: [PATCH 0/1] vhost: tolerate fd in REM_MEM_REG for interop
Date: Fri, 31 Jul 2026 01:18:59 +0000
Message-ID: <20260731011900.3518573-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1011
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310006
X-Proofpoint-GUID: KiNpJVET9ZOyKZ9ogsRLSvCH1lDiB6EX
X-Authority-Analysis: v=2.4 cv=Nr7htcdJ c=1 sm=1 tr=0 ts=6a6bf80b cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=Vd41IKOgs+CGE2+bDnhSdQ==:17
 a=RAioF0-LDSMA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=2Lpba0WeoN7BYVdwMO11:22 a=iLNU1ar6AAAA:8
 a=3cEc0xAJMBXqnWx4iN0A:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-ORIG-GUID: KiNpJVET9ZOyKZ9ogsRLSvCH1lDiB6EX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAwNiBTYWx0ZWRfX4vCmmtsddrqb
 DB84hoDsDy+jSdx9vfJY7s2oEQ4ySocxPbkbpLzUdm8dST/7v1t1b6uvj8HKMolo8tbN2ufigwD
 D841b8DnrW82VzGD2xW9JvCShMoYAX8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAwNiBTYWx0ZWRfX+XeWnHDB/fz3
 fROFYBLYPkYgZTCMXTnQCHli7FXSPjZgyvlBE6IaJAUScPEv4AhIjmCGbTE/NMWbtWcVmmrAAdv
 ndWa7zDOju20Vl+BEbivsO1KDGuR4yCncmZFFYXxdRtRgkDlUvIj+IVYFd9Oja6oZk9DuMkK7Ly
 khPzLMlnKPbrV28oZM0OcyIZWRbyzIrc6eVj+y9jnJESI1G8FLwrc2vLuUzdad8MIPARYZcP4M9
 tdark2mVcDq9GCZCTUkzmGfVi/i724BGi6AREaR+nfmQ9XB3OmpoHDpeFFfZSPwYtd13/40ASri
 wOvGMHJyXrOtIipXzJEeukalAHbq74pHQ1uZDSOeVI8rlV+K2XpRbRh9oEJJHfRxH4OMdZa9ngn
 JarO0i+3qvAlfT+Fg/x8pclJb0vjL5tP/uLLPagDORbUCDEax5EQQr+Di1DNTvqiewk8PQk2YTc
 dDY+XBA0ggTg0dRaguw==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1011 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310006
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

The VHOST_USER_REM_MEM_REG handler rejects messages carrying a file
descriptor, but the vhost-user specification allows back-ends to
accept one for compatibility with incorrect front-end implementations.

libblkio (v1.5.0) sends an fd with REM_MEM_REG because it shares a
message helper with ADD_MEM_REG.  This causes DPDK to drop the
connection with:

  expect 0 FDs for request VHOST_USER_REM_MEM_REG, received 1

QEMU's libvhost-user reference back-end already tolerates this.

The fix accepts the message and closes any unexpected fd without
using it, conforming to the specification's compatibility clause.

Tested with:
 - QEMU VM bring-up with add/remove memory regions via monitor
 - QEMU post-copy live migration between source and destination
 - SPDK vhost-blk with libblkio fio engine (write + md5 verify)
 - libblkio alloc-mem-region and map-mem-region unit tests
   (ADD/REM/ADD cycles against SPDK vhost-blk)

Pravin M Bathija (1):
  vhost: tolerate file descriptor in REM_MEM_REG msg

 lib/vhost/vhost_user.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.43.0

