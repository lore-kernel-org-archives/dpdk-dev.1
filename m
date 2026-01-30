Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D41E6BF39
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 20:23:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61BBD402AF;
	Fri, 30 Jan 2026 21:23:33 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 3148A4025F
 for <dev@dpdk.org>; Fri, 30 Jan 2026 21:23:31 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4806bf03573so13614685e9.2
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769804610;
 x=1770409410; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5dVXgnl7ijsNAJxPp101DF1cidunFEsqvcDpaltFnrg=;
 b=iY+e/HnOPEMZYmGkY6Hgdr2AqTfpqPPI+yi/rleiUUMpNRZ/rJ3xUmansi/q0OzTND
 qN7iF4ljSTVEPNy5x36kYnQILbbfwTLlWaKOnkkhcFwflNI7vXnZ2h88XGqwo6Q26qLo
 ofaWob4s82NFkNM4Tctt2hJOD0GjYDITr7kavSPa/fCvKUY1iOQHjSg4SbGb9R/mV9Hs
 J0qkdijZviNoFzbUo8Idq89XThFYeEE8Vs6LW6vQjQQkJEMWhgG61UvNdf0NwWV440OP
 7LCY6RIYh4kngXNRlXpAl3ffeMvP0T/8g4tKiSq2QNvuMnctE0kA6+nvUSMMO9xsAZeo
 aIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769804610; x=1770409410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5dVXgnl7ijsNAJxPp101DF1cidunFEsqvcDpaltFnrg=;
 b=ebTBE8ewo6ffrtv+qM6pSawwKPXr1kzReemNqlmCrzZU/9hE5r68aMIoK+z2VB8OVR
 uwD7fcipB4oyoeARWOzqSncrbNvZ2RYwHNG3eL5SG0op2wRtMxEzdpa8aLQlLxpn6dC0
 pX5zy5Rjp52DGaVpy4UbKcTDjzVjABqXOefngEpHQY49YqssVG1dPh11u8wMnYny3zLR
 goht8WlhiL6Ai7iUM0SZARemYiNoMp46CjpnIdknko1dAsrWGOCwwY1SyJKyIlzJ7ZuZ
 H1GON2C0MOO/sg1fNQANc+xVvGQddvJqFVy5/R4MzL5VYo7aC72qEfDpu/Nb3apA9swS
 7qNA==
X-Gm-Message-State: AOJu0YwSTs0rJFh2vmNjtrMTB1L8eKg+rEB4P4wj6HFUnSXiaxejn1NB
 7Puv7hk05IPVoe7dPW1kAocRMZfhVxMCo34rhuzPXHl/wOt3u3S4Ac6Qb3fG1AwiE2QbxYtoVrp
 QVcRw
X-Gm-Gg: AZuq6aIX4vsBsa2y6G9r/xbqKdrXjvnvrAy+oxv93xqYp2FHLWmnQUHnp8DY0RsTLxu
 bVIb/aCLX8xkPF5Jk3Zkq1ZVz3EnH7ir2BCfA3fG0V9NvZrPesHAr1kNorOlqfWv1UsNpoJjy3M
 Fbvwe9keuN5TTePtCFlBZD6O9ZbEwMktoLHazBQ3HhTxIxaBNnCMHfU6n/Kch3TAnEVLFU0V8+L
 bWKfInjrTDeb5MkIgQoQa+cSgYqMmlV04P6N79bM4EajSsNKfDhsWg68kMZ6W9YnH0LwnquAfOO
 yNyt4Tstu5AdaRudBiRHpM8UJZI6HYWh+CpsXdw9WiDfMaWImmsECAB/nheQIcTWsFHnn1AwS+K
 OgUIIblr7PkfvRqeF6OoqpFtfnNKS9EtSwPYyp66phgBINL1QGkOrgZXBsJLKWrjr4EviY9T5Ax
 WZhk+kJczuNFFg1SnF3kVY13srn8ukLYQMgDU9y2dVzOr7snxFUw==
X-Received: by 2002:a05:600c:4684:b0:47e:e946:3a57 with SMTP id
 5b1f17b1804b1-482db4b4f5dmr44264625e9.36.1769804610251; 
 Fri, 30 Jan 2026 12:23:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e04c13a2sm23799065e9.5.2026.01.30.12.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 12:23:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 0/7] Cuckoo hash optimization for small key sizes
Date: Fri, 30 Jan 2026 12:21:50 -0800
Message-ID: <20260130202324.37485-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250818233102.180207-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series improves the hash library's key comparison performance
and portability. The main goals are:

 - Hide internal implementation details to prevent future ABI breakage
 - Enable optimized key comparisons on all architectures (not just
   x86 and ARM64)
 - Add specialized compare functions for common small key sizes
   (2-20 bytes) to avoid memcmp overhead
 - Improve test coverage and code quality

Changes in v5:
 - Rebase onto latest main
 - New patch: remove spurious warnings in CRC32 algorithm selection
   that fired even when the requested algorithm was successfully used
 - Improved commit message for patch 4 (was patch 3)
 - New patch: convert hash unit tests to use test suite runner
   framework for structured output with per-test pass/fail status
 - New patch: add dedicated test for key compare functions that
   exercises all sizes in cmp_jump_table
 - Use table lookup instead of switch statement for key size selection
 - Add static_assert to verify table consistency
 - Fix minor return value issues in small key compare functions

Changes in v4:
 - Add test for more key sizes
 - Add a few more special case sizes

Stephen Hemminger (7):
  hash: move table of hash compare functions out of header
  hash: use static_assert
  hash: remove spurious warnings in CRC32 init
  hash: simplify key comparison across architectures
  hash: add support for common small key sizes
  app/test: convert hash test to use test suite runner
  test/hash: add test for key compare functions

 app/test/test_hash.c       | 249 +++++++++++++++++++++---------
 lib/hash/rte_cmp_arm64.h   |  62 +-------
 lib/hash/rte_cmp_generic.h |  35 +++++
 lib/hash/rte_cmp_x86.h     |  62 +-------
 lib/hash/rte_cuckoo_hash.c | 301 ++++++++++++++++++++++++++++++++-----
 lib/hash/rte_cuckoo_hash.h |  84 +----------
 lib/hash/rte_hash_crc.c    |   8 +-
 7 files changed, 490 insertions(+), 311 deletions(-)
 create mode 100644 lib/hash/rte_cmp_generic.h

-- 
2.51.0

