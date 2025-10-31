Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A63ECCFA00
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 16:44:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B05C4402DA;
	Fri, 31 Oct 2025 17:44:23 +0100 (CET)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id E9AC540150
 for <dev@dpdk.org>; Fri, 31 Oct 2025 17:44:21 +0100 (CET)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-b6cf1a9527fso1676073a12.1
 for <dev@dpdk.org>; Fri, 31 Oct 2025 09:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761929061;
 x=1762533861; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0KSFZFqzYjSCeAKKZ7675WKpw9N2xk/TLUgQVGxjhLk=;
 b=hmV4K5vyuz1dE1sZcn0Bh6WoJfz3X5Opm3XVqGgb8VwKwqukTWfniCKxo/I+P4MKmM
 moW4Hna1OfU4NVpfkBQxp8lqjNrJlBBBcmRaeJzmf5PjQWdNEntoGTkxGnbIR2L/SQIl
 Gjc9BGC5nQepkOI0mtEr0U0O+AyJN441A/Iwxl/ExxNkV+aTNcm80OI7NHCbIe6whxWe
 C7FD/TyawM+h46WyQtfgHXdi66OdfuiZTqjQZX2yNi+5w8YuQXoqzqDiJnnLCGT2Gk1a
 HkS71GzLgGHI1ayOY86vJN53ovqnRnrJnRVhQedMnDW1GjWVGujE3p4fb/FXxxGEokMt
 Y/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761929061; x=1762533861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0KSFZFqzYjSCeAKKZ7675WKpw9N2xk/TLUgQVGxjhLk=;
 b=ndVCjgICjyI1Wj2xCtodXPnAskRW9Gi0J5r5EZPj0pSlnzhiVQ/2fkr5FsSCUFz6lj
 jcJlxwGJtBl7ETmfrRSpuzVCcPWaQ4S4AKf2m4SoHclIpdFkSqQDZs7o8cmWAQRdeAtm
 8UKuVhtq8ZlpA2kJAWDfQNdtjHBDKOX/NE0esuK0yody+nanBxQ4roOWtedsmf7X2/K7
 27lj4hFIigNue2l2ZQSquG+t3iMzI7qF++XJZusg0jllWQTS3VTS8w+aMKuQXLsNldW1
 3LcL5DYs6683wDeunoFV3Izv37V57F6/l/0TcVCbAXBQu6WHAIR2y8wnvFjXvcuDR77a
 YEqg==
X-Gm-Message-State: AOJu0YyDfjmdNv5WL/aU/oInE7UgT/ye/qjtyyhJYxccvIwGcCAE4tUx
 HQQwiTiYcDNQvBDnp+BRBInM9QW9dr6FWCZlNtu7ub0DvZYWxwJI4faatL1IieG4SFOp2kUhrrK
 BK8GG
X-Gm-Gg: ASbGncvHPc8LjFOHTG3yaKIHEkrn5XW5F1X355IdCoa7sryPgIr3U4A9IlggRcM1aNI
 g5nbFFYGwKvOwBzUcLEIv+2VoIL/8d4tuemdVF6r8CnbK4wXBwnKYXBQNoFb7IRdVD9OPUUcJDI
 Lc1z5JMF1rYscyXkzVscDZ3xujy0CWHXKZ/TxM3qmp4Y7XtNelZADFFlnYvq26qoY73r68tmL74
 /5hHuRVknQQQmrM/f0PU5bzM5K6dRKCyQ+2eZdVc1xU1Z1uf9jDolEpQyhcXiwpzyMDNWr03S+D
 E4SMu/NAt8FjvGhJa7VQjD91AXM0Atio8LQN0d5Vh0CdVp76Jl+utn4ZchVgIc1/N2bsKz3EFMY
 XbGKiA/Kh0JR228vKz4fdzfNWDg5ma93Ewc8cGQd9GT27r5mGkCtQb3oANfaqcxoP7zcuyjAALO
 kniHTazvkd73Gkcq3WD58e+YeLAmuye1D0MF9uO5Q=
X-Google-Smtp-Source: AGHT+IGg/25Hjb8H2sBxn+UWXxSFUhoaSe6dpO28LXasHllchkyIQSTl//XmfaGPLz6vvx4fyAAY4w==
X-Received: by 2002:a17:903:38cd:b0:290:ad7a:bb50 with SMTP id
 d9443c01a7336-294ed2cfc3amr96525945ad.27.1761929060989; 
 Fri, 31 Oct 2025 09:44:20 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-295269a8ddcsm28391845ad.91.2025.10.31.09.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 09:44:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v2 1/5] bpf: add allocation annotations to functions
Date: Fri, 31 Oct 2025 09:41:45 -0700
Message-ID: <20251031164417.14166-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031164417.14166-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251031164417.14166-1-stephen@networkplumber.org>
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

