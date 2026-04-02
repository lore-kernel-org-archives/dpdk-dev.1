Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E00CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 07:38:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EF0140E09;
	Thu,  2 Apr 2026 09:38:07 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 9B2C240E09
 for <dev@dpdk.org>; Thu,  2 Apr 2026 09:38:05 +0200 (CEST)
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6324Odag462264 for <dev@dpdk.org>; Thu, 2 Apr 2026 03:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=x
 XmFL2PnBAs/4OZs7ekP9s2VrRxy8G5Cp1/LQZGXBWM=; b=DglEp+hnpxfxpN+G4
 QZdLXJhMPtACJdl3m/rDjBkjwI578QOp0yfC60Y+8IgebN9xhL6HB2/fC1fx9QTn
 z/leb1PLTKpQ+9MD7JWWf31uEvsEC1X8oxiqqTmoyi2UGhGUOaFBDlbX3Xg60yHc
 Oc6Rm0J6gPzOAdfmsHQD7FGHM9fdqFDm5Y4ez5UQUtTSEob6+kuB+BhxODvuXggN
 JyTqtfV5E4gmuS0yjainXaZ5OPNYmDfQRAWhq5DdEIZHDSnF8wc7jyQXb3kvmOyM
 1UH5N8o5fUrKUJ1d5sN/9Ym48pdPAq+SQGSZOfAtSuPX6kYfpUtO7YGj1P+9Ry+G
 Omytw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4d682nyvbv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 02 Apr 2026 03:38:04 -0400 (EDT)
Received: from pps.filterd (m0371675.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6327PJco1998953 for <dev@dpdk.org>; Thu, 2 Apr 2026 03:38:03 -0400
Received: from esapsmtplv02.us.dell.com (esapsmtplv02.us.dell.com
 [143.166.203.150])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4d9m0j066q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 02 Apr 2026 03:38:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1775115483; x=1806651483;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xXmFL2PnBAs/4OZs7ekP9s2VrRxy8G5Cp1/LQZGXBWM=;
 b=LjJmYjUt/JyBpm/1qjFlzetuTmJwtYL84l88iZjeWK+PkJcJlNs0cQUH
 zO4BgpvhWh3QXdZdTlsrw3NRjJNA5YrPCOaSlFNXn37oWm6prVajgAQjX
 d1CT4E29WPdB7iH/G7Isgy4B8dGBJB6oIYw3qcyeLgzOpJL4EoU9ZGN8g
 58bjO3Aib4a/hFaEdH1AfNGRSNKWAR2uJhfJOC5+OU6QPw7bD6oqW/HVs
 PYgIRCst7BqstlX0Nj81JwGBIu+88NvIR1KDLVur6vwwYEmO8SJgmdC7y
 s0nZATYMTMdLKdcc3CdbHAGrb0F1oTgjIZRoyXhiymm2pxgcJm4kCwLIr w==;
X-CSE-ConnectionGUID: EUrqrPJ8RCaNT2K5p/3XMA==
X-CSE-MsgGUID: l54xRvYUQLOQmaz95X74qQ==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv02.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 07:38:02 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Apr 2026 02:38:53 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Apr 2026 02:38:01 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 2 Apr 2026 02:38:01 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH 1/5] vhost: add user to mailmap and define to vhost hdr
Date: Thu, 2 Apr 2026 07:37:59 +0000
Message-ID: <20260402073803.3068147-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402073803.3068147-1-pravin.bathija@dell.com>
References: <20260402073803.3068147-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020066
X-Authority-Analysis: v=2.4 cv=d+n4CBjE c=1 sm=1 tr=0 ts=69ce1cdc cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=AlKjE2zswbbG9QqlC8cQbA==:17
 a=A5OVakUREuEA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=U3ti1ie9CgboSd2qXsAw:22 a=iLNU1ar6AAAA:8
 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8
 a=3CDqXdsAvEiB_ezhLkQA:9 a=gbU3OgOOxF9bX48Letew:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: AO3Nm3eM0yanV6rhbZ2VAqTdmc1SJB06
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA2NiBTYWx0ZWRfX9osuko5EPV+V
 BxbgeH79fzn52kINH7+pecpr5RlXwXsXxqGeYIv82q5oiIvy+8OvvoZvBXBy0JQnSpTtnLBvBjm
 aH5cvNHFneDi+oPtuA3GDhBA6ikgXqhToZULMjdZ6C3Li/8Ma/CiMzLIeV6z9FzTe+LoJrnpSrb
 JyJMu0Hlz27YtkJnjlLEcZJ0VUwa1LRh7B0BJL/+NjlHP+qa2oCR3VPcTuubvV9tEOnICRLrnTB
 kEPxlP6VgdMR6d+6uOaE3Sm0JdAfDB+TjMVYDTu6RhNxGL+F5lg2EB75Fpga9wg9bMfZ004lcs/
 aAYupBFBUAZl0REGK89Z/dfASORen7z+08WBdhDA6XMlVEyz/3GsFAXdu4R05qgE0j1+E/ds2W0
 AA1XYStrLfvQJd7IgelzS7FqH3bMsdkYR38z9f8RHncoNlgQKwXbotrsVT0DxsB8cL4TzYysaAF
 KKhSUDI96ImS+58O6BQ==
X-Proofpoint-ORIG-GUID: AO3Nm3eM0yanV6rhbZ2VAqTdmc1SJB06
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020066
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

- add user to mailmap file.
- define a bit-field called VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
  that depicts if the feature/capability to add/remove memory regions
  is supported. This is a part of the overall support for add/remove
  memory region feature in this patchset.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 .mailmap              | 1 +
 lib/vhost/rte_vhost.h | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/.mailmap b/.mailmap
index 0e0d83e1c6..cc44e27036 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1295,6 +1295,7 @@ Prateek Agarwal <prateekag@cse.iitb.ac.in>
 Prathisna Padmasanan <prathisna.padmasanan@intel.com>
 Praveen Kaligineedi <pkaligineedi@google.com>
 Praveen Shetty <praveen.shetty@intel.com>
+Pravin M Bathija <pravin.bathija@dell.com>
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

