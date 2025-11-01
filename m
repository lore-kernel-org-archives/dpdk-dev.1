Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0556CCFA00
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Nov 2025 18:07:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C218402D1;
	Sat,  1 Nov 2025 19:07:05 +0100 (CET)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id 3265E40261
 for <dev@dpdk.org>; Sat,  1 Nov 2025 19:07:04 +0100 (CET)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-78af3fe5b17so3142470b3a.2
 for <dev@dpdk.org>; Sat, 01 Nov 2025 11:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762020423;
 x=1762625223; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0KSFZFqzYjSCeAKKZ7675WKpw9N2xk/TLUgQVGxjhLk=;
 b=eRwrkZlL7PwE15CcHS06jojgTw+6ybFyEOth7AzWudXSXfSOtUyIYNCpUjd7N/TtOk
 6I0dQlbwVNE4Jw6fLKsUQ+v6xDUZjAeEBCIE3YDVe9siXQ0BHnFGZ4IJLu3NpD/lGR5c
 a6/2stq6YsyGcH0NsE6CUqp8YZ2Lo1MKejp1EIsI2jT/EN6UltktIzuQZ+31je/LXIaF
 y0eDlX9BTYIKv5V3ugmBQ6jBhdGgnG0JOAgI/ycpbAI5TBOUSL8PHP0xRWdvvRBghLtu
 T/5VexSNdwZY52EhClSd/A6yVNHYWx46S93yqKsoAvwREftuZEqlW4JSmQjcXXTjdepM
 eInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762020423; x=1762625223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0KSFZFqzYjSCeAKKZ7675WKpw9N2xk/TLUgQVGxjhLk=;
 b=SzgSTK0Ec9s/9S58Ilgf13w+kkxrUDt7MRhSgCQckWAj7r/5MaJvGQHBOmPcm0uN/J
 hTN/4G196Mb8U8Z6sTloiocqvVQTuxVkRO0znz8KriubNlE/jak3pL6n4TVqZ8gPtURg
 RLeW+Phtg7Wfn6R9vLR8o8fHXOARsTMcAf5qUMZJXc8REfNH9NMdxNHN2zi7Z1zaqrjs
 siybrkVaFQr2bHLKMf1fGQS/4n4/CIa1JLij/CqEjCyekvYfYJDUu0njlHTXnshq1Ce3
 VBRVumQPsyDEL3yLjGckeXdm00XZL7pgVFi3vogZCawfF2SXT+0p1F91mSx3pr0FYLKs
 qt1w==
X-Gm-Message-State: AOJu0YwZ3pxNBaAnsZ9cSwGSx4IRYxe7TKv2GY1GKSZX86N4+x2t4IWo
 FcQhDXUD2cAEH7Dr4rQgOfmLacygDri1Q+/ChgSIaacFNQP1IwPaJdXSFa1dcMNZc2zN1q4oPdE
 InSVU
X-Gm-Gg: ASbGnctQh3zoYX6DExoI7DnXqLohFkGVqczjkFGl2oovjKMLCUT1Hxj+I6QPGOzbbg3
 IK1djUKavblOuqb4W5sOeEe52mmhQ4j9r52mn/WCzWmF4/i/fpe6PX74NzQA8q+890LjBN9gzSC
 YIl8BI63QhbW/lOrSmaWbaFrxDlJYXPXuK6d9fgczc5EbV1SiiATr2iBu8DbnQq0nN2xf3xGllU
 TQqACEtftuES13Lmxqqc9be2cvf7Jh3CCMnbrUXbu68dxCsqZlHYYnfFemy39cLuDAYRovOS9Fj
 hHZ0/5W++GaEFNNQzMO+tWlULM+mknDdjlP3n3ZfK9nQstKwC34I86ypDSDaQv6ufzu8hOrhAZ4
 HuxzpTwuslvWin2GzrSWjgrsbA9ceJSoljvfEp6MajNRhraIGs/IQ/3cGQK4Dfw95PScQHhjx1M
 vrfvKnVCvnHSkBm0m+IyReBaq01EeRMER+nQjNisI=
X-Google-Smtp-Source: AGHT+IG5p2m6Okm3EPiFW+uvfNLda9g4hoiAg2kDQ4ZYpKEechfVrtQdkDw81Q94vMghoIMs/pMGOg==
X-Received: by 2002:a05:6a00:951a:b0:781:171c:54cf with SMTP id
 d2e1a72fcca58-7a777760e07mr8920118b3a.1.1762020423236; 
 Sat, 01 Nov 2025 11:07:03 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a7db0a019csm5861606b3a.42.2025.11.01.11.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Nov 2025 11:07:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v3 1/5] bpf: add allocation annotations to functions
Date: Sat,  1 Nov 2025 11:04:43 -0700
Message-ID: <20251101180659.43883-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101180659.43883-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251101180659.43883-1-stephen@networkplumber.org>
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

