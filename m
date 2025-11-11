Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BEFCCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:40:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D6C440670;
	Tue, 11 Nov 2025 12:40:33 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 89E9640663
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:40:31 +0100 (CET)
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB4D8mD007080
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=v
 IjhM0GOQcCVDmnoL/rEsrh7Bd7VLD+6DjaIMh7zrjQ=; b=KOEYIE1CqkdezFNpy
 U9qZ6g3riQhDvfXHo+jSJnk0g4+xoANGWJwJNeGTsAqUxkGo7/+ZHMg6doNTANII
 uOjgnRs90l9ZZDcnK82bNwiaGKTMJwggdDN1YFDhIifA0ArI4OTcoM8q6QCrAWyn
 lFa4acr0F/XQQ1TE+FvUHHimljj3SxecQMzY4TfH61N2mGVO+EI4w5z/GpxDmSjm
 nTtpSpiHx34Ya461Fda10t3ntClFBkIzZ96tT6h/OfrczYFAaIC/7MTBdKy+RE9r
 BKyokzzsBbDVnBTRdDTBVuT4ArdNI43uwG6sp6WgYIAALAuoGTjtrZv61L/kDABq
 1d3zA==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4aa2rpkybe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:40:30 -0500 (EST)
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB6mbIe006861
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:40:29 -0500
Received: from esapsmtplv05.us.dell.com (esapsmtplv05.us.dell.com
 [143.166.203.153])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4abxg348et-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:40:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1762861229; x=1794397229;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vIjhM0GOQcCVDmnoL/rEsrh7Bd7VLD+6DjaIMh7zrjQ=;
 b=WJS0uncQzSetpoREm2TamsMvXDiUFNUwF2Yx0awufgtnIDPS+bMrqZyA
 aRjRDvPtStlDd7sI1lz1WUMLxJyFP5OayLnUf5cUx20ZU2JR/RdQ2IXLq
 tWEhig3+FU1M+PEYdi8sJBLrudV8Q/cIrhpUKbML7KBAO4vAOVCy01ybh
 ILGX+ymRBLlnJNoG9AMrx4U5EJmLUSXueDYwUiwmwzluMvM7E/m1V6BLw
 1JkOdFEdT+B+75ouNa/Z1Z0/uBWtNDOWh6VQKVd+YoF1mqjKq1CZlCmGI
 m7kt5/GYYaF7n/miteiHnA5BMgNyfa2k96nRM90rutAPg2k/nGLxMrxVg g==;
X-CSE-ConnectionGUID: 56vzQhYZTxmB1RFN02wWsA==
X-CSE-MsgGUID: myNsmcW1TaOaE/ZnM9bnAg==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv05.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 11:40:22 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:41:27 -0600
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:40:21 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 11 Nov 2025 05:40:21 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v4 1/5] vhost: add user to mailmap and define to vhost hdr
Date: Tue, 11 Nov 2025 11:39:58 +0000
Message-ID: <20251111114002.2902696-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111114002.2902696-1-pravin.bathija@dell.com>
References: <20251111114002.2902696-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511110034
X-Proofpoint-ORIG-GUID: 8EWkcGb9ragk4I-VAPfNZrWuK13JGSaI
X-Proofpoint-GUID: 8EWkcGb9ragk4I-VAPfNZrWuK13JGSaI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3MCBTYWx0ZWRfX1LwUJXaBwjiY
 ZzqluiHsoGAHpbeji0Waai8jA08d+r+HRXBXf3J5wTMowkyYmP3VwcjBlXiKvTdUpD5FturL/xe
 edTbFdiJWemwsdID2MF/NFXyjUd0ZFhDjMsQUu+hj0wn/zHTuFhQy3RrsfFbxJPThtpCl8lEcZt
 +NRXHm//cdc+CLBW135y/zFTXdhNqOtIPwaL/EhtM4yzl6A9m3avUkLVwNs1T39apDx/6xTij1F
 ZjD5a50O9Ru+rbuuQHczAQVTOARo3JXU22q0wrFD53DCx3G420zRKSak/tMISox1dw/CQXOXGAr
 TiQsYddIaTUVFcFjEPiDvQqOvFJpgCwPhJqPEvP26UVYkQ541C+R2oU2uSNyj6AHBIIUPSP5wKp
 5LA5zdQHG9D+bkqwSNXTOyFUAstDag==
X-Authority-Analysis: v=2.4 cv=UqVu9uwB c=1 sm=1 tr=0 ts=691320ae cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=t4Iba6VQkoKuxR139xjPXA==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8
 a=M5GUcnROAAAA:8 a=3CDqXdsAvEiB_ezhLkQA:9 a=hlJyneSgMmFPbskH-t2w:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080070
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

- add user to mailmap fle.
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
index 0b043cb0c0..33b8ccf92a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1266,6 +1266,7 @@ Prateek Agarwal <prateekag@cse.iitb.ac.in>
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

