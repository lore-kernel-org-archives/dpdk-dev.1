Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F0AC79FB7
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 19:23:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72F4E41101;
	Wed,  9 Sep 2026 21:23:33 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 5A3D84067D
 for <dev@dpdk.org>; Wed,  9 Sep 2026 21:23:31 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1cea4bfb6so339849a12.3
 for <dev@dpdk.org>; Wed, 09 Sep 2026 12:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788981810; x=1789586610; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gsdxeYyBjvtY6XlJg33hYGqY1dOIKKP9FFpMeQSKkNE=;
 b=dIm7VntcyC74qL1DA+401mWIDq/e1NtVsnwkRyTSSSt0ez/ZAkeU+Fg6V1W/2ede0N
 F4zY1AmgW85qOvJF8XGvHzZP939lpVYyUWk0NLYsWnBsmzfT0q9Ooa4vbqXzIXbU59A0
 cusnPHF32RX9Y5XnM1sdAdgQEzP8JC2a5MzCGqC8xo1Kr2tJIoPBqLsAXPhOyENxCFZd
 NXWOovO7QhPAwjl0zpvOFExjSMooQv1R0/ZSZo9FAD8Q8gk0Bs4CTrNJq4+ypnYmEasE
 ieqIoMvgPiNoR0nTik32mUzdKqTZZF2ay7U1kM5UnQDbjMZMV5k6awwunqLHOXlerKjF
 N4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788981810; x=1789586610;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gsdxeYyBjvtY6XlJg33hYGqY1dOIKKP9FFpMeQSKkNE=;
 b=ix63ThEU7xCfoKnkG9d2ogZzZ7RdUcq17OIlJo4mMkBMyqRlTMpqwqQmVcCiAftUq8
 Kb+RCdM38hQXuKCbP/ALLx85qEiKFXiEdQogFng56wWi7ThkY0LJkQQExv/FF2tmm7bJ
 fo9EJOQv8vf6fpu5bJzURyl3Pb6Z3cse2RySXgqh0FKOzYNo4lrep1KSpcv9UPlMgkFk
 6P9m0XnWgwbUWWj+oP/m9//4KeQDle6nJidtWuoDm7Dma1zXFjrhKQnQuZml6BmZKU7p
 2tnXwIZBRIU9I/rbeRUQASj8r1Oo70/FX23pLFRXpLllzoicFpfvJi0KEO4bXJWkxUF4
 YeiQ==
X-Gm-Message-State: AFuF++nJVIhpzS7N6OytfrfO3XCNY3gzPsiDDRgxegjV6SVXMvHMJWG1
 Q+f+sQvScC6Qadel5P0luox/4ndplxj9vj95ODpfcaPfqvaq0pv7apzbcQ9/GRUg
X-Gm-Gg: AYBFou3nW2pSHPPHUW/1HoptDe+W457Z/1jLwGvFtiatlQn3o6r4E3y4Nh26eQPR/AZ
 aqWGImWy1kEqz0P4sSwY7DVQQJMSXgtuu3YVkuvmnvfTf1meARcchDhh2SrED6z8bz46XwsAEpz
 rgtKmBJrTS3nhTXLleX2c50N4WG1ya6qxo73ZpIQow5x00D39JfdjoSgdu40GBTkwUWtT8S/NQm
 nng3gzCuXx22NpxzaRczXtV2LGGsM+tHw3qsXhx4dLIuKhqtPDyWqp0MdJ+cFEf5ln+xvJ4e03X
 6XoQcPbsfLkAZXwLhbLMxqOFo1maoOPRSILa46LDP0a+dFNOoBOP9SkiIqtXC0h145q5e2CT4yk
 sJQvQ6WyvChHYuEkJYf8T9o+aBQTYrlCTVtum2ZPBxkw+FJuSp8el/irLbW6BM6fudm4IXtGbsL
 /smAcUNyAvC6dVWD5l4uyvavBZMwCcdWbwIx2J2VPfikSIYwYsOZ9i4UIZ7q88wM9uycsPOKphz
 jxw+RPSoj4KK1rasfDyXePT9bcG42S+eajQj7SSubEXX0qy
