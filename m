Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC21CFF5106
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:20:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7F8940DCB;
	Tue,  7 Apr 2026 17:19:01 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id B53C340DD5
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:19:00 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c76b994f7a8so2200674a12.3
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775575140;
 x=1776179940; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c739IzSfW87eEdpO7+idB9dNSZ9Bf0b81P5/erbf/VA=;
 b=n7Im8KtumQu7qrvXOy0yzyA6KomQmy2yQ13YB7RjsGddzWzqGukH3MIdtkJlearXoW
 s3t6XWOh3BSYjSxj2O9UpOfoVXqc+qnEQ1CLai2wwpKFKGC6rxFUL1SF/Qk+YQNG0bs0
 czKU1CMrBTTMNwzNgw8imNdXBQYp3Ar09f6xtdZG1DHdRxGK1Ps2FMPqddio29S4/SbT
 M+tEkuOHll8Jn5skbvCrMUmE64iFfaENZQbxDBzKJCkwsJIS5D5PumPkkAXN8G633d91
 RGrcMFzThSzyP0Du6EXV+umyrCWlt1sP9Oq3lBPYYpzdMNjCjvbLJTlE2Op1wAxlHMo1
 FF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575140; x=1776179940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c739IzSfW87eEdpO7+idB9dNSZ9Bf0b81P5/erbf/VA=;
 b=ph4GvtNrLsimYYJgPesgIAa+/E4apfc5mKcIuN1bAMNxC6IgaZB8+CNbIMA4XFAgA4
 k3Y3v6wK5UloR86M4r+ieZ5J0oF4sHk6KpecUBBtTKUAy2YgH4FJpn6VNPmqqwZUytB4
 4Z/4FdUVU38ih4W08ujRrTS0X2ZRLRQYQV+gt+Vbnrf4vGHJq3YDuZL0MBPtGBUzeHB6
 o8NiLmLVAW4QfpdwTkqalonWsF6Kr8/TlMVdhBtm58Nr8tL5tqwyBTmNkHloOIqS2qbZ
 2k9dZZOeE78N5Lsp+URL6GrcdW/9Dr2/jKXy7boSo7j3U36zgaG66Pd0Fm29mODW5Jtv
 ISzQ==
X-Gm-Message-State: AOJu0YzoXDNOccAIWPXqiIWGXXq9ExUcQeCDWus97PKI2lq/rzlUS9GY
 DUXcHQG/Y1fqch0gY9eK79DIlp5LSEPOnG2CRhKJvaiaqRooyksyLv6j5Wxqc7xmooc8p3xGGc7
 e3V3l
X-Gm-Gg: AeBDieuhJylw/s7to9WFcGlTCoL4xJ6bGeLEmBgXbdKTPvVkIw0TivEg0uWQIY0LT4n
 g0MsdBjG7dh4A4zBI+0AnR9iCWXNzTmGlNq65XwsOVHq1NuJqM9ZyIfkKX8RxAtf+DtRq4rNHLy
 Hcpsb4Xj8lkCE8Whh03TEeDj+lrA7q9z2pNUykzU5+D/tPR7j4Yf3dC3RA0dM1Mw2vAorR0Biwm
 1f1y4bPAOwYVyRPT0vDhg6awsxp3SziUOPRkkcsDr4aVFyeAqVyzhhOja4MmRACwpoucNCFFzDn
 JecGGSVvBdGgJ25pPf1vSPAUhljhlA1REwPbW/0YhfMr1oyodXQbMzIonw1hhGx9hxPeR2asXoH
 jJ+I9DE+HgHdClalU8zcaZYvnZc2x2K1F6P3bTGNePz8dbbqtdBnkDaavOf6yxEhABbQJ9s+nEA
 m5YoeB3dStP2zU3NdwXuZ5J81ZoFxj90eH80sCLWi3LFo=
X-Received: by 2002:a05:6a21:3283:b0:39b:e115:f690 with SMTP id
 adf61e73a8af0-39f2f096b60mr16340895637.42.1775575139786; 
 Tue, 07 Apr 2026 08:18:59 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm15842933a12.3.2026.04.07.08.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:18:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH v2 23/23] examples/l3fwd-power: resolve shadow variable
 warnings
Date: Tue,  7 Apr 2026 08:16:19 -0700
Message-ID: <20260407151732.272195-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407151732.272195-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
 <20260407151732.272195-1-stephen@networkplumber.org>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

