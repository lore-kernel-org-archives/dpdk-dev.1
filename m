Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C151FB5188
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 03:54:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31ED940A79;
	Tue,  7 Apr 2026 05:52:40 +0200 (CEST)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id E055940696
 for <dev@dpdk.org>; Tue,  7 Apr 2026 05:52:34 +0200 (CEST)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-12c0b72dac7so1936923c88.0
 for <dev@dpdk.org>; Mon, 06 Apr 2026 20:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775533954;
 x=1776138754; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qtejHMrL2kwf+nsd9x8xPlf895PlpWx44mLY2g+p6wY=;
 b=NTb2oXr1SqWOjRWLreqA36iy3rojhswY9pHZjQTjGdhhosRBuGpCIhfd95YBGghCXX
 xwpOn1bNy65V9aXvrkIH1ceKZP/ZbEmtE1jVZ/X6bOccGeqkqZdx4VyMY6X79dFnZdLU
 e/55iMKNViJanKle0x/TaJclaJg0ZaZVQ6abUKqu5H8+pBI9N+LrYL14rnOBWWqRhBeO
 6cf6hsjWiFC3rETgMAfyKSRpIZAqdBLODzJR8feDdVsl9dyNuL/2a89OccrIrDV+YBXT
 /AmA8N1TqqMf07QVm9+CSWsyWRNpDCP9itaDvRAS4yMkNutNKtqQS4uFkHhNNdos9qtD
 vrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775533954; x=1776138754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qtejHMrL2kwf+nsd9x8xPlf895PlpWx44mLY2g+p6wY=;
 b=ZELLadTMfw7mNjihUSAOSAXWh9dn2y/xeydSCYevfFOWjPRizLRavF0/8QgnP1ahnu
 QIkMjceEDYgYHrczRRh1fIZSo7fO5nH9yHCBdVzXw4E4QoNEPkqP+5xUmPerpoqnzxSF
 0nzjGcfYsFRRXDx9VSyrHQzlmnH2L6up0mwbc8JBOE55CXkHUhgLze8sz7O3ZzxTZvsJ
 1UaxvcYDJu/M2hYXsEX5HYqAhAKOqeN6QuijXfIg12oyCkhHjL+ccyWpDjlXTVGHSiPt
 IZyvUQVrPtfmB75Ifh2Wh9MXxImnzVQKEVFKixcsyJAooJVLVIHDxBg0vtKiyUlFh/Oz
 SvAg==
X-Gm-Message-State: AOJu0YylUUQT2JrNFhRQNK6btN2eTT7ju8uaTBspoepRBOs4OxayLgz4
 yjPl7LISkRnfROogqQZ78V09cossRVCXWwRAVyLX/k1EgcYYqsnViAm90dyla4e6Ov/g2mR6g5a
 1jL8r
X-Gm-Gg: AeBDietZRErv65SneCN7JqrW5E0HDhUA+Zw6qQRF6jM82mN3Za9KrQg08vZ1tzRYtO0
 wiUHunpcbJAxFDsBlj+biF3KPjzwMeB6+79mMnF9bWb04ErNRZSLD07oKtuLWOGCZaqbScTNlw/
 bbgJyEIzYrZAAwTKXuqJKWfnKYTaqW4jTNp/lQfzANkbdL/7IsbDPSbPZx8nPLkVZAhzVMHnrQb
 QZ3sDmsreIeKObZkN48PVmhI7V+KPkc8FiaALk4vLuWlE2+novjsSu8UhX0G1Cj2wHeRT5OHWHy
 eWrs1ke8kkd0aQLpot9QDAzpZZRxUqhhJDrStgMPaqkUtVeHc3JP/ebUI4DA8CEwWOWO+jDe04L
 sbyAc23TTDlGM6pGpDUXJ3o+c++7JTp/wHzis2dtcpb7dAtfWZK0lrPyRn1kh3DBV4A1mbrQyG8
 cpZi8BELyEtB5P5SREmrz2RgevW/SYcIN2
