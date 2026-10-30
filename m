Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1A5606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=ejR8W9wX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93C0C4027B;
	Fri, 30 Oct 2026 10:17:10 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 1B64C4025A
 for <dev@dpdk.org>; Fri, 30 Oct 2026 10:17:08 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U8Enfl2005424 for <dev@dpdk.org>; Fri, 30 Oct 2026 02:17:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=VtdmqMuIN24DrqcXQi+PF6E
 lALKbe/JFN5RPUIE4tkk=; b=ejR8W9wXWQHMRDAwMa011Mypjf7z9Qd9S1dnHtJ
 NrEArv6MwPzYA9ptyzOq2xtXjlD8kQ7MS0R7IoMHexWSlX9KyGIM5i6pVUGNzWVO
 QV7K1VTxBORV9N5P4N2y3z37aYdUXHev842gLNUghegpNQ9uo6MuG06yTKetY799
 vhrCvtW8yeGYiMmwYB2ktAQAD6pX0W0Jaj8W65TEgKvl0IBl48GOyU/O1Y2sc8e5
 hgWHrG29w6aHQWgsi/9H8c7hxWqskuFNsCdSc3HHqAPu7GFBLuYCYhsHXGZhGmnD
 +33EUWSf2k1FcMOw7TkqFN/oeugDoSnTJZO0anwFvcB8yMg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hme5yt4h8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 30 Oct 2026 02:17:07 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 30 Oct 2026 02:17:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 30 Oct 2026 02:17:06 -0700
Received: from cavium-DT-30.. (unknown [10.28.36.108])
 by maili.marvell.com (Postfix) with ESMTP id 9A3FA5B6953;
 Fri, 30 Oct 2026 02:17:03 -0700 (PDT)
From: Nawal Kishor <nkishor@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Nawal Kishor
 <nkishor@marvell.com>
CC: <jerinj@marvell.com>, <asekhar@marvell.com>
Subject: [PATCH 1/2] common/cnxk: fix DPC alloc config width
Date: Fri, 30 Oct 2026 14:46:51 +0530
Message-ID: <20261030091700.1237155-1-nkishor@marvell.com>
X-Mailer: git-send-email 2.48.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzNiBTYWx0ZWRfX7bSRDJWaEUOl
 2sIX0rkI1r3BY25c/Vow9II1BQSCeaJQrv2jL5znerGxrjZplvulQz3Ms3WuihP8D8cAs0ZQYut
 PRa7jPHi8CJ13isB5M9nkNWXf+WZkDI=
X-Proofpoint-ORIG-GUID: LvScianFjFNnFzqq1yCRj_lHUXxIjveT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzNiBTYWx0ZWRfX91odorQUqXew
 Us36RZnL9ZTQZrJPDIE5RyCdYJNHjBdEG6/1pjFzPQRSaHGdIEioIzizGSCQbZ2pW1dbiqpB0ZE
 0NkP+zO9qxGYqM0I9Id+1JifOO7JZv2DyxvHQEnAXCKktFojPDlSBaF0uucteN/wDZXe3GaPFRt
 oiYB46r0xvrmwyFK8okouCMj3iTW0N3H4KHWe9ZwMUVEo9QruR/OfEoPWBV90eHbC4chf3sm6kS
 BsvSz80DDpdAaI9A1os6EP0vC64sT0eZ4abzSQAhLAzvDo1O3l0ar0xrHpBUDzXtbGsY0drJnOV
 KRyPYDJ93MIs7UkiN5YQEtGmHdXcJKbqfoeqy6YOyx5S09gykZcsZUK6QoDF7YxK+aXTz995/7V
 LIP3tZfMbG1DrRqY/nOr29r31JQjcS9ev6SmGQxD+90FKehiz4lIZGSOCiA2+o6OgVXNZ5wn8m4
 gu0FUQujZEeyh2U0TlA==
X-Authority-Analysis: v=2.4 cv=N6q8hG9B c=1 sm=1 tr=0 ts=6ae46093 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=qd4jw4jT77dKP2-cafUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: LvScianFjFNnFzqq1yCRj_lHUXxIjveT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The dpc_conf field of the NPA DPC alloc mailbox request is a 64-bit
value, but it was declared as 16 bits in struct npa_cn20k_dpc_alloc_req
and in roc_npa_dpc_alloc(). The upper bits of the configuration were
truncated before reaching the AF.

Widen both to 64 bits.

Fixes: 28d65f12ac77 ("common/cnxk: add NPA diagnostic counter")

Signed-off-by: Nawal Kishor <nkishor@marvell.com>
---
 drivers/common/cnxk/roc_mbox.h | 2 +-
 drivers/common/cnxk/roc_npa.c  | 2 +-
 drivers/common/cnxk/roc_npa.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index 279a9cc99b..e21596c82e 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -1466,7 +1466,7 @@ struct npa_cn20k_aq_enq_rsp {
 
 struct npa_cn20k_dpc_alloc_req {
 	struct mbox_msghdr hdr;
-	uint16_t __io dpc_conf;
+	uint64_t __io dpc_conf;
 };
 
 struct npa_cn20k_dpc_alloc_rsp {
diff --git a/drivers/common/cnxk/roc_npa.c b/drivers/common/cnxk/roc_npa.c
index 425bbc782b..ebeebf1205 100644
--- a/drivers/common/cnxk/roc_npa.c
+++ b/drivers/common/cnxk/roc_npa.c
@@ -1850,7 +1850,7 @@ roc_npa_dev_unlock(void)
 }
 
 int
-roc_npa_dpc_alloc(uint8_t *counter_id, uint16_t conf)
+roc_npa_dpc_alloc(uint8_t *counter_id, uint64_t conf)
 {
 	struct npa_cn20k_dpc_alloc_req *req;
 	struct npa_cn20k_dpc_alloc_rsp *rsp;
diff --git a/drivers/common/cnxk/roc_npa.h b/drivers/common/cnxk/roc_npa.h
index db610cbd2c..df68e13ec6 100644
--- a/drivers/common/cnxk/roc_npa.h
+++ b/drivers/common/cnxk/roc_npa.h
@@ -893,7 +893,7 @@ int __roc_api roc_npa_aura_drop_set(uint64_t aura_handle, uint64_t limit,
 
 void __roc_api roc_npa_dev_lock(void);
 void __roc_api roc_npa_dev_unlock(void);
-int __roc_api roc_npa_dpc_alloc(uint8_t *counter_id, uint16_t conf);
+int __roc_api roc_npa_dpc_alloc(uint8_t *counter_id, uint64_t conf);
 int __roc_api roc_npa_dpc_free(uint8_t counter_id);
 int __roc_api roc_npa_pool_dpc_enable(uint64_t aura_handle, uint8_t counter_id, uint32_t flags);
 int __roc_api roc_npa_pool_dpc_disable(uint64_t aura_handle, uint32_t flags);
-- 
2.48.1

