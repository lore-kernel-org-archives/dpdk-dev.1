Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0D2EF8FEE
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 15:16:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B3F94068A;
	Wed,  4 Mar 2026 16:16:31 +0100 (CET)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by mails.dpdk.org (Postfix) with ESMTP id 2C31C40041
 for <dev@dpdk.org>; Wed,  4 Mar 2026 01:34:15 +0100 (CET)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-389e71756d8so118510331fa.2
 for <dev@dpdk.org>; Tue, 03 Mar 2026 16:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772584454; x=1773189254; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sA66aF/49pGjtzci5B85zSga2zp6FIsGPhn9s26k8e4=;
 b=GT9rU84qW6JaSI5bacPKqqqjEGhArm7avrG09DiTQ2Ct7jStahM2sKg6z499yLLUQd
 ZXfXornWrsZuLjBacedEF+BK9RlPpSEBP35ydzIHvX/cdbdfXkoZAzxPWN412h2XkZpm
 XqOLMbEoOvaft+tdUnwcL9QcqFZuKfXUuRzCaD2gg+zoR8m6cFxdasJFGXnfWX+phgoT
 4ZsCr6IoosuyBA1V41QCZOqEfDIoN/4JJfjgpk2lSOdP/Rr86KppN8wsD1vWRzzp7RbA
 yxzOBT7JhT5bAkippYZFJLBEMkSninzC3SVuf72rBSrI8WRPAXJxt/QN5s0hAx4y/tC9
 e5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772584455; x=1773189255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sA66aF/49pGjtzci5B85zSga2zp6FIsGPhn9s26k8e4=;
 b=ZCe2qMBtJQoyMIieqp6rxnsd7Yyix16r9xjzCgIQ2rl3BuN4vhIY7Q+tFYCoWVqJPR
 IfA3CQzWSt4QV8TP4fWlmoXF3Xxa6Wc2PBs5fvzAeKuF8jRn6nwIK7xJoEjwnxa2lhcv
 Kz9zDA4263gWkTtVgkjAiwCRi4F90YxCIoo7T3BgTBxLrmH82wCPDgj3MimtJfDtLeZO
 5HVp/DN+O0UBbGdL/2hG8SSMuO+TXOJwIsEJeThtclpI7YP5EyrKcxow8Q/0je++CuU1
 7p9owbDhn3oy/s1tMi71tZxeDAsguKMz/W9I7F9UUSTdgKNdZeRvYvWfv7zHwdGFKe4Q
 L2Yw==
X-Gm-Message-State: AOJu0YyhbzfBGu0hVQYXoaTtY9qPbJ+ySPyvl8jDJohGW4yKorF9Az7X
 NSAB3Qy/XS3OZl150vsWE4H9teTq+7uwgt5IyRZXU1TpxjaqxxfOTaI=
X-Gm-Gg: ATEYQzwtXi1KAuYm2352Ld5RltcnuEj/tx3fbswsnmmQSD1xrJ/uBIM9vBgWljH0Mz2
 WTOio4LqR9WQv1g8nscXH7e7CTRdsu8y4wu1nOOwchxU9WrQ8oICrKEM3Xnoo8DvoDeYWG4indL
 KmeIUaMO3JcMBOBvecrZeV/A5L6nk26IdDNaOy+yW7ogA+M0mbIfR3LSTu666ioAIMCYFiPEO2Q
 r6WKUvrKspOmFhqrcuL9Bd92kA5QAIRfIWFxJRboMwkNojW0ZUgzRq8Bc2UjKxOfE4al/dXJgKh
 yhgEIX3bi9l5I0+WGjvewHPUE6kbalGIvMNNhptyvM8C8egSEl0/HfbUEJ72RXdGmM9S/k8vxM4
 B17sZEdfANnkieo7pfhU3j5l2jkXo1Iyru1AWTwsCqsiRnrh5j5LJlg/YFtedWwUMCL9vYsM6OQ
 SR76AS8lqSKpuymV6snlFtUNqtg4G9
X-Received: by 2002:a05:651c:1541:b0:37c:c84a:98f5 with SMTP id
 38308e7fff4ca-38a2c4ebacemr2570921fa.0.1772584454320; 
 Tue, 03 Mar 2026 16:34:14 -0800 (PST)
Received: from dev-debian-1.home ([95.165.2.1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a123581424sm898843e87.26.2026.03.03.16.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 16:34:14 -0800 (PST)
From: Sergei Iashin <yashin.sergey@gmail.com>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org,
	Sergei Iashin <yashin.sergey@gmail.com>
Subject: [PATCH 2/2] mailmap: add Sergei Iashin
Date: Wed,  4 Mar 2026 03:34:06 +0300
Message-Id: <20260304003406.252929-3-yashin.sergey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260304003406.252929-1-yashin.sergey@gmail.com>
References: <20260304003406.252929-1-yashin.sergey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Mar 2026 16:16:28 +0100
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

Add my name and email mapping to .mailmap

Signed-off-by: Sergei Iashin <yashin.sergey@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 6c4c977dde..85db3c11af 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1936,3 +1936,4 @@ Zoltan Kiss <zoltan.kiss@schaman.hu> <zoltan.kiss@linaro.org>
 Zorik Machulsky <zorik@amazon.com>
 Zyta Szpak <zyta@marvell.com> <zr@semihalf.com>
 Zyta Szpak <zyta@marvell.com> <zyta.szpak@semihalf.com>
+Sergei Iashin <yashin.sergey@gmail.com>
-- 
2.39.5

