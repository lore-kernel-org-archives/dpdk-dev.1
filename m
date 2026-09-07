Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0519C79F99
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 17:05:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E2E240BA3;
	Mon,  7 Sep 2026 19:05:40 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id D23B940BA0
 for <dev@dpdk.org>; Mon,  7 Sep 2026 19:05:39 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cc1cc97b84bso2821709a12.1
 for <dev@dpdk.org>; Mon, 07 Sep 2026 10:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788800739;
 x=1789405539; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n9ZM96ujVFH94gbeNkTaeaem4Dshm0O7O3+S5ZYestg=;
 b=JGFfql7eFyLXaL+HKpxsgqVPUvmS4W4OzvyuRgWeicmjm2fKoBl1JCLfOPhxsUD8Cc
 KgCz3IcQhpKR89bb3d/gFFgzjSi+3KgpmIFZYZiAPNaoZ0QGqwPyj3E+iZDAqQN4FIZq
 TF9oNMWUbiICuTzDYbjpqsy3skwWFkmqKygOhHATm3Dd2oVpjPbZG479yTqpzN4EMYlk
 kCOjPklq9be5jF5VqRPmn1VXjhFB/yhP7VckJzwIQCbmz5JQiESVLREyvshSYQBivZPU
 aj+KrXvddt4J1/NZRAWAbvkCVZSJ2K9mVsHBTJyyTI0PIQvcAhFZSkNQRLQ7IBTsJoOW
 73ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788800739; x=1789405539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=n9ZM96ujVFH94gbeNkTaeaem4Dshm0O7O3+S5ZYestg=;
 b=XNKdQSCHi1a0/autWMeA1M6GMHZsggCASyI2MJlW24G/QU6aCwyWsRR6fhPtlzHh80
 yseKUiy0LJj5rDuQBxuRnBrtoG0TJkPBemhclz+ZxoC8ESGI/1b6lXpAR/FPh325bd/9
 KDLTnVFjEKQt4DiXPzTyoTX2f2ycv1GbhmPoQwnWqMGWILZIgzgvj4qncUbeHwcaZEtn
 6yEtKgP5I19VjV06ock3l/mwov9uYPU/SXOXo35RakdTHK2l/5xkDsUj0KRSvXWipCNV
 LP3GIO+74DzA2/BQzyW/N0KVc/nGUMjNIqDQpDd0T7ucwLprTH8qFymfanGT/JdMk85c
 EdQA==
X-Gm-Message-State: AFuF++k7w7wveZsot4k++esG+E3TbkYHFITFgFiQMh/3HRO54YRVsZdB
 vwC+a9p1j/Bti4ewWpVs2jX8ftF3omjxZKaUoLuIX5usORiGbi5nTaELWgP6HOqpY9lZi2fwtmm
 mldlG
X-Gm-Gg: AYBFou15zfdUs3PsE495CVG3YnSmIPF6CTJzpevEgwoPOiY0MCrODw/OUkb8fxYqAgO
 11fSXN1kw7a+uDh3PsmuZbFAdQNWnKi5iE6jTsEv97mJr1771PEkpEBzdA0LdnwhxFxhhh1xCn8
 AyTTM/c2oX/w3n52aYnfrtt1ss1C1BKygtu+hvXUy19dEBI6oQT+/m8xiN6TWzIDSgq6wWTEzq2
 WuM2aQU35fOYS0XR3cX1nSuneiD+xMmZmX35IHXbUREU0VDPpGrwENoxsjx0moZyoYEdYPhYz8N
 Xq3Hzo2h/xXPx1g3XdZCa6rcF+onbRR6q1V5eu7v1BGrw4yp6qrW3aEQetTYi5bv2+QN9AN1nHL
 AWo+8JIWujGqxHhuELtynr+pAcELE3GwTDX2gSQvwjnl8rM7QmumH8tq0ZwGy0m0NjOkany36oj
 qZrBCkreycAKxRnYnq92CnDFrHynS8vXfoPuYJZxRCPvR8IcvtDSiolqzvLOtjZToBZOkidFftB
 VEZd7YUlwHpYTP/6jGlQ3PT8ak=
X-Received: by 2002:a17:90b:564c:b0:37f:e326:6557 with SMTP id
 98e67ed59e1d1-39b2612338dmr40275378a91.4.1788800738839; 
 Mon, 07 Sep 2026 10:05:38 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b26123c99sm21509536a91.11.2026.09.07.10.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 10:05:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>
Subject: [PATCH v2 09/13] examples/ipsecgw: do not print from signal handler
Date: Mon,  7 Sep 2026 10:03:27 -0700
Message-ID: <20260907170454.351647-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907170454.351647-1-stephen@networkplumber.org>
References: <20260906232716.496546-1-stephen@networkplumber.org>
 <20260907170454.351647-1-stephen@networkplumber.org>
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

The SIGINT handler calls printf which is not async-signal safe.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/ipsec-secgw/ipsec-secgw.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/examples/ipsec-secgw/ipsec-secgw.c b/examples/ipsec-secgw/ipsec-secgw.c
index eba7560c9b..4816bcdd82 100644
--- a/examples/ipsec-secgw/ipsec-secgw.c
+++ b/examples/ipsec-secgw/ipsec-secgw.c
@@ -2448,11 +2448,8 @@ create_default_ipsec_flow(uint16_t port_id, uint64_t rx_offloads)
 static void
 signal_handler(int signum)
 {
-	if (signum == SIGINT || signum == SIGTERM) {
-		printf("\n\nSignal %d received, preparing to exit...\n",
-				signum);
+	if (signum == SIGINT || signum == SIGTERM)
 		force_quit = true;
-	}
 }
 
 static void
-- 
2.53.0

