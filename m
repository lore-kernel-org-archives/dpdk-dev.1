Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC66CD6E4D
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 12:42:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 601A740DD8;
	Thu, 13 Nov 2025 13:42:56 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 6027340151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 13:42:54 +0100 (CET)
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD9bI7p023083
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=v
 8Ns9WAFNzjQZ81cMfPcGdaBnn2n6XflWbfbVuuZpl0=; b=QeNZf3h8kRXpZtdDE
 g2gOYHQksVpuKyKAMzdzBjzbCUkeCzNe2oKZIhIkNudV14aih9LllYLvYynI7njv
 OFpiCYktX6v8MZM0zzTPsA3BiAg2oe0HaGNcfz0H6lnPcjzl4RsR/05zQGORit+d
 8tRqPJsqnMyyrTnwjEVc75gEzvrGZ51RjS+wM+YG4o9d68vDnf5Vtm5jG7uy3sc+
 y56C8ry7iImWxTAeQ0laNmJQ14T8QRX9N8i0m88Em9UYb5IU04Ct3n1iy+U/rk/z
 pWG8si3uMFgs8ONqY06wefBzUj8RyjxeKBln5rG9BFqBgCVaBLQ0j86ijkNt87Dq
 6wt8w==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4aa1aa1gtm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:42:53 -0500 (EST)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADAlp0N021653
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:42:52 -0500
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com
 [143.166.203.146])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4addw4sb3x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:42:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1763037772; x=1794573772;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=v8Ns9WAFNzjQZ81cMfPcGdaBnn2n6XflWbfbVuuZpl0=;
 b=VItdwSNQZ9/1vS6f63admPTuUXyjwVD1cX1inJalObYS4pURiXSzsAfr
 R3imm+k6mGwVn6Vh+W/An33hP5p3Fx+9GEyd1g5mdOR0UT+s7DFTWWqph
 vmRK3NJMqlObiX5oWnx5y92pR/t3KHcyBbfOl9+3+O/Un3wwtoZssad4v
 vTtm4ztU6CBf5xlo5D1gVrE+KU5Fs12Bhs6mrkyUeKseyNxVzravpAp7A
 DHsH+/hqo6xhGauXfekUqOFXoTF7rGbbjBfFtOu/RnCF2/5x9BlL8apJi
 5Gsox2AKFHukNvIsFKrodiopc/0ZnJPmsMDkfgp9otoEt6r7DV75p/EWo A==;
X-CSE-ConnectionGUID: ADT4bxAUQiOw6UcK8cuQwg==
X-CSE-MsgGUID: TBw7JwuvT1G0yf0v692Rmw==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv06.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 12:42:51 +0000
Received: from ieorr5-ppwem001.delllabs.net (100.64.0.132) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 13 Nov 2025 06:43:45 -0600
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-ppwem001.delllabs.net (100.64.0.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 13 Nov 2025 06:42:50 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 13 Nov 2025 06:42:50 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v5 2/4] vhost_user: header defines for add/rem mem region
Date: Thu, 13 Nov 2025 12:42:08 +0000
Message-ID: <20251113124210.2913846-3-pravin.bathija@dell.com>
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
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511130079
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA1NyBTYWx0ZWRfX6heVa49JmiJH
 x0g4IWjjpSLRgXA0FUkKgrv1YKPopMVWSRdfUbrmKnaFmtLiUEDKTIYcqOxnggxeO6PfMC2h9GR
 YZPnp2KLbC7WFp5+6AOh2279LdX41fDkNVesYvlGlxTiIsQ/WHLkeWiH4tgJIg19cOiuV9+EG3g
 LvqQgghxzDmZu4WSQ/7F4BunRk1XxbpauUvfof4MuFeXzCeZF7b5+i7/KRvCqqXpP0k7t9dSmF7
 BuhrQlj3Fp+auTzJzgXkMXCex+pQfWzsqmYHQkBP3dIpu/HocO4QV6pE7bjwoSYaxhhTRpkqJ1A
 X1w5piYr/a12IjZcBFFR8LPDq0Z6+mW1eDLVC6BFiNtidY9RdymgQ/OGPoodTe4ewyjQYWCDPw8
 8SI0G8l4lshvUIVxYcJj2E1Tjc7JQA==
X-Proofpoint-ORIG-GUID: oEydCBshU4Sdi4MnxBNhRgYIbzEobbP1
X-Authority-Analysis: v=2.4 cv=YPaSCBGx c=1 sm=1 tr=0 ts=6915d24d cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=SZDRi_bp6sUVpNgfmQ0A:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-GUID: oEydCBshU4Sdi4MnxBNhRgYIbzEobbP1
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

The changes in this file cover the enum message requests for
supporting add/remove memory regions. The front-end vhost-user
client sends messages like get max memory slots, add memory region
and remove memory region which are covered in these changes which
are on the vhost-user back-end. The changes also include data structure
definition of memory region to be added/removed. The data structure
VhostUserMsg has been changed to include the memory region.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/vhost_user.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h
index ef486545ba..5a0e747b58 100644
--- a/lib/vhost/vhost_user.h
+++ b/lib/vhost/vhost_user.h
@@ -32,6 +32,7 @@
 					 (1ULL << VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD) | \
 					 (1ULL << VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) | \
 					 (1ULL << VHOST_USER_PROTOCOL_F_PAGEFAULT) | \
+					 (1ULL << VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS) | \
 					 (1ULL << VHOST_USER_PROTOCOL_F_STATUS))
 
 typedef enum VhostUserRequest {
@@ -67,6 +68,9 @@ typedef enum VhostUserRequest {
 	VHOST_USER_POSTCOPY_END = 30,
 	VHOST_USER_GET_INFLIGHT_FD = 31,
 	VHOST_USER_SET_INFLIGHT_FD = 32,
+	VHOST_USER_GET_MAX_MEM_SLOTS = 36,
+	VHOST_USER_ADD_MEM_REG = 37,
+	VHOST_USER_REM_MEM_REG = 38,
 	VHOST_USER_SET_STATUS = 39,
 	VHOST_USER_GET_STATUS = 40,
 } VhostUserRequest;
@@ -91,6 +95,11 @@ typedef struct VhostUserMemory {
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
@@ -186,6 +195,7 @@ typedef struct __rte_packed_begin VhostUserMsg {
 		struct vhost_vring_state state;
 		struct vhost_vring_addr addr;
 		VhostUserMemory memory;
+		VhostUserSingleMemReg memory_single;
 		VhostUserLog    log;
 		struct vhost_iotlb_msg iotlb;
 		VhostUserCryptoSessionParam crypto_session;
-- 
2.43.0

