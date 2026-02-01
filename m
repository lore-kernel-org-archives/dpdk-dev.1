Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2795FE65296
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Feb 2026 17:20:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C6B440650;
	Sun,  1 Feb 2026 18:20:03 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 085B9402F1
 for <dev@dpdk.org>; Sun,  1 Feb 2026 18:19:50 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so30862675e9.0
 for <dev@dpdk.org>; Sun, 01 Feb 2026 09:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769966390;
 x=1770571190; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A3ZBToOg06xPErCrGjNJXmja277cLb1v8rE3cToKX1k=;
 b=mzHIx6fACWmRVO771yB2cs41G/HePQUin8DWERiFkKcXtIGaatdI/hN7WwvbSH+j7/
 li8aWusPp5dAMCEekXFryiR9gL9rONk+zwpzqCCbp6IQdBRnZm9CGJqgFQKJ/RBUIDtm
 tdPYPpGyeHcw2CxNxUYmMegsVCE0hKeYqUztVm4PFdt2OpcHPN7ajtLZBVgyZJjqjmik
 P5DAqSVBLIx74AantUkG61XxKQXFxVv43XzBsptNDTbwm8GxGrek5bLEtOEAkhL60vIB
 UNHtwGoChn/WG+NGWDX7yV8Tv6gFw2FQw+8UIBjW+fcla7uGZQjc11CApwbjzbHJjXwY
 wAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769966390; x=1770571190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A3ZBToOg06xPErCrGjNJXmja277cLb1v8rE3cToKX1k=;
 b=X6aIrhQ0FJKauI2MhyNo8FUYaOaXEiLMVsMSApr8BLjLAathpgHy8KakHmlMb7B3+H
 GwR/Yv2JnYad6maivyOVQSsvH9OQqytj0QMdqOGlM0ALe6zLo86Ta42hfnFeXVxGD1uZ
 gXSqw05Au/m9fV44M77oiaZmwOw2uKXTNztF9AQSnwNpu6HeddP4Jt7GY6Ml8gSjvVmM
 e0gtpapXcw3AqrBUalzz21Gj8uNOcNXw2J5UsQWZLL0Z9myd+uyJjK7HYVFeBMrMUk2F
 rm+qWlgxO6IM4D303hqGIOcBY3fM7lsxvsT4DzTzbWJGc/QJi7NkKO7I7sNh4ibmDgWh
 6New==
X-Gm-Message-State: AOJu0YxLsBdXNG1TPJs+snaNTSBEdSZgXT9xPP64Ksm9IuHlf0NmTUJ/
 QVcZa6JXHXmaSuH5shWWwyha+eZxQtTEuplltABmV4WhoXQGenaiWDQHWOMbFGIqoeKe071YqGF
 GNlB0
X-Gm-Gg: AZuq6aIawBN4Cm+nv06bhwtx7CFXAodKNcC1/a/B9ykpPgRvBtNAGk4mc+QbWJwP8vp
 /RTXrBXnabtrStMGUrl73vFb2b1fxS9vh09fn5aPte4hU8Ilwz7PINkE644wb2t2UZqElXSlaJ/
 r234PZL0CPFh92x3gvMOKeL3zlLw5QBLGRHpmAh0S4RUykaOEiQ4xpwkKglgoUJfPjXvSrNbWJR
 5qH5px0h+/wZPzMpHQMXN4sNaXVAk8HOtMu9c1aFKh9295Qbjghd3IE2y1kMGXYTaKTwU5uKruK
 ffv3pnzadaNnObWy6Upkf6WWs/sEhXfpt9xriCh1Kpy39K+4icIhukmgw6/c5JFWPBztBwes5Ae
 QJL1OK8ltSHLR4+X10CfY3kZqP2X4PLCl3CNn1bUbzryGv+7zqIRWYFZwY9ylHToTiH8p6uVgPs
 uF76JYriZAwixNW3t5Oa+RMRsQVfOXruIPamS45Pn8rOju+tdjNQ==
X-Received: by 2002:a05:600c:4507:b0:480:39ad:3b7c with SMTP id
 5b1f17b1804b1-482db45e244mr117084725e9.16.1769966390024; 
 Sun, 01 Feb 2026 09:19:50 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cdd79c7sm346810765e9.2.2026.02.01.09.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 09:19:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Tetsuya Mukawa <mtetsuyah@gmail.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v10 3/6] net/null: validate the numeric devargs
Date: Sun,  1 Feb 2026 09:17:34 -0800
Message-ID: <20260201171938.89492-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260201171938.89492-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260201171938.89492-1-stephen@networkplumber.org>
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
index f2ffdc2b2b..0b6c9577cd 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -603,56 +603,49 @@ eth_dev_null_create(struct rte_vdev_device *dev, struct pmd_options *args)
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

