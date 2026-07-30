Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04476C5516D
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jul 2026 18:25:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA21640276;
	Thu, 30 Jul 2026 20:25:01 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id EFB1D40272
 for <dev@dpdk.org>; Thu, 30 Jul 2026 20:24:59 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2cca0c5799eso1098555ad.0
 for <dev@dpdk.org>; Thu, 30 Jul 2026 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785435899;
 x=1786040699; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zfJyUUhI3OGmzG49PNnbzwLmLi7XZv/HRg3ceA/b0hs=;
 b=oH5hBOdb1SXEfnwv+OIjmD3VERRKHHsDYpy13T5TCTcWVGAYwPoh88MZ+rW7EfLRpJ
 TB6hYWbCOgPqUlKy4eeqMXCiWbukN1dmia1KJGfJFK8ZPikp61L17lEZJpzQWP9k325b
 cSkKEYTVirIQ73V9R5dm7ULLHEMs9Koe7rx69A8e6edgFdNchl/fCcefXpuobbZeqqHj
 GsXGHvJ30zUyYEXlJb5w/YRWFMuCDBcVkVjO53P6MZGHyfDwFNIyMxtLNagQtI2yCRCi
 9x1FFgiX+Zbd91cJDaI3+Oyo/VXKDM/ZsJFt1XoW2RKoktMAX67v2OHHaZE4z0WKn6CC
 aFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785435899; x=1786040699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zfJyUUhI3OGmzG49PNnbzwLmLi7XZv/HRg3ceA/b0hs=;
 b=gMPLRPHNZz8H7ngNkZs0Xa70Bkv72/I12a3y63pSJuf/4Irw4L4W7bqsrRPrnnieZB
 9ocb10DLC5EPuepLjWYWlUxEyv9lRvX4fVeBzhj53nAucXgICj9l8s7zDP35JzlxG5oO
 1DSpkw4b8FQR1eFjKiJME9FLdqlcNmI7Ps59ShTsLgAJIayP3tYqX3M2HbfswoNi+mkR
 eXmFWc+U02F4Oiav2MeuWvgL/BDkk1AGPF2lkOQsJz5KyQ+gmhGZgtApEyKArYcwWBXZ
 1RkE4RFZ7bLb8gwG/3U6Z0e/+CNT236/9dh3sq8ziFtCeKDGsBnxqbzix/VhfwdqkQEU
 lQXA==
X-Gm-Message-State: AOJu0YxUYulI6CegcnZHOQPKZfzLgrn9LV3eYoevUBW950zFuf3f2SsV
 SHAiPToyFOp2CEiGvG2DShn8F7aJMaaWxa30szE5pZkg+PQY/xj0SqUWlaCWxNZAmz1nZ+09zjT
 C2XMh
X-Gm-Gg: AR+sD13Q/oGbl9v75qsC4jnwEkwfrHysz2khsSgIYOfJuzsLUpE7fhVFxUOqeG8fhnO
 SULMkKhC/wVko2bgbTBCgw1q2eR3GrCj6VfqRTgv5Wg6kzCiJilgYmqdqakovzJNcqFZHbR91uQ
 X7oFr2RyEJpS5W7IrdYkTEJB5/tH/xFEpvq7MF1YRVcEiozjaHMDL3kzqo98CLNoyc0VI0zuIIQ
 w4JIBj3QYGL5KW6nWwlgfBV0xmit1uS06MYSirx4cFUP1t957TzQ1ihS23KGvcaMLdPOqUYLlFh
 7goUeBgX0hnKm2WqV2ypA6m3gJkH8ABOO6VEknngLgqi2vh+Td/QlQHgG3dXXGN/l52fiGyQPOg
 5Z8N9OTqZHgZI/S7MvXPO5MNKpWN9KR2o6d3f0vq2C8WeVMgOsqJ4oi3EZVk2uXxMQDxBQPQDCS
 SRfiYjGhWTSzxU7Er5CScBJRAQCC0Yi086W2hc9Q5HooZ+sB/jGbr96ZPvRvyrYX5A3P47H/bAD
 cRrrY7AP+hYr3y7GxX5JyjuNLZzZac74hUyhg==
X-Received: by 2002:a17:90b:1e41:b0:37f:b0a9:1a68 with SMTP id
 98e67ed59e1d1-38f9bd692c0mr2973698a91.7.1785435898591; 
 Thu, 30 Jul 2026 11:24:58 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7262bc27sm30272155c88.2.2026.07.30.11.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 11:24:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/4] Wireshark external capture
Date: Thu, 30 Jul 2026 11:22:53 -0700
Message-ID: <20260730182455.502175-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727224417.1419663-1-stephen@networkplumber.org>
References: <20260727224417.1419663-1-stephen@networkplumber.org>
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
optional libpcap filter and per-queue selection.

Advantages of this:
 - no primary/secondary needed; works on Linux and FreeBSD.
   can also work on Windows with pcap support.
 - installation is just putting script in Wireshark directory.
 - script has no dependency on DPDK libraries; can be packaged with Wireshark.
 - allows for live capture
 - supports BPF (with JIT) for filtering

How it works:
 - The capture library registers telemetry commands (/ethdev/capture/*)
 - Callbacks are installed on the specified port/queues to copy packets
 - Packets are formatted as pcapng and written to the specified output
 - No packet data passes through the telemetry socket itself

The pcapng statistics interface has been extended to include the
filter-accepted packet count, which was previously missing.

Testing:
  - Run: dpdk-wireshark-extcap.py --extcap-interfaces to list available ports
  - The script should be installed in Wireshark's extcap directory for GUI integration
  - Comprehensive unit tests are included in app/test/test_capture.c
  - Tested on Linux and FreeBSD

v3 - fixed AI review feedback

Stephen Hemminger (4):
  pcapng: extend interface statistics
  capture: infrastructure wireshark packet capture
  test: add test for capture hooks
  usertools: add script for wireshark capture

 MAINTAINERS                            |    4 +
 app/dumpcap/main.c                     |   16 +-
 app/test/meson.build                   |    1 +
 app/test/test_capture.c                |  660 +++++++++++++
 app/test/test_pcapng.c                 |   10 +-
 doc/guides/prog_guide/capture_lib.rst  |  168 ++++
 doc/guides/prog_guide/index.rst        |    1 +
 doc/guides/rel_notes/release_26_11.rst |   14 +
 doc/guides/tools/index.rst             |    1 +
 doc/guides/tools/wireshark_extcap.rst  |  144 +++
 lib/capture/capture.c                  | 1202 ++++++++++++++++++++++++
 lib/capture/capture_impl.h             |   56 ++
 lib/capture/filter.c                   |  110 +++
 lib/capture/meson.build                |   19 +
 lib/meson.build                        |    1 +
 lib/pcapng/rte_pcapng.c                |   50 +-
 lib/pcapng/rte_pcapng.h                |   33 +-
 usertools/dpdk-wireshark-extcap.py     |  416 ++++++++
 usertools/meson.build                  |    1 +
 19 files changed, 2874 insertions(+), 33 deletions(-)
 create mode 100644 app/test/test_capture.c
 create mode 100644 doc/guides/prog_guide/capture_lib.rst
 create mode 100644 doc/guides/tools/wireshark_extcap.rst
 create mode 100644 lib/capture/capture.c
 create mode 100644 lib/capture/capture_impl.h
 create mode 100644 lib/capture/filter.c
 create mode 100644 lib/capture/meson.build
 create mode 100755 usertools/dpdk-wireshark-extcap.py

-- 
2.53.0

