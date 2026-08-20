Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28C0C5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:26:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E038D40E27;
	Thu, 20 Aug 2026 07:25:25 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 905DD40693
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:25:24 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso2213390a91.2
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203524;
 x=1787808324; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O0k1EK/r95sW1obABSomt9qjWIbHe/nJuvOEtDtntrA=;
 b=cuhjtsaKyDuL2gAK8872aLrnuihcLMcUX86uwohDWRLcQACYGr2gSArbb9HstYo6wC
 ovsjGbrrsEtVZBTCl6e1ks/ZxAluzpnV2xdzsWw+DP1amLXl56UQFDEaHbOIBZ0YJ5SP
 SdhcviS1TopPxGb2eR+Rz/Vm2DkbJVUqD29BSIvesW7tsb+gOnTkdLX79IFGpBVyXQpS
 NkTH1/c+CangljbWCVN/nnyZNyoGS+0Su7atn3uxbqb86cjZyWIxI3uKtzx59Zj+kMlG
 BAfn8KjGN/Il6H3FMP5qY0IVdXXec7IGK5x9VG8W3d5NYAjQRQ74qzJX/Zz6yK96kijZ
 I6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203524; x=1787808324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O0k1EK/r95sW1obABSomt9qjWIbHe/nJuvOEtDtntrA=;
 b=i/ZrlWsVfBX0d1Th4q591mlzKwctOkNGbC25X8rgOsFIQgjFbv4b7ZjCUBisJJErxk
 F6R3rgt5RoMxiJsG9UQBCO+x6OjECRGAUEl03+uzoqzl4HdoR+HomHaSH+lB60LcfnMQ
 w2UuhwJ4CXhljfHFHfAbt6cFfS89bg1p/a5j9LYLvGoqmtZwEi7YrpyDfau6v5IECjjd
 h0SI3BWaiN68rPOxRwlX368mQfXXPOCRNfivxJejhQEb0n+9WgGbU24a0a5TNPkNGlbR
 qq40mRqsNKLquqvUXxVs6yw5EWto1Uf2tiiLtUzO+BrPADG1Nh9HNFn9Qhe5MF2cbzqa
 lJzg==
X-Gm-Message-State: AFuF++kUQcevnzP0bpOROwmVA/KB+tmAS2r9z4BIuoaF4tRbKrXf6s3+
 /wmHcGSsuIz9NwQdWzYZ37a0D7f3afON9J6+ZP8ZoH/vqbwSXcjTHFUY7eEMkK1lt/NSAzk7VYb
 ynkju
X-Gm-Gg: AR+sD10sDpgp7gHbHVEcGGbgVMz+exT4rF8pfczSEcC662hVHL3UyGx5OHdXgl2FHC0
 /KSPambFfvErDgB9CXkdj+cJKUqCdL+JUYEJbQJbI/au58KGGrcbblk5iFFhWq6fztxha7HV6EK
 yaGaR+qRh4Lefj3p4mX6+QqFVsu+sc8dAALwlji4Iq2AO6hX79uNARSSGJ1JbhSIe8Gymn5TF6q
 eGxemXJKgPixrtvSmDJJwr+KSpyU6QPxnQLftDhWlNFuMNDDJFbKFnzsI5GTIr1OcXkS2t0jtBm
 xI7sqVnTPibHZxZL2sSAc/e/MAJG79+WOdxUigbxYD9D3O4szdYA3TcRuIeUaoWOCQ9yVogm0TD
 MhlGMLa1HxKBVbkDMIOy5oRlAbIQkWgx6ItgeLsNH3JhoSvhHyQZc2GCnYq8DyDxmmRUFPtZD7c
 MjVpXdmdIAZL7IZmQGhAYUILyp09ohFs8AfyAkaY3zEblfX3g7QmSs7cKK++ljE8x0zvYzUqc43
 WE1GaIsFKMREVAD0He+hat9FzM=
X-Received: by 2002:a17:90b:3fcf:b0:38e:9045:bac0 with SMTP id
 98e67ed59e1d1-39580ab840amr19733679a91.5.1787203523656; 
 Wed, 19 Aug 2026 22:25:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:25:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 39/61] net/ring: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:29 -0700
Message-ID: <20260820052251.1453273-40-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ring/rte_eth_ring.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index b639544eab..60d41d8c06 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -9,7 +9,6 @@
 #include <rte_mbuf.h>
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_os_shim.h>
 #include <rte_string_fns.h>
 #include <bus_vdev_driver.h>
-- 
2.53.0

