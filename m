Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E13CA1015
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 14:11:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 117324275D;
	Thu,  4 Sep 2025 16:11:05 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id F1915415D7
 for <dev@dpdk.org>; Thu,  4 Sep 2025 16:11:02 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-45b8b02dd14so7902645e9.1
 for <dev@dpdk.org>; Thu, 04 Sep 2025 07:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756995062; x=1757599862; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=CjWTfURwqYNTbPzNsBia0X31za1aBLnvzaWRJgp/Vzs=;
 b=nm6N5xIFSjnzhNYURNL6vFcBPfv/3kDgxxHO2TOMbkllWN7I2+YCTDpcflgObmJxuo
 +HO3oh5+KTVawHM54FuxIGbppjfSa9ef+2W30WRdSffUi5uVJ5HBYX2nx0U9mt1SFvXz
 yy2P40Bg4yI1XJzzQk7G7hG9G8JNKgXse0gOsSCBb2eGz6v5HFQ3rLIGrAdDzClFAma2
 rIlg+6FLK79q8eyVBX11gKde35qVwX/9q4Nv7hdsskw+0cazKVxTQzmBACH8I/J2h96/
 EyYR7QMf95LANaxbM4IYi/5JfSqsoLdSSnmjjPX6ZE4+Y8NMA0v9YRG7EXp7tRkN68in
 um2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756995062; x=1757599862;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CjWTfURwqYNTbPzNsBia0X31za1aBLnvzaWRJgp/Vzs=;
 b=RfPYXjrWVe32zzkeyX3K9UCtA9sjxhj0tHTHPky/WFINzov+PJksJmEGXu+lScrP43
 B0x6XLjM6nL4rnLa1Nkh0Go54PAs9WMm2tDSGZZmOLIRBf0wa5pY+SI5yUZL1mZUckax
 xSPTakO82cnDsUA8tbK68vNRmk+3exuIlVdgz6sLol/HGC98oMD2YCtcYREDfh/LpLYY
 St0ExbA9iiiHzbOfK7eMJoVpQ9ru7tcNtslTcJJh9RBQVNMNUGhYoHXBCTmxDBt0P4q+
 7GC+NdmeNt8c61IZi0ZoHHs76xgQCXSI03lEIDNYC1B45ja1GsHOPSsVRfzVM6o7eCLE
 5R3Q==
X-Gm-Message-State: AOJu0YyOe+eI1x2ikzCq4mPvJOcjkLAhc/9ssFKKjLBxMUcBvhy+GmBR
 2Q/eIBjJhZZxq0Jyh+RTVLK6JSamC5V+t6/AHPMiHKGkSDTJW6Cnt7nvlL016w==
X-Gm-Gg: ASbGncuwpsLREcP6byjv1gG/whnD9Aa3eioZaLAYokx/0KxN9SEejhLWy1x1ctYLqd0
 rgYEBLFKsrFHIVHrI89g/YCqZechEwsjDQ1F6KFLxmeqkVHBL1FYiTR8JnCL4pYlLu3KtbH/W6B
 vUGCsDJsS9Ku7CBuwuPjqz+XXwN6Nn9bvOe/VHhon/4E2nHu9TeHcSPveI+hLV7lLPXSjQxIPz7
 ITQ4geO22Tbqo0VA0iN3My6aIguERguE1KKfy1OsrMnyGLInZpRLX8zpvfssi0U+SSXE6RExvR/
 CcA19Ah+oTJ8brdVLhrfLv9W/7OclJjtPyVQEnefmjbxXH1tx8KjfaX3c1dLfDHPS5QrO6wPAaF
 eb1aJqfsDNvPvWmjrDQJp754Uedf7
X-Google-Smtp-Source: AGHT+IE0dz8JilsyGuMw3FpcgL2Xu5PLFS+d+RERR+n9c0VBXAQG599ziC8HL0aetzWA9am8bFi70Q==
X-Received: by 2002:a05:600c:1ca9:b0:45b:8c3f:7d5a with SMTP id
 5b1f17b1804b1-45b8c3f7dc6mr130534055e9.4.1756995062132; 
 Thu, 04 Sep 2025 07:11:02 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:8ca1:db3d:f1ea:cfc9])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-45b7e7d1319sm318823065e9.5.2025.09.04.07.11.01
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 07:11:01 -0700 (PDT)
From: luca.boccassi@gmail.com
To: dev@dpdk.org
Subject: [PATCH] net/zxdh: fix building check for arm64
Date: Thu,  4 Sep 2025 15:10:44 +0100
Message-ID: <20250904141059.54626-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Luca Boccassi <luca.boccassi@gmail.com>

The comment and docs say this should be built on x86_64 and aarch64,
but RTE_ARCH_64 is not aarch64, that's RTE_ARCH_ARM64, so fix it.

Also the check makes the build skip unless RTE_ARCH_X86_64 is true,
so switch it to an 'and' instead of an 'or', to build on both arm64
and x86_64, and skip elsewhere.

Fixes: 29e89288ff14 ("net/zxdh: add driver skeleton")
Cc: stable@dpdk.org

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
---
 drivers/net/zxdh/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/zxdh/meson.build b/drivers/net/zxdh/meson.build
index a48a0d43c2..723697551c 100644
--- a/drivers/net/zxdh/meson.build
+++ b/drivers/net/zxdh/meson.build
@@ -7,7 +7,7 @@ if not is_linux
     subdir_done()
 endif
 
-if not dpdk_conf.has('RTE_ARCH_X86_64') or not dpdk_conf.get('RTE_ARCH_64')
+if not dpdk_conf.has('RTE_ARCH_X86_64') and not dpdk_conf.get('RTE_ARCH_ARM64')
     build = false
     reason = 'only supported on x86_64 and aarch64'
     subdir_done()
-- 
2.47.3

