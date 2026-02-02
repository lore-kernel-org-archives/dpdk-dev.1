Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10827E7FDE0
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 22:18:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCD3640666;
	Mon,  2 Feb 2026 23:18:32 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 804F2402CC
 for <dev@dpdk.org>; Mon,  2 Feb 2026 23:18:31 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso1698675e9.1
 for <dev@dpdk.org>; Mon, 02 Feb 2026 14:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770070711;
 x=1770675511; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A3ZBToOg06xPErCrGjNJXmja277cLb1v8rE3cToKX1k=;
 b=rc6qZW8L8AXvasZwQP5BAgkPcj3igjyOn3vFggX/fPdoUcIsKP7HUZF8ol/Df6X5D1
 DptFHGvJhBDhUS/rV+WnvugiJ0vEZSeO2ZvVJ2uGI+LNcI3K4XLH52r3b7eRrW3k98Tj
 74+OsBOXpjFTNZDOi37C7kaMfPYbxUyI8N0cB8sWehWhvdsze4X+iQi4x9zSp5pVFlaO
 RUsznY3DyoFuk+dKs2DNTHwVGgrGr4AdBVZM/nKsX+bipRvtzPFojXRE/35npHnx7qNS
 8Aq7p6RlUVdFHZBAbsKwuVIlMiJUjoZqEdrHtG46zzlbzM9IOXKT5yzWQ/4yzPNitbzL
 C6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770070711; x=1770675511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A3ZBToOg06xPErCrGjNJXmja277cLb1v8rE3cToKX1k=;
 b=Y3RBn+t8XYHBYz74GIr3hSmp8JtyuYS7QpoPX7iFAGzDbAL4/dFZilL40WiyAY7eBK
 kpwaRLstxEJVUvbenxdHmuDmHJNSdCFnbbBnemT3V+ANpnrkWuTCCWfw9UJq/dMUSljo
 mYqIt6cRxJsNo/Q2SBG6iM4Os2eyoCV3CeSVIBM3kJp7id75/TV7cs4WFFN/c0YFjwzj
 Am2pIiQnw0qGjDWkP31YrVCOIANtTvJf71FzoWJq/flyK57N4vepB67kViXj7pbG3rTI
 xocpbDIJqLZ6NFGquTWvN6VWzm2hY865hFeSTKGDCsdl25D37+NzTBNGL98Nn1tFeH5R
 xSlg==
X-Gm-Message-State: AOJu0Yw8BwRbX88dVHzNY7FZhfatUVXb8/v9ZhzSaMWE/67E1O02oTsQ
 Mhb4gM3rtmr+cZk/XWpQzg5wUBT6a3rZSAlsHu4GOKugxz9ki1DCT0yy8A0qgDKiZLMkVinJurV
 12DRE
X-Gm-Gg: AZuq6aJdGd+HVExRNtLfd5k779m2b0F3jwEH9WUy36sKYN8XpKWH4VffMM3qfZH+rbl
 cVBUmpM0ODhglJNVZMwz2HTtJ6CNjQ96hxqRjc7fTJr8yum/nK06YAbY8m9thWynTC/bk7RxD++
 x/jDMca6TOsBFWIMvIuWtmjBP8KCWCxr5YRc3QssMdQt/jsW2EE3P4SMuRXMj3pJ6UOPx7iNJH0
 YpRXpiaNa9dnF9M3gnA4ZyB1MLrd2bHXJZE3A1NFCpAfHIcDFfASRmoGWCK4+DrqFUtCAdjupqo
 dZ6mLy/NhaHN9TyIHJtqCOW1TLMoKI836obs0JZ0aEvh5tTVCBDKgBxWecSNqAvq0U/030UVKH2
 IjHUtekPBiFy/OQ8/o8hSkGX8JIcqIg+w3CKo4YEND4rxsH4WxfuOkeYhraLr8oXIJ1/uuJHBa8
 MQevheExgFR0Cn1+/SebKL/pDFhv7h4m2MTbUulhEMKpOTn+7jWA==
X-Received: by 2002:a05:600c:620e:b0:481:a662:b3f3 with SMTP id
 5b1f17b1804b1-48305137d8cmr14596475e9.7.1770070711149; 
 Mon, 02 Feb 2026 14:18:31 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee04csm47109336f8f.12.2026.02.02.14.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 14:18:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Tetsuya Mukawa <mtetsuyah@gmail.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v11 3/7] net/null: validate the numeric devargs
Date: Mon,  2 Feb 2026 14:16:48 -0800
Message-ID: <20260202221820.204680-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202221820.204680-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260202221820.204680-1-stephen@networkplumber.org>
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

