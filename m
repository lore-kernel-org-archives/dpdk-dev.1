Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2471EB2700
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 10:26:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05A8D40608;
	Wed, 11 Feb 2026 11:26:24 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 44448402B5
 for <dev@dpdk.org>; Wed, 11 Feb 2026 11:26:22 +0100 (CET)
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61B72orq2414291 for <dev@dpdk.org>; Wed, 11 Feb 2026 05:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=l
 x97InSopN/O1v2aDYcNgouB0arsBEJkleC9dU+DKrc=; b=XIW8boItfwuruzx51
 1PImuyziR1r/X91PlKUrPz5N0euJWZDE4flx37cbUoPA4HwcywDM4dYxVovb71DO
 7QRUbHgZVyVOwzE/kbVnVeJe6aDuMgyqkZ2GieRqDRR3tdp3NxmUyAeV2lXZpkDR
 J8kfQMotdqZk9IMZvDMbQW/3vAySXRBCc/Fm0cOO8H+GZAh2Gp97+atAWHxOP41R
 1kunrwOS3wW2jxuuEtpcr0u46zR0a3NApxTHnFfu5rw9zX5kH0mXFxTYY/Xj+z65
 tgWsKFcz6umpaVcU0irWPcyPSN7ecHt6UpIXazMHm1nUIRbUwtf0fZlMyeHaOnbZ
 TsaQA==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4c61ea0g1g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 11 Feb 2026 05:26:21 -0500 (EST)
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61B9842e1475359 for <dev@dpdk.org>; Wed, 11 Feb 2026 05:26:20 -0500
Received: from esapsmtplv09.us.dell.com (esapsmtplv09.us.dell.com
 [143.166.203.151])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4c8ny4seku-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Wed, 11 Feb 2026 05:26:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1770805581; x=1802341581;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lx97InSopN/O1v2aDYcNgouB0arsBEJkleC9dU+DKrc=;
 b=DQ/rJVXuVWTzLgY4l8yvycVadm3vcQ5ACPnSFnbTbOABznivL++UCqqy
 Tz4eENlEWT7OT/mVlxXim7435eq/SDamZJf5xbIy28+S2njNwWeAy134d
 PCLHzHq695uJerOn8ehZB5TgK1FTvFoZRD4g5GKsh1If6+q9Vr6Z87YtH
 0Ttl/qvwyR11LV9xcTctdf/xHGJWAZ2OJhBYK6XMySxQqVLWeU25TDHmW
 yFrhvYIK7V0aoeV2NcXjAzsuoP4tQpgIaXduftkGo5X8MX4nDBZkSR783
 RTdxJHOhaBdJzGgoLmS8TYHuV+YrJECHf+DpqbIPD6NefiIWu4UcbOvBt w==;
X-CSE-ConnectionGUID: fgD27QsBRUmgX5HjqoB9jA==
X-CSE-MsgGUID: uojBml3STFeKVv/Lg+q3+Q==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:24:15 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 11 Feb 2026 04:25:12 -0600
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 11 Feb 2026 04:24:13 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Wed, 11 Feb 2026 04:24:12 -0600
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <maxime.coquelin@redhat.com>,
 <fengchengwen@huawei.com>
Subject: [PATCH v7 2/5] vhost_user: header defines for add/rem mem region
Date: Wed, 11 Feb 2026 10:24:30 +0000
Message-ID: <20260211102433.694516-3-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260211102433.694516-1-pravin.bathija@dell.com>
References: <20260211102433.694516-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110085
X-Proofpoint-ORIG-GUID: BjNEinmZTlZx-3qs7fW25DDPeUx8JLzG
X-Proofpoint-GUID: BjNEinmZTlZx-3qs7fW25DDPeUx8JLzG
X-Authority-Analysis: v=2.4 cv=P9M3RyAu c=1 sm=1 tr=0 ts=698c594d cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=1BWgYg405ukQaXe9BCXDPw==:17
 a=HzLeVaNsDn8A:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=iLNU1ar6AAAA:8
 a=CCbkoWxl33X5vWekUEUA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA4NSBTYWx0ZWRfX4Ub3X0yEZqJt
 Cyj//n+zzZG4hVoPdDF8X7vjNc5JUE5uiDtN+u1pyYigOhRVO6XEt2nS9R4AIYaB7BaZ0odyNEx
 jD9zcQFoRGGahEo8O2Pe49t8M0Xnx9W1xT1M+wclxHkLIljo1rvaV/O+SZAMP+eh1j21XB+kyC7
 9OD5KFPEb+LCbqrzVCSvxBvTsPl2oik0wDyvXHiRJ5rbc1tlCzoGtgl9eJlgagHWdXNrnbfYFi0
 CPeWUshgz7Cie4JZe4wDvB7GdDjEkPEoNJ2uFsSHY7Br13M227ZkehEoXKvUhL9v8gY6Fdm8pyW
 UqdH1HjLjHSScxchTT0tXkmU+YA7zK5980CaV2tfKlBzwosLRZOQA/bgPHBs6NzjcrNdbhbPrys
 D6ThQNN1ISvHEbI2bC4nHoZ41/H5UTb/SGiDh7lMlhRgP+YUT2OhrGof3VaFp+ddOInvvVWe+Er
 CXJxV2haUycJ/2B91lg==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 impostorscore=0 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110085
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

