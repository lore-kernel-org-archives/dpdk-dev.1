Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597EFEDB7CA
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 07:42:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75C8F402D3;
	Tue,  7 Apr 2026 09:42:09 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 0FD3A4025A
 for <dev@dpdk.org>; Tue,  7 Apr 2026 09:42:07 +0200 (CEST)
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6377caun747860 for <dev@dpdk.org>; Tue, 7 Apr 2026 03:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=l
 x97InSopN/O1v2aDYcNgouB0arsBEJkleC9dU+DKrc=; b=MWubgocWIm+v5acrk
 Ot7UgipLk/m8nJ/051Y/heRh7cl1AKY9SFX4HOf/2ksSgRaYxiJGnCwagJxvVve3
 s2Y+1IJCkqqn5/H6tjy4VB2a92n7zC8QYn3VVIRITEB8MZ4AUqOmqR8uwNcYnSZr
 TcZmjhWKiwxfQFicbSq/amOUy9A5ve7ZbYpyjxv2Cx+vDZR4NVjveE+Jj6ew793y
 8JdxnkOC8vPzidMrzmmnEg4f9VVDKgeQba5xUgPoC+2TYuLY8ZVSCGRej9+JTrCO
 q/3yF5POXjzP9oG7Iv6e+szkluuyE1MkMJGFd+NpFZUZ5lT1aagMRH3QthwD2SnU
 ChIiw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4dcmrmtbc4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 07 Apr 2026 03:42:06 -0400 (EDT)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6377amv91927930 for <dev@dpdk.org>; Tue, 7 Apr 2026 03:42:05 -0400
Received: from esapsmtpat06.us.dell.com (esapsmtpat06.us.dell.com
 [143.166.211.145])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4dctryjeq3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 07 Apr 2026 03:42:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1775547726; x=1807083726;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lx97InSopN/O1v2aDYcNgouB0arsBEJkleC9dU+DKrc=;
 b=WdBeL0pylqn77cyICFEY0sS9qvNXgRCspYkTCZL6G9ATFhyEYaH8gcV4
 6Ek/CJ8P8/CXRmq0EllI8C3ZLYfuew0l6MMRW5CltqINne6L6SRfMqAbn
 BY6+0H3LHc+ZC0KlT16gLFRF2EIAYyWhrELLjyZfKf1TNPSC5Bo7vwwEY
 mzxPiEjX0P4j4qbaWSb/QmpI4kSvW+TqyxoGbq7nBCGw/TlAPRkJoNjVZ
 Y1kCwO+O0OFSKjezkS6ZpgiqQQNYFGd0XCnz5H92SN1wml/ipQ1vyFX2E
 h7LA8bD6ZOQZAYbJSBXqd1ztRhmgRwMK7PeaUgqtz+RTrHoVI+cvS8Ey0 A==;
X-CSE-ConnectionGUID: SVZG22/PSUKDcAlLpBj2JQ==
X-CSE-MsgGUID: piNL1qxaQI6U0ctTpbaO8w==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtpat06.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 07:42:05 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 02:42:57 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 02:42:03 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 7 Apr 2026 02:42:03 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH v9 2/5] vhost_user: header defines for add/rem mem region
Date: Tue, 7 Apr 2026 07:42:20 +0000
Message-ID: <20260407074223.3876085-3-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407074223.3876085-1-pravin.bathija@dell.com>
References: <20260407074223.3876085-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070068
X-Proofpoint-GUID: LajlRMZ9dmdGxmd_vnDjHfeQNRC9Wczy
X-Proofpoint-ORIG-GUID: LajlRMZ9dmdGxmd_vnDjHfeQNRC9Wczy
X-Authority-Analysis: v=2.4 cv=PJw/P/qC c=1 sm=1 tr=0 ts=69d4b54e cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=5Q2474zp7XKCQhFpYb/iUQ==:17
 a=A5OVakUREuEA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=vUAfKriDyi6VqHAKCLgX:22 a=iLNU1ar6AAAA:8
 a=CCbkoWxl33X5vWekUEUA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA2OSBTYWx0ZWRfX1WW2n7RFCZGw
 7uAhTkF45YiItaIeyEK03pvE9nqbCgh2wredEiPMRZYYDaxenqsxo6hRq/Cx76h/cqRckR9vZkH
 uJZVY3Ato0AVW++0z500GortRw+s+qcx+VENM3TQFvXDWCsomnVJug7VPq1N4wWDtS38j4tVFm5
 qy/enRt5ka5ftnpsJywLQILPp42Pv4wMu1604EfiSYM6HQRSJfldTMO+WkiBLQbBe0AcfA2XXch
 xCyjc/PSocNThzDJQE27OkQeuGVK9oUjlitYiuvJo1fyR6SQuRqSV4sGJB0dBkkZDz939d18qsJ
 q4lStNnWhybqJGSomP/a4TLhG4xzy/cwc5oGSJE2MZouIIoWnXMvtJHdWlbmE/paUp8LhVwJ+QD
 CohGiJBMBveICs1DcnPgzWbp8ymPaxhGyVWJfLnY3hB/YqsnCx6aQVcn+MDFRjOOl0P9vFafYNO
 M6ViZLNbcB6nDs9wDtg==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070069
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

