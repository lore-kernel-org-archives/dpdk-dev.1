Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BF1C982D6
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 17:22:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3DF742FF1;
	Thu, 17 Sep 2026 19:21:31 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id 3DA7142FDF
 for <dev@dpdk.org>; Thu, 17 Sep 2026 19:21:30 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85469b2e1d5so1107366b3a.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789665689;
 x=1790270489; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ntqjwbgnol4IeVQEEvLKO7+kHR56qds/p/s6M913cwo=;
 b=dSu9e2jNUDhte7ydyIkZjlwpBAn0jX5oHNytDa+hXIp/ykdB3iofaF9/u8VWKkgBDi
 eonZhdBbXHEwItGhS67yLHkA8jD1S824fqWi6r6LHK4fbVcYhiTcp4PlW3XSjfpiYA8F
 HGklnAPcOAsZSz2YUoTtdKiKOxwepbM2xgxYJ+bUIAuuMKKCwqLv3jMYA4roSgcSyKzt
 9qMv3hsZDOomyc+Hh7eQENPBd6zT4/0Gp5TfZeYyxhpGT8jfz2OR3ogD6JGqJS/HFmPC
 sndMIiGMiYrUdOP9Ly3WiF1D/7aAacwMvTihrDALRefChT+A9vDSyTPLpdo1e+1GHI0E
 FBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789665689; x=1790270489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ntqjwbgnol4IeVQEEvLKO7+kHR56qds/p/s6M913cwo=;
 b=NeM3GA3XL+Ps/ec+W53hhh0TYATuUuNIx+f1f6LCl/Y0gSPMRqswvefgKLbjAK/b3F
 9w6uCmiEh43ZO+mbD7bg43BrK0g4W3cphHFf5RxaCFVFHI3CZDh92swkHN/btjdfn24D
 MF0NixpwZeKSuXZBh3M/mNUAEtKXyV7qRby7PDmZNLuRZjUYVQ9Blcg48tWyTK1Xn4Kt
 1OzbQDNIB8/KKv7vnr0hnmamzIMQDOy/BHX45RGJyjXuMQyB8SYLSbCM3OIy3kT2yP5Y
 piXmsnf0roe3k/zKsS66PhFNT0EEKaKY+NSnmSmDhX0NuE+9LdNXy/e4nFX1xPSJbI/O
 y79w==
X-Gm-Message-State: AFuF++mRHE+j/dY/cg+U7gPd/UG7T1o5ONyoWflbBajqiw2yU44wNwHk
 qGZBsdyhFPjhX9n+kXMpPDTMjsoHyLuSUgwpDuKSUEns/IiyLUIibH44psTDvkQehx609i9RkxD
 XQXxM
X-Gm-Gg: AYBFou0ZdCMDDwJ6v3gm0hlUNoETK8LN7JTYTT7KQNVv19VU9u2IwmGol3GodLedWEu
 1Dp05wznyJ0WrtMs7dApHxYXunLQ7vTZQBVKVLpHSjF2zawx6OCHNPRg26bdu3uiNBZoQpL5d/x
 2B/+LmdXw3tJmR6bdv3cblbVrtGqZMunZZ2tA7zrM21iNg75TO7tbUobfVNbXTSJhqwBUzj7ADN
 MarfzgfvXhObzzO2eimKRlxQYM/JZdomHbKo/uHQEb12hqZMgL0mWF/+bHLh1u7ACGFoHPQrEwQ
 VsPcxFuP/5Eot2MBKfqb2gL70/LczlglrEvD+yx/K13w7cHB8K4gWZQGZXNpcZ/NFhyVQqwT92j
 9/Xon+pGgF0C0BVt5PhW3lPy+C857TlVUMnDzOBdWVn3aQjkBu0OWKLZfSgF/ZYgG0gC/jgiTOQ
 UdwOe6nx/LiKDIHuFatf9UTUtBZdUQf6No7EZ/KuimOEgdgs0X0ffd0foHmWlIeKhpCrcr4qwop
 wr4C12gXagU/S+9qKJvdcZSmXnx4ZCIU2jggy1KzFZMdEjH
X-Received: by 2002:a05:6a00:4501:b0:874:705d:f65f with SMTP id
 d2e1a72fcca58-874705dfbb7mr1620230b3a.45.1789665689279; 
 Thu, 17 Sep 2026 10:21:29 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87379a2e079sm1447408b3a.31.2026.09.17.10.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 10:21:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH 6/6] devtools: forbid direct use of sys/queue.h
Date: Thu, 17 Sep 2026 10:19:44 -0700
Message-ID: <20260917172116.660120-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917172116.660120-1-stephen@networkplumber.org>
References: <20260917172116.660120-1-stephen@networkplumber.org>
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

The set of list macros provided by <sys/queue.h> differs per platform:
glibc lacks the _FOREACH_SAFE variants, and musl and Windows have no such
header. DPDK now provides rte_queue.h with the complete set.

Both headers use the same multiple inclusion guard, so a single direct
include of <sys/queue.h> anywhere in a translation unit disables
rte_queue.h for all of it. Reject new occurrences.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/checkpatches.sh                 | 9 +++++++++
 doc/guides/contributing/coding_style.rst | 5 ++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index 18bd825372..a8ff4bfe82 100755
--- a/devtools/checkpatches.sh
+++ b/devtools/checkpatches.sh
@@ -105,6 +105,15 @@ check_forbidden_additions() { # <patch>
 		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk \
 		"$1" || res=1
 
+	# include rte_queue.h, the system header has fewer macros
+	awk -v FOLDERS="lib drivers app examples" \
+		-v SKIP_FILES='lib/eal/include/rte_queue.h' \
+		-v EXPRESSIONS='include.*<sys/queue.h>' \
+		-v RET_ON_FAIL=1 \
+		-v MESSAGE='Using <sys/queue.h>, prefer <rte_queue.h>' \
+		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk \
+		"$1" || res=1
+
 	# check %l or %ll format specifier
 	awk -v FOLDERS='lib drivers app examples' \
 		-v EXPRESSIONS='%ll*[xud]' \
diff --git a/doc/guides/contributing/coding_style.rst b/doc/guides/contributing/coding_style.rst
index 11de3bb39a..f2c2cd8503 100644
--- a/doc/guides/contributing/coding_style.rst
+++ b/doc/guides/contributing/coding_style.rst
@@ -317,11 +317,14 @@ Queues
 ~~~~~~
 
 Use queue(3) macros rather than rolling your own lists, whenever possible.
+Include ``<rte_queue.h>`` rather than ``<sys/queue.h>``:
+the set of macros provided by the system header differs per platform,
+and the DPDK one provides the same complete set everywhere.
 Thus, the previous example would be better written:
 
 .. code-block:: c
 
- #include <sys/queue.h>
+ #include <rte_queue.h>
 
  struct foo {
          LIST_ENTRY(foo) link;      /* Use queue macros for foo lists. */
-- 
2.53.0

