Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682C4C53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 18:00:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2786440E4A;
	Wed, 29 Jul 2026 19:58:01 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 93BDA40E1C
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:52 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38e3617ba36so1484696a91.3
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347872;
 x=1785952672; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CrpwQ8i4fl71NDcI6nMJQybK8wjxaXtksuSUEGn1T4U=;
 b=IqTsKZpy+kvTCMIGK9Q9+M2XRnLx7d1HgoHpn9W5lY6HcccH2Q3bHEW0MtslsnVa/M
 ypeVE7Q+jSlvZPwU/d1dDap5kUX9/+jpWDlAk+8dxDfuQ7GDnwS52HpJ9i2mpx/V9qWm
 jv1Yn/DVjfejvpQXsaWKIMyjOM6es6FDoBaM0SWi1DQt86rfJJsMnul9Ve2csjsNowGh
 lRumdS6o9y8Ef5+51HAuEDb5VIFOrjjNwZX+Hl4YtqQWjVBKnE3GUgSptalCRxQQ3A1D
 DGN75u+ZD0gsFDKLF3vDkcUdsRvMTBQOiEKHAevRLEKdfBIOasbl9Ccwu2PJDdZSqkVU
 yUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347872; x=1785952672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CrpwQ8i4fl71NDcI6nMJQybK8wjxaXtksuSUEGn1T4U=;
 b=oIXRYWnYLv9oHjouALhT6363y6qePQRHsMGh1PMJuqadhvAdDWFp/Bni+8pbjGBMGS
 d8vI1RARwfEJBQow6e/EAcR8Ja6immewaZWIuvgvCs/4FqFhNh00ayb7PsQnPpDv3jN7
 4Ei9aCenSKy54di43wP+gFk2S/O7I+Ac4ZLm5cfDFo0UkaE/7i3X1GDq/yxN9CsxPAe1
 +FKaFl/4bTOJjdrYhFu1XmqpWyKBoM9y1vMBj8u3Q4DzvhzU/2nu+Dd3LkEbg4ziNNwO
 iSWrVGRLzjcM2KIgFOTF6FaG6VEYohRWI0c/y7PR7uPoPbBlp2U/FiuHdlnJnDeCDD0c
 hjyw==
X-Gm-Message-State: AOJu0Yw+QIj/Pnph1vTJOJbQYzUXeM+qWHwbZAwBHjsf0CH7IXi5Jecn
 zWxw7QEXCHZWA6bL/75eh9qZDOkGBCw3OPGGY4arU1yjHgidFaXZxF0TQ6VnQbS6J2n0udsc/XB
 gSVgp
X-Gm-Gg: AR+sD10hKuoc4kBRDBJOGjN/hsXlqCgbpa4SmT+Ak0piTBnGv3k/l6GqWmwN/vqHhln
 QIKia/BOYeoFUH+VaiHrj+FpTPZWy+q9782DDrZXrABN56URWJWhNU08IiIpWja4znS1eQXmhad
 hMunyCU7akHTLtaXpMqd7zFmmWMCpRi8nKTupGgC8nBOr5vY5NHDJOZrij9EXTZaEAexaPRlHjg
 Wd++r03g7O3s66xtder1PXlrw6qzqBiJ44TVLxDPAYFeSeg2XOXUTGHBTp8kErdZEVeSwmyE5MF
 KTOs2HWRgc0BljjhpDNNiY6cDeeMzR7ud87ABITqBeKk01D9Z2yl9F0emGZtcgIyAkirbpUIySF
 ClJu3bmS3GYR7/7CXsNBajvGczR2dDYLGH7ZweMIuldTtbM3gXTtYAdAoi9or934uFApUjGmqQD
 eWJSDFdBjZaLhRJmx3Jycj/aVWmUFkcvX0hEhWhb2GSfTHs49Ag+lJeWo1XSgvWfk2NShLqgjlk
 mYnYkJ0zkvKKZU16atzPyTjCvQ=
X-Received: by 2002:a17:90b:5106:b0:381:50ab:1594 with SMTP id
 98e67ed59e1d1-38f6a45f70bmr8084208a91.27.1785347871670; 
 Wed, 29 Jul 2026 10:57:51 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [RFC 31/32] checkpatches: no longer warn about rte_smp_XX
Date: Wed, 29 Jul 2026 10:54:24 -0700
Message-ID: <20260729175715.165120-32-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
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

These macros/functions are now removed.
Any new use will be detected as compile errors.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/checkpatches.sh | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index 18bd825372..3649645488 100755
--- a/devtools/checkpatches.sh
+++ b/devtools/checkpatches.sh
@@ -129,14 +129,6 @@ check_forbidden_additions() { # <patch>
 		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk \
 		"$1" || res=1
 
-	# refrain from new additions of rte_smp_[r/w]mb()
-	awk -v FOLDERS="lib drivers app examples" \
-		-v EXPRESSIONS="rte_smp_(r|w)?mb\\\(" \
-		-v RET_ON_FAIL=1 \
-		-v MESSAGE='Using rte_smp_[r/w]mb' \
-		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk \
-		"$1" || res=1
-
 	# refrain from using compiler __sync_xxx builtins
 	awk -v FOLDERS="lib drivers app examples" \
 		-v EXPRESSIONS="__sync_.*\\\(" \
-- 
2.53.0

