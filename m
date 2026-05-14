Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B84CD4F39
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 May 2026 22:46:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51C634064F;
	Fri, 15 May 2026 00:46:43 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 4B57D4064A
 for <dev@dpdk.org>; Fri, 15 May 2026 00:46:41 +0200 (CEST)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EJ1WW43716863 for <dev@dpdk.org>; Thu, 14 May 2026 18:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=K
 GpmCNj4uSTXl2pij3fq5mzREVLTz9L4hgU+zdob5aI=; b=CMsp1odCHS/fLjlQH
 C0AqtI9q8g6P5EcvVN5WM0ovsOHju3i/zj8dibIXxm1e4c1RxgMuTUJvBJDVqI1H
 y1D5MX6RkXiHxUzAuvZlPx2eBDzeA8Emcv7WJraR3nKHovNq4zhxo4cQVTtXFQtj
 CzSVVJMHsxr54E7h4D18Awbv4bfI7fETkq8Cshj88bkL4tizrVK38xIkz/eYHgiK
 UJ9WDYio2lTelxLQt4pDIYzExnLpTrRTau6TLVfJpPquwR1gA52PuyHBry0PEwh5
 BubJO7WQ0MOVISG0kTntHr9JfSRP85ZSV7yNUk3iBqw6wl9Cf5e5rLtI9g/vjWoJ
 AsCtQ==
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4e5m6g8pxx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 14 May 2026 18:46:40 -0400 (EDT)
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64ELmSgB794030 for <dev@dpdk.org>; Thu, 14 May 2026 18:46:39 -0400
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com
 [143.166.203.146])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4e5m6m2a9f-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 14 May 2026 18:46:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1778798799; x=1810334799;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KGpmCNj4uSTXl2pij3fq5mzREVLTz9L4hgU+zdob5aI=;
 b=lA/OTEGZ8lVHeZsQL3yGCxRnR6tQvJ523r/3DU7e2Q6crqo+HbiVaWhs
 CpW09n3gpAt3GtDRfs7SnPh9ws8XKZv+fyrKP8RbtkCWYl6oSKqeWK8No
 OoECJ1AXl/U+nyS4WAOaCCOATutPdxAn/nqlk6z6i2n+JcYVMu/IYZxAo
 nvAtFS71jAjE2poQegNtJvSPj6wyQpfJjyAz2y/nR2SzXxH0gJj2hqVBa
 pOIJ1xVdZu7bV4z/UspGyn3Nhv3lmPyYMuNaRyC4bCqjWrSmCB4yl4tAK
 YKAYvcUjJ7GoxHdmlwAy9HNohOztD5ku0vHmrIyo7XU1DLBoX00rya0s/ Q==;
X-CSE-ConnectionGUID: cW4gyvq2QdCnY1tx3Z/tig==
X-CSE-MsgGUID: 1FeVWsi7SAWQdPln9+gqDw==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv06.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 22:46:38 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 14 May 2026 17:47:53 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 14 May 2026 17:46:37 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 14 May 2026 17:46:37 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>
Subject: [PATCH v13 2/5] vhost_user: header defines for add/rem mem region
Date: Thu, 14 May 2026 22:46:24 +0000
Message-ID: <20260514224627.2014566-3-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514224627.2014566-1-pravin.bathija@dell.com>
References: <20260514224627.2014566-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140223
X-Authority-Analysis: v=2.4 cv=J8OaKgnS c=1 sm=1 tr=0 ts=6a0650d0 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=aNt9FJNJ8fZyd9HhltU_:22 a=iLNU1ar6AAAA:8
 a=CCbkoWxl33X5vWekUEUA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-ORIG-GUID: WyXnR-MF6jZELtG-1S_DG9-9oz3Zb0hY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDIyMyBTYWx0ZWRfX5UyIGMZ3HrGv
 ds827uf/Gj+G2YlTPBrx5TPIy8Rb6p2Iy7kxcVyX/gg82bpO9gcWXE0vnp7fdHDOXtVV9NZBRnQ
 6H6REt9FO7gmqv7YFJVBHXC6qvPdpJYlHjbUybcWaKyMzsrlF2UR1/62sgfKPvzAD5tcwaSSnzN
 cyTBhDIVkZlUpeSoH7UpIiMkWGPpx2TE07H/kn0sAXlSXXoryyqy5hr5VTK1K9yudMPSOEyYXXn
 pM/E3PSLXNCgx1yNPlhQD8t2Ac8bvn5JvmSHLrdqqIUQglxFMeKgyLa/uGEBXWOEYhKuNDZGJ+w
 cG9FlsiTeEBvOBKAWJ3idvX2mv5VH7G35YINVovN2Jn+X+2u3JouS/ZDa8VWEvKSyXLTHKhMISP
 L6QIKWEnWJn4KLNP00Jno7a06n56VxVi12pKWQVoRIDrFelrzk2Z+2q6qPSfTVt0DcaRx2Wm8Y1
 KPpPLdNqtt5KdQi1bIQ==
X-Proofpoint-GUID: WyXnR-MF6jZELtG-1S_DG9-9oz3Zb0hY
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0
 spamscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140223
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
index ef486545ba..6435816534 100644
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
 
+typedef struct VhostUserMemRegMsg {
+	uint64_t padding;
+	VhostUserMemoryRegion region;
+} VhostUserMemRegMsg;
+
 typedef struct VhostUserLog {
 	uint64_t mmap_size;
 	uint64_t mmap_offset;
@@ -186,6 +194,7 @@ typedef struct __rte_packed_begin VhostUserMsg {
 		struct vhost_vring_state state;
 		struct vhost_vring_addr addr;
 		VhostUserMemory memory;
+		VhostUserMemRegMsg memreg;
 		VhostUserLog    log;
 		struct vhost_iotlb_msg iotlb;
 		VhostUserCryptoSessionParam crypto_session;
-- 
2.43.0

