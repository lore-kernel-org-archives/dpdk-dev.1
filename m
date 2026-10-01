Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6FBCA5FC1
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 02:59:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 083C6402C3;
	Thu,  1 Oct 2026 04:58:59 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id BD26E40294
 for <dev@dpdk.org>; Thu,  1 Oct 2026 04:58:57 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-398beb616f5so2771838a91.1
 for <dev@dpdk.org>; Wed, 30 Sep 2026 19:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790823536;
 x=1791428336; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Ci+S/p9Vz/FmNhdj2FGIQfJ7v815MHRQ8HJ+Y8yg8I=;
 b=KvAyomnkEpiTEFRTt8FTJrIIv/wyzBlt9LmssgHNNKOkZNGebElCJGkwU8OFAotrXl
 F89OirksUXbpGg2dSU5i32msDa6X52Ghmui7Ok/DRFxuewFie9hzP3MyXRnTYBrZo1JT
 yaFsHFTX6W9HDtV/rlosi4EYse+ui6eSG4FgJZK8ZgwW5iF9tC4uK+AHWNvxN6utq5Lb
 GdGXLfBW8mUN6cdWljwa8+1Tgu5bKIfQrolywivTP0c5SJYAJrIB+gzM2aqIUx4A5cji
 zclS5XdQi+Lp4e/10ZFqOvtOQaWxZimZY4sFJeL+O/9vhthNb36qy0oRDMPf0Mmr4LUW
 J8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790823536; x=1791428336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5Ci+S/p9Vz/FmNhdj2FGIQfJ7v815MHRQ8HJ+Y8yg8I=;
 b=mtejGJZIYrX3hcHh/IDy14Mcfkz1PtKprUNBHp8jEJp8Ltv0dp39SZRj5x8UROMnGm
 nVxIS59X7HsKOoe7cwiOq5G9jh5S/1uB3qbxgfCP+ZjzFRSWVzjtN0Hvv4t/ZuW+WI3R
 UsEKSkX10h5iin/7J4pteNHg5W/maS3GTKHTROGsiyHdOWmQwdd9i3gckCq8FSa8jZCG
 S4KTkPoWIGzULX3AJstOJZjWC0b9ajsQO0NaTFeIfffwUllv4u0yhDezaEOzTQBMMxsm
 C6W/P/MlQ5qFRdgMnI4HfSnMOIPSMe8U4tSE68ZcEUurPaOfAwBTu3vS2Li0uJJ7fYxx
 u2Dg==
X-Gm-Message-State: AFq9FYJIpqLsWVGUc/0y5qIwcMyz8r9BYlgof+WtwNlUTmxT7u8Iq2t8
 AO1C9JNgGmZ65GfHX8F+jVRM6dW4GqMB+6RGMpljTouJy2XKvkJtO+LvrDRyP040490GNWfjBF6
 qQeV5eGI=
X-Gm-Gg: AYBFou0oyjei6lKDms4Q/nXQIPKME71nepNN5QFouncb83qObq7z7Ok1SaqVe8eEKCH
 8isd6pKV51Z0QAH+C8A9CyW89bi/W//QKLP00yLWbmQfVfdwYfHxMkJ62HmQSfb8C5qepilB8hr
 +xgUYdhZEd1kQlIXVWYOHkgqPR/xLhalqaflmdOTzupDCiiQXzywbTJReH7fmC8uV8HZKqsapUw
 4qD6KxpahiedgmijDHY63CIj7aMEzUau/ceI39Qm951+FHMo8bUUUapZJ2E1u5W+Lb/Pq+NBep8
 fiwOVe8Qwpi6qPGs69mU19/AZZ5fnPho2Bc/VOkXC5hU6Df0PQwMQlyySwtdgc0Yk15piT/8I+O
 6eaaG61WADy59gT0zl+JYpB6UUMR61XOLcTc/RwPx7RvFkD/vkKmXQM1zkDiQqKw/FXQ3P/fnsm
 hey2Pkp2qazWa49stI3NEaHyvRe5PAdXDOv0MNkssAWoEfbdfwDEb3MPYuc6ImVSTFE7Zleyzub
 dlazvqotiy6LempwhdAm0GiH1rx1XWJ4jJM6w==
