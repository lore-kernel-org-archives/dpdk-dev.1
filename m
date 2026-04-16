Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EC0F8D765
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:51:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C4FB402B0;
	Thu, 16 Apr 2026 20:51:48 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 156C040297
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:51:48 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2d8ffdc31d0so10780444eec.0
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365507;
 x=1776970307; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Kzz2nsNxjzWCxLn96/QsXq2GuHUySWVuhhefv9F2Ck=;
 b=OdzJMQabZd5hxizFYgnLxNEIqbGaC7/OrZX1O/UhCOy2T/cmUfwqcLRaOBdLjKQPuh
 2WCoN665KuDS95jSnSIaBsseD0BERK3r9M5mSSVgvB3ikmFAfKbM5AC+pQXxtqk3Tdbm
 8lkmBuRTaaqDyBHpk2LmJTezIP5PvhmXEAQAIbW0RKM6PS7bK8aIcjKwgXpfF0YtTAdU
 f6HyLoXX155RXFtWR2fdVdogvKXKQknWflkjEe5+6l1D9CnMFI/Z+LrxA8CPbpMV10EK
 PnFl9R0MaRFoeLbHT6E+dajuFidCxlHLvxKNHYHhDDrEUHpHq6gVNp7mchklgkJwBJ42
 AVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365507; x=1776970307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Kzz2nsNxjzWCxLn96/QsXq2GuHUySWVuhhefv9F2Ck=;
 b=YX3Y37GZIvr+kTnixjGEXFzjbKI6NmCAz/NUKdYEYNPgaM2lsPZzeo7kKdd7157jMM
 lbNHyZ5Wp3ocGcv8jkJ+k+OKEcPdOVfT5PM1S+2GTtPk7NulgdSN5+g4+mW74GMOsNVJ
 L1rKKuxCAnLQt4dhu9OVRqbPF+1KIRbDexVPXj8gz56Xky/0rKUoE4IQTCV43j65HVTV
 jaW8AwXqf0mNC+BmSHvH9V2o7gJiH9ycY381peCtZPwFn0u3/ZRhcOMlZBc3tUcBBB/H
 sQnpE1ajBOwaOUMWWywwf0lN+PCcAMiraUAMdP6behY/kTEJ08vDW6eQBwvWS8qiRDki
 moaQ==
X-Gm-Message-State: AOJu0YzOpmSHF0giwfFJ4AVcvbVWzZU29RlSk5NAgkhwzT+S5B0R6ub6
 iOJaPmcWFGK19xSvXhWb7EiuDq7NxPTTt6n2O62k184/NwNBJgjA4CCYtHP16p86VF1Z+bySSH4
 SkkGl
X-Gm-Gg: AeBDieu2WOBksDPuvur9ARJl+/ebAQWbX6UhuQLQpj+voAEOxXWb0qvVQ/4T/TgvsLX
 5pQwiP7OyvwtRZC3FaxU84VsZPeVvQFyakRXRxHbM8eSniBY0PREZyml6oqHtl6p5W3IxlsthWO
 vYSRSHJxPWXRCsFh2Z18aBAz4cdg90An3sY/SrYmA7g3kegm7sXbVDeKRr2ktCcwZMGtm5jVIlv
 FxfNiZ4N+7bmJyk1mfbHYKPKCdWSaZdfCfAbmBkVNcpFfaAiGDH9qvdE41aUnQOg3baNW5nVsmk
 KbQcnAPev4Jq91KXfaUOc5CjQoU0o3Z+Pm33kjTgZ9BNuO/I0wxlMp3c+QIPLwadfLqkwa/AGxg
 Uqvv+va+fKBcYVUO16OV/i9AQabvwSuZGevwPb4ZCCJjhqVkd1UwyksILVo8UUPPBrw+vV+SW2i
 qZFTNn5TorY2uGKRbfQaFItXVjQ/BoLsWIuYZC7Gvl6j0uwVoj3yeM0A==
