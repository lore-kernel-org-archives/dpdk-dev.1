Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334F9CC6B0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:36:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EAA640C35;
	Wed, 14 Oct 2026 00:35:14 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id F15B1406B6
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:12 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2db710396ffso31185005ad.1
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930912;
 x=1792535712; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cd2ZaDFNTVmRhmn3FmQVWsFaq3/lXlpgh+Csh2aFOL8=;
 b=X1MRUz6pcsFbiZ6z1f3sfc7uMm7UlSucyimr5JyFvkcYFSiMRO6wBXt/q42/YM7KYd
 lL+403/BSJ+bfuQdMhoDmxw7ObaL/UZcMZQ5wbbJMbmUtUjhXGj4l/lFg0J6ZXCf3NQt
 TDfq6iADRwPcwBrf0/i0fAuZggzt2eMsHzlkVunte3dglrzHOSQYJ/24N3hLdr6vvS6O
 uGpgxh/lRAHKFwwM+dS/kz0vvki5zD2yP9suHshlpjM8df+mYSzL2lGMk9IUICiq5YX8
 2IZjxPFYu6XVONeHP48qm+WtNKVJ+ZysX/QqRDZb3LI1kRsNbfFciUhlGcVIeOuskzTC
 guVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930912; x=1792535712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cd2ZaDFNTVmRhmn3FmQVWsFaq3/lXlpgh+Csh2aFOL8=;
 b=FuvFdVznEESO+LZZ6Asq+UdIb2eG/u1oN3nMGhb239qBPSIgVi9kMkrZ39NLxhVpMW
 b6y+PO6C8gcYqsUwAyzzJubQWQWY4K377OTWZj8cgM5L4zlBUNJk6E9g2c4l75y16omP
 30yxc1JRYOqJV+ctiEhPYx7Cf0BHRBsArWEnGM9Hd9F+fUXd14ckIw2guJbtL6Aa0/kD
 yRRBzsTgsegq2FCfRV43tjje1PRRv/9ss77+5RCqg83Ultu17uIlLKCW9WUoqHBw0imd
 FBFXbtPNHGkTEg2NhhUZadeOLj3Bi+uytD/aRQ+izcp3Pl7ARunuGGZ/Zxo4iK9AW0dx
 H8xA==
X-Gm-Message-State: AFq9FYKeln7qTjRJgcw2gEs5lH34kN+kRuzR4Ss92/F2OX28IYg+xj7p
 bLfLCxRCGDMEXvnXe1TxkYN74V9bmcvFh/YIsKow53YanL/XH6ieHsSZOLI0okAN9ez9yKoNw+p
 CquQH/Ms=
X-Gm-Gg: AYBFou0zgo5HIe76vjQP+sACPNNAEhP3wXmX2dsOC1S4uEM0LGp7pmqZoh3w19TqQOf
 OM0A3nDd5e+BxaMKTmauGP8I5uqqQoDz/w+lAd9zfWehj/6ksoClps5YJ+S3JWqf8jUXTXaoZRa
 LODWTwYI2eZlGmUp3jFljE7gj0ipvDhTBqeaZ9yoZzwwH/7wNs7zfMySvaV72pDPlrZAsGqSN5I
 oQgWYHKxt6PDJnEgos98EgSGX6S+/0BATU0wNacKxAGigIQMF4eTrCsMlxmoEZvYdTWyI55l2Jq
 ZiR4Yqwywag95UwNX3TsZnkTToR37tUf184pF4L+nXwrxSgXQ+Fj8Pta3xmuH47cXNP9hIaox2p
 QanntUU/MUIt9tIJBa00SWVmfTwy2hqJI+6Ir5zI4wJMoj/STDekpexJwIXcjjGd9XaXsZsK5GA
 M55NIrFsCxBoA6hipR6wYDFA19+JjDzIrGwsaq/LS4SMUOwk5YyyeQVgvEKKPDrES8CT7imhk3w
 dRR+vteEH2TwkLJ530AyZyhzq78TZQdkAOtnHs=
X-Received: by 2002:a17:902:d50a:b0:2e5:d6a0:c95b with SMTP id
 d9443c01a7336-2e8404d5079mr93330535ad.17.1791930911799; 
 Tue, 13 Oct 2026 15:35:11 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:35:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anoob Joseph <anoobj@marvell.com>
Subject: [PATCH v4 16/29] crypto/octeontx: use IO barrier before doorbell
Date: Tue, 13 Oct 2026 15:22:29 -0700
Message-ID: <20261013222410.2257622-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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

The doorbell is written with rte_write64_relaxed(), so the barrier
before it is what orders the queued instructions against the device.
That is device ordering, not SMP ordering: use rte_io_wmb().

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/octeontx/otx_cryptodev_hw_access.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/octeontx/otx_cryptodev_hw_access.h b/drivers/crypto/octeontx/otx_cryptodev_hw_access.h
index 3104e6d31e..096dcf8f87 100644
--- a/drivers/crypto/octeontx/otx_cryptodev_hw_access.h
+++ b/drivers/crypto/octeontx/otx_cryptodev_hw_access.h
@@ -203,8 +203,8 @@ static __rte_always_inline void
 otx_cpt_ring_dbell(struct cpt_instance *instance, uint16_t count)
 {
 	struct cpt_vf *cptvf = (struct cpt_vf *)instance;
-	/* Memory barrier to flush pending writes */
-	rte_smp_wmb();
+	/* Instructions must be visible to the device before the doorbell */
+	rte_io_wmb();
 	otx_cpt_write_vq_doorbell(cptvf, count);
 }
 
-- 
2.53.0

