Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FB5CCD1AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 05:48:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C035E402D3;
	Fri, 24 Oct 2025 07:48:51 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id EE064402D2
 for <dev@dpdk.org>; Fri, 24 Oct 2025 07:48:49 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3D2Rh027349;
 Thu, 23 Oct 2025 22:48:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=5
 0brCj+l/gjNzeC15cZNjAOM6wTNM8pGoalrVuInMe8=; b=S1pqQl3PWWVbh3wDG
 PEeAV9bQFCMEgqhzA7wyNOZ/NGHisQVTJcEjj2BneRUjiQK8AxiC7DOlARXt6INU
 N2oDwzFMJM56kd0fhal4UDw48sBNiZEd1EDFBlsxna3I6TUFju0+ZLlUbGKSw7N0
 QLabkpVtLfzSSlrqkKpmhGjJVBY3IMTuN9FUrAf4koR71ikAsKyBRhePuDfoAyD+
 ElSmn7HcwvKO3zA4jstKvtyW7lEWPN6cYYqOudLJFKgZsg3Z5t+dO4ZqlPdV3PWe
 2bQDR1hLWxAPGq0VUhg9Xxs9pTgkMiTIpdhlFw1GSxvzJYDrv+N0FZ3cbKlyI6VR
 EGyTA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49yx9prh7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 22:48:47 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 22:48:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 22:48:44 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 148973F7071;
 Thu, 23 Oct 2025 22:48:41 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
CC: <dev@dpdk.org>, <Ruifeng.Wang@arm.com>, <bruce.richardson@intel.com>,
 <david.marchand@redhat.com>, <konstantin.v.ananyev@yandex.ru>,
 <mattias.ronnblom@ericsson.com>, <mb@smartsharesystems.com>,
 <stephen@networkplumber.org>, <thomas@monjalon.net>,
 <zhoumin@loongson.cn>, <wathsala.vithanage@arm.com>,
 Tomasz Duszynski <tduszynski@marvell.com>
Subject: [PATCH v11 2/9] trace: change scope of conditional block
Date: Fri, 24 Oct 2025 07:48:23 +0200
Message-ID: <20251024054830.933910-3-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024054830.933910-1-tduszynski@marvell.com>
References: <20250801102109.3544901-1-tduszynski@marvell.com>
 <20251024054830.933910-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5xX_ysVvptXgLbiIspWxETi7gwQYWzS6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDIxNyBTYWx0ZWRfX7OKCEGfiqzKJ
 g+K9+S8+U0liwGqdKrjx2NAk4w+rKUkq1QVYYf4TqICS9W0NVb+lnMRXL6/csK/U4+bReAQhs7+
 ZgTSKZiBvDvnzXg99ebRicmTGnwaDjOp8Ar/SDtv3dBhHwJfh0Jhi6gESoWV1WdwfVZb9985JZt
 7rMbn2RleYOFJJMTzs1chctw87r0nLnKmrBnies+ZiSztzV3Av1N1BqN01qm4ekQ2xOJ68ob/SP
 zbHT3Szvdsed1rm+jPVe6kb9iVC6Y7bhyijcgVs0GjOzX7ArWuigtRSc2atuaQ9+KLSi9CWExQ4
 wNZ0BBNF/URScoNOE2ezRFAHLdJ94Bb+Oz3U3cJKB8n0gMPe4NWepH/QfTNvno7KQr0dDYHMe+T
 GX6RmpQXp4s+JA4gOPK1BPBJxZCsWg==
X-Proofpoint-GUID: 5xX_ysVvptXgLbiIspWxETi7gwQYWzS6
X-Authority-Analysis: v=2.4 cv=Wvom8Nfv c=1 sm=1 tr=0 ts=68fb133f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=mkB43dQOfHrW3UneyFcA:9 a=zZCYzV9kfG8A:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
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

If ALLOW_EXPERIMENTAL_API isn't defined warnings should show up but
build itself should not fail (unless -Dwerror=true).

In order to avoid build failures change the scope of conditional block.

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
 lib/eal/include/rte_trace_point.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/eal/include/rte_trace_point.h b/lib/eal/include/rte_trace_point.h
index c0ebf1ce13..394b2619c5 100644
--- a/lib/eal/include/rte_trace_point.h
+++ b/lib/eal/include/rte_trace_point.h
@@ -289,7 +289,6 @@ int __rte_trace_point_register(rte_trace_point_t *trace, const char *name,
 #ifndef __DOXYGEN__
 
 #ifndef _RTE_TRACE_POINT_REGISTER_H_
-#ifdef ALLOW_EXPERIMENTAL_API
 
 #define __RTE_TRACE_EVENT_HEADER_ID_SHIFT (48)
 
@@ -314,6 +313,8 @@ struct __rte_trace_header {
 	uint8_t mem[];
 };
 
+#ifdef ALLOW_EXPERIMENTAL_API
+
 RTE_DECLARE_PER_LCORE(void *, trace_mem);
 
 static __rte_always_inline void *
-- 
2.34.1

