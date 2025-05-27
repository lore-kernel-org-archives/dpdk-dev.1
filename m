Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5EEC5B542
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 11:03:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9906540B94;
	Tue, 27 May 2025 13:02:42 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 784934069D
 for <dev@dpdk.org>; Tue, 27 May 2025 13:02:37 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QNTsai001051
 for <dev@dpdk.org>; Tue, 27 May 2025 04:02:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=G
 rhAYEKdW8sqjfGkp74MvM+laChwTzMlCqBwV/DJSeQ=; b=jZWVVxpJ4GUM9K+Va
 JhTrln6PFiKMVTIJ0rdotI+ySaqz/y4AlIqTRtIvzGhBIm9fliIyGfBqrDuraOUZ
 ztss8Eg9qJcYXUoahm1CP///EQ73OgLn/cLW5YKvUKXXEesXH1Acq0yfLv2WMiW7
 FImZeuPTznT6vaxkOelRUXj5uj5zzPTyrtjKHLssknsmVoKUMEr+sgdUdGgc/dgk
 0Z/6cwHxm8NdtBe4Vz13P6ThDBKmRiDeU6urHjWR5hfVBUqtPDSz6/IeRKroYv+e
 +BTIpzbpKwMr7jA6v0KfGImdytJv6EIRhN6MRxUQG01QGqb6TUJMUFG+aFlleXFw
 hS1xw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46w21293nw-9
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 May 2025 04:02:36 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 May 2025 04:02:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 May 2025 04:02:34 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 6F5603F707A;
 Tue, 27 May 2025 04:02:32 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 11/25] crypto/cnxk: add security session destroy
Date: Tue, 27 May 2025 16:31:51 +0530
Message-ID: <20250527110205.2300800-12-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527110205.2300800-1-ktejasree@marvell.com>
References: <20250527110205.2300800-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=H6zbw/Yi c=1 sm=1 tr=0 ts=68359bcc cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=RdC8Ne2aqbW4Nz29PYYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 27F4EGxEAk9QopZGVS6tbROo8J9UmxkA
X-Proofpoint-ORIG-GUID: 27F4EGxEAk9QopZGVS6tbROo8J9UmxkA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA5MCBTYWx0ZWRfX2vLygqlU21c1
 BjkNN+oV5JNjr14h3YOotDJxW70F4hc0CcJEpj0It6Dy2M5Qy+y8U+r/h/xKWexCyvzBgkNQT6N
 Hvn/1svh9xLDRslww/jfsxJNGk94GuIzwjXhbXxN9+jZbtwRNU53ba9lo0lccJNNSiITzKnnqrg
 tNc4nRVHrDs0Xs84GXI0eXxIvajBIK0/rtagbzyBj60vRjotMR14MU4Tmc4nFy5da+03k39w7bE
 6jLeesVZLP6FLlZwyL/rOYFqtVB0ufstS3c0Oe/0FKG1mIMaysUsS2/o3ve/3KK4Vajo+Boj+iB
 xBMYicCXyX8LtSMQrWpJEaQ8M5Q2f7cT8ojnociQ0vn9b0tqcuJqZ4M+Mi3hGUTA1nL4R2JdLZM
 3aXKpB7Iq+FbvqU4BqVisj3itdpNA/QCHGPrMp+fZKMbHa31OS+xx6+ukBRO08RsNb/3N/ud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_05,2025-05-27_01,2025-03-28_01
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

Add support for rte security session destroy for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev_sec.c | 17 +++++++-
 drivers/crypto/cnxk/cn20k_ipsec.c         | 51 ++++++++++++++++++++++-
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_sec.c b/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
index 0bb4b7db63..1b18398250 100644
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

