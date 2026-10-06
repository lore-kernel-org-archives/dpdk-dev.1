Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A4BCA5FF0
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 02:31:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D15A040E5E;
	Tue,  6 Oct 2026 04:31:12 +0200 (CEST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mails.dpdk.org (Postfix) with ESMTP id EC02A40E42
 for <dev@dpdk.org>; Tue,  6 Oct 2026 04:31:11 +0200 (CEST)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2df5a65671eso6248635ad.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 19:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791253871; x=1791858671; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HBtoqwqkO2JwWoxrrlXh9YmRkzK3X/s+DpSfENaZUXo=;
 b=od/N1ZQLjkNhLyn8VGOingsSz0D6NVUY6ln9vj57LuQtk6FYNWbfnfsUn3kvCEW3eV
 cGwwhBHOVDWT3a85CawVxEYGcFQ7KcHfi8BCOiHunfznDCQeonrtDPf/oZHzd6SAoLfm
 C7Zv3qxIO23Kj0V3//otnI0atUxbWa86VD4df2N+Whrg3JYPbnrdU+MBav0Rn/QLfBpN
 9i5A7KqGqUVrIopKLHGQVqftsvsLCJ46rCG1F+H1kdEdoOV+jm7w/s51PdEr3+ev1438
 7yBF+FvDWDgG9ZGEJfBo224JTiflANY/ZTZnIGeHyFzuT0AZ7m6aaNR99qif5ugcZRGJ
 9/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791253871; x=1791858671;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HBtoqwqkO2JwWoxrrlXh9YmRkzK3X/s+DpSfENaZUXo=;
 b=tLV6ELDIhosoNUPCoMCYxNibBYbMrl6bpURgfHIfFLWzc5vki6BgdFpaOI/JX7hczx
 x2/yy25geH0bapHoA0YWfXviiKREdvq4nVOe91WNy/XevvEarC1SlC44Ijw1FgiIKt/v
 D17VzBoUQ/vsNa7vZnOj3MBgsR5A81Ttrfp8B0330oEbjR+ctOwlZMyYxnro6XgjeFmN
 AaJ5N55d/gY3aRXKL/AjvhA9ixcrnhxF90BvWw8tt//DuJMprYA6Ggwt7qiBam/vxmQu
 QiLEVVQ6ncMqj/HqVXyDTyzPwN5/EYev5XDTnM0pLGf50IME7rPtYemnnzUHeMkefRRi
 yg+w==
X-Gm-Message-State: AFq9FYJRzRmT/fWXrGehVXftLye7q2thvwXDHqR7WRRXvgjqHGfeL2/r
 DUTesLIRfJWQzIDsuOI2iv0qnUsTA2uGu+aw1d6hz0Qy8gndgqMe90D5G2nSreuaNX6B+C4EkDg
 Tt3KzVdnn6PM9Sw==
X-Received: from plblm13.prod.google.com ([2002:a17:903:298d:b0:2e5:b835:73bd])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3bcc:b0:2dd:b442:ea48 with SMTP id
 d9443c01a7336-2e5c539004bmr8874305ad.19.1791253870782; 
 Mon, 05 Oct 2026 19:31:10 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:30:44 -0700
In-Reply-To: <20261006023053.2572501-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260923010742.2468145-1-joshwash@google.com>
 <20261006023053.2572501-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006023053.2572501-9-joshwash@google.com>
Subject: [PATCH v4 08/15] net/hinic: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>, 
 Stephen Hemminger <stephen@networkplumber.org>
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
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/hinic/base/hinic_compat.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/hinic/base/hinic_compat.h b/drivers/net/hinic/base/hinic_compat.h
index c53b88b96d..c37d970f59 100644
--- a/drivers/net/hinic/base/hinic_compat.h
+++ b/drivers/net/hinic/base/hinic_compat.h
@@ -70,11 +70,8 @@ typedef uint64_t  dma_addr_t;
 #define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
 #define lower_32_bits(n) ((u32)(n))
 
-/* Returns X / Y, rounding up.  X must be nonnegative to round correctly. */
-#define DIV_ROUND_UP(X, Y) (((X) + ((Y) - 1)) / (Y))
-
 /* Returns X rounded up to the nearest multiple of Y. */
-#define ROUND_UP(X, Y) (DIV_ROUND_UP(X, Y) * (Y))
+#define ROUND_UP(X, Y) (RTE_DIV_ROUND_UP(X, Y) * (Y))
 
 #undef  ALIGN
 #define ALIGN(x, a)  RTE_ALIGN(x, a)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

