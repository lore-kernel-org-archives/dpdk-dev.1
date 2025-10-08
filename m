Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F52CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 09:05:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12FA540651;
	Wed,  8 Oct 2025 11:05:20 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 9D60440649
 for <dev@dpdk.org>; Wed,  8 Oct 2025 11:05:18 +0200 (CEST)
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5980GMPu026059
 for <dev@dpdk.org>; Wed, 8 Oct 2025 05:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=1
 bhA7bIt+QiTWznfuQlLiML/Inkn12yLaPY2hNgzt0c=; b=x2Yqo8TirBFYTc/y4
 JNJeUoII4b4ZAYkTI6MUSgA0TmFEzhGKCcKynJ8LiWIqK0KqO7TR7iiOZgJThM3t
 IVsBI/XxdccI570dft/jiSO0Rm8LVjJs2PH9SsGbEz5VZFRSIBblOMdRh6Xsb33t
 PRmcQ8rsW1s3PNfQ3j+ZusDXH0SUUHfD5O3idRpuE6FsySzFP8eRLbylOlRaZ5+s
 fhfojwE6dcONIdHFCOMPfN57+qCNx1af2WxcbXwgOd5tcm8TEFV4bK+BIIEaII7O
 x3GKtM4RaMRwmpRwXHD0M6e9JStBw0zK+WT5Qd/PDUy/Qb0QbyzUFtI1+yHkll9+
 D2joA==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 49jydxs0ft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 08 Oct 2025 05:05:17 -0400 (EDT)
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5988KoEq032498
 for <dev@dpdk.org>; Wed, 8 Oct 2025 05:05:17 -0400
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com
 [143.166.203.146])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 49ndqfvkew-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Wed, 08 Oct 2025 05:05:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1759914318; x=1791450318;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1bhA7bIt+QiTWznfuQlLiML/Inkn12yLaPY2hNgzt0c=;
 b=MJ+SGgrtgfuMfq5bBLONnlFQEVc29SPFU8f7kNslmeOFXPnj+mwKBUsH
 2h67b5jfd+aJE/WBEjLNUpuGCAr16XrTDoAaGktCjVj/OldpmWjKfQ3IK
 PfputkXsxZ3xHQPdpjOVNTyl+cOpXeGrMaD3syIBdzYLekY2MJujxx+lx
 Ub2MGkKNYRzWj2Z2F7Vpzo9F3Y02QVyzicquueRkZzHiSRGMdAOMN/K1B
 Hr5uAPy5nV6BqMlZUNlcfQBzw3PJ1HW4zraMiSR4D+KEbSdx/83FYgTdX
 wTiB8Z9K3zwTKo7qE0wfMbx3aByzdxyb3E+bBXCVsqpFHkNE8xA33QPei w==;
X-CSE-ConnectionGUID: +6zvZT2YQuuJ+YOEcUP3Kw==
X-CSE-MsgGUID: xmcvSUN9SLq4Q4C4X/EjqA==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv06.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 09:05:17 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.34; Wed, 8 Oct 2025 04:06:17 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.34; Wed, 8 Oct 2025 04:05:16 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.34 via Frontend
 Transport; Wed, 8 Oct 2025 04:05:15 -0500
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v2 1/6] vhost: add define for configure mem slot
Date: Wed, 8 Oct 2025 09:04:39 +0000
Message-ID: <20251008090444.2689652-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008090444.2689652-1-pravin.bathija@dell.com>
References: <20251008090444.2689652-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510080003
X-Authority-Analysis: v=2.4 cv=J+KnLQnS c=1 sm=1 tr=0 ts=68e6294d cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=x6icFKpwvdMA:10 a=ke5jqHz-1hQA:10 a=iLNU1ar6AAAA:8 a=QyXUC8HyAAAA:8
 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8 a=3CDqXdsAvEiB_ezhLkQA:9
 a=hlJyneSgMmFPbskH-t2w:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: SLtfWSYZEUSKDIYq00x4bBLHBdU-tqfc
X-Proofpoint-ORIG-GUID: SLtfWSYZEUSKDIYq00x4bBLHBdU-tqfc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDA2NCBTYWx0ZWRfXzGRUV+WtNdbz
 g8FSa2+irQ2Jkut2qWCsJFvaewM2cIYARIZVe/KseyBbcuJ9HEpHRvCztnvcLTNxuHT7ubF4WWi
 w72UQmkmS/G6qSDKhx4Dq7tmlgka4SV+OFORmfwU1hulKH4UwoDQ9e3ARzJISFrDa5WY1u9WMyI
 P156saAfr7zhNSbQqSe5/vrv3l4B5FM/PkTeSUXo9K8wWSlBnizZTLbLEkSFler5dM4Eta8JOa9
 24fI+XR2xAwFvztYPIgN7aqcuNzwiWNPu10WySDIe2uy6/bdx0RW2ISpTx6Vy9Sp7b/BMxaHR4M
 x+90zImQ2nMMB9pnh5Itkcq1xOLbAfeZXl9nev/vHo2UYnw1uLyIjzrA8W3bfsbIp3a3f6LbNh9
 5kkycxS7KVILPlcK6RbDsmqyxiWvJA==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040064
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

* add user to mailmap file
* add define for configure memory slots

Signed-off-By: Pravin M Bathija <pravin.bathija@dell.com>
---
 .mailmap              | 1 +
 lib/vhost/rte_vhost.h | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/.mailmap b/.mailmap
index 0b043cb0c0..1725e5ddbd 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1266,6 +1266,7 @@ Prateek Agarwal <prateekag@cse.iitb.ac.in>
 Prathisna Padmasanan <prathisna.padmasanan@intel.com>
 Praveen Kaligineedi <pkaligineedi@google.com>
 Praveen Shetty <praveen.shetty@intel.com>
+Pravin M Bathija <pravin.bathija@dell.com> <pravin.m.bathija@gmail.com>
 Pravin Pathak <pravin.pathak.dev@gmail.com> <pravin.pathak@intel.com>
 Prince Takkar <ptakkar@marvell.com>
 Priyalee Kushwaha <priyalee.kushwaha@intel.com>
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

