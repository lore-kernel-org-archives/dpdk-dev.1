Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517BACA6017
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:38:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B6AF402B8;
	Fri,  9 Oct 2026 01:37:33 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id B32C9402E2
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:37:32 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-8935f42e8f0so619877b3a.2
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502652;
 x=1792107452; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i44jwQBOEGAULy+WJDBHE8WSa9mfIvcvbKfK6YTf4X0=;
 b=mUCkVqLgoleXt2l295fEBNz/PGDoKbQuHCnOuQIcCz6TroWU7sQl33X+ILrlrFKhIp
 1Rl2BUWqOMsV+Tx4GuFkRBd7WIgd1GLouSSBE/nbclH/thjMTg2ST27ZxZSG/hGvrHhJ
 dVx+vsCtzbl+vnHdY+g96NlTWG9T2dBm/1oLpR5tKVGLK+NDaTmmQFAH0ZZ27a6EhPUg
 QGfPgtutndB/IVZ2wN9bkffYggYGyCE2W7+PReLJLlDlBXTlkIi1Lt4vzDsvfS9oFbBO
 YIqsyhZhZVtalOZhd5R0xHoY1FP5gVQGxKCh42jzy4UpG024dMZQqB51Pt/6eW/DKeJr
 iD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502652; x=1792107452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i44jwQBOEGAULy+WJDBHE8WSa9mfIvcvbKfK6YTf4X0=;
 b=xitwrae3TzZHoWC1PzCjcZkISgGKhcEiKV4mpzzjO8xa4mvG3Ou0Hbseln7rNb4KBO
 lLl7t9sxQZdcQSUK7ICjBqyCyjkWSbcrOyEJquyRV3E2vvF9VadKmKm+eV39rGG9uPH7
 GuZ+u88gFbssj45iJfcg/ngX6tjvfvomzHDhUEBu3YsmUvpx364ceq+5Ke0MkevgyUaP
 eNIZJjtCbiu4YB27Gmchx5h1DA6Bv/INo6dxahuVJ8gVGAU3WKT9ghUhEUhNO4K8Dmjc
 O1xHuxnPyDuXzvCibR5kz8VAAo5SVlEGO5w5NbY+C7X2Faio+aZpUiJ05ZkmaB0Xb0EO
 Ahzg==
X-Gm-Message-State: AFuF++kj7tuJVOxnEd/qka+jdH1tGVWHYFfOEKLqQsLxmz5DBvkbq8Pu
 +R7RNvYqZOhE5dPgXNgFxzYPGlC8HDYT9FOcCSBsRFET1mqW7LvuF1k6nWsEYllXBG3XXr57es7
 zuMzzuuU=
X-Gm-Gg: AYBFou3D4p0+DuCI7Rau0c+Eb9MQ496CVGWpAdwdjMocxAeQh+RjzHUXsmcnNZvkr76
 SfMqx3UTey+bJpw+gkkHIxKTJEwoG8m802wcxI0iNo8Ih85hQSfz/2ChcKdFfwD4zT442E9TxdW
 fbJoplXFKDYwSucOcFhp6l8WENbRWCnUHLA6ZbdAdOd3+GrQD5mxA5SdKqXTxr6qxVeEFSMaFAt
 gqaDoMyh6zYm4VV+ab5lRLHyFyLkBoOye8KAI2FGfGXd9SxmcQSEDlIRwHUAFOR9XqXZASQYzNO
 QmvEi/kgX6Xz0bSm8grB6l9m+RntNpkjV1Cu/KYRFfOt1IwrIT37MjPv3bQu7v1bG1klQU58/rD
 CWCrWwunEZ6HWKpGLe84qu/XFwzFxl9U3JZhtT1og8AKBQ8WXZqkU4DlYfy0A7Rv2eoOjKXMS5s
 bjk/YwEQr/yEbXM8rvdL0FEAWmaEr+5QK+gOe5rzPIMZ+4gTMYmFuO1IP8NrmVcfHun6zh5rpW4
 XLjL15oCE4HgP+j9e6JVUCYNEsDup2qSVgf4A==
X-Received: by 2002:a05:6a20:5493:b0:3dd:a00a:c5be with SMTP id
 adf61e73a8af0-3e16c03cd8emr12587637.49.1791502651881; 
 Thu, 08 Oct 2026 16:37:31 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:37:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v3 15/29] crypto/caam_jr: use IO barrier before job ring
 doorbell
Date: Thu,  8 Oct 2026 16:35:08 -0700
Message-ID: <20261008233649.1260843-16-stephen@networkplumber.org>
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

The barrier orders the input ring descriptor write in DMA memory
against the MMIO doorbell write. That is device ordering, not SMP
ordering, so rte_io_wmb() is the barrier that expresses it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/crypto/caam_jr/caam_jr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam_jr/caam_jr.c b/drivers/crypto/caam_jr/caam_jr.c
index a7d314bfab..01a9bed1ff 100644
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

