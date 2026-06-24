Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A803BCDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 16:25:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D055C402E7;
	Wed, 24 Jun 2026 18:25:58 +0200 (CEST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id D3D27402BC
 for <dev@dpdk.org>; Wed, 24 Jun 2026 18:25:57 +0200 (CEST)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-139d5c9a495so1179416c88.0
 for <dev@dpdk.org>; Wed, 24 Jun 2026 09:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782318357;
 x=1782923157; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J2zeDnmJsMPMIGF58EWYnlWm9mvoJwgWvcZB4TRwDls=;
 b=OXwKVonUAtywlLIO34uNnQTt6bZc809CEDKN9YlmuIsThIj1C9hnVFZFFovSbqmKLS
 BbDqENdjAmRKvpw28cZ7m9zV2djMkVs/jU/KKCNpyY3FboOhYKr2aMXAIMJXOM+I62+C
 hjgYp8qj+WarmR0uaCDk3gP2cHI++lrUHbOSSoeXbfaznJcxT4tHVzgOarGgXt/XNRph
 RtadGOs1mslGyXmAou00FetZxF12r90pMAukt45IJkwhz36eAcyxUaxY7+Ma5+p4noSI
 pJsabSa0v8yhUpGvo2HKaokkQtVofS5EdfMqiHS1J/K+blY/QpnJrdKZ8rDYGjj7bfpK
 vTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782318357; x=1782923157;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J2zeDnmJsMPMIGF58EWYnlWm9mvoJwgWvcZB4TRwDls=;
 b=POxKQk0Fe/rFAlynMM6ztVcGcZd4IO3jkOiaQqWtBqtWsdUzedBlOdfnLYXm2lUJZa
 RBB9ZLKo9Bb9nRRxW+uyXaVlw/Wk1M08pUGBRRYSfME2gJPBqExfzYcHcp1UTWP8RCoY
 Djsuw17XnH5cHg1k2F5CHT+qm44VczD1wTOgbIS6QT8gYDm/h63QJrgYH68sqHgIBdsf
 eI1j35tCSLb9ABwp2WtG/MKlqPMDYxRIYmiSDgzeIMVO5Jy2r6SFMzpKImnSaHUq3ZsG
 g8OftGPrAUtVE11nfAdWZyDkzVKQHPm52mhYg6+WQ0UzlKlmbYlSPipRhbapukMNu0YZ
 jeug==
X-Gm-Message-State: AOJu0YzWgn5Cky6Xk7mAZzWkyzIpkbykFvUcEZsBnH7YwtGSe8YKZzHt
 F/n5F0baHYKLb02ZkTWaEc93w4OgpCj874mYlZ5TM7nd4VhNd5qN4WTW3jECw74LOdZIUhRWm1m
 ScZ72
X-Gm-Gg: AfdE7clXX27RIkZGBC+74uJ3zs5B96Fj8JrasEa6pbkxNcCPobXYGsyAKzCEGknuccp
 dSN5/DEXgguyCOVh08nvOloFhVPTBb5qQ5u8wvfki6ksjF4eFlo4uXL1KF1560Bfame708rMnmz
 GgDx9IKiAWW+XEY6yje29lMjB3g8Wto2XK6u91BZjgvtnSf8YkqOGmVtnNa9t8fyOq+StvRsgG4
 N4yrszZHDjE3pTwG6aO/ReMoCJpnSzqcFz61qSQI/bCHXb5y4LJlQA+138JLsRaHrlHoXRhjpRh
 38nRo1+22EOq8hIwuFoH59Z0r7d0PauVj4JDab+voZ87bAGqFUTbGV+hfr3blK0IZEJCID6ihCQ
 IB64S/vVeLTePlsblh0i5CZzWlwHkbQh0yWEsSVzTq2/6v7PxF0i38iNEcaEajPTsxBYPSxm5L1
 InmknbP7N0gai9kbgpJbkevPk8h3L1KSWw72u09FTSRGKYNKJ2Dtsy4LysiqZhBg==
X-Received: by 2002:a05:7022:610:b0:138:36f:4288 with SMTP id
 a92af1059eb24-139d0c192cfmr3253782c88.15.1782318356461; 
 Wed, 24 Jun 2026 09:25:56 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6d2e4sm379678c88.7.2026.06.24.09.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 09:25:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH] checkpatches: suppress warnings about msleep()
Date: Wed, 24 Jun 2026 09:25:53 -0700
Message-ID: <20260624162553.79057-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The DPDK checkpatch uses the underlying kernel tool which
does some checks that are only relevant in kernel code.
The warning about msleep() time only makes sense in the
kernel.

Suppress feedback like:

WARNING:MSLEEP: msleep < 20ms can sleep for up to 20ms; see function description of msleep().
+		msleep(10);

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/checkpatches.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index f5dd77443f..071bdb2c15 100755
--- a/devtools/checkpatches.sh
+++ b/devtools/checkpatches.sh
@@ -34,7 +34,7 @@ PREFER_KERNEL_TYPES,PREFER_FALLTHROUGH,BIT_MACRO,CONST_STRUCT,\
 SPLIT_STRING,LONG_LINE_STRING,C99_COMMENT_TOLERANCE,\
 LINE_SPACING,PARENTHESIS_ALIGNMENT,NETWORKING_BLOCK_COMMENT_STYLE,\
 NEW_TYPEDEFS,COMPARISON_TO_NULL,AVOID_BUG,EXPORT_SYMBOL,\
-BAD_REPORTED_BY_LINK"
+BAD_REPORTED_BY_LINK,MSLEEP"
 options="$options $DPDK_CHECKPATCH_OPTIONS"
 
 print_usage () {
-- 
2.53.0

