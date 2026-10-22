Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15501606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=XHNu7YwR
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B70540613;
	Thu, 22 Oct 2026 17:54:16 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 75DD940264
 for <dev@dpdk.org>; Thu, 22 Oct 2026 17:54:15 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2db80fcdf8bso13115555ad.2
 for <dev@dpdk.org>; Thu, 22 Oct 2026 08:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792684454;
 x=1793289254; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=693lSklddI3fY04CZMSlUNh0NY6qowaodQRsUTCG4Bg=;
 b=XHNu7YwR/dk0X2u0ZxaFM9/5n8EagBxOCJImTJnuaz10QsHcJm7mF5mxNfLOa6b3v4
 aH863v513HrrHiaKrc0oqoE9JHB3/FwY48EzWkUnAkUTYmUwIzY7sO3NyCehogJT3TBz
 +YptVlnMaE/AiCRLJrsZdvA1z3LhVubQcXmK6G/98rsJOUVP4kxqiabOd8muPtyPcHdf
 2EOb//DvyrLK93kR4Wmd2Rr0KlZVY6VthE8vKZZuZ/FBsGD6MtC41A+eoonRJQ/pJsSn
 ChSZ7xBGZ7ghUdAoTUSCiFNK3oqo+JO7Fg4ptGpxCAZWMeXQT067sq3+8hHCJXTBYnXt
 bE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792684454; x=1793289254;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=693lSklddI3fY04CZMSlUNh0NY6qowaodQRsUTCG4Bg=;
 b=CDUUzqj/AdfoilnAitfKggTWc/755n1l/sNwVTfJB988uk951NCTiqN2dPX2XWElrW
 SbOO78oc2QQqLUwjG6a9kfXUM6yZKJvPLG+aiH6xW1n9RVOUFRrvZGHOFx6SAuM1k/xX
 +BacTW10pI9Z5ke5TM4ouYaR3SYgIL830WREWhzn4yqYixSVkKd8WkIPdD1DbH21vFyf
 QyJ1Udq7BN0V+qEWHXHiBZOU0jWwbwPbK4sfjWtRQy5/JpUzWNN+eFJPGC8cX61n+vd9
 885SQvbeVJ5HNEmxO+2ERIUHU8t4zl/hJr/AiDQgWn4OHR1uCwrP3mPRMSYRhIKgH/rz
 9Xcg==
X-Gm-Message-State: AFq9FYKizx8J/wuCB5QcuEcvfhT5C/9J4MkPlJaPJk1w3j4l3oGVcLO8
 0VgBpwdcc10gEyrJdwlidiBXGYS8yPl3GzEMqmtty9ZddBQPsKA4chiG6C9S87G0b3Q=
X-Gm-Gg: AYBFou3wiGX6A4Wx/64lGS8gcDk8iJqz+VRlI2jJ7GOHXb50BWRUZEUwZepf0VZjjY+
 zIGNiauJZrH5WfNh8ujPqk1pT+pzeybLpbqMfONlQGr44blE/Vpnu9d0gQWxEPnoW8Icv7NdgPE
 u1OV0ev/jpbF3Hh0t2K/paipTp74ypZMe8E4V4P1y5S2phsA0jnueiC6dXoew2IBj216euVUFYJ
 vAbWxQVYI/89LjuMFQB+MjsSg/VfKzTGTDJjCIJTyddlFrvIQshRReNZOQ+JkGd5hWJj1HbVZVF
 gL1AR1BJSS3ken/0lkMVBnTwCa2Bn1eRjYQvjd3HPfVL0/OPuVsOmFniQ2wsfd5r84WcXoAbI5P
 d1N/9dJLApE8CutonFdgwJLu69I/L2U7Bi4OOjd7Zl/+IAbyAv5+sHAtle4jIYC/QtBS7ZWbUls
 pS/IUbSVzCIiGWO9/VpCMC087ViEflaIXDXKNJ1MSVvE5nJdl7PEfHyolAdiPI6AKDT73oDhmvS
 0tEVUyPgsgrEOQyXwK2VEDGgi1UDh1gG6b6PwLkTvYzJUl6XdpT2+uAjxYRWjoE7AsSPkkEIcUh
 z8EonxsB6K17AFsogSWRig==
X-Received: by 2002:a17:902:d2c6:b0:2e9:9bac:2e90 with SMTP id
 d9443c01a7336-2ea43d3a8fbmr42861495ad.65.1792684454317; 
 Thu, 22 Oct 2026 08:54:14 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea7b3ba573sm149975ad.48.2026.10.22.08.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 08:54:13 -0700 (PDT)
