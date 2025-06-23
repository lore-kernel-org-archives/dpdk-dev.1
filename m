Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2E0C7115B
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 04:49:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95B4B40270;
	Mon, 23 Jun 2025 06:49:33 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 68DCC400D6
 for <dev@dpdk.org>; Mon, 23 Jun 2025 06:49:30 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N2t933013674;
 Sun, 22 Jun 2025 21:49:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=h
 nm3jA8ZQ7rYJpcFV/6SHDEHLqTtZc1KioTrOAppU5E=; b=BiuTHCnYVSp2E+ngd
 eNPnOjZBDgMbAUOql2+LHRzzl90pYUsr0S/gSiwe7Zp/ITBd/8XDV92//xIOnoqI
 50nSIpzr0ZhPABGf5lrJYIZejdbewSbRo8kATwBPbECvBpNQut2EAmzZTUU5ZlGL
 qbEPKptWYMWR+spGSrnd96MHNAFnOUI639B0XAlerhll6HL4kp0P7Z02Dj2vnRvV
 oXC2x60Ux8FJjtNTk6lubBlcZHWVSODEjYPlRAg2JJCDfI/qykz/IIv2nwqAkmck
 tonzU1HQDOotjk9aiAsWWOkKvinxH+BL1sLmh4KIdXhWZBAGmFoZHKXbpIT8weFZ
 x3XoA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47exhg856t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 22 Jun 2025 21:49:22 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 22 Jun 2025 21:49:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 22 Jun 2025 21:49:22 -0700
Received: from localhost.localdomain (unknown [10.28.36.158])
 by maili.marvell.com (Postfix) with ESMTP id AF1083F703F;
 Sun, 22 Jun 2025 21:49:18 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Srujana Challa
 <schalla@marvell.com>, Jerin Jacob <jerinj@marvell.com>, Ray Kinsella
 <mdr@ashroe.eu>
CC: Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 1/2] net/cnxk: fix lock for security session ops
Date: Mon, 23 Jun 2025 10:19:06 +0530
Message-ID: <20250623044907.2906896-1-rbhansali@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250620050950.2548925-1-rbhansali@marvell.com>
References: <20250620050950.2548925-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: uSHz1LpsJJ0Evskl8kSL-cLXNa_P5HiJ
X-Authority-Analysis: v=2.4 cv=O5c5vA9W c=1 sm=1 tr=0 ts=6858dcd2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=tXlxyzx3Ts5Cnbg1ZM0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDAyNiBTYWx0ZWRfX/X490LvScCwd
 JU5XTJsqBcv/yxfshC9v/c7YuzYxvNxJugOC2gwNtoycwGA10jSplT30nlvIa1h0skkUT7qGL0d
 NQpklFshR3mRXvW+hAjH8xm6Gis1QaRkthxOHrq799Rl1XGpISbNp/n4l8wC7jB+dNdYzO2TAS8
 INcujwiI/d/tgI/pgAkWvQj3AS585MwV+4zeF7CsTr1jenmUOPSXaiZkOQSWcFfF9M8ebz1jMmI
 q225d7qAJnZwM8BZ5sJtBHrqJ6ZnT+4sio3IAjmhlI8EL28afBw7UYA/YcIambWWN5PTf6Dy+4i
 SCz7u8Aqkt1mRnXSpNuIA+E/3jXIFmdODThJPuoVNUrjEzrTwprc0bNwL3bTOaODhwZHUyxcUGN
 b518RB5IgeTL4CJLqOgZZRZQJmQAdBQKHtWViVkFMZ7TU5YSwAgKjphqc/gURdatL4rGBUyM
X-Proofpoint-ORIG-GUID: uSHz1LpsJJ0Evskl8kSL-cLXNa_P5HiJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_01,2025-06-20_01,2025-03-28_01
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

Add fixes to have lock on security session update, write and read to
prevent corruption.

Fixes: a72e15611303 ("net/cnxk: add PMD API for IPsec SA base and flush")
Fixes: 8efa348e8160 ("net/cnxk: support custom SA index")

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: Updated fixes in commit message.

 drivers/net/cnxk/cn10k_ethdev_sec.c | 65 +++++++++++++++++++++++------
 drivers/net/cnxk/cnxk_ethdev_sec.c  | 60 ++++++++++++++++++++++++--
 2 files changed, 109 insertions(+), 16 deletions(-)

