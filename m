Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DC9C624DE
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 09:22:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5775F42E63;
	Fri,  4 Sep 2026 11:22:45 +0200 (CEST)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49]) by mails.dpdk.org (Postfix) with ESMTP id 57DAB42E63
 for <dev@dpdk.org>; Fri,  4 Sep 2026 11:22:43 +0200 (CEST)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7f84a55cc06so613546a34.2
 for <dev@dpdk.org>; Fri, 04 Sep 2026 02:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788513762; x=1789118562; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5D2BvfCsEikrXdv79pcuOJAfXkMXXmqb9pDVq2pVeAE=;
 b=n6+9o5pF/VbtF+QEAEgdhfk/3xAwJ26YxZSzNycZYwFx0jEE3ybFMVsE7patKTbAWc
 /XQp42zEBkfSD3W20YQh8ausDC3MQRWzSfHEg2Ffzlse/LsMkku0SMcNbqexS9RiiDOW
 0TezpufbfkrveMlsuYR/rgVsqo5yNvwzGLoh1IaQz8h4OwFJS/2Wi+7OBRAm3IRoGhlz
 SqPzGJmXg3kgp6P0/HL6/uMAz8Ir2fIC7NBfnDd57fK5iVsuJk3LLbc7Kg+ypSmaP4UJ
 uNgSi2CEGyQnQBdXbck6ohvA4x7g/sPhQKH/yIrUjY5X8KH3qHYHNAUMUBKrRBumYpFQ
 bVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788513762; x=1789118562;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5D2BvfCsEikrXdv79pcuOJAfXkMXXmqb9pDVq2pVeAE=;
 b=o4q3JJ0cY6+ANWvW0bAmZUl/8dFz4ruEtAfXso941exjD5461i8RYC8CXMshfe+LIl
 UtsMFgKyC7xQ0Baks07MUvtEbpTLPm9uUOvga69YnIDhoUWiXt3WHpbCg2+4VqeNR+xe
 7IsI4gmvp3XbHku2wq9j313K3Vp75rKx1BN8VQ9vmBDeo7U49lC/yp/EQ69Iunf/NFeI
 nsecpncPrJxtqLBt1/1Hgbjvb+nKrQUJuLcFOnkPmRCGgmMztVQsxbdG2bApBG7g41iz
 RdM5dpaRsAsytxm/BXFt/07XuAtLh3tAWH0QzjY+v/HHXxf/ZYAO7YbWejZpGHM3b1k6
 yTMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8KmigL2yGe+zrIMFfVt5X9/ZdDuUABT3YsBxfMVM8TjH9A/dBQwA/bdtwCpKN3LbimjA=@dpdk.org
X-Gm-Message-State: AFuF++mWLDJE/TIUqJEGWjWpQdTZ0JSl3XV/QhXtvSxecRJUcoaWRmzk
 P0sCd2adVebi4uYCWjWCd+7wGH+XLHAmIXxH/97BHR3sm/lQJeQynrnH
X-Gm-Gg: AYBFou2okngow15CSg0+GXDSApt8oZE0g1ivwBy/Gv2y3HplmWsEkSq5F78nKVO4hk8
 LjF5BNF4zysQPfOwjMzsfIXTx9pa8ErTQP5ZUTEhg7CE7Jd/Vbczen7KkiAUlkq56EmbV/EyuHL
 GB487jTAoAf4WHLmTL4SKS0old0ruhXD1YO+DzD0euQFuMNrcNd6rjzc7QTlbNyfgwl9WIduA2p
 9hpN9IL0EdW3chTkarnpUik60HLf7OWF4jj49XT9jT3L6d2je5bt+GyWtm2thH7lZ5T2P1CBgUT
 47a85FOUq6RGfWwSeOxZpLlu6f+ksU/ZyE0qBV9REZOYm8bs/8O5B4JcgzErtRmjbUIIhDdkUA5
 dj2Loo4p7flv11fnNZN6i/YWB/oO/uzabEJd7C+wk6MAfPX7NJJU+W8d2qKkayq33NvvTm696bL
 K7F3ttzu5wGWnHBrQ3PtSGTCv1UjPh34hIEItTry5gqGIGLy0hH+Wcqa4vw56ya4X9qPwE5WfoS
 J0FYRkXwBBBetWS5r86URcOqPntNhPTkgUzAA==
X-Received: by 2002:a05:6820:60b:b0:6b7:46fc:1d3 with SMTP id
 006d021491bc7-6b746fc0241mr1542531eaf.50.1788513762342; 
 Fri, 04 Sep 2026 02:22:42 -0700 (PDT)
Received: from amiya73TMT9m.aristanetworks.com ([49.207.230.155])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339885ca07sm5963590eec.1.2026.09.04.02.22.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Sep 2026 02:22:41 -0700 (PDT)
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
To: ndabilpuram@marvell.com, kirankumark@marvell.com, skori@marvell.com,
 skoteshwar@marvell.com, hkalra@marvell.com
Cc: asekhar@marvell.com, dev@dpdk.org, stable@dpdk.org,
 Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
Subject: [PATCH] common/cnxk: fix duplicate mbox alloc in NPA aura pool init
Date: Fri,  4 Sep 2026 14:51:57 +0530
Message-Id: <20260904092157.51040-1-amiyaranjan.mohakud@gmail.com>
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

npa_aura_pool_init() allocates the pool init mbox message twice on
non-CN20K platforms. The if/else block at line 106-111 allocates via
the model-specific branch, but the original unconditional allocation
at line 112 was not removed when the CN20K branch was added. This
overwrites pool_init_req, and the orphaned first message is sent to
the AF with uninitialized aura_id, ctype, and op fields, which can
trigger any undesired behavior on CN10K.

Remove the duplicate allocation.

Fixes: 143a419edf35 ("common/cnxk: use new NPA aq enq mbox for CN20K")
Cc: asekhar@marvell.com
Cc: stable@dpdk.org

Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
---
 drivers/common/cnxk/roc_npa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_npa.c b/drivers/common/cnxk/roc_npa.c
index 4a3e96a97a..87f7637e9f 100644
--- a/drivers/common/cnxk/roc_npa.c
+++ b/drivers/common/cnxk/roc_npa.c
@@ -110,7 +110,6 @@ npa_aura_pool_init(struct mbox *m_box, uint32_t aura_id, struct npa_aura_s *aura
 	} else {
 		pool_init_req = mbox_alloc_msg_npa_aq_enq(mbox);
 	}
-	pool_init_req = mbox_alloc_msg_npa_aq_enq(mbox);
 	if (pool_init_req == NULL)
 		goto exit;
 	pool_init_req->aura_id = aura_id;
-- 
2.39.5 (Apple Git-154)

