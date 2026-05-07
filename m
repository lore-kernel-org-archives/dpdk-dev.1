Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0D3CD3439
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 00:15:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FA75402F1;
	Thu,  7 May 2026 02:15:08 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 0187A400D7
 for <dev@dpdk.org>; Thu,  7 May 2026 02:15:06 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2f3c623322bso508589eec.0
 for <dev@dpdk.org>; Wed, 06 May 2026 17:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778112905;
 x=1778717705; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gkCwOgsuLBchO4z35fBxjgNhXSB3v/R8yPQl4uY3WyA=;
 b=mLbzobAMy6uM7ggb4eGm7hyEWU2Kq+l7UKz6zwPTZ+JPgNIwmd7f6zQeuHOk1wV5xB
 TaUPOlfGfC9NGScyGXX9CW/cy7lIi/QDcrEUPrL2eeRs9hILW0Oeza6o9WKgq/i+97jl
 TVtU3ITNmRdH4HWl03KIrQE6U2Ey/u8EfKPObABThy9juAqIZ7Ni9rx/xNd3xUiRtlOy
 ggBV48ZVP3d0AWy2BRGJagn0ipkvDpZst4/9EPOSBEnWkRGhCtJg96DfEcyCs23H3IMk
 xVRpGl3hDXM1e77eqS4vY8oUmxNGvqpr/TpAQegHe/ocwqrdWdsUwndkgUovuJxRXz7M
 n4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778112905; x=1778717705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gkCwOgsuLBchO4z35fBxjgNhXSB3v/R8yPQl4uY3WyA=;
 b=JzaAZZasHjw8g7c8xe1Tafb7Sk0p1ZM0DhGTMoPdGqTUgmEVj2fHw6k37+2b/XSkIJ
 JBkyk8EF3Oz3EZWG/cJ/xJMf98Ueg1p7WOEMGMZ98G6GaGBFMeS9ejV66uPQj8+y0OEV
 Xr+DwrSciyj8qdxleGHBWLyjrblyyflT+Vvo46u/PkahsX3Wew9SX5gdscrj30/t6apY
 7hpLkwEdThFtCclebuj/Uiq2deLS4nNhJ1utwRsllzfu719jjVq6ftkhx4OclgdQ5pun
 2+GqQTFxZPIRdUIlQ4+qRud0yPWnkR4qkTCtw08pI6TSZDZhBFNMRsyv1ImeJxmZS9UA
 VEKQ==
X-Gm-Message-State: AOJu0YwF/KoR2vF9OLty1l+jfdTZDNv5t8I4HH+TNLrhqiiPykLCvhBq
 0+wOFNwBQM5MoCGLY2d2mC62KKeNRpijd55E8bLn33OBjoI2u3SWHw9bpoPNQQXqLJ2pXB33yUo
 maL8L
X-Gm-Gg: AeBDievOCC9nlvvEWWBtTlqG8kVdRKigZrkYKpkKoTcY0rRSECfW3lwPRCjed78LP7P
 DjQoYIXM+21LtP6qjLVAHoWyMsf2LCgh7jM0d9nyMQzsZtKHcRkykhem8q1VDlXPrGTXzgCi/HI
 th2Pve/wX6XdxDPqd6C38f97fL8avhkrM8MOzZseTW2uXbR8daJqWQqsWBCJFtjfMLOAuBcHK/R
 49ijEu8qBqZ4aIDdUpBeH7EyvGIexOnTKc3H6nrUykAi7A+vf0Vfsfwi6EMwM4qgGAvNHya/k5u
 0iVJ35j0S9pWTodIHkpW8ZdpMZVYuPwnOhzB4rKIMTjoRk3iv+eKG0I4UngD6QWcYxcI7GizvGv
 wFKb5L1HipimZfHw4V1XQ8TXOsBonZDD7D+7ko3x/CS5i11tvm9FmrVqw5fo8RuaUQbwkI8SNVE
 kcI/NOFE88f8TjempSuBMKsYm2Je0DXoUz8NYSnsHe4OA=
X-Received: by 2002:a05:7300:2146:b0:2d9:ad46:4a92 with SMTP id
 5a478bee46e88-2f54b68d65bmr3095768eec.13.1778112905108; 
 Wed, 06 May 2026 17:15:05 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f57057bd00sm5159080eec.30.2026.05.06.17.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 17:15:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC v2 1/4] config: add support for using flex and bison
Date: Wed,  6 May 2026 17:06:48 -0700
Message-ID: <20260507001501.608724-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507001501.608724-1-stephen@networkplumber.org>
References: <20260505183917.370281-1-sismis@dyna-nic.com>
 <20260507001501.608724-1-stephen@networkplumber.org>
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

For the flow parsing library need flex and bison and
these might be useful in future for other libraries.
Detect and provide generators for building.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 config/meson.build | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/config/meson.build b/config/meson.build
index 9ba7b9a338..8668546eca 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -296,6 +296,29 @@ if (pcap_dep.found() and cc.has_header('pcap.h', dependencies: pcap_dep)
     dpdk_extra_ldflags += '-l@0@'.format(pcap_lib)
 endif
 
+# flex and bison are required for libraries using grammars.
+flex  = find_program('flex',  required: false)
+if flex.found()
+    flex_gen = generator(flex,
+        output: '@BASENAME@.yy.c',
+        arguments: ['--outfile=@OUTPUT@', '@INPUT@'],
+    )
+endif
+
+bison = find_program('bison', required: false)
+if bison.found()
+    # Parser generator.  Emits both the .c and a .tab.h
+    bison_gen = generator(bison,
+        output: ['@BASENAME@.tab.c', '@BASENAME@.tab.h'],
+        arguments: [
+            '--defines=@OUTPUT1@',
+            '--output=@OUTPUT0@',
+            '@INPUT@',
+        ],
+    )
+endif
+has_flex_bison = flex.found() and bison.found()
+
 # for clang 32-bit compiles we need libatomic for 64-bit atomic ops
 if cc.get_id() == 'clang' and dpdk_conf.get('RTE_ARCH_64') == false
     atomic_dep = cc.find_library('atomic', required: true)
-- 
2.53.0

