Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55873E8B365
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 21:20:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3928540652;
	Tue,  3 Feb 2026 22:19:56 +0100 (CET)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id C8EB340288
 for <dev@dpdk.org>; Tue,  3 Feb 2026 22:19:54 +0100 (CET)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2b834e17c3fso90117eec.0
 for <dev@dpdk.org>; Tue, 03 Feb 2026 13:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770153593; x=1770758393; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2ttW+poCNellPsidppR0WnkDktUDbUlxzlcorPDF2I=;
 b=JAq5bzLX4uyARAkQJhn9RmpuYZffpToEr/yfZTSw498464SY2ODz6jblftX859gXZT
 htKRQa/LihBArvmtibNMSTCQWOoKCLz4M8124IkUj5Vu9o1TrYa8trDzLGb4tpFH8ZZx
 6IgoFD2/YW3u67aVd+tkOdINi9OOzPui/KWEuLVI9jPWh7ZB6s0vLCUb+lqVmJwjhE4y
 80T2KMfkGiSmfPGOnxSyHUsSDET6Nv9Z/wpe7BY/BEO1pd2N9JMjnWJEweCLUpfqEOmV
 LM+pNtPa/mFJfa9B+h/EY4zFt/MBvwMnGQFdS2AoJ2heZT4HCzG8041ek/bVrycYE7gI
 CJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770153593; x=1770758393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G2ttW+poCNellPsidppR0WnkDktUDbUlxzlcorPDF2I=;
 b=QwrT3ef6YOZNG4jey50mU57VEGqeQLx2xpIbyQJCJC3ptAoIzNr3ukSACwbHA5Bvgm
 r5Av4Cz3m6hVY/t3AfI0LPe15Fcglj61HzZfCPGOckfMM5j5kkKmpEU1kbK+RHhHmNKo
 hTc61UC6y0OLSfN9E+JJJBimgOlBsxoI/22gLmZpEk/vP2pa0rySJoReHbk5davr1RbW
 cOqtBJgSdP/tqNZ3hMR6g2PoSeaarRNAItJG5NU5PguHS99BYi0gluEj3FnoEEWYrQd9
 VLieXyTQEsYQeQBk5ZtlYleIz3yP/dQmpe+lw/qd4mT1xY4ZeuTp5R5ergEViwD00c17
 SVNQ==
X-Gm-Message-State: AOJu0YytuTiol8pSFUMdIyjtsPnBA3CSQ+cmcpaftNkFoaTzCdeUUdc4
 bxMDBFg63mvS/uzGFDWbeRndzwvTZknACDcCm+whowRyIao3vVdHYuBKUbNMGQ==
X-Gm-Gg: AZuq6aLuBrzd3QUWMDNUen7jS87fVhMQ/5+TS9e2wXIlFclJ0zA3/+ItpJ+B70raDEV
 azGOZ3rIrgva1Tw2gR2Ia3uQvm5TFeETekc8Qqd/Gglf8SlG0dXWg4vcjUjo3K6DVPDl9YLn2Ze
 i76JmoPwDFNTJGCUgr59D1kj9egRh5ZozdRGdaKhOuzqzAkKaWPHlqI8jam005mU/T2d8BznS3F
 70FqtVX/4nTxOBRwddGPJFnqHz1nuVHps+yNIT8HRhw7DwQWgOAICVyKsprCsusm2aHst4MONY1
 Fop6BME5RRsmvf7fsHaHi+Ak0XqoNujuXcMWtrXIgqDNn+qbElwJdnS6n44A3necmBHdd2Olv70
 KjjbCH0nlHhzeeheBE/un4ljPTs//mVJ/67s/2MCYrbKfobu3ramuvbNo6JA4A4sYPDzffQf2F5
 gcTYq/ZnmKp3/NU6IA9YEDXQYQRntyguH+g8DUWy3fdcy2wJk4pFo=
X-Received: by 2002:a05:7300:bc1a:b0:2b7:1008:9f51 with SMTP id
 5a478bee46e88-2b832876cdamr440442eec.8.1770153593248; 
 Tue, 03 Feb 2026 13:19:53 -0800 (PST)
Received: from mr41p01nt-relayp04.apple.com ([17.115.166.158])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b832e56c25sm406927eec.14.2026.02.03.13.19.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 13:19:52 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 bruce.richardson@intel.com, Scott Mitchell <scott.k.mitch1@gmail.com>,
 mattias.ronnblom@ericsson.com, stable@dpdk.org
Subject: [PATCH v18 1/2] eal: remove alloc_size from rte_lcore_var_alloc
Date: Tue,  3 Feb 2026 13:18:32 -0800
Message-Id: <20260203211833.44063-2-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260203211833.44063-1-scott.k.mitch1@gmail.com>
References: <20260202052442.92192-1-scott.k.mitch1@gmail.com>
 <20260203211833.44063-1-scott.k.mitch1@gmail.com>
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

