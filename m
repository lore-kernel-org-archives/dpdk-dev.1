Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984A7FF885A
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 05:53:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6D9A40659;
	Tue,  5 May 2026 07:53:07 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 4955740616
 for <dev@dpdk.org>; Tue,  5 May 2026 07:53:06 +0200 (CEST)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6450Quku969782 for <dev@dpdk.org>; Tue, 5 May 2026 01:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=x
 XmFL2PnBAs/4OZs7ekP9s2VrRxy8G5Cp1/LQZGXBWM=; b=VqBkvqhdJFPoM6s82
 aPwSORdGQUPokgL2m/EYHx3ls5rfaN+VBrrnS3Iq+cJuKylTOAuU/xT+EbzEmw/l
 +Yk0WcLrk6jEXsHokK6tqC+NiWdpZHof/a2F3KfjeqMyYdYCp/MXtg8bk2F5ecY7
 0GhdtCBT57jVYN9+Rl9jvlKj8c4LjCO5O6rMmmhFvAnYUSE+FgUnAaehuo3M56Ki
 QXM4mLcez4BZ3HUMUZI/HbTESVUAvDjcmLBOJh51Wtg3aPWSJuwCXAowHl0YK+AI
 PIHXNoYN60VgpTGK4C0JBYUkzoqzLa/EUPEotCYxHYw90KSLSf6fdt6cmQ764zqA
 oWhTw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4dwcdqsk4q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 05 May 2026 01:53:05 -0400 (EDT)
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6454umMd2213920 for <dev@dpdk.org>; Tue, 5 May 2026 01:53:05 -0400
Received: from esapsmtpat05.us.dell.com (esapsmtpat05.us.dell.com
 [143.166.211.154])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4dxv9nkfc0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 05 May 2026 01:53:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1777960385; x=1809496385;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xXmFL2PnBAs/4OZs7ekP9s2VrRxy8G5Cp1/LQZGXBWM=;
 b=LDC7WJjEgyBDmOhpnjZxOoQu7ZhvVi7QZlgYA1irIjRx52xkLCKPyude
 DxajD6HiAeFk4ApvnbqeObe2PK5Xaeh4GRU3dnbcYwoiEzwV/2Q6trIOR
 wsXJgujM2Qm7dMEb80Lyubd8CfkiU5YLHbGMsZk1TOsSr5tLAiMwXhn8s
 e9sRZJRWf2I4UZzj5mNy32FPIMsY5DbfRGK+c+scTRuXfnzx7Y+3Dt+ZX
 xgdW7P2NLhuMirBBM8gBJP3d5pHLMmPKGnABqxVM7lvZvwqwl2yo5tVvy
 GA5BNtl7v0qcWRPHFT5rWtm0a58skt5p3dzPKFsrPZLGtu27EMiaCRb+2 A==;
X-CSE-ConnectionGUID: Bf7gdVjPRm6bLFoAVeaVEg==
X-CSE-MsgGUID: LZIr8fe6TOy3TNZESeS8EA==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtpat05.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 05:53:04 +0000
Received: from ieorr5-ppwem001.delllabs.net (100.64.0.132) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 5 May 2026 00:54:14 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem001.delllabs.net (100.64.0.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 5 May 2026 00:53:02 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 5 May 2026 00:53:02 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH v11 1/5] vhost: add user to mailmap and define to vhost hdr
Date: Tue, 5 May 2026 05:52:47 +0000
Message-ID: <20260505055251.818594-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505055251.818594-1-pravin.bathija@dell.com>
References: <20260505055251.818594-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_01,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050052
X-Proofpoint-ORIG-GUID: _pDfKViGApyfiYyOMmFC0pV0PoiCuMPy
X-Authority-Analysis: v=2.4 cv=AsfeGu9P c=1 sm=1 tr=0 ts=69f985c1 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=uswt3CficuEu8DJvSCSroA==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=aNt9FJNJ8fZyd9HhltU_:22 a=iLNU1ar6AAAA:8
 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8
 a=3CDqXdsAvEiB_ezhLkQA:9 a=gbU3OgOOxF9bX48Letew:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA1MiBTYWx0ZWRfX78tK0F1JtlMc
 I/zAl/hJLFkgYrRh7S5IDdV/rrZfemzS3XgMw3VTZMOCLg+CZOFkns+bv9HjBzcKVD3MgOR0W8v
 A6no4fEP9hX7Z+JBYGVxGRo0hsjA8PEHGGif2LBwYW72FeqhwVagwjOe7f9ECc0fDbGrvyQpGPd
 94aeY9274rvhJt/JiwroJlbPn0lN9xUDIfXhU8Tsh1+cz2eIEShM9iv6dOGkCveF5mmiksRDJIa
 BCajDXgh8i6lrH66KjrYAISUTLgag8GZozQiK9VrWFiNk3juDNmVhHDMk4XQIVVbKnfE7M+g+KL
 +QavOoOGHry22GUu6/YfCJqUxbRLSEiNNkAq4ydUOh1srEToEsxRAZ+ha8Y5b+1Wc5/cY/vW7s+
 6XNaeKCVgzsQav8JmclpL51feQ5uawnqRQqS2iB7IMbRgWp1rFaFAESasSuOOEzI23E7JBSv5YH
 yG7sGCYGA4LaLgB0zOA==
X-Proofpoint-GUID: _pDfKViGApyfiYyOMmFC0pV0PoiCuMPy
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050052
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

