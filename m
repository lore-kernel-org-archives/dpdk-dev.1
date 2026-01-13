Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBD2D30CEE
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 23:01:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8B0440673;
	Wed, 14 Jan 2026 00:01:04 +0100 (CET)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id A2B794064A
 for <dev@dpdk.org>; Wed, 14 Jan 2026 00:01:03 +0100 (CET)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-430fbb6012bso6486817f8f.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 15:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768345263;
 x=1768950063; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MVDEitid3uBi21CPUIsj4OwBratlZVhWGA0kO20KOyU=;
 b=Q0NM2i2Da9zfbkK8p6LWI+XNkdDsumj09HxoxF7iqCFrrWKryzZY0evhYfPfDQSnPL
 rKuumh5KMAhWe+JedioI/oNp2erbAH7/66w++/Kn5veMre+vXdPF2nVCE5psNVLikERD
 kx35Z7S5//s5lIIOHkBPEgQfsFVREfkxY3wFNUZmCvlXPrmK6GyDLshPkJr6szLFdpAy
 Ui9BelI00oq6N5b8lKxWbldQbDEAzgRHn9/ExD4twS1RAniMm2WYCu4JjBD92BcrJKeL
 yZsX/OGP9KSnZYeTRSqVIUOwBmfq9aMMcUbL/ggBDGYaECJiVC4Pq8qDniLSdsY/ZTac
 A30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768345263; x=1768950063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MVDEitid3uBi21CPUIsj4OwBratlZVhWGA0kO20KOyU=;
 b=aJceVQxnIkdi387y59+hU7eycgTmFRTDHEsZOcpFUIeD3XVuar2XnySxmqeM/YiT2r
 1aepu4W4f1zYSidw4ARvS11ZOHx878TRlahKJQklRgT1OKZ/c/qcTSsqf+FYTToDd/Oy
 7x9Bce3vmGvbGIDbwLnBIG65ZdMwi9lBkNBz9xcvhjKZrNSjLbCA21ALjOxMVKnyOUZO
 1ec3RpN3lAbbDKmq0+FBpfg3pki7TEeyvH8TsljPmrMOIop7lXCL7BI7vcDUkPfUzlsW
 /wzCdjncJlCsxN8rgjIqFGyXXoBhg90bIsC81nsu//dA43I+hXewbadku66cteofa8Rz
 Hk0g==
X-Gm-Message-State: AOJu0Yy3koKHU/U0mMmhiqDHPhx+ctuLWM3djEmgHkiFmHXmoMMrZlbs
 C5dpLiBHtugUhuF0i08V+xFuHaGzqTBj/oG7YgLPx1LgimshyR/8mAuUPrgdOLrD4pqCcehxhe0
 wY+0w
X-Gm-Gg: AY/fxX7m8g2GYobmFvTqQQFpp+KMyhGbrhWARdLNn1yUVScxYkKCFabvujJnpTfvVv3
 Vqx0qA7L4axHQYkcBF/11tGQWzWL/eBs6jGjXeDeL1v89x5HROyXJFUhzsDurvhWK63xPiuhEC/
 3tirW1c2zO5ytlI1jAwESArc6YyYpYjrzNNX7PDTtoLxoaHVh5XtwDWwdB+E5baUiSKq7g7HMOl
 w53o7lC9D/hb3xrFxN4wqGOP9h85hrcdPWm2tj9EsfDHnKcHGhAHOXh+q04oKyytc1QKFKbCjVk
 42miw5+bf34znxuRu4hr3sk4avudnPifDh27xdgLxDaXXYQXufWWq99C5bCHyI4Q030sdhfTTCc
 5JO2DfU0WqyKWgvScX6eQYEr4l6tnp5vL0dSTPB7QBVq3J2jTN08B+0iKcX2QWzgyzqScS6IOO/
 DIlAw/nSjByCcuu/NqJLM196VvxnxahcL2gJeBJrtTiVEJLLPbgg==
