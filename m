Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFC8D29C56
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 18:20:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E74040299;
	Mon, 19 Jan 2026 19:20:23 +0100 (CET)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51]) by mails.dpdk.org (Postfix) with ESMTP id EF63F40297
 for <dev@dpdk.org>; Mon, 19 Jan 2026 19:20:21 +0100 (CET)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-64b9b0b4d5dso9491463a12.1
 for <dev@dpdk.org>; Mon, 19 Jan 2026 10:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768846821;
 x=1769451621; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DhAvrVI3AMfCESjjYc+suNyWxealPv8rVo2ZHb+meLs=;
 b=1oI0jmaXlty1WQ6JmglDkSxdumWma+c3B2rA2xQ8JSgiV1ASdknbdyxHjGvEea7t46
 VzouUZV8WAAWlgAwx1l6ZEC6YEi1hwLcUpw0Udz4mTM30A/lJL0RVHel6rYnjrwUljvQ
 wFKW2WPwe1b+LYJcn13gRUJRbJrWp5h5U0L6ZcXFZsx+q2TSbG+D95pWRYzRfjGiNuHW
 4yrkIeeUCpkC92sXQknj6hT9DGR13WlqrMu1CVzjeIPD+/QdiEPxcqAma2S1dcED8AZu
 XhzNQ2DNKUs9qnTXWCaSEe8f17KvmgM+v0eC5aCceXsgmZBLKFE4WpOGoh7gdOKvQsn3
 Bsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768846821; x=1769451621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DhAvrVI3AMfCESjjYc+suNyWxealPv8rVo2ZHb+meLs=;
 b=WVc84l7bybItBGLoBbgZ/KvQ3orL9kFKaR7FI72pTV4F0IGALJ+N2+uVc7gyRtsvl5
 mNb2IubtfL0863aisVdwdJLl6i6y6Yrrk+UnvuwsmgtZIv87i22ok3Z3RHACY3ji1sPa
 e4/J9U8VOa6Gn9YE162W6lpLxY1E8CUiV8h6N3857BGcVAUK6YjjqGnB8GVZBSZ/fZlU
 cXKrA4Jku+vNli8511Og2cirtXczHXKG1O3hHGzv/WaGnUcpJ9eP7UcbLPB06MNCb2qw
 R5Qxcd2sRlvCStrx4ToRgoBrJYuDh4WQq7/XmKuAzfgQNiPNMgPFth0BLGiVRSCpDH7k
 2Cjw==
X-Gm-Message-State: AOJu0YzGdfS4CgE4Ic19XGuSRTGfdrm0DbPmThV9Ouk0GMZRWPzoJfDq
 DHmnKLcsoXiQ9lHamxBmIL1nolROphrROg8mvjgs5JBzbG+6wpENuhiMegFQPKs8hrgV8p615nq
 iR4UG
X-Gm-Gg: AZuq6aKJ9xdkVZvy+V0Y9kGehMaFaUOzWAylg+1SSmAptsE50EjM/nQvKlwDNlumLd5
 +l3CukUP6zYxmiMdXw4Qq97yhN7/BYrM31MHvkmJ2DLYIYri3OhgHD2jymSIH3BT7TlP0b3dCAq
 RhW1pg6h/y6OlrMPUuVZjlSJLmpwivKhBhrm3GOCGC2kxSxnBi+560Vj5iI591Cj0UnMre7j577
 uWFRL9LIBbkxs+uaOj5JrI0BnKyA5nOz5p6/+P/XswiaD2r/n9OiRD7VWbsXUnGO6U+k9dQDsTc
 VWKPSOZN5NsaCkdB+vihdeQkVNdL3pCP8lpTtE4oGOZCTRTNERHwu4OzprZxML0IWc11zYo8dO4
 ypSu7VpNKYst79fjCeeRtzZOPUWayKQ5U+zqhAZlkd7rAbzCwp/ehk8XKKeVaan1BZKfzs99JvY
 QyDAgpB8TOfWfrgOx4FW1oKNf00pX1Y+dh7vd2d2+zNAhxT40RP/NM0bnmXBKi
X-Received: by 2002:a05:6402:234a:b0:64b:4720:1c16 with SMTP id
 4fb4d7f45d1cf-654bb236773mr9014953a12.20.1768846821342; 
 Mon, 19 Jan 2026 10:20:21 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65452cdab55sm10878829a12.10.2026.01.19.10.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 10:20:20 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 0/5] pcapng: fixes and improvements
Date: Mon, 19 Jan 2026 10:18:58 -0800
Message-ID: <20260119182016.44769-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126051218.50568-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
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

This series addresses several issues in the pcapng library and improves
test coverage.

Bug Fixes:

Patches 1-3 fix potential issues with string handling in the pcapng
administrative APIs. The pcapng file format uses 16-bit length fields
for option data, but the library did not validate input string lengths,
and used fixed-size stack buffers that could be overrun by large
comments or metadata strings.

    Patch 1 adds length validation against the format's 16-bit limit
    Patch 2 replaces fixed stack buffers with dynamic allocation
    Patch 3 handles the case where comment options exceed available
            mbuf tailroom by chaining an additional mbuf segment

Performance:

Patch 4 optimizes timestamp conversion by replacing division operations
with shift-multiply arithmetic, following the approach used by the Linux
kernel vDSO. This eliminates expensive divides from the packet capture
hot path.

Test Improvements:

Patch 5 improves the pcapng unit test coverage by exercising comment
options with varied test strings, varying packet sizes to test more copy
logic paths, and ensuring the test runs long enough to verify 32-bit TSC
wraparound handling.

v5:
  - Fix missing commas in test string array (AI review feedback)
  - Reorder patches to put library changes before test changes

v4:
  - Handle case where clang wants parenthesis for multi-line string
    constants
  - Add one longer comment test case

v3:
  - More thorough testing
  - Passed AI review

Stephen Hemminger (5):
  pcapng: add length checks to string arguments
  pcapng: use malloc instead of fixed buffer size
  pcapng: add additional mbuf if space required on copy
  pcapng: improve performance of timestamping
  test: add more tests for pcapng

 app/test/test_pcapng.c  | 145 ++++++++++++++++++++++++++++++----------
 lib/pcapng/rte_pcapng.c | 145 +++++++++++++++++++++++++++++-----------
 lib/pcapng/rte_pcapng.h |   8 ++-
 3 files changed, 220 insertions(+), 78 deletions(-)

-- 
2.51.0

