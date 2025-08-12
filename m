Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0BCCA0ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 02:34:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46B7F4064E;
	Tue, 12 Aug 2025 04:34:43 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 9C857402EB
 for <dev@dpdk.org>; Tue, 12 Aug 2025 04:34:40 +0200 (CEST)
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BH8KHp002219
 for <dev@dpdk.org>; Mon, 11 Aug 2025 22:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=B
 PPEyRdq4dDZARGw8gvlFWmUp9bekRiFFEpVTbFNSgg=; b=KOHovQVfxOr2InjYE
 zl3FhxQmT5sxyomCKixN9j/O6QcdSxvICsChhap1xH/ID0OeNVzQtWTaBwB4znuV
 mNEc5TyPcAAWHw2CK1GA2Ng/vtrcUSslkR38zaPzoGGpN6+i5vI4mOFia/MIxmt3
 t34YBkFH2Vj0pZZSVCsb+wot1GCAijPVzqAFAxabVM0YTixP0LvcWGrTmK7kkBk+
 Xv7LoJCi7od23zP158jPxaCKGHlitj16IVimI0NsyuW7Q9lbUYa4tX6O7wdxoGXu
 nvE2v5rELTAca6Xj3SjqjMlIK9s6tN4KDfTZqedcf5/KYk4YXOMIXBZ/An5kWwnI
 Nn/Ow==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 48e0w8ak31-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 11 Aug 2025 22:34:39 -0400 (EDT)
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C2TeN0015132
 for <dev@dpdk.org>; Mon, 11 Aug 2025 22:34:39 -0400
Received: from esapsmtpat09.us.dell.com (esapsmtpat09.us.dell.com
 [143.166.211.151])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 48fux4rq1s-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Mon, 11 Aug 2025 22:34:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1754966079; x=1786502079;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BPPEyRdq4dDZARGw8gvlFWmUp9bekRiFFEpVTbFNSgg=;
 b=WLwMWqteD4To4xLzowmIFXcOp8fOzQoYNU52KLxtiI4ejUoA/vBtkJ8i
 Ymt+KdhaqnkcOliBWuQTq3rB/D7yKrFUQ7tPTgIOWMGh1fvNsEin6hkqD
 sHalP3evYtsfAoqA9fF2dDUxid8rIq+j5X8gg3L+Aq4bEfaLvCtyE922k
 UophLxU80kpIKsKIkdAhQY8Q5ascxzJU3v1pGuBNaO8P12KUvYmqO4xeQ
 yyklS3vc8uRK4dXuD/q6aNsqBKHxV5f/26IaWFHHzV2MWhn+S1vjBR3lM
 dLs7s0paJ5RScMCT2cICxrYOwoWSrTGm/1Sfd11uysYnkALSaSK1HvNbm g==;
X-CSE-ConnectionGUID: eg8xNlRWR2ucfi9elyCLlw==
X-CSE-MsgGUID: bmV2uokBSgesm69ocpVksA==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtpat09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2025 02:34:39 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 11 Aug 2025 21:35:43 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 11 Aug 2025 21:34:38 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 11 Aug 2025 21:34:37 -0500
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH 2/3] vhost_user: configure memory slots
Date: Tue, 12 Aug 2025 02:33:57 +0000
Message-ID: <20250812023358.2400020-3-pravin.bathija@dell.com>
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
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=706 clxscore=1015
 spamscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508120022
X-Proofpoint-ORIG-GUID: 6s_fYpx9ZHjx3KonqIE0ic5rF5xh6tX9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDAyMyBTYWx0ZWRfX10ozsEcaK1CE
 sHdmS/etJfiAjgxa8A0FxAJDSQ6QDPYDNfkjy3gjdazZZSer/OSbq/OQeLdntlTrk3t9h4pFOsx
 YR9sukya4MT7ohkdwAg/UJq2rks2oMnHsOM6IJIpTG97BD/dPId5XaYq+cNFyAeNGRpETIUXpgq
 CRBDzAAqDaUrPSrWlJYZvKgiCrYjjsFTW8ftiOTL4fryK6BeqNwx06BpCKdqFBPbVMFO5O2zfNb
 971F62Q7RnyCcNXa9Y7cjOjvtFI4UUuZqb+fco8Vo2RUKJ09vuDnVi3VYoa25aJQus+zhDAxlHG
 Ez7Fr0NSoWz7lImNZaK8u5M99utxotFz1gaLdbAZ90oo5EoJ9ysMeBMgKEFCpRxYkR06dMBcX+n
 8Jx8dh9G2fkqKqaQmINmrU0twbLEehDGz8+goBx5N4NQ2/vdBYYn8xzZb7PKqOxBncx9mOCk
X-Proofpoint-GUID: 6s_fYpx9ZHjx3KonqIE0ic5rF5xh6tX9
X-Authority-Analysis: v=2.4 cv=U5qSDfru c=1 sm=1 tr=0 ts=689aa83f cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=Vd41IKOgs+CGE2+bDnhSdQ==:17
 a=2OwXVqhp2XgA:10 a=ke5jqHz-1hQA:10 a=iLNU1ar6AAAA:8 a=vhdcl8Btm4WQQZqW7OEA:9
 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxlogscore=749 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
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

header definition to configure memory slots/regions

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/rte_vhost.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/vhost/rte_vhost.h b/lib/vhost/rte_vhost.h
index 2f7c4c0080..a7f9700538 100644
--- a/lib/vhost/rte_vhost.h
+++ b/lib/vhost/rte_vhost.h
@@ -109,6 +109,10 @@ extern "C" {
 #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12
 #endif
 
+#ifndef VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
+#define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS 15
+#endif
+
 #ifndef VHOST_USER_PROTOCOL_F_STATUS
 #define VHOST_USER_PROTOCOL_F_STATUS 16
 #endif
-- 
2.43.0

