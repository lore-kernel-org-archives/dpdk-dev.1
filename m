Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F483D6CFA7
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 21:44:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F238140676;
	Thu, 22 Jan 2026 22:44:31 +0100 (CET)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 26814400D5
 for <dev@dpdk.org>; Thu, 22 Jan 2026 22:44:31 +0100 (CET)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-8c5349ba802so151080885a.1
 for <dev@dpdk.org>; Thu, 22 Jan 2026 13:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769118270; x=1769723070; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=866BvrvO50gKYRHYAfuNmOp7Nhx8VxT+bVuKNJtnGhg=;
 b=KY9BHChGqANJfLmlWhXwu8Wr9Bi9KNxNhO966fGVpHd6pGJEdrrQ7tGb5LUOkr1Q3p
 nrt+k7A2AX/KFl17p47mY2maX2R/WQoNDsQNbNWBXoO4BnRmYttPFUs0HjP9Ue0qeMOH
 EZMwveAfffqoYF74tuK7zib6+oCZBb/qDqvb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769118270; x=1769723070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=866BvrvO50gKYRHYAfuNmOp7Nhx8VxT+bVuKNJtnGhg=;
 b=cB3jUrKlmrLddM25E8LQge0X2YiTDOfCMPDiUpe3CXKYsDTp+xZWLO0gWeHpl5Kgn3
 NSzOI3f8aZ7NRIOKys99fyxqiMJ7JW2p+WLnCHD5EzX4L4K80y7DhZw7CWAgtWo13P0/
 5Wgwfn+R0XobZChf7RybRf/S0KMxKc2d/D74Ck1tJF6mHswy8OgZMPei2RWGYJZ9jsn1
 Fv/O3Ka8WQr9FD0KTydbxNZoso5PJxk2dJwM03wFZQyQzxImQQR0zSyDKft2odUpf+mx
 xApr2rjKxmZ2pSDuMLqVM6ld9+8nuI6CK4WfzSiGDSoa3fguIvg9EDXg26rp7826inFb
 h7VA==
X-Gm-Message-State: AOJu0YxQcAxGNWXQ2CfgrAmJR5Zd6RomQ6q0FTFWo2Af4TXOXy0IkuZM
 UvJMFZvbZyYGOFMJe73xGnQUNZWXRkQL9++yPTnpOPSZvk5cgYHNlAwyvU8LdrYlNtI=
X-Gm-Gg: AZuq6aIv8CRLIOYoAyssiAAhkVyV48+83g/NkyEYPJRbsL2Kc74Pajz7AOXL5VPF9Pj
 CbzAeY3TZaBM3BvyeBNGzX8iL5iS8PoiKn3Ucdw1tneSZURIdvMvr8nqO80pGJyzHKA3dDG5zux
 1yn7T4B9+K43+cNSMfepYNEIxodGljTuAe1SxG1WyXUC1m2cAs1DtiOA9XYaT5E9oa651kZ4ctF
 1AVw6PJfW0MUBBIWcWW1fQqddXy4Gb9dyQQP994QPbAkKj9qldgWYkjzIUvPP6StUGNg57RP3zA
 IvvzSixtujlH9SeK5YgsVgYoNzzfVHCmd+lcNqM1SCOZQfdrv6bWdkGYzcunImueDF1QcKe1bkm
 2XZW5vl2LagDvogD3jpM8/5/B6zQml6p6at+HPSY9arJu90DTmi4M+eZtAq1kKB2p9ZoVJA8G5N
 i8mXBbuQgmK48nqKsQD2phVWXLamANSPu9a3pQpXObG7/TUKjRDvnb
X-Received: by 2002:a05:620a:28cb:b0:8c6:a034:9224 with SMTP id
 af79cd13be357-8c6e2e22820mr125721885a.47.1769118270395; 
 Thu, 22 Jan 2026 13:44:30 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6e3870c48sm28720785a.51.2026.01.22.13.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 13:44:29 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	probb@iol.unh.edu,
	dmarx@iol.unh.edu
Cc: dev@dpdk.org,
	gakhil@marvell.com,
	Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1 1/5] dts: add find float method to text parser
Date: Thu, 22 Jan 2026 16:44:20 -0500
Message-ID: <20260122214424.322422-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260122214424.322422-1-abailey@iol.unh.edu>
References: <20260122214424.322422-1-abailey@iol.unh.edu>
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

