Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A83CCD184
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 17:00:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E73DB42DC9;
	Sun, 19 Oct 2025 19:00:45 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 4620D427B4
 for <dev@dpdk.org>; Sun, 19 Oct 2025 19:00:44 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-33ba37b3ff7so3333386a91.1
 for <dev@dpdk.org>; Sun, 19 Oct 2025 10:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760893243;
 x=1761498043; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0KSFZFqzYjSCeAKKZ7675WKpw9N2xk/TLUgQVGxjhLk=;
 b=wKWQhas+hmZ+dA2I38M66ORavJnn4jfDz/cV1fLraFaZdH34sSBySYM58D6h+krkVm
 F/cn4p+p1lzMyOuHXhCZt5aVGZoSH0dWTMxiZ+at5BDtfNUa9kCnb/vcMqnLZyKRhAkk
 1XLFYs7ERw/KgxKalmguIZ/QMWEzK2j5TBwlK1rg47i/0U3ueXcUw52ShBPXNPFpSdN5
 A7zZl3IgNKZUqdWih0p0KTVuD92PRXXUIWNppvq3iLYShRwVO7sfcvCOCg+3A9jAkJyI
 e0Msu1Y8rnuv+7Zy4kwrirbaxh8+bYD7P9d5VhaRBrJljdLJDQCNaqrY0C2b67DDlRcp
 jdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760893243; x=1761498043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0KSFZFqzYjSCeAKKZ7675WKpw9N2xk/TLUgQVGxjhLk=;
 b=OO/6Mz4RJ1XE6A/wb7IlSiIlHhJzAWdh6wshsw+P2O7ZxSPzzfptE4LuTl3fXadcSM
 8vgGyBV0tWxxfg05u3dFh3HfjYArJlo+dsUOEMZF4XfhX/7S26KzqUSOOlQKS5mqbAh9
 QDfB28kMiIlRNgqW8Oyg42m6EOf2fQxHMJ/RHp7F9WL9s+IzeD4xdQoibYjlKACRGJ09
 mGjmWOn8rylaCW7buV7ksucZ9tJAnvJydmEadyMkWkdXAbzJy/cE359a1oxCAzX4sN0Y
 N917pe52aJkb9+FZ/1hHGdgXS4YG+/mz6X46zuQjox79oJDpxuQLWrlwnvrolgbLJhuz
 vQIw==
X-Gm-Message-State: AOJu0YzLdZueSp9XEPLEY0yRPiP3qilBT5bLkeyahftrKTzLf+2voWl5
 usnwPfmn5hKevHDh4u6Gxpcw2EoUnYOAXBAkOidpWBnJPr1GiVmLUBgR43HyQUMV/2YFSXS+3Tb
 TVkDGqb4=
X-Gm-Gg: ASbGncsSXan8vCpvn6TKomBRw18OaidkWrKm4CZDryE3GxlLFi63ZTM3ZDbvInoRcq+
 jHcsQCimcl8w5L7MqCWVbbWFmnUCUazQQohqcuN9oGC6doQNetEmr8mVxXoxXUIzoDMn0VwfDMf
 lPeUdXGjE9DTR/11hKvJBB3LFtw1jQKDxeNAA6UoeM2gtKZV6D3eU0IxY6XfFS/xTS3ecAJv66s
 FzrhEamReAXBWeAdHUsfKmWNZ+bLxeh+QPU457rp1r3MA894uS8Ug8v4xPUoywT27wifT6tOIZs
 8uAzE1iQEjdxfTrhIDFT7PQlWT28muSralkjHk9zYm9sy0uM/7YwItRCc1bs2UcwSTo1fjY34gA
 3vD6giX/5uF1eOL6M8Y25PpdU13rNwR66M0pUnjXS1HP/lz1pfOcAcshHYTFrl5zGsBGSNTdWrV
 DZ8ct7umofVniB02rP+E/SYTr3mMFdxHo/Pf2q16w=
X-Google-Smtp-Source: AGHT+IELF42l6nWPfSEwNrnRolfVUp0snsKXyt1Hyv7z6j4f9RkoDnlDH9RHFe0NYa7v+Hr5C42ykA==
X-Received: by 2002:a17:90b:2887:b0:31c:39c2:b027 with SMTP id
 98e67ed59e1d1-33bc9b91621mr14884290a91.7.1760893243285; 
 Sun, 19 Oct 2025 10:00:43 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33d5d00c909sm5696079a91.0.2025.10.19.10.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 10:00:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH 1/2] bpf: add allocation annotations to functions
Date: Sun, 19 Oct 2025 09:59:46 -0700
Message-ID: <20251019170040.166372-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019170040.166372-1-stephen@networkplumber.org>
References: <20251019170040.166372-1-stephen@networkplumber.org>
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