X-Received: by 2002:a05:7022:43a8:b0:128:ce84:f68b with SMTP id
 a92af1059eb24-12bfb6ec4ffmr7245672c88.4.1775533953892; 
 Mon, 06 Apr 2026 20:52:33 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede545e8sm12716093c88.11.2026.04.06.20.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:52:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH 23/23] examples/l3fwd-power: fix shadow variable warnings
Date: Mon,  6 Apr 2026 20:49:49 -0700
Message-ID: <20260407035209.650419-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407035209.650419-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
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

Rename function parameters to avoid shadowing the file-scope
static arrays ipv4_l3fwd_lookup_struct and ipv6_l3fwd_lookup_struct.
The new parameter names ipv4_lookup_struct and ipv6_lookup_struct
match the member names used in struct lcore_conf.

Fixes warnings with -Wshadow for get_ipv4_dst_port (both exact-match
and LPM variants) and get_ipv6_dst_port.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/l3fwd-power/main.c      | 12 ++++++------
 examples/l3fwd-power/meson.build |  1 -
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index 02ec17d799..ff0e61e639 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -552,7 +552,7 @@ print_ipv6_key(struct ipv6_5tuple key)
 
 static inline uint16_t
 get_ipv4_dst_port(struct rte_ipv4_hdr *ipv4_hdr, uint16_t portid,
-		lookup_struct_t * ipv4_l3fwd_lookup_struct)
+		lookup_struct_t *ipv4_lookup_struct)
 {
 	struct ipv4_5tuple key;
 	struct rte_tcp_hdr *tcp;
@@ -585,13 +585,13 @@ get_ipv4_dst_port(struct rte_ipv4_hdr *ipv4_hdr, uint16_t portid,
 	}
 
 	/* Find destination port */
-	ret = rte_hash_lookup(ipv4_l3fwd_lookup_struct, (const void *)&key);
+	ret = rte_hash_lookup(ipv4_lookup_struct, (const void *)&key);
 	return ((ret < 0) ? portid : ipv4_l3fwd_out_if[ret]);
 }
 
 static inline uint16_t
 get_ipv6_dst_port(struct rte_ipv6_hdr *ipv6_hdr, uint16_t portid,
-			lookup_struct_t *ipv6_l3fwd_lookup_struct)
+			lookup_struct_t *ipv6_lookup_struct)
 {
 	struct ipv6_5tuple key;
 	struct rte_tcp_hdr *tcp;
@@ -625,7 +625,7 @@ get_ipv6_dst_port(struct rte_ipv6_hdr *ipv6_hdr, uint16_t portid,
 	}
 
 	/* Find destination port */
-	ret = rte_hash_lookup(ipv6_l3fwd_lookup_struct, (const void *)&key);
+	ret = rte_hash_lookup(ipv6_lookup_struct, (const void *)&key);
 	return ((ret < 0) ? portid : ipv6_l3fwd_out_if[ret]);
 }
 #endif
@@ -633,11 +633,11 @@ get_ipv6_dst_port(struct rte_ipv6_hdr *ipv6_hdr, uint16_t portid,
 #if (APP_LOOKUP_METHOD == APP_LOOKUP_LPM)
 static inline uint16_t
 get_ipv4_dst_port(struct rte_ipv4_hdr *ipv4_hdr, uint16_t portid,
-		lookup_struct_t *ipv4_l3fwd_lookup_struct)
+		lookup_struct_t *ipv4_lookup_struct)
 {
 	uint32_t next_hop;
 
-	return ((rte_lpm_lookup(ipv4_l3fwd_lookup_struct,
+	return ((rte_lpm_lookup(ipv4_lookup_struct,
 			rte_be_to_cpu_32(ipv4_hdr->dst_addr), &next_hop) == 0)?
 			next_hop : portid);
 }
diff --git a/examples/l3fwd-power/meson.build b/examples/l3fwd-power/meson.build
index e45cda86f9..5ff4466cac 100644
--- a/examples/l3fwd-power/meson.build
+++ b/examples/l3fwd-power/meson.build
@@ -13,4 +13,3 @@ sources = files(
         'perf_core.c',
 )
 cflags += no_wvla_cflag
-cflags += no_shadow_cflag
-- 
2.53.0

