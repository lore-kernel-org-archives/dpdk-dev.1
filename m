Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7365D73E83
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 20:26:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6B884060F;
	Thu, 29 Jan 2026 21:26:48 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id DF4854042C
 for <dev@dpdk.org>; Thu, 29 Jan 2026 21:26:45 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4806e0f6b69so10323005e9.3
 for <dev@dpdk.org>; Thu, 29 Jan 2026 12:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769718405;
 x=1770323205; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ipLL/H93R4+vLJ5oRMolPl81x8WLMtMw3YpVS9Lzda0=;
 b=nFPrHm1JCHWzevEjCYRVrWwfsua91WE4VEfNeHkTyXi8GwypSW0YjoReGkSq1BpuDg
 loclWCrqaCCxk5kvsoiUcL7BTHIiq8I9uX2MV2Xefp7IiQBy596NIK76IWcrYXYZ2nTK
 UDqYpsnZepxw4iToo/bo9Wc+1mq0I57AnSkgXeEU0fPxX+/4hcSIo+kSEmaDmXxgcHpR
 bvkkvMb0NCb2dwWhwJgck1LfKwumKdo0ABtbZ1HhJSTBEXSnT7Jh2jNSQZ0rCQWjgaJL
 DWQhjnOu8g9bVw/jKHXaf0ukI6Yf58yYwXiS43pacOIev5sLK0GQsllrrxGcucvFWQG7
 8tnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769718405; x=1770323205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ipLL/H93R4+vLJ5oRMolPl81x8WLMtMw3YpVS9Lzda0=;
 b=bWQ1XoJWi4Shn/nuG+q0FDgWVE1VKA5imIcTDFzYXa6fbnRYxfnWklYcKROMwPgkCc
 0SapcPpDj69cyH4k0Dkp45GKq3Y+89t5cdByNA0wLaeDLOF8/o+uV0hjqRsHjX+m6oi7
 A7F+QalPDMi4uh4xIvbGtHuowCpEJ05V3Idey/cnflDf1ecD6wwAKnkeMVVTG+fSHzbs
 xQrRxo6+jHUwW9vZL2gF2UOORbwYEdEFHkA0MU1zEuOpUNbVm72aDbqhs2dKLOUuM5ue
 6WyQrVBKJXTwKAU8wvgJ0MoL/beZ+ZOMQpxYF3YE1+3N4/GiZH35uI23W2hHOZPXSKX1
 tyjw==
X-Gm-Message-State: AOJu0YxF5tltdDNq4n1vt7Xvgzwi3+xXUhe17Q2SsZmDRkN7+KZzYLof
 Z20nE2O1i/CoKMC6KqMAr34BP7uC4DD0No2wUzXHQ8zNoPDh4CT+0an9YJjAidQqGvTGZ5Z8ohl
 i6zUJ
X-Gm-Gg: AZuq6aLpsDAUyAj8Rn/ZVhnMhqoqU0Mivdt6YyLBe94GAUukNeIRCyUw+cN65ua8rXO
 kas6k6DhR13Cimam46Nsf8btGDvZ7TQFffNBpexhFGdGGOcO9m1sGKJH8dJJ2hRaotphchqHsf1
 rT08yiZVOgXE3XShzoCKP2mAhyWQEhoxdPvEid0ZndymWL2FjVYzZ60ZmN0jLdQAt4mmTIpeTB2
 CsURGmSqaflQjoeSUTr/NbdvP+emzHAV083gZVpJznlmmQ+n8w/DXokHtfO/uopKGkcpfc8QxWE
 S3t7Nh1RDdACNVkxv8O0+4jmeJtxJWtVlWrBjgdGN83+Bzj6Ugij9IMcDjv9MLgI2qQn/YUQ0PU
 FGa/TpmnoPxsOoYfjHO8vD2HoX3PAih5zU5SqKczRHwF9xt+E3kZlk6T4elazNQ5eu5/Rj1bvz0
 hax6soxTpjuIv6JkBBRDRrqYgp1g3htoITYdQoyo9IB07t/FswsA==