Date: Thu, 22 Oct 2026 08:54:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wei Chen <allen.chen@jaguarmicro.com>
Cc: dev@dpdk.org, cristian.dumitrescu@intel.com, stable@dpdk.org
Subject: Re: [PATCH] cfgfile: fix isspace() undefined behavior
Message-ID: <20261022085411.6932d274@phoenix.local>
In-Reply-To: <20261022122348.3467-1-allen.chen@jaguarmicro.com>
References: <20261022122348.3467-1-allen.chen@jaguarmicro.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 20:23:48 +0800
Wei Chen <allen.chen@jaguarmicro.com> wrote:

> The _strip() function passes a char directly to isspace(), which is
> undefined behavior. The ctype functions require an int argument that is
> either an unsigned char value or EOF, but char is signed by default on
> x86 and ARM, so any byte >=3D 0x80 in the input is promoted to a negative
> int and indexes the ctype table out of bounds.
>=20
> Such bytes are reachable from a user-provided config file containing
> UTF-8 or other non-ASCII content.
>=20
> Cast the argument to unsigned char, as is already done in
> app/test-bbdev/test_bbdev_vector.c and elsewhere.
>=20
> Fixes: eaafbad419bf ("cfgfile: library to interpret config files")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Wei Chen <allen.chen@jaguarmicro.com>
> ---

Looks good, there seems to be lots of places with same issue.
Perhaps putting helpers in rte_string_fns.h which handle the
common ctype case and use comparisons to avoid pitfalls.

   static inline bool
   rte_isspace(char c)
   {
   	return c =3D=3D ' ' || c =3D=3D '\t' || c =3D=3D '\n' ||
   	       c =3D=3D '\r' || c =3D=3D '\f' || c =3D=3D '\v';
   }

Quick AI doodle.

=46rom 653b2204ef72a45e460ba557c6b765b1965154c5 Mon Sep 17 00:00:00 2001
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Thu, 22 Oct 2026 08:52:58 -0700
Subject: [PATCH] eal: add ASCII character classification functions

The <ctype.h> functions take an int that must be EOF or an
unsigned char value. Passing a plain char is undefined behavior
for bytes >=3D 0x80 where char is signed. Most of the ctype calls
in the tree do exactly that, including rte_str_skip_leading_spaces().

The ctype functions are also locale dependent, which is not
wanted when parsing devargs, config files and addresses.

Add rte_isspace(), rte_isdigit(), rte_tolower() and friends.
They take a char, use ASCII only, and never match bytes >=3D 0x80.
Use rte_isspace() in rte_str_skip_leading_spaces().

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_string_fns.c             | 44 +++++++++++++
 doc/guides/rel_notes/release_26_11.rst |  6 ++
 lib/eal/include/rte_string_fns.h       | 89 +++++++++++++++++++++++++-
 3 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/app/test/test_string_fns.c b/app/test/test_string_fns.c
index 213a9312ea..ba6b6fa8b2 100644
--- a/app/test/test_string_fns.c
+++ b/app/test/test_string_fns.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2010-2014 Intel Corporation
  */
=20
+#include <ctype.h>
 #include <stdio.h>
 #include <stdarg.h>
 #include <stddef.h>
@@ -378,6 +379,47 @@ test_rte_str_to_size(void)
 	return 0;
 }
=20
+static int
+test_rte_ctype(void)
+{
+	unsigned int i;
+
+	/* Must match <ctype.h> in the C locale for 7-bit ASCII */
+	for (i =3D 0; i < 0x80; i++) {
+		char c =3D (char)i;
+
+		if (rte_isspace(c) !=3D !!isspace(i) ||
+		    rte_isblank(c) !=3D !!isblank(i) ||
+		    rte_isdigit(c) !=3D !!isdigit(i) ||
+		    rte_isupper(c) !=3D !!isupper(i) ||
+		    rte_islower(c) !=3D !!islower(i) ||
+		    rte_isalpha(c) !=3D !!isalpha(i) ||
+		    rte_isalnum(c) !=3D !!isalnum(i) ||
+		    rte_isxdigit(c) !=3D !!isxdigit(i) ||
+		    rte_isprint(c) !=3D !!isprint(i) ||
+		    rte_tolower(c) !=3D (char)tolower(i) ||
+		    rte_toupper(c) !=3D (char)toupper(i)) {
+			LOG("FAIL: mismatch with ctype for 0x%02x\n", i);
+			return -1;
+		}
+	}
+
+	/* No byte outside 7-bit ASCII matches any class */
+	for (i =3D 0x80; i < 0x100; i++) {
+		char c =3D (char)i;
+
+		if (rte_isspace(c) || rte_isblank(c) || rte_isdigit(c) ||
+		    rte_isalpha(c) || rte_isxdigit(c) || rte_isprint(c) ||
+		    rte_tolower(c) !=3D c || rte_toupper(c) !=3D c) {
+			LOG("FAIL: non-ASCII byte 0x%02x matched\n", i);
+			return -1;
+		}
+	}
+
+	LOG("%s - PASSED\n", __func__);
+	return 0;
+}
+
 static int
 test_string_fns(void)
 {
@@ -391,6 +433,8 @@ test_string_fns(void)
 		return -1;
 	if (test_rte_str_to_size() < 0)
 		return -1;
+	if (test_rte_ctype() < 0)
+		return -1;
 	return 0;
 }
