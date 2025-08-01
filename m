Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE997C87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 13:13:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A37CE40E1D;
	Mon, 11 Aug 2025 15:13:14 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 764904028F
 for <dev@dpdk.org>; Sat,  2 Aug 2025 00:22:51 +0200 (CEST)
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571ElvKn000451
 for <dev@dpdk.org>; Fri, 1 Aug 2025 18:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=smtpout1; bh=rNteGg757/6ABBrxVw714Q+
 vTrlNGq5ewAf9jnGTSEk=; b=yNkzhVjqNgozWav85F+l27fK4YFfN44ZJk87+fs
 I1EqSpC9AsvjRDdoaX5HCEi8hvQfMN71R+e5PqMEngyH/PwRwzaVXZ5F7L5LK1c0
 0kNZ5yLXg3MmR5YnKSJPWUrGnd2ymzow+0dFhFxU/qp57Be7X5+sYrDlR8IG8xB2
 RO9aTRnHSyWDWJpo89YEqbpz8nScz/tUIfEaD6cbYqh0nMGUSSjVm3GLIE+jwqyp
 kfgktZ3t1NfeUOJmdq9sa0WsVXoyoHYmtNZVHkklWLs62eSfBuksM9fbPQHwkc7u
 MP2zNCHLQjtS9w5XKvMjyCufWW8DJFpsJxEXnydC8/Z01Vg==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4876cgg5ex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 01 Aug 2025 18:22:50 -0400 (EDT)
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571LJ1sd038649
 for <dev@dpdk.org>; Fri, 1 Aug 2025 18:22:50 -0400
Received: from esapsmtplv05.us.dell.com (esapsmtplv05.us.dell.com
 [143.166.203.153])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4895cvgh5y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Fri, 01 Aug 2025 18:22:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1754086970; x=1785622970;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rNteGg757/6ABBrxVw714Q+vTrlNGq5ewAf9jnGTSEk=;
 b=n9vjF/CD08Z7VTzUmANPDNBLj6vNsHPIP/tpahJ2NRzshyh7hTSaUYOJ
 QZX+d6v+oVX4Jc5TnjAF450XMjr4YbeF5Dqo0jZ1sqA+9KnfJxPXCPUFV
 YRLusmvamJ7pDvLWs5/4txpQNpGJjUK3gBVjAMgIkwqtWity7YoITCoRD
 Cf5oGYhVE/9sFwe62amlPpaXJIwLF4fU3g5awms41D+lXpjhGaaEO4xHH
 6R9cYfGgGkTKxyM5aOvSO06BriHj86n7IuPlUUShxgNiXnEIiJ6WGpBmE
 uPAZ6gHwQlqABlA2Qwxb3h6h25i1FBE5/YU9FCmvczrEBoiPKU/b57qXw Q==;
X-CSE-ConnectionGUID: QGUE6AD9T6qKgNzkRJ4lWA==
X-CSE-MsgGUID: AKtYIu8wRmGcSsp1GcE1bg==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv05.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2025 22:22:48 +0000
Received: from ieorr5-ppwem001.delllabs.net (100.64.0.132) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 1 Aug 2025 17:23:40 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem001.delllabs.net (100.64.0.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 1 Aug 2025 17:22:47 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 1 Aug 2025 17:22:47 -0500
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH 0/3] *** vhost_user: configure memory slots ***
Date: Fri, 1 Aug 2025 22:22:35 +0000
Message-ID: <20250801222238.1519748-1-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0
 mlxlogscore=554 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010180
X-Proofpoint-GUID: 9fgJCi5Z7ZcAra_urJS4VqkZWHUXDV0H
X-Proofpoint-ORIG-GUID: 9fgJCi5Z7ZcAra_urJS4VqkZWHUXDV0H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE4MCBTYWx0ZWRfX3Wv8D6pyQXN4
 BWeghJRtrtsDzeiujOGFZSrWlRS/1LzbrviUcg2l8nf11beLatAPBScKQy6br14Ii2wPH+IxhdZ
 5daifB7Nkz7X9PA1xV5gqWvCsX7SC19jR129XZ+EkCVDjxlmiYkgFSvMIN/5q83ZMlJnJLnP5zN
 3ENIRaDCGcP0hwK6i1aUVf9zqsRauHC6oIdGLgGQz65DTTsrYlsj/oZC+w5JzwXqP+69GfDPsqa
 7CW7obpUNwvtUw0HbkNVyoWwNiThpouEzp4bABP6qhHAI/ezt7EUphyFO1PjD7IXEfiJikL48Wl
 FrpsWKdNDKtB01aaXmWvyaKNlcQaeaAsbaFo/+CU92BUXM4K4jVuO0Q+GfnW+PnEnAVFEeJRa8M
 pS8QlM0r5Vz2o8+iwY4fEux/yocppEdF8pM6h6qr5pnS+7wliwwEC+Pr98F8GwVbmlcOzNBj
X-Authority-Analysis: v=2.4 cv=F5FXdrhN c=1 sm=1 tr=0 ts=688d3e3a cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=t4Iba6VQkoKuxR139xjPXA==:17
 a=2OwXVqhp2XgA:10 a=ke5jqHz-1hQA:10 a=4gVp8_51gQM-wQZJVKIA:9
 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0
 mlxlogscore=549 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010180
X-Mailman-Approved-At: Mon, 11 Aug 2025 15:13:09 +0200
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

