Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7F0CCA476
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 07:02:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CF5D409FA;
	Mon, 13 Oct 2025 09:00:53 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 838604021E;
 Mon, 13 Oct 2025 09:00:51 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D0UPb4001365;
 Mon, 13 Oct 2025 00:00:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
 L8e2MrXclTppenAambg9J3Fuq8PrCfyKrCqp90BlJI=; b=KvybWvMLn8CWdrAaW
 6czW2LYy0tOjOB42HGQc6fBGDcEymZhRYGwZotejzcMYw+VlWGq3HAmLep1otWm9
 NsDoKb44/MiV6mH48IQ6/kOJwS+dP44uektX6jXPBTT7D4FjQf1puNbRzpYtJrNd
 weQkt3e1eLSuvJG1QvUrdwSwNJWtcbf3yWLduuJ0YtN8BKKq8Bd4EGnB4+1zAb3s
 IUtXnrWWLmR0JdOoYtVkcunjCKcxQPdCyzaAqyy4QTBPevJRCoerYsPhby7/r//S
 lCPx4jjooNrDDv8Dge/XV9tVAljk3x2Rut4S+CAci7zCn2u5rnCzJwWD9j4RoWM+
 VLqQw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49rp1jrmpj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 00:00:50 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Oct 2025 00:00:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Oct 2025 00:00:59 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 2709F3F70C1;
 Mon, 13 Oct 2025 00:00:46 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v2 18/19] common/cnxk: fix error handling on inline inbound
 setup
Date: Mon, 13 Oct 2025 12:29:48 +0530
Message-ID: <20251013065949.200414-18-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013065949.200414-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251013065949.200414-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MiE8lWXwp9KrHwGYprx7Wy5Y5hZBW1l-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDEyNSBTYWx0ZWRfXykXf/pQyrr8v
 HuG9z3gm7uVTHuE9z06Q2RWu5pIZV5K5m8F6sO1aMA0JxU7OWr7NRH5NBj9q9N62ospzPYtZJDQ
 BI/xdy53oOcUolLbW7wXcHgrVwCKpLYea4RPUIXGkzXdGWgVnTLKdeksZZ2iIOyRh2jGZGPpXe6
 gwM+RVtX4J5hhytNSQyYnhblUinmcdbOTWcxlW3c15VYc6VfDQPPtXpgQFnZum4OxJdJUGRX/76
 0VKmxxNphpm1IxbdtkzWZeOCVk/kjW9EEY7FN5KE8g6WSif6MuJ8ZbHVY7iqRCe2WcnOjVSSRFf
 dPm9u+2k0W2GAbrSeKBsuttf9FFQlxUllVIQc8HlVHHD9TZ5muHlXRCgIeopdz3l8NRvjXxAceT
 m2F004C892c/3TlirI+TtZTJR1+m3Q==
X-Authority-Analysis: v=2.4 cv=Utdu9uwB c=1 sm=1 tr=0 ts=68eca3a2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=Np0JFEGaXBVNt86ZIjUA:9
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: MiE8lWXwp9KrHwGYprx7Wy5Y5hZBW1l-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
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

Fix issue reported by kloc work.
Fixes: f410059baac6 ("common/cnxk: support inline inbound queue")
Cc: stable@dpdk.org

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index 75d03c1077..38ff96334e 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -244,7 +244,7 @@ nix_inl_inb_queue_setup(struct nix_inl_dev *inl_dev, uint8_t slot_id)
 	if (!cpt_req) {
 		rc |= -ENOSPC;
 	} else {
-		nix_req->enable = false;
+		cpt_req->enable = 0;
 		rc |= mbox_process(mbox);
 	}
 cpt_cfg_fail:
-- 
2.34.1

