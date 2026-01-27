Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC204D25934
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 05:29:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14D2C40E1D;
	Tue, 27 Jan 2026 06:29:08 +0100 (CET)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id BDE9640B9F
 for <dev@dpdk.org>; Tue, 27 Jan 2026 06:29:05 +0100 (CET)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2ae2eb49b4bso12162077eec.0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 21:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769491745; x=1770096545; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2ttW+poCNellPsidppR0WnkDktUDbUlxzlcorPDF2I=;
 b=YcXM71OhX8QmNSN/gtO0CtQfz8/g8tEWRnZCpqV8gu5iube0jpKE+/oxPka3TZJVVK
 A77PA+sgg98zh37atP7jEN0BgGNXehdckpHUf20zKhZeoVzW5Y1WulCNiL9Xb54mQ2Hp
 4QKIzyJRALYFCV+/GMZ9kgzZqeFN8ZaEZ/gIA/weE9fq/lx2HH20x9eaIJ2fGOfqcpGt
 vGUHVctYvNZ8sRl4jL3LYsN0wiyLfLkAAL72ggFn8HUD6pWXA9HALbsrM42HIZ601+OA
 1xMvVHqWy0FXYtQQogRq9MEzjnXzrgyz6dBNRs2ials7qE6pt4PuSW6He3AAxkH7YCJW
 Wn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491745; x=1770096545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G2ttW+poCNellPsidppR0WnkDktUDbUlxzlcorPDF2I=;
 b=qVl7t/ms7UOe7ah21xUmanSX8rw2ia0VG+T+JsTdZRRFEKxJLz2dETvxKw4Vqh2jyP
 8GivmJhuwNIcTKlxagZnFdSciySF10eZNVbT5P0+1dnvg9RYSI0QDTvh20T/fsouTrlR
 Bb1gNYO/2kIo6BcoGK+l3uZR1ONT9Czn2eWYT+ttVZWSnt/nGx0Msnhfqwwfy0KZr0bd
 sf/r6Tb4km8Q1FnKLJih8uVb2UZVmq+VAusLN6+hMQkAFD77a5e/2iwF2MqW/01NjUzL
 4+PCl7XbJ20B2H6BBMgV8UCqouhbNdaBSA1CNCpThhM40bdY9RwIXUzK/np6dXhQxy2A
 aGJg==
X-Gm-Message-State: AOJu0Yz2kZU1l71jWEb+1C7oQd6Ig/Fq8BmtaYPQ8NEt+6nGy9lz/lxN
 hwe+Cxk+jljPGKiYQ+2m9FQJ4W9/EdSX/+CCQRUbQK+le7vKo5aEXR6XM3ERpw==
X-Gm-Gg: AZuq6aIZ0ix8Jrk/15NBrmX290MC5mYNagU3Q8iMDCAXxcCN/7xT/JX07iShKBohzEf
 qamyKvsJ8KhBULx1Lo9yZxepOjsOqUhEZ3wc28vrNHqQ1BkHVtgrk09RTxu8bf+S7UQC76PR7rh
 dbp9SpjBWy7pM4OAKaGyJCU31qbKaTVAmUaUeHf/I0krsF/NcqPPub46Xvv9nbwQLcEN2OHuoYw
 2f1UY0Jgb61MJeHeHZy39gBsh/bthVmm2dYpCrM8XI9iNzsZAgYMCaS0BoUn8M+4eEvq2YqySa4
 QoA7Fv6czBKZfRaK+Mv6gn2+k0PQZRvrEYAb+jn8xWhAu2B6sHHKq3LoI+vIAh+KKr8x63gmq+k
 VocYPfzXf+B8glwL1j6qfEOJoJcKbEfQMpmmBuUZbQmGtx3/mKW02APZ1+A0UQYqF7AXOJJq+E/
 7YgTxCHMMiaXXb8t20ZhorXQ==
X-Received: by 2002:a05:7301:1e91:b0:2ae:5020:afe1 with SMTP id
 5a478bee46e88-2b78d90e402mr541588eec.14.1769491744627; 
 Mon, 26 Jan 2026 21:29:04 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b73a9e1ad3sm15681349eec.19.2026.01.26.21.29.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Jan 2026 21:29:04 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 bruce.richardson@intel.com, Scott Mitchell <scott.k.mitch1@gmail.com>,
 mattias.ronnblom@ericsson.com, stable@dpdk.org
Subject: [PATCH v16 1/2] eal: remove alloc_size from rte_lcore_var_alloc
Date: Mon, 26 Jan 2026 21:28:59 -0800
Message-Id: <20260127052900.68045-2-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260127052900.68045-1-scott.k.mitch1@gmail.com>
References: <20260127020246.53057-1-scott.k.mitch1@gmail.com>
 <20260127052900.68045-1-scott.k.mitch1@gmail.com>
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

From: Scott Mitchell <scott.k.mitch1@gmail.com>

The __rte_alloc_size(1) attribute on rte_lcore_var_alloc() is
semantically incorrect and causes false positives with FORTIFY_SOURCE
runtime checks.

The attribute tells the compiler that the function returns a pointer
to 'size' bytes of usable memory. However, rte_lcore_var_alloc()
actually returns a handle to a per-lcore variable scheme. The
allocator internally allocates 'size' bytes per lcore
(size * RTE_MAX_LCORE total), partitioned into per-lcore sections.
The handle points to lcore 0's copy, and accessed via
RTE_LCORE_VAR_LCORE(lcore_id, handle) which computes:
handle + (lcore_id * RTE_MAX_LCORE_VAR). Access is expected
beyond 'size' bytes beyond the returned pointer when 'lcore_id != 0'
but FORTIFY_SOURCE may terminate the program due to out of bounds
access.

This can be observed on CI with gcc 13.3.0 in lcore_var_autotest with
'*** buffer overflow detected ***: terminated' if pointer provenance
is preserved (e.g. if offsets avoid casting to uintptr_t).

Fixes: 5bce9bed67ad ("eal: add static per-lcore memory allocation facility")
Cc: mattias.ronnblom@ericsson.com
Cc: stable@dpdk.org

Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
 lib/eal/include/rte_lcore_var.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eal/include/rte_lcore_var.h b/lib/eal/include/rte_lcore_var.h
index ca31dff6fd..48b022e84e 100644
--- a/lib/eal/include/rte_lcore_var.h
+++ b/lib/eal/include/rte_lcore_var.h
@@ -202,7 +202,7 @@ rte_lcore_var_lcore(unsigned int lcore_id, void *handle)
 __rte_experimental
 void *
 rte_lcore_var_alloc(size_t size, size_t align)
-	__rte_alloc_size(1) __rte_alloc_align(2);
+	__rte_alloc_align(2);
 
 #ifdef __cplusplus
 }
-- 
2.39.5 (Apple Git-154)

