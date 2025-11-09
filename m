Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39D2CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Nov 2025 20:09:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28248402E0;
	Sun,  9 Nov 2025 21:09:01 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 1FB5E400D5
 for <dev@dpdk.org>; Sun,  9 Nov 2025 21:09:00 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-3418ac74bffso1629929a91.1
 for <dev@dpdk.org>; Sun, 09 Nov 2025 12:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762718939;
 x=1763323739; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kle0FbReQCP6r1RIFTZnc9Ju4tBNQ1WJad8zTt+X0K8=;
 b=Bsn5dVpLCY74M2OICn+hlLoGetzCjkSS1cjTMj/LIk5pFM0z4CilA1+VeprCkdrvCR
 2kf5l9+zDz+fMxNljDN55cVFbDU4uokji3BOjFTU+p8DaNgKN2s7kbl4GQDRH2gDEGLS
 tqCQQj2FGwnf9roP3pB8rXMs/n0f50Ay6Yde1UtIv7wO/+aNEh3kuX5xjSBCE6WktUG2
 /CH1gfNnwvniYFgRzXvV5g8SzV1RRtiZIgp7NHR88aQA9IRx9FF8lAL1FWt8T/hkyiJL
 fExksB3O2hGVNSLaaeZEGhZY0FUskJfidtFnvhhvf+3osNbLIOLzW6NuFkvaIex+mdGg
 pOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762718939; x=1763323739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kle0FbReQCP6r1RIFTZnc9Ju4tBNQ1WJad8zTt+X0K8=;
 b=Uxfi9HgZU7c1EFyeE40YczemRUlI7mlg5hrCb1sRFhjU9CB0OlbwTibsovcGDVSJVC
 tP4pUJC1xpmvIcpN79ewBnaDElyvOzr+OHewYZpXm3cyyP5EalV0OoYPsNT4GVbYS4YV
 8P5hQTw8NTqwpck3EzGZFqjHSbsMGTtTAzbfsnf5dqvlOA2/s/MIUXDGRmE3lSMNlEL5
 wSyg6ejeBrrIsLOMGmG2Kqyt1KBqyi0+FRWHHVd7ZYg/4ndrfloG6mo2i/DKpJlgw2Sh
 Re1VEsxJQ4TwjCTIU4TZgfv2Hl3oDatryXAlwYR0gYQnzvDU/cB3rurkIA+buMP4IKDG
 Ti+g==
X-Gm-Message-State: AOJu0YySbCJVJbyOSAuHe2ybDGnLyH+cUuyhkZs/BZMkN+kfQ9Hx390S
 EnuG9apjLBbdhoFtkVi1St6feln9shvFU2Sx51tffV9hFaxuj+HAV0Z2iUyey8zKY1pQaRBZenf
 7JoqzKlM=
X-Gm-Gg: ASbGncvLZSFUU6Eo1tpeiSgC3V4ilEPM4JCYtOprI4fqLOLb3009GaefPMXaIJcT3bh
 n7x0dRVj1pl/gbO8FQ+N1CS/k1Q7sZxS3eoxZ8UH74CW5qi2JbyKyJv2MPDJVKjPhoW27E8wLau
 j0sFWlISdxBYuDc0cmF4G+Qlu8d9u0jBKn0XmR9Kvjs68FFKbRX2C7FeilcbP8J8w8wqmBwQoi1
 6flokQrMNBZAwUi0uFkn16qWSwMyI8apTspqonCK91nwfsDHymSX2GyuHDE/nYPl0/zg07PSVCx
 Sv7Ct+qXXy8Xo6WpUbagKZgX1cJRGkSsgWlGrVONMGVVossnve2VAG895FG+7S/FXeU5RiNCOpI
 +InE3SIHVPrdh3ra0Izh5c0D4iRMn7Xx0f21dv8m7Mhi+VjR+EzpGnNV8AIt0fG7H3gx6jq1XhW
 ZkcWTM+R4lrgTXQwbZHJ0wIyQGqO+uDkqGrWfjVyPWVPOlBNGbda04k9rFJj0Q
X-Google-Smtp-Source: AGHT+IFj4jd6ADB9Ww3j6iReQADz5FKUadSeH8yZjkrgFSYDAtVaq0L0kqbeAOlyD4dLNEmgE2XB2A==
X-Received: by 2002:a17:90b:390f:b0:340:f40c:169c with SMTP id
 98e67ed59e1d1-3436cd0a335mr7172616a91.32.1762718939231; 
 Sun, 09 Nov 2025 12:08:59 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-341a699d6dfsm15396648a91.16.2025.11.09.12.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 12:08:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v5 1/5] bpf: add allocation annotations to functions
Date: Sun,  9 Nov 2025 12:07:34 -0800
Message-ID: <20251109200854.45942-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109200854.45942-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251109200854.45942-1-stephen@networkplumber.org>
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
Reviewed-by: Marat Khalili <marat.khalili@huawei.com>
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

