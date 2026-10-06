Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E13CA5FFD
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 02:31:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1902640A76;
	Tue,  6 Oct 2026 04:31:04 +0200 (CEST)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mails.dpdk.org (Postfix) with ESMTP id 69F4A40E1D
 for <dev@dpdk.org>; Tue,  6 Oct 2026 04:31:03 +0200 (CEST)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb11535e6a1so1196762a12.0
 for <dev@dpdk.org>; Mon, 05 Oct 2026 19:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791253862; x=1791858662; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Kn89D4l0KAhLS+bwNdh6s5K9giTFDQ/kyBCTBxPQjm4=;
 b=Xxrnbqmm+MJgkZLGGtUYhdahpMRNiFpu3OZ95SXrbHUm/DWBuG8Bw+j2RsVcxm7aNA
 /kjqwjyWMl0299bWwaMTqpjOo0R0ZxCtAHmr5KurhhlzKdZAJgPM3VAANb190ReSgWDd
 nDWjcfJhoZ1AMStWsL5QP82OGPGpl7Gh8ZhucO0mQIGNzH8ggQ0n6gEpNU3PI1gGXAM6
 J3AKiKWlUOMWrlu2syCFUXa6pKpUMmmnRsG7pqLWdISkXzvJSI4VCmNYDaafs12C9l0q
 iAA8S82rd+dWVclMEV85cRJ9W+rwvqrUP6EOHQY2pr59CWC63KiL2Xe4zlhVBAEyDWgy
 myUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791253862; x=1791858662;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kn89D4l0KAhLS+bwNdh6s5K9giTFDQ/kyBCTBxPQjm4=;
 b=lNYNrNLX1bCN0jcUSDeNmpNAI3AtEFEz/MjkT0CtAcXTV6fYqO5WIiRWu12cwS6vFL
 HaOy2zYB/IRJzuC4909hPy6S9pgPCQ+a6451c3MEbBlTP1vsOZdd02h0ckw7FGMivvap
 DMzwxxtLookbyO9V+Fg+9FR3WUu4LbVDE0AXoAHXtl2YDrO6E+yd08+kRoL6XCun/pUr
 1FesjTi61N+7T55Cu1ZSOB6Gg9WNS2UbpfjH07hmzjqHbs9/eoUrR+/8WrjHCe1MI9T+
 KatZyXT9HAcZtr/WZ1OLnlPxva0cH0Tkzay6FiDZTDS1ID10K0f7+Ukk5FAfUHbaC1DJ
 k3gQ==
X-Gm-Message-State: AFuF++kLQc6PjhDx65JWCWqF+7PiXVEwoVn2vQlneO3uBZJxcSSZomPM
 SJvK9IQXM2Ku810SV1vq4OGD/+zuoF3X6X1MI4VGIhtKvlQ0x7vSzAOQbYeUL8xQzgK/U1/eCKc
 ERMnG12QUhVPXQQ==
X-Received: from pgfd9-n2.prod.google.com
 ([2002:a05:6a02:6549:20b0:cc4:aa77:305b])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:918c:b0:3d2:89db:1688 with SMTP id
 adf61e73a8af0-3e124496078mr4724637.2.1791253862306; 
 Mon, 05 Oct 2026 19:31:02 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:30:40 -0700
In-Reply-To: <20261006023053.2572501-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260923010742.2468145-1-joshwash@google.com>
 <20261006023053.2572501-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006023053.2572501-5-joshwash@google.com>
Subject: [PATCH v4 04/15] net/ice: use common division round up macro
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/ice/ice_osdep.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_osdep.h b/drivers/net/intel/ice/ice_osdep.h
index 599bd4086b..f4ec8b8994 100644
--- a/drivers/net/intel/ice/ice_osdep.h
+++ b/drivers/net/intel/ice/ice_osdep.h
@@ -313,13 +313,12 @@ ice_hweight32(u32 num)
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
2.56.0.rc1.315.gc6ed9934b7-goog

