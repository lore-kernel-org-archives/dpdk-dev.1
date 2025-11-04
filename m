Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768EECCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 16:08:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67DAF4028C;
	Tue,  4 Nov 2025 17:08:50 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 4CF0D40269
 for <dev@dpdk.org>; Tue,  4 Nov 2025 17:08:49 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-340ba29d518so2919490a91.3
 for <dev@dpdk.org>; Tue, 04 Nov 2025 08:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762272528;
 x=1762877328; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4pnusFJWbUA7akTLnc4fKN5DebXBS5DQ+3l3hgPBpHk=;
 b=k9LBVAQcAsj2vtER3qEkzuopDc4VqT6hK+yYnS8w6nAEWRczCiuuG/rsO6Cn9mFpld
 LGVbK+MwbMgyiRZbEPUUuCCmez+EB4elLSPIN6PQtxTYxMb8e9ARblrwPSpIsRq6/gUQ
 Q8l31TzL1eFELuDOc04TPb6bVorWod3JKmyHvrhUQB7UQeJFMzkc/+0lfZZlQhNWGoR1
 atqd7PGS503mbolLtI4qjyR4DdHZj9hhXRNjk2EJO3LdX00+o5OsyOY4w4qoDtjrq0BS
 iSI5XCplZfa1058Rz4cl32uxxArTNafQJUTLl79gg2vO6a9uHMluY+qcx9w0GB0WEKeL
 LfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762272528; x=1762877328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4pnusFJWbUA7akTLnc4fKN5DebXBS5DQ+3l3hgPBpHk=;
 b=OAhmuGOWWhXIuWdiiuEakAeKs6ISHfQZyG7iaqOK359h/isUVUX7IE6mZY0BALmSTF
 QNwGtOkQ5izVrwQzMAqKtHTj4kcfHstaxfyhS5bQSRSLMulcIaqVvbg0AGi7kocIMV5s
 CgSUhSNk0dQ1K02RMzBtIF4bomrKTsGo7qjaLcJNmNSv7dPWnIe/mdNgdmAvzOHgY6dW
 8VZe/jnXojFM8owGjdbAZsHab9I2cV986J9tcuB4kQfLuMQsaahQHN3w5gCeGHr9DW5v
 GGp3K9ksbQqXgGGQNDs3TN3mfj0553vmpjYjseIYKzpckc5GGKZPMmBMYkYoKLs6oeHk
 eLAw==
X-Gm-Message-State: AOJu0Yw+loAECAa43PISm5ASDtHUDW9bkYQKBgf54dYOpNzmmb9orzRQ
 +UytMwdc9Nf5mFVhhHY3Tp7d9skWR91VtiMxitbVns6rZbXwiAF0TB99Tu3pdqSNV9fQnN+r6tm
 1rUkk
X-Gm-Gg: ASbGncugN9jr7a78B1WzSk9aNz2B2IAcQ5qfxT/PoSAFIjMWbt/UjpUsu64C9Dke4K+
 gn/r8y6QNNdGR0VraYLMm/iPxJoOkickphUR9fSpT1WXS9w7uM/DtGcbrOFnn7wurLFB2BAEruz
 v2QIRZe06bXDL3vOEeFyoY79g/BJ4zrXDFZCtlsbIo6UsyeMOmuPQ6ikncOE5l+EAaoZnGdTyLO
 1wc9yXSADPNRMn2/ln6vVA+HKu7yJD2wR9BMSi7RnPOMsWPWvy77lkSnLUM8/SvtCFpDZV+6l3H
 PuvkKimAkjNYpdWSA4tNKd6QrlA2Uu1o2wmUKGGSet6K/+xHfmQT4/0kE5qAjUM/Dl8hUSHBswi
 AV8vMZWPqZjkOU0XhEK4NvZP+bJ7CH+2x4heo5jebDllACv12/OUTxGCfLi62Qi1a8fnW1dHgJU
 Xnr6ZwXtgVy9WY2Pr4XyfqyXXzovyUkrLP71E4T2c=
X-Google-Smtp-Source: AGHT+IGU8ErDfmjghtBj9GCzA/ZJ4QHJ8Z+7/wVzduD1chInDJXIMrTGSU1lGmJJfcv1AJPzCiY29g==
X-Received: by 2002:a17:90b:5350:b0:33e:2934:6e11 with SMTP id
 98e67ed59e1d1-34082fdb7e5mr23570048a91.11.1762272527826; 
 Tue, 04 Nov 2025 08:08:47 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34159941803sm5084800a91.6.2025.11.04.08.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:08:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 0/5] BPF enhancements
Date: Tue,  4 Nov 2025 08:07:25 -0800
Message-ID: <20251104160843.304044-1-stephen@networkplumber.org>
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

This is a series of fixes and tests for BPF functionality.
The new tests for Tx and Rx filtering require the infrastructure
to build a bpf program (clang) and the tool to convert object
file to header (xxd). If missing the test will get skipped.

It is disappointing that there were no examples or tests when
the code was submitted.

v4 - review feedback - use alloca instead of burst to remove dependency on VLA

v3 - do not depend on xxd -n flag which is not present on older versions

Stephen Hemminger (5):
  bpf: add allocation annotations to functions
  bpf: use bulk free on filtered packets
  bpf: add a test for BPF ELF load
  bpf: add test for Rx and Tx filtering
  bpf: replace use of VLA

 app/test/bpf/filter.c    |  53 +++++
 app/test/bpf/load.c      |  62 ++++++
 app/test/bpf/meson.build |  53 +++++
 app/test/meson.build     |   2 +
 app/test/test_bpf.c      | 451 +++++++++++++++++++++++++++++++++++++++
 lib/bpf/bpf_pkt.c        |  15 +-
 lib/bpf/rte_bpf.h        |  11 +-
 7 files changed, 636 insertions(+), 11 deletions(-)
 create mode 100644 app/test/bpf/filter.c
 create mode 100644 app/test/bpf/load.c
 create mode 100644 app/test/bpf/meson.build

-- 
2.51.0

