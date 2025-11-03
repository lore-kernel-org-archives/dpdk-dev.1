Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1039FCCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:51:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7129840DC9;
	Mon,  3 Nov 2025 17:49:50 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 872A440B8C
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:46 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-340bb1cb9ddso2199343a91.2
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188586;
 x=1762793386; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BObaC8WUuvG2KwThOdqHfo02l/XzaVEj8lrRY2Byk8E=;
 b=D/6yTHcTZR3hr59xCF8zg1LvCUUexT0clLE4IyaNXzIoON6qdBEnJdSKSD1sk1wmp3
 ZhW/bixCRXzrWNw4IQFHxgo5ubothnatqxmz36e5W/mrbhzj4mpuuS8C0wmQ9sHkx9BQ
 36WPHBz/n4nTbaT/hblKg+dN2/6S7PfQVTi7Dyw1vuvaeJlEFNlnRKSVENtZ6jTpa3aZ
 JF4OjXVmyl63sx2wQ0b6M0x04wZEv0zPg3z7+FRRwNOPEVraf00zEbUsyHIgvOIUxozv
 Piciq3H39IvpOOdCRnJpFMBz51UaoA8L5xeFTr4W+2CFsquUzW0Gv4wxC2U1+ZIFXBmi
 uSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188586; x=1762793386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BObaC8WUuvG2KwThOdqHfo02l/XzaVEj8lrRY2Byk8E=;
 b=rLxabNPLtX4ENBaET7/Mh/lpAhvYggfzB2hJXGvPoVfNb/WglOkFaGgH9M6Oi2BUnf
 K7e4zpCsMJeX9+EfdK5473+pcRBY4T+A917eGMBEUUGaYvO4Mgd+KqSvZsxNMJMLU+67
 l3FHgOTJlcUjOzMN6AXlVRV5EjQByx+LJwdNLx9EuakbgjdkMedAx5gXvJtLEx1rcDd3
 8oq1M8OickgSycCcFKLYwLtRSim+ZiWEQLhDj3lo3P47fGWgyKNJHoyEVmkEsXp8eTRm
 NGGK68L7e0hhqRFXp35ncF0Y88PPc/ieQz0b8EdqwUx0pDE5mIa6cEwEOG081EQZFCYl
 h+6g==
X-Gm-Message-State: AOJu0YybrJrCTx6C85NhbpTc/MkbsxRaKX/sTvoJHEt7b7rqjR8TW49j
 k9D5Bz7dsBTdEVtrDokLI3IIOZmKjoE9lZHQZfF2eYL6cbhk83JGw6u7fIaVB3b6Swl2pylvZMP
 P4Fem
X-Gm-Gg: ASbGncspcG7c3IUp9Sl5QETKO+EfO4gapvCWoX7uPFPMU8/wclf873BZBfYSDUvNO45
 dM6UYPQLZTpxiKNNym2YjJOLLaS1qVsu0EWJ2bJcfHQE8ssNx7KhyloXE439LgZ23l1jRFL80h4
 Cw0p0m0pCiEept33HRs7BHv9bYqy/JGem9/7B6bW/haVCBJNsj5xUGM9RgOISQUsFyuria2QZgL
 2xFmu/0+PMjMs/kN6ymxRz5e3haOIprTPl4Sd8u3cI4riNaxWom8ksdEaBsY8vR+wzEKVrivYDz
 tlbh3m/uF5J0xV0MUPv8qLU8E0PaFHM0l6pKWukXSIjlgTKP4WQhFuvsknjGFo5qjVE0yAt6hIe
 rqI6vUFPwNv7UFKDwbL6ezm/fUGT+JtRF9lYqYRvLFY+JPFBQTFEihZnki6i98BSR8LziGEm4+D
 Ifz+ZlJuLWwXZ9ofJ/UcugXiEaCK/cEyGH+EYk8PM=
X-Google-Smtp-Source: AGHT+IHC9XpuJLu3K/XQii2qGvg5dawydheWYrDOkB6B5C4Z2eJ3/c8gCrM9avlWtNSSKpLj3pTq0Q==
X-Received: by 2002:a17:90b:5150:b0:340:48f2:5e2d with SMTP id
 98e67ed59e1d1-34082fc655dmr16231894a91.9.1762188585538; 
 Mon, 03 Nov 2025 08:49:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: [PATCH v3 18/44] net/mlx4: replace use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:23 -0800
Message-ID: <20251103164915.101713-19-stephen@networkplumber.org>
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
index f68eeb991a..38ed78df9f 100644
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
2.51.0

