Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124EECCD184
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 20:41:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76F9B427C6;
	Sun, 19 Oct 2025 22:41:14 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 1506B400D5
 for <dev@dpdk.org>; Sun, 19 Oct 2025 22:41:11 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-290dc630a07so16276235ad.1
 for <dev@dpdk.org>; Sun, 19 Oct 2025 13:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760906470;
 x=1761511270; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0KSFZFqzYjSCeAKKZ7675WKpw9N2xk/TLUgQVGxjhLk=;
 b=nOlNhhoIk3vj1cEvD5tvoqtgGgw3rAonebPEotCwSE50gEpy3IzQBxxKhHGDvhIRIO
 5pPyO61/eFdeA3/jo6tlmY1e40VwJusoCcJGi7CKRysisaGp/PIFR76p9VJZPHHZYYWJ
 AVLEMWRO9KhWKz6TWxqWMz57AC+DKpX0U3bqFTFaQysBNFD+F+tmoULjGGLngnw1rxXN
 WSfP6vZ2Y8nSFtel0PezJdnamPiZvoyb18IwJSM14Oh2yi/QygnBaEUc0mJ268rZa++L
 3xHc88f9rcqa/utewtyc32JgpHT5CIPIEyEWs1lt9xUUxpEB6jeQkM8jLI9Wv14aDEWe
 QN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760906470; x=1761511270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0KSFZFqzYjSCeAKKZ7675WKpw9N2xk/TLUgQVGxjhLk=;
 b=aFHUiVqMgMtEcnwLe+0LUBW91PLjeRjeFq8xUhOVMx+a8hvzRQr9zHEzZuWIk71/GV
 SOzfnbT+W3wuTYpyHECAWX7ZmxqPAbE5ZKcSFZTHldGgSXj2Kn3uYg+cqAQLg6MtP2QY
 pNSFx25iOhgo2VOJfIqugpGDBuUCxiZJijsPvKTgni9St1tiWm8Fb/jpbiM4oCk6y5nJ
 yz0Q6j3zgD/TaY+8eoV1Hw8v8yel5hv6mEIyNmzPACe4r3sLq1AF5loGeIL2ShE/ILxV
 3K6tSlSWZtFOVd+ymeC3P/DnZOZ67TKys2SptdVGKC3zzpxWSVJRfqSA7EHbHgFEzTqh
 IHHw==
X-Gm-Message-State: AOJu0YwbLegr0JPsskW/BI4wGnf0otq2VgJoB6+X/ioh1UvBGlOCey/J
 /4OwFK/iRMFiFjGhH2gg/oNEKP3AEsUSgsg8QMbJ9UjhcZ+6V9SjgbIDnhioiuQeojgaUgv4HDE
 7NuFc+IU=
X-Gm-Gg: ASbGncsyl6EIRwYhpQb686DWLup+xkbksk97UkHn1yUhmiNIJIO9f7qjL8RY7OWkLcC
 DSx+9ekMQpugucF8EZor3Uk43cyK/xGy3nJDyk8vdi/HJWBNj/rUgIj5O2pVG2iIvYoilryjSlH
 tj8SxXalceuPBD3HPgxgcGi9oINiVJeEYAnszQvPyENIM/4Qif3bq3RvZ4wIYdrwV+gBjr+qHi9
 MlHN3E7fIZN4PEr9ogzIvMEuQh0zyo5b3bqOP8qEnt+ngpiv3iI36kUuhKdgamm+Bk2h7UGTGdk
 Bea023p1sQnDWChf29qOZG0DERsGTHzM/IitPnBsp/Cd1gInrmaSlX8xK9saPwdufSlaVie3ioY
 5KAzX3qpzHq3kerX99tDf6zV3749dLFuQI07HL/RPx0kFTkA+/HpDCteXH06ULs2hW1ZO+Ntmi7
 oc/Pf6ymRuhRrCQzIcvzsSDdBAvceKJyv0KbpygjGJ0uaMvuXYCA==
X-Google-Smtp-Source: AGHT+IEMUGE0m+K/RbW4zjVMtWnK1smRn0Yrn4V6nWHQGSef/xeEUkGiAIXwz1rbwI2Q/wDH59Yzpw==
X-Received: by 2002:a17:902:fc44:b0:27e:f16f:618b with SMTP id
 d9443c01a7336-290ca4f9b44mr106214595ad.24.1760906470196; 
 Sun, 19 Oct 2025 13:41:10 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472194b2sm60571935ad.103.2025.10.19.13.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 13:41:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v2 1/2] bpf: add allocation annotations to functions
Date: Sun, 19 Oct 2025 13:39:58 -0700
Message-ID: <20251019204106.29043-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019204106.29043-1-stephen@networkplumber.org>
References: <20251019170040.166372-1-stephen@networkplumber.org>
 <20251019204106.29043-1-stephen@networkplumber.org>
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

In commit 80da7efbb4c4 ("eal: annotate allocation functions")
helper macros were added to provide compiler information to
detect misuse of alloc/free combinations. This covered many
of the functions in DPDK but missed the case of data allocated
by BPF load functions.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/rte_bpf.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/bpf/rte_bpf.h b/lib/bpf/rte_bpf.h
index 80ebb0210f..309d84bc51 100644
--- a/lib/bpf/rte_bpf.h
+++ b/lib/bpf/rte_bpf.h
@@ -18,6 +18,7 @@
 
 #include <rte_common.h>
 #include <rte_mbuf.h>
+#include <rte_malloc.h>
 #include <bpf_def.h>
 
 #ifdef __cplusplus
@@ -128,7 +129,8 @@ rte_bpf_destroy(struct rte_bpf *bpf);
  *   - ENOMEM - can't reserve enough memory
  */
 struct rte_bpf *
-rte_bpf_load(const struct rte_bpf_prm *prm);
+rte_bpf_load(const struct rte_bpf_prm *prm)
+	__rte_malloc __rte_dealloc(rte_bpf_destroy, 1);
 
 /**
  * Create a new eBPF execution context and load BPF code from given ELF
@@ -152,7 +154,9 @@ rte_bpf_load(const struct rte_bpf_prm *prm);
  */
 struct rte_bpf *
 rte_bpf_elf_load(const struct rte_bpf_prm *prm, const char *fname,
-		const char *sname);
+		const char *sname)
+	__rte_malloc __rte_dealloc(rte_bpf_destroy, 1);
+
 /**
  * Execute given BPF bytecode.
  *
@@ -228,7 +232,8 @@ struct bpf_program;
  *   - ENOTSUP - operation not supported
  */
 struct rte_bpf_prm *
-rte_bpf_convert(const struct bpf_program *prog);
+rte_bpf_convert(const struct bpf_program *prog)
+	__rte_malloc __rte_dealloc_free;
 
 #ifdef __cplusplus
 }
-- 
2.51.0

