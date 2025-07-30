Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8C9C87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 13:13:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3045140E11;
	Mon, 11 Aug 2025 15:13:12 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id ED34E40668
 for <dev@dpdk.org>; Wed, 30 Jul 2025 06:57:22 +0200 (CEST)
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TLav8J000487
 for <dev@dpdk.org>; Wed, 30 Jul 2025 00:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=B
 PPEyRdq4dDZARGw8gvlFWmUp9bekRiFFEpVTbFNSgg=; b=mJaVNMRJ/tDOICTer
 AMAxqqk27C7125LpNX+/PEdMP1YIPKB6S0X/RkQm2i7vgSa9DQcRMphT/f6h5YzO
 UkKu7ax0uZ00ow9vI+dF4TpAnsgsrkMhPPvuDMBQg+adS8KatPMhvLkjclugwVVp
 77q5NN6AFL1F0aaf6qQpYHw5Xk8TKXHe/LPnfRzSRuIiK4H0HZQmmzGZWqJ/jnZ5
 HYL4uKSI5b2V5tPqhD1C/mGsTzNkZsIqW6uZGQhajZAkIFNltCFDX0jCVJIOxtHK
 KAWajFswCEPc00X2pxZ5RSbEVx7E4hLtDGwtP4EZbHDeLWIsKxX7lFTG5fzC201M
 hT68Q==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4876cbsg6k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 30 Jul 2025 00:57:22 -0400 (EDT)
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TNn0uD025961
 for <dev@dpdk.org>; Wed, 30 Jul 2025 00:57:21 -0400
Received: from esapsmtpat01.us.dell.com (esapsmtpat01.us.dell.com
 [143.166.211.146])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4878a7av1e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Wed, 30 Jul 2025 00:57:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1753851441; x=1785387441;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BPPEyRdq4dDZARGw8gvlFWmUp9bekRiFFEpVTbFNSgg=;
 b=n1/+pkSKX0JLtDPc7C8OpaGcySiDIK60YhdMk0kA1F4DmR4IszjuXyOy
 eE0pfrs1P3JBZCEqMfERN96jRN1+kiBlvplXYzdTEW88FN5C0cB5YmEY0
 jHmQRfVk4VKHODTl1RLNvQWQ8Gkgl9YH57RowsVlrHtor+I8BK66hanMC
 kbDWV7hxpmt9+Bgedro2N5r4FsRgQHX+p10wp2KUorFSysl7tQRryyn8U
 1QbOhOLRtIf3g6P3D8O4bwT2AymIukgpniox8oD+KMbj/Wb3/S3Ch+PFk
 cWOO/xF25cjpxRzNuAjWDVeup4oMdODKay+B8+n+5f4zT9yMx06lNKM4T A==;
X-CSE-ConnectionGUID: mkB41bP8QYuCXLwiazOKqQ==
X-CSE-MsgGUID: RPDskqmXSBOjlIwhB/z6TQ==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtpat01.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 04:57:21 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 29 Jul 2025 23:58:21 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Jul 2025 23:57:19 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 29 Jul 2025 23:57:18 -0500
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH 2/3] vhost_user: configure memory slots
Date: Wed, 30 Jul 2025 04:56:39 +0000
Message-ID: <20250730045640.414132-3-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730045640.414132-1-pravin.bathija@dell.com>
References: <20250730045640.414132-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=718 impostorscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1011
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300032
X-Proofpoint-ORIG-GUID: RwYYamD3CJsvuQeP_2J4LwTJOgkYVyiW
X-Proofpoint-GUID: RwYYamD3CJsvuQeP_2J4LwTJOgkYVyiW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDAzMiBTYWx0ZWRfXw+4oY8ayFDVS
 HiB/j6fOtYpJmr0VhgJTZ+OId1s0psR61IZCPY0JEDI9evGnI71eLJT1sNVnOBJ37SuOkiU7ef4
 nZBL03KUzLI0MKjMdkw091fadbSmjkRfBK45BHc9+0+gGnB/+XQgAst8h4GoZc2VQW97nVC4sJ+
 BTQ0gLOtZYrhcjX2KfosD1r8wO5OlhmE0pu1oiVdCqlTG7p0HyfE/cjZKI7sNcl2m318ASO47n2
 9SWG/tHwBCmvRX2M5wbToo5A2cUoB96U/Wyx4Y4CuoxqfIW84LWbQwCNGF5dMkPHmQ6kW0nZWO+
 nDdMMvlnj9SdhF4BwrQwNYPSvqPRgBBJ5kETUZHmyHJavPtiBZywgp67Rk0/GJCfTaQ+FvnKVHR
 E78Pku1qJCyy6gJ4sEJMoZXy0HY33e5UYItZnm1m8OjrilkyDu6tEqOVPYJf0Vh4+YbsWIm8
X-Authority-Analysis: v=2.4 cv=B++50PtM c=1 sm=1 tr=0 ts=6889a632 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=MDsIxxkBee3CUfGUG3hQZw==:17
 a=Wb1JkmetP80A:10 a=ke5jqHz-1hQA:10 a=iLNU1ar6AAAA:8 a=vhdcl8Btm4WQQZqW7OEA:9
 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 clxscore=1011 mlxlogscore=761 priorityscore=1501
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300032
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

