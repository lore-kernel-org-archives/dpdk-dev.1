Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8EDCA6015
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:37:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3A0F4042E;
	Fri,  9 Oct 2026 01:36:58 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id E8997402DA
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:36:55 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-88bd2b44f3aso2023296b3a.0
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502615;
 x=1792107415; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Syes63RKmMSLDj+fIOGXC3kUF92ZJLik0mU+IxkGk/Q=;
 b=emDhiMC47RlxXFfRp20QU4JHUEc325me+aie6sDkInmDq5kaHdD4qO548E69/SBcNd
 F4oaipxoiXdyNJWF09sElulkv3WxGNbnKCFYJ/waoBYLiAGEDUcrxbDOl7g8ZR1s5Ad9
 159VW1lPRMel76gl+HGXsNEmPrNd7tk13HPxu21TGuGYtXmyzSZiRQdDmh9X8tRaBAca
 WkHkukpfhuaebFas7VIN1pvpmMUWLCEspNDF4LklEZHFM/DW1G4YLPARWbyiAsMDFiGH
 pFzdq48CMqbKNRNMgGnmP88tnXOUweMtmA0TC5DxBH3+25akf4pfCz8YQ1x2zuB10uuz
 wu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502615; x=1792107415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Syes63RKmMSLDj+fIOGXC3kUF92ZJLik0mU+IxkGk/Q=;
 b=u0cGLjJvCm+TXePEcFXrSktdFY0LLrWp48WcV3M5cj03y+/7hX2HOuJiNiE9prZJAE
 Av7kLFWiRwp+WuTmKm1Tjr1dyQhWSRFQNedPw7yr5WKu+LNwlEicEai2+XNx3Wx60+tk
 vTt9BRJ8Dyqq2WcC3mi/WiLAPqCodtKMBKNf6Ys0A/Cm4ApVY+ZOJMAF5rvFtvb9ze6s
 OohWKkbPnDtp+xAumT3JWrCpa8jG+yO1zNBTR+tSy42BpnTEXXPnhB7uJnAXhG6346fS
 82HcV8K90Wj9NU+VcEllgpLgZPYvCOHn4W08V2eFAmuC7ziAwTmjsY+yPcOYdF3bQmIg
 G0kg==
X-Gm-Message-State: AFq9FYL1cAnRgG1HDMiy2R+zse6gNg69/4NZ3PsDp2d0RpkgdcNpXpQY
 d5wamVPjiAQXhbT70TGJ+rniBbCVp+i4j/J/giy3rMgpV7KeNUE2z+oNgp4B0gyDRgbUgGlDyuX
 vKIHeFU4=
X-Gm-Gg: AYBFou0aC6yQcI6E02WpPPqjKZrOPN0Rrp+F20iPYk6DoPHmtiOMlbLfOW7RWlYHhpS
 mNqP2COv6/SXBnJMAOnMhdsx4cRNFDOAK2bEBRFe56kbpoKLIwEpmHwERX6LItI67Ny2/M87qIP
 JGZfjuRI/gTRr0tFfwIR0xJfRTvs+W7vgcHlSD0zkASQvIEA5GAyuXtiyU9ObirhvJ519lhwWnt
 qKnAAt5NMmKHH5URoq+deRJBn3x0M+UIwI483Nm+qOwcVFjfNycfDA2jA6uaReb8t26ufRR3t+Z
 135A7H56nnwmwpiFVTzOZoaW0m0WYxBYw4eUC1bruhxNtPcG9Y7p/1OiuvxtZ0BuckZsAJzw8iD
 8QCEf1Ro1aNGIGdXWLBfL5zk1Ap6s/kSjrZtFAbNxLC9vGp6GqVOKzdH9Z3f23H7S9am19zYAnG
 Zk4qqhdEXuQJl3AocUZoLXcf7uELfL5vaiRNnM/Imu+JklALj3BS9c0yUSovFi59O2RXoUSQ37x
 f3IBwhjBuTFjiW+uw+ZDMXOplLk7hyyiiHsVw==
X-Received: by 2002:aa7:88c2:0:b0:886:cae0:fb64 with SMTP id
 d2e1a72fcca58-897c700e74emr44282b3a.31.1791502615014; 
 Thu, 08 Oct 2026 16:36:55 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:36:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v3 03/29] bus/vmbus: fix ring buffer ordering on weakly
 ordered CPUs
Date: Thu,  8 Oct 2026 16:34:56 -0700
Message-ID: <20261008233649.1260843-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
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

The read index update in vmbus_rxbr_read() was only protected by a
compiler barrier. On a weakly ordered architecture the store of rindex
can become visible to the host before the data copy completes, allowing
the host to reuse and overwrite ring data still being read. Use a
release store for the read index.

On x86 no barrier instruction is added, only a different instruction
schedule; on arm64 the store becomes stlr.

Fixes: 831dba47bd36 ("bus/vmbus: add Hyper-V virtual bus support")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Long Li <longli@microsoft.com>
Reviewed-by: Wei Hu <weh@microsoft.com>
---
 drivers/bus/vmbus/vmbus_bufring.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/vmbus/vmbus_bufring.c b/drivers/bus/vmbus/vmbus_bufring.c
index b49725da3e..86dc446786 100644
--- a/drivers/bus/vmbus/vmbus_bufring.c
+++ b/drivers/bus/vmbus/vmbus_bufring.c
@@ -238,10 +238,13 @@ vmbus_rxbr_read(struct vmbus_br *rbr, void *data, size_t dlen, size_t skip)
 	 */
 	rindex = vmbus_br_idxinc(rindex, sizeof(uint64_t), br_dsize);
 
-	/* Update the read index _after_ the channel packet is fetched.	 */
-	rte_compiler_barrier();
-
-	vbr->rindex = rindex;
+	/*
+	 * Update the read index after the channel packet is fetched.
+	 * Release store ensures the host can not observe the new read
+	 * index before the data copy is complete.
+	 */
+	rte_atomic_store_explicit((volatile uint32_t __rte_atomic *)&vbr->rindex,
+				  rindex, rte_memory_order_release);
 
 	return 0;
 }
-- 
2.53.0

