Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8667CCFA07
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 16:08:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B65C440662;
	Tue,  4 Nov 2025 17:08:51 +0100 (CET)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 053DC40269
 for <dev@dpdk.org>; Tue,  4 Nov 2025 17:08:49 +0100 (CET)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-340cccf6956so2139617a91.0
 for <dev@dpdk.org>; Tue, 04 Nov 2025 08:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762272529;
 x=1762877329; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3uBcwNtCgVWHj7pQ9GnroAeEcNZXl84E0aZESxoJTOM=;
 b=AMMcuXD/2EG7jjdNnkVD7B5DSfGJUR2D+BrcOfss72hcA1kuBFHWgZ5he/GW/+0F+s
 HCPXzNjNA7SRBIc0HIPgInGPDd037kVqsBm7J/57vr9UFKBEl800KlMPbLOzWLH5O6y0
 EVCbbwl6fvSfzfcX5/gG7MDiG0WA3eTMO+YgIkTas3ghk7/qkRhp1eceeEZpbYRPOV6c
 3xXk34L5DnMkbwYvpvzeSUwpu0Yk63T6V86lX1qUc5VQLNqlDw85GSA3Iv2L1RL7Dsvf
 R0FsDhVex8znC0zlAeDUk/x0zIRboUMtIE39aQhNRWV7EF/rCC3oz3INMd12T7IWWEzs
 8HEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762272529; x=1762877329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3uBcwNtCgVWHj7pQ9GnroAeEcNZXl84E0aZESxoJTOM=;
 b=CODKgKJq1L0qeseYW22EoRWQCiFFqdovlRI4TQqqcWoJzBThjkOTBSa2zKJ1tXDEsU
 vm4lit6F8SdfpNhJqNYfIwMT/gE6V8mnbFRXyH2aAjEQQbGuclIFZJj2oyHfmcgt2cLm
 q506aHiOiMk8G9jc4bC17NGVK+Qczrv4vnZjt/dgBfuAXpcEpGkkZP/BovklKYnuhKCg
 VTrwOrvlHEvl6016cLW5n5+X+NPZeP3jV9s7A1B4umYeppCROO5INsaY+gYqa8mHlEyL
 rt8W8u+dOxNc5WtpNJfUuc8usyk5OMUbzc9BZ0eoX897JDiSVIszQYojLUHfax5NBNUO
 ZWmw==
X-Gm-Message-State: AOJu0YyMn2WSvqa+Yt8Wu853bkJ46k98gVHue1njxV/Q77srEomgvxl6
 xCQtByb99D9BcTUKeB3Z745meMVaCmsJsbrXX19ff45xjfvyO0OMBn8s3obAbgUfF9kY27TTY2x
 2jvSA
X-Gm-Gg: ASbGnctQqyQUNnAIh2kMTP1yH58plFGsWnXRZ3gx5n++YtkCWSm2a6HhDnJL+dwwqlm
 wNCjXiXrVOd9nDcrQCY4KRISO26frYTj78zQC9HwYQl+rEZ/oZ0lzvN5qvg6UPx40xpiP1fxuqq
 zf7JBWLwycJoqCFClGOfbmhcDz8fve8wyYPd1k7M3OKOLiymhaC7k+5v5QuXv76Gfm7oC6dF6yX
 Ispjq2rS3kUixR7apiGGYy5Lt3w//+j7Igeha03Q14ve181TtTRZgFDbA88p2TgJjLRx4wgEiiw
 atFtjklLaOUM/7NZLbHJ66Tc1d4Pgwf2RwnfIPcqjWoKD1tWy6yUNbkRUO+qtLqH+qiniTZZHnF
 ZAxXrIpbh+sy66Ne3EODsrE1enF1/c0Xz/5cBzSCM+/L73QwX8r3ZAMt9aWwaVND+uBJ73ETnSY
 q+cd9k7OEY/hDQZ4SAyL7zjK6hd2B1+/9S7B1T9BA=
X-Google-Smtp-Source: AGHT+IE+UzrRDgSzIvtFvaml+HYmVGRcQlLc12FyZbTWv6Xj/6SEdPhuwckKj8q/GPi8LsBKNcKfKg==
X-Received: by 2002:a05:6a20:7489:b0:342:f5bc:7ce5 with SMTP id
 adf61e73a8af0-348caf8cafemr22826794637.19.1762272528964; 
 Tue, 04 Nov 2025 08:08:48 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34159941803sm5084800a91.6.2025.11.04.08.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:08:48 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v4 1/5] bpf: add allocation annotations to functions
Date: Tue,  4 Nov 2025 08:07:26 -0800
Message-ID: <20251104160843.304044-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104160843.304044-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251104160843.304044-1-stephen@networkplumber.org>
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
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
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

