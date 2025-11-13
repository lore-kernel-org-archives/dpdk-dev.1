Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198DACD6E4D
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 12:42:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4484540DFB;
	Thu, 13 Nov 2025 13:42:48 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id C2F2C40DF6
 for <dev@dpdk.org>; Thu, 13 Nov 2025 13:42:46 +0100 (CET)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD5CIYW020173
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=v
 IjhM0GOQcCVDmnoL/rEsrh7Bd7VLD+6DjaIMh7zrjQ=; b=shiALIYGpOvhZXkJ4
 y94Nc3kOO/P3aQ8WlU3BNG3YLsi4hI9hV0UusF1YxgLU/Jp8D0OttOPMNxla/v3h
 ByGpDtvcNIEMBp4Z/BZkVndpl3SCf3zxEr6a+uim5FEKPAyTDTFhC7xVMsMzBgSz
 IDTA2FiTSaGz0eRIZtsSjnzjh+zV6r+FIboDucbfsf9SU7agmwyO04AdQNpR2E/U
 kkXGyPaBdM7cA/ufcmJvXbpHDlA++BJ+5ZijayxJnLuMQjC9qZY5CN87+JXSWMGY
 ksaxqSWGMRlZqIRHleKykWs+aw86RahwpwQmg0uZg6QZpbHHf1Lzt0YcJn58YfKh
 NIyug==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4aa1w1s7db-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:42:45 -0500 (EST)
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADCHMst000809
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:42:44 -0500
Received: from esapsmtplv03.us.dell.com (esapsmtplv03.us.dell.com
 [143.166.203.148])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4adf6u89dy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:42:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1763037765; x=1794573765;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vIjhM0GOQcCVDmnoL/rEsrh7Bd7VLD+6DjaIMh7zrjQ=;
 b=flMA8kK7hQgD2j3OrH4WkmRDLa0RkDIoKYoiRcxIgCCf4svTUq3kAoio
 pIbVsnfrn8ybO4SCiZEcFjOutPXWN8rs59vD3H4EAeFyp6LsqSIsjuFWN
 72w62DQbhGzWxTuAm2l/aDl47zhwmNNKnqtp7XZRFnHkM6oeVLJIfecU0
 LHvCfXlukQg+lYmZFNZPnEmecmGyQIQ5Qqq3DuoZuuXIo80iEkFSlWPSL
 k7ICNfdP0YipTTz2MeSdHWjdrD0n49oPsEB0z/T8yIziTSsomP5Q6QVxh
 1B8jIrJMl4kV/kst61fJX1Fgs1cAj2KVUvvChC/sb/kS7LP/WQTzekDo7 A==;
X-CSE-ConnectionGUID: XoulY6ivRj2Mq9pZpcov1w==
X-CSE-MsgGUID: woivRBfRR/20U5ywYQ4Ifg==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv03.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 12:42:44 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 13 Nov 2025 06:43:48 -0600
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 13 Nov 2025 06:42:42 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 13 Nov 2025 06:42:42 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v5 1/4] vhost: add user to mailmap and define to vhost hdr
Date: Thu, 13 Nov 2025 12:42:07 +0000
Message-ID: <20251113124210.2913846-2-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113124210.2913846-1-pravin.bathija@dell.com>
References: <20251113124210.2913846-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511130092
X-Authority-Analysis: v=2.4 cv=a7g9NESF c=1 sm=1 tr=0 ts=6915d245 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=iGMIhCliR854E25UHWhNxg==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8
 a=M5GUcnROAAAA:8 a=3CDqXdsAvEiB_ezhLkQA:9 a=hlJyneSgMmFPbskH-t2w:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: dLz_t5W79NkWE-JXiCyO0JN_myv8l5tB
X-Proofpoint-ORIG-GUID: dLz_t5W79NkWE-JXiCyO0JN_myv8l5tB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA2MyBTYWx0ZWRfX0T241fSaw4p4
 WeKBt1B8fX4wBoHkVuz5wTFdSnAnfMjYI7vTGr31wUV/6PNsoMtRMGyxTqdXmfCg3G3sYosVoRA
 BdUwJUJ/aJND2WlraaKWjqkTb09re4boYN3dNAU4JhkeMAfUs920sKfgkOOkH6Mr+K0LRIVuQjN
 MlxbD51eTEBQXb8xXpdIO194HVhNiM+bTJ1Bdl1xiLb7LUe9fYsdmfXiOcjcrvZYkh+Zpnio53N
 a4eCXopGUsN0xiq63A/VDHFtVha+jAbenyuab5A9mp5VK01LVnDhxw0sAOg4wBtQRXR8FRUZ3Ee
 Hj9jv6kDUXNnFamzBtvV4ZV23TLPBwemcJmJv/KcLqOsZM9x9vGOUXqKhhnxGy4dtg5n9wvaCSl
 9Cv/VsdncXz3Rf9JnwHD3FaIdaU9zw==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080063
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

