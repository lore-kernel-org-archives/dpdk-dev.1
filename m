Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6B2CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 17:37:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 718A640609;
	Thu, 30 Oct 2025 18:37:39 +0100 (CET)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com
 [209.85.160.45]) by mails.dpdk.org (Postfix) with ESMTP id A600C402ED
 for <dev@dpdk.org>; Thu, 30 Oct 2025 18:37:38 +0100 (CET)
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-3c9c379af8aso945044fac.1
 for <dev@dpdk.org>; Thu, 30 Oct 2025 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761845858;
 x=1762450658; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0KSFZFqzYjSCeAKKZ7675WKpw9N2xk/TLUgQVGxjhLk=;
 b=AI+YUhu1VxcPwgJlbz9I5a3DmPKXdUlJEmgj6jTn2Jam1Xu7uqszRvmL9qIcGD6SHv
 5wnwVT0MO4QymdxCEVIk503+UuIjzV4NpD7f3O4x3GSz/O0ndaJ1WO4/gfF1IDOuOeQz
 fqj5GOPIXUEtLBQoIY6PlhOLkk4m6EaoqjHZiGj4gEc5g/nCwNcteegrZ/bEeXa414mY
 90y7NcjUTn246dTp+tbm8jhpUtmDh6KcsRRfvxLvIEAySSNuXMv0sEzV74kJ/wcbcXdh
 cZk/67ABTX1RgjCHxV3BxHnue7wq2O3dSEE3K3TI1OnI78+UOvc4h48OdWZZNeuPedWS
 4Lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761845858; x=1762450658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0KSFZFqzYjSCeAKKZ7675WKpw9N2xk/TLUgQVGxjhLk=;
 b=bCsfok0ZK/u14Te8aMkjVjmRMV7qffUq5VtjUrCtqcQoOUaNJgGyQ/JV39uxVxkwPE
 TNs9glOJMDWEzt0TUhMNHX7wIkmnIYRQMp9k1fysgRCjYa5TW/sFZ0RcJIYsCpzLUpAg
 KYmMBRnTvS/N4O5o99RJj5uTaCOioVCw+thzsuyf3vgXsPfW/Zcwfrpx1odu7CTEe3q8
 dWU3I6rhJxHxtvRo/kam23yXabMP43fTvHBdfIDGLZyy+ZHI2PCwCy7WayY4h/eso0zs
 i993hh36pVtrq7ttlv3B5YnqblUj654Ebn0reGtLNIg8GIno4LLcxTpe58C4vUB4XgJE
 iuiA==
X-Gm-Message-State: AOJu0YxjFm6cJcdWOH42tdOinWUu656dfXRX0Z+xCwHuV1xh0PLaubGo
 lz7Q2Cf5o7ygbKRtPvyP7m0cbnUJouxDcwILpK8vGG9ZwwjbWRM4o5kJfeLxFYhYcs03b6sduow
 /8zzA
X-Gm-Gg: ASbGncvzldzX2Yd4PCNQx1Q+bMxEK5TMMPfA8BjSZ308q+B3efLAiZZxQEIqQKsdwXK
 iKaXzk1FKIPvKKnRKm1ItPEoAWiBTA3OnrIEYDomXZpQxl2t0FJa+CSUluknhnaywEAKYF+BCMq
 LsGtlOhRxOXTEhugmaYvBguskPwXicj9paqFHSk0LgJ+mjKlU6YO8pPjwvuQWvvrSy9CTC1qDfa
 9MG7wrBBTrILAU8EcYJ6qa7dQrJ1M+RiB8ZJ4FxlCF9v3JOSOsUQPgRVvQxhcPGQ8KwfwrjxlGI
 TXSZbfY/FvbCTXKvGt7q5neLTZhi6Wr2LOh/q5gY5ZiWFlIKwMOsxuOZDb0rvG39L8YCHWD0eRh
 aSmf53lW5bm9gdMNlXznz2evMASPOWO5keMi7Xvuty0DF8iBd7RjahY+4z/TYkLA0LRoVgO5e64
 B0AlBqsCiQsX8Uuk3Qh0QSYnMFGRImXHL3Eq3Zqkw=
X-Google-Smtp-Source: AGHT+IFwZR3LTBqRhOts2gKVRbaggnkbety0jtlipC+yNEi0JLAFuY6YQ0tPF9077sRpEgebTl2F2w==
X-Received: by 2002:a05:6870:6114:b0:3d2:3429:b243 with SMTP id
 586e51a60fabf-3d8a501efb0mr1920480fac.16.1761845857705; 
 Thu, 30 Oct 2025 10:37:37 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3d1e20f1396sm6057278fac.3.2025.10.30.10.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 10:37:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH 1/5] bpf: add allocation annotations to functions
Date: Thu, 30 Oct 2025 10:34:09 -0700
Message-ID: <20251030173732.246435-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030173732.246435-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
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

