Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB36BC79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:57:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A408427E6;
	Thu, 10 Sep 2026 15:57:01 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 963B342D45;
 Thu, 10 Sep 2026 15:56:59 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ACAgfd1008300; Thu, 10 Sep 2026 06:56:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=2
 ez5Ni26K/E+xorPD7CSIAUk2RAJelSY/e75lKGv68o=; b=Ua4dW6iWQkIrwnRgg
 pAvNh7K7uAqFBDdRKp72ybkwUIVHZYimvTEMETpN88PG2/dr9f+PlwanCXphVfBJ
 PtlzI8W1L3Bh+HwmjK7Bol+3RfWrxEFjR9IrH13ZCgOceFx2eIoY0mTmpbIHB9Ri
 PGGUcSf9UoZdaBP5XYhFr9B9jdeDDSIVg6YpwiDxB5VuxVdo8YTDDL8nrWvgrJED
 olD2DSmeyBGjXvc4T99X4zARNF2h5Fs/rr83gVLysIk9FXFe1x3JJckd1QN6MnKJ
 +1uJnC7R3RZ+h2asLGuLq6UvuE7rKsbWUqr/xAfUsEfpPPC2jrAfRWL0ht9FIw8H
 0Kl1g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gkcxnuhv7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2026 06:56:58 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Sep 2026 06:56:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 10 Sep 2026 06:56:57 -0700
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.165.174])
 by maili.marvell.com (Postfix) with ESMTP id 72F8F3F7086;
 Thu, 10 Sep 2026 06:56:55 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>, "Shijith
 Thotton" <sthotton@marvell.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH 2/2] event/cnxk: advertise CN20K preschedule capabilities
Date: Thu, 10 Sep 2026 19:26:49 +0530
Message-ID: <20260910135649.24956-2-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260910135649.24956-1-pbhagavatula@marvell.com>
References: <20260910135649.24956-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=K923jCWI c=1 sm=1 tr=0 ts=6aa2b72a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=6aWugfRyY-JjSbMZB7kA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: 6zVfYWC2rFDJ5j__n5w9xJQV0Bi_GCI1
X-Proofpoint-GUID: 6zVfYWC2rFDJ5j__n5w9xJQV0Bi_GCI1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE2OCBTYWx0ZWRfXxA0HdCEJhygF
 2e7tLErwX17ulSecol0jS3ZMhOBc9LigkFEv6OCCT5m4kvPNqOig5Kbm0tNYE+N0zo2CuLppKbW
 LmwFVewDulhpiC4gG1paNpzQWn9qego=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE2OCBTYWx0ZWRfXxEMuZd0rqKhj
 eMPHb+3O/QD4r1zaYvUMP18Sks8POWa4sd/bKxIG90dHrEkwRWSglKxZDw/C1t8R0xxACbcTVj7
 RQKNd5VVAH1GuYw2zCRAp16FezCcvsi8cyQoEG5KiBWQPaPyvI3hq5hSc4IJcG5ZGA2bCqOY6BW
 xKHn39u5aYtzBOFAfxoA73vSBp0Dj2UcY6aNhhDvOXXuAB3YTCacFddNgkrQwEj2KpfklA9Sd15
 O7a8+JVFcbZw//hN8/OOa8/cY7LH41QfVWA1PKY0sZbJLW8M2gBHkQSliH38DWnJuncKxC0PV2R
 P/eLrZSeVXcLniSGuQ2EJMuFOzICkL5yZb0T35CocdTdEGypoDoCmvAuPfYmKZHFXcx6fd111Qo
 3KJPxIe0It/wE4oz8VMRCyHX/YLsuBgG2+IdbPFjDdXa3nJ/vWjwY7qM69sA2m9D9+doIJ8aTt/
 CkRCtUZ+zmJ7K/EVyQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_04,2026-09-09_02,2025-10-01_01
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

The CN20K preschedule callbacks were wired up but the capability
flags were never reported, so applications could not use the feature.
Advertise the preschedule caps in cn20k_sso_info_get().

Fixes: 1e2d9b3dfc9a ("event/cnxk: add CN20K event port preschedule")
Cc: stable@dpdk.org

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 drivers/event/cnxk/cn20k_eventdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/event/cnxk/cn20k_eventdev.c b/drivers/event/cnxk/cn20k_eventdev.c
index 9d34168c3292..29495eb4f9f4 100644
--- a/drivers/event/cnxk/cn20k_eventdev.c
+++ b/drivers/event/cnxk/cn20k_eventdev.c
@@ -431,6 +431,9 @@ cn20k_sso_info_get(struct rte_eventdev *event_dev, struct rte_event_dev_info *de
 	dev_info->driver_name = RTE_STR(EVENTDEV_NAME_CN20K_PMD);
 	cnxk_sso_info_get(dev, dev_info);
 	dev_info->max_event_port_enqueue_depth = UINT32_MAX;
+	dev_info->event_dev_cap |= RTE_EVENT_DEV_CAP_EVENT_PRESCHEDULE |
+				   RTE_EVENT_DEV_CAP_EVENT_PRESCHEDULE_ADAPTIVE |
+				   RTE_EVENT_DEV_CAP_PER_PORT_PRESCHEDULE;
 }
 
 static int
-- 
2.50.1 (Apple Git-155)

