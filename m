Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7EFC44500
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 07:49:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3FDE402C3;
	Thu, 22 Jan 2026 08:48:57 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 5877F40299
 for <dev@dpdk.org>; Thu, 22 Jan 2026 08:48:56 +0100 (CET)
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60LNxk9u005212
 for <dev@dpdk.org>; Thu, 22 Jan 2026 02:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=l
 x97InSopN/O1v2aDYcNgouB0arsBEJkleC9dU+DKrc=; b=JXpKZMCeLt4a9oSxA
 3J63PcUsdBGcXAY+gQ6MOGgcHPff6zdbsPdY76A1BGpQR3POHYKS+Z1giri2B5Sp
 76AwGPBJU8whWSom9iMlgxsPcPaQe/myne780G7JQcM7Zl+NZZ7Jo24puwS7Y1P9
 27ceWXHYxYPK95+UQG+5XpAjipH7pEIjXSlR3QCyYIfsI9mOvP2b7EsXSBdmG+go
 s8NBF+bVOjjs2oqaUSATxTB/W3Rkj/Sam+xPeYJgiX3nSJuich0YZK5WTVYdKCC7
 HFXLsqK6wQwxlgof+XrxI6p0Qp336uo97B2lD7fgzTpdl2oFjS359LDaKvS4BVVr
 AnofA==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4br74ymmqr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 22 Jan 2026 02:48:55 -0500 (EST)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60M6RfXa017224
 for <dev@dpdk.org>; Thu, 22 Jan 2026 02:48:55 -0500
Received: from esapsmtplv09.us.dell.com (esapsmtplv09.us.dell.com
 [143.166.203.151])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4budb6sq5e-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 22 Jan 2026 02:48:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1769068135; x=1800604135;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lx97InSopN/O1v2aDYcNgouB0arsBEJkleC9dU+DKrc=;
 b=GJ9+Cwh7Pq6p1TdDb1wL69UnYnOwya8y4TAQdatEVuVxI9SQDeQJaRum
 jq0bnfmrUC52Cj0L6cVN0j3PMZTonYpOx8xcIYazxS74VR3pS2uyJZHZG
 Oe87b3hKywb65d0scKZIbdxXltaKcU/4PM5HjKxamWIva/LR47iXwpAW3
 3y9qNCu6I9DdrRatOZd/dZOTJgb01+SX5B53RuTgaVBnfHz0IZGYPWJrp
 cKe/SocZYof9OTd7vv/ciYmJ9TGuPA20n0kymN14EKaCmQEHzwmPu3VmU
 rukaT+/s3i7ZM5P9BpTfRYQ6kLX5Cfd+UAuTAfiARsK/SjbSjdxOOU3NF Q==;
X-CSE-ConnectionGUID: LcxGXJ/jTlKcgMZt4OXsLw==
X-CSE-MsgGUID: POYMaj5PTaiDbclFFR2a6w==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 07:48:54 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 22 Jan 2026 01:49:57 -0600
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 22 Jan 2026 01:48:53 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 22 Jan 2026 01:48:53 -0600
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <maxime.coquelin@redhat.com>,
 <fengchengwen@huawei.com>
Subject: [PATCH v6 2/5] vhost_user: header defines for add/rem mem region
Date: Thu, 22 Jan 2026 07:49:03 +0000
Message-ID: <20260122074906.127942-3-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122074906.127942-1-pravin.bathija@dell.com>
References: <20260122074906.127942-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601220050
X-Proofpoint-GUID: mxuhI29ABk8Gc3aIk7FaHlTkLlMyR3vH
X-Proofpoint-ORIG-GUID: mxuhI29ABk8Gc3aIk7FaHlTkLlMyR3vH
X-Authority-Analysis: v=2.4 cv=JqL8bc4C c=1 sm=1 tr=0 ts=6971d667 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=1BWgYg405ukQaXe9BCXDPw==:17
 a=vUbySO9Y5rIA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=CCbkoWxl33X5vWekUEUA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA1MCBTYWx0ZWRfX+bkyNiIV5k2y
 wpYzDfU/XkpWoxD41IJxh4bzJeDJB/H5dksFPN0hWxPMJqI/Z+tB9W6tFvu8Reok8M+oOuC1ZP8
 zqqp3d3KyErIuI0bGwbvjQNDbvdHDKRcQ6u8UcFkvDZ6t0p5WghNd5ALXJte+/a2virGeXq/P1X
 YGU4k5MDXYpMTPG+StGdwqeWyPMlrY+IuGX4KDw3HsMB59ZsBQwnXeYqet9ySpu951V0foAjKQS
 5TOcx2b5LpEEXz+7Tp6V+yCly+oDN+wYJhsZgTgWlKwjGMaBnF3/evmSutO4AtgDeR3RrwXJi9i
 e6jel+H7+YMbAFyN3XDQ2LO3gYvedx7gzuzKc5yNQfA45J8oD4tRYET/KPDyWAUwgsuSi6eilDu
 R95doQ5rD0n6fsypHHi2YIInIGdRQ54M66OgtUvICkt0D1o5nHVN9wDQWTR16h53Z67nLjzz5qC
 2zUrfaSNOPyJfa8MRWg==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601220050
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

