Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D366C87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 Aug 2025 10:22:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDD7940698;
	Fri,  1 Aug 2025 12:21:55 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 12F0740A4B
 for <dev@dpdk.org>; Fri,  1 Aug 2025 12:21:53 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5716VKPM004073;
 Fri, 1 Aug 2025 03:21:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=/
 4FwyihJoBmjcWxWxFVtyRI49aM/fC90jOlvWUDi29U=; b=aZZPUSr1AXo9+cl5c
 p3zKvyOao0z8pLaeAMtx/uc1Qm/59BcSoLYtXGSynBoZjfrLkOc6KT1f3nk4BV7b
 NpW35eif/CY7OORQgjO4tbUIaIc0UFaJMXrDwlDYRX6Ulb9dJGLfKuNP+r+xJPBU
 bcaY/4+xcggDf8T5n5MACMX1+xU+vznWvuFB+6h1Co3xsKYmdYH0djUmRXHpnyGy
 UQSJi1rNDg2sUMglcq2nEA2cWTQaVmzWrVKOfnrVstgy3yahEgBPBnPJ9Gg2Q6JV
 yEJOpP6fMCljbF+UvWKxJ1xSuhz2VRxaQqZNN+Zf0M510HHdVI8fFuVTi+lSiqGj
 Tny1A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 488rcngck9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Aug 2025 03:21:50 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 1 Aug 2025 03:21:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 1 Aug 2025 03:21:50 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id D0ACC3F7079;
 Fri,  1 Aug 2025 03:21:45 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>,
 <thomas@monjalon.net>, <stephen@networkplumber.org>
Subject: [PATCH v10 10/10] lib/pmu: fix out-of-bound access
Date: Fri, 1 Aug 2025 12:21:09 +0200
Message-ID: <20250801102109.3544901-11-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250801102109.3544901-1-tduszynski@marvell.com>
References: <20250723044118.2962318-1-tduszynski@marvell.com>
 <20250801102109.3544901-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: yrj1qbtLK7ci7XvKqy0LkuAJ57Bysru0
X-Proofpoint-ORIG-GUID: yrj1qbtLK7ci7XvKqy0LkuAJ57Bysru0
X-Authority-Analysis: v=2.4 cv=WosrMcfv c=1 sm=1 tr=0 ts=688c953e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=rsDlWQ7q-kAZFu0dnB0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA3NiBTYWx0ZWRfXzXu1NEkd/Yu3
 N7LEav6dN1L9vo8RrAguwCRtcW02DL/BW8b6uE5PDhTlE26tWPKSh9G9tCE/N+2AIaw+0bSPXJV
 78sK13S85mU6/E4AB3LdJp5CQ7fddDMWvGNUW0icr0JNQheSMonTme3STvwjyh02caGira6yAc1
 G2PSV3iXMKFZypI3Z8vTtv9JgjDgComkkgwXsWarOtb9wW66fOxsJfCmrzB8K/AmeST8GErNvFF
 EQQiczlObadjQc/2i0KyDTi/sEtHqDT81RGmFZDYaUbHAiK5CK6Tj1Umebh+8DzKsTBbbz4P4wg
 6TWS1whzNKjr4o1MKtXTpxS8m76cupuq0AtVDvuePsUEAYItHEwgbb/IvXyb3N5JHxCsp52agOZ
 At+BccolFniPOXQkLAa1c2t44xi2LJirc5HZHyOsv9JKym9FDWrsMimoCpZykZ4+IvrI4pTR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
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
index 89ae69ce1b..30f43f72bd 100644
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

