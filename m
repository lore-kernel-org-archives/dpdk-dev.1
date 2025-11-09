Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881C2CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Nov 2025 20:09:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B8144026D;
	Sun,  9 Nov 2025 21:09:00 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id C88C6400D5
 for <dev@dpdk.org>; Sun,  9 Nov 2025 21:08:58 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3436d6aa66dso936585a91.1
 for <dev@dpdk.org>; Sun, 09 Nov 2025 12:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762718938;
 x=1763323738; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EvTtHoCnxIreSW841+RXRVSkOe9kMPS9XaZFdTFZGIo=;
 b=Kgdadsfbjv9S/1MX3m2Zbp0tDrfzkoDDOshBFGPYwdb+TB3N9+i6WXuTNQgHDGnXW/
 MY9s1xrs0VtEh9noO7WE1J5LT5B0GyvJHSyHlHfora5b/OwIZ8jHEfPNSBaR3MVED/H/
 ot7NnSxPrSjUfjwfYe6pgqGFpOkY3DHn9N5OLREKRxuFTpqpIpQEZI/DYp1PH0zCNtvI
 szfl76r4/TRgVDN11NPatQFX/hLptWprj9n3k1thJi/w/IFZVE0eCpdHtTJn1sJqgCMA
 U2qYpjWdfl2YSlow72AqsLNvCwIGRnxECyGjXeHqQ2AbHzzBGXfEnBgj1I0CkwYj3odY
 VFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762718938; x=1763323738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EvTtHoCnxIreSW841+RXRVSkOe9kMPS9XaZFdTFZGIo=;
 b=VREcVCrKslCwhWAFUy7TDwMxWpJ3S74sciP/vJpZA1qrwekxjtpSxX6i91+LLhmaCG
 m58WfKgmyyOUn/UNLkvgJjXceVsa3kYk/SdqwX7C908rsxGNqExV+/v6BbFktwqKh9ZE
 wq8infzI2ApYLL/l/FJINxeh0TfGWIaVgQQmOSA5z9PJXNmNEl5+kg+RNkYmabMsfGW1
 7snMRFrCgdCJiv+RW1EghH0Xwp4X8Tyj1kmsqskMDtRy9jKJ9+lJx0mHiGTpQwKhZEhg
 KK3q3ydPHNBoKOi2ouTU/jDSKxRvwzupCk1wt9kN3nmtdR85/f/easLt0+gpMYnFJom+
 WLiA==
X-Gm-Message-State: AOJu0YzMWZdElZxh9KpO0MLLqQ4no5IoRGfa9qa+DK+jx33TCDFnd8Kh
 vdWGq/3/8aLxvlc3A6PFHn1ZUROmvLmJ7E1fcbjFdVKE8PoQqavm48fHaEGx/R2RPEFjGqpiQTf
 NBe2eBLo=
X-Gm-Gg: ASbGncvyr5BEOi0y5k8s4Z0A+X77JOLZOVH1+vlVj/LAG9sGUK4jmdUrnRrgJ6M6Wpk
 UCs5rKGxgz7m5agHjuh1UwG1rFJjQNl8ch4a11K+eUqZlb7k26e5nCyND5V3zo5OLK7sCdz8Okv
 EeI5HBoQrQkeB1kwqRhD3LL8uxDL6lNqX2xfwDIL50m6KBas+ZXPp8rsn3K/2/frJDHIYzatt1u
 HuFxdGSeUT4zFF7FTl1O5E0U7YGCCcdY7afxEaA2T5r9Y39XFjiAchpPZ4d8Oga5e6h5lT4qxYE
 1mPY8ZBMKWg4gPIHLWq98fxYdj3Vfewpt87SxAyIO3WldGBVm8baFWwBqlM10o1978MQBePrroX
 DktSsZaLjcGNVlpD1sTFk0+qAWlBGJh+XOqgCUFpIBKbZpAeJ5WSgMF3DBhhDe41W7PiqID0F2T
 +Uw5rvnM87Vw2nQrEda08m0jFDkIZJgCXa91QMpEqWSmAc2cxXQQ==
X-Google-Smtp-Source: AGHT+IEA9TLtjMF6yGuDN0NIPzo8c7W4LVuKCAa3AhOmYlKxnr/g2vQJa6Kyzu0r7wpYRjizac4HcQ==
X-Received: by 2002:a17:90b:2f50:b0:340:b501:7b83 with SMTP id
 98e67ed59e1d1-3436aca72a6mr6960189a91.10.1762718937589; 
 Sun, 09 Nov 2025 12:08:57 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-341a699d6dfsm15396648a91.16.2025.11.09.12.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 12:08:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 0/5] BPF cleanup and tests
Date: Sun,  9 Nov 2025 12:07:33 -0800
Message-ID: <20251109200854.45942-1-stephen@networkplumber.org>
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

v5 - review feedback
     make it clear that load test is mirroring previous test
     and check the result. 

v4 - review feedback - use alloca instead of burst to remove dependency on VLA

v3 - do not depend on xxd -n flag which is not present on older versions

Stephen Hemminger (5):
  bpf: add allocation annotations to functions
  bpf: use bulk free on filtered packets
  bpf: add a test for BPF ELF load
  bpf: add test for Rx and Tx filtering
  bpf: replace use of VLA

 app/test/bpf/filter.c    |  53 +++++
 app/test/bpf/load.c      |  51 +++++
 app/test/bpf/meson.build |  53 +++++
 app/test/meson.build     |   2 +
 app/test/test_bpf.c      | 463 +++++++++++++++++++++++++++++++++++++++
 lib/bpf/bpf_pkt.c        |  15 +-
 lib/bpf/rte_bpf.h        |  11 +-
 7 files changed, 637 insertions(+), 11 deletions(-)
 create mode 100644 app/test/bpf/filter.c
 create mode 100644 app/test/bpf/load.c
 create mode 100644 app/test/bpf/meson.build

-- 
2.51.0

