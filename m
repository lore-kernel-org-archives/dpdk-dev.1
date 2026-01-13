Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB8ACF45D4
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 00:52:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AAF1402E8;
	Tue, 13 Jan 2026 01:52:01 +0100 (CET)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id E8148402E6
 for <dev@dpdk.org>; Tue, 13 Jan 2026 01:51:59 +0100 (CET)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so3747994f8f.0
 for <dev@dpdk.org>; Mon, 12 Jan 2026 16:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768265519;
 x=1768870319; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GJPDlW8uwpVkOnOgP0b14+V5rR52JpmLdtytjf8vjs=;
 b=SpPv3xa8oNBsTgRObrASkDJZLJxg5SsB+SYqp9WM6QSG/48SsLTgVS85O80m6JkiDu
 8gtPXtobc1lOUrDzz0FGcT+CJENLk39WhTilBlooQZKH2Q9Ss7OzRkHrLKxXoxtAQ1Pb
 HLe3QCg0yzBFvEhCVQ+BlY+JJf7jfeDO+nens7jdTa/ZasqEsdl21eKNTd4o9FT7wwD8
 kKJ2IrwhtiuMtQ8h/ecpKOt4HGJyH/PpcHkr+rCZ72BkgHgVUEgiQ8lLIiMcsOZ/RRRw
 rH1o95OoKvVpGjs13DMo511piERJy93SS2oi/ghD7zipeanULyhtU1Qc5n1kGmOf8TzX
 CefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768265519; x=1768870319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1GJPDlW8uwpVkOnOgP0b14+V5rR52JpmLdtytjf8vjs=;
 b=phjgY7+ZOGrF1wogQWtVzZyaH2P16K8PXgoVUFbo9M5C1uBBGiIYswav0HKAoQMYLX
 PVC6/BK6hJzi6z0ESlQzKSX9bGgegxZWbF9+d0JCJvgH6uzHhhKwp5Yb4+DnVhxaaCdn
 e+jaRnfjihNXrG4/AVQV0iMHFOICtljzRMaSNTJPQkynfOcg1LC50RSuZtRbrcTlUqzq
 bzFuZ5XLj/JZeJCcD6h3POoNUkPhcBOjvEtxNBDCTK6GScM2AjiKJSL+BPsjF3PLmNDN
 Lhzz8molDVva6rOCkM7nKVPRP+YEenR7lFPTg8Ve7g9tMzNOhrW2qJpByqmwXgRwrhKx
 0Vyw==
X-Gm-Message-State: AOJu0YxNvaiiSS7qa/pSDJnoU3ufvq+J4u6qobfANfVNJGPjYW0ZkQij
 m4wdL8qCzKg2DlvtaPlPx2lZhF5OFiUYlfJGDmhylsxFO62Cfb95wTqGRr6d/4Gjjh+mQju5zt7
 JuDDJ
X-Gm-Gg: AY/fxX5jzIm5GyUPPyEEFy/gXqwVRFNnBDkbKL5GaXHkTlswkDMoBDHt0mUjf+dBQRf
 olAOA6e7MP8u7zQ6QdLDKqIuqXHHnif8YkZu0qUflMRGuFbxyArb/QRqQe1fiLZHUHTJ1B71bgf
 MhNujFfCtKWgiF0HsWnd1xGjIL21ZfyzPR6JElGrMPPmU2ftkMEfpKlJM25Zi2807Uydq4iBdlu
 YTNa1tRf7TxPpbVyiE+ovAT6SEQyVGF5AMQ/t7BmLRleMRmxxZ5UyxFupGbUfkyrPomLUNPhjmj
 FD96nGTZVFSklEwALFrp528kNnfj/VO9KMdv9eMp4b4Vh3ztts9Ew2Z0JT0GZaFXgtNhzIa/p9D
 N20mlYuPyNpD4xNk2Mbvp2q6p1XheqFQQEQs2Vyaobb/OSgE3wD/XdZ5OauvjB4nHJWGXzjRNr0
 FgHomQZk1tvfeCGPRdOM2ZeB18CPgdNDFLjJJZFTc1RI1ALxTJvQ==
X-Google-Smtp-Source: AGHT+IE6zyDul+Z9s2g4vP4m9oDgVa91Pq2vxIFLsENfcrXWGklI8kPwimK3yaFh7GR8ESbfRb9+gA==
X-Received: by 2002:a5d:55c2:0:b0:431:8f8:7f1e with SMTP id
 ffacd0b85a97d-432c37a6bcdmr19332726f8f.48.1768265519324; 
 Mon, 12 Jan 2026 16:51:59 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dad8bsm41603051f8f.8.2026.01.12.16.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 16:51:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 0/7] pcapng: fixes and improvements
Date: Mon, 12 Jan 2026 16:51:23 -0800
Message-ID: <20260113005154.44551-1-stephen@networkplumber.org>
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

This series addresses several issues in the pcapng library
and improves test coverage.  Several of these patches were
submitted previously in other series but have been more throughly
tested and passed AI review.

Bug Fixes:

Patches 1-3 fix potential issues with string handling in the pcapng
administrative APIs. The pcapng file format uses 16-bit length fields
for option data, but the library did not validate input string
lengths, and used fixed-size stack buffers that could be overrun by
large comments or metadata strings.

    Patch 1 adds length validation against the format's 16-bit limit
    Patch 2 replaces fixed stack buffers with dynamic allocation
    Patch 3 handles the case where comment options
       exceed available mbuf tailroom by chaining an additional mbuf segment

Test Improvements:

Patches 4-6 improve the pcapng unit test coverage:

    Patch 4 exercises the comment option code path with varied test strings
    Patch 5 varies packet sizes to exercise more of the copy logic
    Patch 6 ensures the test runs long enough to verify 32-bit TSC wraparound handling

Performance:

Patch 7 optimizes timestamp conversion by replacing division
operations with shift-multiply arithmetic, following the approach used
by the Linux kernel vDSO. This eliminates expensive divides from the
packet capture hot path.

v4 - add one longer comment, and handle case where clang
     wants parenthesis for multi-line string constants.


Stephen Hemminger (7):
  pcapng: add length checks to string arguments
  pcapng: use malloc instead of fixed buffer size
  pcapng: add additional mbuf if space required on copy
  test: add more tests for comments in pcapng
  test: vary size of packets in pcapng test
  test: increase gap in pcapng test
  pcapng: improve performance of timestamping

 app/test/test_pcapng.c  | 142 ++++++++++++++++++++++++++++----------
 lib/pcapng/rte_pcapng.c | 147 +++++++++++++++++++++++++++++-----------
 lib/pcapng/rte_pcapng.h |   8 ++-
 3 files changed, 219 insertions(+), 78 deletions(-)

-- 
2.51.0