diff --git a/drivers/net/cnxk/cn10k_ethdev_sec.c b/drivers/net/cnxk/cn10k_ethdev_sec.c
index 0dc5c22444..110630596e 100644
--- a/drivers/net/cnxk/cn10k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn10k_ethdev_sec.c
@@ -786,7 +786,6 @@ cn10k_eth_sec_session_create(void *device,
 	inbound = !!(ipsec->direction == RTE_SECURITY_IPSEC_SA_DIR_INGRESS);
 	inl_dev = !!dev->inb.inl_dev;

-	memset(eth_sec, 0, sizeof(struct cnxk_eth_sec_sess));
 	sess_priv.u64 = 0;

 	lock = inbound ? &dev->inb.lock : &dev->outb.lock;
@@ -796,6 +795,8 @@ cn10k_eth_sec_session_create(void *device,
 	if (inbound && inl_dev)
 		roc_nix_inl_dev_lock();

+	memset(eth_sec, 0, sizeof(struct cnxk_eth_sec_sess));
+
 	if (inbound) {
 		struct roc_ot_ipsec_inb_sa *inb_sa, *inb_sa_dptr;
 		struct cn10k_inb_priv_data *inb_priv;
@@ -1007,7 +1008,7 @@ cn10k_eth_sec_session_create(void *device,
 		roc_nix_inl_dev_unlock();
 	rte_spinlock_unlock(lock);

-	plt_nix_dbg("Created %s session with spi=%u, sa_idx=%u inl_dev=%u",
+	plt_nix_dbg("Created %s session with spi=0x%x, sa_idx=0x%x inl_dev=%u",
 		    inbound ? "inbound" : "outbound", eth_sec->spi,
 		    eth_sec->sa_idx, eth_sec->inl_dev);
 	/*
@@ -1089,7 +1090,7 @@ cn10k_eth_sec_session_destroy(void *device, struct rte_security_session *sess)

 	rte_spinlock_unlock(lock);

-	plt_nix_dbg("Destroyed %s session with spi=%u, sa_idx=%u, inl_dev=%u",
+	plt_nix_dbg("Destroyed %s session with spi=0x%x, sa_idx=0x%x, inl_dev=%u",
 		    eth_sec->inb ? "inbound" : "outbound", eth_sec->spi,
 		    eth_sec->sa_idx, eth_sec->inl_dev);

@@ -1112,7 +1113,8 @@ cn10k_eth_sec_session_update(void *device, struct rte_security_session *sess,
 	struct cn10k_sec_sess_priv sess_priv;
 	struct rte_crypto_sym_xform *crypto;
 	struct cnxk_eth_sec_sess *eth_sec;
-	bool inbound;
+	bool inbound, inl_dev;
+	rte_spinlock_t *lock;
 	int rc;

 	if (conf->action_type != RTE_SECURITY_ACTION_TYPE_INLINE_PROTOCOL ||
@@ -1127,6 +1129,14 @@ cn10k_eth_sec_session_update(void *device, struct rte_security_session *sess,
 	if (!eth_sec)
 		return -ENOENT;

+	inl_dev = !!dev->inb.inl_dev;
+	lock = inbound ? &dev->inb.lock : &dev->outb.lock;
+	rte_spinlock_lock(lock);
+
+	/* Acquire lock on inline dev for inbound */
+	if (inbound && inl_dev)
+		roc_nix_inl_dev_lock();
+
 	eth_sec->spi = conf->ipsec.spi;

 	if (inbound) {
@@ -1140,7 +1150,7 @@ cn10k_eth_sec_session_update(void *device, struct rte_security_session *sess,

 		rc = cnxk_ot_ipsec_inb_sa_fill(inb_sa_dptr, ipsec, crypto);
 		if (rc)
-			return -EINVAL;
+			goto err;
 		/* Use cookie for original data */
 		inb_sa_dptr->w1.s.cookie = inb_sa->w1.s.cookie;

@@ -1158,7 +1168,7 @@ cn10k_eth_sec_session_update(void *device, struct rte_security_session *sess,
 					   eth_sec->inb,
 					   sizeof(struct roc_ot_ipsec_inb_sa));
 		if (rc)
-			return -EINVAL;
+			goto err;

 		/* Save userdata in inb private area */
 		inb_priv->userdata = conf->userdata;
@@ -1175,7 +1185,7 @@ cn10k_eth_sec_session_update(void *device, struct rte_security_session *sess,

 		rc = cnxk_ot_ipsec_outb_sa_fill(outb_sa_dptr, ipsec, crypto);
 		if (rc)
-			return -EINVAL;
+			goto err;

 		/* Save rlen info */
 		cnxk_ipsec_outb_rlens_get(rlens, ipsec, crypto);
@@ -1204,24 +1214,40 @@ cn10k_eth_sec_session_update(void *device, struct rte_security_session *sess,
 					   eth_sec->inb,
 					   sizeof(struct roc_ot_ipsec_outb_sa));
 		if (rc)
-			return -EINVAL;
+			goto err;

 		/* Save userdata */
 		outb_priv->userdata = conf->userdata;
 		sess->fast_mdata = sess_priv.u64;
 	}

+	if (inbound && inl_dev)
+		roc_nix_inl_dev_unlock();
+	rte_spinlock_unlock(lock);
+
+	plt_nix_dbg("Updated %s session with spi=0x%x, sa_idx=0x%x inl_dev=%u",
+		    inbound ? "inbound" : "outbound", eth_sec->spi, eth_sec->sa_idx,
+		    eth_sec->inl_dev);
 	return 0;
+
+err:
+	if (inbound && inl_dev)
+		roc_nix_inl_dev_unlock();
+	rte_spinlock_unlock(lock);
+
+	return rc;
 }

 static int
 cn10k_eth_sec_session_stats_get(void *device, struct rte_security_session *sess,
-			    struct rte_security_stats *stats)
+				struct rte_security_stats *stats)
 {
 	struct rte_eth_dev *eth_dev = (struct rte_eth_dev *)device;
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
 	struct cnxk_macsec_sess *macsec_sess;
 	struct cnxk_eth_sec_sess *eth_sec;
+	rte_spinlock_t *lock;
+	bool inl_dev, inb;
 	int rc;

 	eth_sec = cnxk_eth_sec_sess_get_by_sess(dev, sess);
@@ -1232,10 +1258,18 @@ cn10k_eth_sec_session_stats_get(void *device, struct rte_security_session *sess,
 		return -EINVAL;
 	}

-	rc = roc_nix_inl_sa_sync(&dev->nix, eth_sec->sa, eth_sec->inb,
-			    ROC_NIX_INL_SA_OP_FLUSH);
+	inl_dev = !!dev->inb.inl_dev;
+	inb = eth_sec->inb;
+	lock = inb ? &dev->inb.lock : &dev->outb.lock;
+	rte_spinlock_lock(lock);
+
+	/* Acquire lock on inline dev for inbound */
+	if (inb && inl_dev)
+		roc_nix_inl_dev_lock();
+
+	rc = roc_nix_inl_sa_sync(&dev->nix, eth_sec->sa, eth_sec->inb, ROC_NIX_INL_SA_OP_FLUSH);
 	if (rc)
-		return -EINVAL;
+		goto err;

 	stats->protocol = RTE_SECURITY_PROTOCOL_IPSEC;

@@ -1251,7 +1285,12 @@ cn10k_eth_sec_session_stats_get(void *device, struct rte_security_session *sess,
 			((struct roc_ot_ipsec_outb_sa *)eth_sec->sa)->ctx.mib_octs;
 	}

-	return 0;
+err:
+	if (inb && inl_dev)
+		roc_nix_inl_dev_unlock();
+	rte_spinlock_unlock(lock);
+
+	return rc;
 }

 static void
diff --git a/drivers/net/cnxk/cnxk_ethdev_sec.c b/drivers/net/cnxk/cnxk_ethdev_sec.c
index 614997bd3d..ac6ee79f78 100644
--- a/drivers/net/cnxk/cnxk_ethdev_sec.c
+++ b/drivers/net/cnxk/cnxk_ethdev_sec.c
@@ -354,8 +354,25 @@ rte_pmd_cnxk_sa_flush(uint16_t portid, union rte_pmd_cnxk_ipsec_hw_sa *sess, boo
 {
 	struct rte_eth_dev *eth_dev = &rte_eth_devices[portid];
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	rte_spinlock_t *lock;
+	bool inl_dev;
+	int rc;
+
+	inl_dev = !!dev->inb.inl_dev;
+	lock = inb ? &dev->inb.lock : &dev->outb.lock;
+	rte_spinlock_lock(lock);
+
+	/* Acquire lock on inline dev for inbound */
+	if (inb && inl_dev)
+		roc_nix_inl_dev_lock();
+
+	rc = roc_nix_inl_sa_sync(&dev->nix, sess, inb, ROC_NIX_INL_SA_OP_FLUSH);
+
+	if (inb && inl_dev)
+		roc_nix_inl_dev_unlock();
+	rte_spinlock_unlock(lock);

-	return roc_nix_inl_sa_sync(&dev->nix, sess, inb, ROC_NIX_INL_SA_OP_FLUSH);
+	return rc;
 }

 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_hw_sa_read, 22.07)
@@ -366,6 +383,8 @@ rte_pmd_cnxk_hw_sa_read(uint16_t portid, void *sess, union rte_pmd_cnxk_ipsec_hw
 	struct rte_eth_dev *eth_dev = &rte_eth_devices[portid];
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
 	struct cnxk_eth_sec_sess *eth_sec;
+	rte_spinlock_t *lock;
+	bool inl_dev;
 	void *sa;
 	int rc;

@@ -375,13 +394,31 @@ rte_pmd_cnxk_hw_sa_read(uint16_t portid, void *sess, union rte_pmd_cnxk_ipsec_hw
 	else
 		sa = sess;

+	inl_dev = !!dev->inb.inl_dev;
+	lock = inb ? &dev->inb.lock : &dev->outb.lock;
+	rte_spinlock_lock(lock);
+
+	/* Acquire lock on inline dev for inbound */
+	if (inb && inl_dev)
+		roc_nix_inl_dev_lock();
+
 	rc = roc_nix_inl_sa_sync(&dev->nix, sa, inb, ROC_NIX_INL_SA_OP_FLUSH);
 	if (rc)
-		return -EINVAL;
+		goto err;
+
+	if (inb && inl_dev)
+		roc_nix_inl_dev_unlock();
+	rte_spinlock_unlock(lock);

 	memcpy(data, sa, len);

 	return 0;
+err:
+	if (inb && inl_dev)
+		roc_nix_inl_dev_unlock();
+	rte_spinlock_unlock(lock);
+
+	return rc;
 }

 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_hw_sa_write, 22.07)
@@ -393,7 +430,10 @@ rte_pmd_cnxk_hw_sa_write(uint16_t portid, void *sess, union rte_pmd_cnxk_ipsec_h
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
 	struct cnxk_eth_sec_sess *eth_sec;
 	struct roc_nix_inl_dev_q *q;
+	rte_spinlock_t *lock;
+	bool inl_dev;
 	void *sa;
+	int rc;

 	eth_sec = cnxk_eth_sec_sess_get_by_sess(dev, sess);
 	if (eth_sec)
@@ -405,7 +445,21 @@ rte_pmd_cnxk_hw_sa_write(uint16_t portid, void *sess, union rte_pmd_cnxk_ipsec_h
 	if (q && cnxk_nix_inl_fc_check(q->fc_addr, &q->fc_addr_sw, q->nb_desc, 1))
 		return -EAGAIN;

-	return roc_nix_inl_ctx_write(&dev->nix, data, sa, inb, len);
+	inl_dev = !!dev->inb.inl_dev;
+	lock = inb ? &dev->inb.lock : &dev->outb.lock;
+	rte_spinlock_lock(lock);
+
+	/* Acquire lock on inline dev for inbound */
+	if (inb && inl_dev)
+		roc_nix_inl_dev_lock();
+
+	rc = roc_nix_inl_ctx_write(&dev->nix, data, sa, inb, len);
+
+	if (inb && inl_dev)
+		roc_nix_inl_dev_unlock();
+	rte_spinlock_unlock(lock);
+
+	return rc;
 }

 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_inl_ipsec_res, 23.11)
--
2.25.1

