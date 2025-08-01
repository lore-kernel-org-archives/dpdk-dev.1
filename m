Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E59FC87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 13:13:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF9D740E24;
	Mon, 11 Aug 2025 15:13:15 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id CF4C44028F
 for <dev@dpdk.org>; Sat,  2 Aug 2025 00:23:03 +0200 (CEST)
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571FMQx6032622
 for <dev@dpdk.org>; Fri, 1 Aug 2025 18:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=O
 Oe+rj2wBbb7AUzCb0XYZ7Cdz9Vbdqns3fZpVoi8pDU=; b=WcmhWBs9FNQeNhCBr
 PQi4Z+DGK0xDYEyCSQIAr5KO9uADcN+GOb7jaI8aqJOiNrgLDb+rUYfnWh3HRlvA
 32ralnOknOw1jletcrGUIzzvII1vRoGK79M1bGuJeUcP62ipMHUg/p8Vm5c13K3i
 afF5P0j+kLQ5kkZKm9MtRwEibqj6evnHURC33KF0hBK7E1js3MGHAjnEYNAh+/bK
 RRrypcyNT453cPAqVK7MocEq7lveeGf73LartyM3ynBdT6mbNQLb1tcuXWRg+YMV
 RSRxZisTRsWrl/x0pbFSV54rx+u0KYtViu/91ZXW9gcf/dyL6N0YPWkTiFXPaJ83
 Zj9Ww==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4876cc9206-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 01 Aug 2025 18:23:02 -0400 (EDT)
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571LJBaK040825
 for <dev@dpdk.org>; Fri, 1 Aug 2025 18:23:01 -0400
Received: from esapsmtplv05.us.dell.com (esapsmtplv05.us.dell.com
 [143.166.203.153])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4895cvgh72-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Fri, 01 Aug 2025 18:23:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1754086981; x=1785622981;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OOe+rj2wBbb7AUzCb0XYZ7Cdz9Vbdqns3fZpVoi8pDU=;
 b=iKYBh/E3ukIeUXjRYiOshxteQz7AuVPAyZ4mR87GHcsHvNxQ3G3OR8db
 rh32XifcDh/2KavDC+I+9GjQ62Be9CDOpHyfFfzEpgy7SOgwFo1xzROqi
 g3bNPRKSg0426/+kFreoRDa+587rNSMYrOOc1gzVL1U3HSKHNcotDEBLa
 4gevg3Bv0Kc3xpASUxKEzbUwXpEh9ECiiEl9jy26KlxCvtciwGpocFbpu
 9xPXYc1Fj75Dlkc81A4t61wpgxVcI8+MRJLItXSwxqmLY47O6qzqjI1Qn
 q1JIrGWnykdjX6slSWHurMpc8udcCP3ss9amfeRmoe/uxUWjTAjK8jDNF Q==;
X-CSE-ConnectionGUID: MEPGN7j7TEm970U00FmX/w==
X-CSE-MsgGUID: 6cSo52iUTUCcAWHV4g7tLQ==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv05.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2025 22:23:00 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 1 Aug 2025 17:23:51 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 1 Aug 2025 17:22:59 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 1 Aug 2025 17:22:59 -0500
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH 1/3] mailmap: add user
Date: Fri, 1 Aug 2025 22:22:36 +0000
Message-ID: <20250801222238.1519748-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250801222238.1519748-1-pravin.bathija@dell.com>
References: <20250801222238.1519748-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0
 mlxlogscore=587 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010180
X-Proofpoint-ORIG-GUID: PrLo4a2SBOanJRpeqxDTGS_yD2AE1c3O
X-Proofpoint-GUID: PrLo4a2SBOanJRpeqxDTGS_yD2AE1c3O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE4MCBTYWx0ZWRfX60haOOW2R5lz
 0hcte5PsR9jJNbSn0z6csdareWw86NwbDc6vO93AQC6RC0hGx91y/HxDNouHg3SQz/sw1Cjl1NK
 aNBMyoNezVs+2lcGat/Ach89tLtkfLtpz2yjijQzyARb0+VMTFLQIrw+2mfTWCruTKc3TSszrX4
 hEaF8K1XrOF1RRihI4qjKrJq1H54EzNtLYOOkbTvH4AqsjOChEbvIKduPKMJrl5O/YJdXgNDYBE
 gktBzWfA0oazHqEP5167ESZDD5FGqJuKRDncWIbn7sfgqq3EvYhlI39Yeus+8a0Qx/yFh/9bkA3
 mPWNXzwOdNrxW4Gb6xpRJVuKhRZZvS8CZUxwh3rWST8bS86J/gOX/KM/lareGMiOopNuB6ehl5Q
 FQpJcvgshBoB/WoVygVa6o8cEmM5+qsaH6w1nYXhvbuMVj/lZUsN1nynq/ytCsbpldMlmK7B
X-Authority-Analysis: v=2.4 cv=B++50PtM c=1 sm=1 tr=0 ts=688d3e46 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=t4Iba6VQkoKuxR139xjPXA==:17
 a=2OwXVqhp2XgA:10 a=ke5jqHz-1hQA:10 a=pGLkceISAAAA:8 a=iLNU1ar6AAAA:8
 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8 a=M5GUcnROAAAA:8 a=8AirrxEcAAAA:8
 a=ywhdLq5f-aV1tX3TMycA:9 a=hlJyneSgMmFPbskH-t2w:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 mlxlogscore=630 priorityscore=1501
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

From: Pravin M Bathija <pravin.m.bathija.dev@gmail.com>

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