X-Received: by 2002:a05:600c:3f0a:b0:477:a21c:2066 with SMTP id
 5b1f17b1804b1-482db447c57mr4058435e9.5.1769718405463; 
 Thu, 29 Jan 2026 12:26:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e2ba7asm4819435e9.20.2026.01.29.12.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 12:26:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Tetsuya Mukawa <mtetsuyah@gmail.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v9 2/5] net/null: validate the numeric devargs
Date: Thu, 29 Jan 2026 12:25:28 -0800
Message-ID: <20260129202635.173530-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129202635.173530-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260129202635.173530-1-stephen@networkplumber.org>
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

The driver was not correctly validating the arguments for packet_size,
packet_copy, and no_rx. The original parsing had several issues:
- Empty strings were not rejected
- Trailing non-numeric characters were silently ignored
- Large values could wrap around causing unexpected behavior

Add a common helper function get_unsigned_arg() that properly validates
numeric arguments by checking for empty input, ensuring the entire
string is consumed, and enforcing appropriate maximum values for each
parameter.

Fixes: 4df90194f2a2 ("net/null: prefer unsigned int")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/null/rte_eth_null.c | 59 +++++++++++++++------------------
 1 file changed, 26 insertions(+), 33 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index ba87c82a73..cd7a29bce9 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -602,56 +602,49 @@ eth_dev_null_create(struct rte_vdev_device *dev, struct pmd_options *args)
 	return 0;
 }
 
-static inline int
-get_packet_size_arg(const char *key __rte_unused,
-		const char *value, void *extra_args)
+static int
+get_unsigned_arg(const char *str, unsigned int *retval,
+		 unsigned int maxval)
 {
-	const char *a = value;
-	unsigned int *packet_size = extra_args;
+	char *endp = NULL;
+	unsigned long val;
 
-	if ((value == NULL) || (extra_args == NULL))
+	if (str == NULL || retval == NULL)
 		return -EINVAL;
 
-	*packet_size = (unsigned int)strtoul(a, NULL, 0);
-	if (*packet_size == UINT_MAX)
-		return -1;
+	if (*str == '\0')
+		return -EINVAL; /* empty string */
 
+	val = strtoul(str, &endp, 0);
+	if (*endp != '\0')
+		return -EINVAL; /* non-numeric character */
+
+	if (val > maxval)
+		return -ERANGE;
+
+	*retval = val;
 	return 0;
 }
 
-static inline int
-get_packet_copy_arg(const char *key __rte_unused,
+static int
+get_packet_size_arg(const char *key __rte_unused,
 		const char *value, void *extra_args)
 {
-	const char *a = value;
-	unsigned int *packet_copy = extra_args;
-
-	if ((value == NULL) || (extra_args == NULL))
-		return -EINVAL;
-
-	*packet_copy = (unsigned int)strtoul(a, NULL, 0);
-	if (*packet_copy == UINT_MAX)
-		return -1;
+	return get_unsigned_arg(value, extra_args, UINT16_MAX);
+}
 
-	return 0;
+static int
+get_packet_copy_arg(const char *key __rte_unused,
+		const char *value, void *extra_args)
+{
+	return get_unsigned_arg(value, extra_args, UINT32_MAX);
 }
 
 static int
 get_packet_no_rx_arg(const char *key __rte_unused,
 		const char *value, void *extra_args)
 {
-	const char *a = value;
-	unsigned int no_rx;
-
-	if (value == NULL || extra_args == NULL)
-		return -EINVAL;
-
-	no_rx = (unsigned int)strtoul(a, NULL, 0);
-	if (no_rx != 0 && no_rx != 1)
-		return -1;
-
-	*(unsigned int *)extra_args = no_rx;
-	return 0;
+	return get_unsigned_arg(value, extra_args, 1);
 }
 
 static int
-- 
2.51.0

