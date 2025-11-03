Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C12CCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:53:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5706940EE1;
	Mon,  3 Nov 2025 17:50:17 +0100 (CET)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 96DAA40E43
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:50:13 +0100 (CET)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3414de5b27eso539462a91.0
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188613;
 x=1762793413; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwAj2o9TG0XuUH2YaTzx3ePC7f9+iiB70jK+kiK/v9Q=;
 b=VXQHNge7j0lXeOcWL+l1qcyKL0cmRhsHgLXHsz0GBEGARsGfXpz3FQvgwhG3ATzZ/W
 jQZYZBRV9bS2902Az+a77NTyoIxAtRsO/nKyxC1o6ezhfPdoYbs60Tue6psyaZb5sKSz
 k8x/mIn0aYOriUI2Uw+jTbS2QV1oED/vom2Fk9k53Bs6nDhzEoPtyDqT+JD9jkDEeVef
 dPnp/Gy9AjOJNpnEPmLBzTEwtCzVdswVEff4fEOMfhZm4Ar8S66Mzvp91YC3gG5eKFcf
 zKgPPvxDtyrRD45wZweq4y19NvzAwdc3kfvo+6PEj75LdJggKnIHsQqHl+F6nCfHRadg
 UPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188613; x=1762793413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uwAj2o9TG0XuUH2YaTzx3ePC7f9+iiB70jK+kiK/v9Q=;
 b=VxYZnBisADPoqPpU34kXcx12Jmj5cOdDupPr/0KYjR/haTC7N1YXpePXkN7yOD1+Vx
 nJVbZJxzcKELA323mEmdxbQjZdnRDpj7ev6ImNkuU2z+AXKKV9tPxLNpbRox5ourLyZw
 pp+Mi6m/o41HcLU4uradZoWiPPsBaKuvbc7/1lkRBCcOyhFL6lW2fvkQQSr1354030si
 3+heKDkwdFuUI8Mvar8lMZ71vznre1IX5hbtQ+OXUM51otVaQznbKBSsl4J2AAIqNRNJ
 Pp6TcyprfNocTRktKP3pRCdLfjjlzuIQ7u+0yuKb56VXccwTvpGi2/teZgYx7ZENyWdP
 pVTg==
X-Gm-Message-State: AOJu0YwOTfK1vRfNS59iIWzfbrsHyXJQe5pHcATFuvfPbVNAegm2DsES
 /bLM7CqY0CKJn4GBAoxMa162pShHPImb6xp9fWVSnjXHDYJ10Cb/krlY5CiwJuUxzYOZro4zwTa
 97wno
X-Gm-Gg: ASbGncve4rSJXEVWshkVMuurtBK1jhyqtO3VBZhwrcOuwH0lPHNEjb48y10MaiGFGTA
 8/UlT0GqQwRWMnt6WgvsLDCWjUCTifS78+Pc0uGa6l6Dm2bd8LGGtC60dRCscKjj9nnmHZbWrFu
 /owp/WFZjGisfBIw28Tm02FwYuu1g1gMOeTFFjEYfCklzo7jWpqO9O38v9eyq8AY2lQKD4+ym4V
 AZ/IZNlheFlyT58ZXpSrLme1Ov8sOANmTMClPkmKgkON34wf8HdF0n9ZMZughDedAHBhAaJNM2Y
 j4d5AfhlSjWGczGoz5KwYEB7OqnCMJZgDBHdBYkb9zuPomcnj22uRdHNAAx47Q4su7EQbuvNofX
 qd2PuicWPeWmHTrMyH6i0wZq5+B4EyrA04cnQ6PFLTwAIpWo223k2kXv1QQ9WXH+SHUEJKBJM6G
 207WsoxCfn2L6I8QX5DioWWGbsAkfVFjp7YpW95N9Mz+4T1gxE4Q==
X-Google-Smtp-Source: AGHT+IGxmOiGT40nkClCF2wWnZPBTEUoeeH3vLIgjlEl+kUVzfdArKqSu6dgf5/TSwcSsdkVyv5VJw==
X-Received: by 2002:a17:90b:3ec6:b0:32e:a54a:be53 with SMTP id
 98e67ed59e1d1-34082fe197fmr19253431a91.16.1762188612712; 
 Mon, 03 Nov 2025 08:50:12 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:50:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
 Liang Ma <liangma@bytedance.com>, Peter Mccarthy <peter.mccarthy@intel.com>
Subject: [PATCH v3 42/44] drivers/event: remove include of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:47 -0800
Message-ID: <20251103164915.101713-43-stephen@networkplumber.org>
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

The system version of queue.h is no longer used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/event/dlb2/dlb2_selftest.c   | 1 -
 drivers/event/opdl/opdl_test.c       | 1 -
 drivers/event/sw/sw_evdev_selftest.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/event/dlb2/dlb2_selftest.c b/drivers/event/dlb2/dlb2_selftest.c
index 87d98700c9..b085a3407d 100644
--- a/drivers/event/dlb2/dlb2_selftest.c
+++ b/drivers/event/dlb2/dlb2_selftest.c
@@ -7,7 +7,6 @@
 #include <stdint.h>
 #include <errno.h>
 #include <unistd.h>
-#include <sys/queue.h>
 
 #include <rte_memory.h>
 #include <rte_memzone.h>
diff --git a/drivers/event/opdl/opdl_test.c b/drivers/event/opdl/opdl_test.c
index 9b0c4db5ce..b6fe99fbcc 100644
--- a/drivers/event/opdl/opdl_test.c
+++ b/drivers/event/opdl/opdl_test.c
@@ -8,7 +8,6 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <unistd.h>
-#include <sys/queue.h>
 
 #include <rte_memory.h>
 #include <rte_memzone.h>
diff --git a/drivers/event/sw/sw_evdev_selftest.c b/drivers/event/sw/sw_evdev_selftest.c
index a2ce14051c..18ef5f13a8 100644
--- a/drivers/event/sw/sw_evdev_selftest.c
+++ b/drivers/event/sw/sw_evdev_selftest.c
@@ -9,7 +9,6 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <unistd.h>
-#include <sys/queue.h>
 
 #include <rte_memory.h>
 #include <rte_launch.h>
-- 
2.51.0

