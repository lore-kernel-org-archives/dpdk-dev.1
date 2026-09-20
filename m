Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753C1C982D8
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:15:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA1C340E64;
	Sun, 20 Sep 2026 20:14:17 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id D744840E36
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:10 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396ccd4f99cso2490325a91.0
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928050;
 x=1790532850; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cd2ZaDFNTVmRhmn3FmQVWsFaq3/lXlpgh+Csh2aFOL8=;
 b=qpARtrGE8spUeJBgHnAbS5EmnkrmWuVg3dPiCefAxdrtRMcckvfzbfgiXO0Jg/V52B
 V6VuIDCDZycEQ4to5eL3l/DzU/ECDaH0lkOcFKlCfvST7pEwDncBvniapYAsjgz/Pfrq
 CEkT1tm9UGF61MK9mw+5MR3fyCeq0lyOzhylAXb9nqSX0DBhTGdF88TBhq264IXHZb0v
 r5fqobSSJGkaV+jllw2GqCZ2e1Jca7lTU3qHK8VVa6VNY8xrbkL7N49CgHGLp+ERnnya
 UmsfKHiYlrgRvWFlGlZmjcfWzYHKOjnACHvhwNBPCQJfeciGD9MkcY50OtiCZarZei3Y
 400g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928050; x=1790532850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cd2ZaDFNTVmRhmn3FmQVWsFaq3/lXlpgh+Csh2aFOL8=;
 b=xb5DNymJlPQOxHcj9v9qPLYGSx1ToZCRMZ/gSJmuVCEdNxLevRF21x545P9vYc8/c6
 K92FAQmsKuMs0PYW6zHhN1gLKuO756zZxERPNtwQpBm9yl+eurI/yEJLQ25KfbEDQry9
 JdmCQYIuE5Fc+g5YJztq0D9z+fGwvxbu5o2QnlGLBBkzmURSzAXUKUizL9izS8zRUQ6f
 QlJwtECoc93cJexBeBuQJwo27KYut//inB6/nm8DsS1CxdxfLpBFqRGq7bDt+pHH3cF1
 C+QkHzFLVl/Xl1wwM4CqKNYEZGvkULyTndZIr8k+ZQLR636FWvWzDfFj8dLXQKx4gvQ+
 LXvg==
X-Gm-Message-State: AFuF++lSrbWOzvGsAM63bdSvgp+agYzQm4AXRwq2jFRV3Geg2dASpDWk
 wUnK1CssM7Dv+4cFMZmXZgBT4J+jtfVnxAD7VPRcppmk7Z2dONSFmQVnZUY2eS7K3I8CCYr/oG7
 6FBQ1
X-Gm-Gg: AYBFou2yxuahVxT1eRuUpHlMNIXgGu07/EHsAfvTIHpVFdL45vUU/ChczGgewUfm3QY
 AKnORitVryIJPZ1dM1i5W1F5ORargnkitkgzg8+InDHH67HwSKy85zXYjqUkvGnbqujKHqFUOuF
 nuadJXuVtNCAjLboYlse9LKMrEO8zLkbwn9cXf8OoJ1LLIp4LmOI59h0lwz2ATGxCpOkGlkozkQ
 hPwkOvYt+Zz4K9ksjfxxMS1W6T1Vt6N+0xTF54IJTuAGKiifoCbtkmxJon1OpgM0Yf2Azm6bAha
 xSyAzIp4brjnNednBDcFdqVUh0myoeZilhCS6nLvKkyZlnlVlYttJy7edh6WnNo+x+6rO31ou/M
 evlVPic/+yCDm7UqUaGpk4QYFv7MzAgCXrJV9wA87jSHw3GsXes93H7nLEedokipjCT1HfWIMry
 JWjS1RqNGZk9nva9Zc5OHXcauLDmNT6ijrCGdz6316Tc9lOIAYBhZaEJb6O1JLxWFnjyGUkCB+T
 f699+tRwLkDCunLESLlEYGgcsh6Lt+u8aI1WA==
X-Received: by 2002:a17:90b:17c5:b0:39e:1633:d29e with SMTP id
 98e67ed59e1d1-39e54cc6ef6mr14511002a91.5.1789928050086; 
 Sun, 20 Sep 2026 11:14:10 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anoob Joseph <anoobj@marvell.com>
Subject: [PATCH v2 16/33] crypto/octeontx: use IO barrier before doorbell
Date: Sun, 20 Sep 2026 11:10:08 -0700
Message-ID: <20260920181347.747210-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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

