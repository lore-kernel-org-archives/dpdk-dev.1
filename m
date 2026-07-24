Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29249C531F9
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 21:22:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E48AA40276;
	Fri, 24 Jul 2026 23:22:44 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 0276940274
 for <dev@dpdk.org>; Fri, 24 Jul 2026 23:22:43 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-84e3007a2b7so780060b3a.0
 for <dev@dpdk.org>; Fri, 24 Jul 2026 14:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784928162;
 x=1785532962; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lU7XchfSH4yyYHvC6gQA1/mx/NfEjqetFaJXPR/E7+0=;
 b=h6+EdoXqLjzVKimUw2h43L72tbb/7EXfqMBMNNtjN8FcK+tt0FqeG1rMXjPSVZdW71
 qwG9pYULio2XGA+cR1nVkJUDAw1AOE5asrPS/S4jUjAWEO37kU8ggpaMwsDn8ATxFwa2
 xWaqS0tkcnI6D0Hyihv8POoFBcQ3etDkQqoCtmMiP0bWU883Xm3gLqsRbPrs4VYchE7N
 +wzNZS2bz+QJFqg11vJrhzZYTBepq0lF0CQvWTiUc56Vrf23OOPt9ne5tq7m81w4SJ5Q
 L/kScUzXQccx/HP60LC8E1Hse2T3RpN9mU+zn3tncuKxaMIGnIrAAhVo8lhqsQ74eQcE
 WdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784928162; x=1785532962;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lU7XchfSH4yyYHvC6gQA1/mx/NfEjqetFaJXPR/E7+0=;
 b=g1LAV6VHiqhreX6UVTBF3DcKgXbIGgIca8pF6aacdipD/RcDIPZTRD1PQ9pfm9vA6f
 uw14lYVifuUi/Xn+QdRQ4ZU7NpnI8v2Fx+rQM1dYFzxChJkuPnZRlmBfHTqqy+Dj616n
 JIUUwbyvkyQwjxY+3kuQf4n3648TJNLrSLcmsAIjecpCgKsZ3Y6FcTq+AruN9UlLehsM
 kI7Q3DVz0i6XBD3vWAP0VlD7e2Ergb/cJJSJYyc+g3xSO5ndBnMUvk8ai55c7FOilSqk
 6+CH+6zp4C4gBb040hST4EFsZfxfPpvfjeaookkYSQ9oSSQufGKKX9ZzyKuqYMTimp/C
 mKSQ==
X-Gm-Message-State: AOJu0YzKhMtTjzgclVypv3a/gwVpii3J1lS3ukb3FuzSuKRWJilPpQ5f
 b7WasW7FcGD+0BOB23ib+4SMjaQ3idKtP69EFmaqq8T5ArbKpRxx7v/KUGWc6jUhm5NvXQfPmY/
 30Q5h
X-Gm-Gg: AR+sD124UujqRde3idSzLlXvsAVlX8yXcifLo3WtVfAFuUQWO3DM4APMNUB8hB2sH2O
 0uNM1q81lL8qk29hV6lnVCUm6uzYp2iQLR7sOt11NuQhfNS04elgwcIhwv+ifIkRmWnyoW7fTLA
 vy81sNxIW/P85nqJGMuVAfCOWQkWqQvLZXCr19GIZozTxs7xohWPpmU3TCCmcsCfg+OGOiG/QZH
 FSHNM8favCMUSBrgjF6HKwW/DcLudlK+0IOe6TRxYsnhyP3HiqG8mugDXp5W5kheN0Ibau9Gbzs
 yrjylXt04VZcE6coC+2ZczrBO668aSYXWjP1tIS4z9zbHMLK9lgdDIjJZ+1RMcS2nXeRI7tj8ej
 XzB/15YM8b47WOgX5/iyNhi2dubXQm6c50oGX7Qw19PI3NhUx3/kWkqJBbTeUSN01BVkZ6lkikN
 gbwD3twEdE6dU408QRczToq3ETYCxttdHqcifrq+uu0CisZ0nli6U=
X-Received: by 2002:a05:6a21:9d95:b0:3c4:3454:38a1 with SMTP id
 adf61e73a8af0-3c67df92442mr29784637.58.1784928162525; 
 Fri, 24 Jul 2026 14:22:42 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc548efesm2612725eec.14.2026.07.24.14.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 14:22:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 0/5] Wireshark external capture for DPDK
Date: Fri, 24 Jul 2026 14:11:52 -0700
Message-ID: <20260724212238.864798-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

This series adds live packet capture from a running DPDK primary over the
telemetry socket. A new capture library installs Rx/Tx callbacks on an
ethdev port and writes pcapng to a caller-supplied path or FIFO, with an
optional libpcap filter and per-queue selection. No application changes are
needed beyond linking the library.

Two front ends use it: a Wireshark extcap plugin that makes each DPDK port
appear in the Wireshark interface list, and a dpdk-dumpcap.py for
file capture without a secondary process.

The pcapng interface-statistics block gains a filter-accepted count,
which changes the rte_pcapng_write_stats() signature.

dpdk-dumpcap.py is not installed yet, since the name would shadow the
existing C dpdk-dumpcap.The long term plan is to remove pdump and
old dumpcap code and only support this new code.
Will take several releases to stablize first.

Stephen Hemminger (5):
  pcapng: extend interface statistics
  capture: infrastructure wireshark packet capture
  test: add test for capture hooks
  usertools/dpdk-wireshark-extcap.py: script for external capture
  usertools/dpdk-dumpcap: add script for file capture

 MAINTAINERS                            |    4 +
 app/dumpcap/main.c                     |   16 +-
 app/test/meson.build                   |    1 +
 app/test/test_capture.c                |  512 ++++++++++++
 app/test/test_pcapng.c                 |    6 +-
 doc/guides/rel_notes/release_26_11.rst |   11 +
 doc/guides/tools/index.rst             |    1 +
 doc/guides/tools/wireshark_extcap.rst  |  144 ++++
 lib/capture/capture.c                  | 1032 ++++++++++++++++++++++++
 lib/capture/capture_impl.h             |   56 ++
 lib/capture/filter.c                   |  108 +++
 lib/capture/meson.build                |   19 +
 lib/meson.build                        |    1 +
 lib/pcapng/rte_pcapng.c                |   32 +-
 lib/pcapng/rte_pcapng.h                |   30 +-
 usertools/dpdk-dumpcap.py              |  426 ++++++++++
 usertools/dpdk-wireshark-extcap.py     |  374 +++++++++
 17 files changed, 2744 insertions(+), 29 deletions(-)
 create mode 100644 app/test/test_capture.c
 create mode 100644 doc/guides/tools/wireshark_extcap.rst
 create mode 100644 lib/capture/capture.c
 create mode 100644 lib/capture/capture_impl.h
 create mode 100644 lib/capture/filter.c
 create mode 100644 lib/capture/meson.build
 create mode 100755 usertools/dpdk-dumpcap.py
 create mode 100755 usertools/dpdk-wireshark-extcap.py

-- 
2.53.0

