Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DD6C9830C
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:17:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCD2642D7A;
	Sun, 18 Jan 2026 20:14:31 +0100 (CET)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45]) by mails.dpdk.org (Postfix) with ESMTP id 758FE42D78
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:29 +0100 (CET)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-b879d5c1526so447604166b.1
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763669;
 x=1769368469; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0qEe646x3UFOUjfeMQXbggw/6BDU16viVpohFAw3OtQ=;
 b=iv/S/386lFcoF5q6hk6tbUycOq6bwji3VtfaS7CH3i8TUJj066GZMddD9hhDzHWLSn
 Zd6skFV3FZuwq9epkUgZPi7uOzgIskZgeWjMVyOo026feCWx+4amggiB8hIfakV9faVS
 zG8oTwNRZ/raWPzlHq9kT/kBcyZZ66G8Brup0LzS2KP1+JRmRCrgDuarTpkTU1TO+tUq
 z3V7SaYnYivolmaozLTbkMMsXpHi/+ZQDiUXAKUxeL+pH/Qq1nEZwceMETdEYbgp6+m9
 iUWrGWRrzxuYzTWt25wtkslPuLuKhltnnhHttKiZkbmA8DNd1uJHvZMN0dBhRY4SdLxG
 MJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763669; x=1769368469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0qEe646x3UFOUjfeMQXbggw/6BDU16viVpohFAw3OtQ=;
 b=vBXqOQ3WmGU+T/g3DKVXTlpzOPax5Ky/c57ie7R6zhsah2Toj7V6nPDUDZsCOa8WQe
 41DZgW1WKDxsQSsFyzj8hTgu1/i9R5/xRCjF+jOME6q8efb1jOdC1CoqEfKw8X7Fs5bi
 JXHKh+ASk+qvixLm+VTtPuHFl17KvgJCEckNh9oe0wCceNVeWVMe3+7Zk4RRTj5lTAcD
 2jPdR68eqL4w2+ZEDoO6sCc9ejibE9T3JpHFWnM2gvs7TuIfJvfYc5DkMvrNBF1xeNF6
 NbfTLWxdYmaVOn5EFJ3oUchV0Se40HX6S9LwrGka9xQXVWL2EyHccoHKu+LQPTB7a8O9
 0s6Q==
X-Gm-Message-State: AOJu0YzOAcSgm3yFrYtC+pJ3FT+YaGC5cl/FmN6kb9tnx7xYNQ6Tjriy
 fEGvNYh2ayp4khBcH0QNMPjppqoyXcFUrxNShmevJaQEQ7CYeR9w3CocKmQCzFwwbUimpdbHh5p
 eX1uP
X-Gm-Gg: AY/fxX6IZalpzq9IfavWAdh6dKsdqQegYmbhgRhSGy6VTWBUH2GlUWOJUaOTsWCdN9O
 efAO/TD3xNRsqKAkhRJh63U8vleEGXfFcvO2PAhzKu60FkcLa6MLkMrBUd3cl1mCzRqtN9amSi6
 AwbpVzVgZou5IC1ZHNOe+3nqcleiYghglRRk3ELo2Zww+X2m+vDqUsWXIkcDioHjuIWLG0FeKHb
 Jym7NPDm0jZ0bbtNqIcfkdBRsE+pji1iuMbxPhQVfgbKE6QAI2p7T0ZKL6VA349iN2w17HPM623
 WktYFjEVgZd/Cy7xLeXhAmO3KxKUkW+kKzj8Kkhj04HILDWt1TxGmJp7U06+KT7zEvwhVPOqWxM
 iYuWJ/qTGYz2TIzoosF9o/tag4Qq8jxNwNjnD4npRXIQuq9uqqMEItrtDsZujH0GsqQ4+n2ArOc
 nHnAzKRJmeDnQb2NdCA5aMayGSnES1mdaPUPu6LNMZ+V78JsvYxA==
X-Received: by 2002:a17:907:944c:b0:b87:324b:9ae1 with SMTP id
 a640c23a62f3a-b8796aee9ccmr803419666b.40.1768763669015; 
 Sun, 18 Jan 2026 11:14:29 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:28 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 39/54] doc: correct grammar in ACL library guide
Date: Sun, 18 Jan 2026 11:10:42 -0800
Message-ID: <20260118191323.241013-40-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct various grammar issues in the ACL library documentation:

- fix subject-verb agreement "fields has" to "fields have"
- fix awkward phrasing "to which...belongs to"
- fix typo "is a follows" to "is as follows" in two places
- fix typo "less then" to "less than" in code comment

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/packet_classif_access_ctrl.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/guides/prog_guide/packet_classif_access_ctrl.rst b/doc/guides/prog_guide/packet_classif_access_ctrl.rst
index 172f443f6e..00e2fdbef8 100644
--- a/doc/guides/prog_guide/packet_classif_access_ctrl.rst
+++ b/doc/guides/prog_guide/packet_classif_access_ctrl.rst
@@ -32,7 +32,7 @@ over which packet classification will be performed.
 Though there are few restrictions on the rule fields layout:
 
 *  First field in the rule definition has to be one byte long.
-*  All subsequent fields has to be grouped into sets of 4 consecutive bytes.
+*  All subsequent fields have to be grouped into sets of 4 consecutive bytes.
 
 This is done mainly for performance reasons - search function processes the first input byte as part of the flow setup and then the inner loop of the search function is unrolled to process four input bytes at a time.
 
@@ -69,7 +69,7 @@ To define each field inside an AC rule, the following structure is used:
 
 *   input_index
     As mentioned above, all input fields, except the very first one, must be in groups of 4 consecutive bytes.
-    The input index specifies to which input group that field belongs to.
+    The input index specifies which input group that field belongs to.
 
 *   offset
     The offset field defines the offset for the field.
@@ -140,7 +140,7 @@ The following array of field definitions can be used:
         },
     };
 
-A typical example of such an IPv4 5-tuple rule is a follows:
+A typical example of such an IPv4 5-tuple rule is as follows:
 
 ::
 
@@ -209,7 +209,7 @@ The following array of field definitions can be used:
         },
     };
 
-A typical example of such an IPv6 2-tuple rule is a follows:
+A typical example of such an IPv6 2-tuple rule is as follows:
 
 ::
 
@@ -346,7 +346,7 @@ For example:
      * populated with rules AC context and cfg filled properly.
      */
 
-     /* try to build AC context, with RT structures less then 8MB. */
+     /* try to build AC context, with RT structures less than 8MB. */
      cfg.max_size = 0x800000;
      ret = rte_acl_build(acx, &cfg);
 
-- 
2.51.0

