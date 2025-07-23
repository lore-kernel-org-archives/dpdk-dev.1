Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF48C83F25
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 04:42:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A24FC40A81;
	Wed, 23 Jul 2025 06:41:54 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C542F40A75
 for <dev@dpdk.org>; Wed, 23 Jul 2025 06:41:52 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MNXckx026919;
 Tue, 22 Jul 2025 21:41:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=A
 EXYpB53k0d9UFYh5LPjsSnX6wpke6Gy/AtiVW77I2o=; b=APlOdt44L07CCPnph
 jx4NuWcOhYeEJVwFR6or7gggmixIzkSDwSY9zi4Qe/9cwjQMUX/L1yVS/IxHiegD
 d2hRyFJLdyj3xEeAzY6sR2nt0vQvqYm8kqkhN1CGNnijVB8RwvRSsGrC9rrv9j8A
 LGzZUJ9DsKHjvY7kfLQIn0vOrKPy0E86lEeCPp5FuLDu/n8NRovQKTfR3HXYKiRY
 l6/eUl1Rt3nanDboAs2OoWtNUVqgZyNcgd6jCQqSzxVelPCpQ5LKiOYv/ZOxFEho
 /X31USNi8wYutiC3lfeYa8BtLK8rOJNSn3Msu2Qxrc4nofK2pEG1PGFRmvBdFckU
 u9yIA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 482jy50pmf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Jul 2025 21:41:51 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 22 Jul 2025 21:41:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 22 Jul 2025 21:41:51 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id D87243F707E;
 Tue, 22 Jul 2025 21:41:47 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>, <thomas@monjalon.net>
Subject: [PATCH v9 8/8] lib/pmu: fix out-of-bound access
Date: Wed, 23 Jul 2025 06:41:18 +0200
Message-ID: <20250723044118.2962318-9-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723044118.2962318-1-tduszynski@marvell.com>
References: <20250722120041.2718227-1-tduszynski@marvell.com>
 <20250723044118.2962318-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: B1NG9PQt6syCGdw1Ky6ggmZ4Rh0xJty1
X-Authority-Analysis: v=2.4 cv=OdqYDgTY c=1 sm=1 tr=0 ts=6880680f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=rsDlWQ7q-kAZFu0dnB0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: B1NG9PQt6syCGdw1Ky6ggmZ4Rh0xJty1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDAzNyBTYWx0ZWRfX4YUg+66+6aO5
 h9RwVLzo90r5J2gHwT20sy3jHghR82gGOl8AX+j1u2xZGrMIyLNwajLTpzudlupgXNcSEv1QaUW
 Rwg/+QYO2tBeKle4KwkRQlSUw4pjSMjPBNgbytyV20jOPHCMSEFABSvZH5/pIGIUlzYMM2hs6+s
 pJOrNLFMKM4WH3gfkxNjEzl17EPdQ/mSBCd9gG1MZ/ZVW4vNYx+Vc/5zAwnoMJJlZnC/GVuOcir
 m+dxXIg5Q1vLMzwrVxKMfJ40yBSexSzStEtKacL+wca2gS/VGB1nECS5yfE8nFAgBmS5ZvW/wYg
 Ax0jQfx1vF1job78tJD49Yx01OE3IrRC5QJoBnQDy0tWure8PTH/j7xgJMOGiIYBP5WJietLh/B
 x1XnmYW6BrpkOfhOi0hGL9otOTw2VtR1Sozqt0VpZ3jXfzQ+hlL/dRjYqt44Iagc5pr+Lxae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
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
index 5f78f3c088..d83818c3b2 100644
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