=20
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/=
release_26_11.rst
index be758a0c02..c6ccf6ae2d 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -60,6 +60,12 @@ New Features
   Added the ``RTE_DIV_ROUND_UP`` macro in ``rte_common.h``
   to divide dividend by divisor, rounding up to the nearest integer.
=20
+* **Added ASCII character classification functions.**
+
+  Added ``rte_isspace()``, ``rte_isdigit()``, ``rte_tolower()`` and related
+  functions in ``rte_string_fns.h``. They take a ``char``, ignore locale,
+  and are safe for bytes >=3D 0x80, unlike the ``<ctype.h>`` functions.
+
 * **Improved pointer arithmetic macros.**
=20
   Updated  the macros ``RTE_PTR_ADD``, ``RTE_PTR_SUB``,
diff --git a/lib/eal/include/rte_string_fns.h b/lib/eal/include/rte_string_=
fns.h
index b3b5bdf275..1e3b2df9a1 100644
--- a/lib/eal/include/rte_string_fns.h
+++ b/lib/eal/include/rte_string_fns.h
@@ -12,6 +12,7 @@
 #define _RTE_STRING_FNS_H_
=20
 #include <ctype.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <string.h>
=20
@@ -115,6 +116,92 @@ extern "C" {
 ssize_t
 rte_strscpy(char *dst, const char *src, size_t dsize);
=20
+/*
+ * ASCII character classification.
+ *
+ * These are locale independent replacements for the <ctype.h> functions.
+ * Unlike the standard versions they take a char, so they are safe to call
+ * with any byte from a string, including values >=3D 0x80 on targets where
+ * char is signed. Characters outside the 7-bit ASCII range never match.
+ */
+
+/** Return true if c is ' ', '\t', '\n', '\v', '\f' or '\r'. */
+static inline bool
+rte_isspace(char c)
+{
+	return c =3D=3D ' ' || (c >=3D '\t' && c <=3D '\r');
+}
+
+/** Return true if c is ' ' or '\t'. */
+static inline bool
+rte_isblank(char c)
+{
+	return c =3D=3D ' ' || c =3D=3D '\t';
+}
+
+/** Return true if c is a decimal digit. */
+static inline bool
+rte_isdigit(char c)
+{
+	return c >=3D '0' && c <=3D '9';
+}
+
+/** Return true if c is an ASCII uppercase letter. */
+static inline bool
+rte_isupper(char c)
+{
+	return c >=3D 'A' && c <=3D 'Z';
+}
+
+/** Return true if c is an ASCII lowercase letter. */
+static inline bool
+rte_islower(char c)
+{
+	return c >=3D 'a' && c <=3D 'z';
+}
+
+/** Return true if c is an ASCII letter. */
+static inline bool
+rte_isalpha(char c)
+{
+	return rte_isupper(c) || rte_islower(c);
+}
+
+/** Return true if c is an ASCII letter or decimal digit. */
+static inline bool
+rte_isalnum(char c)
+{
+	return rte_isalpha(c) || rte_isdigit(c);
+}
+
+/** Return true if c is a hexadecimal digit. */
+static inline bool
+rte_isxdigit(char c)
+{
+	return rte_isdigit(c) || (c >=3D 'a' && c <=3D 'f') || (c >=3D 'A' && c <=
=3D 'F');
+}
+
+/** Return true if c is a printable ASCII character, including space. */
+static inline bool
+rte_isprint(char c)
+{
+	return c >=3D ' ' && c <=3D '~';
+}
+
+/** Convert an ASCII uppercase letter to lowercase, else return c. */
+static inline char
+rte_tolower(char c)
+{
+	return rte_isupper(c) ? c - 'A' + 'a' : c;
+}
+
+/** Convert an ASCII lowercase letter to uppercase, else return c. */
+static inline char
+rte_toupper(char c)
+{
+	return rte_islower(c) ? c - 'a' + 'A' : c;
+}
+
 /**
  * @warning
  * @b EXPERIMENTAL: this API may change without prior notice.
@@ -133,7 +220,7 @@ rte_str_skip_leading_spaces(const char *src)
 {
 	const char *p =3D src;
=20
-	while (isspace(*p))
+	while (rte_isspace(*p))
 		p++;
=20
 	return p;
--=20
2.43.0
