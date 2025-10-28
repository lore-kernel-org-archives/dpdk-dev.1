Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD63CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 17:23:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7440340262;
	Tue, 28 Oct 2025 18:23:49 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D526B4021E;
 Tue, 28 Oct 2025 18:23:47 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59SDrTjO1293438; Tue, 28 Oct 2025 10:23:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=u
 mFlUyshvfOCN8xZEnFN79/VuqaAVfGk2JUvth9Kn+c=; b=ObQGfIrz8riX3olNd
 D3liTTvCWp/j551zJ1f6rDs9gwrmf0yO5LCKb6g/YCd9Dd8sfK0qJA5wTqhEJeET
 C6fPOl9TqQM+PddM0sk7tJ/4+voOVBgByKVltzoHcOC2mwyHMScz5ZgUFB+mysXP
 BR3YN5A0m9JZMHFsQsmcKd3+cS4Lq9WyQZRut4CEF0lifX8mvMwFwAULp5t/w8Q4
 NieQKkY7UdX1SGp/sNyRFOyx7OD4dJB72cypdjDR+4V/RgU8War2XmN9LBd2wqrv
 vP7wD+0tqci4vB02ISHMBgosFFMhLJ1J21v2IkhS2pMK0femDhj7egv1wKETADql
 MxAzA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a2s5ktee8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 10:23:41 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 28 Oct 2025 10:23:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 28 Oct 2025 10:23:40 -0700
Received: from jerin-lab.marvell.com (jerin-lab.marvell.com [10.28.34.14])
 by maili.marvell.com (Postfix) with ESMTP id 28B8F5B6930;
 Tue, 28 Oct 2025 10:23:37 -0700 (PDT)
From: <jerinj@marvell.com>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Yiding Zhou
 <yidingx.zhou@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <bruce.richardson@intel.com>,
 <david.marchand@redhat.com>, Jerin Jacob <jerinj@marvell.com>,
 <stable@dpdk.org>
Subject: [dpdk-dev] [PATCH v1 2/3] net/iavf: fix issues with clang 21.1.4
Date: Tue, 28 Oct 2025 22:53:22 +0530
Message-ID: <20251028172324.3149379-2-jerinj@marvell.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251028172324.3149379-1-jerinj@marvell.com>
References: <20251028172324.3149379-1-jerinj@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE0NyBTYWx0ZWRfXzbbfBY/hSq5m
 vddJVdloOVf77YRoENLSgHAIkOqTRZKv/fSuyo2Y5R1fn3AyobT+7yb3S4I0Ww0e3WG0fCWYSOY
 DmVSIkLy3NewjmvZk+jI6x3J1TUKHfgxC/7uW/2W9OnAH1t5ZxjJlL8fAi0MrAC9IHNapZS+zQm
 LW40iN3ZGDeZIZ7uSwcGBkiwJ6UHGVCRWUeVY5MZf6gxwPcY8s1U/rVUMqjFRdyrY15Vo/YOv1r
 LgbaIeINdDHofMnH022Iepp0KI8AH6Kib0dHm2CyS7pAklHqZKO/siwCV6Zfg6/MTHWJoGpvK1y
 ePWyCKWraZSEwiK++eM0VlqLKix2SRBri4rTmT+2A6T9gPyp4wbXe3mvXHBvcGmet6LseWoWaAr
 LfJqlVabdvZVvIqKgIzD9qLg7p2Acw==
X-Proofpoint-ORIG-GUID: XbrqApMZ94G8rfifjf8ETIomnxOLVyoe
X-Authority-Analysis: v=2.4 cv=BuKQAIX5 c=1 sm=1 tr=0 ts=6900fc1d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=R18w0tCIQCz98NZomTsA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: XbrqApMZ94G8rfifjf8ETIomnxOLVyoe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
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

From: Jerin Jacob <jerinj@marvell.com>

Fix the following error seen with clang 21.1.4

drivers/net/intel/iavf/iavf_vchnl.c:123:38: error: variable
'notify_byte' is uninitialized when passed as a const pointer
argument here [-Werror,-Wuninitialized-const-pointer]

Fixes: cb5c1b91f76f ("net/iavf: add thread for event callbacks")
Cc: stable@dpdk.org

Signed-off-by: Jerin Jacob <jerinj@marvell.com>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 460035d772..9ad39300c6 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -102,7 +102,7 @@ iavf_dev_event_post(struct rte_eth_dev *dev,
 		void *param, size_t param_alloc_size)
 {
 	struct iavf_event_handler *handler = &event_handler;
-	char notify_byte;
+	char notify_byte = 0;
 	struct iavf_event_element *elem = rte_malloc(NULL, sizeof(*elem) + param_alloc_size, 0);
 	if (!elem)
 		return;
-- 
2.51.2

