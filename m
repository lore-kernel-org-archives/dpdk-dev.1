Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5196CF0182F
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 13:32:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D543427BC;
	Fri,  6 Mar 2026 14:31:15 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 6839A427BC
 for <dev@dpdk.org>; Fri,  6 Mar 2026 14:31:13 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-48373a4bca3so58369535e9.0
 for <dev@dpdk.org>; Fri, 06 Mar 2026 05:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772803873; x=1773408673; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mlxL3PyZ+IosztdC/qDp4aeYkPKebNr5Kl9kpF4TIvA=;
 b=SShrVtUIJ693EQwgOWnD34CW3RbdqmNaVKCV3zzu6oaMoKG+8wrS5YQ0Al9NeGR9Mx
 IXn0DMVbttwqjTdqvbD0NMAuyZNPFzWfTIYKaI8JKT8EwqG8TVsNyWQxTGd67hypF+kL
 BsI4reWB//D/flWUk0T96mMh+aZoXWwEL6PiTrDR2pLxBctv/QYXGcH0/wgReSBCcs46
 VdL43H4xneMnMc3cVFKbHifnwKtVrTHrf8Y4LOqSHR1hpnhTu75l4w61Gutof5RojloS
 yEZGENwxT5HMmEbyJTSeEspD3b3CLUvy26ni0oHoZENSRnbfESqUcpkMS+aQaTp2Oo+8
 m2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772803873; x=1773408673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mlxL3PyZ+IosztdC/qDp4aeYkPKebNr5Kl9kpF4TIvA=;
 b=oZCMWdwaUgwP5BmLv3LamgnQ6sh4aLar1k6dl4cCjSVGSgKSjj/pIZOxgyaLrqGfXR
 Z862RjqjJ0fL9ds9xejd7CPst3rwjkbAdfbpT8dtk8PNmQGxp2I8OzHY/rgMo5K1vryQ
 KoRoA47fQVwg1z5AOhBqmborfQNzRRdffDkmltD325djUr2Js+ZDLS/VL/MV1dzonV1T
 9qROM2WZmrhoXZaJeTHGMUS7iFplLJq22u0mPgjNcZAWs5c2VepKZEmQzufNR94/a9SN
 rVnU8GpuHPQ8vgnTjp96lA65Zm+5k3a4L5tQ4rhdJz90mNZXIrXEgbK1mVr5R9qrW8Gl
 mUqA==
X-Gm-Message-State: AOJu0Yx3PIT4JcgpR5a5bV5wf522fIIQaPLaH/foB7z2sV7DeuqRwKrP
 +/gGmU1oS90a7nKjZT36s2cPHRi9YhO+3uRurM9ydAHLPbAYei5gOefcqXmAd9oT
X-Gm-Gg: ATEYQzwe6OM071evP9GX5MBIXnY61v7Ar5m4OgWNVad+Fh9OUqNa76ZgogY7AW8HWwS
 Tkn154ZoddqGbHkHa8fT49aewFQbE+luwd+uC+n9KvdJ6r6p4osCMSccDceKqmRQGVZapwJzPSK
 2RIY9a90Ky5229DRf7LtFjDQsxniOFoa4eiFi+y/YDzL5X052na1dc8A3s/Pu0WFBBAY3qrwQxV
 N6jn06mTZ/qPcgwJejQoEyXxyU9/rVYYsBZPI5+0obW5e2jWE6oAPnlgaEYJ6oDGQCiMHTIaW7o
 bwFQe4g2CP3aaiOsNlHdhPfp7h3pTarwHICsgYYD0GierGc2Dg9f/raDOB4nGbLMpUT1qaYP6+l
 V++3ciarBVLWCYN+37FXS6BuEF1Mab5YIkm7lqygXchUk75FKDEGiEmvd5w+D51slhpK2enakbZ
 MPwLnrRnQcxZfzbx8iluzL9qKUxXo=
X-Received: by 2002:a05:600c:608f:b0:480:426e:9d38 with SMTP id
 5b1f17b1804b1-48526967adfmr32684145e9.27.1772803872846; 
 Fri, 06 Mar 2026 05:31:12 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527681e3fsm34315685e9.6.2026.03.06.05.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 05:31:12 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v3 13/17] net/dpaa2: add SG table walk upper bound in Rx path
Date: Fri,  6 Mar 2026 14:30:31 +0100
Message-ID: <20260306133035.179709-14-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226143341.282188-1-maxime@leroys.fr>
References: <20260226143341.282188-1-maxime@leroys.fr>
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

If hardware or corrupt DMA data fails to set the FINAL bit in the
scatter-gather table, the while loop in eth_sg_fd_to_mbuf() walks
past the end of the SGT buffer. Add DPAA2_MAX_SGS as an upper bound.

Not tested, found by code review.

Fixes: 774e9ea91992 ("net/dpaa2: add support for multi seg buffers")
Cc: stable@dpdk.org

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_rxtx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 8275ba9780..b316e23e87 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -335,7 +335,7 @@ eth_sg_fd_to_mbuf(const struct qbman_fd *fd,
 			(void **)&first_seg, 1, 1);
 #endif
 	cur_seg = first_seg;
-	while (!DPAA2_SG_IS_FINAL(sge)) {
+	while (!DPAA2_SG_IS_FINAL(sge) && i < DPAA2_MAX_SGS) {
 		sge = &sgt[i++];
 		sg_addr = (size_t)DPAA2_IOVA_TO_VADDR(
 				DPAA2_GET_FLE_ADDR(sge));
-- 
2.43.0

