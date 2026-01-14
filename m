Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB97D3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:28:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48C1B410FB;
	Wed, 14 Jan 2026 23:28:33 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 5C49A40E7C
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:28:31 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so3186285e9.1
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429711;
 x=1769034511; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MVDEitid3uBi21CPUIsj4OwBratlZVhWGA0kO20KOyU=;
 b=FaE3I7fRIjFT/UPHqxRlnjb6cCVOjy9XYgMQ/tLswV0tqefOpeRTjQgCVuj5hIxU6l
 X2QpZRpcMC8nCbjkEEqCCOuOc3U4v5XS0jRrV77JvXNRAlZKw799Dg/GF/7JulC3T/1+
 eSvdA+cOCP4aVynVZd3OfX3UiddmIfOpkQngJnoRTEfE0GxTisNFsangcmTddkJIbxjw
 urz+noBzyACtINBWZKri0Nn1j22r2t1hPMnp0nV6jGvSVh0UsAwzsdRxcEd/ZuljGLgD
 GB4QMogKHGqc/OkGnfVYXgmdBplx+4ImNnPPf8byg4NzgYpuskXxSj05rzCn9SUR1GJm
 oXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429711; x=1769034511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MVDEitid3uBi21CPUIsj4OwBratlZVhWGA0kO20KOyU=;
 b=CqYS994LTdNPB7WHF2Cuu3/mYy8yMjtizp0lieuPrm3YVqzGTJht0WetZW5yuNNSz1
 Pvkhivwfd3fhMpbXqTv0iLIVibJtfUVLGlLjVhRVO4KefwrCLgJax5QhDa6eAfK5gt60
 mWEg57Vp3UU1tq1TOiM4e3HwFCdcvycvM9wvaLSFXkhxFbXeGnTlulqJ/BzYpKBY6rP2
 48IrMkbDkr8gSe67bLFyTDiHnjadxhEjKD1+qwZKPbOJV3tyHxwJu6KAtgwvz1wp2cn/
 2v7D+4jKOSXdTZu3oiVgOSAEKYyhad6ts9wFRur2vQ7QZ7VltJTLz4uQ+m29YerbKpbA
 H1MQ==
X-Gm-Message-State: AOJu0YyG47tQlo2n4qlGTKvN0ewndNS8jf7vhIlsEbhQTrehVLsaTXF9
 p3+7mtF8vGoBQ2yo0LLUtomWrXFEk+wuFvMmvPlEghk5skjLaiwtG3ZHE5ThySGE/ZbczozhWQD
 ukXbf
X-Gm-Gg: AY/fxX4lgXwlURcfAmxEiDk6WjR4y3WwxpAFtYBXend1G5FStUaxcJ0VbCtQ9Oyi7Hw
 DYGs29J9YWKX7RDtCGTv02zyGqiw72ZEZtWD0x5qJd4lLl8tu3pr25rYuYEv3XIoCbqMt2hdk2t
 BPcTQNWmdRQY7zciE6lakDpI4HbgLwW7z0Tfu3dmJaqEzoWQ5OpaeV2xkiIirLqxFonnQl2N0GJ
 L+uRBMgspfLNi4fs9SjJ09iVWEnmg68p+j/SfAoh2ajobI6M0Zy6NInFx2tWlBSGb4MIakonZko
 OyJNrRlaEi785iab2iFs4lxoSgBAoSpKdJckN2LytOQEe9jlpY1VXsi6onutMp3+FJ7kuT5/mRP
 D3kvgA9K2yK9t/ff0K7qIGuSrHSgWS58/nApdNwU5SHy/VaR+8nQ6J8SPyjt+MsOc+IgC/j/mlg
 YnG4xFIp/1Nscyj1sUzNVTbg1X9WnT3hL4CGA0BJkO/5VwqIADaQ==
X-Received: by 2002:a05:600c:3acb:b0:46e:4a30:2b0f with SMTP id
 5b1f17b1804b1-47ee3372fbbmr40626345e9.29.1768429710940; 
 Wed, 14 Jan 2026 14:28:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af653632sm1757198f8f.11.2026.01.14.14.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:28:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v4 02/11] doc: correct grammar and typos in argparse library
 guide
Date: Wed, 14 Jan 2026 14:26:54 -0800
Message-ID: <20260114222821.87920-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114222821.87920-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260114222821.87920-1-stephen@networkplumber.org>
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

