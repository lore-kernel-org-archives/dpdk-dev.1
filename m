Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F83C55182
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:54:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66DE340B9E;
	Mon,  3 Aug 2026 18:53:32 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 485B340A71
 for <dev@dpdk.org>; Mon,  3 Aug 2026 18:53:25 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2d032846c95so39819595ad.1
 for <dev@dpdk.org>; Mon, 03 Aug 2026 09:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785776004;
 x=1786380804; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+4Lod7esgwoloXCt6rGhR1rOmj8JmQPwx7czXDdY0ZQ=;
 b=XVgPtXXFWKV1e5mxG2UvAHFxE856jmAWuZZIWc2bcPI8K8WQ4t/G0eOZu/0AbLr20j
 E8XqG076D1Fu1uiyC2SB0xT7vdWHJukGmeq/i6U/ilqW5Sxlk18nkDwV9QBsM6UpS55u
 CHYsrf+H6lfd8RcalADp3VmqjiF8jJ/mqNm0v+dQZdkz3X4ClHeDSK+TBieoOxYGGi9i
 fRCEYjmjw+Pw5Yw6v781bxzkTQaYKp8JtquswesQBTRRykYr/mAq/12GUrzQc7zqz/wq
 5N+spHICnws9SrROde2JVOuxmJAFhmWUnMD2s4xfGvRVIXtAxngkuZK+BuX2K69o9UnW
 rL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785776004; x=1786380804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+4Lod7esgwoloXCt6rGhR1rOmj8JmQPwx7czXDdY0ZQ=;
 b=I20YpYfY/sRmt/1DzbJctBDB2Fo/inHJOMPyYVTky+X4kUsOI782eONzFb9fenqQQJ
 W1tIhTkAHtB0mmMRQkJhi6YFVEHUAg8Kj7tx+QYoSxvJTQ7+xyKXJxylmYDCVv9I4bz0
 EwRZimCHrzMN952G1W3ipdkL+cjKPW2BNole6XpfpVl4W0I63i3yhRIljHsMGSkXU35z
 97YhqrHY42bDwjO3EOSo3BWz0OS8F1wTYxFKev7N1xNGOZfBLsQqw9mcjNz1OYwVlulu
 utfDZHi7eT55B62Bnz320tp1TnYnbVp1jflYqIBHBhZkx10+PwK+lcVsuBqKMp+i7v+A
 l1Rg==
X-Gm-Message-State: AOJu0YwTmx76Seggw/bz0YEv9gem2xJVeoW30t5eM4/nwuJk3sDSGzIT
 ROd7ETjfQPhcgldbNLQrwB8Xcioxn8MGkjJ0KpR6juKx3r5OHnufIA3MiHqt/lHYPI2kNV9Uy19
 YIS9D
X-Gm-Gg: AR+sD13PQ6FTsfoWVTEcloZ5A8rVRC7nvsILNOjxHqu97wItPtlpxMgms62yo0N8Zgk
 M9XShzV7gCGCy67F8CHStEPhTl2DWXMNqUSMyJOHhpATLVEX0gfsZfbUdEHNJPAZ+IC1srqrOuM
 5EiFnojc9uLi17eUf9u5RGEpGDTzV4K6NU4nKUg9VyoyWlodY7lVfNCAC52kNncZQbggry4rIoj
 MrLcYcaRXSB/AaJGmQm5uaR9e7I3t/wpW8/qSwM1J+zNgS0GzFJZG05A+3KNHWf8o6WzaFTMRoI
 g5la3mqmrv74acrkB5Uu85H+6b4/f5aGCAZf+HMAPzYEAzSiLVuOZXHtDqIM+PYUnom1WmNsRe4
 JuxnjaB0GGQZgDwHM+vqv7xD+APbb0EZ0YZpigrApKAmMux5FOxJ2cbPlj2DmMpl2TIXjP+/Mlo
 pdQV18FwmsPcmOch7AN8/y5UNFaOlnNAeLx8GVH4TGE7zRIhl0hCoNZmHDXewMi+moi0KIbP98x
 DGtg5a+TeGApDHe1lWvtdk5Wr6Wuot3SyMpuA==
X-Received: by 2002:a05:6a21:10d:b0:3c0:9c19:6586 with SMTP id
 adf61e73a8af0-3c92a86599cmr11863347637.64.1785776004508; 
 Mon, 03 Aug 2026 09:53:24 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e5b0sm37711635eec.1.2026.08.03.09.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:53:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v2 17/22] net/mlx5: include rte_flow as needed
Date: Mon,  3 Aug 2026 09:52:03 -0700
Message-ID: <20260803165304.289869-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803165304.289869-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
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

The driver was getting rte_flow.h included indirectly via
rte_ethdev.h. This will change in future and driver should
include it where needed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mlx5/mlx5_ethdev.c | 1 +
 drivers/net/mlx5/mlx5_flow.h   | 1 +
 drivers/net/mlx5/mlx5_txq.c    | 1 +
 drivers/net/mlx5/mlx5_utils.c  | 1 +
 drivers/net/mlx5/mlx5_utils.h  | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
index 8160d10e7e..c3d8e1b04f 100644
--- a/drivers/net/mlx5/mlx5_ethdev.c
+++ b/drivers/net/mlx5/mlx5_ethdev.c
@@ -19,6 +19,7 @@
 #include <rte_string_fns.h>
 #include <rte_rwlock.h>
 #include <rte_cycles.h>
+#include <rte_flow.h>
 
 #include <mlx5_malloc.h>
 
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index 3415b4722e..0da50fab85 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -12,6 +12,7 @@
 
 #include <rte_alarm.h>
 #include <rte_mtr.h>
+#include <rte_flow.h>
 
 #include <mlx5_glue.h>
 #include <mlx5_prm.h>
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index f9b254c6c5..f0b7b2d032 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -18,6 +18,7 @@
 #include <rte_common.h>
 #include <rte_eal_paging.h>
 #include <rte_bitops.h>
+#include <rte_flow.h>
 
 #include <mlx5_common.h>
 #include <mlx5_common_mr.h>
diff --git a/drivers/net/mlx5/mlx5_utils.c b/drivers/net/mlx5/mlx5_utils.c
index 606743c4b7..12820054ff 100644
--- a/drivers/net/mlx5/mlx5_utils.c
+++ b/drivers/net/mlx5/mlx5_utils.c
@@ -3,6 +3,7 @@
  */
 
 #include <rte_malloc.h>
+#include <rte_flow.h>
 
 #include <mlx5_malloc.h>
 
diff --git a/drivers/net/mlx5/mlx5_utils.h b/drivers/net/mlx5/mlx5_utils.h
index 9ab79c8ad5..19d03145a6 100644
--- a/drivers/net/mlx5/mlx5_utils.h
+++ b/drivers/net/mlx5/mlx5_utils.h
@@ -16,6 +16,7 @@
 #include <rte_rwlock.h>
 #include <rte_memory.h>
 #include <rte_bitmap.h>
+#include <rte_flow.h>
 
 #include <mlx5_common.h>
 #include <mlx5_common_utils.h>
-- 
2.53.0

