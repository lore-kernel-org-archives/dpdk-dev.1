Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BE1C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 15:38:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1F1E40A6B;
	Tue, 30 Jun 2026 17:37:44 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 023AA406BC
 for <dev@dpdk.org>; Tue, 30 Jun 2026 17:37:35 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-30e9eefa268so896539eec.1
 for <dev@dpdk.org>; Tue, 30 Jun 2026 08:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782833855;
 x=1783438655; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qTY9Z+25lOu5AOfuzl+tQSUUOi8o6p4dfnzVIH38ndo=;
 b=C7KfyUWDlS8qzVnHJ5SVZZUbTtQ190U1nAionoDXFRWOmeETI0G+eCkdh2UvdyYz2F
 Rgg8Uw5OydOLE+xohUKZFKJyeOaEin8mbKyrMBW5jGKAyNRrvCDrQ08GWiJSlPGpCGZV
 YYzlijcdt/0YEX/Ls41sxI7w3SmM2XQSRgQ/sSkcrSeEYN+km0MHhGe3wVnVthbH8yDf
 ZuH0Spg4M/Bem8Rax/f7hF+8dWZjo2UNYySnywqfZcIcqpvzATOdYAQfOBfUv6Aw41uG
 GIWvqqfoGtRs0aCgAZPY50KAlE+fzZmYGpliz505aKoZ6jfeMabu5ClW7QPEBUuWfH0s
 VntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782833855; x=1783438655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qTY9Z+25lOu5AOfuzl+tQSUUOi8o6p4dfnzVIH38ndo=;
 b=QfU52rby23/skPsYMZlfGT1gS9us1mTLAx5TPx4AOQUk+8YON1JNcXngQoR/xWBAxU
 84wDuetaN8hUh9OEPSXWgTZpvv4s+Y4wzgTJ3DQywRCpESWVk8LHydOj03Gzr7Hf6sVn
 3K6nBwjRbhj5qyTF4zke1x6FD88I6fKb6XM6Hi+dNzdz3JqRy7ZiDN59qkBzK5GU+RS7
 0ofYuQ1j+onFLKMI27JFJRuSfxKTdKsROhHaKwQ+wTsfothIp40UqaX9woPv880vNB6G
 0/cS3TL3uxwv+jY0yZwzoyIlrOZstcTsvJlIAST+3vfDgHbn/xEMEHRRPJSXD8OQ6h58
 Xfbg==
X-Gm-Message-State: AOJu0YysV4q0y0E0BbPbJz48AU7XFYDTLnNH6ZzlDIQ3SExq+NiLUbYk
 mqxiKyKctL25C4MYUdtDA53TPgP6lTtJhQKSzF5FfzXMTVtAwDDoo+7nNy1XIquOoNpxBGthDD+
 Pt2oh
X-Gm-Gg: AfdE7ckUGopA+uwdSfVfIsiXvwPTWCnQJpKYcS/efl/xFCL6hAvGWZeLAo3RURv0+Nk
 BFj0SVxsmEfdxb8GyqBLhJYgie7gSX71buio53ZnHUdrof+4Z43x0avml/jSbFbmm1BHR5C0RCw
 tjY0YL65jGN3extyzcSMfw9Iec+MSeKHqL/xtoFSnpxWHXAH+2EYZMz+e5AxOA4DPGEsmbYruj7
 9gHMze+6S6h1cwjSWJCKjwSrETDZ+MA8BZuIOk//KtV7jAzbZZG9qxwT+IkAddYHPV47yfGx9n5
 R0A4lFYW8KGvj1M1e1ZUVM2Ypd9a90KXjbbfX83knBkOGxt8kW1jOYC8XJEyBTu/tT7WqUmOLxV
 XY+PA8elpkK8X3lywZVszkxqY1gkucXobwc0fWP88KE8hWF4eGH2+e7ljwALI5bf9Lei0AHFR00
 al3bbR61vHlGVBL5mPCh4d+1z1L+HGNINUDoO66rts5bVeUrzDEaI=
X-Received: by 2002:a05:7300:a144:b0:2d1:d434:cfe3 with SMTP id
 5a478bee46e88-30ee102373emr2691136eec.0.1782833854729; 
 Tue, 30 Jun 2026 08:37:34 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee2fc21casm9072139eec.10.2026.06.30.08.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 08:37:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 7/8] ip_frag: remove use of rte_memcpy
Date: Tue, 30 Jun 2026 08:36:19 -0700
Message-ID: <20260630153723.525167-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630153723.525167-1-stephen@networkplumber.org>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260630153723.525167-1-stephen@networkplumber.org>
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

Replace rte_memcpy with assignment or plain memcpy to
get more static checking.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ip_frag/rte_ipv6_fragmentation.c | 3 +--
 lib/ip_frag/rte_ipv6_reassembly.c    | 5 ++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/lib/ip_frag/rte_ipv6_fragmentation.c b/lib/ip_frag/rte_ipv6_fragmentation.c
index c81f2402e3..86dd2e65ce 100644
--- a/lib/ip_frag/rte_ipv6_fragmentation.c
+++ b/lib/ip_frag/rte_ipv6_fragmentation.c
@@ -6,7 +6,6 @@
 #include <errno.h>
 
 #include <eal_export.h>
-#include <rte_memcpy.h>
 
 #include "ip_frag_common.h"
 
@@ -24,7 +23,7 @@ __fill_ipv6hdr_frag(struct rte_ipv6_hdr *dst,
 {
 	struct rte_ipv6_fragment_ext *fh;
 
-	rte_memcpy(dst, src, sizeof(*dst));
+	*dst = *src;
 	dst->payload_len = rte_cpu_to_be_16(len);
 	dst->proto = IPPROTO_FRAGMENT;
 
diff --git a/lib/ip_frag/rte_ipv6_reassembly.c b/lib/ip_frag/rte_ipv6_reassembly.c
index 9aa2f2d08b..cae4266f97 100644
--- a/lib/ip_frag/rte_ipv6_reassembly.c
+++ b/lib/ip_frag/rte_ipv6_reassembly.c
@@ -5,7 +5,6 @@
 #include <stddef.h>
 
 #include <eal_export.h>
-#include <rte_memcpy.h>
 
 #include "ip_frag_common.h"
 
@@ -145,8 +144,8 @@ rte_ipv6_frag_reassemble_packet(struct rte_ip_frag_tbl *tbl,
 	int32_t ip_len;
 	int32_t trim;
 
-	rte_memcpy(&key.src_dst[0], &ip_hdr->src_addr, 16);
-	rte_memcpy(&key.src_dst[2], &ip_hdr->dst_addr, 16);
+	memcpy(&key.src_dst[0], &ip_hdr->src_addr, 16);
+	memcpy(&key.src_dst[2], &ip_hdr->dst_addr, 16);
 
 	key.id = frag_hdr->id;
 	key.key_len = IPV6_KEYLEN;
-- 
2.53.0

