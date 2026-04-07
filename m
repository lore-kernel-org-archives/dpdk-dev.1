Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6D2FB5188
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 03:52:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D534B402D8;
	Tue,  7 Apr 2026 05:52:19 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id EB21D4029B
 for <dev@dpdk.org>; Tue,  7 Apr 2026 05:52:16 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-1271195d2a7so10002991c88.0
 for <dev@dpdk.org>; Mon, 06 Apr 2026 20:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775533936;
 x=1776138736; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PfZq5Lu7ldbPsYl80iqMOEYXbi/qvYO/hVXTN7/HEyo=;
 b=hyqbGU4BVm8jnDy5C0v1x9yzuYWMB+zIs3kK7uakieVp9EFuxrT6LilB5cir/x9mzJ
 UnmZAjlt7gD4ldrI6+2/thBC+XFRTYV1OR9WErV2N2BmaMi1po3NHqkCYrQIANH589yQ
 59TD2lXB6q2TMrReddijQUIr6nfPXtN8coN1yo33sqlVI9M3p08DImgoq+uz4IiVFaYm
 eDoeDugXn0J4ghZ4Q4DEMNuS4jJLIQ3DMjpjbdUItVyPz75vZJOdNnGItleX+Xl+h3tK
 gveXO8Cg0pXE6R/vf9HjGRmVM3LPBSHu1C/J3noHZiZ0Mf0GIY95OiDGldUU6p0VJ/++
 pMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775533936; x=1776138736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PfZq5Lu7ldbPsYl80iqMOEYXbi/qvYO/hVXTN7/HEyo=;
 b=nbMRRJYk8801lVv7ympy7Ut45tF2lcC29yRuzveOhdj+h2JvBk5elpAZEkFD8ZNC2G
 5bGac10A8X4j8zzltWSqfxdNfTN6X99lrpbUz7qp/6dB99+BseZLWugh2UBWgqZZCvgS
 IRkyJvdxbftB1chRpinpbJCvlotVcevr/Q2apU3tFKtftCIAsuAif6V+eG3mD5UGG9Yo
 j8GxR38INkbVX+WSLJNS7+r0btpoSJtNNUPNQjCUXe/M4zoRzARmZ8nUm9a87mxXwxxN
 1xOIgo3AfiIqNdBynzzhKNlLMdXy4JCJbmufHUrVmN9a7z8i5Qj1DYv0GmWXkMnz0zlr
 2qNA==
X-Gm-Message-State: AOJu0Yw/dHDFeSqaq8Dvb93VQR21JLu5KKopagZA+4QEwA6Nd4vk/z+A
 gqYk6f7ljT/eK0g2mBWa28daz+EDQGQsLm7T+bEIZBWb7St1OGBEcH74+m7ekrMNsdtGaLEE0oW
 WTMP8
X-Gm-Gg: AeBDietT1g+OKtmGvXzoRAsPkfT+EaVENcBQNw9XvWjUB+LSI/sr+mcQZWA3EGulYAY
 rhTqjufcTKpg7k0Rf+hhrwkNnAbF7sBzz09P98oK7XNkZc20d4VpKkG9B3AXnUK+WnaAQzzjW8D
 nbOZ5T1GGR9J6zAvwFzk9/4/2AGdjK4kJ9q16NKSgYyGHzJzOKj7mXzLbIlHnyIq++Wq1WrGOmS
 mieDs+Ekt2K+5/xYzHltCoKiu6EHXfmUy83nLzjcWrwBUyS0VOx34EVkdG4sK1MGMAVga2oyuSb
 5yydQxu2diOhHo840Y3NqecUOwtMIduGlUwhFbwCc4+lqkPqfmg2nZQM4UoDa74LPAEpu+gvdUz
 J9IMe/m8qJjJ85jqmTLfWdm5JiVHQBuvDoDkgBwWXwTr2K2f7DoztGYZ6YoeqVKD9EmQ2RfmK73
 ali9l92YeiRBu9l5n9a5DXY8NtlOaqLmxd
X-Received: by 2002:a05:7022:45a6:b0:128:dbbf:fd35 with SMTP id
 a92af1059eb24-12bfb76607fmr7272695c88.28.1775533935856; 
 Mon, 06 Apr 2026 20:52:15 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede545e8sm12716093c88.11.2026.04.06.20.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:52:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Volodymyr Fialko <vfialko@marvell.com>
Subject: [PATCH 04/23] examples/packet_ordering: fix shadow variable warning
Date: Mon,  6 Apr 2026 20:49:30 -0700
Message-ID: <20260407035209.650419-5-stephen@networkplumber.org>
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

Fix shadow variable warning by renaming the parameter from
'portmask' to 'mask' in parse_portmask() to avoid shadowing
the global variable.

../examples/packet_ordering/main.c:147:28: warning: declaration of
'portmask' shadows a global declaration [-Wshadow]

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/packet_ordering/main.c      | 6 +++---
 examples/packet_ordering/meson.build | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/examples/packet_ordering/main.c b/examples/packet_ordering/main.c
index 748fe0826a..0279faf081 100644
--- a/examples/packet_ordering/main.c
+++ b/examples/packet_ordering/main.c
@@ -144,14 +144,14 @@ print_usage(const char *prgname)
 }
 
 static int
-parse_portmask(const char *portmask)
+parse_portmask(const char *mask)
 {
 	unsigned long pm;
 	char *end = NULL;
 
 	/* parse hexadecimal string */
-	pm = strtoul(portmask, &end, 16);
-	if ((portmask[0] == '\0') || (end == NULL) || (*end != '\0'))
+	pm = strtoul(mask, &end, 16);
+	if ((mask[0] == '\0') || (end == NULL) || (*end != '\0'))
 		return 0;
 
 	return pm;
diff --git a/examples/packet_ordering/meson.build b/examples/packet_ordering/meson.build
index 092a5258ef..f8be053fb0 100644
--- a/examples/packet_ordering/meson.build
+++ b/examples/packet_ordering/meson.build
@@ -11,4 +11,3 @@ deps += 'reorder'
 sources = files(
         'main.c',
 )
-cflags += no_shadow_cflag
-- 
2.53.0

