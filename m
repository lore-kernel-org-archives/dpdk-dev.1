Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6628C531CB
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 09:35:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74A0A4028A;
	Thu, 23 Jul 2026 11:35:51 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id E3F6B4027C
 for <dev@dpdk.org>; Thu, 23 Jul 2026 11:35:49 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49550ec592cso1741995e9.0
 for <dev@dpdk.org>; Thu, 23 Jul 2026 02:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784799349; x=1785404149; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=425IOe62VHh1DCbE9FjyySLAKQFT1iR9hN6TWc7zDNc=;
 b=C4tVKjBp4ZyaKgh6DW1J69MKtdgAkQcMNv3NZPV8+qJ5bpPlM5FsCukV8YTtBM0rzZ
 hpwNS1Z8ajbf3t+/Xgin9ZraqWX1TcKFSABT+nlCyEuNLzo5IOTnzF7m49gvTfh6J64o
 gDBW+NSfXotMXdnMXzfA0rRHhi1WDJEHRau4wpLDIFgy6vsV2gYQW2luGJJO5W4g5C+g
 f8PG7JYVCLsPxUnXQiexd5SSt67ZpF403tWlEFOYqs+E/O4yHGOEQxLukJlkkoqwi0X3
 5HXYY9KXxILddIhh8sy2KEh5LQFXePxU/iHU428C0P+ETVQ8fJxJRdC23SmPpf0ktOK6
 qwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784799349; x=1785404149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=425IOe62VHh1DCbE9FjyySLAKQFT1iR9hN6TWc7zDNc=;
 b=eo3byrrVdcmLqw8EHDad7eXMWuatTXOx1Q7exQEC2mP1xJhdO/QfrapRJSMmQ8vKIW
 3hm532O4YMhSHgLUQflNXe5LAyfMBbD5f/i+0ZvssWDpyRnx+Hd7IFs7o5HVVaOqicIE
 2FgNHCdvJjSNEucgqlLQAUxf1ocdHagFJgvAd7R/9wJzWIY1IllmBf0V/c2CGKhTVsZc
 bzHtFEA7c8hEyWLy9ZP6IpqtSaP2OsW+2ytkAyJ9yNfordwNFUONu2RnJ3NnXabrjflQ
 JUaZrTCK843DZoL741qE4xqVDjD2rq7qh9hw4PiUhPglY4AxjvAR9l6qqs47/Roa69JJ
 rc5A==
X-Gm-Message-State: AOJu0Ywqf/aMOZRU3/TaxQOba9aAsx8lfJrO0dir9OsAJm9T1X6irlLk
 UKh4rUL00rxqy+gQW0yIOTXQFXz+akvhO19Gbmh+UArvlpqkQxFGsf4An3TK7zUr
X-Gm-Gg: AR+sD13yGp8HWw00id/VsxYe70k70lzIVgaE7KDR8muF9rkvCFKRbcHJ2ge6Q2Van3b
 vgV7T4Eo1xSkD18g5/63Bv31QAsbKT4cWRzXGHEQAUImdcH2oKi15EUCs+KcQf303otzHO/R5Yx
 nyjnw/Q0sYbP/BqysCkXkUqgb869Ma61SvGXgGF6giaTrTgspXu0/iMb1ZnURVH6xOsd0Hdub4I
 ge4H6C8gPqn5UpNc6jBh+QupTq/wNMf+w4I/b8xCvmkGD+t3jcSOR/uI56CyeRUr8iaI2MWe0nz
 bJoi90b7xxs2fdNrpRyUGVIComRcv5zV3nOvkEhAEGKK4LjDV8CLzMGvTZOXfzKc3CGCsSt011+
 rnYOVanZKONTOukAP0zHOCAQKZtK5qjHhAbY31y2ASlAqum35Ikh25PVX4/fKP9s525SJk/0lAW
 h8gep2ZY0r6WP8LvZt/qPmoQ==
X-Received: by 2002:a05:600c:8284:b0:495:3c6f:7c18 with SMTP id
 5b1f17b1804b1-495745817f9mr19810375e9.3.1784799349077; 
 Thu, 23 Jul 2026 02:35:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:6f:bdf0:7f2c:8921:1691:e459])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495730353d9sm56728425e9.12.2026.07.23.02.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 02:35:48 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Maxime Leroy <maxime@leroys.fr>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2] net/dpaa2: hash inner IP for tunnelled traffic
Date: Thu, 23 Jul 2026 11:35:40 +0200
Message-ID: <20260723093540.1839619-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720133436.869334-1-maxime@leroys.fr>
References: <20260720133436.869334-1-maxime@leroys.fr>
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

Extract both the outer IP (header index 0) and the innermost IP
instance (HDR_INDEX_LAST). Plain frames keep being hashed on their only
IP header; the inner extract resolves to nothing and adds no entropy.
Tunnelled frames are also hashed on their inner IP and spread across the
Rx queues.

This is the PMD default hash: dpaa2 does not expose the ethdev RSS level
selector, so it applies to every RSS request. The hardware cannot hash
the inner IP alone, as HDR_INDEX_LAST only resolves when several IP
headers are stacked and a plain frame would hash to a constant. Folding
the outer IP into the key is therefore unavoidable, and two tunnelled
flows that share an inner IP but differ in their outer IP may hash to
different queues. This is documented in the dpaa2 guide.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
v2:
* Dropped the first patch (the INNERMOST revert), now applied upstream;
  this is the remaining standalone patch.
* Rebased on main for the 26.11 cycle; moved the release note from
  release_26_07.rst to release_26_11.rst.

v1 (since RFC):
* Reworked the approach: rather than overloading INNERMOST to also hash
  the outer IP, always extract outer+inner as the PMD default, since
  dpaa2 does not expose the RSS level selector, and revert the INNERMOST
  support in a separate patch. Dropped the Fixes: tag accordingly.
---
 doc/guides/nics/dpaa2.rst              |  3 ++
 doc/guides/rel_notes/release_26_11.rst |  5 ++
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c | 63 +++++++++++++-------------
 3 files changed, 40 insertions(+), 31 deletions(-)

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
index 938617ca75..bdfe424f26 100644
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

