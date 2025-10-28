Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6546DCCF9EE
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 14:12:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9ED8440677;
	Tue, 28 Oct 2025 15:12:20 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5D2844021E;
 Tue, 28 Oct 2025 15:12:17 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59SDrq451221111; Tue, 28 Oct 2025 07:12:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=FMjYlVKn9MHOY6H1JYJLa1c
 zk1H5EoqmOmTdo/bFWRc=; b=OKf4k9PA8fjzDEFVDo2dD0a1oldzKtaFjE+QRSx
 EZbPZIdGAi0WkAiZlWt/pkULiJTIgepwaq+q/uVnkO/EpDwIvDS1H8mj3AxAgzDQ
 Sn9XXeguQ6d4durSplEODABKOq05SO4SGN6xsAuDJ8tIO6tMOhlgTUdmXoY0HNxA
 8b9qFJ44enQ95DU3DSGGvqx+Ku620boyhPhnqElMB1BYzRYUVvs9JCiWq6D0MmuW
 SSHaD4EOAli1MEWki8h6c8M8Hv0l2LfwSU3EHn5/sb2kjEZNxWn8JPPeQVm0yeuN
 JyRJ5AUqt0oqYyK6Yb5DrgfSbrThTb+Z21eSJuIHX8jLBtA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a2ttbh6ca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 07:12:16 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 28 Oct 2025 07:12:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 28 Oct 2025 07:12:14 -0700
Received: from jerin-lab.marvell.com (jerin-lab.marvell.com [10.28.34.14])
 by maili.marvell.com (Postfix) with ESMTP id 93BAD3F7109;
 Tue, 28 Oct 2025 07:12:12 -0700 (PDT)
From: <jerinj@marvell.com>
To: Erik Gabriel Carrillo <erik.g.carrillo@intel.com>, Jerin Jacob
 <jerinj@marvell.com>, Sachin Saxena <sachin.saxena@nxp.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <david.marchand@redhat.com>,
 <stable@dpdk.org>
Subject: [dpdk-dev] [PATCH] doc: fix doxygen errors with v1.15.0
Date: Tue, 28 Oct 2025 19:41:59 +0530
Message-ID: <20251028141159.177727-1-jerinj@marvell.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: c3W54xMxPW3tzTv_8gw2T2zammCSFD77
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDExOSBTYWx0ZWRfX4G9upUDgqOZo
 7rV7k9bArBiSA2DEzV8EewlBUmgFAezCN1K9cO9mYV+bn0/4etU1iGSkYXrcIsS5sFvcO0toUub
 uXEEoBv92n162UJ6tWtgw0cO9DzNae44jNrCetDegJpxpNtjiom5aIIBFRwtVGsR9lWMdvMFgIC
 RWUo6mQdsBKOiVogyBcBPjqRNwfmXqfwFGVxJJUBq5H+vVMmrJOwHhCsPTN0j7dPajlFPuB1+e2
 tkV+/u+Bj+PLepmlHCqUY9jeBjxltB18vyH0zglYsMwLWtaz1suKB+dua3wPc9jU531o5DitE7Y
 ZlVUsqFFCRHzWu08pK/3cmEOqVKM0lILf4hP4FvAyfZpmAwr3h3kvjW1z4wx4Pk0weEY90znQsV
 JpEkgPcRPN9Jmmw8TMtuoml18aV+iw==
X-Authority-Analysis: v=2.4 cv=Ffk6BZ+6 c=1 sm=1 tr=0 ts=6900cf40 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=bCyuHyKUdbIu3Wqq8GgA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: c3W54xMxPW3tzTv_8gw2T2zammCSFD77
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_05,2025-10-22_01,2025-03-28_01
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

From: Jerin Jacob <jerinj@marvell.com>

Doxygen detects valid errors. Fixing the same.

Example:
lib/eventdev/rte_event_timer_adapter.h:720: error: Reached end of file
while still searching closing '`' of a verbatim block starting at line
569 (warning treated as error, aborting now)

Fixes: a6562f6d6f8e ("eventdev: introduce event timer adapter")
Cc: stable@dpdk.org

Signed-off-by: Jerin Jacob <jerinj@marvell.com>
---
 lib/eventdev/rte_event_timer_adapter.h | 2 +-
 lib/rawdev/rte_rawdev_pmd.h            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/eventdev/rte_event_timer_adapter.h b/lib/eventdev/rte_event_timer_adapter.h
index 256807b3bf..67e65ab849 100644
--- a/lib/eventdev/rte_event_timer_adapter.h
+++ b/lib/eventdev/rte_event_timer_adapter.h
@@ -566,7 +566,7 @@ struct __rte_cache_aligned rte_event_timer_adapter {
  * Before calling this function, the application allocates
  * ``struct rte_event_timer`` objects from mempool or huge page backed
  * application buffers of desired size. On successful allocation,
- * application updates the `struct rte_event_timer`` attributes such as
+ * application updates the ``struct rte_event_timer`` attributes such as
  * expiry event attributes, timeout ticks from now.
  * This function submits the event timer arm requests to the event timer adapter
  * and on expiry, the events will be injected to designated event queue.
diff --git a/lib/rawdev/rte_rawdev_pmd.h b/lib/rawdev/rte_rawdev_pmd.h
index b810006a46..02351a2a29 100644
--- a/lib/rawdev/rte_rawdev_pmd.h
+++ b/lib/rawdev/rte_rawdev_pmd.h
@@ -506,7 +506,7 @@ typedef int (*rawdev_firmware_version_get_t)(struct rte_rawdev *dev,
  *   >0, ~0: for successful load
  *   <0: for failure
  *
- * @see Application may use 'firmware_version_get` for ascertaining successful
+ * @see Application may use `firmware_version_get` for ascertaining successful
  * load
  */
 typedef int (*rawdev_firmware_load_t)(struct rte_rawdev *dev,
-- 
2.51.2

