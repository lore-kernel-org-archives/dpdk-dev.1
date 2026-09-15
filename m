Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B82C88E77
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 19:23:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0933E42EA4;
	Tue, 15 Sep 2026 21:23:06 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 1273042EA0
 for <dev@dpdk.org>; Tue, 15 Sep 2026 21:23:05 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-398cb5615deso110059a91.3
 for <dev@dpdk.org>; Tue, 15 Sep 2026 12:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789500184;
 x=1790104984; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vrjL4DwlfgcBZl5fRp1FUkHVjVdYr91pquSt23nKJvY=;
 b=UB8pi6xvVQs5BoQqmrnICc+SK0CXtrc5Nt8MM84IvHDMyk3kqsxdUx7cjDHzhPmHcU
 4mhP/AXLcHPc/t3dAjBBKFM5fy6giArIWz2gNLk7P7uu6YJBIFD4MBufiS1bfoRlwoll
 pL4BMaEHevmiUQ0QfGLjiQLOuYKlMdtjtaV4Zh61qRR3Fue3rqMYgJUuyYeXTvYrdrMn
 vnjIFjdonn4sVV6Huud03I+TDsY3cgkvDNPrtWiOhiBSZIbdt64bofBqO6BIHdNnF8TK
 8kq6e5lE4LwfjlInqe5lscMva05dCbxyF9Y689NaxLfdy93MShKhKvd19qYQZxFVxbez
 vNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789500184; x=1790104984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vrjL4DwlfgcBZl5fRp1FUkHVjVdYr91pquSt23nKJvY=;
 b=MTj9ODqvbS7oIvreWacNnrTO7Og3niT/ajW8TyRw1GKi96VTAuGJu+4nMSmt2J8N+9
 RFIrkJoXESJwLLd5nwxwxLR7xtZdtjfAdQwaIpTGsYbBX9tQNYaa/TZ9lpq4wzZZ8yQb
 baLCC4uIXmuZcBHZVFA9oEqjnPHYd6PgGekXVK9xG9MonY679ZBVFLm9XNbY1N6vCUWS
 PJCTIg3DIjW0j5FC+MbKLMsY1GVKJRSJ0reTRGuVumRjjMj72o/tHYbevgz4hENaWWOH
 2p5IlQcJEiVWGB6OFHj074BRC0r9RKh+LfFQgv9TITpErUTi3obWSwMwLc6VpanXiCZ8
 zJ0w==
X-Gm-Message-State: AFuF++nlUjSaOQiH7+Nrrg77U2Px7Fxyh1TiK84Rd9lEjcPZ797iW0Qu
 ovtH5Tcn9TeNEKI4ttqlSyyFOo0l+f8hJpcO2QUqmeAWE8qKugoWRK085vhg6JA0rZ+PqQlNOnH
 jmXLEa4V2Mg==
X-Gm-Gg: AYBFou0baymhko4OEjnCGXA6oNSMaZDgeB1+goHbKKt9djcLFtNh9T6Xl6p1J3pAAzH
 QuWMN5lA0SAKOoQgKhRZzo01a7mvSTkD+I7gLlszIS+CP9DDi3qpfsenLQzFOgrgxxqvZQVP3UL
 YlhwVmdTFIMtr8758QWCtfWrXTtbmF4Zrx9jYtK2TSqFRw6WQJW68EOcshGHKE1LnVGMnHW6+1K
 TEyEV8GgN1GHgGS/BOADBBvvRHaBC+//QlvbwKIHNUKSKCyfQ6g7WwNCeIudj+0XiPOSxIyqE2f
 k2klaf+HwW0kfTTHtQ0u+XLYACY/BgcEjj01juB1CNRL2P1mB1Dv0dwm35sjxLMzV66/UhxtqXL
 6k9+MGr1vSdjlOhbXJM1yhv8P0PLgLSwywbOZk0GxqYlKeMjAr0KxhtGnGU5aDKy4kUG8Rgn1gH
 Y5PQrENfj11It0YsbdsaAZWb44ufmQ/KxHZXvbiN+NSMMkjar71oF0JYYKCpIAkZcHlTEcd85Dg
 f5wB4a1ewNOfaBpDNiHIWrRaKhgSujEhNYiFg==
X-Received: by 2002:a17:90a:e70b:b0:39b:370e:c807 with SMTP id
 98e67ed59e1d1-39e11095fbamr4422191a91.17.1789500184147; 
 Tue, 15 Sep 2026 12:23:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbfdd49sm217535a91.11.2026.09.15.12.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 12:23:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Gagandeep Singh <g.singh@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>,
 Apeksha Gupta <apeksha.gupta@nxp.com>
