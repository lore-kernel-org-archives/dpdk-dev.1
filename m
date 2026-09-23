Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFCFC98302
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 01:07:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE5F3427B2;
	Wed, 23 Sep 2026 03:07:50 +0200 (CEST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mails.dpdk.org (Postfix) with ESMTP id 324F34064C
 for <dev@dpdk.org>; Wed, 23 Sep 2026 03:07:48 +0200 (CEST)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2db3734d06dso3775795ad.0
 for <dev@dpdk.org>; Tue, 22 Sep 2026 18:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790125667; x=1790730467; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=07QdTVF5xKneai7Csry1v5XGI+2WooXkG83CX47TlGc=;
 b=iyO1igDc54h7WaNH27j57cZ8o4X4cGlIswoHepPpjt34vvY/0Gqt2fySaFpNgtzYYW
 5ROMXoKg1GK5SZQtCMtvbt6Gz0UxUuhMrWfHWUb2Kdd+WxrpBdbvJ9o/NOlUZ4z84qG6
 lVgyfDcfdu12SOAMRlYBwCdflKuT2S7o16urvsVnMeNrkkPqMz5k4kGaGAkzJIZ+LJPD
 bm7c/bM53XAsL0Fkj6uh8rN6/8mfH7hk7Dap9mis7aJYtG05pnFJWbyjKb/JsUL3FCSM
 vnFfz/fcK9HEnqiuVx4QbQToWeYdVxN1dkYEVIr8d1VeXf/Gk4ef+5hQg2b3Z+r9MGEu
 HlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790125667; x=1790730467;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=07QdTVF5xKneai7Csry1v5XGI+2WooXkG83CX47TlGc=;
 b=Qdo7DG98z1TlKxrsfgQKrMo8KtEwOalLCJ/2IVYDnE5BUsMNmKCAyUJ5OxG4/Z9EdO
 9JdtLKC+MiVneY2yKy/l+hIWqygTSxYlXUVZd/A/gEpqeMgnUGAomIN2rBVpMt5D6m0G
 2l3WgX+EVYmqdT0eiMm4sJlmOCmOxsJdtiA+Zs8Fa0mxv7kIj3VMxs3FOZS0V93i8W8l
 dcQbwgTH6cjVS8fbLObJgggCqZ8YPed5iqG5iZNHYiuaNoYpIyLu0uxw2lFqhtXNcv0c
 k7f8q/QGOn9wk3eAb0k2S1A6ymNuuo/6lRtfPRyH0nbp/4DZe/E95qlC84U7rW9xup9k
 mfSw==
X-Gm-Message-State: AFuF++nF2IP5KM3nAOOwZhjfEY3pgplzaLlWGy3MOIvMDB/e+0HSXOli
 OfBHzPmxln3uIVIPZnqxVbBnxdhfQMwe2XBgwOAVcBQvIWcaIvqHK+tGYqbFCi5hbaDkjq2SfQW
 9fPoEhnXY2Hoo8w==
X-Received: from plmk24.prod.google.com ([2002:a17:903:1818:b0:2dd:ac78:8906])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:db07:b0:2db:5c0a:f18c with SMTP id
 d9443c01a7336-2df69d36878mr9802065ad.6.1790125667149; 
 Tue, 22 Sep 2026 18:07:47 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:07:25 -0700
In-Reply-To: <20260923010742.2468145-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923010742.2468145-3-joshwash@google.com>
Subject: [PATCH v3 02/16] net/i40e: use common division round up macro
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
 drivers/net/intel/i40e/base/i40e_osdep.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/intel/i40e/base/i40e_osdep.h b/drivers/net/intel/i40e/base/i40e_osdep.h
index 9c5a94f055..93620f5c50 100644
--- a/drivers/net/intel/i40e/base/i40e_osdep.h
+++ b/drivers/net/intel/i40e/base/i40e_osdep.h
@@ -227,12 +227,11 @@ struct i40e_spinlock {
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
2.55.0.1082.g2b9226bbc0-goog

