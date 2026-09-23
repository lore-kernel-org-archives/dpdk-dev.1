Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88872C98302
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 01:08:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D958142E8D;
	Wed, 23 Sep 2026 03:07:51 +0200 (CEST)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mails.dpdk.org (Postfix) with ESMTP id C73D5427B2
 for <dev@dpdk.org>; Wed, 23 Sep 2026 03:07:49 +0200 (CEST)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d959904658so4384695ad.2
 for <dev@dpdk.org>; Tue, 22 Sep 2026 18:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790125669; x=1790730469; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3VfbEJ5FiaxlQQY+PaWi2ZlbdRAd/B4zLmfTmiKau48=;
 b=LcIBWADZgrm8yRhQxv1yi25CxKnfhKAsbsxCGDc8h1gCLpUMsXXpcKiErnSvUh4Qfu
 Fg/9whxAl7+w+trljEk3Q5vgwiw3cxWIu27xxkubVimekUKjYwDNFfBM0b98J8a+oY38
 FE/13eEfEMiUNY2E8fXKIM0Ec0aMuElVV4okRdXSS64HpEfs4Q3pMidXFS/gLb07bMsJ
 i9BNFY2FLH/Jq/obBFbYGULOHsBZ3Qk7eWuAk513bQ9PJ+stB66raQJKdJQkJJ5VeFx7
 x/WcNWJqU4DiTvZcJkhy+Id4XhWiFVHk/60TcWa65Dcd8b0XkN2tyHwNqhGNBg2T0/Ta
 7pHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790125669; x=1790730469;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3VfbEJ5FiaxlQQY+PaWi2ZlbdRAd/B4zLmfTmiKau48=;
 b=yx7jUeXm+x+rSBXobwjqMGknrRKITplM9puGAgDM0vS2Jn1RG7/YYxC8eQOUoqpDG7
 8Chsv+9QC5S+Ryh3dBZGIq8wcQ8e1hDP9cAvEcWMJ1XKnUFbqgTygyi9UKHOqgw3UTQN
 uI5jvlDWrf9GcIavd8XJrt9qdTTA7d11oAhz2UDY1ele760DD6Y2A2qBiAojf8RUUGQ9
 gj252/i+NdOuj/KvTCzl3WHZJ8BvxhmW/W8ERlgxXIEYYCxmVOvEjhXKpDws+1H4fQsM
 34FDg6BWGD39AQ5Z6KghpYlPku+qlrRbu+nbu1jghIG63rKEA/xHHzvpjaYQYCH2NEQA
 3nJw==
X-Gm-Message-State: AFuF++li1pZBiJtlxY87OwaBgDTPoayOEp4qZMyG2coOhexdv317N0R6
 t3TQGkLGW8BIE8VjUZtyUVy7SXMI4IpnWFZLQyNAhh+3/935ShJnzxPEgsCQS7ou4d9V4tX6DzE
 6Zllhvc1Uwz6K0Q==
X-Received: from pleb11.prod.google.com ([2002:a17:902:d40b:b0:2db:8a77:fd33])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1b0d:b0:2dd:89b1:7fd3 with SMTP id
 d9443c01a7336-2df69d1b2cfmr9433155ad.4.1790125668697; 
 Tue, 22 Sep 2026 18:07:48 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:07:26 -0700
In-Reply-To: <20260923010742.2468145-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923010742.2468145-4-joshwash@google.com>
Subject: [PATCH v3 03/16] net/idpf: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
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
 drivers/net/intel/idpf/base/idpf_osdep.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/intel/idpf/base/idpf_osdep.h b/drivers/net/intel/idpf/base/idpf_osdep.h
index 67bc33f2e6..64bbd00eea 100644
--- a/drivers/net/intel/idpf/base/idpf_osdep.h
+++ b/drivers/net/intel/idpf/base/idpf_osdep.h
@@ -291,13 +291,12 @@ idpf_hweight32(u32 num)
 	return bits;
 }
 
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 #define DELAY(x) rte_delay_us(x)
 #define idpf_usec_delay(x) rte_delay_us(x)
 #define idpf_msec_delay(x, y) rte_delay_us(1000 * (x))
 #define udelay(x) DELAY(x)
 #define msleep(x) DELAY(1000 * (x))
-#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))
+#define usleep_range(min, max) msleep(RTE_DIV_ROUND_UP(min, 1000))
 
 #ifndef IDPF_DBG_TRACE
 #define IDPF_DBG_TRACE	  BIT_ULL(0)
-- 
2.55.0.1082.g2b9226bbc0-goog

