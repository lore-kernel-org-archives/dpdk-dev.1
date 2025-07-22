Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662C0C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 12:01:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C95B40685;
	Tue, 22 Jul 2025 14:01:12 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 746004067D
 for <dev@dpdk.org>; Tue, 22 Jul 2025 14:01:11 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M72629010873;
 Tue, 22 Jul 2025 05:01:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
 0OKrcg7d1Ljahf089tMgNuat3ruvBtaiRh7alnR/Xs=; b=NA+HoFFtzc/x39e+j
 jEvZZdL/3X3WlTDBgpZgTdjeOkebGGu4UDPrb2LC2H78p69VLrfzRO9DggW9PWr0
 I18A0Hu0cCNioDTDz7gce/ZQWq6cbuLoJkKYyA5J4QrbHrg1nloKe7+CjBb3OxgM
 jMSr0IcPM5TVIy87rUj1VznHWOfzceTUs0qMkFpCgmNP5izLZO986ekySnPQ6eeW
 33XqIMvLTPZs8/IfdkmHmGaekDtFUMfsKXifg7EIScZFBAeT1WXKqsfyn3/3VqmD
 i7SH57Q0bNCqiwdKgmS/FQoMiEFSuOoj7NqicVlaHDAA5gvwrUJKJ8KSskOvsEAe
 7M8eg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 481y91sbev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Jul 2025 05:01:10 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 22 Jul 2025 05:01:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 22 Jul 2025 05:01:09 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 1F8B43F7045;
 Tue, 22 Jul 2025 05:01:06 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>, <thomas@monjalon.net>
Subject: [PATCH v8 8/8] lib/pmu: fix out-of-bound access
Date: Tue, 22 Jul 2025 14:00:41 +0200
Message-ID: <20250722120041.2718227-9-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722120041.2718227-1-tduszynski@marvell.com>
References: <20250627154107.3405768-1-tduszynski@marvell.com>
 <20250722120041.2718227-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5OCBTYWx0ZWRfXzVgBifJlX9hr
 N1WXGtUCo6LPLZoMhmFbTuwI8j45/BOMQgH4F3d06kelbE7bA2xSnhUO7FS5JKQTU8/aaXvPmJ5
 VYiNDX2nYDf1HB+8w+NsIEJoZ5KLJ+aGtwgs2J3pV9xw5oycxNgedASp+dzbedLrX7zfCOPWcAB
 pMAr9GF966dokcwpWiv90svEjcTIOaXRnZ6+TcU8KppJ4NMy9m/ZIpad82tPvUNbw4Dq8s4hOZN
 fwczkRNuU/0KgX+BVWp5TaJ6NKabm3rPH4f2lA4o+bigJmTNJ2wI3iMTxJzjmraFUcnHQJP8nC7
 dYwsCYclfbxevnE4M7RLNVdlj1mpNu4lKbF3XkTwxoVovQrBF4/m+ARl8aaI9hODN38sulR0R2I
 nElBJ6QmoygXbUXABcvnbqrYpwa/mDDb89H+z4rVB9zoqn8BYQDzQSdz5zI0pXVVaD5dWQkp
X-Proofpoint-ORIG-GUID: 2VUm2MEx9SJdziI-H6ZfKHWSNBgyyAE_
X-Proofpoint-GUID: 2VUm2MEx9SJdziI-H6ZfKHWSNBgyyAE_
X-Authority-Analysis: v=2.4 cv=RfGQC0tv c=1 sm=1 tr=0 ts=687f7d86 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=rsDlWQ7q-kAZFu0dnB0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
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
index 742829cf9d..8960faa7d0 100644
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

