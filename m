Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A3CEB2705
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 19:35:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B04EC40DCD;
	Tue, 10 Feb 2026 20:35:15 +0100 (CET)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id 1C98C40B90
 for <dev@dpdk.org>; Tue, 10 Feb 2026 20:35:14 +0100 (CET)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-896f6d4b6c1so38659426d6.2
 for <dev@dpdk.org>; Tue, 10 Feb 2026 11:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1770752113; x=1771356913; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=866BvrvO50gKYRHYAfuNmOp7Nhx8VxT+bVuKNJtnGhg=;
 b=TPn+XMsrMXOCh7H1ekvoPCyYeoihQWOjF6pVCpqA4gw2MAmMVWtwPp7rDn8kONMELE
 VpLCSEixyIdOx55OpCR+Q/6yzg/5rsb/pAtP/AhdBmu9xL3pSW8xXZtjBgCzdNjy7115
 DFy06fEysN8tB07mW72xmu42BbBqfBwI9AmL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770752113; x=1771356913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=866BvrvO50gKYRHYAfuNmOp7Nhx8VxT+bVuKNJtnGhg=;
 b=QrY8ONKPs+m/jn05nESBZ9LYNblwWWMQ2SbKPOV8Q464p3pA6jhYxnlayp3hIwzv5i
 34UhxntgXr5HXScZayxOc1v5lUPpXuoNjJS0MRwtrinVCAbLpe46VYaQcf0QfrT0hEky
 hADq3mwiyuBRVona4Lw8GC7vP/Zd+NJvmaV+fcyKCrzh4u9RnrtwkafUinZcO2JLixKE
 FlMXpAyT6WgKVLCd2EjTphFHHhhCDdPnwREBaqwgZnEN3Dk8n8GWosCdQ811v3zcgpGr
 Rn/l6sQ41JW61jelsGdOu5dbu+3YLWsXyjSuhzFV3TOprs+87yrG0nxWHUK0SlUp5Rv/
 Tnbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7/XpCcLPw5nzLPZG8v9+UXh4JCrGh+bk6BsHUApuO5qDnaPPSAy2O/fyVASbGgKU32RA=@dpdk.org
X-Gm-Message-State: AOJu0Ywgu3x1MJUdkum2I9BDcoJNLjKYMl9yuvItRfaylet/JJcSjlwb
 ZqRYl9Lv/jhEH/GZtmHhcKwlW0BlnmsRow3bszuQHa8kOKn9DtjWlrab1rmhOR/iyhemvF/gIMN
 5ehrJ
X-Gm-Gg: AZuq6aJDtntE7UjgbBFfDHA5tLOPn/wqSKXjOi8oS5BMf7tmZ8CsSGOoaowjZasAzlx
 d4Vlpli0h++88mIY0ES//HKl2J6arXFvVlXDn+an3BetQuI5P7oKvba94saGYXYuXPLtHDekKxa
 fT4usk2ugStZn4SYyp9WfiMM6EZeJ+iG7vj5Y3gjMflwkVM7zMrt1A/l4A1IBXWwqSPsO27puE1
 NdU0kRHcGnHfqXgrB4/XBdZEp2lBBBvm96OMW+I+fU2Wyue8hjWAWjb460sv7DvJuN4JtTq4sXz
 uFxr00D26TbpaXooy4V60KpSd1CuPD/uHHadnqH2ynIDtLBtbsVLi2a5nzP0v2Xf1ZYllAxiJp5
 6Ur5JZJqyqfh8dPOBn+9f/y1/fK/BuTM0xfaCe6HE5NuxuyRLAZmbx2tZPCHiqutvCqKehvo23u
 s4T/UOzQ6kO6PXliYK8Ua6fv/sdkBCG5XkmmdEEqtssV2PDop5F4XTW3BmqgILGQy3
X-Received: by 2002:ad4:5aa7:0:b0:896:f42f:bf27 with SMTP id
 6a1803df08f44-8970e58c60emr51132686d6.58.1770752113342; 
 Tue, 10 Feb 2026 11:35:13 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953bf3b6b2sm107455356d6.6.2026.02.10.11.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 11:35:12 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	probb@iol.unh.edu,
	dev@dpdk.org
Cc: dmarx@iol.unh.edu,
	Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2 1/5] dts: add find float method to text parser
Date: Tue, 10 Feb 2026 14:34:44 -0500
Message-ID: <20260210193448.69423-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260210193448.69423-1-abailey@iol.unh.edu>
References: <20260210193448.69423-1-abailey@iol.unh.edu>
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

