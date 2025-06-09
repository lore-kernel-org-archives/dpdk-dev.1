Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A064C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 07:24:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6002D40661;
	Mon,  9 Jun 2025 09:24:29 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id E4EF9402E3
 for <dev@dpdk.org>; Mon,  9 Jun 2025 09:24:27 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-23602481460so21560165ad.0
 for <dev@dpdk.org>; Mon, 09 Jun 2025 00:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749453866; x=1750058666; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ygc5JVB4LfSCkuK49TjdnmUj5MS8Er9Zm/44E3in85Q=;
 b=QxgZM58NN40+wnKL+MjsX7OwyHWXpKAa2SxHvSby4uRDbelo1z7pzWWSKBYcm0Fn9i
 nGcOoeAaY0CB35u5PqVtzIr17gTfsCp9A2UABroAPAQLcBIG40hT1qBaBm4JbZiWBtzS
 ABoVE2ejLZ5Z0QoVKhKuRUkxjeRmVN9naVyjd/sG8kx9f+6y6hiX+MJ9zzFBEbbyDxB4
 xBOqn18u4sXXs417BIu4eKa7qQ9wpe/9DIrKawpVzNyjcXEyUnYnElxgvuK3UmODV+Rg
 x6d++hq7C5uM92nFuWZ2RbSgA0M3pSZXMeFLEwwnWhdhzjh8Nw1Jd599LLAp5ohy/Sbt
 WdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749453866; x=1750058666;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ygc5JVB4LfSCkuK49TjdnmUj5MS8Er9Zm/44E3in85Q=;
 b=WVKlGTc1p2xZ26tXtkAnNAMWvQjRxXGo3kXPZvipJZscpEJ/N39EfsVO7SEX/n7oJ8
 5HL5KYOV2Y9kW+qfn3EkPMwlZPG733AjJhltrvQFX7/JXRlUInLsa8zfOIMdOAY6srv2
 6k77beydRmZgykWjhI4mT3fFY08UnWP26nkgLJbV99Gum3MXCC7eStgomF63bJ87jSJG
 77SQCxh5aarNUjkms64eBAnevQYYmryt14/Pic62C1HfCEoy66wkvmW+65GOKiKlbPT8
 Nf8vt8l1Spvthq8AISBFQ4+N364SBGOXixZpRa3HtIkaMSTT4dIuR3yX2wZUHK+3+Kya
 FNbg==
X-Gm-Message-State: AOJu0YyEEE1J4pbLOBkgW66TDhtLoQX2FH/aFNdYlY+UZCHsKtrgzQhl
 WIVZvTgPeEP+P6lUpED0Y/gPbTx43BWfgAMZWEnAoCW10TD52KwhlffZtmQ2lLtvBrw=
X-Gm-Gg: ASbGnct+teF3qtPUellsgMhOIz4UBBq90CXJIau5IfLEwq3aLqZG/SElDVNNIWp/5uV
 zFuhKWkScXoagmF5rBSvix4g6+z4pNPpqnvAWRJ0azevA0yNxAS86SnpAFdwiuYosPADTPULqV4
 yWfjoNAICPaAi8+MDccpf7aUeoLdzrTy36u2+hVmnjy1GMkTUDzPEnJD1sfb1qC1FQDJ0xfy3OU
 Tww/HTbOlufByOKbTE+SvDxPyChEnNXBUAdaU0Qk8R+BIfNohi0Tp8zIP/cChBVBJu4Vgdulv+O
 IrBeG/RpBuTpfabI3gtZA0rEtXIHcNxa6J1uhVv0U4UJO11uv+bT7ofGNkGnWx7we5NZ2rin4ZI
 WyaIAZNBaUT/XdMkw02QWj8o=
X-Google-Smtp-Source: AGHT+IFKB+oIUBLe7Ui0ux8ykYNS0vje4pajf2juvaENsBUEDl/MDswcZM31EXRr5zMC0d8ItHgvjQ==
X-Received: by 2002:a17:902:dac5:b0:235:ea0d:ae23 with SMTP id
 d9443c01a7336-23601cf0a33mr122693835ad.6.1749453866474; 
 Mon, 09 Jun 2025 00:24:26 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.35])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-b2f5f892f57sm4690735a12.66.2025.06.09.00.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 00:24:26 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: dev@dpdk.org
Cc: Hengqi Chen <hengqi.chen@gmail.com>, Baoyuan Li <updoing@sina.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH] net/virtio: Fix check of threshold for Tx freeing
Date: Mon,  9 Jun 2025 07:23:47 +0000
Message-ID: <20250609072347.1748785-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.5
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

Like most dirvers, make the fast path of virtio_xmit_cleanup() behave as
described by the comments of rte_eth_txconf::tx_free_thresh ([0]):
    Start freeing Tx buffers if there are
    less free descriptors than this value.

The rationale behind this change is that:
  * vq->vq_nentries is set during device probe with the queue size specified
    by vhost backend, this value does not reflect the real nb_tx_desc
  * the real available tx desc is set to vq->vq_free_cnt via the nb_tx_desc
    param of rte_eth_tx_queue_setup() API
  * so `nb_used > vq->vq_nentries - vq->vq_free_thresh` could never be true
    if say nb_tx_desc=2048, vq->vq_nentries=4096, vq->vq_free_thresh=32,
    see bug report 1716 ([1]) for details.

Bugzilla ID: 1716

  [0]: https://github.com/DPDK/dpdk/commit/72514b5d5543
  [1]: https://bugs.dpdk.org/show_bug.cgi?id=1716

Signed-off-by: Baoyuan Li <updoing@sina.com>
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 drivers/net/virtio/virtio_rxtx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio/virtio_rxtx.c b/drivers/net/virtio/virtio_rxtx.c
index edecd2011f..ab97f03d7d 100644
--- a/drivers/net/virtio/virtio_rxtx.c
+++ b/drivers/net/virtio/virtio_rxtx.c
@@ -1873,7 +1873,7 @@ virtio_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 	nb_used = virtqueue_nused(vq);
 
-	if (likely(nb_used > vq->vq_nentries - vq->vq_free_thresh))
+	if (likely(vq->vq_free_cnt < vq->vq_free_thresh))
 		virtio_xmit_cleanup(vq, nb_used);
 
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
-- 
2.43.5

