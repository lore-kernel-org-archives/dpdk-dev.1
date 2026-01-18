Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B508C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:13:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75B0E4065E;
	Sun, 18 Jan 2026 20:13:32 +0100 (CET)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51]) by mails.dpdk.org (Postfix) with ESMTP id D33FB402E9
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:13:30 +0100 (CET)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b8708930695so565227566b.3
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763610;
 x=1769368410; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zPjbqWPBFCYf9UQvn1bM63M94kWBASonsgfSSbcvp18=;
 b=yFE/eI+eIjZHImyRWWd/tu50d9Yr1Cb/EX4I/e8WfjIWbW1JT8ebNMGs8HCNL6WO9N
 QJfhTx9tLY+ib5oqBwfZonxCrNWgsP60Wjf84PNlpY8sReiSi+U2b2UEj66r72c63YSI
 ibhlnFg0sadkxJt4zGOcZOkqLLku7tk1/oNSmUY32b0RiwPGzOKTXlMFwbk9ocIzmR+N
 cp32oqwc1JWRFwdzODOksoeppmaMQQBncT6/WYV19BxHlkuePgWougUWlCcYFgRRprN9
 qfNPc1zhnIxHe0W/wL6gNdGwjRbzfF0lynb8CzwFyEpuIM7hMcF2blTZ3cbWdUUE8Mf8
 lhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763610; x=1769368410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zPjbqWPBFCYf9UQvn1bM63M94kWBASonsgfSSbcvp18=;
 b=T0coDVzBHPBS6mCyJ9/kWAvn6fu3btRISjMoVo1ikL5FowDFvHcSbMcHGWZ5la3wg3
 Bn1SP1fzu64LcLCW8ejtzO+tAsbtQZfwhYiQxU8005QxxhVywByxPBVTyXPYlzyt02Pv
 a2IdwF6cRnggq7tGXbczNaKewjSC+F3k7KKbl22IUpkUc4riW1/VjdhhsBJYLd8vXuTc
 zsptdNeCsWMAxbZ3AWztIiNth+M92+JIho4VDSnLNnbMEeN0b+HOXD9vCf1nb0kBvJkE
 B4sqnci3LJCeCLaEFOHX9+zIKahNh1n8Fmcij0B20xlwz+rTUKYBmORyd8aQ0q9J9gQz
 SZNA==
X-Gm-Message-State: AOJu0YzNpbmbloyJxlYAx+2bnRQsG02kT12MEfwXTigHbE5Ye3288CY3
 JZ89UdSsTEYWEW7tqSzYRI1zWc9Fp4frBeBFXNFU1j7/QoBZ7lgdX7USnV1AM9Vj7QA0UBFNhFH
 f3vJY
X-Gm-Gg: AY/fxX7bW/XI49dwDfFbUDUF62Fh1XYf5UzuNvJB/VtfnOZc13r1Ygp622wrRnWZY13
 mq+zWyBKYUDTERV2Hqpn8+5qi1BGHomtfniswKwGzASE5Kqz5lEDBqiqWFVu+7HoWTVW2A5ejEG
 bm5FbVGq9D+6yqEvuOnDYP1E+QyA4lyCfDsQaCR7Ok4FOyUgewxScItuHbui3Um531hqKbOCLv/
 Je41IpdysFGufOXU7QFZhkpDK2a+yX8nkGBQ6Ew+AuSk0CLHEZVwBJQF9AjTCztVJY5xXrNI0XT
 5dGznqympMin9/5xqwFh48HMoB7w5uaBDFGAg4+v9uuivZgLMglP7leYZxAebNbUI51KCZpP3Mp
 uAauIqQqmuI2aNVn2ZrbdSecVFbPz4UZUUNkKA2DTBvj5cr/BUkNN2D20N4T4bhCIa0zH8Mdaro
 aoso5rkQSO3lsLAXWOvKIxQHuHmnVz2av0PJGRYRpRbD6j/sR0Dw==
X-Received: by 2002:a17:907:e118:b0:b87:9d0f:5e71 with SMTP id
 a640c23a62f3a-b879d0f76ebmr467599166b.7.1768763610228; 
 Sun, 18 Jan 2026 11:13:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:13:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH v5 01/54] doc: correct grammar and typos in argparse library
 guide
Date: Sun, 18 Jan 2026 11:10:04 -0800
Message-ID: <20260118191323.241013-2-stephen@networkplumber.org>
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

Changes:
- Add missing articles ("a user-friendly", "a long_name field")
- Change awkward phrasing ("take with" -> "have")
- Correct verb forms ("automatic generate" -> "automatic generation of",
  "are parsing" -> "are parsed", "don't" -> "doesn't")
- Change typo in field name (val_save -> val_saver)
- Change stray backtick in code example

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

