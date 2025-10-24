Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6F4CCD1AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 05:49:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 539F240661;
	Fri, 24 Oct 2025 07:49:26 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1151B4065A
 for <dev@dpdk.org>; Fri, 24 Oct 2025 07:49:23 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3Cr48027234;
 Thu, 23 Oct 2025 22:49:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=m
 fwEi04863q4LgF63EjjDOs8IMAGRT2SZazX/BK0GsQ=; b=EG7K7ZG8Mh7QVnVTa
 nxiamO3ZtQRBRztIAF7bdtaWTBZjomjpqPWKpch5Xelv6hSq2WZeIuaZVjs9mRnV
 nmcN6D96wR6W8zpNOMdSNUqcBEykS92ar8SmIziBdaCXaKPgdfoQx66ukoxbyeei
 thmhSrlOmo6UZjQDeK67DHEEMyec5nBqZ97nSGaT1sOb+vNlFjCW/T3j10k+GoDP
 54gwiXo/RZ2+ggtHyHP3C7hIMhaaZ5o5r680TRuc4vk9syyMe/w9L+B/nosh5PiH
 VGzM7yahQkwSC41M8vOBP5OPS4tYi8rL0uk8VA1X7nVCv27ZkvyBkQLTl2WPQR08
 n+40A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49yx9prh90-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 22:49:21 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 22:49:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 22:49:18 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 444BF3F70E0;
 Thu, 23 Oct 2025 22:49:16 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: Tomasz Duszynski <tduszynski@marvell.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
CC: <dev@dpdk.org>, <Ruifeng.Wang@arm.com>, <bruce.richardson@intel.com>,
 <david.marchand@redhat.com>, <jerinj@marvell.com>,
 <konstantin.v.ananyev@yandex.ru>, <mattias.ronnblom@ericsson.com>,
 <mb@smartsharesystems.com>, <roretzla@linux.microsoft.com>,
 <stephen@networkplumber.org>, <thomas@monjalon.net>, <zhoumin@loongson.cn>
Subject: [PATCH v11 9/9] lib/pmu: fix out-of-bound access
Date: Fri, 24 Oct 2025 07:48:30 +0200
Message-ID: <20251024054830.933910-10-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024054830.933910-1-tduszynski@marvell.com>
References: <20250801102109.3544901-1-tduszynski@marvell.com>
 <20251024054830.933910-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rTBX0QU-rS6ZlZLJhXYesAtAKcFGzRgD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDIxNyBTYWx0ZWRfX2N+WcbOZwnTv
 Su3FfYksG0JJvqpY+as84WQOOZ8xPNMFEf5wyz4YLh0WDj/0XFT7oJewnucxjChE62X5jzG0DCH
 PCWTSRViXJxOqJqm2u5tk7ieuTKVQBdg1yoRbQpLGf0ZzaEKo6Wk83oj5AomsooPeqFxNqkLqh8
 PDj3h9hlOHSUQ8oh/m7nMs/BM/yMkfLtTzdKRjQssN1PnsaGZxzksKR9HjLqps3xfU7pxQ5EEht
 VtnXxLvTtjXgpuyk2Ed6mMZ568isNtKtdz0sd6K1kcRvo7MhcitvGwFbgtpLEAT4eQKzG3gFxTc
 E2YwaEWS2uh0JQncrUS8Wbrxw/oMMPvKO2Zi5hykAJkHk+fBKVFq2HiclDMVQ3+AjASId9T68wL
 TeNjquZblm76bYrYxkxIgxfZahJ7aw==
X-Proofpoint-GUID: rTBX0QU-rS6ZlZLJhXYesAtAKcFGzRgD
X-Authority-Analysis: v=2.4 cv=Wvom8Nfv c=1 sm=1 tr=0 ts=68fb1361 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=rsDlWQ7q-kAZFu0dnB0A:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
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

Make sure that out-of-bound access does not happen by saving one byte in
buffer for NUL terminator.

Fixes: a8926a65ad1d ("pmu: support Arm")
Fixes: 960c43184c4d ("pmu: introduce library for reading PMU events")
Cc: tduszynski@marvell.com

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
 lib/pmu/pmu.c       | 2 +-
 lib/pmu/pmu_arm64.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/pmu/pmu.c b/lib/pmu/pmu.c
index 4bce48c359..c14128addd 100644
--- a/lib/pmu/pmu.c
+++ b/lib/pmu/pmu.c
@@ -126,7 +126,7 @@ get_event_config(const char *name, uint64_t config[3])
 	if (fp == NULL)
 		return -errno;
 
-	ret = fread(buf, 1, sizeof(buf), fp);
+	ret = fread(buf, 1, sizeof(buf) - 1, fp);
 	if (ret == 0) {
 		fclose(fp);
 
diff --git a/lib/pmu/pmu_arm64.c b/lib/pmu/pmu_arm64.c
index 2c40b5f702..f3a817b42f 100644
--- a/lib/pmu/pmu_arm64.c
+++ b/lib/pmu/pmu_arm64.c
@@ -24,12 +24,13 @@ read_attr_int(const char *path, int *val)
 	if (fd == -1)
 		return -errno;
 
-	ret = read(fd, buf, sizeof(buf));
+	ret = read(fd, buf, sizeof(buf) - 1);
 	if (ret == -1) {
 		close(fd);
 
 		return -errno;
 	}
+	buf[ret] = '\0';
 
 	*val = strtol(buf, NULL, 10);
 	close(fd);
-- 
2.34.1

