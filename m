Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0B6D1951A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 21:06:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3ED1402AB;
	Mon, 26 Jan 2026 22:06:23 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 65DD6402A0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 22:06:22 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47ee9817a35so37983435e9.1
 for <dev@dpdk.org>; Mon, 26 Jan 2026 13:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769461581;
 x=1770066381; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nBYxioQ6aHV7icBLXW3cm58ack7TI9HqAl17Z+XmSfI=;
 b=SJuKgYfjvRkaQEGIa2xkTyq6JIi7/xUgxc9yh2PWPo2jRP/nmYXH/thLeN85glLZk5
 TqjvQki/WDyuMfswolBhApyWSvJISXvb9x5bmZxgr+WCEFD1MeRLZ4Ir+AUhrbaWe5Ky
 mSFKzNBeHGpwzBVpVYwdbBS0+zRHNhUwCzgiCYLaTGXsWMiM9MM9yIUmwgFqRGCLcVnS
 mdx2Z2doKylG1Gznf2Oh+X0fokRpqBXb87wsCunf0MBXEHYGYI5kiksEbX69xVx0sm1/
 5s3vay0ntDsmtyD3lbNujhuh6do0mNUNxEMl8lRC9Q4HKsUnRL0WGkeH0Ns5jRjbEYBg
 6e6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769461581; x=1770066381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nBYxioQ6aHV7icBLXW3cm58ack7TI9HqAl17Z+XmSfI=;
 b=ILekAurWDWEjy168r6guOfqe9I34jmR4/DnmI3lJGTUEeUTuLx+kNH3I0gvdcOSbnM
 9Hm3pu4RSK//e7lN5bm5VtCvKeNsjbmw4qbR867lfr02vXmtAc7XluoBWlEr0Vc7Pxzv
 uT8OMZ6g6DBhwt5TiB1ur1WjSDHDx6tbEHIT8hfbWyoTGVfE23o2s/Hnv9r6jxSSKtiC
 1c73DV/EH0RaaN8LP/8LfByFytbdpEdijEfKQ2+bFU89PrgajT45Cpyp1ADnLCq/rJRO
 tXyTuKFBwDrHcuzbu5/rLyZHgN5GkoAf/sJ4VjjdJ1wvDPOEwCIzbBkY2Ob4JmZ6xbOz
 iMCg==
X-Gm-Message-State: AOJu0YxemnKIvsswtfmnr4ap0QKrEaIK51qdPsyZZTGmUFrKBZfcCbNV
 dXmEYMT074Hj6XuO1YikBJhQhDDLkJ9+FL5DCrl6dCcpq7Bu1QJGBXlXnJNonxPqBYptoS7qDX4
 2hYNk
X-Gm-Gg: AZuq6aL9RcHAIDNtfUzCZCs+X9TTOpA0AUbTsCZmUlpF50EZ+mZeJF8/wNSHM3k2l/3
 cuEJf/Hdfy60QlVjOIKr9UOKGN9HuhXy9YhDRkvaLZIe6vHcSszohkQHmoqzAmgh1YNGYdxg2By
 Xg7VbINu6UKPiXYVgUAMBLN70gQ5VTYTOONSZcRZLP+1xYYqWRCr2YogTjvxO98Jky1Ji4JFfms
 5XMDYzRJYGZjoRT5AolrNEcH0Hf+B5FPJoLMZ+4rMW7gqznwmGSKz60BJGjECgL/C0IrgmAQ7ZG
 SmCzb45Z27tR4+im/6ZoGjRkPkKrYmcBqmp9fjH/z+COLlUFEi0dufvU7vjpe09BvaKyQ94ks5I
 BdvASg7jGyIrdNr8wQ7LUwNa0YeCIoH2h4EqJUmY5dxuwP3ZSG6oscLdO2Q2Pzpp/qkkbromD0M
 hLJEyKCvDBKvs0QkLukm9i6CAb1m7JsBsR3+/KDIxiJBt/VtzKjw==
X-Received: by 2002:a05:600c:3e14:b0:477:73e9:dc17 with SMTP id
 5b1f17b1804b1-4805d06dec2mr107907595e9.35.1769461581457; 
 Mon, 26 Jan 2026 13:06:21 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066be7704sm15166915e9.1.2026.01.26.13.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:06:20 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 0/5] pcapng: fixes and improvements
Date: Mon, 26 Jan 2026 13:04:33 -0800
Message-ID: <20260126210615.175816-1-stephen@networkplumber.org>
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

v6:
  - AI review feedback
  - Simplify return value documentation for rte_pcapng_add_interface()
  - Add explanatory comment for debug-only validation in rte_pcapng_copy()
  - Adjust test comment frequency to 1% of packets for clearer intent
  - Add comment clarifying that zero-sized packets are acceptable in test

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
  pcapng: chain additional mbuf when comment exceeds tailroom
  pcapng: improve performance of timestamping
  test/pcapng: add tests for comments

 app/test/test_pcapng.c                 | 147 +++++++++++++++++------
 doc/guides/rel_notes/release_26_03.rst |   3 +
 lib/pcapng/rte_pcapng.c                | 160 ++++++++++++++++++-------
 lib/pcapng/rte_pcapng.h                |   7 +-
 4 files changed, 234 insertions(+), 83 deletions(-)

-- 
2.51.0

