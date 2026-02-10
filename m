Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC421EB270B
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 19:59:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0051B402B0;
	Tue, 10 Feb 2026 20:59:05 +0100 (CET)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 614BF400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 20:59:04 +0100 (CET)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2b7da62b487so4130683eec.1
 for <dev@dpdk.org>; Tue, 10 Feb 2026 11:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1770753543; x=1771358343; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=866BvrvO50gKYRHYAfuNmOp7Nhx8VxT+bVuKNJtnGhg=;
 b=jitI1JxElg61Ywxy10+I8IJ9naUg7BB13hSTbmHFJ2KGZV+GN/r/coQr9n0g+wWrdN
 hZ/K+AXTayFOrmHRAfIWkdB5udfa+jjHypOrKZmscE8ir/q+u4Hyo2es3rcwDKnI06+b
 cIRzMfGTPeRNX4ittYbvuSnXS9ibY2nVHelxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770753543; x=1771358343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=866BvrvO50gKYRHYAfuNmOp7Nhx8VxT+bVuKNJtnGhg=;
 b=MCX6Xm9myHLGP3gZX0g/ykYe+lDW9gnuSHQQcK9KOYfhQHDyoO+VpH9OeOIhxERCT7
 6MS7GnfWBKJ0FtJdIFVlN0Mp+zbfRKthVQpay5aI5EweKAO34STVPTdaXMKTS5cFtSbl
 XSf/V3aX15/uGmTlXeXlkxBRs2o+Co/ViSloWhGsniQPMiLtX7d63Wkn6P9SIjl150GM
 JqdYO7PCjqKOoKstwdqlhUA5UNQwrfktaA4TdBM5W3bPiNyofGBrpkAWexLzgPDT9n/n
 OYN7Mn11ANTcLocSySqKJ6fpmO7zHXg+CrjbGZbRp3itKATVDkuTDQf40yXwRbo1Yken
 rXeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq2RB3xa+68989UBqJD1EhhEKikPhHOSmGiWAfyLY/lqd0cUhbs5T9h7pXOk3JMrtnFSA=@dpdk.org
X-Gm-Message-State: AOJu0YylipOzsaNWxdT+t1CQLeBTf59AMSYf+Gi/Qu0upCLzId+mBiP6
 wOlaMK7PA/uJXtdwIs9Kcp+Ns8GWX/F+KXeYgJwz0u/wHNV8v85+m+vSpzcZgOGw/XrzZ0cKPFx
 f52PV
X-Gm-Gg: AZuq6aL0jxTCBqLH62ypkD0s3LCbvng6pLG7C0Udx4aXqn7iZMkEzCAgO8mSVFvDuLj
 qTfgcxKFLCJ0nT4fZuKo3ABmfuFGd9we8+mJo9xnREWap/uGGvwN3XU+oyBs+99aWxxCY3Okm0s
 rxkShV58bP1fu6K8sTUSIi37wLW65FpAYGt9iFUuMZ4J5z2mrmmrqnAcekisLa0x/jYKk2EmWDQ
 QgLpj+PlyK8Y1IXSJ9VwNO+oDJxO59gVZrZsfw15im4u7JcpaQaYM0IdOUGUtMATwiqfWfdOIyV
 63K8bQtfuAc18IoFz0ONY2h+3NasF9J/j96fzPHuYpojF+qm5NANwlx2Ti1oc1Rf2S+cRYEt0jm
 +nlkZI5RZVJEy3JrsFoneGYT1gxVHB/oD1/XipyrejWxAtD6B/MI3bkFGWhJlD5hPFk+YPUjq7/
 uP+55Y0AaCSFuNMQTFokpF5ZHrkJH06kNRr39RKHEJ/PRqEJMmjI4Jw6VctevWhVDLRFzdoWFHN
 mc=
X-Received: by 2002:a05:620a:29cc:b0:8c7:1595:7355 with SMTP id
 af79cd13be357-8caee678781mr2025086385a.33.1770746810286; 
 Tue, 10 Feb 2026 10:06:50 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8caf77f2868sm1079300385a.3.2026.02.10.10.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 10:06:49 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	probb@iol.unh.edu
Cc: dmarx@iol.unh.edu,
	dev@dpdk.org,
	Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2 1/5] dts: add find float method to text parser
Date: Tue, 10 Feb 2026 13:06:41 -0500
Message-ID: <20260210180645.65880-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260210180645.65880-1-abailey@iol.unh.edu>
References: <20260122214424.322422-1-abailey@iol.unh.edu>
 <20260210180645.65880-1-abailey@iol.unh.edu>
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

