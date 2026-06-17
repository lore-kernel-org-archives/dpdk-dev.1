Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F325CCD98E4
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 13:43:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F393F4027F;
	Wed, 17 Jun 2026 15:43:06 +0200 (CEST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id EF5D440276
 for <dev@dpdk.org>; Wed, 17 Jun 2026 15:43:04 +0200 (CEST)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-490b1c39fe4so3713845e9.3
 for <dev@dpdk.org>; Wed, 17 Jun 2026 06:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781703784; x=1782308584; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DYLgYaib7yCVbYE8N902Pt92KxmyBMs3Rdxe7FOOjwY=;
 b=qA1ffGBHsrYRGQ5e9AAcDnbzoKA3/9C1MyNXme/fLWj3aexH9/mjSvsXETPIJ3kwdJ
 +YpVZ6Obbn1OUklqtATZ6ZjkvL9h9z1qC+88ZA66Grr5qIo/V+/xblWVSLsSvJsy194T
 P2ZY5VF4rUFVEceUqq0u8rNx28eNnLuMqDUjH/jiGLpGF/atwipKMyWwu+rMJj+CXvfo
 ou3fEvJJsRtEaK8evUdVVBldzBxOP+Oppc9oECKkuvGNa1NluE1Hs8cfA4aosiQRgXvH
 v4yUlLOd+hD0aUBTfVQtJI3LnL3t2rEzbs9ELgwJYq4pWrfKHTDLispW5tI5/rZ6z2KP
 zUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781703784; x=1782308584;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DYLgYaib7yCVbYE8N902Pt92KxmyBMs3Rdxe7FOOjwY=;
 b=Zxx243NfzY/N7QM3EjT9D4acJugq0avXk4dnnaAJB5c0raElAxrOI+BdqQgvIKxG1N
 7FVWHmtUtSLAhu0p/HwCerHzGN2z1aHY+yEDja7Wqw4pUslP8aV51gIZxscJhN/plqFp
 Aej2pBGTQ7lEqJAr0ZXyvtgvLojdWa4/QjD92MgOJ0PpYZq0mVnaHYTem02gDyk28WUq
 JJz0IyedckN+u7ZK5V/+4uamMSPPCht0EYKOY3/z5plXoFfO9RS+EdRuygUsnalWZ58J
 tFib+aS1wjiWbfEDF+V+5tWxCgddee1vc4j77bYAf4/OK3xVftKo4+IhSNIdPLwhT25A
 VZxQ==
X-Gm-Message-State: AOJu0YzrFNfxHSWoz7VnIoU5fpkaJJ5tpRkDAwvXX/0J3BVbOpUy66BP
 3LlfOxOvh23eOD1c5/IF6uHGRVXPbk3JeORonAchN0tU19vAgCJ7L4/e
X-Gm-Gg: Acq92OGOuZiWIowlduF56GjwkY6hqssCpaz6g/ULfDwVElrN6Ktq9QZDLkjEzcdtFKz
 kuP22rggJJ6hgfu84/BVNTgJ81FwMIhsBEa/853JO5mdCIKl6pNFpBnFzJ/3Fs0darbNMa2DuME
 6qfmB2dOnzyOKK7mNlELitLIoM1CyBilyE4iYv4bZOofvTcwSAxy5mz048zzmIFYISHgWHmgmq0
 QC1CR8EbeKT8bEuE5yC1aqGUMgHw+UsWmE2xnwuBHxtH+fuQR6kHVymGQmK5zZao+5cYm91sAD/
 gb6p7tVzV5MUkt5fUjG5hIfecneSqfyJa5QEbIIJ3UtKUNVt6tIvXH7A/0LKphNfThTKFJYdNif
 Fg4AIC6h/wwEqpxT7yHkSv8fd1lhbCjVBUAyww4hQzuamEopC/gbHhsPLWbVJQbXCejZdXS7aFV
 ybbmbzwq/1zfmBqFqv7v/2d7S9M5gy+KpHpz56tLjEWPdM+CC9+OgJqSTYYg==
X-Received: by 2002:a05:600c:19cd:b0:490:ade7:9ca4 with SMTP id
 5b1f17b1804b1-4923339f546mr34486715e9.2.1781703784377; 
 Wed, 17 Jun 2026 06:43:04 -0700 (PDT)
Received: from tsyrulb-Lenovo-ideapad-S530-13IWL..
 ([2a00:a041:e3c1:6100:975d:4242:f7c4:c21e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa3a4easm180755645e9.3.2026.06.17.06.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 06:43:03 -0700 (PDT)
From: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
To: Thomas Monjalon <thomas@monjalon.net>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Alexander Kozyrev <akozyrev@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
Subject: [PATCH] net/mlx5: fix double free in vectorized Rx recovery
Date: Wed, 17 Jun 2026 16:43:01 +0300
Message-Id: <20260617134301.798213-1-tsyrulnikov.borys@gmail.com>
X-Mailer: git-send-email 2.34.1
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

During Rx queue error recovery, the vectorized path in
mlx5_rx_err_handle() reallocates an mbuf for every queue element. When
rte_mbuf_raw_alloc() fails (for example, the mempool is exhausted), the
rollback loop frees the mbufs allocated so far, but masks the element
ring index with "& elts_n" instead of "& (elts_n - 1)".

elts_n is a power-of-two element count, so "x & elts_n" isolates a
single bit and can only evaluate to 0 or elts_n, regardless of the loop
counter. The rollback therefore never frees the mbufs just allocated in
this pass (they are leaked); instead it repeatedly frees elts[0], a live
mbuf still posted to the NIC (use-after-free / double free), and
elts[elts_n], the fake_mbuf padding entry used by the vector datapath.

Mask with the existing e_mask (elts_n - 1), as already done in the
matching forward allocation loop just above.

Fixes: 0f20acbf5eda ("net/mlx5: implement vectorized MPRQ burst")
Cc: stable@dpdk.org

Signed-off-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
---
 .mailmap                   | 1 +
 drivers/net/mlx5/mlx5_rx.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 4001e5fb0e..0b09243c45 100644
--- a/.mailmap
+++ b/.mailmap
@@ -222,6 +222,7 @@ Boleslav Stankevich <boleslav.stankevich@oktetlabs.ru>
 Boon Ang <boon.ang@broadcom.com> <bang@vmware.com>
 Boris Ouretskey <borisusun@gmail.com>
 Boris Pismenny <borisp@mellanox.com>
+Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
 Brad Larson <bradley.larson@amd.com>
 Brandon Lo <blo@iol.unh.edu>
 Brendan Ryan <brendan.ryan@intel.com>
diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index ce50087b70..c0ad8d6701 100644
--- a/drivers/net/mlx5/mlx5_rx.c
+++ b/drivers/net/mlx5/mlx5_rx.c
@@ -662,7 +662,7 @@ mlx5_rx_err_handle(struct mlx5_rxq_data *rxq, uint8_t vec,
 					if (!*elt) {
 						for (i--; i >= 0; --i) {
 							elt_idx = (elts_ci +
-								   i) & elts_n;
+								   i) & e_mask;
 							elt = &(*rxq->elts)
 								[elt_idx];
 							rte_pktmbuf_free_seg
-- 
2.34.1

