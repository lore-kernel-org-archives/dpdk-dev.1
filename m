Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC48C4452B
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 13:34:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A6EC40696;
	Mon, 20 Jul 2026 15:34:45 +0200 (CEST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id DD92D4068E
 for <dev@dpdk.org>; Mon, 20 Jul 2026 15:34:43 +0200 (CEST)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49545ba3d4eso19525065e9.3
 for <dev@dpdk.org>; Mon, 20 Jul 2026 06:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784554483; x=1785159283; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5c5y+cqj+sL4K6D6LiTBC4i+6xqo20X4QUn5YUwgXLE=;
 b=pHq+2Oy754igV7r+5jzBNWxqhJ4GvFWlteq2k6MgLK1gc0lvNlpgLq273yfLQWSi4X
 35wx+8m39kNm2bMrQS01aPpRXQUjeQ2l49ZpJ2AXM2qhjtgMXpSl2jMaDplN7swk7TGd
 OpQJaGImWlIT4Y7V8ANQPepcsqJTQRVdLglEq4gKAvSlIFm7lLnZyO2wcJuN+R8Xn33C
 GJE2+6h4br86r8t4JJQAFcAmR3/UUGu1Sv5w9lmp97au8zpwliQOyn5D5yLP0z6ZJWF6
 jam3m7DAT37BO1MRWn1/kBkA0P9YFZfN6ncMoInHUL3GmNlAk2pZR1vKu77ZxcwzCKGA
 o3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784554483; x=1785159283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5c5y+cqj+sL4K6D6LiTBC4i+6xqo20X4QUn5YUwgXLE=;
 b=rgJ0IyiC8eGyzYbEBb5zGqgzWt3CR2HW8fDLWr7aHhV68a9R+ViIGzGUO9AqATTZE+
 hkXlSSLyr9yEQXS7F94RpOlllV77qsCC+skb+pqQg84FU7DGZx0Eoj+SurEuVf7UY1iO
 xh/I4GVHnPRcUeeAMyiOuCE8cwRcaWTQ2McUmLnIkASLbZKH+30g7/SYjH+h4aYCnerA
 uM1ox/b/jzhPDr/dO1jGGrHerdSb3OVZJqmWv7HxFZRVgOJVs06PgY5c+nPDXdFoIOtf
 iatJ8ZvrxRG8yfZ+EsOer7nVuLPYYfecvyfC6C7CcgDVkHb6m1pK+LkkBG+u/Ps7sals
 Ba+A==
X-Gm-Message-State: AOJu0YyKpRjI2U9ZxkJdTkwE/ADeaMG/NCZokvFDkC0zD/AAcm+SFnR7
 yeE4iNR3KSTVbFB8zYHXYeAWBBrUXVQsrkFad03TFstyPekMF3BnQJKXGGT9VGyd
X-Gm-Gg: AfdE7cn6k9B3u+qjePoajQFiqTxfnuKhVjt3KJNRfsm06Xg6ETrsAzwzKvsSTS+P9iC
 2GN5hUaqfYXIkHwyk5QwZnJa8v0Wrm/1Ki1mOXkJ4J4uXQo3Ye3bL+Fj1WBSBO2gp09hJfaU8+L
 LRCxaRpsz3KJCIYcU70Mkfja+M3IjLo3/wilo67yK/puqfhExNM4Asuh/VTZCvuEEHXm8cXAcne
 j7Mwxgz2vFIe5A9Z6x+bk8JP5nAF3SG+50k0Gut7f2ymU2REFA5cpnq9O7ccPQLkyEFtBVtjGQU
 vV2VrUyOHY9z1f6/l9qprPoPRahbTbe/a7/lBtk7olJuUikegCbSIgM+6Eq2LOMu2khj4vRZ4xR
 LhQPmJD67NjwG/QOrFtXWR8CEdnbTvZzoGlDL8hSvStYVwOEXj8kWeoGKMA2YHzKD9FgKsHuXW/
 uGjHIB6tDqSAoz/2vIkPnfnZnvIlfavw4nQLMKxn1yactSWYWK8fo=
X-Received: by 2002:a05:600c:6dc9:b0:490:688b:f9f8 with SMTP id
 5b1f17b1804b1-4954a5151e5mr119545965e9.27.1784554483261; 
 Mon, 20 Jul 2026 06:34:43 -0700 (PDT)
Received: from freepad.sicorp.iliad.local (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955dfa4a97sm115980345e9.4.2026.07.20.06.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 06:34:42 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com, hemant.agrawal@oss.nxp.com,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v1 2/2] net/dpaa2: hash inner IP for tunnelled traffic
Date: Mon, 20 Jul 2026 15:34:36 +0200
Message-ID: <20260720133436.869334-3-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630123857.392884-1-maxime@leroys.fr>
References: <20260630123857.392884-1-maxime@leroys.fr>
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

The RSS key only extracted the outer IP header. Tunnelled traffic whose
outer headers are fixed then carries no entropy for the hash, so every
flow lands on a single Rx queue.

Extract both the outer IP (header index 0) and the innermost IP instance
(HDR_INDEX_LAST). Plain frames keep being hashed on their only IP header;
the inner extract resolves to nothing and adds no entropy. Tunnelled
frames are also hashed on their inner IP and spread across the Rx queues.

This is the PMD default hash: dpaa2 does not expose the ethdev RSS level
selector, so it applies to every RSS request. The hardware cannot hash
the inner IP alone, as HDR_INDEX_LAST only resolves when several IP
headers are stacked and a plain frame would hash to a constant. Folding
the outer IP into the key is therefore unavoidable, and two tunnelled
flows that share an inner IP but differ in their outer IP may hash to
different queues. This is documented in the dpaa2 guide.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 doc/guides/nics/dpaa2.rst              |  3 ++
 doc/guides/rel_notes/release_26_07.rst |  2 +
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c | 63 +++++++++++++-------------
 3 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/doc/guides/nics/dpaa2.rst b/doc/guides/nics/dpaa2.rst
index ae8b32af2c..aaaf5f9713 100644
--- a/doc/guides/nics/dpaa2.rst
+++ b/doc/guides/nics/dpaa2.rst
@@ -588,6 +588,9 @@ Other Limitations
 
 - RSS hash key cannot be modified.
 - RSS RETA cannot be configured.
+- RSS hashes on both the outer and the inner IP header. Tunnelled flows
+  that share the same inner IP but differ in their outer IP may therefore
+  be steered to different Rx queues.
 
 .. _dpaa2_dptmapi:
 
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 6a528e4a0d..c952512023 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -163,6 +163,8 @@ New Features
 * **Updated NXP dpaa2 driver.**
 
   * Added RSS RETA query and update support.
+  * Added the inner IP header to the RSS hash so tunnelled traffic is
+    distributed across the Rx queues.
   * Removed the software VLAN strip offload:
     ``RTE_ETH_RX_OFFLOAD_VLAN_STRIP`` is no longer advertised,
     as no hardware strip backs it.
diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
index 26ad105c73..5bb9ad4591 100644
--- a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
+++ b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
@@ -236,6 +236,9 @@ dpaa2_remove_flow_dist(struct rte_eth_dev *eth_dev,
 	return ret;
 }
 
+/* hdr_index selecting the innermost IP instance in a dpkg extract */
+#define DPAA2_DIST_HDR_INDEX_LAST 0xff
+
 int
 dpaa2_distset_to_dpkg_profile_cfg(
 		uint64_t req_dist_set,
@@ -381,42 +384,40 @@ dpaa2_distset_to_dpkg_profile_cfg(
 			case RTE_ETH_RSS_IPV6:
 			case RTE_ETH_RSS_FRAG_IPV6:
 			case RTE_ETH_RSS_NONFRAG_IPV6_OTHER:
-			case RTE_ETH_RSS_IPV6_EX:
+			case RTE_ETH_RSS_IPV6_EX: {
+				static const uint32_t ip_fields[] = {
+					NH_FLD_IP_SRC, NH_FLD_IP_DST,
+					NH_FLD_IP_PROTO };
+				static const uint8_t ip_hdr_index[] = {
+					0, DPAA2_DIST_HDR_INDEX_LAST };
+				unsigned int f, h;
 
 				if (l3_configured)
 					break;
 				l3_configured = 1;
 
-				kg_cfg->extracts[i].extract.from_hdr.prot =
-					NET_PROT_IP;
-				kg_cfg->extracts[i].extract.from_hdr.field =
-					NH_FLD_IP_SRC;
-				kg_cfg->extracts[i].type =
-					DPKG_EXTRACT_FROM_HDR;
-				kg_cfg->extracts[i].extract.from_hdr.type =
-					DPKG_FULL_FIELD;
-				i++;
-
-				kg_cfg->extracts[i].extract.from_hdr.prot =
-					NET_PROT_IP;
-				kg_cfg->extracts[i].extract.from_hdr.field =
-					NH_FLD_IP_DST;
-				kg_cfg->extracts[i].type =
-					DPKG_EXTRACT_FROM_HDR;
-				kg_cfg->extracts[i].extract.from_hdr.type =
-					DPKG_FULL_FIELD;
-				i++;
-
-				kg_cfg->extracts[i].extract.from_hdr.prot =
-					NET_PROT_IP;
-				kg_cfg->extracts[i].extract.from_hdr.field =
-					NH_FLD_IP_PROTO;
-				kg_cfg->extracts[i].type =
-					DPKG_EXTRACT_FROM_HDR;
-				kg_cfg->extracts[i].extract.from_hdr.type =
-					DPKG_FULL_FIELD;
-				i++;
-			break;
+				/* Hash on the outer IP (index 0) and the innermost
+				 * IP instance. A plain frame has a single IP header,
+				 * so only the outer extract resolves; a tunnelled
+				 * frame resolves both and is also spread on its inner
+				 * IP.
+				 */
+				for (h = 0; h < RTE_DIM(ip_hdr_index); h++)
+					for (f = 0; f < RTE_DIM(ip_fields); f++) {
+						kg_cfg->extracts[i].extract.from_hdr.prot =
+							NET_PROT_IP;
+						kg_cfg->extracts[i].extract.from_hdr.hdr_index =
+							ip_hdr_index[h];
+						kg_cfg->extracts[i].extract.from_hdr.field =
+							ip_fields[f];
+						kg_cfg->extracts[i].type =
+							DPKG_EXTRACT_FROM_HDR;
+						kg_cfg->extracts[i].extract.from_hdr.type =
+							DPKG_FULL_FIELD;
+						i++;
+					}
+				break;
+			}
 
 			case RTE_ETH_RSS_NONFRAG_IPV4_TCP:
 			case RTE_ETH_RSS_NONFRAG_IPV6_TCP:
-- 
2.43.0