X-Received: by 2002:a17:90b:4c47:b0:3a0:d7f2:5a58 with SMTP id
 98e67ed59e1d1-3a4f2aff61dmr934748a91.3.1790823536072; 
 Wed, 30 Sep 2026 19:58:56 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f471b16asm2024487a91.9.2026.09.30.19.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 19:58:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 0/4] add rpcap remote capture daemon
Date: Wed, 30 Sep 2026 19:35:25 -0700
Message-ID: <20261001025853.319860-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908210832.1556291-1-stephen@networkplumber.org>
References: <20260908210832.1556291-1-stephen@networkplumber.org>
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

This series adds support for live capture using tcpdump and related
tools that use libpcap. See document doc/guides/tools/rpcapd.rst
for the details.

The dpdkr rpcap daemon runs as a secondary process similar to dpdk-pdump
and dpdk-dumpcap. The difference is instead of writing packets
directly to a file, it provides a standard API for transferring
packet capture over a socket. The command line arguments
are chosen to match the existing libpcap rpcapd, but not
all command flags are implemented.

The capture is only possible if the rpcap daemon is running.
And since it is a secondary process, it needs to be started
after the DPDK primary process. The daemon will also exit when
the primary process exits.

Since it is intended for debugging (and due to limitations in
the pdump API), only a single client can access rpcap at a time.

The dpdk-rpcapd uses existing pdump infrastructure to capture
and filter packets. One small additional API was needed to extract
the timestamp and original capture length from the mbuf
that was processed with pcapng mode. Since rpcap protocol
is limited to pcap legacy format, only microsecond timestamps
(and no metadata info) are visible in the stream.

By default dpdk-rpcapd can only be used over local TCP sockets.
This version also adds TLS and password authentication which
could be useful if dpdk-rpcapd is setup to allow non-local access.
An additional security feature was added based on what libpcap rpcapd has,
with the -l flag a list of allowed hosts can be used.

Changes since previous version:

  - Moved from examples/ to app/
  - Added TLS and password authentication (patch 3).
  - Added the -l host list option (patch 4).

Stephen Hemminger (4):
  pcapng: add API to read back capture mbuf header
  app/rpcapd: remote pcap daemon
  app/rpcapd: add TLS support
  app/rpcapd: add host list option

 MAINTAINERS                            |   2 +
 app/meson.build                        |   1 +
 app/rpcapd/capture.c                   | 541 ++++++++++++++++
 app/rpcapd/filter.c                    | 164 +++++
 app/rpcapd/main.c                      | 840 +++++++++++++++++++++++++
 app/rpcapd/meson.build                 |  40 ++
 app/rpcapd/rpcap-protocol.h            | 146 +++++
 app/rpcapd/rpcapd.h                    | 122 ++++
 app/rpcapd/session.c                   | 292 +++++++++
 app/rpcapd/sock.c                      | 365 +++++++++++
 app/rpcapd/tls.c                       | 273 ++++++++
 app/test/test_pcapng.c                 | 133 ++++
 doc/guides/rel_notes/release_26_11.rst |  13 +
 doc/guides/tools/index.rst             |   1 +
 doc/guides/tools/rpcapd.rst            | 288 +++++++++
 lib/pcapng/rte_pcapng.c                |  40 ++
 lib/pcapng/rte_pcapng.h                |  46 ++
 17 files changed, 3307 insertions(+)
 create mode 100644 app/rpcapd/capture.c
 create mode 100644 app/rpcapd/filter.c
 create mode 100644 app/rpcapd/main.c
 create mode 100644 app/rpcapd/meson.build
 create mode 100644 app/rpcapd/rpcap-protocol.h
 create mode 100644 app/rpcapd/rpcapd.h
 create mode 100644 app/rpcapd/session.c
 create mode 100644 app/rpcapd/sock.c
 create mode 100644 app/rpcapd/tls.c
 create mode 100644 doc/guides/tools/rpcapd.rst

-- 
2.53.0

