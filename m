Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DCEC44508
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Jul 2026 12:48:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A83240A77;
	Wed, 15 Jul 2026 14:48:29 +0200 (CEST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 6C45540A72
 for <dev@dpdk.org>; Wed, 15 Jul 2026 14:48:27 +0200 (CEST)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4758b2a9e2aso3353009f8f.2
 for <dev@dpdk.org>; Wed, 15 Jul 2026 05:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784119707; x=1784724507; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q+uZt2xUrNapfVLGpbsGsEMYU9IIap//TeTj7bP556A=;
 b=KrW0l45KSUqpwpw2vrhQ/D6RkmWtFp1lisA3DqpTwmZ3QEar+O2tP5fZtj9jtlE+Gk
 GC39BJybc2C96IAJfxtJGFkUuynbvU1kpkGPmqOeN3Ro6JzF9aC8oM1cWEFJuEJN7chI
 HiJ4WAdXgbSB6S2Sv0X9wTxrkZPEcMBAfgFUQrHj8ejKgcOX1e4jp8rzLjO3jfx9Djvp
 X0McWxhLKzkH9z+3B47GR2xoW5xjMLJ4IObHMOJEEddTUVx1yk5wOTPsWAIJoqXpEZAr
 NUWDJdF/Dmfyh1SW9ZxvXbte2vIyop5fo93U/Y59kMzsdVd0/1jqV8xcVfK860Lt719i
 rv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784119707; x=1784724507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q+uZt2xUrNapfVLGpbsGsEMYU9IIap//TeTj7bP556A=;
 b=cuXBJZjgLBrHiiBORvyH5uoXs1gP84XAa++7h62tpPIEmr0IsiBVyLlh5qeawOKODy
 rJtNlf+/dmZyYtaVTLzurgRyDP3XdaTmK4wmHr2BPH5tWY6jhQavxh0MIxD+i+LWsLwl
 SGuQesZiqnlqxv7MG7mNPzovRoRvN5aictgTdyfhqjjMOzZMppojGqpaGxQKyhae+yyF
 3Qc+oaHHfctNENB+GXvUiWSz1u+eG6y0MxoKWixAJkGqg8M65jOABhImKtXAF4vPGFmH
 C8eUrT/4V2a91uOKxKKCjvvytrHkZfMz1TFsWzA4lgfp4qAHx3VRRmzQxAWpYWVuYrzz
 BmLg==
X-Gm-Message-State: AOJu0Yy+b78IQ4wIDio+6FpvMU9zmKgbQ60/YwYAnPRlMP4kSghJuUec
 xZXuOBRnnZ+ZsLZ24QQH34P7UGlQqnVofkeclgxGp32/4a4bTtHoo+K6SxGsrzS0Srg=
X-Gm-Gg: AfdE7cl5mIssy12yfUX9ju8tESk+Y/cH8tb7MnNxQAkcQomqcUpsCTrWjKJNNDsvxNd
 hb9SKh57o/RW+6rU7Btb3Fc/deaFGr/fErq//7FI+frTeh73EF+jv9h5UqtPtKYoXoAWvK7T2Vt
 xGr3IU2h1qhTKaf7t5/HmD3vPhZqX0tK1jg10hwGf0WzCOJ9Up8DSf93czB4ZB1xhIv0kP49Tv2
 34u32BPjtxOljzQD62FzQ/ok5lNMAViR6thfXwROs+T7XyDxcMuJ6gWt7/TXH+/ELyVnTtKCVeM
 pq9UgRDTuJ5ZYARSmqQsdr1O7+O6SdsJjRw0AciAJ4Krx7Me4hNLYiXcNaWLYtE6l5dMzUN8A9p
 53K1sZSBABWk6poaYGFls/Tnv1MBA4UO7DgOWYfyDxsbZNrc9Zzno89riwcGvxHrzkV7jG8JyP+
 1w25hcFdOEeRF7NYnNFzEhq6eW+p7Y2nX52N/erl5F5SAmdfCqKCpvMvikN/ETTM9p6qXiKmL/f
 n0Gd/ogw3br35Qw3Q7RZigQyz2kQMlzT/FwBUY3c0GwULwuSSZDnTtXr28Ch6I=
X-Received: by 2002:a05:6000:2510:b0:475:f0c2:5b01 with SMTP id
 ffacd0b85a97d-47f488dfb44mr7746950f8f.55.1784119706950; 
 Wed, 15 Jul 2026 05:48:26 -0700 (PDT)
Received: from ll-cherrati..
 (2a02-8428-106e-2001-e626-cafd-02ee-1254.rev.sfr.net.
 [2a02:8428:106e:2001:e626:cafd:2ee:1254])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c30a9sm15651854f8f.31.2026.07.15.05.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 05:48:26 -0700 (PDT)
From: Sid Ali Cherrati <scherrati1@gmail.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Sid Ali Cherrati <scherrati1@gmail.com>, stable@dpdk.org
Subject: [PATCH v2 2/2] net/ixgbe: fix return value of close operation
Date: Wed, 15 Jul 2026 14:48:16 +0200
Message-Id: <20260715124816.19882-2-scherrati1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715124816.19882-1-scherrati1@gmail.com>
References: <20260710134639.108129-1-scherrati1@gmail.com>
 <20260715124816.19882-1-scherrati1@gmail.com>
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

rte_intr_callback_unregister() returns the number of unregistered
callbacks on success. Since the close operation started returning
the ret variable instead of 0, this positive value leaks as the
return value of ixgbe_dev_close(), so applications checking
rte_eth_dev_close() != 0 treat a successful close as a failure.

Use a separate cb_ret variable for the unregister return value so a
successful unregister never clobbers the dev_stop() error already
stored in ret, and stop retrying once unregister fails with anything
other than -EAGAIN, since those errors are not transient.

Fixes: 62024eb82756 ("ethdev: change stop operation callback to return int")
Cc: stable@dpdk.org

Signed-off-by: Sid Ali Cherrati <scherrati1@gmail.com>
---
v2: use a temporary cb_ret variable instead of unconditionally zeroing
    ret, and stop retrying on a non-transient unregister error, so an
    earlier error is not lost or masked by a successful/failed
    unregister

 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index c5010f623c..9433515b85 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -3095,6 +3095,7 @@ ixgbe_dev_close(struct rte_eth_dev *dev)
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int retries = 0;
 	int ret;
+	int cb_ret;
 
 	PMD_INIT_FUNC_TRACE();
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
@@ -3118,14 +3119,17 @@ ixgbe_dev_close(struct rte_eth_dev *dev)
 	rte_intr_disable(intr_handle);
 
 	do {
-		ret = rte_intr_callback_unregister(intr_handle,
+		cb_ret = rte_intr_callback_unregister(intr_handle,
 				ixgbe_dev_interrupt_handler, dev);
-		if (ret >= 0 || ret == -ENOENT) {
+		if (cb_ret >= 0 || cb_ret == -ENOENT) {
 			break;
-		} else if (ret != -EAGAIN) {
+		} else if (cb_ret != -EAGAIN) {
 			PMD_INIT_LOG(ERR,
 				"intr callback unregister failed: %d",
-				ret);
+				cb_ret);
+			if (ret == 0)
+				ret = cb_ret;
+			break;
 		}
 		rte_delay_ms(100);
 	} while (retries++ < (10 + IXGBE_LINK_UP_TIME));
-- 
2.34.1

