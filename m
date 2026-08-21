Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C267C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:33:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9FBD41101;
	Fri, 21 Aug 2026 21:31:53 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id DD8E640DCA
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:31:46 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c9aea40d799so900602a12.0
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340706;
 x=1787945506; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SQO5rA+xhzMkvq/qAnJO35mXbs+SUNSrql7p77lPgrs=;
 b=FpoC/iD/UmgxslJYlQpi0aeA3oWAUxFzAOTeelTC5AFI1Tsb9xmZKXmJgXG6sZtmYj
 pFKUE1UCxCtZGdDzoCALusToBdV2uoxGN1PdSSQ2lqLcd7J80J1Q8kmGMvsw0QHgD5+z
 n5oOZ/9yPJMC80epg2uqR4LFC3Q4n3hN2QcKgj2NFBOF7KpFCrt7bjNdPLYHKdyOIOSU
 exjggz5wCNA4ErWLFP7pyIy6uVlDtPcgZtTPN5nuiNw+gWbQlr0uQXAGtd53tZMM0IMT
 HFRlWAh0SxbjMjdYhnKITGid/Lefdl6rUNyGoOes6AS6KjXqDfsYAN4nWJM4xYIhyFQy
 fxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340706; x=1787945506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SQO5rA+xhzMkvq/qAnJO35mXbs+SUNSrql7p77lPgrs=;
 b=kxbNTYMRIbtEN4NLr2wq0SD04F/MBNb8MMtipEpkQY6mlJGTdhkFHrOIx1L1a3ezY2
 QgBFFjQd9lndpRghePYAusS2AKbaDzLoVF/YCR8/JBkA65+eOvQp0tsPT7D/rubTW1JT
 tWaxsGt4NQbCtDA9PiLg97qT0sjLfnHL2UYWTOHWSzunF4fuphCjyJZ9/PYUmayIizVH
 /eev/+eWZKH6wTuJKhPHAt9VxPogZFDNGdTnZiYfS0FE5MtxxriB6pSuALtWU9FLVqxb
 Q5in9dnOyRpKeLmjbBJ4ob8FfLcV6dTVqg6x5jLlXt8IKMH+cH2RpTOr4xM2maeY+9fH
 54eQ==
X-Gm-Message-State: AFuF++lPJP8yjW9Mdzbi2K0oqDC8jP0+yLrDwaQ+WLLhZEsV7D73xDJw
 J5bDzqssit450xLN3lSAcnChhIJpv19MVoBSpXKGYaJWUQ1tvALYJjym+v0EbC39GN73Ea4nzNV
 9LBVXkIs=
X-Gm-Gg: AR+sD10tb6QTJVeD6bMUv+/VY0MSHj9/GnCpo87pmHmPYpQPwGvdtaVd0YAFUCRxn2G
 QTU0TZxnYS8IT04L2qZYQ+TyNzlq7ZG6/jiFbL2fr9IY1x65tzdH8bCd3G0DYxaH/fNdfa5WlRd
 CGZf/NHqC06hFYc3joj3zSuIwRt+fmsDd9N7pPwfy35JZZ9CZxYQShvMWjCjulWksBXtphUFHei
 VVvCm6zbxjnRl13Ij9ebOKMCv1/BdHgwbbO68iEpdZpKJ10ip26SIg/5TSbmFxVLmR1JDhyH9lL
 zCzV6q5zZ3PCuyFjHdGgMZr0nOl2sqVV1i2+csugmxTH815uFkl8OE+9iGlL8Lp5QiHgAoDoCtL
 fED8Qeeb/J7Ag08ncydWj2IKLFA2uDTIIMyyYAg/hUilz8ASUZx+VAEkT/VkWj3UiNy4MOko2iR
 b7CP84D6yfdhFEd8tuIvX+SgGwOsD/N8ildr/wb91rlk/o6GIvJ93lphUntDndCzz7fsCpWXXv5
 ZnXxeNa6typhpKYw4S4yOxfS40=
X-Received: by 2002:a05:6a21:6b8c:b0:3be:b0b3:3962 with SMTP id
 adf61e73a8af0-3cd3007cf21mr18289540637.9.1787340706082; 
 Fri, 21 Aug 2026 12:31:46 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:31:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Yipeng Wang <yipeng1.wang@intel.com>
Subject: [PATCH v2 65/68] efd: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:25:00 -0700
Message-ID: <20260821192646.146382-66-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

Copying small key with rte_memcpy is better done with memcpy
which enables more analysis checks.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/efd/rte_efd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/efd/rte_efd.c b/lib/efd/rte_efd.c
index 4dfc0ec9a4..09b0b01d90 100644
--- a/lib/efd/rte_efd.c
+++ b/lib/efd/rte_efd.c
@@ -18,7 +18,6 @@
 #include <rte_malloc.h>
 #include <rte_prefetch.h>
 #include <rte_branch_prediction.h>
-#include <rte_memcpy.h>
 #include <rte_ring.h>
 #include <rte_jhash.h>
 #include <rte_hash_crc.h>
@@ -1060,7 +1059,7 @@ efd_compute_update(struct rte_efd_table * const table,
 		rte_prefetch0(new_k);
 		new_idx = (uint32_t) ((uintptr_t) slot_id);
 
-		rte_memcpy(EFD_KEY(new_idx, table), key, table->key_len);
+		memcpy(EFD_KEY(new_idx, table), key, table->key_len);
 		current_group->key_idx[current_group->num_rules] = new_idx;
 		current_group->value[current_group->num_rules] = value;
 		current_group->bin_id[current_group->num_rules] = *bin_id;
-- 
2.53.0

