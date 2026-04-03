Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F7CCC6B1D
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 01:54:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AE4440E0F;
	Fri,  3 Apr 2026 03:54:02 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id D1F3040DDC
 for <dev@dpdk.org>; Fri,  3 Apr 2026 03:54:00 +0200 (CEST)
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 632KiCBM992259 for <dev@dpdk.org>; Thu, 2 Apr 2026 21:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=x
 XmFL2PnBAs/4OZs7ekP9s2VrRxy8G5Cp1/LQZGXBWM=; b=qc/K7MNs8Dvf1/O4V
 vdRhzRJeLe7DzkL41wzan2qbWE2E+DGgytJnETJl64oQETN8PHpUThLXbZUy3Kjm
 jDV8sG52VJjOOu4I4n8T5pelhGluRnWujBtgUZRIBoiiIAsFCFSV8zxMjZuH/ceq
 Zj3oz+vEGcOFNWuo5GnuyjqmXpRhfLj6ZPyocP6FS12O26rzyB0x8bbSIxXXR5h/
 S8Pu/oO2BNt4dWKoW50Qk3wJs23HqnTPHlIEFAKd0vaaJc8uUZ5tJx9+B5i3GtyB
 tNLIGXbIEUfpP07ZGSz61PGjKj0W8see9VkHqXxzn8k+hA1mIkZ5G4VgvQjUgqOy
 H3Y6A==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4d6a75vqpf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 02 Apr 2026 21:53:59 -0400 (EDT)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6331lbkN1305381 for <dev@dpdk.org>; Thu, 2 Apr 2026 21:53:59 -0400
Received: from esapsmtpat03.us.dell.com (esapsmtpat03.us.dell.com
 [143.166.211.152])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4da1s29j9m-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 02 Apr 2026 21:53:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1775181239; x=1806717239;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xXmFL2PnBAs/4OZs7ekP9s2VrRxy8G5Cp1/LQZGXBWM=;
 b=WaBFbq2lTAjjWhd5UT5O6mbMm6uUfAJfI4owMD+dDW4ke1O7jTj/cQjU
 aBVNkIm6IbZaAS8j6A9cR5dT4tyQcoCccQSF1wUMxl3OulKPDS7hADGjB
 p2E9B6TjHGTvMVMDrtl8y/Yl9sXpqOqqL2u0VsksDGOV+PLzLr1TAcX5a
 lJ/FiJeMv/utLX0/zs8ZxbBXzv7bveqm9VVu9krucfigzT+CDpfMMYzZp
 KQuPzEMg5HpaZkHCk008C/2c+3GhrAk0yxgq1qAc9InUqm8kE/ziF55bY
 O+BLYzrhedWGUQrOGg2RzgouEPqyV103etr1ST7VtYSNXQIaYTS6YOl68 A==;
X-CSE-ConnectionGUID: MofvAd+URsOn1NE++zfIZw==
X-CSE-MsgGUID: 4LM3ByBTRqSwY1dGRRSe6g==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtpat03.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 01:53:59 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Apr 2026 20:54:50 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Apr 2026 20:53:58 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 2 Apr 2026 20:53:57 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH v8 1/5] vhost: add user to mailmap and define to vhost hdr
Date: Fri, 3 Apr 2026 01:54:30 +0000
Message-ID: <20260403015434.3124102-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403015434.3124102-1-pravin.bathija@dell.com>
References: <20260403015434.3124102-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030014
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDAxNSBTYWx0ZWRfX+G4BjM/cred3
 8UqooEPmi05STDilcUZQElWSEWaNfHW5gkBMne/yDjrDmlAYEnKpbcR+GPhJ4PnR+g54Sln1Wdr
 RIduP/l5Lo7YgXKEre/GLGppP7URSR8fO6wtAJkPTpQrq25+msfRoBgi+RBiPepUQy+sAiXX8wW
 0h6UAS/c2B1yHl2O4JlrtkmCvcAnW1ci8LXmN7zsKyYKGpwo4WOiepnYjvz2O8OnnUMIdp/IpKf
 yRglccxEFJcsKWFRse3k8TRTZGn89NG1ll6IRHG/8Fx5+NyJUQsSia1MbrNUmAOssegeHSlPqGD
 7CxZnd1DnA05/QUJEWb2/KcwGuGQOH7JomaP2U7T5ZskPNwnj87FbwiLZZadDOSKz6y8RBGS8T0
 uv8L+/J0Fa8e0ScT3ufhR+5tas4y0XaeW4OhtVNOYXlThnwgBCpL4I3zt9OMa9YwO+OY1C1qwzw
 OkC3vNssQB9+L5nohHg==
X-Proofpoint-GUID: OEU7bLb3-7xyGGcbws_50Llv-42hrdRo
X-Proofpoint-ORIG-GUID: OEU7bLb3-7xyGGcbws_50Llv-42hrdRo
X-Authority-Analysis: v=2.4 cv=FJEWBuos c=1 sm=1 tr=0 ts=69cf1db7 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=Exi4HLWdEtKd1bGGvbjpxg==:17
 a=A5OVakUREuEA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=vUAfKriDyi6VqHAKCLgX:22 a=iLNU1ar6AAAA:8
 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8
 a=3CDqXdsAvEiB_ezhLkQA:9 a=hlJyneSgMmFPbskH-t2w:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030015
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

