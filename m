Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A15C98302
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 01:08:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B03842EA3;
	Wed, 23 Sep 2026 03:07:54 +0200 (CEST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mails.dpdk.org (Postfix) with ESMTP id 8D556427D7
 for <dev@dpdk.org>; Wed, 23 Sep 2026 03:07:51 +0200 (CEST)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d9336581a2so6306355ad.3
 for <dev@dpdk.org>; Tue, 22 Sep 2026 18:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790125671; x=1790730471; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=59V08zhQKlIVEpQciRZKWHtzcm87oqRZdFHT5e2Fr9w=;
 b=Bw4cjVq0zTO0sNivu4/g3nn88musHuzH5iH5OA2Q5h/zbi96wxGYDmZyLijVl/dWMO
 ibFx02OfVqQZ3UUZDJ+3xPsRqHWLfx071eFQLnP84R48xQlcWV2pMF7fGqpUjHDffhYw
 0Bq82OitFKxIxmMXr/yxgR0o66qJkrk7XzZu5vxtoCBUF9LWwVz1EIte8K2sijrknjjG
 abR0bMD+KBflkbaEfXa3zOM6EnC2retL4Y+WM8+w+BsfvfHsXDYuTlSIGRJ8Ay+LxoXF
 PSZ3QjR5Y6MI72UhCgjWkG/UKCGEUjofSO7tcD6xnTkU7NOYiYbdYuq7uV4keWx5y5ZA
 hzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790125671; x=1790730471;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=59V08zhQKlIVEpQciRZKWHtzcm87oqRZdFHT5e2Fr9w=;
 b=BIOx/1YSNEk/dfGKyIz79wXUWpOndzqdi3/9BkFOTzTZ1qXeUZJqv5XvcjKX8qcQo/
 PvpJ8/3XipHMay1V9uPVdoRLprLsA56Iv+vOnd/Uhr6xAxpTwWYHUGZRDP2+4XDuspAU
 +am0KAOxlaThvRNY1bK1BMtLGJe7bE/erbcbvXDVY52/vRc4WRSwfrdAJ0vPVYa6x3jg
 NzCIW+gEfAwxlMv3y7GAqbkhsTg8LHt5WcbWMKU6hiCWx6HKweMQKwcDo585XT5xf8kv
 UvRkwjKyLfbm8nRbLKlHDcj8VSlU64Bj4jce3QPGZ2gGnylJ0/wzVblp0slOnVl9e0u7
 FC/A==
X-Gm-Message-State: AFuF++nrcr3FHNgT7yH7A6VlbB7xwMx11Z/tmylEp8ymhekdiWWNfQbv
 tuK/lf1mNUz6wl6mrQqgAOmYELCQvriNDMKuiy8SJ9MDeHp/Cmr/BCJh7f+X3V2mEaJvwkyVJVv
 wXH/IMXwxGqTH5g==
X-Received: from plat13.prod.google.com ([2002:a17:902:e1cd:b0:2dd:bf7a:f211])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c94f:b0:2dd:c100:942f with SMTP id
 d9443c01a7336-2df69dee3e5mr9953955ad.45.1790125670500; 
 Tue, 22 Sep 2026 18:07:50 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:07:27 -0700
In-Reply-To: <20260923010742.2468145-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923010742.2468145-5-joshwash@google.com>
Subject: [PATCH v3 04/16] net/ice: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
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
 drivers/net/intel/ice/base/ice_osdep.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_osdep.h b/drivers/net/intel/ice/base/ice_osdep.h
index 5d92cf5aa4..3ef52eae6d 100644
--- a/drivers/net/intel/ice/base/ice_osdep.h
+++ b/drivers/net/intel/ice/base/ice_osdep.h
@@ -311,13 +311,12 @@ ice_hweight32(u32 num)
 	return bits;
 }
 
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 #define DELAY(x) rte_delay_us(x)
 #define ice_usec_delay(x, y) rte_delay_us(x)
 #define ice_msec_delay(x, y) rte_delay_us(1000 * (x))
 #define udelay(x) DELAY(x)
 #define msleep(x) DELAY(1000 * (x))
-#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))
+#define usleep_range(min, max) msleep(RTE_DIV_ROUND_UP(min, 1000))
 
 struct ice_list_entry {
 	LIST_ENTRY(ice_list_entry) next;
-- 
2.55.0.1082.g2b9226bbc0-goog

