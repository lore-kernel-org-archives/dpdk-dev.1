Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667C6CCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:53:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAE8F40E7C;
	Mon,  3 Nov 2025 17:50:13 +0100 (CET)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 87DDD40E43
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:50:09 +0100 (CET)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-340e525487eso1282352a91.3
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188609;
 x=1762793409; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lH46tkP26ZHanmLNQGSS4hUZtFoBXQbkCymr792QvEQ=;
 b=w2wNuL4pjhSXexuJGnyaPWtmqukAnbusiWXV9vvy6PGUndU7WR2K6+x6xB8JnkBxiI
 5UIjiSLOucHNxm5lK8KYB2wfIBcl/0k68QvIsvGITO3U6rOcjiwCc4HYuT2BgdFgni43
 ikDhPT1HvejbwTC9hEgTWeBqNRSwCbMuxj2n+muIimsyeanmMuhiVCqxzOTzoatdK1et
 8fIee1MbxgisSI7LXn8cMYswJGHB5SGsHR8Zu+HZ/hP5Mz6LmmT86ryuo8n12qraBp4/
 RtFW0UnSOvzsxD/sEQ+f5nbIEAp38H2DOsx761YsbLxGHTDsDhRc4CIySz9jRPSWGyiG
 ZLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188609; x=1762793409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lH46tkP26ZHanmLNQGSS4hUZtFoBXQbkCymr792QvEQ=;
 b=Rk7eJA179R1qNca4QWVqw235rX/CWdGhl9HS3L+4wq4jV97jHi9TIWlig1ru/ShwvN
 kzO6yR1PU3k2cgrIwQlrbHNettN0x0hDKWT5OH+8DJ4+pKJHo4PesT0WUMfvHiCZsz1d
 AhH4aqPtVpl58G6CpvcDyPAwKPbHW25eXOnnC0F9587eULc52xMKnBkgcSJrDc1xNQDY
 /Kaa48qnRhd9AgVTGz+IwvOuFbn7K+e5z3YfHsLQVmmdgVT+W8M0aglQZ9KwH0RD7xWn
 +WkoNVJJVue6qQJ5s6SEIVabsqahJktaJqEU31CtT/OeBXqpxVavQ7+bP5ai4fIdbX5f
 tsIw==
X-Gm-Message-State: AOJu0Yymm7DPeZ0ZctbvKm9bxd0tMY8AvoQEXxyeY6F3bjfVhjRSb8gG
 XtKFK7TaQJgPOaSSv0ETJr6fuIdtouWAn4vfa0rj27dhV4BJF4vCYMSgJORNCK/2xErvRSr5JHq
 Zbbus
X-Gm-Gg: ASbGncszrYDSZQRBglSspvX6/DjAhe6bUONTYyHEcPjf6w5UMylETut90xFYYlHKj09
 /Bd7W2aOP/7NJsjYODzSg+dNIYHQuCkwfPVojQfQyt5Qzlvrv1MAncful/jWusMPXIQovAfT4mR
 AoJC/nVQ7n12vkyxBFALgbU1VX/qm5095QrtyTrm/EsQqymHoU1U7+bSREzPFwmbw4dMgwHDKN5
 SdTwxmXh+e1cgMu8jfeQ5WED98WHCiDb2NYRrP1Y4wk6Z0AT7HuluFfEyn1mvmgBADT90FeT3/d
 DPEpWNhxpSfeKZFpieYijzOsPKJMx/Qf750ZEFNYOvBgcAD0bwwTToO7QL1+UgTegY93FZuEGzQ
 7qtLpT+K6GE68rMUYj8p1fK6+cl3Og8GI8kAczJIIuHT0n07if6gbCGoLJ3CXZeRsg1RMdsY3mC
 uUJpYXWXPrIaSbSR/iaIJdB4Z96XHaEF5VhtBRfT8z/tuN6VkE+w==
X-Google-Smtp-Source: AGHT+IEZud+uUqB2oYu6HZKU94g8rtWfdirYN6+ZMaujbUaC225JX7U2CsljmfKrSs0cAdhq0aqwOw==
X-Received: by 2002:a17:90b:1644:b0:340:d1a1:af8e with SMTP id
 98e67ed59e1d1-340d1a1b247mr9606337a91.37.1762188608589; 
 Mon, 03 Nov 2025 08:50:08 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:50:08 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Vijay Kumar Srivastava <vsrivast@xilinx.com>
Subject: [PATCH v3 39/44] drivers/vdpa: replace use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:44 -0800
Message-ID: <20251103164915.101713-40-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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

Use rte_bsd_queue.h instead.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/vdpa/mlx5/mlx5_vdpa.h | 3 ++-
 drivers/vdpa/sfc/sfc_vdpa.c   | 2 +-
 drivers/vdpa/sfc/sfc_vdpa.h   | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/mlx5/mlx5_vdpa.h b/drivers/vdpa/mlx5/mlx5_vdpa.h
index a398aa22ce..8071e1a5e0 100644
--- a/drivers/vdpa/mlx5/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/mlx5_vdpa.h
@@ -6,7 +6,8 @@
 #define RTE_PMD_MLX5_VDPA_H_
 
 #include <linux/virtio_net.h>
-#include <sys/queue.h>
+
+#include <rte_bsd_queue.h>
 
 #ifdef PEDANTIC
 #pragma GCC diagnostic ignored "-Wpedantic"
diff --git a/drivers/vdpa/sfc/sfc_vdpa.c b/drivers/vdpa/sfc/sfc_vdpa.c
index eda111954f..73c75acca2 100644
--- a/drivers/vdpa/sfc/sfc_vdpa.c
+++ b/drivers/vdpa/sfc/sfc_vdpa.c
@@ -5,8 +5,8 @@
 #include <stdbool.h>
 #include <stdint.h>
 #include <pthread.h>
-#include <sys/queue.h>
 
+#include <rte_bsd_queue.h>
 #include <rte_common.h>
 #include <rte_devargs.h>
 #include <rte_errno.h>
diff --git a/drivers/vdpa/sfc/sfc_vdpa.h b/drivers/vdpa/sfc/sfc_vdpa.h
index 2b843e563d..a240a8be25 100644
--- a/drivers/vdpa/sfc/sfc_vdpa.h
+++ b/drivers/vdpa/sfc/sfc_vdpa.h
@@ -6,8 +6,8 @@
 #define _SFC_VDPA_H
 
 #include <stdint.h>
-#include <sys/queue.h>
 
+#include <rte_bsd_queue.h>
 #include <bus_pci_driver.h>
 
 #include "sfc_efx.h"
-- 
2.51.0

