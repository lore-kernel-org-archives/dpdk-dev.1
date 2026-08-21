Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A706C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:28:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09758406A2;
	Fri, 21 Aug 2026 21:28:39 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 44D8C40658
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:28:37 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cbb8b54fcf8so1430650a12.0
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340516;
 x=1787945316; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VP5AM/VofpxSHq+WOAcKHqdb/qfaELWVfK7pW3PfCQY=;
 b=gsB4xl4NJptbW5VLDl45pTzomY0PFzFjIdnCLmJrOM5YJDFVmW+tJ5HdNF6DJL6pw3
 zeWM/bo9IiQBOi+1fXtJS0yqdeYWHOlYov95flDUMRYD0eJqBmpzrCWd+d+zwjRckBxv
 uNi9vKh9oCrNSxR7kQM/D2KTLdVBC3H2zqOiGjwSbw7EBQukikRK/iZyyHhBJC+TxsLU
 vD/Uvo693mAYBqCYpXJAZB+MEPndtVqlbFt1o6e3ctrLTg3BGzkJUVm6MFGdkbZGnLLC
 n77U1uYutZY4ei38OUvZ5o4t1cgk38RyZijH6mvs8GT42r98QeFWS3yvZbuxh0AxI7s6
 GLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340516; x=1787945316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VP5AM/VofpxSHq+WOAcKHqdb/qfaELWVfK7pW3PfCQY=;
 b=A8L4eAPy7BCz6N5wkMD2fGn34ieQ4G9uG9CZOhzkZkRDFFk/996AYjsq61mdczet4u
 Tj05UkaV8d6K2qCc37Ks3qvPFy1xegZq08kN6gSE/GF4rll8PWv3O/pE/aDtZ/1p7rHo
 8gkXfHLmOICvO8vXz9McdSc5IwO7gZ7CVPCifvOVkslh+1uu4ZLl1i4IlLg2i2XzOFeI
 D1ZpJi2b3HGkT4QpAhj+NszGHKU4FuKJOj3TCFtJ/rc02NWgNIp023cLy4AGt7/cVcm8
 KbrwvdcFRDxu1oC7vKjFGyah1ChbOHI3trDyTt6U72PAOcMH1DEg3mlNNWoLapqPr0dC
 h4Kw==
X-Gm-Message-State: AFuF++nBA3RFkLNuYPpX68MVTEcFl25/ouJBAKjnJaU/2fIKRArzUTJk
 rK8f88Z+trEpQKhxGBPamWFHszJeacVoLLZyF4XKJq3lQgmfoQO4O2n6f/GtfrdeHY8Gg7YcoW3
 U/L67
X-Gm-Gg: AR+sD12qoTDvMouiheFWNBYdgPBbCycFZ2RIBG5qM8mBqGnwBj8774iUmUdMToZNu23
 TUsSQKWWKN0kHwYpsmRpXhl2pENwHUdSxBLe+eO825JG0vyWmmEXLXC77aryn4eFX667BZtM+/v
 43h79Q1FJoobkEiTMmOKzPVBLZIRJOUe72cpoaHu6eXNHM5QIdkCCD7ovhlw2EXBb2YS1x4vgdm
 1fz/o6nr7ci/ObjWwlAdyx6+rzm6t9z8UXnZ1JTstw77tQSyhVms1b2u3ODmcYql0Xv+vd/Zq5T
 rrKvnVuoXNlpK5yVaJw+sRTlzWr72ydEx4qzLCuJ0S2fuJBX9jaspigPwkNp+DEhG9FlNBQg3eZ
 HyxEZ/hN0GyG6k47xdaCepq9K+RL56aCyqKBLawHEd9H/stIi3D76ZAlIjP6cAK3QV+t5cnvFmI
 +1jO+s4Lsa0JyBYsE+lbspNSaCj+LPwIu2uRaAge2poPPwRH91D3SOlB8D7SHVmMsxftUziHB9T
 6PQ0sZ+gmMmQRtF7o0pmLFVM7Hdch3A
X-Received: by 2002:a05:6a20:3d94:b0:3b3:26aa:5455 with SMTP id
 adf61e73a8af0-3cd300f9e23mr17046909637.13.1787340516438; 
 Fri, 21 Aug 2026 12:28:36 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:28:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sunil Kumar Kori <skori@marvell.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: [PATCH v2 11/68] app/graph: replace rte_memcpy with memcpy
Date: Fri, 21 Aug 2026 12:24:06 -0700
Message-ID: <20260821192646.146382-12-stephen@networkplumber.org>
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

Use libc version of memcpy for fixed sizes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/graph/neigh.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/app/graph/neigh.c b/app/graph/neigh.c
index 3298f63c1a..16c8257724 100644
--- a/app/graph/neigh.c
+++ b/app/graph/neigh.c
@@ -91,14 +91,14 @@ ip6_rewrite_node_add(struct neigh_ipv6_config *v6_config)
 	memset(data, 0, len);
 
 	/* Copy dst mac */
-	rte_memcpy((void *)&data[0], (void *)&v6_config->mac, RTE_ETHER_ADDR_LEN);
+	memcpy(data, &v6_config->mac, RTE_ETHER_ADDR_LEN);
 
 	/* Copy src mac */
 	rc = rte_eth_macaddr_get(portid, &smac);
 	if (rc < 0)
 		return rc;
 
-	rte_memcpy(&data[RTE_ETHER_ADDR_LEN], smac.addr_bytes, RTE_ETHER_ADDR_LEN);
+	memcpy(&data[RTE_ETHER_ADDR_LEN], smac.addr_bytes, RTE_ETHER_ADDR_LEN);
 
 	return rte_node_ip6_rewrite_add(portid, data, len, portid);
 }
@@ -121,7 +121,7 @@ ip4_rewrite_node_add(struct neigh_ipv4_config *v4_config)
 	memset(data, 0, len);
 
 	/* Copy dst mac */
-	rte_memcpy((void *)&data[0], (void *)&v4_config->mac, RTE_ETHER_ADDR_LEN);
+	memcpy(data, &v4_config->mac, RTE_ETHER_ADDR_LEN);
 
 	/* Copy src mac */
 	rc = rte_eth_macaddr_get(portid, &smac);
@@ -130,7 +130,7 @@ ip4_rewrite_node_add(struct neigh_ipv4_config *v4_config)
 		return rc;
 	}
 
-	rte_memcpy(&data[RTE_ETHER_ADDR_LEN], smac.addr_bytes, RTE_ETHER_ADDR_LEN);
+	memcpy(&data[RTE_ETHER_ADDR_LEN], smac.addr_bytes, RTE_ETHER_ADDR_LEN);
 
 	return rte_node_ip4_rewrite_add(portid, data, len, portid);
 }
-- 
2.53.0

