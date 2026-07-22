Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16832C4453A
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 18:33:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F13E940270;
	Wed, 22 Jul 2026 20:33:56 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id 222F04014F
 for <dev@dpdk.org>; Wed, 22 Jul 2026 20:33:55 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-c9b373d5af0so9743380a12.2
 for <dev@dpdk.org>; Wed, 22 Jul 2026 11:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784745234;
 x=1785350034; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PSwsGjiQMj0Tq6NFrtT+lEGqLZazaThNsuC/UlCbpwM=;
 b=qXYrSyTWG7FN+QZNj1EmuGKic+E1i/lMC/RH6aJNZQo+R49WAzBOalvMhmlfxSaqLN
 emABVV+++ogEDpRZCRXgTCR4CYp8GZpgA2vuYSw5ZnQTUMiqk5Rr+cnTmZZgq6p1jWrS
 nnrflgB77XYNUljBEQSdj31XL9zKYRM+aeiIxRSZPESdzS8aYAfAFLmT8E3GS0uVZIyJ
 onK77Iz0I/7T2VXkVVuh3ca7M/T1iKhWEDIEj7q1FxI8mI+c1BnXFGOmzHz0qjGePVnU
 sCM4dKN07Ak4p9S+LkeXES8JouGVdtNbkvA3JaPnpPe774CTvdsUhi1GOnA9UCoCLMvY
 kE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784745234; x=1785350034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PSwsGjiQMj0Tq6NFrtT+lEGqLZazaThNsuC/UlCbpwM=;
 b=Fs7JOcMpbYHnWkTPNY1cpr+XijVr93F+7hrescQz9jC/pW7UNR1b4ihhPE4U2ruCOL
 4+87LaRnWYFtFm49qcoYxHB8n2i9W32qZa9dQ4IoGj+JRu1X2Ak1QaMKbGAdun+p0sx+
 SjBKRKiBhMNXUP8wXbPQunp8JyqH9nc+BX09MPOPmACRHlt0hCSnm3V8pFGQegAUDZaV
 6C23KxwbnG6m8JRcnUjX27clVcKGCMwj3BTWsRR07UxI9gFZDClchwmS7DAz+QYqn//G
 76cVzspcSZwCbMCqb8IUabwc1BNJAL7T3dcAYcQKp1a7S5qi0gobovIwog1N3aMcGjun
 p42A==
X-Gm-Message-State: AOJu0Yypl9Md7WWjVAFsc+6XvNlnb1CRGYYbVeoSroj/tnaQvqKrQrmH
 Q2AjaPtqL7iloEGifh6f+QSiJTkhuvmeCk3QFgSXwcf0BR76eZB3byICwJbmZ0gLKbsrXkZGVqS
 NFFV9
X-Gm-Gg: AR+sD13dnkp/zBqFQY30UBK6MaxDRhP+BoIoIby/+pIagFwlVzDK6fbvAFSzyjSj5sv
 eLKNFzbrVV40Sl7MSY3D6rz/gz7RBPQAnnL/h9NTk5cdN86aZSZK/FpQUNAdbmMVH35HBZ5lh8Y
 gyuRAvgDA/6wxhK9gGCafvzV/rBpKng/JXX9szeuqj36Vwr1ty7z52A67FftNLUd/1eQMpI3CX6
 qx3Dd2N1yQ1k40G7Ot6vWejj1Yaq8fTLCQEOq0aXGPf20NuvVohw9leWgD0mL9By9K3v/SaLmtU
 FWnG0ngQhtv6pYdDfgTNE8P3Hf6Tk6ZLgBM6WRSJ82PuMc3JbLoZKva8/t3AUOJ/HYThaxB+M3m
 3mayo+HM8ri4vqlogUQJLb3fdSqoevKlfp3sv0yATuSAWWJP1zapYMLz+LzI2xbJlmqBQ+HcsKy
 ep677AGW9IKi1lWcxSkF+rzuJi5LI/TRDL3b2s1xHccxOBzw3l5L4=
X-Received: by 2002:a05:6300:2285:b0:3c3:64cc:c1fc with SMTP id
 adf61e73a8af0-3c3adb05f0cmr25728089637.73.1784745233784; 
 Wed, 22 Jul 2026 11:33:53 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1c7ff4sm12227744eec.27.2026.07.22.11.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 11:33:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 00/10] bpf: bug fixes
Date: Wed, 22 Jul 2026 09:05:12 -0700
Message-ID: <20260722183351.633025-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <0260608203322.1116296-1-stephen@networkplumber.org>
References: <0260608203322.1116296-1-stephen@networkplumber.org>
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

BPF related fixes mostly related to JIT.

The arm64 BPF JIT did not implement BPF_LD | BPF_ABS or BPF_LD | BPF_IND,
so cBPF filters converted by rte_bpf_convert() could not be JIT compiled
and silently fell back to the interpreter on arm64.

The first patch fixes a latent bug in emit_return_zero_if_src_zero():
the offset of the branch to the epilogue was held in an unsigned.
A backward branch wrapped around. Existing JIT tests were never
being run on ARM.

The next two patches make the bpf tests assert that,
on an architecture with a JITbackend, code is actually generated,
so a missing or failed JIT is reported rather than skipped.

The final patch adds the ABS/IND opcodes, mirroring the x86 JIT
with a fast path for data in the first
mbuf segment and a __rte_pktmbuf_read() slow path for the rest.

Christophe Fontaine (1):
  bpf/arm64: fix offset type to allow a negative jump

Stephen Hemminger (9):
  bpf/x86: fix JIT encoding of fixed-width immediates
  test/bpf: add JSET test with small immediate
  bpf: mask shift count in interpreter per RFC 9669
  bpf/arm64: mask shift count per RFC 9669
  test/bpf: add test for large shift
  bpf/arm64: add BPF_ABS/BPF_IND packet load support
  test/bpf: check that JIT was generated
  test/bpf: check that bpf_convert can be JIT'd
  bpf: fix uninitialized warning

 app/test/test_bpf.c     | 320 +++++++++++++++++++++++++++++++---------
 lib/bpf/bpf_exec.c      |  31 ++--
 lib/bpf/bpf_jit_arm64.c | 185 ++++++++++++++++++++++-
 lib/bpf/bpf_jit_x86.c   |   6 +-
 lib/bpf/bpf_validate.c  |   2 +-
 lib/bpf/meson.build     |   2 +
 6 files changed, 457 insertions(+), 89 deletions(-)

-- 
2.53.0