Subject: [PATCH 14/18] drivers/net: use common random MAC address helper
Date: Tue, 15 Sep 2026 12:21:12 -0700
Message-ID: <20260915192207.3926217-15-stephen@networkplumber.org>
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

Both drivers open coded a random MAC address: take 32 bits from
rte_rand(), clear the multicast bit and set the local assignment bit.
That is what rte_eth_random_addr() does, and it now takes its
randomness from the operating system rather than rte_rand().

The enetc version also wrote past the end of the six byte address.
After incrementing a uint32_t pointer to the last two bytes it stored
a full uint32_t there, overrunning hw->mac.addr by two bytes. The
address bytes are now read explicitly instead of through a wider
pointer, which also makes the value written to PMAR1 independent of
the host byte order.

Note that the read path at the top of the same function has the same
overrun. It is left alone here, this patch only changes the code that
generates the address.

Fixes: a7fc52fcadb1 ("net/enetc: introduce ENETC4 PMD")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/enetc/enetc4_vf.c     | 22 +++++++++++-----------
 drivers/net/enetfec/enet_ethdev.c | 16 ++--------------
 2 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index ef5f1e6d66..df3b4bd89b 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -4,7 +4,6 @@
 
 #include <stdbool.h>
 #include <rte_kvargs.h>
-#include <rte_random.h>
 #include <dpaax_iova_table.h>
 #include "enetc_logs.h"
 #include "enetc.h"
@@ -1252,18 +1251,19 @@ enetc4_vf_mac_init(struct enetc_eth_hw *hw, struct rte_eth_dev *eth_dev)
 	low_mac = (uint16_t)*mac;
 
 	if ((high_mac | low_mac) == 0) {
-		char *first_byte;
+		const uint8_t *addr = hw->mac.addr;
+
 		ENETC_PMD_NOTICE("MAC is not available for this SI, "
 				 "set random MAC");
-		mac = (uint32_t *)hw->mac.addr;
-		*mac = (uint32_t)rte_rand();
-		first_byte = (char *)mac;
-		*first_byte &= 0xfe;    /* clear multicast bit */
-		*first_byte |= 0x02;    /* set local assignment bit (IEEE802) */
-		enetc4_port_wr(enetc_hw, ENETC4_PMAR0, *mac);
-		mac++;
-		*mac = (uint16_t)rte_rand();
-		enetc4_port_wr(enetc_hw, ENETC4_PMAR1, *mac);
+		rte_eth_random_addr(hw->mac.addr);
+		/* The address is six bytes, read the last two explicitly
+		 * rather than through a wider pointer.
+		 */
+		enetc4_port_wr(enetc_hw, ENETC4_PMAR0,
+			       addr[0] | addr[1] << 8 |
+			       addr[2] << 16 | (uint32_t)addr[3] << 24);
+		enetc4_port_wr(enetc_hw, ENETC4_PMAR1,
+			       addr[4] | addr[5] << 8);
 		enetc_print_ethaddr("New address: ",
 			(const struct rte_ether_addr *)hw->mac.addr);
 	}
diff --git a/drivers/net/enetfec/enet_ethdev.c b/drivers/net/enetfec/enet_ethdev.c
index c7ef097875..691f634d80 100644
--- a/drivers/net/enetfec/enet_ethdev.c
+++ b/drivers/net/enetfec/enet_ethdev.c
@@ -637,20 +637,8 @@ pmd_enetfec_probe(struct rte_vdev_device *vdev)
 	*mac = (uint16_t)(tmac >> ENETFEC_MAC_SHIFT);
 	high_mac = (uint16_t)(*mac);
 
-	if ((high_mac | low_mac) == 0 || (high_mac | low_mac) == ENETFEC_MAC_RESET) {
-		uint8_t *first_byte;
-
-		mac = (uint16_t *)addr.addr_bytes;
-		tmac = (uint32_t)rte_rand();
-		first_byte = (uint8_t *)&tmac;
-		*first_byte &= (uint8_t)~RTE_ETHER_GROUP_ADDR; /* clear multicast bit */
-		*first_byte |= RTE_ETHER_LOCAL_ADMIN_ADDR; /* set local assignment bit (IEEE802) */
-		*mac = (uint16_t)tmac;
-		mac++;
-		*mac = (uint16_t)(tmac >> ENETFEC_MAC_SHIFT);
-		mac++;
-		*mac = (uint16_t)rte_rand();
-	}
+	if ((high_mac | low_mac) == 0 || (high_mac | low_mac) == ENETFEC_MAC_RESET)
+		rte_eth_random_addr(addr.addr_bytes);
 
 	enetfec_set_mac_address(dev, &addr);
 
-- 
2.53.0

