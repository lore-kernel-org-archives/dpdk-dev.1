Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18A4C79FB9
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 19:06:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB1CD4028B;
	Mon,  5 Jan 2026 20:06:53 +0100 (CET)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id AE8304026F
 for <dev@dpdk.org>; Mon,  5 Jan 2026 20:06:51 +0100 (CET)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-888310b91c5so17747646d6.1
 for <dev@dpdk.org>; Mon, 05 Jan 2026 11:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1767640011; x=1768244811; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=866BvrvO50gKYRHYAfuNmOp7Nhx8VxT+bVuKNJtnGhg=;
 b=icFEOMEO1PCnzFu3nW34ZUXRQo/MRQ5fRgZentN6reoqucg2qhJGG6stsiP5VkDdD2
 VNPXChSazEscl5HT6ABxHNF3U0GL4QiV2z8hxsnvCQzZ5ZPr8RmntjvVXYM1Lxm9RM2V
 8woER7zzUYu5UQdgfPzOSVKUbjNNtx0H5XH4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767640011; x=1768244811;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=866BvrvO50gKYRHYAfuNmOp7Nhx8VxT+bVuKNJtnGhg=;
 b=HAo0pqpkNaDzBoXEk++9Yi/RHHLjCZY86u3N81C3qQVkEVX7brIm5exnBR3QQcEm1w
 2BGwbnhBYDDHYBMNI7mcVAEzjIzIS2GMsVhhyuwFQHXPmFrof9VqL3d/J59V3pKqmHFc
 xK8v/f3/5n+cPE1Sd2Ss8zlmjKSGZ8Wid4FhR3KxwVytGMlZs5mZnPAwdWlYSEnvoHl6
 BQm0RKfg5y3ALfeHWt4k2NJxgQwP+saEuKJnClv6OdTuE7hThrFaczUkyICrrE0aSSIN
 vdFi5lDmqqJbvqNRfjltsAOL+ITqfEIp4qvkmkYRRf5T5bKFP1sl5yyb5NFGosSNh8kl
 pQiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcTQmbmqfRP2srBJyGnoTt3C5qfYfLVZLNf+61pp9YOyGePZbZdK8S4VDkAwY74pxtNtA=@dpdk.org
X-Gm-Message-State: AOJu0YwlEzBztFhIDoN8Wc+FKh+0YjAEkpXVkxJlOlRKr4PIO/owcpbk
 UaPqTPKz03fSkJIobGMv90VqfuMTNhHaF5Hg3ln6LwtoWpzidvKUvOkfC7tabDfcVuQ=
X-Gm-Gg: AY/fxX6BSdTB/hpQCRlqekxsUT06NdRoPH0VPqYdbIcEC/+gMw0vWLogrj8ftW6MElv
 gNrNT+CYSL1K54eWPyPmWrHmwzcljEnhMZSRnVOJkCjys5+u4fNhz7HsEmjlTOEN/Aq+e1HOZzJ
 nM5jXN+GScJ9v3IQ9z7eHK3bjmUPoftiJ3BrVhYJz1uJ95ihzl0SYC6vAoduGELoQbLGEAhYkPs
 s96la4XrZHHE/gQ7b6Twi3bHFo06sP/xVMq/pFvqCWO47tqFNUxevxOcWcaVccjcTE2O9t6KlQ1
 VuWDqxqsc8w2k1XNnDWiHxSWJJIG8qfbRYUKFQIz6cS4Ppb3/IHbENE5qbAWXfuCnsNU50HnsYT
 hlFIx4cYA8zjf+qVO+l6C7dd6VLcBuv52aighsMuE0s+EGzfFppRxJ75/COo9p3vdyjwkKK5bP+
 d6BX2mwqb/E+ATYnagv5YP1ZE=
X-Google-Smtp-Source: AGHT+IHFovDUY7ZTfmsYrK3UyaEbABdF7rp3SgyoZueRZGtTAp8o9E2tXKpS1b7W6QQNj+gJu+8s7Q==
X-Received: by 2002:a05:6214:2485:b0:888:4930:4c85 with SMTP id
 6a1803df08f44-89076a40685mr2947826d6.33.1767640010516; 
 Mon, 05 Jan 2026 11:06:50 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f4b9c9esm12426485a.18.2026.01.05.11.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 11:06:50 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: probb@iol.unh.edu, dmarx@iol.unh.edu, dev@dpdk.org,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [RFC PATCH 1/3] dts: add find float method to text parser
Date: Mon,  5 Jan 2026 14:06:45 -0500
Message-ID: <20260105190647.63244-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
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

Currently, there is no way to gather floats from text using the parser.
Adding a new method to find floats will allow testsuites to utilize
valuable float values that are output from applications.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/framework/parser.py | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/dts/framework/parser.py b/dts/framework/parser.py
index 4170cdb1dd..3075c36857 100644
--- a/dts/framework/parser.py
+++ b/dts/framework/parser.py
@@ -220,6 +220,34 @@ def find_int(
 
         return TextParser.wrap(TextParser.find(pattern), partial(int, base=int_base))
 
+    @staticmethod
+    def find_float(
+        pattern: str | re.Pattern[str],
+        flags: re.RegexFlag = re.RegexFlag(0),
+    ) -> ParserFn:
+        """Makes a parser function that converts the match of :meth:`~find` to float.
+
+        This function is compatible only with a pattern containing one capturing group.
+
+        Args:
+            pattern: The regular expression pattern.
+            flags: The regular expression flags. Ignored if the given pattern is already compiled.
+
+        Raises:
+            InternalError: If the pattern does not have exactly one capturing group.
+
+        Returns:
+            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing the
+                :meth:`~find` parser function wrapped by the float built-in.
+        """
+        if isinstance(pattern, str):
+            pattern = re.compile(pattern, flags)
+
+        if pattern.groups != 1:
+            raise InternalError("only one capturing group is allowed with this parser function")
+
+        return TextParser.wrap(TextParser.find(pattern), partial(float))
+
     """============ END PARSER FUNCTIONS ============"""
 
     @classmethod
-- 
2.50.1

