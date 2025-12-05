Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65058D37497
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 20:16:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 077AF40649;
	Fri,  5 Dec 2025 21:15:57 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 5143340654
 for <dev@dpdk.org>; Fri,  5 Dec 2025 21:15:55 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso24728735e9.0
 for <dev@dpdk.org>; Fri, 05 Dec 2025 12:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764965755;
 x=1765570555; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o3xI73Qbi/sgZfJg1+w5dGq6Jt/GiS5F7JZlrYSLb8c=;
 b=tgA08nbDDZw/RbZdZ61YClT9yVi/pjohlMVjr9nRDjZSvuoTjulVvwRwNsk9DGZ77y
 PPUm92XJ1H1YiQs+85g8gB8nDjjHID6j09uA8BYmiJm0M728FXahq4YTN8rPjeOCTvm1
 OjhrR1MHCu1nYTh3TmUC2cM6dkbljvBd9kcAsjkOT4kBIksZ8Gg2djgOXHFQY3+Nkvm/
 atgA9qcNziPwJCo8kGssjz324+SDOEpCCx+FIQMbJF+QwtDVujuo4y7mDfiWfafNlfDO
 AuA13RfO6X+0Bo6W/J5/XJ1AImKSWKCHfeZrBwKMQ0zhCKgME16XJFGbrUCY9uQ7JOhO
 NEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764965755; x=1765570555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o3xI73Qbi/sgZfJg1+w5dGq6Jt/GiS5F7JZlrYSLb8c=;
 b=PJt21LFVYrtp/luBDs2J3isslzSNmQh8tedk+ujOqbJ8B0q80bJMMlKUrZkt/32IYp
 WSJE3njO1+A/ReNtJfxMEeEfKwF+Grci82wfczcOtRGwLdoRgNx4jXAuXlYXw1RW14Tj
 zJVDeyexoG9hoiToA/tJHOg7SffnzJiqSbpHHz02NnQ+xigKYVEK9TU2dg0jKNrulfpK
 211U0/mrBi7TTEAEE6+YjaRJGEycSzO4nhNzLZ5uq7gYtrpL30LEPuBX1yEbmBhq+gcJ
 dpofxyOjGFAqUFKzrbCiQbLcZvWZv1t/2/v7gAwWNzwxeVdQD/Iendz87lwMDbYTztej
 QoIw==
X-Gm-Message-State: AOJu0Yz7ARg89dfY6pD5Sxa2GE33TB1Qd6tpalWshhcE3tyGbcSpSx9X
 LSbrwSAsyI6/y3jZZHGJvMRuAnFDJpPpiWKiAZjd3oEtudvyqvLPc00OSIJZ9VvqCqtQr2LfH2C
 NX3ph
X-Gm-Gg: ASbGncsxZGdISwkqBoWAFlBeZtsjw52BJ0GBBMWI3tt1rRBNhBP/mNS1iaoA25Y/TIs
 fdNyRrbhZWIG/zPvOgpcr3V8smnnvVTu9NzToIJZXrKiwYocNX+vuvQS0keGOtVk9tQGfpc3UH/
 2LN3lOMXVbuyLWbPWUybr387ysuP/fWkfXqsmGLNQUy7m1gxb5CsjfmnZL0kYQQZVs2aUJtWMHT
 rQ4PrjaaMywf/eM7/BdMWcoBpalxuM0cI0ER7U+GI2U94ToBQ/WnPuTndOlFo/P3xc2wdX9fhXI
 rA5U0Q9kAYwCwu0kxVIEnXi677PHqksgXgTB3iVvbHXpkl2aBDScifXuukewqswMtQ6MySdqX6O
 kivS9Tqza8bzo9gfvS1f3MHDd3RjzqhgLTeT4uvV0AbFIjx8V4AHTm5tAUADQeM1175TJUOsfq0
 mEb/bJFMH0hBgfFJaPJYYP0GO9QlGwtYq2jWufaqAEqWciTt/i2g==
X-Google-Smtp-Source: AGHT+IEMo6qvyd3aaL3aeOP3hAtEi3A/LkFBWdeVA3koLBQ/jIT3sKZyS9nJy/qxcOtxT76L7woL4w==
X-Received: by 2002:a05:600c:3f10:b0:479:1348:c63e with SMTP id
 5b1f17b1804b1-47939e22863mr5541195e9.9.1764965754885; 
 Fri, 05 Dec 2025 12:15:54 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47935fce542sm45344875e9.0.2025.12.05.12.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 12:15:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Byron Marohn <byron.marohn@intel.com>, Yipeng Wang <yipeng1.wang@intel.com>
Subject: [PATCH v3 06/16] efd: handle possible name truncation
Date: Fri,  5 Dec 2025 12:11:35 -0800
Message-ID: <20251205201537.251131-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205201537.251131-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205201537.251131-1-stephen@networkplumber.org>
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

If the conversion of efd name to ring name gets truncated, then
log it. And if the ring name than causes collision, make sure
that log message includes error reason.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/efd/rte_efd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/efd/rte_efd.c b/lib/efd/rte_efd.c
index ebf1e0655f..ed2c509938 100644
--- a/lib/efd/rte_efd.c
+++ b/lib/efd/rte_efd.c
@@ -698,12 +698,15 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 	TAILQ_INSERT_TAIL(efd_list, te, next);
 	rte_mcfg_tailq_write_unlock();
 
-	snprintf(ring_name, sizeof(ring_name), "HT_%s", table->name);
+	if (snprintf(ring_name, sizeof(ring_name), "HT_%s", table->name)
+	    >= (int)sizeof(ring_name))
+		EFD_LOG(NOTICE, "EFD ring name truncated to '%s'", ring_name);
+
 	/* Create ring (Dummy slot index is not enqueued) */
 	r = rte_ring_create(ring_name, rte_align32pow2(table->max_num_rules),
 			offline_cpu_socket, 0);
 	if (r == NULL) {
-		EFD_LOG(ERR, "memory allocation failed");
+		EFD_LOG(ERR, "ring creation failed: %s", rte_strerror(rte_errno));
 		rte_efd_free(table);
 		return NULL;
 	}
-- 
2.51.0

