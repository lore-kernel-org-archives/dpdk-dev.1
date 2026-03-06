Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93799FCB622
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 16:40:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6509E41611;
	Fri,  6 Mar 2026 17:40:34 +0100 (CET)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id D5FE340262
 for <dev@dpdk.org>; Fri,  6 Mar 2026 17:40:32 +0100 (CET)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8cb20bcff5aso921916485a.3
 for <dev@dpdk.org>; Fri, 06 Mar 2026 08:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772815232; x=1773420032; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=866BvrvO50gKYRHYAfuNmOp7Nhx8VxT+bVuKNJtnGhg=;
 b=LWBj8NLR9acp3oowdueTXb0l3eAo8unmULTQnrn8bO7boIwsG0ehNBvrUJgBYaH+MZ
 s0tfVoD/0xbq7eRgWh/RRbK8DA/nTGOSYS903jtkdQC4CiZqDaUljH68VMLufGv0GHtd
 1+FNb8+R9zCUH5PsQL1pmAUX9e2u4f1oNwGqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772815232; x=1773420032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=866BvrvO50gKYRHYAfuNmOp7Nhx8VxT+bVuKNJtnGhg=;
 b=sgVBK7pnckN9iHnJrwnxMfIoeXRb3xxDS8kDDZUZtBYmufLaMWDEHSUF7ywqe2bvTr
 tDT9PvJQQq4Wj0CULaDD3aeDU+kAlANqE+oiQiY28MLg9g4XBCwN7bPgCWZn0W9g99kt
 TFoqpkX4vS8c3vlwTbA+nK9bgK/A9QSiHewaQ7HrfRexPSeJO2iRPKfL7XdnHlC0tn4L
 gfYl5cHYrFilhPm9mlXKu5PbkQazI4Kt/8SK9mkAvgiSaYZefUY7H4el6Q8l9wapWcab
 xCixcoNZSwCwldSYE4bcKusd9POnz4r/4OAGiieJ8cb2QIH8TQPcEQCTPmPyB2ScEPSW
 zEAw==
X-Gm-Message-State: AOJu0YzD0bcvpYbVtfx5I/1KjtMRVAzPjdWw2/zW8dvUEXrZAvzORTh2
 yu+3skD/hOotZ0Qp++Uu50ayhYNtA0lWQFmYgVgsrvJ1ypBasMilGVj3CrFyBzjmIuM=
X-Gm-Gg: ATEYQzxMRSTboDisfW5EOoqtGijsNUE4DE8MPE8iDLNnG4x9xCXQl87YQyIKDwcQkFN
 HIIkVrIqBHms1zU21WRrq9hAr0ugV/tZ3ogPbSgkSNx3XVKaWOMMVypbBIhNZLk99nE2UK73Txq
 E3JI2yq6EKsCzSFBDwR0wlARkWBe0+QIOdvxj6+89LK7FA4p53Q5BchsdCNQk0iGBWfvtDS17qN
 MECP6vVjG2BrbgFujQJzKgH9KJoWh/7LCAPWjG1TbXsAcOPk/VFDOtJlQPKnl7EZxZl0ixNGSYz
 YHAFDv5KR8E+GyBoRoRdGtkUxv9nPh2YVLqfhtnnsFut50Q9wehc12b5x3xkwBFbnKtbW5fbZ7/
 q6rOagAiCLYRTVJduhX9b/Rht0OpEfPem1j/dBWkXimlbTwC6raIxptAjxef39UkJjP+H7AVRdn
 tnqyJFLMNyLzuFK9t5J6iFaSNz1Ra2fNoTB8T7QkSVZ7syG22azW4C7s20ximrGFHe
X-Received: by 2002:a05:620a:bd5:b0:8c7:c25:9e69 with SMTP id
 af79cd13be357-8cd6d4886edmr327119285a.66.1772815232096; 
 Fri, 06 Mar 2026 08:40:32 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f566fd5sm144608185a.43.2026.03.06.08.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 08:40:31 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: dev@dpdk.org, luca.vizzarro@arm.com, dmarx@iol.unh.edu, kai.ji@intel.com,
 dharmikjayesh.thakkar@arm.com, david.marchand@redhat.com,
 gakhil@marvell.com, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v5 1/5] dts: add find float method to text parser
Date: Fri,  6 Mar 2026 11:40:23 -0500
Message-ID: <20260306164027.171723-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306164027.171723-1-abailey@iol.unh.edu>
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260306164027.171723-1-abailey@iol.unh.edu>
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

