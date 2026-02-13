Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36821EF99CD
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 19:20:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D180402C0;
	Fri, 13 Feb 2026 20:20:45 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 7F52E402B2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 20:20:44 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4837907f535so2624915e9.3
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771010444;
 x=1771615244; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vWzMgnC7XXlU0TrtHQHYUh0LPyIo6gIa4nFhsY4pKlU=;
 b=idPBV9Z5LafoeCCbYf1z2oFbqKVrv71VWK9uBezGsfFyCzSL+FVTtyDfxv3o22mom0
 1uTHvEePo+Ppif45HpD0KGVRzAbptfgTIgO0d8C9GHrOai1S5aVTMV6PkC1cjBzc45jw
 9vRMGBxGWyKvE9LzMOYrzylI4wHzXTOPvffIdfpC0D5oALAcMVvQARdGTl4hforVi7Ha
 R3wvi8HxkB3i60YLajZjA8dT8tljtFvfYSUc+8v1M7/JSHJk/tY+9/lfbvOh13vjmLk9
 3LzBzUVcqbjrE8t4Wz1rrf413wglFw8lb9Jqus4Z0XZXwqWlhAofFbVrr1XmQoCiq07A
 CiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771010444; x=1771615244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vWzMgnC7XXlU0TrtHQHYUh0LPyIo6gIa4nFhsY4pKlU=;
 b=E5aV16jwDrGOh2hiuFaMoLrK0A4xE/i4Kc/gZuagyRWBnbrmh67SULE5p8GRJynn/Q
 Q8hs0lZdyFdrvaucO0oRsf9ZBTiKub0DeAZrSqSpaystkXoNYDbMFRLEnSXhBeaM4r4Y
 hJaMQAQMCiaufbGutKPf3G+LHWRUAqmP0YOngPd0aWqWhVm1PJ9VhGQk5AGx6dfxC27/
 9B7umllLCv9HffWd4jeEU0lw6PHtnaxJSQGUhHalt6zkFK+8ANBijyh3N4yc8h9Pa8Ix
 3mcjQc1r9iOmVIwnJiDfpPYI9FLWqpVPMpiJSvBpQ7ypCCU2T/qdJgKuiqLUdFRuNK0I
 Bmlg==
X-Gm-Message-State: AOJu0YxGrTWErfD5sSeq1tX2lTmMwCBMZLDxknvJIs/GJQMRyAXxI7/q
 WN7kRnDH9BIu93moPRamR+coXYcUj7xA+j2a01ImaBsj+xpjB6fqCBffyBS22l0dK0e7u148xwS
 0e4qt
X-Gm-Gg: AZuq6aI17etHhPl4HVVjDOF84C66fy3mlOoK5++UT7G68UjN1QmEDPh9nXFAwAAh8s8
 mMJVpauOSVn9dxnNLPUh5J3YcuZSEv3841Sy1LiNEykoKDXz6Z7n7ujOmmtkhzdvCaBs5JEFXwE
 w4Pi6W4E8+XRO7tqiL8oFFfNVvDdquVPEU8ZOUA90yEcDdY9aDqs9GzlSCcN5aMEGMuPnNK+lAj
 jWFrBrjPmL+clrJUn3pgZgW+uJZ6XZ5xhu8qwr2ZiSjXUe4279K481r99tyP+F+aoSxmgdkKYeh
 TdyFF6K8kWD5v51eor1ZXzexCjFok2Od+XXzKR2Gy5AKXHnkeyUBWf2GUILDF2LWUDM8svik+fv
 Ua96siEryi5YetUGIwuZSMV6LpE4siavSOoMNRY5FqHFP4He172nQTBk8NfEb1V7Y5j45NUB7XH
 lpFbge21UFy+DjqE7vF7hUqD7SSmZccj/jbHBScJM1dTUC+uUIkA+Po+oXRRDYjQ==
X-Received: by 2002:a05:600c:8b6f:b0:45c:4470:271c with SMTP id
 5b1f17b1804b1-48379bd7409mr5158755e9.18.1771010443953; 
 Fri, 13 Feb 2026 11:20:43 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d82sm7758723f8f.31.2026.02.13.11.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 11:20:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 0/7] pcapng: fixes and improvements
Date: Fri, 13 Feb 2026 11:18:17 -0800
Message-ID: <20260213192039.221213-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126210615.175816-1-stephen@networkplumber.org>
References: <20260126210615.175816-1-stephen@networkplumber.org>
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

This series addresses several issues in the pcapng library, improves
test coverage, and updates dumpcap error handling.

Patches 1-3 fix string handling in the pcapng administrative APIs.
The pcapng format uses 16-bit length fields for option data, but the
library did not validate input lengths and used fixed-size stack
buffers that could overflow with large strings.

Patch 4 optimizes timestamp conversion by replacing per-packet
divisions with precomputed reciprocal multiply-shift operations.

Patch 5 improves pcapng unit test coverage with varied comment
strings, randomized packet sizes, and 32-bit TSC wraparound
verification.

Patch 6 fixes the test build dependency so the pcapng test is
skipped when the null PMD is disabled.

Patch 7 improves error reporting in dumpcap for pcapng API failures.

v7:
  - Add meson build fix for disabled null PMD
  - Add dumpcap error reporting improvements
  - Update timestamp commit message to describe current implementation

Stephen Hemminger (7):
  pcapng: add length checks to string arguments
  pcapng: use malloc instead of fixed buffer size
  pcapng: chain additional mbuf when comment exceeds tailroom
  pcapng: improve performance of timestamping
  test/pcapng: add tests for comments
  test/pcapng: skip test if null driver missing
  dumpcap: improve pcapng error reporting

 app/dumpcap/main.c                     |  36 +++--
 app/test/meson.build                   |   2 +-
 app/test/test_pcapng.c                 | 151 ++++++++++++++-----
 doc/guides/rel_notes/release_26_03.rst |   9 ++
 lib/pcapng/rte_pcapng.c                | 199 +++++++++++++++++++------
 lib/pcapng/rte_pcapng.h                |  12 +-
 6 files changed, 307 insertions(+), 102 deletions(-)

-- 
2.51.0

