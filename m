Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F60C982D8
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:16:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8FDA410FA;
	Sun, 20 Sep 2026 20:14:32 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 6A96A40ED1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:23 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-398cb5615deso2719415a91.3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928062;
 x=1790532862; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=myd8/8w9q5qDu09PDLUwkhGcqZeeVUZbj6n521rFOOs=;
 b=B1lbxBul5vG2URrcE2MRtUPGP8aH/1c79zNOo9DTZCG3xH7cJhnkWrCp6o7PLWEghV
 tCGGAWDW2i+dMWn450oRL71kI2UDnfqLhM8vnTLePwtZ9Ug+1oshays80wJO+jqb/jEV
 es+qMAjSE/dq9Ct2bSGf+jwGZTmr9CCpG8RiNy4X2R9HdRw+UjZMB9GKmD7zjYxbYPe+
 j7uxPHtxvxYHa2ITajeIqn0egDa9P4/z146vJvYYkz4q1+lW+IVC5IlEnEx4+JQ7GvIO
 RvO92fL1x3l+jy3SqBa8qVtVP7YEyTFyFU2FMgAQFB6vtkx5FIMWQUlT0l3LW2nmJFyd
 +feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928062; x=1790532862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=myd8/8w9q5qDu09PDLUwkhGcqZeeVUZbj6n521rFOOs=;
 b=FVUoXWzgRjKQycXDkH/tzs0H+jv52OAfLp1HgwjNBrxj+3BnIU92FlZjYgx7Uov9v0
 HxuNvPb5MKt2JjNOlLe1iYNJkZNQ1EYo2D1jIccOLLZoQhQD83EGYgwsJ30BQFkbkPY0
 v1HK1zhwdF4Wb/hjacpyaf7lrTzZMSZSzG/wZIHzX9RgBcy79IvotTsZkwRi/jrhpyoo
 rUg4cVnB+QLR6GOsqRoIDJxfKPTteannZbycMkj49SQJQCf3IQJY4JigiCFOemCL1x2c
 iujGyBYc4HZT1SZ5Q1Cugew31FYz40yvBOdVc0cCv7CnywtLZgKue5M1ep5aDjcU7WA3
 EUBg==
X-Gm-Message-State: AFuF++kZQv/RJEVpKRHzQoVmLOT6dpoPKXhH2KROaCuBb5vfgmKWFOfr
 ZAHukZYUOIQ4tbd4IssT1SBO+mMFjU54wTtla/pgNfrUFrCM5IQcEdm2qlk8hydjUcrM5YqFDqA
 F5FRJ
X-Gm-Gg: AYBFou3KibsKqphQVUBx3O4aKpT14Fy+eUPiFWe1DJWYYKsiKlCXEdy5gM1w/q3PQfT
 gq/EyrQk1k75B43iIToNlUsIua1x1/Jomiw2+c+k+ML5CvQ+3yVHZcjp6kFA/ftHsq0B2Dp13jY
 kz26Bsr3YAweMIjZt8qdTzIXDky2X21nitvysF7UJJJVGAVjd8TZE95JvgA9nioxvycEPJsr6C5
 CizNM+Qym0Vep5A41BwtGHzvgbIOdN3WMe3RY/gEgebZ/lCvNrV5z6IwLrYYl0oeNFkaFtMz8JI
 fZEUvW7PW2ShIQUK/OwtA+iavuUoM0GrFPXZHNaYEdB8CzoC3iR6GG8N/9BiRH2Uk2QVpvuIF3r
 pg1MMe2oJFiwN2pU4Sp5I2qAuOHi7txWMrBOM9GDhxYn2wLYXkcDp3qFJrfzRKUiKC3Vhrnf28f
 GSpgqsiHupx8ug/Qh5drMN/XytHGwEeZPKVG5ZhPHPe/SCOKlWcWHi53q8AiGA/ezCyUUE/3He8
 kpY8OHO+18YNJmturGbdEwVQ/Hf3P+YY4QI7w==
X-Received: by 2002:a17:90a:c88d:b0:39e:4c81:6c94 with SMTP id
 98e67ed59e1d1-39e54f24890mr13943684a91.26.1789928062591; 
 Sun, 20 Sep 2026 11:14:22 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>
Subject: [PATCH v2 28/33] net/thunderx: replace deprecated SMP barriers
Date: Sun, 20 Sep 2026 11:10:20 -0700
Message-ID: <20260920181347.747210-29-stephen@networkplumber.org>
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

Redefine the nicvf barrier wrappers as C11 fences and add an IO
variant. The RBDR refill barrier orders descriptor writes in DMA
memory against the doorbell register write, which is device
ordering: use the IO barrier there. The mailbox flag barriers are
genuine inter thread ordering and become release/acquire fences.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/thunderx/base/nicvf_hw.c   | 3 ++-
 drivers/net/thunderx/base/nicvf_plat.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/thunderx/base/nicvf_hw.c b/drivers/net/thunderx/base/nicvf_hw.c
index 5b1abe2015..d1e31ffdaa 100644
--- a/drivers/net/thunderx/base/nicvf_hw.c
+++ b/drivers/net/thunderx/base/nicvf_hw.c
@@ -499,7 +499,8 @@ nicvf_qset_rbdr_precharge(void *dev, struct nicvf *nic,
 			break;
 		}
 	}
-	nicvf_smp_wmb();
+	/* Descriptors must be visible to the device before the doorbell */
+	nicvf_io_wmb();
 	nicvf_queue_reg_write(nic, NIC_QSET_RBDR_0_1_DOOR, ridx, count);
 	rbdr->tail = nicvf_queue_reg_read(nic,
 				NIC_QSET_RBDR_0_1_TAIL, ridx) >> 3;
diff --git a/drivers/net/thunderx/base/nicvf_plat.h b/drivers/net/thunderx/base/nicvf_plat.h
index 7d22563035..08ebb0cf62 100644
--- a/drivers/net/thunderx/base/nicvf_plat.h
+++ b/drivers/net/thunderx/base/nicvf_plat.h
@@ -25,8 +25,9 @@
 
 /* barrier */
 #include <rte_atomic.h>
-#define nicvf_smp_wmb() rte_smp_wmb()
+#define nicvf_smp_wmb() rte_atomic_thread_fence(rte_memory_order_release)
 #define nicvf_smp_rmb() rte_atomic_thread_fence(rte_memory_order_acquire)
+#define nicvf_io_wmb() rte_io_wmb()
 
 /* utils */
 #include <rte_common.h>
-- 
2.53.0

