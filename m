Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D31C9EC7C
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 12:23:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89ED940DD2;
	Mon, 12 Jan 2026 13:23:17 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 457FF40DCA
 for <dev@dpdk.org>; Mon, 12 Jan 2026 13:23:16 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60BN092j1080570 for <dev@dpdk.org>; Mon, 12 Jan 2026 04:23:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=4
 C8SPhcLjhzLRbHuZfUcXk7dY+i6RRMJwE+ngbNmEio=; b=Sn4A+yUr8jjdCRX6o
 UTjEsN0PLCzYV+AjtULnad7ESlsGARdStJY8ROBfs6vasT6sOAWYK35rOwx8viZU
 O/Lq2c7L8XkdVTP0h580gM18ib5fG/uE3LPzNVNX5tCgz5yy98gjXhzoTWtX7JhV
 yUMfoIA+MuMPZlKRD1VzggJFG4LcNOyZt6Xb3TlM5r5WD0TSIZON2qJO7Xcii+OL
 dhzIkHcZh6fnzQjf/bJCmWvkbyhSQQaeU/6L1gfgYINOtpgibK9l/4o58bka05lx
 aXsOhNQxvqlWks+JwQAhN/QNFyb23O0j81xZUC9U/kUURmQqAbTP9Izl0qgq7Dnz
 sw9ew==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bmn5d1dmf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 12 Jan 2026 04:23:15 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 12 Jan 2026 04:23:14 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 12 Jan 2026 04:23:14 -0800
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 8411E3F70A1;
 Mon, 12 Jan 2026 04:23:12 -0800 (PST)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 1/2] common/cnxk: set CPT cache line size per platform
Date: Mon, 12 Jan 2026 17:53:08 +0530
Message-ID: <20260112122309.2448535-2-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260112122309.2448535-1-ktejasree@marvell.com>
References: <20260112122309.2448535-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: jary6f0ECsDzMFUBa1b-c8jNkKGcxe64
X-Proofpoint-ORIG-GUID: jary6f0ECsDzMFUBa1b-c8jNkKGcxe64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA5OSBTYWx0ZWRfXzhNpbVHadLb2
 rBAsFLbYY0TvxPkvsB4BeZFOAS60ZVxPnI/vvgMTTsQLMqLPHwhqVnEVzY1FI9NV+E84Ul9kttC
 YHeMyLVrxLDBYFsjyOocHV9lyeNyHWN6h4npsnVh89cJ/XD91rBq1hUgTugsKSCpCxLD+ibLyN5
 /NVEl2DtK6xthPz9WC5nIxoc8O0+oN8msZxXmFC8YuV01E4mYXQjfsIUGv1GlTiM54H5DdEnXGh
 vUg9bIqxUi1YEZ9uk46uXVT0CIqTt4iOPLc92aGADd+YEIwywSW2lx/II7qKEzOHRwNaBKSrqGi
 0FistDa1psabNU37g8mJpadwqpKnFQXgeJscfiibMq8VatCw/l9N0koctDwNqa+/6Z8TRH2uHEH
 c9EUqNrJLyPg0yad2EE2mAZuCxWIdLCgeAB3npOzgO+AZllUYEI0Akkal8PHO/YwhV76APvdfj7
 ggrViJeYGj6ZjXf8ZEA==
X-Authority-Analysis: v=2.4 cv=Sq6dKfO0 c=1 sm=1 tr=0 ts=6964e7b3 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=ULKiNwEkmEE98wEICwQA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
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

From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>

Added conditional definition for cache line size:
 - For CN10K and CN9k platform, set cache line size to 128 bytes.
 - For others, default to 256 bytes.

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
 drivers/common/cnxk/roc_cpt.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/common/cnxk/roc_cpt.h b/drivers/common/cnxk/roc_cpt.h
index 67956758be..37873820e2 100644
--- a/drivers/common/cnxk/roc_cpt.h
+++ b/drivers/common/cnxk/roc_cpt.h
@@ -130,7 +130,12 @@
 	 BITS_PER_LONG_LONG)
 
 /* ROC CPTR Cache */
+#if defined(ROC_PLATFORM_CN10K) || defined(ROC_PLATFORM_CN9K)
+#define ROC_CPTR_CACHE_LINE_SZ 128
+#else
 #define ROC_CPTR_CACHE_LINE_SZ 256
+#endif
+
 #define ROC_CPTR_ALIGN	       ROC_CPTR_CACHE_LINE_SZ
 
 #define ROC_CPT_CQ_ENTRY_SIZE_UNIT 32
-- 
2.25.1

