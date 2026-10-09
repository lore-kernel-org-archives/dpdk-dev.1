Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E90CA6019
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 11:41:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06F7940279;
	Fri,  9 Oct 2026 13:41:59 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0BE894026F
 for <dev@dpdk.org>; Fri,  9 Oct 2026 13:41:57 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998IWFM2796902; Fri, 9 Oct 2026 04:41:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=Te3DOCKR3mtvt7xfrq0H7eZ
 hwYsAuAfmXkKjyUi6opw=; b=RAsqoVmZFPwLPC3eNw5R/OxkDBYBd99choE5nvV
 n17mh0YSEyR3QUDg/gZl2hDjqYD5talJJFDl+Wm31dBOfjy9hrCphU7sA0pmZ5SK
 uAmPshNJcFzZboc/Glge8TSkz3bYfHAKoSbSJF7uyROSvDEhhmPHncmxzrCOm6lR
 DwVLx6hZFLD+sYeKfxpKwDUZ1BjAq1ir1x0H1uAgG6auJcvjbMjwCBAXZafkgVvg
 yNpHUDxnwSYGLXOpD5qqwE6vMIQEX27k+RVJbOIFLGk146ARuaxm8/pLiwrm7Cdp
 ZdiGqowMUQJ6uSIgdpiqCfJOIzcz6BMFOROQcUZ7YsYzvSA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4h6kjs2nm5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 04:41:57 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 9 Oct 2026 04:41:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 9 Oct 2026 04:41:56 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id 34E755B6921;
 Fri,  9 Oct 2026 04:41:52 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <gmuthukrishn@marvell.com>,
 Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH] crypto/cnxk: fix AE table get on unprobed device
Date: Fri, 9 Oct 2026 11:41:42 +0000
Message-ID: <20261009114142.2598690-1-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: YCjpYVz9AyWx9X4XoQcZ5eImhBVau9cJ
X-Proofpoint-ORIG-GUID: YCjpYVz9AyWx9X4XoQcZ5eImhBVau9cJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfX6sQaPHIIxAGm
 /53gfNJ/CwYJVVmpXs8FsOLxT7TuPfdeIkXGJhQH+0wlZ7D40fOinHrr/xp+MrS9Gx4DbPHu4Al
 SKdkOWtOg7+N7nrcZZx4zK9t/FckFmc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfX61tinu9+ZnE4
 bHHAsdTFA6EZQws93UZ+QQDV+vKUaRuYjcjd/cg9+oOyTYaGsiI9dlDsmWEyb431ZLXi+1qwH3W
 bON3oSnq1AIe7GMnEZs1iDZ6FZIS6k5ioMJJOYbp6eZcI714h6ove8PuUbTWgnX6wlMfzXBIlNO
 2U0bZdRKLZi/ULhx5h3uv0M5jbV2I9iw5r5n5PKh+prpEdQrGXk/XZBMycb24EHAu5Ys1BOoBsz
 gR8vkdNH0TRUGJnpZvMEXwlomsgE/g/mfKdS5EufWo7j2/GcDOAvPQmKdK6hNs4VHkeELisuMaP
 92i0DKAB6AHHyN70EdvWtpQtaqBCGFRuNlcQk7Gp2fL6pa9VHQ52EBtMWm0qPyX3rKjAa8UBakQ
 E4dBfU0nhLx7J1WnmBadLRCvboozRjkMgPbCPe+cap57aruE256uPQxufp6EDctCaj2A/0QUfO0
 XqEf9lHAiJFckWWokMg==
X-Authority-Analysis: v=2.4 cv=BPQmP1QG c=1 sm=1 tr=0 ts=6ac8d305 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=SeQzfxXZAHSPz4-IFdEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
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

rte_pmd_cnxk_ae_ec_grp_table_get() and rte_pmd_cnxk_ae_fpm_table_get()
checked rte_cryptodev_pmd_get_dev() against NULL, but that helper
always returns a valid pointer into the static device array, even for
an unprobed dev_id. This led to a NULL dereference on dev->data when
called with a dev_id that has no probed device.

Use rte_cryptodev_is_valid_dev() to validate dev_id before
dereferencing dev->data, and reject a NULL nb_max_entries pointer in
rte_pmd_cnxk_ae_ec_grp_table_get().

Fixes: 53ff25b1086b ("crypto/cnxk: add API to get EC group table address")
Fixes: a1b4cc32591d ("crypto/cnxk: add API to get FPM table address")

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index 4c9bacecdd..b0ae8c7298 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -1131,12 +1131,12 @@ rte_pmd_cnxk_ae_fpm_table_get(uint8_t dev_id)
 	struct rte_cryptodev *dev;
 	struct cnxk_cpt_vf *vf;
 
-	dev = rte_cryptodev_pmd_get_dev(dev_id);
-	if (dev == NULL) {
+	if (!rte_cryptodev_is_valid_dev(dev_id)) {
 		plt_err("Invalid dev_id %u", dev_id);
 		return NULL;
 	}
 
+	dev = rte_cryptodev_pmd_get_dev(dev_id);
 	vf = dev->data->dev_private;
 	if (vf == NULL) {
 		plt_err("VF is not initialized");
@@ -1153,12 +1153,17 @@ rte_pmd_cnxk_ae_ec_grp_table_get(uint8_t dev_id, uint16_t *nb_max_entries)
 	struct rte_cryptodev *dev;
 	struct cnxk_cpt_vf *vf;
 
-	dev = rte_cryptodev_pmd_get_dev(dev_id);
-	if (dev == NULL) {
+	if (nb_max_entries == NULL) {
+		plt_err("Invalid nb_max_entries pointer");
+		return NULL;
+	}
+
+	if (!rte_cryptodev_is_valid_dev(dev_id)) {
 		plt_err("Invalid dev_id %u", dev_id);
 		return NULL;
 	}
 
+	dev = rte_cryptodev_pmd_get_dev(dev_id);
 	vf = dev->data->dev_private;
 	if (vf == NULL) {
 		plt_err("VF is not initialized");
-- 
2.54.0

