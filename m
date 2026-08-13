Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7207C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 17:23:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9099742E59;
	Thu, 13 Aug 2026 19:23:13 +0200 (CEST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mails.dpdk.org (Postfix) with ESMTP id C402A42E61
 for <dev@dpdk.org>; Thu, 13 Aug 2026 19:23:12 +0200 (CEST)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc88e22f92so2710395ad.1
 for <dev@dpdk.org>; Thu, 13 Aug 2026 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786641792; x=1787246592; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PNl4YpY61Cs/k/xCtC1o/bXFNRZDieZTETSDYZ3XE8k=;
 b=hH+gUka3SOjXwkEaD5q5W+OIokAOK0TOCXxZLSyrgM+uSGH8c3MrtCXqc4yn7l/qUB
 EKk7urH2fOu3/xMwD0VAKyqq7MU5JrAO2IQPQ4PNTpPu2aGPUhtxO80tp1865G1sKh9D
 2BjKvn1MMVlqCkKeU/RgPuWEvMkBr5ZNvb8MfN3GFM4TJByKWpZHSvt1RUx7GVJOidpO
 dhS57d6eTOsnaqHxvOOl/sYGPCOdj1dKpg8XaXTU3IKV4R10ZqQLT+d6AWvc2ISWZ7PA
 ICGXGy5gma3fsLq35BbEgrss1v4f7B3/CJyJhWcwaM/y6ExcnxMczwRZiabkdQoSvclS
 C/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786641792; x=1787246592;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PNl4YpY61Cs/k/xCtC1o/bXFNRZDieZTETSDYZ3XE8k=;
 b=NV8Kt4Kwf83hJQmhDt0P8OEJ70rsYSXK92X8PDx2hwNicIjwKrhtNPtNku2e02xbMZ
 xuznP6N6wqaSiqqwh6cQPa9HDN/FPTGEfJx3R/0TWvbzlCJ5imhLCua9h7uNwh0iFVMq
 I8EQlNcIE0DSZnkGPaeMnhk9BMh187dJlo3uApXb7XsdV85LvIjId0pU7JlY6VlEi6eO
 yx365ub6W8YiYCGPWA5iwcfJRx8YK4QL41hsA+9XemUtQFnnaejz9aGjUD4UxjLHIbZR
 nMvmleDz4zQu9VUKkgD7bjfjEVI9ElD5PVvREVo1jFVUx0dPWDHCYKI5azgIPgl2UwMa
 REPg==
X-Gm-Message-State: AOJu0YyUoeebNJ/DTEvdB4NTYcblQEtB+WIvJ8hbMQxjIzAyQLUbZ69z
 YWiI7DORI+PpgogoZqdOoHD0PiaL0xIwycJl4Ua8jpzJ1V5qYhdGbWSx9IhCJoKo6OvwtAjzCAp
 t4Q4Ny6TRqcIFZw==
X-Received: from pljf9.prod.google.com ([2002:a17:902:ff09:b0:2cf:2c6d:ddb8])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f651:b0:2c9:c991:3bf0 with SMTP id
 d9443c01a7336-2d37d581162mr92023085ad.8.1786641791719; 
 Thu, 13 Aug 2026 10:23:11 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:22:37 -0700
In-Reply-To: <20260813172241.964736-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260813172241.964736-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813172241.964736-13-joshwash@google.com>
Subject: [PATCH v2 12/14] raw/ifpga/base: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Rosen Xu <rosen.xu@altera.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
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

The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant.

Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/raw/ifpga/base/opae_osdep.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/raw/ifpga/base/opae_osdep.h b/drivers/raw/ifpga/base/opae_osdep.h
index e35a21c80e..b0045a36a0 100644
--- a/drivers/raw/ifpga/base/opae_osdep.h
+++ b/drivers/raw/ifpga/base/opae_osdep.h
@@ -71,10 +71,9 @@ struct uuid {
 } while (0)
 #endif
 
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 #define udelay(x) opae_udelay(x)
 #define msleep(x) opae_udelay(1000 * (x))
-#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))
+#define usleep_range(min, max) msleep(RTE_DIV_ROUND_UP(min, 1000))
 
 #define time_after(a, b)	((long)((b) - (a)) < 0)
 #define time_before(a, b)	time_after(b, a)
-- 
2.55.0.691.gc56d675ccc-goog

