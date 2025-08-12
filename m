Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE99CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 02:34:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B645E40270;
	Tue, 12 Aug 2025 04:34:28 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 1293E4026C
 for <dev@dpdk.org>; Tue, 12 Aug 2025 04:34:26 +0200 (CEST)
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BLs1Fv014195
 for <dev@dpdk.org>; Mon, 11 Aug 2025 22:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=xEaxK6KT2aMFeyqq72K0YLz
 Yrx48u+7HJC6dDaiunyo=; b=LqcSifOiaMGVh+te2aJGowHOeNISx04oUytaZwy
 T95nH+tD04dg1H4AziJAdAwxMHyUz4xRl6XWxqPF0pCoSE6+Ibt6lGehsHhH0fz9
 pPQNecjb+FaiWF3cCtlXPg6qllTNQwTh0G4n0uson70mUltL5E0BG4d3GOFXpN5J
 Jx4m3bBfNQmR0lPcqsblyhay3iXTmYsRxB3i0Wb0Stmaxyvk+YaK7l79MkcgCgKp
 J46Zb9X3m98hHFM/ngMqu+3tzdacD+dAHvFoGFeZEzZ2H2/utK2NPXDBvKlYOe21
 R6Gme5VxbdbIkbVMH9zvmnAS/gTOwGGa3w+Wede2ktVjpvg==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 48e0w8ak28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 11 Aug 2025 22:34:26 -0400 (EDT)
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C0F5pK037453
 for <dev@dpdk.org>; Mon, 11 Aug 2025 22:34:25 -0400
Received: from esapsmtpat09.us.dell.com (esapsmtpat09.us.dell.com
 [143.166.211.151])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 48femykvtg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Mon, 11 Aug 2025 22:34:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1754966065; x=1786502065;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xEaxK6KT2aMFeyqq72K0YLzYrx48u+7HJC6dDaiunyo=;
 b=VK1tG2HUsPgyxUCIP48Op2JbnyWQOa1kdq1rMvDbpkNaY6lxw+x7N3Vz
 FH4V08vbjrvZkH1TtK29+0wSXor8USX3ehPfIyFcS3tbYCxcvVacLSSDl
 XqBPhmEyEuLDB4qOHYX9XPikp7s2zt9UcToqRzFqehoZEWH0uEhOs8Why
 j/d85OpyWawGZyhTwM5hbB5x0hXwQD+E/TM17sqksWWjrovmiJaupVmYz
 L5JpkhTHKBuN1ruvmVWGpOUisxtt1MJ5ZsteMqIi8Na+fnm1TwHfe8/pF
 HnTPjXtFJ+Nzk+OZEe9ySh0oZqCdJmmuG43XcoKs2vJNdfMt/XPFdT8w7 Q==;
X-CSE-ConnectionGUID: Upxu6e3fRY+yFtoVPOVgNA==
X-CSE-MsgGUID: zYQYSE0XRoG9v+Om22Xi2w==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtpat09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2025 02:34:25 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 11 Aug 2025 21:35:29 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 11 Aug 2025 21:34:24 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 11 Aug 2025 21:34:23 -0500
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH 0/3] vhost_user: configure memory slots
Date: Tue, 12 Aug 2025 02:33:55 +0000
Message-ID: <20250812023358.2400020-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=587
 spamscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508120022
X-Proofpoint-ORIG-GUID: IkCbaEvbzHjIyLS7hfFW_PTVLSx9CHDj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDAyMyBTYWx0ZWRfX5n3+uZMoVaXT
 f+KaYR7pXU6f4WgBfloq5UUMoWWz5TYkw3W3nQHVpJFHxPzFH9jo06E8FKfG+V8h0FQi3aC4AJj
 +0PZNLZ3uIrMb/nuAKUeTvAhxRVvtAHpK/pMWfJjVQv4P0ep3keKrNlhYXkCGSIzb1oVnptaIlK
 uZcNi52yYMfrGeX+rcORzpr3Tdm3zJ8FmimbEb06h39rGZQ14f5ZFBwPYqEcJi4+nO+DiBQWQ7D
 oihj9l2EKrgsSmWPhROWc0AmpVg+e1sufrXvr53Tei27+4ndfRkos1o2uujsGhXNbZFVb5dq4wB
 OL/VaqQj553kEIlmpnqOiFN2dDARmFPFUedqVVxeLV6n4HjYkW7Pt5WPR16d50m6aJPTNqhcyBV
 jNOHv1Za7H4oBNT7Aoi3cCtJ5+xpBj05DxwZNvDmbw+w1ZG7/HzABnaU+Vxy1ykEeaxlvczl
X-Proofpoint-GUID: IkCbaEvbzHjIyLS7hfFW_PTVLSx9CHDj
X-Authority-Analysis: v=2.4 cv=U5qSDfru c=1 sm=1 tr=0 ts=689aa832 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=Vd41IKOgs+CGE2+bDnhSdQ==:17
 a=2OwXVqhp2XgA:10 a=ke5jqHz-1hQA:10 a=4gVp8_51gQM-wQZJVKIA:9
 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxlogscore=630 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508120023
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

- add protocol feature support add and removal of memory
regions/slots dynamically.
- this patch set has been tested with multiple instances of fio
connected via libblkio to spdk target backed unix domain socket.
- please apply this this patch-set to dpdk mainline as well as
version 25.03.0.

v2:
- fixed warnings with e-mail address
- fixed warnings with typos
- there is a warning about __rte_packed_begin not being in
pair with __rte_packed_end which on reading the code turns 
out to be false. It is an anomaly of how git-format 
generates the patch and how check-patch checks it.


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

