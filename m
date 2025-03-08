Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE82C282EC
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Mar 2025 08:59:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4246640150;
	Sat,  8 Mar 2025 09:59:14 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B4D8740144
 for <dev@dpdk.org>; Sat,  8 Mar 2025 09:59:11 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5288oL86008748;
 Sat, 8 Mar 2025 00:59:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=nz5OAtzAQnNYWeb/rdfSLKg
 B1uW4sRIefAO1i7I6oUg=; b=Uc4YuMl8h8O5ON53tOfxHkxoM5M5UHFNCWpyyLe
 FXWDCoDXsVvD158rtf+zlvpiPSkyVbfNH16Pm7xhwHelkPxArcU9FpHd+jVHBYPY
 ElVjXtChdpHeIO9MeFGiZx9tcEEXIaqwQDNJNzSOh8SnDH5v8HYac16r28+y14Ld
 ne/fHsor0R1McJUSegX1r7vHaM8QDH9g0nXlEuN2UTsjnbNzGvrQA9CanFncI3Xd
 tXQI5AZj/zALFHSTyY1DIb2/LQANfmfVzcb3ZfofTla3iHAfF0Lbbbt5Lj5tIFvy
 a0Z+IO6cIOkVRrTE8zFU2HZjLuWSSgkYW0oJm1MPUd0bV7w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 458ev9g8x4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 08 Mar 2025 00:59:07 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 8 Mar 2025 00:59:07 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 8 Mar 2025 00:59:06 -0800
Received: from MININT-80QBFE8.corp.innovium.com (unknown [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id 0AFE73F7043;
 Sat,  8 Mar 2025 00:59:04 -0800 (PST)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH] config/arm: fix march features not being set
Date: Sat, 8 Mar 2025 14:29:02 +0530
Message-ID: <20250308085902.4383-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jtR4VgOQnbNB0srrKNeDz99f-LvOV7rq
X-Proofpoint-GUID: jtR4VgOQnbNB0srrKNeDz99f-LvOV7rq
X-Authority-Analysis: v=2.4 cv=Mrqo63ae c=1 sm=1 tr=0 ts=67cc06db cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=wKhTIz0uthSbCaeEdTYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_03,2025-03-07_03,2024-11-22_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

Fix extra_march_features not being added to
mcpu flags when SoC configuration advertises
them.

Fixes: c02c01dbf907 ("config/arm: prefer strict use of -mcpu if supported")

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 config/arm/meson.build | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/config/arm/meson.build b/config/arm/meson.build
index dea329ceb7..7f85b088c9 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -841,6 +841,7 @@ if update_flags
         implementer_config = implementers[implementer_id]
         part_number = soc_config['part_number']
         soc_flags = soc_config.get('flags', [])
+        extra_features = soc_config.get('extra_march_features', [])
         if not soc_config.get('numa', true)
             has_libnuma = false
         endif
@@ -909,11 +910,15 @@ if update_flags
         machine_args += march
     else
         candidate_mcpu = '-mcpu=' + mcpu
-        if (cc.has_argument(candidate_mcpu))
-            machine_args += candidate_mcpu
-        else
+        if not cc.has_argument(candidate_mcpu)
             error('Compiler does not support -mcpu=@0@.'.format(mcpu))
         endif
+        foreach flag: extra_features
+            if cc.has_argument('+'.join([candidate_mcpu, flag]))
+                candidate_mcpu = '+'.join([candidate_mcpu, flag])
+            endif
+        endforeach
+        machine_args += candidate_mcpu
     endif
 
     # apply supported compiler options
-- 
2.43.0

