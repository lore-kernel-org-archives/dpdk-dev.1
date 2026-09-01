Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAF6C61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:33:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C00F440DD0;
	Tue,  1 Sep 2026 22:32:56 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id B448240E40
 for <dev@dpdk.org>; Tue,  1 Sep 2026 22:32:55 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-8535a9be75eso242682b3a.2
 for <dev@dpdk.org>; Tue, 01 Sep 2026 13:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788294775;
 x=1788899575; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5RgWO3AeG0SiCatsw8qEplLWrq60QCJZnxcsr84UPUU=;
 b=Cunf1H47KWTIRpkNxRW02eHxH1nNXRo0XSNtLZCrM3GCpV89smsgRwAYVsyusNfn4+
 Y9HxjlsFav7eEUQ3zN/gWDy1CsuZdOiF4l3ZDyck8wsTn95k6BfO/4QJJwwGUD36xW81
 dZvblmDG+xl65zmDrxkiLkbSZagNUYaey+vq5t7R60bhA+Vjz/AU3UZM7Vt7oTiAScoC
 S9hh60wVoS79vqcX3BxnAytB4Q+lUN4QzXclR1xBypdbsS3UJPudP5f9LrSiOYnYomzU
 WlkGBTXgLYcfzQ8YbwaroR9S/m+bi+H6S+ErAZpCLlGXYnzKiIELfN48asYi3PB0tmcS
 PkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294775; x=1788899575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5RgWO3AeG0SiCatsw8qEplLWrq60QCJZnxcsr84UPUU=;
 b=TNZSkPEZvbyRpqxv9D6mw6vQFkL+IPG7bJvzFvwII7ZNZCt5os+5UTWoy11Ra7u4/5
 nCok79HG3p96uowvjPGBi2Wk7bZOc3RACOdAAP19Z5H11adqrFzx3gztcTynMo/KvwlX
 MSIB4t6IZ5mCL1yTLhZRYkcJCmMVgfkt8rb/owGltaZPoLAuSipXGnbDLOLk4lShdCWf
 T31pHMItSnrBysXiga3+Z44tur07ooqSY3enNstk4rzmAPV5G0GTvkafLERdaQrKstG/
 stR65c5LyVaNdl4rr/klQaujKELQ6rl0k2ZqbX+aOkznHwIVOTIUouh/ivyyQtuEBsR9
 Jo/A==
X-Gm-Message-State: AFuF++ldtpmT9G+L8Ja1Uz4wNSTz0XVlQxTRBi+AHTooBADYUhWuQzr+
 qy/bi2SR4FWbc22xVUiASYABBVO7oLltgp+63QMVv0nBKwDXexXlJprFp3jPEK63tt3P5ixK3pG
 zKErx
X-Gm-Gg: AR+sD137FVpNrJ2bA4MngVqIvA7yrhnXQTjiKYsJ+H71lvhSm7YS4xZzbo0f4MfMdTv
 rePgT3sNWpFP1zKX5mXBmHBSKwnZcD20CQ0tYcZyNRg+Mu5/jhrxqcg8zcmSiQVkaOs91M214Om
 g2AOv1Xt818CwxQuhCWwB1I2Boxr0bVjUakezk6AZz5IZ6c3mG42RgkWB7H+KdM7UKl48s7HJht
 kAIXsjr2f5QFoW6wb/uPv2YJz3sdWKFqQpAu+uakPXW//sxXrFbP7ttLdk9opyYhtAyh3yig0b4
 di5UkX2IYfbU9DX5S1IDKBniC/UoWX7ISQhdkBE2stUsdcJ17d/A0NMOZtHIHUtbu2vZk3jL3VH
 qWHN8LdpRCz7ZqVZBzR8Tkhu6p8K029qA4NfOurng7C09P5aJaXNC8kzbZoA348puYzVitQufqS
 WbJlLmaKSb2ItakQZ3hIf0zQFDIwgOHD6nlFW+4FjpfGLMjU3e9yXoc7fcgBmaQLjxe6N652+At
 hBMWMmrrUbIzUTCk6eWYWn9qj0=
X-Received: by 2002:a05:6a00:421a:b0:848:34ad:3d6c with SMTP id
 d2e1a72fcca58-85ed8017e39mr540355b3a.15.1788294774828; 
 Tue, 01 Sep 2026 13:32:54 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc0bffbc1sm323980b3a.48.2026.09.01.13.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:32:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 07/22] ethdev: promote link speed helpers to stable
Date: Tue,  1 Sep 2026 13:23:06 -0700
Message-ID: <20260901203217.1485915-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901203217.1485915-1-stephen@networkplumber.org>
References: <20260901203217.1485915-1-stephen@networkplumber.org>
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

rte_eth_link_speed_to_str() and rte_eth_link_to_str() were added in
v20.11 to give applications a common way to format link information
instead of open coding it. Both are unchanged since.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 1 +
 lib/ethdev/rte_ethdev.c                | 4 ++--
 lib/ethdev/rte_ethdev.h                | 8 --------
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c4a9053b59..9b5e3cf902 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -109,6 +109,7 @@ API Changes
   * clock: ``rte_eth_read_clock``
   * flow dump: ``rte_flow_dev_dump``
   * FEC: ``rte_eth_fec_get_capability``, ``rte_eth_fec_get`` and ``rte_eth_fec_set``
+  * link speed: ``rte_eth_link_speed_to_str`` and ``rte_eth_link_to_str``
 
 
 ABI Changes
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index d814ee55f9..6fda1468f9 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -3208,7 +3208,7 @@ rte_eth_link_get_nowait(uint16_t port_id, struct rte_eth_link *eth_link)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_link_speed_to_str, 20.11)
+RTE_EXPORT_SYMBOL(rte_eth_link_speed_to_str)
 const char *
 rte_eth_link_speed_to_str(uint32_t link_speed)
 {
@@ -3275,7 +3275,7 @@ rte_eth_link_speed_to_str(uint32_t link_speed)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_link_to_str, 20.11)
+RTE_EXPORT_SYMBOL(rte_eth_link_to_str)
 int
 rte_eth_link_to_str(char *str, size_t len, const struct rte_eth_link *eth_link)
 {
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 41a744059c..2a694130ea 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -3110,9 +3110,6 @@ int rte_eth_link_get_nowait(uint16_t port_id, struct rte_eth_link *link)
 	__rte_warn_unused_result;
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * The function converts a link_speed to a string. It handles all special
  * values like unknown or none speed.
  *
@@ -3122,7 +3119,6 @@ int rte_eth_link_get_nowait(uint16_t port_id, struct rte_eth_link *link)
  *   Link speed in textual format. It's pointer to immutable memory.
  *   No free is required.
  */
-__rte_experimental
 const char *rte_eth_link_speed_to_str(uint32_t link_speed);
 
 /**
@@ -3140,9 +3136,6 @@ __rte_experimental
 const char *rte_eth_link_connector_to_str(enum rte_eth_link_connector link_connector);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * The function converts a rte_eth_link struct representing a link status to
  * a string.
  *
@@ -3157,7 +3150,6 @@ const char *rte_eth_link_connector_to_str(enum rte_eth_link_connector link_conne
  * @return
  *   Number of bytes written to str array or -EINVAL if bad parameter.
  */
-__rte_experimental
 int rte_eth_link_to_str(char *str, size_t len,
 			const struct rte_eth_link *eth_link);
 
-- 
2.53.0

