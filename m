Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76025CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 09:46:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 926FD402A0;
	Wed,  8 Oct 2025 11:46:02 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id EFC3540297;
 Wed,  8 Oct 2025 11:46:00 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5988HSZt012885;
 Wed, 8 Oct 2025 02:46:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=227EvEeKZiWJm4L5NJ6zqkV
 OS8pkWIO1WrR/Z/maNsc=; b=OEP9Ze4I94+egv5xI0zszDhGSkOh8RwpoDiZP1L
 jA7LNWY5dXwxWTsMzNz4rG+ulH4A0eKRTbAkTp4zwpgRnQR6cDS+apGF1l5cJ2Ur
 DSy0+u7gq/QpmOq1lGdW9zWiyXTTqlXAoivy3AwB76UsxIJRHX7Gbmnvh+OOVNCe
 7oH3w1Fney/KkS1aLWJjXl95Nkbihthw0YW/QboPmYVjG0cPhk4i6xYU/PUmoXNL
 k8NVeMxyMS8JTtJYDGuwCIkM7vUT8gHQL0Tchwxjon2caV1qmVABGUV+3TfEMWiO
 XZR31iONR5kXJY4IWjYtQMqhPx6VDU+5HfMUuzsXQ3HVbMg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49nmag04nw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Oct 2025 02:45:59 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 8 Oct 2025 02:45:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 8 Oct 2025 02:45:58 -0700
Received: from ashishg.sclab.marvell.com (unknown [10.110.24.201])
 by maili.marvell.com (Postfix) with ESMTP id 5EF2E5B693F;
 Wed,  8 Oct 2025 02:45:58 -0700 (PDT)
From: <ashishg@marvell.com>
To: <dev@dpdk.org>
CC: <stable@dpdk.org>, <fanzhang.oss@gmail.com>, Ashish Gupta
 <ashishg@marvell.com>
Subject: [PATCH] [v2] compressdev: update device ID validation check
Date: Wed, 8 Oct 2025 09:45:24 +0000
Message-ID: <20251008094555.3078441-1-ashishg@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDA1NSBTYWx0ZWRfX4Prj505/kx2u
 zyYECC1htEe6+f1AepLI5xQuwUsknANHv/XmLsFOq5AMDd3Zd/IBwBfpYd8klZzRAbnUkEY3oUZ
 v2l5ZBduBkQUkmLXn4nkUGgicldUalAyMXPyEfr8Riip/NfyGwyBSUe0GTdGeFzZUDXWIXq0+bk
 JJZHJYCISFwOlnTwIzp/Suw2lttJWAtR29wHQwkrZthWfxOvYHPRd9uIlo6qbdd5lKgOPnhVUsE
 /+c0Z8anhhOq0+R+B95OYo8cJdgF2DDe6FilZ1nKfXr0SAFf+w469wK+zAOasljo799fzCmKgNQ
 xJoX4pXfB3yU3y4MyKlhIVsP3MrgzfFg3FDszeTxsqBWN4U+EBW9oTHAwM9/dqscarYouchWynC
 TKN1W3+Amo0oTPoyldXLXeDElsMBSA==
X-Proofpoint-ORIG-GUID: tMqP-P6w8-DFG4fl98eD7giJgJGcMuoj
X-Proofpoint-GUID: tMqP-P6w8-DFG4fl98eD7giJgJGcMuoj
X-Authority-Analysis: v=2.4 cv=ar+/yCZV c=1 sm=1 tr=0 ts=68e632d7 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=M5GUcnROAAAA:8 a=nzEfcjhZ0GrmtaJz8NUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
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

From: Ashish Gupta <ashishg@marvell.com>

nb_devs is incremented / decremented each time a compressdev is
created/released. However, releasing device 1 incorrectly make device
N invalid and inaccessible. Similarly when first half of the devices
are released, rest half of the devices become inaccessible. This patch
updates the validation check to ensure correct behavior.

Signed-off-by: Ashish Gupta <ashishg@marvell.com>
---
v2
* additional updates
* updated commit message
---
---
 lib/compressdev/rte_compressdev.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/lib/compressdev/rte_compressdev.c b/lib/compressdev/rte_compressdev.c
index 33de3f511b..790b2cd658 100644
--- a/lib/compressdev/rte_compressdev.c
+++ b/lib/compressdev/rte_compressdev.c
@@ -30,6 +30,17 @@ static struct rte_compressdev_global compressdev_globals = {
 };
 
 RTE_EXPORT_SYMBOL(rte_compressdev_capability_get)
+
+static inline uint8_t
+rte_compressdev_is_valid_device_data(uint8_t dev_id)
+{
+	if (dev_id >= RTE_COMPRESS_MAX_DEVS ||
+			compressdev_globals.devs[dev_id].data == NULL)
+		return 0;
+
+	return 1;
+}
+
 const struct rte_compressdev_capabilities *
 rte_compressdev_capability_get(uint8_t dev_id,
 			enum rte_comp_algorithm algo)
@@ -38,10 +49,11 @@ rte_compressdev_capability_get(uint8_t dev_id,
 	struct rte_compressdev_info dev_info;
 	int i = 0;
 
-	if (dev_id >= compressdev_globals.nb_devs) {
+	if (!rte_compressdev_is_valid_device_data(dev_id)) {
 		COMPRESSDEV_LOG(ERR, "Invalid dev_id=%d", dev_id);
 		return NULL;
 	}
+
 	rte_compressdev_info_get(dev_id, &dev_info);
 
 	while ((capability = &dev_info.capabilities[i++])->algo !=
@@ -109,7 +121,7 @@ rte_compressdev_is_valid_dev(uint8_t dev_id)
 {
 	struct rte_compressdev *dev = NULL;
 
-	if (dev_id >= compressdev_globals.nb_devs)
+	if (!rte_compressdev_is_valid_device_data(dev_id))
 		return 0;
 
 	dev = rte_compressdev_get_dev(dev_id);
@@ -129,10 +141,10 @@ rte_compressdev_get_dev_id(const char *name)
 	if (name == NULL)
 		return -1;
 
-	for (i = 0; i < compressdev_globals.nb_devs; i++)
-		if ((strcmp(compressdev_globals.devs[i].data->name, name)
-				== 0) &&
-				(compressdev_globals.devs[i].attached ==
+	for (i = 0; i < compressdev_globals.max_devs; i++)
+		if (compressdev_globals.devs[i].data != NULL &&
+		    (strcmp(compressdev_globals.devs[i].data->name, name) == 0)
+		    && (compressdev_globals.devs[i].attached ==
 						RTE_COMPRESSDEV_ATTACHED))
 			return i;
 
@@ -663,7 +675,7 @@ rte_compressdev_info_get(uint8_t dev_id, struct rte_compressdev_info *dev_info)
 {
 	struct rte_compressdev *dev;
 
-	if (dev_id >= compressdev_globals.nb_devs) {
+	if (!rte_compressdev_is_valid_device_data(dev_id)) {
 		COMPRESSDEV_LOG(ERR, "Invalid dev_id=%d", dev_id);
 		return;
 	}
-- 
2.43.0

