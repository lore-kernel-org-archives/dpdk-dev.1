Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF5FC88E77
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 19:23:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1315342E73;
	Tue, 15 Sep 2026 21:22:46 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id D4E2142E37
 for <dev@dpdk.org>; Tue, 15 Sep 2026 21:22:44 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98fso94870a91.1
 for <dev@dpdk.org>; Tue, 15 Sep 2026 12:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789500164;
 x=1790104964; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/phnFzq0W803yyw67LmFurn+gIz5RJG7XSdSIiHWFVY=;
 b=LYXnxffR6axa6GcD0Ghp9R+IcmkROt97lB18UBcsVBDmxWqf8DCknkE1VDQdNg+jlK
 oLQ27j6aFuMWkrkN4rLPwAUhrabCP7Jsnz8joJLNo6vo3lagRX7qHwQ7PK2DtM8F/Fi6
 oerqpq5jKsroTfraf/7u5V0t07bUxPbS2svqFU709FL9EHvObfohAKuDIVkyHvN6A4rt
 hDg4ooaZ6H1GQmYXaHzLP35kkj8JDS6CfJk7ANePfeP1zZuobUKQzmv0SlvRyJjMdWUp
 TlLSfHpBO+IystoMRPCKfngSkWc81bY8ZTy9IwLNvSIXWZ7uO5tKw6m1fyVjng/VZVmo
 fG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789500164; x=1790104964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/phnFzq0W803yyw67LmFurn+gIz5RJG7XSdSIiHWFVY=;
 b=UX56otQXD/vya+pP64bt7upkH1IIuFKttEEfTbO3drqvJsKxPZCVycSZmDH3Rp0ynl
 8uE2w7Hb/JOgnKIMYvECFutxiJheT0dXqReeggZVVxaf6pzXeVSUtMrbysb7p/Bfz28Y
 MaJoWcsLbPcLJ1Hv9CMtroOVRgNkAEE2DWps++ee+6Xaye//DjUXAV8a08NIUxRshCBm
 6s5PrYdheRn7tQLvBncei+3ZPYUXvA0YVudtuimbBIx0lMxu/zOroZk7BEjOFK4++/Hy
 hAFcbmq4r69Xb9iYnixRGm7dOhU2h/Tmil/Zyn2wM2Q5GsYaPU0VuCmI0KGfAFu7KSW8
 m+AA==
X-Gm-Message-State: AFuF++kkeE1R04cAj2RZRUpC9zm5WEQoJgxkmiSqxt2vJ1Kv0CZKbHGI
 6TOBRBysOzPMl21oXePbng8KqRxdnKZkXptXftrf1MErnlxCiWJYyIRCm41GMycIZr2M55tR7Ls
 dbQf4DUyTjg==
X-Gm-Gg: AYBFou3xkLmzlsv2dku7auJbhlIHmW569uqDTnzs4MTBAnvCi36YBECN8INWCLv3U7K
 qIxwXyrzY+o8I2PE4LzoTruxDlN5KMHHeluKXZjrsaldl1LB/pioVuslQy9TbngpXyZ5N/C4SZC
 If/EOS9FcmFAJFtihjrnosMsSqHhMskBQ/t8WQNhZCuqdXZqEIl720pjtTrnscU4dHIKlRDCIqz
 esnVlao7/UpPpA80zZf+pCQ6tTLPydZDoWZhp9LTgR+uHulIWpEOvoKpGiMpJB9pVxllSAaF8i3
 5V6YfaqcseMIvmar7vXu8CyX519P2v7fl8gjxTud15NOwxrOrRugdFJiZLyFm7wy6juCWgUbGy0
 yM5/7KHGAxhv+Kj+PkARcO63r/Gf0+4+TNPnkHTfeEV6OyybtJMgMIGeNsCqYr4IKLWCMLCiXVR
 iX7AEEpYt8wXxig3mb72795travw4aW+Wu8HTumezA/HoG8BAo7++sUzUf9aUN1gCLPtkReDg+2
 +N0If7AXbzJNKQW4t+aZKz7V/KXEVxZk5kVow==
X-Received: by 2002:a17:90b:4988:b0:38e:bfe:81e9 with SMTP id
 98e67ed59e1d1-39debf5f291mr17435218a91.1.1789500163804; 
 Tue, 15 Sep 2026 12:22:43 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbfdd49sm217535a91.11.2026.09.15.12.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 12:22:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 09/18] net: use secure random for random MAC address
Date: Tue, 15 Sep 2026 12:21:07 -0700
Message-ID: <20260915192207.3926217-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915192207.3926217-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
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

rte_eth_random_addr() returned 48 bits of raw rte_rand() output on
every call. That both makes the generated address predictable and
leaks enough generator output to help recover the internal state.

Use rte_random_bytes() instead. The function cannot report an error
to its callers, so fall back to rte_rand() if the system random
generator is unavailable, which is no worse than the previous
behaviour.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/net/rte_ether.c | 13 ++++++++++---
 lib/net/rte_ether.h |  5 +++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/lib/net/rte_ether.c b/lib/net/rte_ether.c
index 6703145fc5..4b2932c00b 100644
--- a/lib/net/rte_ether.c
+++ b/lib/net/rte_ether.c
@@ -3,6 +3,7 @@
  */
 
 #include <stdbool.h>
+#include <string.h>
 
 #include <eal_export.h>
 #include <rte_ether.h>
@@ -12,10 +13,16 @@ RTE_EXPORT_SYMBOL(rte_eth_random_addr)
 void
 rte_eth_random_addr(uint8_t *addr)
 {
-	uint64_t rand = rte_rand();
-	uint8_t *p = (uint8_t *)&rand;
+	/* Prefer the system random generator so that the address can not
+	 * be predicted from other random values. Fall back to rte_rand()
+	 * if it is unavailable, which is what was always used before.
+	 */
+	if (rte_random_bytes(addr, RTE_ETHER_ADDR_LEN) != 0) {
+		uint64_t rand = rte_rand();
+
+		memcpy(addr, &rand, RTE_ETHER_ADDR_LEN);
+	}
 
-	rte_memcpy(addr, p, RTE_ETHER_ADDR_LEN);
 	addr[0] &= (uint8_t)~RTE_ETHER_GROUP_ADDR;	/* clear multicast bit */
 	addr[0] |= RTE_ETHER_LOCAL_ADMIN_ADDR;	/* set local assignment bit */
 }
diff --git a/lib/net/rte_ether.h b/lib/net/rte_ether.h
index c9a0b536c3..b0dc227362 100644
--- a/lib/net/rte_ether.h
+++ b/lib/net/rte_ether.h
@@ -221,6 +221,11 @@ static inline int rte_is_valid_assigned_ether_addr(const struct rte_ether_addr *
 /**
  * Generate a random Ethernet address that is locally administered
  * and not multicast.
+ *
+ * The address is taken from the random source of the operating system
+ * so that it cannot be predicted from other random values. If that
+ * source is unavailable it falls back to the pseudo-random rte_rand().
+ *
  * @param addr
  *   A pointer to Ethernet address.
  */
-- 
2.53.0

