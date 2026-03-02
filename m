Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE620EB3624
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 18:55:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A68C40E0F;
	Mon,  2 Mar 2026 19:55:00 +0100 (CET)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id EB8D9400D7
 for <dev@dpdk.org>; Mon,  2 Mar 2026 19:54:58 +0100 (CET)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-89a000f5adeso16371036d6.3
 for <dev@dpdk.org>; Mon, 02 Mar 2026 10:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772477698; x=1773082498; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=866BvrvO50gKYRHYAfuNmOp7Nhx8VxT+bVuKNJtnGhg=;
 b=bOXCFwpr3kX/QfeRbJArfscnln+T8JSJSuJ1i5SOkHJmi2LrB8/PFRvcS2RLXihpNg
 HWo5fkc8bwN2GLwvI8GymBavS3/KJvkZjBfSBBOw1g4w2OvJyitGZhSx5uO5lazLEeug
 sJvTQW3n6BQdWvQzjJHFHyxlHbWNY17VK8jw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772477698; x=1773082498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=866BvrvO50gKYRHYAfuNmOp7Nhx8VxT+bVuKNJtnGhg=;
 b=vUVQXKCQOcnoU3xSW1zK71dzNkhOxwvCy9LPVZG5z5HHDY/6X5hTLNtZDuJOzi7okj
 WrpyjeLbq0Su4S8Tpwa50jeR1ccuz68MuQb3tGCJ/p4coedQnw5F43ylbC0eZZ1LZ0/o
 zu+75wtWDWY4is6hYRyzLeQjod0OnVc3R+jBPMaZJJFksE+F4+uSdiDZYbKl472TSsjZ
 09EP8Jycc+1QBbrpUVsxQ4IRQHabOTt80ZhmGJxVBtGgaQXWAydzIkQAGGextUd4e0kP
 8YBnsLIHajZ6XfZ7n/t28jDzNK+OGX633pW35ibxbf+3dcprwBe+SK9zHfRscKiyDDny
 skrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjxjZf4KD5P+w3lwVCzAy18Udg920ZF22riABh18WW6Z7uchTngkZBSnCcB37EU+853FA=@dpdk.org
X-Gm-Message-State: AOJu0YwvVNZU0pOt2AyolpIDvt1Pp3co7WfJmjEeTcXnwmDS26c3K+C9
 muUMaRlZ8qU2Q5XrpsOga2RlgglFG7xs+LUWpOo9Nj0J76P2LJyjEOHlhRUiGDj4QJ4=
X-Gm-Gg: ATEYQzziqOjaubAUgGnz+0+jf8qgo8+UqQPHUnAvxgKvrjQBxP/Oy3qgnZUZCGDch2l
 7NYOZqi2ioOcz9PS4BUSBaZ1DmWzvio9+vKwB3U2L0hzsDGtEBoSsNvQogVNCaGsYqLWrfd6qjS
 iCcyOeSiBNCBf8zIEVAKGuIuPNNVyOBAWzvszYjqq1iSxuyxO21SFEDeHDfocLoXnBUKaIAaJ/k
 ylHbn9TWdn8Aqp+3yO5JSXQks3qMHk5j7uPwmj5G+FqpXxeoTfQSrVgRwkokisvwS70QDlmANnx
 CpM8fR7BMAWaP5SLp9UiOuoh2WXxWa60h4k9GJ69LWoSFb01+WuCWBEppfBK7pqoIxVUtb8FdwB
 HJvwapOCXJrv1KORnmDncINuouawgV0CqcX4j9IZAeGnJx9PhrzC+XZAcSGsBSRBcZOs8ENlRX8
 dhSJ0+1z5/+TIDYS5j+FMHR3/0F/EJ6uQjPHCoFUWeR+qoVTIIx7vnHm2Y5t/nXxnE
X-Received: by 2002:a05:6214:e86:b0:897:2b23:3a7d with SMTP id
 6a1803df08f44-899d1d6c84amr202789426d6.2.1772477698235; 
 Mon, 02 Mar 2026 10:54:58 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899eed12615sm46719586d6.8.2026.03.02.10.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 10:54:57 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org, gakhil@marvell.com,
 kai.ji@intel.com, dharmikjayesh@arm.com, david.marchand@redhat.com,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v4 1/5] dts: add find float method to text parser
Date: Mon,  2 Mar 2026 13:54:34 -0500
Message-ID: <20260302185438.122584-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260302185438.122584-1-abailey@iol.unh.edu>
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260302185438.122584-1-abailey@iol.unh.edu>
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

