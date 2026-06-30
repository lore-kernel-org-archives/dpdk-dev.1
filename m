Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD04C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 12:39:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80586402D7;
	Tue, 30 Jun 2026 14:39:10 +0200 (CEST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 1F99640261
 for <dev@dpdk.org>; Tue, 30 Jun 2026 14:39:09 +0200 (CEST)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-472326ca506so1467403f8f.2
 for <dev@dpdk.org>; Tue, 30 Jun 2026 05:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782823149; x=1783427949; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=LN0AWfCZawiKsTW/6HJ05JtqQGwW9bt2alYMxHb8Ikk=;
 b=EpyEDmleQb8lx5DGOz4HKQwbg9fkQSbeVfvLrd+MJADtAUPu7/EHCMkAw7lRPZp/Ow
 mvhGUPrXFvfeOL6dZALU96gN9B/vARei0N52LUtkuGr2oZAA0FKfMvsw5KUCEL41OCQa
 pbB4fjQQ5GRgp2QLrRZH5aCuqYucNUA3A2Nlv86LpKPmD/Clyu7ynjGfGHr3MVV7h9q7
 KO1Bpgv/KMHejucr+KKP5HmDjzpCkj7PJX58Uhw0RgGs3KssVtxMaMA6LswrbSS9+Ov5
 4Yye5RVmHIsweXEAXmCY7QTrl2nFfPgNqGQYYUNmJ3nmt/XIhIcHSyyTl8L/BTd1ZBIE
 U4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782823149; x=1783427949;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LN0AWfCZawiKsTW/6HJ05JtqQGwW9bt2alYMxHb8Ikk=;
 b=g2Dd9xFbjrphaGzUOWvaO8ga79bJFQUNhBVk+1Isn4zmGb4zNLh0Ci2UE6Nc7Y0faW
 9iEJ7OlZH6h9ohaQrfFZrmoHPIbKK1784M8wmEbSDiae2U3XA6qIgSeRhoucV+Icjgxd
 OY7HESuJCTtqytVjwx94FuAjhbVd/0g8yojdQFDC9CcHpVFueTgFjOuLZqSPrIXFYBTq
 xtOIolIdylNLn0qUzaRL0l/X9KthB2CB3baeWIyPLRoWlzLAZiW7Kx4l/Fxug0tjrsRn
 qNRAnag29xbr0V+pF0zgiI57g1I2y1AgNdLnCTSZ84p2zVf1SteJUgsAR6JI2QXb3Lug
 Q06Q==
X-Gm-Message-State: AOJu0YyulzkdYjUn0pLGoN8getRcPaNVdHhymyGn0dcMNvfxG2HW4U+J
 5KNoo/mYoPfdzARbhiP3gxceI+68A42nKy9tMwC8p+4zLfCHa4STgZBOfVUwtg==
X-Gm-Gg: AfdE7ckLdKsNI9VykyUG4zzWm7KF94Zie9DYmC02ADyjXDTwRmqRGzCVvDUzmx2rUSd
 66fL+ImXTBAfqIWX6KWLrcqWdLcTKmZHANZake+Vdwx2nz55fPIwNlhml7fbmNW6i47naD3iM9X
 Hn8SsqliWJ+o349RonxiIUfdwy3WCwckeDjQ1k6mfNuUAk4Ssw2+IKO1ZGWGH/ADIOPaoVZ210e
 xaaaDZWTDtlBDRNeU3CyyRXyqHWYoTnz6DLqoS3uGoDVE7FWP6sMfvh5WIY7DN8T+LeETkyHNQD
 /DSGcwDt9y4CNMA72Z1DRrq+Z7MuE/2+ihFFXzxEYvaEI2SnQ/x5Jgdztpoq1DsAux8jVe2n3G9
 m006r4WhMLxO+B8CJOCRJDxNueUlEO3EW+MXAk5MCa86S8ntnmC3WumzxgRa3qF+mxlgBxSFV19
 Op2cvHzTm9E8/jeTngbRQvX6dfY7fo9n/NSRpTPH6TAg==
X-Received: by 2002:a05:600c:4e8b:b0:493:aa28:38ad with SMTP id
 5b1f17b1804b1-493b82861b2mr50839635e9.10.1782823148404; 
 Tue, 30 Jun 2026 05:39:08 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8cd303csm64544245e9.6.2026.06.30.05.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 05:39:07 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, sachin.saxena@nxp.com,
 Maxime Leroy <maxime@leroys.fr>
Subject: [RFC PATCH] net/dpaa2: fix RSS at inner level for non-tunnelled
 traffic
Date: Tue, 30 Jun 2026 14:38:57 +0200
Message-ID: <20260630123857.392884-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
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

When RTE_ETH_RSS_LEVEL_INNERMOST is requested, the IP key extracts use
the innermost header index (HDR_INDEX_LAST). The hardware only resolves
that index when several IP headers are stacked: for a non-tunnelled
frame, which carries a single IP header, the extraction returns nothing.
The RSS hash is then constant and all such frames are steered to a
single Rx queue.

Always also extract the outer IP (header index 0), which the hardware
resolves for any frame. Non-tunnelled frames are thus hashed on their
only IP header, while tunnelled frames keep being hashed on their inner
IP.

This is a deliberate tradeoff: the ethdev API defines
RTE_ETH_RSS_LEVEL_INNERMOST as hashing the innermost header only, but the
hardware cannot do that without breaking RSS for plain traffic. As a
consequence, two tunnelled flows with the same inner header but
different outer IPs may hash to different queues. This limitation is
documented in the dpaa2 guide.

Alternatives considered (feedback welcome, hence RFC):

- Hash both outer and inner only under RTE_ETH_RSS_LEVEL_PMD_DEFAULT and
  keep INNERMOST strictly inner-only. The ethdev API leaves the default
  level to the PMD, so this stays API-compliant; it changes the default
  hash for tunnelled traffic.

- Add a generic RTE_ETH_RSS_LEVEL_OUTER_INNER value to the ethdev API so
  applications can request hashing on both encapsulation levels
  explicitly, instead of overloading INNERMOST. This needs an ethdev API
  change and agreement from other PMDs.

Fixes: 32f701671d2f ("net/dpaa2: support inner RSS level for tunnelled traffic")
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 doc/guides/nics/dpaa2.rst              |  6 +++
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c | 64 +++++++++++---------------
 2 files changed, 33 insertions(+), 37 deletions(-)

diff --git a/doc/guides/nics/dpaa2.rst b/doc/guides/nics/dpaa2.rst
index 2d70bd0ab9..b7b68f0cd5 100644
--- a/doc/guides/nics/dpaa2.rst
+++ b/doc/guides/nics/dpaa2.rst
@@ -558,6 +558,12 @@ Other Limitations
 
 - RSS hash key cannot be modified.
 - RSS RETA cannot be configured.
+- Under ``RTE_ETH_RSS_LEVEL_INNERMOST``, the IP hash also covers the
+  outermost IP, not only the innermost one. The hardware extracts no IP
+  at the innermost index for non-tunnelled frames, so the outer IP is
+  added to keep RSS working on plain traffic. As a result, tunnelled
+  flows with the same inner header but different outer IPs may be
+  distributed to different queues.
 
 .. _dptmapi:
 
diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
index 07f4a3d414..b002dba171 100644
--- a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
+++ b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
@@ -398,48 +398,38 @@ dpaa2_distset_to_dpkg_profile_cfg(
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
+				unsigned int n_hdr, f, h;
 
 				if (l3_configured)
 					break;
 				l3_configured = 1;
 
-				kg_cfg->extracts[i].extract.from_hdr.prot =
-					NET_PROT_IP;
-				kg_cfg->extracts[i].extract.from_hdr.hdr_index =
-					hdr_index;
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
-				kg_cfg->extracts[i].extract.from_hdr.hdr_index =
-					hdr_index;
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
-				kg_cfg->extracts[i].extract.from_hdr.hdr_index =
-					hdr_index;
-				kg_cfg->extracts[i].extract.from_hdr.field =
-					NH_FLD_IP_PROTO;
-				kg_cfg->extracts[i].type =
-					DPKG_EXTRACT_FROM_HDR;
-				kg_cfg->extracts[i].extract.from_hdr.type =
-					DPKG_FULL_FIELD;
-				i++;
-			break;
+				/* outer IP always; inner IP too for INNERMOST */
+				n_hdr = (hdr_index == DPAA2_DIST_HDR_INDEX_LAST) ?
+					2 : 1;
+
+				for (h = 0; h < n_hdr; h++)
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

