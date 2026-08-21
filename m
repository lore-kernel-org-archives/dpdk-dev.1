Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62CEC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:27:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33DC040696;
	Fri, 21 Aug 2026 21:27:28 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id A6AA940658
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:27:26 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-84862b0d5f8so1008456b3a.3
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340446;
 x=1787945246; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yJ/jvZOvI0DzBB6o05Gueum3y/MpMNQlADjKoCk82dY=;
 b=W4gXbYZcRh4F/CrqWcxtan4i1wxJMJmQhSWtacGUMO6apPuValdyPgyhOea0u32Vll
 E3N5701Wf6lVa43aRx1ycput1XAKTxS7kAnNcDt6PbtNDlCjsqhyOaNo800qmHhtSVFl
 6Kgbl33SIaZfqNclFZSKJj0zm/y1D8LJNZwq4rKmUngemSmVEPgHdSR8iNWssgaNn8S2
 rdXJbNeeB0oYMicNpAZDZUpm7csgy3s1nsRmA/sdcyCvIW58sOzbeKuwXeW1mD9SUSmo
 p2gFt9kcJJ94ukwXea3kAgcsivPvCO/4uWWwt8a9IS72CACmf0egRIkE8WUHeR0UKEml
 /5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340446; x=1787945246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yJ/jvZOvI0DzBB6o05Gueum3y/MpMNQlADjKoCk82dY=;
 b=eCFGFaTgwFHP3p+Z539f6sHz1ohFGEVZSpcdtjVknnkwpw+ja6LNAq6x6XItHgVmkq
 PATvTyYiUpexpGyYSc2qiKZ00aIJEhgzzMJnaImVum7HzQwD/Llj+PWvlGkpUI6eTXR8
 hbprzbcZo+gVckjcT2uPNi+DIyL5A3h80YwiVeIMhKgTpOtctVpdahVVWCB5AeS7Y0uk
 kglyKKN0yltu7y6QUvV/CSlQLgA7GktixA+VOKJ2XmxgE/UrHmBqf9hAKDHhqfRoUUJ5
 2647cvRgHt0diu7S6ram91McBJYlcZWc8QLGZBcYMcRrGjGTz1SyW4XBffbx0wWKKBuI
 2cfg==
X-Gm-Message-State: AFuF++l8BuZi+Ls4b/DNknn+D7smFSIij89D+ptyiIQaVqN9wkOOy87f
 5wMnn0SlHt5wdYjfoXdxs/IyH0LsZO8sI7Yj8u0BQ5IWtZsJDES+OMmyDIBzJdPCLGU730AHZS7
 VaHB8
X-Gm-Gg: AR+sD112Abi/vixUdmlH2uivVx4GfkzxJSA7WH1dAyOBjyHEe/BuKvdRORz6wgi6btE
 +3cbQSv3U1Q97h+KqDv1/YiTpf102mG1qLby6WXDIBSPUxsFkVt0AlKCQGTLuYHnaBBgd2RKjGX
 FsrFTW8yvlvuS0fhfmYNRKmWyRvzxHPZuncTdUw29WRu5vN0+rTyslsGIbqXIgo2065xUv+rNSJ
 MZBSIwzpPPsr33g+9O9TDc20g0pAnqvY249aQwLZOEaYl3S5iy5aRuul0gTPzXIsSaDZnKTYrgQ
 uDQhpNB3MzbDCRD3DQJMDKI51ip1huTkUodPISjJTNM2CxaegkUlIDxO+1MK8rsG4KSam2uel2E
 z1doyuGuJXtQph7LWzeVrvpl6l2OfTPjpUiSIOp6uQKnqoUN9ubioDw6eLueGlumK5ywOodwOFa
 H5h7O27TdZe/SkXAMP/G7V9c1WA5ikW92S+bZFmOKvJGB56xZEhEp3m4pax5nSvYZo39d2aQWtw
 3osdDuCt724h6lPcHxshamIzU8=
X-Received: by 2002:a05:6a21:e584:b0:3cc:c7cf:5a44 with SMTP id
 adf61e73a8af0-3cd2fd4d78amr18004542637.2.1787340445845; 
 Fri, 21 Aug 2026 12:27:25 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:27:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 01/68] devtools/cocci: add script to replace fixed size
 rte_memcpy
Date: Fri, 21 Aug 2026 12:23:56 -0700
Message-ID: <20260821192646.146382-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

Rte_memcpy need not be used for the simple case of copying
a fix sized because it is not faster and will hide problems
from code analysis tools. Static and dynamic analyzers
special case memcpy() and can find issues that rte_memcpy()
will hide.

Note: many platforms use memcpy instead of rte_memcpy already.
The only reason rte_memcpy() was added in original DPDK was that
the older Gcc was doing slower on x86 than the special rte_memcpy()
when handling larger size copies.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/cocci/rte_memcpy_fixed.cocci | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 devtools/cocci/rte_memcpy_fixed.cocci

diff --git a/devtools/cocci/rte_memcpy_fixed.cocci b/devtools/cocci/rte_memcpy_fixed.cocci
new file mode 100644
index 0000000000..1f264711eb
--- /dev/null
+++ b/devtools/cocci/rte_memcpy_fixed.cocci
@@ -0,0 +1,15 @@
+//
+// rte_memcpy should not be used for simple fixed size structure
+// because compiler's are smart enough to inline these.
+//
+@@
+expression src, dst, E;
+constant size;
+@@
+(
+- rte_memcpy(dst, src, sizeof(E))
++ memcpy(dst, src, sizeof(E))
+|
+- rte_memcpy(dst, src, size)
++ memcpy(dst, src, size)
+)
-- 
2.53.0

