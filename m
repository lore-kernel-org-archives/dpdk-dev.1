Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF69FCA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:43:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F36E04067D;
	Mon, 25 Aug 2025 05:42:39 +0200 (CEST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id 3EE3940611
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:27 +0200 (CEST)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-3c51f0158d8so2825597f8f.1
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093347;
 x=1756698147; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rPViSPyGiMb8IM/BD29sU9Gu1wiqH0hd3f5ZSCAMPM4=;
 b=zrXnEn/uufdmR/rnWiKEynjzPrhsfTWOKkuoPMyOh6Q7y7eQfQabMhoy58iqnzjm2f
 wYOi0U1xeecn8FyISDuHLJmtTXQVeKfpwKHx7gR63RGXel2xGHyJoseVLwUgVmPkwQvK
 /TkVLlxQtL6w/g2ZE17TWqOKSyFspMkBmlt0NpM2SLoNLbtodiOdjL1H2g5VXvuZkd0a
 I2brLZO4bw50Qygl9s2w4tYbaPuYcekts2LIwJHZfIXSZh0JZDf4YN1O9igVf+ut8UEp
 JvAKTgcSRiyBGcOe6jnp1qCpTj4BMivlk24u1BjDVIK5vWD7+38wQnQqAjUDnM/nQu9W
 nSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093347; x=1756698147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rPViSPyGiMb8IM/BD29sU9Gu1wiqH0hd3f5ZSCAMPM4=;
 b=StSa5/JQFKOBIXDO2b6FUsYHIrTP54phF6OJuCAYQY4b9BvReuM9DRgiAlnF++eOVB
 9io127wsn1AMHZRiS05llIlerydC3dnU5+vGBrX+X9UHUe4pArjKqXyzV7zOOlDMQpLB
 FTz5HatL6NUjIjQdcjZPe0r0V3WdZr97fPq7Z/qXAh5jnGyk6JZi9yDrm4wDZKsXgw2u
 EyDsBLfvh0HVu1nXy36zGFUTnhEq+uMlB7DkslYuVnuOdamiwv6+8fjYH037H8S9Gwe0
 ouFvwzFJGZuD0YG5DHizbAi/rUD2hdCYase1mGmEhoSFGyLy0kGEYkX3Udenw+20VG96
 41EA==
X-Gm-Message-State: AOJu0YwthWrX3IIoC1JaRTaT4sUeDBj3fp1sPZCT1pTh6Mjp2rQ4S/Rq
 QVJ1JAVgVN8pcmEg1OAROCvF8J0MCM3nfx6GeE1I3wPzVsyKsdbeeBemETmQtEmmh7qvkVs3cVv
 QU9S1
X-Gm-Gg: ASbGncv9kkoAwtIhnNWsrkHfbPuOaHQ6QN5wioEWotM5o71iHaz/rBTeUOKs1Gncim0
 hv3ne0xpFdHhMmHFazEwDnea5E/AQK+JR5ww0TkQN29Y5D1RcbMdxr+3aD61K0wyKpJy4DCABve
 X0LbB9pESMb9wXGBXzTK4FvawNacLgp/O3vlZKz6/VCLs+MPjqDitGoxq43XuzmdmPL/nOM6KIz
 Wy2rwAc8xDYnEMRkB216JO9u2oRi217kqK6wHJ1O2IdAMH7WMdPEndknGTprVRzqjv2k4T3/mgR
 vae0kGbmf3Y40FYhH1u6EfDHp6k9kRwojgU0Yp3Gb2R0f/JcivZhdM++M2axy1TztxtBhzLE55I
 pMmK/oK7mUaxrf3xXoGSouyZFb9Pn0lg/c43+0Z7EzY1SXnp3EvICs8WGkiO7DwpMeBPliJLnOq
 aNyAhw0BY=
X-Google-Smtp-Source: AGHT+IHFk2rq5e3fP6jIvV1JZbIBpK7Nr6utxQtuRWweJ7Z1ai+UJgVa8vv1X3RzSykdmGn6G+KPfg==
X-Received: by 2002:a05:6000:2892:b0:3c8:cc6e:f8d8 with SMTP id
 ffacd0b85a97d-3c8cc6efc8bmr2433511f8f.45.1756093346872; 
 Sun, 24 Aug 2025 20:42:26 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: [PATCH v2 18/43] net/mlx4: replace use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:31 -0700
Message-ID: <20250825034126.12046-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825034126.12046-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK rte_bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mlx4/mlx4.h      | 1 -
 drivers/net/mlx4/mlx4_flow.c | 2 +-
 drivers/net/mlx4/mlx4_flow.h | 1 -
 drivers/net/mlx4/mlx4_mr.h   | 1 -
 drivers/net/mlx4/mlx4_rxtx.h | 1 -
 5 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/mlx4/mlx4.h b/drivers/net/mlx4/mlx4.h
index c992a1c5ea..67768f3e56 100644
--- a/drivers/net/mlx4/mlx4.h
+++ b/drivers/net/mlx4/mlx4.h
@@ -8,7 +8,6 @@
 
 #include <net/if.h>
 #include <stdint.h>
-#include <sys/queue.h>
 
 /* Verbs headers do not support -pedantic. */
 #ifdef PEDANTIC
diff --git a/drivers/net/mlx4/mlx4_flow.c b/drivers/net/mlx4/mlx4_flow.c
index b520664d95..44181c0aa3 100644
--- a/drivers/net/mlx4/mlx4_flow.c
+++ b/drivers/net/mlx4/mlx4_flow.c
@@ -14,7 +14,7 @@
 #include <stddef.h>
 #include <stdint.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 
 /* Verbs headers do not support -pedantic. */
 #ifdef PEDANTIC
diff --git a/drivers/net/mlx4/mlx4_flow.h b/drivers/net/mlx4/mlx4_flow.h
index 5e82df6bd6..a27317432d 100644
--- a/drivers/net/mlx4/mlx4_flow.h
+++ b/drivers/net/mlx4/mlx4_flow.h
@@ -7,7 +7,6 @@
 #define RTE_PMD_MLX4_FLOW_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
 
 /* Verbs headers do not support -pedantic. */
 #ifdef PEDANTIC
diff --git a/drivers/net/mlx4/mlx4_mr.h b/drivers/net/mlx4/mlx4_mr.h
index 56dd73ff19..7fef07d6f9 100644
--- a/drivers/net/mlx4/mlx4_mr.h
+++ b/drivers/net/mlx4/mlx4_mr.h
@@ -8,7 +8,6 @@
 
 #include <stddef.h>
 #include <stdint.h>
-#include <sys/queue.h>
 
 /* Verbs headers do not support -pedantic. */
 #ifdef PEDANTIC
diff --git a/drivers/net/mlx4/mlx4_rxtx.h b/drivers/net/mlx4/mlx4_rxtx.h
index 70f3cd8680..c68375b088 100644
--- a/drivers/net/mlx4/mlx4_rxtx.h
+++ b/drivers/net/mlx4/mlx4_rxtx.h
@@ -7,7 +7,6 @@
 #define MLX4_RXTX_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
 
 /* Verbs headers do not support -pedantic. */
 #ifdef PEDANTIC
-- 
2.47.2

