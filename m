Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630E6C61DB6
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 07:43:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A62E4014F;
	Tue, 25 Aug 2026 09:43:25 +0200 (CEST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 0164C400D5
 for <dev@dpdk.org>; Tue, 25 Aug 2026 09:43:23 +0200 (CEST)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47f84023916so3082684f8f.3
 for <dev@dpdk.org>; Tue, 25 Aug 2026 00:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787643803; x=1788248603; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nw0RWo7tzHcMGyj9KEpYMaMPZ+Y5/hkxr+9xuHPC2KY=;
 b=D1MJb9yb/UNebeVD16Das5apj4p1J+rPK17S1T+BFifQP3vBlg/w5gQopd8JCq6ztB
 Y0udliLqoIuEJekKJTH2FAqY29N2DEjoxuTnI9poxm+SytJkkGLQdyzuq6PQ/htkQsdj
 VNmDrbmGz/y47Jzn14K5bboFH3fjUYWoaPrktQIIs56JXiS2IFmemBFdyA7f2QmVh6xX
 VT6SflCkShzfVc+RJHJVnGGgpIfkBaJ+xZP7rvX6N0awF5LWKX9/slBFkSCQ0dvcmjEV
 2wkfCjdzPxrmNgW2TJpcRtm2RYDuxsa+a+gI566fRjfDDRta8hIxlk11KqSHsqPdvjX8
 MXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787643803; x=1788248603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nw0RWo7tzHcMGyj9KEpYMaMPZ+Y5/hkxr+9xuHPC2KY=;
 b=LtqrfbWT4Ths6Ed8XB4K8AoPxuvqWEDvCejCSVx3KA2Mp+zY5o5YD76bDHhnYEeRHs
 b/cii3+psE/atTLPLA/qew+gaSwApk0tDPl+7LT94xT6hAp9EWPRo+M59dYYeoIuJD1C
 lAYDW0ihubj3JkkVBkUQVwRzgXx/7hhMEJ2H9Ur6AiQIxzhqZM/4jlWX7eNnJDWahApj
 9bDDYT/sgpg6Jbrn3aMFICke2rwR39+c1FLyhqycRcAPdIkFOBZKlinnZOBOg3gwaVjB
 fJUOZn54OjS4TKjmGMPAWxgU5w5Mbeoq6C4rpFPvj4K7MuSCiNMGXJvLyP5grPazHV7I
 kaJQ==
X-Gm-Message-State: AFuF++mSqSbUWs+KdRSTKYPlnRbSM9mmNr3M8YgsvDkNXC+00gqpTorD
 A9u0H70lgQxSagOPBWrZ0ndw77XqxPgsifienBg6sG13eGqrVacEingq
X-Gm-Gg: AR+sD102/cqRO20ePwkGJVc2U6Mb4T4KHnvDTlzcoT+l4QNYuY4enI45zyFzD8U/zJQ
 EmXac9c64uK0BTp3whMVnbWvFOFV+x2+wwsQxq7FM/aqMFnpezY05GHU6E+/M8dy61cEwkSpP3C
 BQ53qE54pTwj7DMdIQI80C3kCi2d3Ibr9rD+f7KPaoMlDKz/WJvBHohWgSS29BWUw4+RVXUZpHk
 Ns5WkzHwDXrPOPmbwfA5aaJ0y1cPpOsPGyE46oRyHeZO7py9E/DcQ6LktOKbIu1r5eB0yJl7Lv8
 JfJw6l1q2LeKf8x4qspQUsA2hzJic9agYuzq4eHxVVD77tyDUh7upYLcJ2mj2uY6NF19QSqO46Z
 aq/2qhdn2sOftshcLzjjy5tz1GttkUKAAd0ISkS3OyFNMOfj4hfI2eZ2hT7bgn6HmoIDG8ZIVE8
 FPMSWr+Js8TPRQfa8Mtdr1r+z4ZwMyb25/2f5VwN3O3JHNFTQa+8/uqEzW
X-Received: by 2002:a5d:5d89:0:b0:47f:eac2:6f55 with SMTP id
 ffacd0b85a97d-482c0b94872mr38042284f8f.19.1787643803207; 
 Tue, 25 Aug 2026 00:43:23 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:1248:bd70:72a8:57c7:d75d:3066])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9c0abfcsm10656529f8f.28.2026.08.25.00.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 00:43:22 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v3] net/dpaa2: hash inner IP for tunnelled traffic
Date: Tue, 25 Aug 2026 09:42:55 +0200
Message-ID: <20260825074255.367302-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723093540.1839619-1-maxime@leroys.fr>
References: <20260723093540.1839619-1-maxime@leroys.fr>
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

That a lone IP header does not resolve HDR_INDEX_LAST is the regression
reverted by commit 2b375df07e48 ("net/dpaa2: revert inner RSS level
support"): extracted only at HDR_INDEX_LAST, every plain frame hashed to
the same value and landed on one Rx queue.

The worst case, requesting every type the PMD advertises, is 16 extracts
out of the DPKG_MAX_NUM_OF_EXTRACTS 20. On LX2160A
dpni_set_rx_hash_dist() accepts the key, and plain IPv4, plain IPv6, VLAN
tagged and tunnelled IPv6 traffic all spread across the Rx queues.

This is the PMD default hash: dpaa2 does not expose the ethdev RSS level
selector, so it applies to every RSS request. The hardware cannot hash
the inner IP alone, as HDR_INDEX_LAST only resolves when several IP
headers are stacked and a plain frame would hash to a constant. Folding
the outer IP into the key is therefore unavoidable, and two tunnelled
flows that share an inner IP but differ in their outer IP may hash to
different queues. This is documented in the dpaa2 guide.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---

v3:
* Drop the DPAA2_DIST_HDR_INDEX_LAST define and take (uint8_t)LAST_HDR_INDEX
  directly at its single use site, rather than adding a second name for a
  constant the driver already has (Stephen Hemminger).
* Record the extract budget and the LX2160A results in the commit log
  (Stephen Hemminger).
* Re-added the release notes entry dropped in v2, now under 26.11.

v2:
* Sent standalone: patch 1/2 of v1, the revert of the inner RSS level
  support, was applied as 2b375df07e48.
* Dropped the release_26_07.rst entry, that release having been tagged.
  Unchanged otherwise.

 doc/guides/nics/dpaa2.rst              |  3 ++
 doc/guides/rel_notes/release_26_11.rst |  5 +++
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c | 60 +++++++++++++-------------
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
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 87c7e81bde..4887bccbc0 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated NXP dpaa2 driver.**
+
+  * Added the inner IP header to the RSS hash so tunnelled traffic is
+    distributed across the Rx queues.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
index 26ad105c73..83694133f1 100644
--- a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
+++ b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
@@ -381,42 +381,40 @@ dpaa2_distset_to_dpkg_profile_cfg(
 			case RTE_ETH_RSS_IPV6:
 			case RTE_ETH_RSS_FRAG_IPV6:
 			case RTE_ETH_RSS_NONFRAG_IPV6_OTHER:
-			case RTE_ETH_RSS_IPV6_EX:
+			case RTE_ETH_RSS_IPV6_EX: {
+				static const uint32_t ip_fields[] = {
+					NH_FLD_IP_SRC, NH_FLD_IP_DST,
+					NH_FLD_IP_PROTO };
+				static const uint8_t ip_hdr_index[] = {
+					0, (uint8_t)LAST_HDR_INDEX };
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

