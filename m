Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59849EF99D1
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 19:36:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B33B40651;
	Fri, 13 Feb 2026 20:36:02 +0100 (CET)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id CEA11402B2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 20:35:59 +0100 (CET)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-8c70ab3b5fcso189913085a.2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1771011359; x=1771616159; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=866BvrvO50gKYRHYAfuNmOp7Nhx8VxT+bVuKNJtnGhg=;
 b=WIdXg34LlsgKONf0Sl7AN3/lPyiJIS8YJveR2QHr9uVXCX9UImJIArWZwvytQZKLwI
 U2R7gk1odTTXavldmEhu01JTj6hNbjt7KiZVMlLxOg5681EFe/J5mEvVpjEJG9rVN1Hb
 8iU59GSWaQqUTEqtcj0bXkvsjZCrYow8ySZbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771011359; x=1771616159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=866BvrvO50gKYRHYAfuNmOp7Nhx8VxT+bVuKNJtnGhg=;
 b=m655e6/LhrIluDFypvCxSleHgbqz47TtM8nHWP1E8zi+Li0gvZXj23cTGybJV3j6GO
 kaRlpbXSTkV8sRrZX4EE8ZwUFP1fntp6/c+5bIxJuZmMCaK6PNeC5HWLKpQd08I9Q3C8
 oIoZE31kEDfwJJ8mXbp+UNdNTtba0KaXekwUzomfWVevj1Vz/MTrHFWJtlE4u5sE8W8J
 +d2mpEzHj3qPdK6Dl+VkzbQkDsFjD00+ICUBTn2uVcC2+fpSgSWs3Xj8fXFZTqy2MFHB
 Gk+przx2Y4fU6BH+Mxu7uZrCMYOGXKMbwmQbcPBXy1x+HC4hlkUSiVr8dWGdWICUcXsj
 1TnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ7OdLstt17oPtAL2OVjHpfUBJ8rlhhK0051M2qPbJjbZKDtsUZejf/0zeu/rgekBWK/Q=@dpdk.org
X-Gm-Message-State: AOJu0Ywhz5BPdhmQqztd/HUTtOlZqaoWz/xnGSnZx2J0k8G6sUx2MDsc
 8+wa3NxbxK5NnTRzQRDh6Rqa7Nte8NFx8kxv1t+W57AIlL2fWh0bSoUU9HILlw/LtJ4=
X-Gm-Gg: AZuq6aJgWTogqMWGOr6xrDZOQwFyvyJqp0ReGDms0xPfBsv98O/UlC47+RruVcBTxfG
 o5tX40zEGqPhKEyLm+OcbzTkaxhG1UVo4z2I7AUihuHtdKcO20mTEuA0PZbsJ9M/A4vN/sIuyh6
 u0latn5FDWMZRh4ek5RdaBdlAXATDNgPP6BUg5a5bxi0JpgNCcqyaREx1AaoFC61YAP6VxsIQWo
 7H2Rz5ewZft3J9SVxsXc9IIKg84IEfqjk1FkvIVH1OBFzsDU503NlXhrAgQV/t+99RaM1UHI35S
 5nngKy6taeJEAOU5tww0NmRJbaeE5Xe8MFel/DgYf22s2xrjV6M5xbKiKC+g2bAOQ312rRD75WA
 0pgwIZDD7LWxE3s83H8cMpZi6FfvGMMtu/+j1AdW1uQbpYovL3l6iR/SHh8uGSC0LZo4/T5Oj6X
 KoV2kWkMPAkjJ25RbLpYCc44pyW9oG5alEVms1NDtkEQ4K9ll2KmH7FmTg9FjDB8e+
X-Received: by 2002:a05:620a:4053:b0:8c6:a8a6:e164 with SMTP id
 af79cd13be357-8cb4bff2a8amr83857685a.45.1771011359089; 
 Fri, 13 Feb 2026 11:35:59 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb45f13a61sm146726085a.7.2026.02.13.11.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 11:35:58 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	probb@iol.unh.edu
Cc: dmarx@iol.unh.edu,
	dev@dpdk.org,
	Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v3 1/5] dts: add find float method to text parser
Date: Fri, 13 Feb 2026 14:35:35 -0500
Message-ID: <20260213193539.103858-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260213193539.103858-1-abailey@iol.unh.edu>
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260213193539.103858-1-abailey@iol.unh.edu>
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

