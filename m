Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768A0CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:45:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDE8340673;
	Tue, 11 Nov 2025 12:45:43 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 47C1B40695
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:45:42 +0100 (CET)
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABA7qKj023322
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=G
 /1XBhQqTpf4UJuz8Z0qBzd46wngxr8lhv3gU96eUb4=; b=GrIGW97QtGYCFBXZc
 KOHGjxslRLQ166wThAc8pZ/SxfxjKaEqPxE0sSg/HUe8IpJngThMgeyZwoU7MBKd
 gxoo3dkdWK3pNnsgmcvmpYya04u+HAumYEnwjsqMk4vxPRNEEuiblxeOO9+tpNSj
 gcugWXWRre3ooaZRVtCFBhbcUD1QZzmQxauYKDpT/18JgfHnpQOmM6/zHhyQfBKH
 aRCvSAHOgad1M2flvBaH81lRe9puxoY5jtXu3CFsAbxNIvsKfQw2VUPEMm9Pa19L
 xdK+1wN3YGlX+d1Bft78mnYURtxza/d9cQMNNQXRDyW+We2ouZ8weJl+CgSWqBPE
 yK+NA==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4aa1a9m6vx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:41 -0500 (EST)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB8lnMN026022
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:40 -0500
Received: from esapsmtplv09.us.dell.com (esapsmtplv09.us.dell.com
 [143.166.203.151])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4ac1xphwr9-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1762861540; x=1794397540;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G/1XBhQqTpf4UJuz8Z0qBzd46wngxr8lhv3gU96eUb4=;
 b=nLSabINf87JxCuAbgMtAyA6yn5+nDnx3RcturdNsKgOhLjRkkn0glcKF
 DJgXeWl5xOwYNZ200iQz0qp0/LAKm42b2LalLwF3L2D3fDG0KS35jHWhv
 66p6Om1amxwc9B5LR36F0z0CA+cfd6ccNAUTR/qOAR0nGI2ex6Ig2L7oE
 5abhpZMxM+Ju00RfR+BArDPX5GRMQ+rWZ6YFS3Nr9fKw2/jDOl7EBcgA9
 cIFuvFDE7GO59dKisi7tDFvfFUG5EoE599nt84BcwlHbtT0hwiHWiWJic
 uI8oSGrtLTfX0/9q5+oF3qo4QtoZk7uB4RyEyKbmiL8KT7+Be4uyDD9Xi w==;
X-CSE-ConnectionGUID: e7FtGJOwQg6C268oig6IZA==
X-CSE-MsgGUID: TcXe26pZScawqOLW9X5/qg==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 11:45:40 +0000
Received: from ieorr5-ppwem001.delllabs.net (100.64.0.132) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:46:43 -0600
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-ppwem001.delllabs.net (100.64.0.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:45:38 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 11 Nov 2025 05:45:38 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v4 1/5] vhost: add user to mailmap and define to vhost hdr
Date: Tue, 11 Nov 2025 11:45:17 +0000
Message-ID: <20251111114521.2902867-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111114521.2902867-1-pravin.bathija@dell.com>
References: <20251111114521.2902867-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511110068
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA1NyBTYWx0ZWRfXwPtWub5fDPZK
 0F/rPWyoMNnL6y6ZPwQq6vuwNWrukc4UHwBfSbe0ZH21v6UdkQZ2EiiPEYavPadAxP26kaahFES
 4/QnN/iny2Ft4KhO5fcmV7zV9//cDmZx9MtfJ2sK14H8josWkWPHnCmfxi19TgGFYNwAmu5Qz42
 WO19jNli1/pv7MM62Iit1A4Jc2IC64eYoaUO2OsnUAO2h8rkK3vaBPqIv9F1LpkHDFixaADJC9T
 eWxgYnMiVxt2nFvUlTjs5BhkW3kiLK8j69WFdvCDqS4zgHl4ZxtizvtZ9fd5eMxMMPyCDIl0fav
 V/51ziKstTM43JoUqEiME2hAAez8lLeUkagDvdB0NesEoI+ROA8KGqxUPEcIdUCfcCzJBjpsAGf
 VicrY6utzVDPLotmvLBOCXuEnRKtSg==
X-Proofpoint-ORIG-GUID: fGknUdHfsLfAEi_-X1G6l_PgfER3nPr_
X-Authority-Analysis: v=2.4 cv=YPaSCBGx c=1 sm=1 tr=0 ts=691321e5 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=1BWgYg405ukQaXe9BCXDPw==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8
 a=M5GUcnROAAAA:8 a=3CDqXdsAvEiB_ezhLkQA:9 a=gbU3OgOOxF9bX48Letew:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: fGknUdHfsLfAEi_-X1G6l_PgfER3nPr_
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080057
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