X-Received: by 2002:a05:7300:a508:b0:2cb:de38:c77d with SMTP id
 5a478bee46e88-2e2e348a3e4mr250901eec.3.1776365506956; 
 Thu, 16 Apr 2026 11:51:46 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f6615d5sm10602510eec.24.2026.04.16.11.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:51:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v24 00/24] net/pcap: bug fixes and new features
Date: Thu, 16 Apr 2026 11:48:17 -0700
Message-ID: <20260416185144.1359260-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260106182823.192350-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
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

This series contains improvements to the PCAP PMD including new
features, bug fixes, code cleanup, and a comprehensive test suite.

New features:
  - Nanosecond precision timestamps (when libpcap supports it)
  - VLAN tag support
  - Link state reporting in interface mode
  - Link status change (LSC) interrupt support in interface mode
  - EOF notification via link status change for rx_pcap mode
  - Advertise RTE_ETH_TX_OFFLOAD_MULTI_SEGS capability
  - Configurable snapshot length via snaplen devarg
  - Rx scatter offload support with mbuf pool validation

Bug fixes:
  - Fix build on Windows from RTE_LOG_LINE changes.
  - Fix multi-segment transmit to dynamically allocate instead of
    silently truncating packets larger than 9K stack buffer
  - Fix Tx burst error handling: distinguish malformed mbufs (counted
    as errors) from pcap_sendpacket backpressure (break and retry)
  - Reject non-Ethernet interfaces to prevent malformed packets
    and kernel warnings on FreeBSD/macOS loopback

Code cleanup:
  - Convert internal flags from int to bool
  - Remove unnecessary casts of void* from rte_zmalloc
  - Replace rte_malloc/rte_memcpy with libc equivalents in osdep code
  - Include headers explicitly rather than relying on indirect includes
  - Reduce scope of file-level variables

Testing:
  - Add comprehensive unit test suite
  - Make test suite packet generator handle larger packets

v24 - fix format string warning in test code.

Stephen Hemminger (24):
  maintainers: update for pcap driver
  net/pcap: fix build on Windows
  doc: update features for PCAP PMD
  net/pcap: include used headers
  net/pcap: remove unnecessary casts
  net/pcap: avoid using rte_malloc and rte_memcpy
  net/pcap: advertise Tx multi segment
  net/pcap: replace stack bounce buffer
  net/pcap: fix error accounting and backpressure on transmit
  net/pcap: clean up TX dumper return value and types
  net/pcap: add datapath debug logging
  net/pcap: consolidate boolean flag handling
  net/pcap: support VLAN strip and insert offloads
  net/pcap: add link status for interface mode
  net/pcap: support nanosecond timestamp precision
  net/pcap: reject non-Ethernet interfaces
  net/pcap: reduce scope of file-level variables
  net/pcap: clarify maximum received packet
  eal/windows: add wrapper for access function
  net/pcap: add snapshot length devarg
  net/pcap: add Rx scatter offload
  net/pcap: add link status change support for iface mode
  net/pcap: add EOF notification via link status change
  test: add comprehensive test suite for pcap PMD

 MAINTAINERS                            |    1 +
 app/test/meson.build                   |    2 +
 app/test/test_pmd_pcap.c               | 3452 ++++++++++++++++++++++++
 doc/guides/nics/features/pcap.ini      |    9 +
 doc/guides/nics/pcap.rst               |   47 +
 doc/guides/rel_notes/release_26_07.rst |   12 +
 drivers/net/pcap/pcap_ethdev.c         |  859 ++++--
 drivers/net/pcap/pcap_osdep.h          |   27 +
 drivers/net/pcap/pcap_osdep_freebsd.c  |   43 +-
 drivers/net/pcap/pcap_osdep_linux.c    |   33 +-
 drivers/net/pcap/pcap_osdep_windows.c  |   76 +-
 lib/eal/windows/include/rte_os_shim.h  |    1 +
 lib/eal/windows/include/unistd.h       |    7 +
 13 files changed, 4354 insertions(+), 215 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.53.0

