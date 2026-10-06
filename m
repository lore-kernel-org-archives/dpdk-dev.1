Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046D8CA5FFD
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 02:31:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 547B340E09;
	Tue,  6 Oct 2026 04:31:00 +0200 (CEST)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mails.dpdk.org (Postfix) with ESMTP id 87B1040E09
 for <dev@dpdk.org>; Tue,  6 Oct 2026 04:30:59 +0200 (CEST)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-88a46301d92so1919187b3a.3
 for <dev@dpdk.org>; Mon, 05 Oct 2026 19:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791253859; x=1791858659; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=299hRefeF02+t4b3HEszthYpkbHNDj8GYoIwCGdW1i8=;
 b=OS4QQlQ9FX3MhdIX8ihSOdbBEvbdDEvKCWoCmJjEHnZ85pm4LsdYxj7XXXKULs4BkX
 6GsCFpJkmhKMRTf/NnORLGP5htVvKDPdV6kDG9cClKpKCHymNGynxz1fAbB9Bp30VdVX
 HWFCFwdr8ho6hj4odHd4wAzO3GYvCiYF9eqmPGnbnrPnQkc9zmHkZRpUF3gMgEJE4LRa
 Gw92bvbhGrDRLA7L2UQZjjfixp+0KTyDy1Zs45PgE7qKaOcRVVCgla4HBkFN6J/xUag/
 q7s3zK/RNjXNaCxkWs6bX1Mn8eW6zRyPneGrss8CHpxlezjOBVB27ZkU3rng1ZhWkLzf
 30Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791253859; x=1791858659;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=299hRefeF02+t4b3HEszthYpkbHNDj8GYoIwCGdW1i8=;
 b=j8F5UAs55g7pxobmOPtrzeHkpdU2NTebGTCtDp50UnxLWOJgxKenS31lCZAjokw/Ki
 aElzeetyQDWjcoI19eDiUHeVsAHY+em0uMAVU0mJzheFz7LQ5YO8jlL+rCi1/mCXa3bt
 H3pWQqC7DRYcI5SwO6Tmalngopyo5EjZY00Blrgtnamdw4KCdJWTyAjSiidtqhucDzqA
 WTHCQYmAnCKIvfh89L/8j3b/Ni3ljz9HGJvAxYNdbBfm+//Fh4B+OLSAkAw/1CrXdUOG
 DuFQnjqEPOwpYRPTIq31XMk/EQAMhX/1VXbNyAB8FC3PulI7U8pHesvkq+K9uzxjWZqa
 MXiw==
X-Gm-Message-State: AFuF++kSM9xoxqM1bsa2dmK6eA+D59J6O8m7E0A4t1BJAGyddFhnISsg
 IT7nEGF0SmOWXra2sL9OVnkHXg6mm20NvY4cVqmouV8OoqL6skWP2FbSsOMyLUlkCmqwlbVnGM3
 1W30VPj9HrVBjRg==
X-Received: from pgc15.prod.google.com ([2002:a05:6a02:2f8f:b0:cc7:bb84:8e8a])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:e196:b0:3da:80a1:f2f with SMTP id
 adf61e73a8af0-3e0d6bb65fdmr9479436637.14.1791253858376; 
 Mon, 05 Oct 2026 19:30:58 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:30:38 -0700
In-Reply-To: <20261006023053.2572501-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260923010742.2468145-1-joshwash@google.com>
 <20261006023053.2572501-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006023053.2572501-3-joshwash@google.com>
Subject: [PATCH v4 02/15] net/i40e: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Bruce Richardson <bruce.richardson@intel.com>
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
 drivers/net/intel/i40e/i40e_osdep.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_osdep.h b/drivers/net/intel/i40e/i40e_osdep.h
index 1139c9c1fb..e499ae1d11 100644
--- a/drivers/net/intel/i40e/i40e_osdep.h
+++ b/drivers/net/intel/i40e/i40e_osdep.h
@@ -229,12 +229,11 @@ struct i40e_spinlock {
 #define i40e_memset(a, b, c, d) memset((a), (b), (c))
 #define i40e_memcpy(a, b, c, d) memcpy((a), (b), (c))
 
-#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
 #define DELAY(x) rte_delay_us_sleep(x)
 #define i40e_usec_delay(x) DELAY(x)
 #define i40e_msec_delay(x) DELAY(1000 * (x))
 #define udelay(x) DELAY(x)
 #define msleep(x) DELAY(1000*(x))
-#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))
+#define usleep_range(min, max) msleep(RTE_DIV_ROUND_UP(min, 1000))
 
 #endif /* _I40E_OSDEP_H_ */
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

