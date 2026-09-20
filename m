Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3768C982DA
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:15:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2817340E28;
	Sun, 20 Sep 2026 20:14:16 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 113A540E30
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:10 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccdaea75so744181a91.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928049;
 x=1790532849; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=doSgc074OeSc+MmVrZjgUjo1jiyOTzWkk+ukoYwkaPs=;
 b=LOzQx+wCIyxhMzjWO1h95nBvMaaF2RMA6F/UsDXIqfDlXD2olpEaEab+dF41iXPnF+
 Nr4xfyQEQXWaUvKBiIfTHWwyNr4MmNRAQNrPhJRW+Q3B8n1hYEuPp8Rpoe5BGoy3thvu
 89dkoXQB1kIey5FIwovV0tyuvhmd8DgqazrYOfB3IJ0kn402snvES9aHnWlnFcmksn/3
 6KiUCEYJOUrdYtGcRm64t9Zv82DlUqmfn1Vi1Yf2icPL88PCZNe5pA/L0APptTvtZ80Q
 sEEnAZHQ3SQW7k6wC7kSeVunDXhH9U87x3oBKmggjsuwPDibI2EP3h07HEjsmm1rfxyn
 SF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928049; x=1790532849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=doSgc074OeSc+MmVrZjgUjo1jiyOTzWkk+ukoYwkaPs=;
 b=Dq6S5gjwxMM4Whsqum5mDgFIikMh+YnJu7rnu3HWMNGlRRQDsOPxIXIXqMGTqcIZbo
 UXx5Qqk8bnTeamYTM9+3c9uFxaweOgJ4LAo5tXQDVjOH+8T5OcbGtmD8zxjK1CmqZdG5
 rOfmZJNy7CGu2EB+Gf3HieSPAF7SLFuPgBrWYhFdaqFqWi0XR+rfvpyj/d5wpi/fbl1g
 FEIoVpCU2Zflu/jpbBTW/5G+Gv2pFoZGBFJ5PZ/v7X9cZoz1JbjS0u2fpm5cF3StTw+r
 7JFGJINexYdQjIuCnJj+an+NAtAgUXB26aQt5iBqN8elehFCkx3iuD3pAA06EH05tOob
 fRGg==
X-Gm-Message-State: AFuF++k1Jua5yXwAs7EOH3z6W3y01oUNVzI/RLZ0kGLW+hIWdOOWYe01
 69rR4i77a5ZXKPrRW7OAI/XfcToBnvqacMlPfWThKfA8gf5djDBFEAnqNZ382u86ubTjzJUAV2N
 G8KZV
X-Gm-Gg: AYBFou2heTE01qSAJLFklF4D+VEFVtk8S0wMYasu/lupdPIVaB6g0hgujEBwNCVU7Ym
 GxGmN1TL8WiUyy69GT6e+2y3iKjexnszKjxfylHMUz7YRvM1NszZk/bDKpwXL+tCs8UcBYBvXcZ
 L3OydDZthaFvFkmyMaiAgQGABiUdDc53tqzK1tu64BRDqhT7S3Th9wt249itsJnmh9D+mtEgNb+
 3Lu6seQj1xDzig6VnfqifYO7Nq4Rs8h/+RksZBn4LHYXHyusFYBe+rK2Z5hOVbpnX5Dj4c9M8kw
 mhGMFNn8rtYlJYAmuP5AiE3uvY7iToYHdxWz3/JzVFTNK6mAZcXr9KX2uAYaY3gzu32VKaFtVf0
 G/tjO1GaIuqYPwkoeTL7PS1TxltEdKleepWMIG2dQBpZldKM+IfVA56wJGZ9gr8yxQQ9IOx7nO4
 oQPhXef4C3/9P6GTMIbYa/sqpCMpZ92wQ/F5w5jW8G672RjqE2XuzFoDd2MZbzSZAVseKuGv7TY
 kGq+C/VPKvCqpH0RoQA7tZLBUh9vW6WpaXi94wK8DacB8OvVw==
X-Received: by 2002:a17:90b:440c:b0:39e:252b:86c5 with SMTP id
 98e67ed59e1d1-39e5546c8a8mr8285742a91.1.1789928049217; 
 Sun, 20 Sep 2026 11:14:09 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v2 15/33] crypto/caam_jr: use IO barrier before job ring
 doorbell
Date: Sun, 20 Sep 2026 11:10:07 -0700
Message-ID: <20260920181347.747210-16-stephen@networkplumber.org>
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

The barrier orders the input ring descriptor write in DMA memory
against the MMIO doorbell write. That is device ordering, not SMP
ordering: rte_io_wmb() is the correct barrier, and on arm64 the
inner shareable dmb the SMP barrier generated was not sufficient
to order against the device in the first place.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/crypto/caam_jr/caam_jr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam_jr/caam_jr.c b/drivers/crypto/caam_jr/caam_jr.c
index 1f97e72337..7a345c436e 100644
--- a/drivers/crypto/caam_jr/caam_jr.c
+++ b/drivers/crypto/caam_jr/caam_jr.c
@@ -1451,7 +1451,8 @@ caam_jr_enqueue_op(struct rte_crypto_op *op, struct caam_jr_qp *qp)
 	/* Set ptr in input ring to current descriptor	*/
 	sec_write_addr(&ring->input_ring[ring->pidx],
 			(phys_addr_t)caam_jr_vtop_ctx(ctx, ctx->jobdes.desc));
-	rte_smp_wmb();
+	/* Descriptor must be visible to the device before the doorbell */
+	rte_io_wmb();
 
 	/* Notify HW that a new job is enqueued */
 	hw_enqueue_desc_on_job_ring(ring);
-- 
2.53.0

