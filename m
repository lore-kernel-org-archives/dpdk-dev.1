Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5318ED277C9
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Jan 2026 01:57:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 292FA402D5;
	Sat, 10 Jan 2026 02:57:06 +0100 (CET)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id 095B34021F
 for <dev@dpdk.org>; Sat, 10 Jan 2026 02:57:04 +0100 (CET)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-8b29ff9d18cso522737985a.3
 for <dev@dpdk.org>; Fri, 09 Jan 2026 17:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768010223; x=1768615023; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hGz9Hb+lpwxjSPHlO+sS7D50eoM2DR9XI0Ma/v6MzmM=;
 b=bsHbAPw2dcDOj8yTl4eosoekP+RcLIo2Q7R9YcVIo3DVZWbuZ1JR+Kx9znAd1vwTmn
 T6Bd/EYxJbBsT7RFWyLkEOQGaAfg4bJ62OnQQFB8YWzeyWdE5pfIBuQcTitIR3ebw32w
 p0aIdAc59hRXkqCvZRiZrxv1In2VgBXxrQPKYQ5etdPlEZlLEwrF/SNVbVrWNFlYVrm+
 TMtBG8veMHKs9zJC/j0hhOfFSkt0CFhJvyX82m71dAArEo+pWJedYte5K5n2ws8sTfsd
 zUP4C/8Vft9iuNK9DKja9OZhvWTYj8JNvcs6cOtmAZsyDKdBQ0pQRgzKMKxvluudanEN
 YqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768010223; x=1768615023;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hGz9Hb+lpwxjSPHlO+sS7D50eoM2DR9XI0Ma/v6MzmM=;
 b=Hy/FxuwkEdelHdg6R/YT0BaU3YAvvsSiOtVRz56UHpGTofkY50Xn9YWifIKD00a99T
 t36X99IVk84EK3lG+pUmQUYIe4XAiW0jsKIoXANCiALY4tmcqGJoxdmcCpj+/ibwCt3D
 Zv/ZFwSWQMZiU/LcPlscs888Wv/DlIO5TC6GehguuU2oaRpP+a71yZyI4k2pkW9xUq0t
 Nw12f9nDq0aV7m4WYoTxWnfVu6xxOOwVD/QAqysXF3MVPUgNqOeUM+5bSP1Jipy51yB1
 +C++XPJ4NTZaoCNonIJMlSk7ViZqwc1r4MObQJGCyz5TZGs0wx3ctsnj1KwPPaOwcuEE
 UWQg==
X-Gm-Message-State: AOJu0YzL3KIeQYcExnKnclr/Ss1ofx+AOdMkxfUnQW4omEUThytbRBZ4
 WuXLMLyypq5yeZO6xjlRttVoP1tQzEPEU9GioVXJ/vJET8+xzW/ijwl63RBjAQ==
X-Gm-Gg: AY/fxX5lXweaEZ4EL7aWQbuiv6324dWvEPzKgn5CcmMmxczJ/KCelFKtRdivcGwTAQB
 16Kl7+7WxbUkd9okHcuQcpEzO6R5VydqQGqs7tdaSjPV5FQAQ9aYhhxNbxXwkn9JTtiGJp+zkKn
 tcNCpFJAaY3EIS26NNGv1LHJ5gXQh1WeNM/v0jOFYdQQOZaCxgfgoEN170mrLoUpXx2+AjI0XnA
 NhfU/EWWdMzZozirFKc03Dd5D9bE3FTlEIB1IWrbpy+Cbt6s34ndgnrCfCl3a+gAkCq7Mo6q/E+
 whQ1BhNHuuEFA5dNjC5XbzxADp5kq8z7ZOgbYWNFAvzHXDqpGo1r9ybdwvTpeXcNrK0Et6+00YW
 40r7QueEpt6zUm9yooJRYaHHpDbnT3A1XDOgxbgeCceR8otC28oLIGyBEzNleahyRRQxuC3GLwM
 zlhg+58Jf4XR8MPS909A3U5EmcSrD+2+bKTqgcVBTMTrg54mmhwn+4Fq3GLQ==
X-Google-Smtp-Source: AGHT+IG0y76zIWSMkV/1zpl/27qHGIREDC4ade5Gvr9pl8AIbEr9tXLF94mWasJ4tf4Pp4x4sVb5oA==
X-Received: by 2002:a05:620a:2a01:b0:89e:f83c:ee0c with SMTP id
 af79cd13be357-8c389417b88mr1697532585a.74.1768010223167; 
 Fri, 09 Jan 2026 17:57:03 -0800 (PST)
Received: from st57p01nt-relayp01.apple.com
 ([2601:182:b80:6a50:314a:3f86:1924:bd42])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f4a6145sm939379385a.5.2026.01.09.17.57.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 17:57:02 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v12 0/3] net: optimize raw checksum computation
Date: Fri,  9 Jan 2026 20:56:48 -0500
Message-Id: <20260110015651.26201-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

This series optimizes __rte_raw_cksum() by replacing memcpy-based access
with unaligned_uint16_t pointer access, enabling vectorization in both
GCC and Clang. The series is split into three patches to clearly separate
the core optimization from compiler-specific workarounds.

Performance improvement from cksum_perf_autotest on Intel Xeon
(Cascade Lake, AVX-512) with Clang 18.1 (TSC cycles/byte):

  Block size    Before    After    Improvement
         100      0.40     0.24        ~40%
        1500      0.50     0.06        ~8x
        9000      0.49     0.06        ~8x

Changes in v12:
- Split into 3-patch series per reviewer feedback
- Patch 1/3: Core optimization and test additions
- Patch 2/3: UBSAN alignment workaround (separate from GCC bug)
- Patch 3/3: GCC optimization bug workaround
- Reverted len & 1 to len % 2 and restored unlikely() per feedback
- Renamed RTE_SUPPRESS_UNINITIALIZED_WARNING to RTE_FORCE_INIT_BARRIER
- Applied minimal changes (no refactoring) to existing code
- Deferred hinic driver refactoring to future series

Note: Patch 1/3 will trigger compiler warnings/failures on GCC versions
with the optimization bug (GCC 11.5.0 and others seen on DPDK CI). These
are resolved by patches 2/3 and 3/3.

Scott Mitchell (3):
  net: optimize __rte_raw_cksum and add tests
  eal: add workaround for UBSAN alignment false positive
  eal/net: add workaround for GCC optimization bug

 app/test/meson.build             |   1 +
 app/test/test_cksum_fuzz.c       | 240 +++++++++++++++++++++++++++++++
 app/test/test_cksum_perf.c       |   2 +-
 drivers/net/hinic/hinic_pmd_tx.c |   2 +
 drivers/net/mlx5/mlx5_flow_dv.c  |   2 +
 lib/eal/include/rte_common.h     |  23 +++
 lib/net/rte_cksum.h              |  15 +-
 lib/net/rte_ip4.h                |   1 +
 lib/net/rte_ip6.h                |   1 +
 9 files changed, 277 insertions(+), 10 deletions(-)
 create mode 100644 app/test/test_cksum_fuzz.c

--
2.39.5 (Apple Git-154)

