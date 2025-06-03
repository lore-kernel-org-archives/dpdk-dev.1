Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB5BC5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 11:51:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BD8640BA0;
	Tue,  3 Jun 2025 13:50:57 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0B95640B9B
 for <dev@dpdk.org>; Tue,  3 Jun 2025 13:50:55 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553A4vjG012362
 for <dev@dpdk.org>; Tue, 3 Jun 2025 04:50:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=A
 uiKfpN1rBMqRXRMdiTJRscQV0TaPCi4u/jz9K2Mby8=; b=fGOQ4gPG3acPdg15R
 sYJ9HyHQ/AHnuQJ20jrL0yJf9m+T4CYtiSct0DMtfECB+Nf0YwxkDkNT4UjSN5R8
 xciSo/OhQ9SIJUvyImdVaAX2+Jgt7pPa04DsGgRLuNvOfPh6ajooN+xdereE41KL
 Xv8XMS+8FA9tixTHr/TvSWofy1QOH/bWhFbSyMILPpxQui5XrcK9Oh4Vh9Qw3q7t
 2i/hW73y2ubb+XTX4OadI2spR7DhMGrrx/u6/GHF3sZ6ZlFppSpQ5hvrPZvb8Ilk
 zr7HRGHhW4Fok2Hen4NbAxKLxhoQEx5+67X7oXkH7BQPDRVZVQrHUetGAgl5zPLa
 jWpng==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 471xyyg5ep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 03 Jun 2025 04:50:55 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 04:50:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Jun 2025 04:50:54 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 983095B6922;
 Tue,  3 Jun 2025 04:50:52 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 11/25] crypto/cnxk: add security session destroy
Date: Tue, 3 Jun 2025 17:20:12 +0530
Message-ID: <20250603115026.2664706-12-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250603115026.2664706-1-ktejasree@marvell.com>
References: <20250603115026.2664706-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=DsNW+H/+ c=1 sm=1 tr=0 ts=683ee19f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=RdC8Ne2aqbW4Nz29PYYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: lii6UE3Nc8JruQpgvINCVqfvtHIz-INg
X-Proofpoint-GUID: lii6UE3Nc8JruQpgvINCVqfvtHIz-INg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEwNCBTYWx0ZWRfX8omjqNFLLR97
 RN1F2SZGTtl6f+a0Wx1TcfEsUs569v3bQVx90fYFd0W3YGZKIAiHDNCbNzyTk1OZxDpXc2L4TYW
 2qybTRPURpgffD9NGy7jZlgHsBFkRWNaKeEzH4c+45Xg4GptfP4sxl3Pu3YIUgH8r7JTbxwBy1V
 1Y30WZyG10Ul1EWekiqKceJ98TnEa+ziMNuI9f3JCKeRYi+NeU+GTisY4XFqBcOBHHUufLEoep2
 RjjXWS9x24Q/vTtb1JwY+mAdLt7a7BxAwHgoZRqVDu4BkOU6OShHOKMXoz+/tLjVX87FFE/Uph0
 ++tjIy7lQ5nn0FGSYLai6erj64iwrea6Z3v3N3nbf11xKYBXMekml6ePDbywyTAfgJPh+xO94c3
 9yILVotq1oDbQyfnP4gIQuz2P86eZRrLdRQ12YCA5r9xxiv7DbiPugTOCMBUYTkRYfzryU3L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
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

From: Vidya Sagar Velumuri <vvelumuri@marvell.com>

Add support for rte_security session destroy for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev_sec.c | 17 +++++++-
 drivers/crypto/cnxk/cn20k_ipsec.c         | 51 ++++++++++++++++++++++-
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_sec.c b/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
index cf82c33e89..2a39338556 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
@@ -38,8 +38,21 @@ cn20k_sec_session_create(void *dev, struct rte_security_session_conf *conf,
 static int
 cn20k_sec_session_destroy(void *dev, struct rte_security_session *sec_sess)
 {
-	RTE_SET_USED(dev);
-	RTE_SET_USED(sec_sess);
+	struct cn20k_sec_session *cn20k_sec_sess;
+	struct rte_cryptodev *crypto_dev = dev;
+	struct cnxk_cpt_qp *qp;
+
+	if (unlikely(sec_sess == NULL))
+		return -EINVAL;
+
+	qp = crypto_dev->data->queue_pairs[0];
+	if (unlikely(qp == NULL))
+		return -ENOTSUP;
+
+	cn20k_sec_sess = (struct cn20k_sec_session *)sec_sess;
+
+	if (cn20k_sec_sess->proto == RTE_SECURITY_PROTOCOL_IPSEC)
+		return cn20k_sec_ipsec_session_destroy(qp, cn20k_sec_sess);
 
 	return -EINVAL;
 }
diff --git a/drivers/crypto/cnxk/cn20k_ipsec.c b/drivers/crypto/cnxk/cn20k_ipsec.c
index 4fa3872ef9..e19e080600 100644
--- a/drivers/crypto/cnxk/cn20k_ipsec.c
+++ b/drivers/crypto/cnxk/cn20k_ipsec.c
@@ -276,8 +276,55 @@ cn20k_ipsec_session_create(struct cnxk_cpt_vf *vf, struct cnxk_cpt_qp *qp,
 int
 cn20k_sec_ipsec_session_destroy(struct cnxk_cpt_qp *qp, struct cn20k_sec_session *sess)
 {
-	RTE_SET_USED(qp);
-	RTE_SET_USED(sess);
+	union roc_ow_ipsec_sa_word2 *w2;
+	struct cn20k_ipsec_sa *sa;
+	struct roc_cpt_lf *lf;
+	void *sa_dptr = NULL;
+	int ret;
+
+	lf = &qp->lf;
+
+	sa = &sess->sa;
+
+	/* Trigger CTX flush to write dirty data back to DRAM */
+	roc_cpt_lf_ctx_flush(lf, &sa->in_sa, false);
+
+	ret = -1;
+
+	if (sess->ipsec.is_outbound) {
+		sa_dptr = plt_zmalloc(sizeof(struct roc_ow_ipsec_outb_sa), 8);
+		if (sa_dptr != NULL) {
+			roc_ow_ipsec_outb_sa_init(sa_dptr);
+
+			ret = roc_cpt_ctx_write(lf, sa_dptr, &sa->out_sa,
+						sizeof(struct roc_ow_ipsec_outb_sa));
+		}
+	} else {
+		sa_dptr = plt_zmalloc(sizeof(struct roc_ow_ipsec_inb_sa), 8);
+		if (sa_dptr != NULL) {
+			roc_ow_ipsec_inb_sa_init(sa_dptr);
+
+			ret = roc_cpt_ctx_write(lf, sa_dptr, &sa->in_sa,
+						sizeof(struct roc_ow_ipsec_inb_sa));
+		}
+	}
+
+	plt_free(sa_dptr);
+
+	if (ret) {
+		/* MC write_ctx failed. Attempt reload of CTX */
+
+		/* Wait for 1 ms so that flush is complete */
+		rte_delay_ms(1);
+
+		w2 = (union roc_ow_ipsec_sa_word2 *)&sa->in_sa.w2;
+		w2->s.valid = 0;
+
+		rte_atomic_thread_fence(rte_memory_order_seq_cst);
+
+		/* Trigger CTX reload to fetch new data from DRAM */
+		roc_cpt_lf_ctx_reload(lf, &sa->in_sa);
+	}
 
 	return 0;
 }
-- 
2.25.1