X-Received: by 2002:a05:6a21:3a96:b0:3d3:adbf:7783 with SMTP id
 adf61e73a8af0-3dacbf3e1b5mr5072335637.24.1788981810242; 
 Wed, 09 Sep 2026 12:23:30 -0700 (PDT)
Received: from amiya73TMT9m.aristanetworks.com ([49.207.230.155])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3369856a9f7sm25989435eec.5.2026.09.09.12.23.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 09 Sep 2026 12:23:29 -0700 (PDT)
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, ndabilpuram@marvell.com, stable@dpdk.org,
 Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
Subject: [PATCH] common/cnxk: add NDC sync after NPA aura pool init
Date: Thu, 10 Sep 2026 00:53:23 +0530
Message-Id: <20260909192323.26886-1-amiyaranjan.mohakud@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

After AF writes aura/pool contexts via AQ (AURA_INIT +
POOL_INIT), the LF data path reads them through NDC.
Without an explicit NDC sync, the first MMIO aura operation
(e.g. roc_npa_aura_op_free during SQB populate) can hit a
stale NDC entry, causing NPA_LF_ERR_INT[AURA_FAULT] (bit 12).

All teardown paths (npa_aura_pool_fini, npa_aura_fini,
roc_npa_pool_op_pc_reset) already perform NDC sync, but the
init path was missing it.

Add ndc_sync_op with npa_lf_sync after successful aura/pool
init to flush NDC-NPA LF entries before any data-path access. Skip
on CN20K which does not use NDC for NPA.

Fixes: 124ff1a4cbb3 ("common/cnxk: support NPA device")
Cc: stable@dpdk.org

Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
---
 drivers/common/cnxk/roc_npa.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/roc_npa.c b/drivers/common/cnxk/roc_npa.c
index 4a3e96a97a..6339873638 100644
--- a/drivers/common/cnxk/roc_npa.c
+++ b/drivers/common/cnxk/roc_npa.c
@@ -85,6 +85,7 @@ npa_aura_pool_init(struct mbox *m_box, uint32_t aura_id, struct npa_aura_s *aura
 	struct npa_aq_enq_req *aura_init_req, *pool_init_req;
 	struct npa_aq_enq_rsp *aura_init_rsp, *pool_init_rsp;
 	struct mbox_dev *mdev = &m_box->dev[0];
+	struct ndc_sync_op *ndc_req;
 	int rc = -ENOSPC, off;
 	struct mbox *mbox;
 
@@ -128,10 +129,33 @@ npa_aura_pool_init(struct mbox *m_box, uint32_t aura_id, struct npa_aura_s *aura
 	off = mbox->rx_start + aura_init_rsp->hdr.next_msgoff;
 	pool_init_rsp = (struct npa_aq_enq_rsp *)((uintptr_t)mdev->mbase + off);
 
-	if (aura_init_rsp->hdr.rc == 0 && pool_init_rsp->hdr.rc == 0)
+	if (aura_init_rsp->hdr.rc != 0 || pool_init_rsp->hdr.rc != 0) {
+		rc = NPA_ERR_AURA_POOL_INIT;
+		goto exit;
+	}
+
+	/* CN20K does not use NDC for NPA */
+	if (roc_model_is_cn20k()) {
 		rc = 0;
-	else
+		goto exit;
+	}
+
+	/* Sync NDC-NPA for LF to ensure the new aura/pool contexts are
+	 * visible to the data path before any MMIO aura operations.
+	 */
+	ndc_req = mbox_alloc_msg_ndc_sync_op(mbox);
+	if (ndc_req == NULL) {
+		rc = -ENOSPC;
+		goto exit;
+	}
+	ndc_req->npa_lf_sync = 1;
+	rc = mbox_process(mbox);
+	if (rc) {
+		plt_err("Error on NDC-NPA LF sync after init, rc %d", rc);
 		rc = NPA_ERR_AURA_POOL_INIT;
+		goto exit;
+	}
+	rc = 0;
 exit:
 	mbox_put(mbox);
 	return rc;
-- 
2.39.5 (Apple Git-154)

