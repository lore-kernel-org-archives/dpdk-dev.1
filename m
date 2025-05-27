Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB64C54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 13:02:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E2D5406B7;
	Tue, 27 May 2025 15:02:07 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id A06DA40697
 for <dev@dpdk.org>; Tue, 27 May 2025 15:02:04 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QNTsgK001051
 for <dev@dpdk.org>; Tue, 27 May 2025 06:02:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=f
 S1jmhBme3oZd7MLDml3G90IcHY5VUyCv9AdPfqlxdI=; b=QR77XZ/nE4M1Y3/Jc
 aQ0heekTyHZi362ox461Hq4+p0MncJ2o3kIlddMJ0Jciq9/DyQDUFY2oWdkWPrqW
 9aFLYUtiGwYkng9v/FGLkM6QLRCbZS/XNZdgSnfqN5DF01RbQ5taCt6PHGodHHic
 LRSMWYn+HI+oRu49SVNxj2C7/k5G3jhjsjK6IsU068qnAF6ymYILuvqWU5SI76om
 hR0ZNpeysjJbsaBgPLwNW+DjIqexyUjNvjTHUlB5ipqPWsxl7rfAY9CPjqHz3w86
 5PU1SKA8WLNMhhhanidUKBFSaDAVTctral4iJ1Gn4kCt9Vd/lRGEbFsWKCsbnknK
 rwykg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46w21299pu-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 May 2025 06:02:03 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 May 2025 06:01:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 May 2025 06:01:52 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 8B5453F705D;
 Tue, 27 May 2025 06:01:50 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Nithinsen Kaithakadan
 <nkaithakadan@marvell.com>, Rupesh Chiluka <rchiluka@marvell.com>, "Vidya
 Sagar Velumuri" <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 5/9] crypto/cnxk: add struct variable for custom metadata
Date: Tue, 27 May 2025 18:31:31 +0530
Message-ID: <20250527130135.2301726-6-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527130135.2301726-1-ktejasree@marvell.com>
References: <20250527130135.2301726-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=H6zbw/Yi c=1 sm=1 tr=0 ts=6835b7cb cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=FbTz2Mgud2xj_ohD22wA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: gqKP2STV0IzFUgB0ZnEukxHm5fCNlYVm
X-Proofpoint-ORIG-GUID: gqKP2STV0IzFUgB0ZnEukxHm5fCNlYVm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDEwNiBTYWx0ZWRfXzswcnbW7AUGY
 NpKkmMtu/8BEqDmvn/vqsGD593eqhq9OQlcl/7UxjQBKSXX+l/e6ofgwqHoQlHcxMie4j9IO2YS
 OGkE5g0e8u2J8wRl6BiQdL3rcpXAiL8f52UOTJ9zn6uwuAZlLrt0mxDwOwULfXw8JpDzvZ3dwua
 nUliTnuIUEYHYtg+j8JxvOm8caaz6Yebvk0k6/WCsBlnjvJKCa1623HQKOjNGpvAgWWZkfsXxai
 L7ozl/Jw94M6VwC+tro4kvkl5ZYgAV+o3lpjhw/XlYaZ/5mtTBdezwO5JkPVnvxYwD+Ng8/nqPQ
 dyE+v2tx+jxLBKkWneyF4HSCLmrNJKpgu3RpRZpnNHF9RJZJk8xAiiEzUNfyAAuNx0+aPY3NXja
 wCSRNso+ZDbYvL8+IdmJrpu+QDfeAsSHjzw1GIfmyVsjs6OyPWqHzAJu71hS4m4GCK7OUvh2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
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

Adding struct variable for passing custom metadata
to microcode.

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/crypto/cnxk/cnxk_cryptodev_ops.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
index df8d08b7c5..17d39aa34f 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
@@ -30,6 +30,8 @@
 /* Default command timeout in seconds */
 #define DEFAULT_COMMAND_TIMEOUT 4
 
+#define META_LEN 64
+
 #define MOD_INC(i, l) ((i) == (l - 1) ? (i) = 0 : (i)++)
 
 #define CN10K_CPT_PKTS_PER_LOOP 64
@@ -58,6 +60,7 @@ struct __rte_aligned(ROC_ALIGN) cpt_inflight_req {
 		struct rte_event_vector *vec;
 	};
 	void *mdata;
+	uint8_t meta[META_LEN];
 	uint8_t op_flags;
 #ifdef CPT_INST_DEBUG_ENABLE
 	uint8_t scatter_sz;
@@ -70,6 +73,7 @@ struct __rte_aligned(ROC_ALIGN) cpt_inflight_req {
 };
 
 PLT_STATIC_ASSERT(sizeof(struct cpt_inflight_req) == ROC_CACHE_LINE_SZ);
+PLT_STATIC_ASSERT(offsetof(struct cpt_inflight_req, meta) == 32);
 
 struct pending_queue {
 	/** Array of pending requests */
-- 
2.25.1

