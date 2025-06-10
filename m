Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A1FC5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 15:12:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D68642F06;
	Tue, 10 Jun 2025 17:12:05 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 2931A40672
 for <dev@dpdk.org>; Tue, 10 Jun 2025 17:12:03 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7c59e7039eeso797372185a.2
 for <dev@dpdk.org>; Tue, 10 Jun 2025 08:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749568322;
 x=1750173122; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QoulOjFZSMKbkcYdSsziERT9GGctaL0Bk0UtbQxAyqE=;
 b=jZ9FOGoL1WznU+Desyvp0YNKabCVe2/AetU3cW6R6cu5jWKI+9l3nq5iFXqJ0NBSmN
 ZFY7NbPE0/AKXe0sUXJVuMFBYvTMsd6peMavntX9jrs7CZDsUw8csx/xNKZ79s6MD+rr
 V3mPWiE0/6Ib0hPb4YOUHfmPQQBOtj2vIiXCQeXkLMBAXcUW6bN2i5c54B2PKoAOXNd2
 muq2uU5XH6Q3/Htz/KFdxQVaWPiz+RO67lP4TMev3sfjzQ3k2q7L6+vPsG/7M/mUYue+
 NTqF++xGM8OChHpgYfgEtEOFHIvzt0Ikrx2z91BwJwRNaM5Hhq5ywgGP+KGQMXAe8OIA
 exiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749568322; x=1750173122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QoulOjFZSMKbkcYdSsziERT9GGctaL0Bk0UtbQxAyqE=;
 b=wu6F9LOpX2SSCb+JzEBPtH5qK4Z+k8OnYRgvFCey6hma4zj2IDbUj1u9EENkErEjMO
 c/QAEQgUwAhUwdSuHz+aNaXU8rTaXXnFSwuEEUejsOB8vMu2lenuOKoEoohmoK5wD5qg
 c6RaW1zoRRLNJLE4dOOPYipFHu4iR+ICSBZiMzaG3BPdBUoJ2sNvhuRVC6Jn9vLxFP8w
 1Wu3EgUiW9yCBsW9UIhcMcW04bnW5bfzM7DkmOFAk+Hkzep94xrUTPYLOulhAkNnBP26
 DJVlfLfPQy+POku93mfnHjJRJQGSc7Rl8IH8OkfODwEBt5kROGY9PSNjPsMorzg6UzsE
 O26Q==
X-Gm-Message-State: AOJu0YzBY1fYG2PDURh2pm6MWwSyi+N2NVl2pOPjgkyC6EqcuGEdFoHT
 DU1ZgHIM0PJH/OuhlVt6zKuWeTSJeHVTvDMm/+VLQJfqsrLsMU+ku/KRmRVr2BZlpmrBbIeSHed
 Zj8tK
X-Gm-Gg: ASbGncv1zDtHLtoqlJ+7yTmZCWM+fv7E1aOs2qV5Siqe2CRg+sY36Ti7R1QLYq2pOsO
 ZpefLrxirG2iq2QUm07Gx6vyODp3/soa6VhivBqebqgyjxco2ofEAtYcR8ZpZlb0/Z6/UX9EjKz
 f9IWP3iZ9S8Y5agwFfmkCc8NGybM+kYJT3ZHWqCKA7iY53Er0yq/s6ml4rE7tSIfFwSY7dZf/RH
 QOaPSji68ljqy/on1IdvOZ7WuECsnhwvrZwelwfp1RK4t03jKAnG4SocEFkz72Yb9SncTcp9pU4
 4zQk+5ppQ5HB/gVdbwBmVPnVPKpfilm14h+1D+5e7Q9l/2KlvRPbjVMh9bxU146g8a5p48wQFPJ
 sin5ToOtysfl20zR6GiFZmtgBPg68tEi5oo15
X-Google-Smtp-Source: AGHT+IHecVuuBiTMP8Xpdv64EafDXOCzZ8NEUUutCqu01KZpkeQ5HrYu0hPh5AgnMGct8DjRiCgwZQ==
X-Received: by 2002:a05:620a:454b:b0:7cc:fef2:51b9 with SMTP id
 af79cd13be357-7d2298ec18fmr2808512885a.52.1749568322378; 
 Tue, 10 Jun 2025 08:12:02 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d2517fa678sm705822685a.22.2025.06.10.08.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 08:12:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 1/2] devtools/linux-uapi: conform to kernel headers install
Date: Tue, 10 Jun 2025 08:11:20 -0700
Message-ID: <20250610151158.209572-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610151158.209572-1-stephen@networkplumber.org>
References: <20250610151158.209572-1-stephen@networkplumber.org>
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

The Linux kernel has an existing script to sanitize headers which
uses more steps to clean up the header file. Make the DPDK header
import script use the same regular expression. The kernel script
is GPL-2.0 so ok.

Not necessary for current vduse.h header only but useful if more
headers are added later. Want the distro and DPDK header to
be exact match.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/linux-uapi.sh | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/devtools/linux-uapi.sh b/devtools/linux-uapi.sh
index ccd8b6816e..e739bdb1f4 100755
--- a/devtools/linux-uapi.sh
+++ b/devtools/linux-uapi.sh
@@ -79,9 +79,21 @@ import_header()
 fixup_includes()
 {
 	local path=$1
+	local tmpfile=$path.tmp
 
-	sed -i "s|^#include <linux/compiler.h>||g" $path
-	sed -i "s|\<__user[[:space:]]||" $path
+	# script to sanitize see kernel script
+	# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/headers_install.sh
+
+	sed -E -e '
+	     s/([[:space:](])(__user|__force|__iomem)[[:space:]]/\1/g
+	     s/__attribute_const__([[:space:]]|$)/\1/g
+	     s@^#include <linux/compiler(|_types).h>@@
+	     s/(^|[^a-zA-Z0-9])__packed([^a-zA-Z0-9_]|$)/\1__attribute__((packed))\2/g
+	     s/(^|[[:space:](])(inline|asm|volatile)([[:space:](]|$)/\1__\2__\3/g
+	    s@#(ifndef|define|endif[[:space:]]*/[*])[[:space:]]*_UAPI@#\1 @' $path >$tmpfile
+
+	unifdef -U__KERNEL__ -D__EXPORTED_HEADERS $tmpfile >$path
+	rm $tmpfile
 
 	# Prepend include path with "uapi/" if the header is imported
 	for include in $(sed -ne 's/^#include <\(.*\)>$/\1/p' $path); do
-- 
2.47.2