X-Received: by 2002:a05:6000:2f85:b0:42f:9f4d:a4b2 with SMTP id
 ffacd0b85a97d-4342c501137mr512802f8f.19.1768345262818; 
 Tue, 13 Jan 2026 15:01:02 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df8besm44977200f8f.26.2026.01.13.15.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 15:01:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH v3 02/11] doc: correct grammar and typos in argparse library
 guide
Date: Tue, 13 Jan 2026 14:51:04 -0800
Message-ID: <20260113230052.54435-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113230052.54435-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260113230052.54435-1-stephen@networkplumber.org>
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

Changes:
- Add missing articles ("a user-friendly", "a long_name field")
- Fix awkward phrasing ("take with" -> "have")
- Correct verb forms ("automatic generate" -> "automatic generation of",
  "are parsing" -> "are parsed", "don't" -> "doesn't")
- Fix typo in field name (val_save -> val_saver)
- Fix stray backtick in code example

Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/argparse_lib.rst | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/doc/guides/prog_guide/argparse_lib.rst b/doc/guides/prog_guide/argparse_lib.rst
index 4a4214e00f..b0907cfc07 100644
--- a/doc/guides/prog_guide/argparse_lib.rst
+++ b/doc/guides/prog_guide/argparse_lib.rst
@@ -5,21 +5,21 @@ Argparse Library
 ================
 
 The argparse library provides argument parsing functionality,
-this library makes it easy to write user-friendly command-line program.
+this library makes it easy to write a user-friendly command-line program.
 
 Features and Capabilities
 -------------------------
 
-- Support parsing optional argument (which could take with no-value,
-  required-value and optional-value).
+- Support parsing optional argument (which could have no-value,
+  required-value or optional-value).
 
-- Support parsing positional argument (which must take with required-value).
+- Support parsing positional argument (which must have required-value).
 
 - Support getopt-style argument reordering for non-flag arguments as an alternative to positional arguments.
 
-- Support automatic generate usage information.
+- Support automatic generation of usage information.
 
-- Support issue errors when provide with invalid arguments.
+- Support issuing errors when provided with invalid arguments.
 
 - Support parsing argument by two ways:
 
@@ -126,15 +126,15 @@ the following two modes are supported (take above ``--ccc`` as an example):
 
 - The single mode: ``--ccc`` or ``-c``.
 
-- The kv mode: ``--ccc=123`` or ``-c=123`` or ``-c123```.
+- The kv mode: ``--ccc=123`` or ``-c=123`` or ``-c123``.
 
 For positional arguments which must take required-value,
-their values are parsing in the order defined.
+their values are parsed in the order defined.
 
 .. note::
 
    The compact mode is not supported.
-   Take above ``-a`` and ``-d`` as an example, don't support ``-ad`` input.
+   Take above ``-a`` and ``-d`` as an example, doesn't support ``-ad`` input.
 
 Parsing by autosave way
 ~~~~~~~~~~~~~~~~~~~~~~~
@@ -169,7 +169,7 @@ For arguments which are not flags (i.e. don't start with a hyphen '-'),
 there are two ways in which they can be handled by the library:
 
 #. Positional arguments: these are defined in the ``args`` array with a NULL ``short_name`` field,
-   and long_name field that does not start with a hyphen '-'.
+   and a ``long_name`` field that does not start with a hyphen '-'.
    They are parsed as required-value arguments.
 
 #. As ignored, or unhandled arguments: if the ``ignore_non_flag_args`` field in the ``rte_argparse`` object is set to true,
@@ -283,7 +283,7 @@ Parsing by callback way
 
 It could also choose to use callback to parse,
 just define a unique index for the argument
-and make the ``val_save`` field to be NULL also zero value-type.
+and make the ``val_saver`` field be NULL also zero value-type.
 
 In the example at the top of this section,
 the arguments ``--ddd``/``--eee``/``--fff`` and ``ppp`` all use this way.
@@ -311,7 +311,7 @@ Then the user input could contain multiple ``--xyz`` arguments.
 
 .. note::
 
-   The multiple times argument only support with optional argument
+   The multiple times argument is only supported with optional argument
    and must be parsed by callback way.
 
 Help and Usage Information
-- 
2.51.0

