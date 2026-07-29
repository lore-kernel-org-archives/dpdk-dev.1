Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380A4C53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:58:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2DCD40A75;
	Wed, 29 Jul 2026 19:57:34 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 016E640A6E
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:30 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so853509a91.2
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347849;
 x=1785952649; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UzK+HGfDuccdwwqU/7kgbZLBnuytApUqFxoH3y2rhIU=;
 b=PflIg0L3Uo68JHwzdhyP2lv5nz3MtGtvGZx5eqDS+GW/aqpIJrPYl3ArVacjM6EnXy
 yLw2MpUxdyW257MCS4m+19YTdPV9IJQTphUZHJGYvVqYit1meFQPBq4/kUSDm/ZoVOFP
 iztwCGl45H26Z/aew8Q/t+0O7INpZL8o6NYz+BHmcq4qY1MsLtNYt/DP9i8K3dC4p3pz
 pNyL1MxVdZVCa6mZOr+/xVY9i+vU8Nn6X7pRWJHvs+kaW+Wzm1RAFGSzjvWa8bgtDtFA
 9B0/xqZj7uE8BZfK43vwmlx7gPwXT2DD8d7OijYpsZZvASXHlXB7IRoT8nnt0FOFYyJS
 bC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347849; x=1785952649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UzK+HGfDuccdwwqU/7kgbZLBnuytApUqFxoH3y2rhIU=;
 b=LwjQIeuHkkcvL9zXzrevD7lF2Ckp0ZWH6WkvKpWHbbTLLmHBQ+osVM86R7ihG0MylT
 3pYlelLP5KImNkHKeSSdUWbPTs1Csl2mX9U4OFkT7FX+h0Yk5qdTfRefq+BGYOwkEwNn
 PU40nF7aREkkeZFQFz8GqJMv1WrNsKFGj40o5F1fOtJKNuA20SbN/4QjgzKKYyFC87GX
 ZcC1r7Tvv9xsJzXUrHZkc/t5Gx2GP2dZkUQ1S8vGTsWp6YEtX7Mhdj0qrE69fHZSqDo4
 TZiGuEGU8j8/yg8xEsQaQM2Ex72j3NzVUu8KMpEwH56c9mEB9tKURVKUTUFLlimZNPoL
 waZQ==
X-Gm-Message-State: AOJu0YyQkW7q8PcBpANnTMN3t7IWh4747N2rusbGUQMYzKy+zFzmNVhu
 +/6Iau5Z40svBrx8WbZ5SL5Q0Z22nc0Qx2TsLbXDwv/WrkLhVn8TnJwKuzMr5Zglhi2nWqIh8k7
 YZMGT
X-Gm-Gg: AR+sD12NPN4YoaKLIull1339MHhYupWJBLSczPAmZ4JHkNEAm41SO7MF2SdGcJbW54/
 /hrqYvWSnkUgYdHcGQlVvfiKuRKvgf0vq1VqEK4WH0ROTrRCN3NEyMSnDghxLPTcuFojJnJdaQr
 nCuIdm/Mde9XQvsC71FwkNcWy0WA4kpTqlEHOb/TgWyMprHDRNOf72ze8GdUcBV4Q+jTkQyLUYN
 0HFUVvcJ7oCGZVttR3j6cjXzODslQEgQqtL1Gm7F5pYhyEePGN3ISqSr7JSzAJSZKyBJnClIKl+
 DdHR89WNC0v30QdJyZYB7UKkRrgoE59C5zaAhhQiLvu5U7uC3BWXxqbwCpNEbpL+UFjlyt4P4qB
 QXPhCvGBiEkovdVxoQOmxmG3dokgS6AvGEcnB1Z2obbqw3YuDA0++tqlsGAtfDET3DYnECaeHCF
 Wb9Fr+qvfUeaGPkh216rbo3In/m6sLo2+MP4BQ5+J657ugqzzyToi0dL4ya9JBA/RQIwhtko4Bb
 i//Zf2TbuxaIkZ/kCOtMYW89lQpohAVuoUcyQ==
X-Received: by 2002:a17:90b:4c86:b0:37f:e1af:df22 with SMTP id
 98e67ed59e1d1-38f6a3383ddmr7982134a91.17.1785347849122; 
 Wed, 29 Jul 2026 10:57:29 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [RFC 10/32] net/virtio: replcae rte_smp_rmb
Date: Wed, 29 Jul 2026 10:54:03 -0700
Message-ID: <20260729175715.165120-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
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

Replace rte_smp_rmb with equivalent
rte_atomic_thread_fence(rte_memory_order_acquire).

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/virtio/virtqueue.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio/virtqueue.h b/drivers/net/virtio/virtqueue.h
index 1f0e6ae77e..37fbd47d42 100644
--- a/drivers/net/virtio/virtqueue.h
+++ b/drivers/net/virtio/virtqueue.h
@@ -445,15 +445,15 @@ virtqueue_nused(const struct virtqueue *vq)
 
 	if (vq->hw->weak_barriers) {
 	/**
-	 * x86 prefers to using rte_smp_rmb over rte_atomic_load_explicit as it
-	 * reports a slightly better perf, which comes from the saved
+	 * x86 prefers to using rte_atomic_thread_fence over rte_atomic_load_explicit
+	 * as it reports a slightly better perf, which comes from the saved
 	 * branch by the compiler.
 	 * The if and else branches are identical with the smp and io
 	 * barriers both defined as compiler barriers on x86.
 	 */
 #ifdef RTE_ARCH_X86_64
 		idx = vq->vq_split.ring.used->idx;
-		rte_smp_rmb();
+		rte_atomic_thread_fence(rte_memory_order_acquire);
 #else
 		idx = rte_atomic_load_explicit(&(vq)->vq_split.ring.used->idx,
 				rte_memory_order_acquire);
-- 
2.53.0

