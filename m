Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6150FCC6B1D
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 01:54:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 652FB40E2D;
	Fri,  3 Apr 2026 03:54:03 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id A269D40E26
 for <dev@dpdk.org>; Fri,  3 Apr 2026 03:54:02 +0200 (CEST)
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 632JoGtY3981630 for <dev@dpdk.org>; Thu, 2 Apr 2026 21:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=l
 x97InSopN/O1v2aDYcNgouB0arsBEJkleC9dU+DKrc=; b=Ts9pK0N5HTIQZy7JJ
 2JVWkD2AtYN4pHQZ3mTfw3tQYxS5Y8LhP/JRe90BOwjsYg9TCI/kLe1asnfnyOBQ
 k0B3WKM8E3KzTnG6PbOnzsejmboiafRJBAogjyqaVHfGRQBjSY+ope3MKHDdIMrT
 ibh7PLjhcLDGNX29ekCUxJHoN7OQX2rM5RFXdvy80zPX+MC21xe971OSKS4oa12M
 imdkxxW/SLeGZ9cevNHvhwYQvJ4dqid37XQlGrgl38YC7rn7EtQr1Zslyo/8ricN
 3Ydmu6Qh+JTy42/+eO3DryolO3Z8y9D6pwBVdLtNTSkwFR3FKXJdnelXA9GI8l+k
 10TmQ==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4d682p549n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 02 Apr 2026 21:54:01 -0400 (EDT)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6331lbkO1305381 for <dev@dpdk.org>; Thu, 2 Apr 2026 21:54:01 -0400
Received: from esapsmtpat03.us.dell.com (esapsmtpat03.us.dell.com
 [143.166.211.152])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4da1s29j9m-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 02 Apr 2026 21:54:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1775181241; x=1806717241;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lx97InSopN/O1v2aDYcNgouB0arsBEJkleC9dU+DKrc=;
 b=CwfJYhfgxbSbBeZDwfmr4uggly88PiRcix9Hjkz96j85TPeAzdKY538L
 U+jO3thnA3wtAcydmW7TbElWOnpK7giTC6ZZ/WxtIwcavmKFKqlab/KXv
 /oWNmnxz+zO7nYTqY59mjjtZ46lEuGSQdJj+q2zaPrCdxx1ONlVPYMRAR
 FJt+6e0F1L1rTPhNnCKA1A9s0fCLTrqBGYYFWh/YH89qLydokvD9nXNZS
 z5WMQLkeZuFk4g87Z1SVSFu8Np+KomipJVUj/wMw+bDpOLWNNEnSVWXya
 6qgC1IAo/RJ64eonrX1UWOaYTjLQJPUHXefRV7BZADMq/VEHPvTDGkTTO g==;
X-CSE-ConnectionGUID: SLfE4eaDT+KCDImgs4rvpw==
X-CSE-MsgGUID: TRnHXNdARk+3VIctkLC/kg==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtpat03.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 01:54:01 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Apr 2026 20:55:03 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Apr 2026 20:54:00 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 2 Apr 2026 20:54:00 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH v8 2/5] vhost_user: header defines for add/rem mem region
Date: Fri, 3 Apr 2026 01:54:31 +0000
Message-ID: <20260403015434.3124102-3-pravin.bathija@dell.com>
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
X-Authority-Analysis: v=2.4 cv=d+n4CBjE c=1 sm=1 tr=0 ts=69cf1db9 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=Exi4HLWdEtKd1bGGvbjpxg==:17
 a=A5OVakUREuEA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=U3ti1ie9CgboSd2qXsAw:22 a=iLNU1ar6AAAA:8
 a=CCbkoWxl33X5vWekUEUA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-GUID: tnco_1oLfO-UwlKu7HgMIS9FQdwC_Nij
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDAxNSBTYWx0ZWRfX1RwA2BuSt1Sk
 dMyBf/7kmEKck3ehyCVAzyxTCvQ8i/OC3s6aDBwiN4C5j+v6+jee+GfLjb5Ce/NBaxsfcMf1tek
 LgL6NsC1Neg0H8DwNN8/g7UsiDWB3Ha7WS5HTy9rFiVYh1Vg6wyKhtwWZ4slVuCd+OVfAwa0Irr
 iMltvSt6kACU6aaJO1YA4l6aKi96EJ8/5R2pqatej/F0Odzwwdq6+aexJrerAmzJO3f90VqA/Gg
 6JHeo2KCy2yFAmaAULFRQumAwNExx+9Kha1KHF0VUW7xkP49O0ev2rksI83xoPGBgOnS2JiSjUA
 9Y3kYEzOQdkSba45mI3WWqXqJtbf3FFdNgjaD6klk+zRJc0McC48DtvN9MbBR/SjcjohJaZw5pa
 gFBa98XMddRVgnKWtMjv3gw93X7f6Gqxf7bEwPR+KC7FXKANmpCU+MAR7RkDl4tU8U5W94G3tko
 OzA/AZirUIl3Z/HKfgA==
X-Proofpoint-ORIG-GUID: tnco_1oLfO-UwlKu7HgMIS9FQdwC_Nij
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
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

The changes in this file cover the enum message requests for
supporting add/remove memory regions. The front-end vhost-user
client sends messages like get max memory slots, add memory region
and remove memory region which are covered in these changes which
are on the vhost-user back-end. The changes also include data structure
definition of memory region to be added/removed. The data structure
VhostUserMsg has been changed to include the memory region.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/vhost_user.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h
index ef486545ba..f8d921f7f1 100644
--- a/lib/vhost/vhost_user.h
+++ b/lib/vhost/vhost_user.h
@@ -67,6 +67,9 @@ typedef enum VhostUserRequest {
 	VHOST_USER_POSTCOPY_END = 30,
 	VHOST_USER_GET_INFLIGHT_FD = 31,
 	VHOST_USER_SET_INFLIGHT_FD = 32,
+	VHOST_USER_GET_MAX_MEM_SLOTS = 36,
+	VHOST_USER_ADD_MEM_REG = 37,
+	VHOST_USER_REM_MEM_REG = 38,
 	VHOST_USER_SET_STATUS = 39,
 	VHOST_USER_GET_STATUS = 40,
 } VhostUserRequest;
@@ -91,6 +94,11 @@ typedef struct VhostUserMemory {
 	VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
 } VhostUserMemory;
 
+typedef struct VhostUserSingleMemReg {
+	uint64_t padding;
+	VhostUserMemoryRegion region;
+} VhostUserSingleMemReg;
+
 typedef struct VhostUserLog {
 	uint64_t mmap_size;
 	uint64_t mmap_offset;
@@ -186,6 +194,7 @@ typedef struct __rte_packed_begin VhostUserMsg {
 		struct vhost_vring_state state;
 		struct vhost_vring_addr addr;
 		VhostUserMemory memory;
+		VhostUserSingleMemReg memory_single;
 		VhostUserLog    log;
 		struct vhost_iotlb_msg iotlb;
 		VhostUserCryptoSessionParam crypto_session;
-- 
2.43.0

