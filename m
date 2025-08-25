Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363E1CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:45:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 104CE40E1C;
	Mon, 25 Aug 2025 05:43:12 +0200 (CEST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 24B6D40E17
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:43:10 +0200 (CEST)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-3c68ac7e238so1105139f8f.1
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093390;
 x=1756698190; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5hEdrxl7nrrT91gQ6oGEDa2efJqk0JcYQNOZ6MJ+22Q=;
 b=lwmQV3WW1Qr4ebOBmvLOr28qrlh3usucGMIRkdJHimdGvIkiPhn8LiJmePS/tIhFq6
 MTqmV2rRCbJWbtcfJaGo5kuJwNvPqLGWCOvgUtf+ThSz1+NiE/4g9HHjFS6U7Aw8jONq
 2DXbzE2FFxO2nOL3c7Nb5emH95i3Pm/eOP1tG6fW5ciCMV1mWPj1js7gugNqZ8YNfgLA
 hw54IWuZYIZdqRGZLDWmg+KTfO4BNrxCD1BZta5kbfr7DKPUfNrqE4L1R4B/x55fUw2F
 kLadjZfxomtSArty4fnstW7r9GqnMaxP73VHuf+ukm+GyE696MonbTkyUTFoQgS365x7
 R7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093390; x=1756698190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5hEdrxl7nrrT91gQ6oGEDa2efJqk0JcYQNOZ6MJ+22Q=;
 b=mVRZtI2s7WOpbpJt351CPewWTq8frMMFKwwZV/RQBI1n0cKLJ15O2q1dfmodTx+SDY
 Q/Q9kc82X7ZpUznDRhp623oNnq730WTLusQt+t16gARXbxULbuhNt826nUVbkaYC4btb
 rW7m1UtQjnUeTRHm5sg8+pS09Sjjg0pwkGPAwaeQUJ2hqTloEybn6eH5ZyN0kTONtUhS
 aNKEcfahEgDcQjOVN9xYLO4u6d0muOg/nTU9dQQ+K3Xq816f5P+Q24bm2e4/3E7Qekjl
 X0iQHpHkkHGE8uo61yyLyvPab9pwJQEVBsqYQ8K69ieBRa46rQ94VQAMZkwgC79/FIJI
 cI8g==
X-Gm-Message-State: AOJu0YyVi6vKvMbP9VsYrlP9tgAwgZ1PlQ99R4I6Fc2z/sE3USfnoc/3
 2EER3bKf7428KDh7TDA+mVFObt//1Ae5VEAtIOJP148mDZy0O+3nXqCeJytWiPFtWQ0ZlnWEfhr
 FLr4R
X-Gm-Gg: ASbGncsFjK+9lbGcrMk55/Y1aXcxKJbDi6OGVIGMZSU9DTyoSVVpU0KDmc7cEiW29Ax
 heDb8ep9xzUiGITS71ID0dNBH2zo0iHFlvksjCtq89qB/w2s5aQVIQ20OlzUYcGKXvTj7ofw3rI
 EgzE8u+l8NO1p/LL+/Nmqg7l0VvAYh8VYXHePCFJ7IkMZVvXaQpjf/UbSyOFzRlDJhtoUojRHNi
 uf3OpguSjgAQWnjWBBpRzQ5raBkoUKm6KPXgI4QukoaidP6LoxWL1QV4DkmpvGr2yVnv6Mnh+dE
 r1zRXnJ5DlL4PMqOilK0A1+DkQYNvSqY424VgXUAKY+ufOE7nQn673X+nrKqkraaQhPgpUw+F9N
 2f9DiuW59AMJnL1XPuZx+n7ZEg2O1p9Y3EeN5uVQMU4lhawbPMb+nwaEPBZbtQcfsOam0tyXnb0
 L8BJlLKa8=
X-Google-Smtp-Source: AGHT+IHyWdPg6++f1NrutI4WbWjB/0IjuFJuAedPxCuW7/+H3bUx0OJszcXt7Spz2m0UtthTNwKZWQ==
X-Received: by 2002:a05:600c:4689:b0:458:bc3f:6a72 with SMTP id
 5b1f17b1804b1-45b517954femr87267025e9.4.1756093389773; 
 Sun, 24 Aug 2025 20:43:09 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:43:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Vijay Kumar Srivastava <vsrivast@xilinx.com>
Subject: [PATCH v2 39/43] drivers/vdpa: replace use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:52 -0700
Message-ID: <20250825034126.12046-40-stephen@networkplumber.org>
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
2.47.2

