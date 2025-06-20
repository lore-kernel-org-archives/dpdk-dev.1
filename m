Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9C6C71155
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 12:06:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69FD542F17;
	Fri, 20 Jun 2025 14:06:23 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 4521542F15
 for <dev@dpdk.org>; Fri, 20 Jun 2025 14:06:21 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K3TjcV015666;
 Fri, 20 Jun 2025 05:06:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=G
 ZCgELMVQvpV89C9kXVTY4inUDnR4QQ1Yo0fzpdXONQ=; b=iql5xbUYeFCz9OhDZ
 tOEhUauiy0TtEciigUoq/bLj+WMJrCh47P//bEb/01n5qeH3ajcqOkxBS39lMGRU
 PM3FMo72cN2W8ULdxBX4i8JBQ4DHjASHCS4ocsTByhcfqfvFTgbYiyMal692hzVH
 04jK+tKbChf/3IiHFsLuFge+QN1chLEoybdGBLmKT2llpC2TpqoDUfUdM6Thkbg0
 RDz43o9QAZcj9RZ7T7mIBmMOtbyZ+B4QpHKDseEifdteSwKA/lWue7G67YOSgh57
 M99i3BM0TgLqvxW/bPfD4ah/aHhAYjIQAuE6p6/R7edZWKY+t88Yv7n62jrI0eSK
 9BOQg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47cyshgvbp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Jun 2025 05:06:20 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 20 Jun 2025 05:06:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 20 Jun 2025 05:06:19 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id C43795B6930;
 Fri, 20 Jun 2025 05:06:16 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v3 7/7] lib/pmu: fix out-of-bound access
Date: Fri, 20 Jun 2025 14:05:51 +0200
Message-ID: <20250620120551.613148-8-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620120551.613148-1-tduszynski@marvell.com>
References: <20250618065618.4045910-1-tduszynski@marvell.com>
 <20250620120551.613148-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=TuzmhCXh c=1 sm=1 tr=0 ts=68554ebc cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=rsDlWQ7q-kAZFu0dnB0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA4NiBTYWx0ZWRfXzBMWXKoWFeNJ
 108E6PgxF1F5btGK8rMJoeCmuSIHfrIO2fXQ+AstQ0AYkVnVYvEZOoGm6Ojg9jipB1sFSn7ecOP
 jK04O9CUSP/ZX9TVjis11P6/YgPtxJ1UmpNG7PRHFt9P+Qu4WDF6YcyxMcphkYcpt1UjOfDT+k0
 nkV8rRCjrSs5D0eGLbJ+pK0/XycDcVVYM7B9KLIUliPnxTYTV0Rm+TGGe4CcKzADWkafXsTpsHE
 CvNqaFx8i+3xHRtC49JQOPYWdrbsbReGlbs38o6qqalZAjzZt/0I5Asj3Re/EAr+DatpxZ7wnvx
 FiPNistwTF+gRvWpEAjqNlGg5egb0W+2cFCK1EmGYhSohI5+JQU12r/iYfoblZY47zTZ1EP/EL6
 DrjvwLhL8pXH5pjTp4WZoLjrp1lbO5KRuiIIxmNphWEd/t1hyJMwyo/CaKchDB1ViObpzSJX
X-Proofpoint-ORIG-GUID: 5s-NRrvx5z6QCTlP4_R25l9unzvm3g3f
X-Proofpoint-GUID: 5s-NRrvx5z6QCTlP4_R25l9unzvm3g3f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_05,2025-06-18_03,2025-03-28_01
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
index d4ce234491..686cc24e83 100644
--- a/lib/pmu/pmu.c
+++ b/lib/pmu/pmu.c
@@ -130,7 +130,7 @@ get_event_config(const char *name, uint64_t config[3])
 	if (fp == NULL)
 		return -errno;
 
-	ret = fread(buf, 1, sizeof(buf), fp);
+	ret = fread(buf, 1, sizeof(buf) - 1, fp);
 	if (ret == 0) {
 		fclose(fp);
 
diff --git a/lib/pmu/pmu_arm64.c b/lib/pmu/pmu_arm64.c
index 3f4f5fa297..c211d5495b 100644
--- a/lib/pmu/pmu_arm64.c
+++ b/lib/pmu/pmu_arm64.c
@@ -26,12 +26,13 @@ read_attr_int(const char *path, int *val)
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

