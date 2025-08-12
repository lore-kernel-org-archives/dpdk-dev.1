Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59B1CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 02:34:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D99A2402F0;
	Tue, 12 Aug 2025 04:34:40 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id E46D8402EB
 for <dev@dpdk.org>; Tue, 12 Aug 2025 04:34:38 +0200 (CEST)
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BK9rpK002500
 for <dev@dpdk.org>; Mon, 11 Aug 2025 22:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=V
 +V5PndhSoetflHml2zZe3WHFyRzE702ZjhHun4xqfA=; b=r06uE7fSWY+WjYZi1
 0oL4w3ZZZ6vegXlTG6oorqGLfgcV76UWK3ucUr0zqRE/YnaT3md19OFWTjsjNQpi
 A1qMlH3LfIu12UxJgpOuPgnlFfjIRuxoldMOxN5mc7NwfoaBfzevFVYayaqjbTlZ
 G6rzBqrGKLvp7IqHe+wJaYsh9QXdRf07QVFc+28n+R5qd6kYCZs4Tt761yfO1HRu
 cz7U3gwJtQwJOxGoip2dtp42aOtlqbW/Y36s0yQ4IBQULhH3SDrFKreMb31qJg/q
 9Q+G2w7qI0IaduPpheWX8mlh0sbF8yAC4cJyLyJnsxd3vmnIQMxpSrBem/p3fbn4
 A7DKQ==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 48e1nntdbj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 11 Aug 2025 22:34:37 -0400 (EDT)
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C2TeMx015132
 for <dev@dpdk.org>; Mon, 11 Aug 2025 22:34:37 -0400
Received: from esapsmtpat09.us.dell.com (esapsmtpat09.us.dell.com
 [143.166.211.151])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 48fux4rq1s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Mon, 11 Aug 2025 22:34:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1754966076; x=1786502076;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=V+V5PndhSoetflHml2zZe3WHFyRzE702ZjhHun4xqfA=;
 b=ELd/YuSr+F7suyXfYYtUJiCQ7jCpKFcwgCPjXFz4xqbLr5eZQ2o70dZw
 TmdOwPaTSo3IS6MZxlM9TaRCdYOiWLIAqdZx5dZEPoBNpKKJJ7Cf9HivS
 EUGa6i1PsaeIESk8J+E13+Gtw0KcG1M0fMaIjMgAFZDx0kxr1VZtPU0kI
 mTn99LKJZl+FN1qhEMC5Qd1jG0jmP4xXqXWgliEHyeCylVT8XBfHyzPRI
 DMMReHibxx5IoqzjakJ44J/ElOUzkuk1lbMEgyIKwIJ/DzQx+wL5XoGkE
 0Dzlgb1kygpvwad8tIOaAbzzJXGtsJYWOSLgDpNFFBBjVCwLZOuXKj6Gn A==;
X-CSE-ConnectionGUID: 4zrOLh7VT3idMrW3UHnCzw==
X-CSE-MsgGUID: NDdO8SLZRl2gKQfTU/mwFA==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtpat09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2025 02:34:36 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 11 Aug 2025 21:35:29 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 11 Aug 2025 21:34:35 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 11 Aug 2025 21:34:34 -0500
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH 1/3] mailmap: add user
Date: Tue, 12 Aug 2025 02:33:56 +0000
Message-ID: <20250812023358.2400020-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812023358.2400020-1-pravin.bathija@dell.com>
References: <20250812023358.2400020-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=577 clxscore=1015
 spamscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508120022
X-Proofpoint-ORIG-GUID: PjLjYy2xPYkCi-92Xkxr6t_3nMtuZ1nZ
X-Authority-Analysis: v=2.4 cv=Y734sgeN c=1 sm=1 tr=0 ts=689aa83e cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=Vd41IKOgs+CGE2+bDnhSdQ==:17
 a=2OwXVqhp2XgA:10 a=ke5jqHz-1hQA:10 a=iLNU1ar6AAAA:8 a=QyXUC8HyAAAA:8
 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8 a=8AirrxEcAAAA:8
 a=ywhdLq5f-aV1tX3TMycA:9 a=hlJyneSgMmFPbskH-t2w:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: PjLjYy2xPYkCi-92Xkxr6t_3nMtuZ1nZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDAyMyBTYWx0ZWRfX+qoeRUiZ9QgG
 J1V5Q1c3z1t8adOWRVIpaUM45YAanBoXn6swC0JDH5bO0thvyZrtDyUrt2xkxTw814GYz2UQBEi
 QKfaNnYDpZDk1lso4VVLCJtPnmrVYVFSyAsZwOAkvq2Un/gI96mGQNnOe1uKTLVtChrZKff15Wm
 3EAg5Z4j/M8D3dJIBVSlaDt0VvczRKSerBkxSdNdcMyIX8VIaHyoDts9068VbuYoHHuLZV7mqeR
 dNgmNXOeTxGQyFCpaDWnk+lIKWKn8CGXEgb32joyLs+DBM43wdrm8JUriGBQHBwLzmIMrcCns0z
 TEjw27QwA4KhH6lAqSKrfw+GJJbIr/VY/tev2SSBpKWrVlsnOLp7gFCnYJcgH7f0uWgwYZ4xUIj
 lGNooQOnz3iGezyUSsKo/3Ki3Y30mumbpaqs2t4/FHgFWoHOPjjXnzVAddtbckhTcU1MTskM
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 bulkscore=0 mlxlogscore=620 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
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

