Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F63C54EFC
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:48:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C94F6402D8;
	Fri, 20 Feb 2026 06:48:39 +0100 (CET)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6AB09402C6
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:48:38 +0100 (CET)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-8cb5138df1aso174822085a.3
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771566517;
 x=1772171317; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cgcdjFGy+1ahFaYkCh2NO1+WjQM+Abpud9Xh60dZoc0=;
 b=z8hH8dADdcsP6S4vXl8hfOM4SJVvxvFD8DqX63bv6uue/GyNbmTPWoCEhYwMvqYIQx
 XC1lchKnLvgPdpeXjcV6Gtd5TR2gS3B7U/iaOGrHeYfBisOW13lrghPJESdkT74zOdqg
 QZUgAMVANWyPVgLgWW2LQTYPuyF42J/qeXfZnKufidiSxRmSTV7J2myjcZXzJZqUDKbg
 smT8no76f54nNNo7Hk2gKQ85hvNLAdbhxq+/sCUUwASynU1DW6s94bTcztjtDlcINFEc
 Dg3Vu1HGqy6RFt480+6u5it10KAag/PSgmZL6Pf6UTxQEOSU7bHdPOlltsecwcNhrZo4
 DMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771566517; x=1772171317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cgcdjFGy+1ahFaYkCh2NO1+WjQM+Abpud9Xh60dZoc0=;
 b=wExN1QDun5JZ3NF5dF459x0X9KhQ9jf22aj/J9DBl4mOPX1trI2WXImmG2cWjwM/AL
 +9Dn0JFq/UiCASX6VoEFeQySS8NTgkTbYm4VX7H84FBezFV4RDv65DAEd3Ze24ZafD2x
 jXMXo0AOSv2MCxZYmyQq3tL54IjZ3tn7HNXU36DQI2RJH8Q+fMawLi7dH9vMAZ9k29mJ
 zvsfcFBs1AdX1ZFjP6VWe3SUPyAgkrGJdwkMcKN8HWMue5YWohbyASkqo8O8+8CuIa+h
 oXefH8eJxJobuQcDE7Mk42xJFqsrb8Pc56rhAmFTv5LtbEQihw141g20GwBOEoLzju1W
 YRyw==
X-Gm-Message-State: AOJu0YzA1eCEdU+XrBqaDCKsgHwrUqCfe/JGRnDqwUBJRq0n0v2lRhu/
 V8OL/Q+7vRX2LSJDgzPs91pwNB8iMcqdbKUBxPgZ8Xn/41rh/MtwDO2iV/IczNrQVrE7ZCz7JZH
 m+ZJq
X-Gm-Gg: AZuq6aIuXIq8QgzAfyROYPKsXKzYjtziPco8af0q0+McDVuT6SBozR5L/z/qOtRJD76
 i/a3vGUeE+GCl0Mj+UdUsnqGvcvz1gxkXnnCCXHH/NrGLdf60VwlyMyKLNEu+1nWNCjVTC6Z77l
 siXpOrpx3aeGiEk3uVD31uNMugHfJx3PdmkB62WCTjGmfRr7eHJ2AZv+uyGqb2+SqLdm+jZzjto
 2Pmdx19cM3XNd91OJcZUSyNTLopIohCoWwFrujmHUpPZWuTEYEi9SyfMtVbJeYDKltjLKlLgrxD
 Ar2SXTUfpQJpuw4CannQ1akQNY0jyG5Y+ggqLPymYW+Zu7LC75xXc8JqOasZ8ZRJwVAJmLJtYyl
 zYvgrLyM+NBwFewRF+h0R0tQ/KlXoOMkWLQpoSciHiE0ZGn7n3G5utbneUrRl5ChRLteuzv/aAv
 NeyC8pUkh4SIfcsF67g2GzlJpxa5+AmhEm4O/LrRzaFZdZUdMwR/jR+PyY1wh8tQ==
X-Received: by 2002:a05:620a:40c1:b0:8cb:43a3:8b6f with SMTP id
 af79cd13be357-8cb4c01e240mr2495690985a.67.1771566517401; 
 Thu, 19 Feb 2026 21:48:37 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdad6c1sm229078096d6.39.2026.02.19.21.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:48:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v17 00/23] net/pcap: fixes, test, and ehancements
Date: Thu, 19 Feb 2026 21:45:35 -0800
Message-ID: <20260220054834.1632201-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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
  - VLAN tag insertion on Tx and stripping on Rx
  - Runtime VLAN offload configuration via vlan_offload_set callback
  - Nanosecond precision timestamps (when hardware/libpcap supports it)
  - Accurate link state, speed, and duplex reporting in interface mode
  - Link status change (LSC) interrupt support in interface mode
  - EOF notification via link status change for rx_pcap mode
  - Support for Windows interface mode
  - Advertise RTE_ETH_TX_OFFLOAD_MULTI_SEGS capability
  - Configurable snapshot length via snaplen devarg

Bug fixes:
  - Fix build on Windows from RTE_LOG_LINE changes.
  - Fix multi-segment transmit to dynamically allocate instead of
    silently truncating packets larger than 9K stack buffer
  - Change Tx burst to always consume all packets; failed sends
    increment error counter rather than leaving mbufs for retry
    (pcap_sendpacket failures are not transient)
  - Reject non-Ethernet interfaces to prevent malformed packets
    and kernel warnings on FreeBSD/macOS loopback
  - Fix infinite_rx ring fill applying VLAN strip and timestamp
    offloads to template packets, preventing those offloads from
    working correctly during packet delivery

Code cleanup:
  - Convert internal flags from int to bool
  - Remove unnecessary casts of void* from rte_zmalloc
  - Replace rte_malloc/rte_memcpy with libc equivalents in osdep code
  - Include headers explicitly rather than relying on indirect includes
  - Remove unnecessary volatile qualifier on statistics
  - Reduce scope of file-level variables
  - Defer pcap handle opening until device start
  - Use bulk free for better Tx performance

Testing:
  - Add comprehensive unit test suite covering basic operations,
    timestamps, jumbo frames, VLAN handling, multi-queue, and more
  - Test discovers network interfaces using pcap_findalldevs API
    for portable interface enumeration across Linux, FreeBSD, macOS,
    and Windows
  - New tests for runtime VLAN offload toggle, VLAN strip with
    infinite_rx mode, and timestamp generation in infinite_rx mode

v17:
  - Fix windows build
  - Fix feedback from AI review
  - Cleanup tests

Stephen Hemminger (23):
  maintainers: update for pcap driver
  net/pcap: fix build on Windows
  doc: update features for PCAP PMD
  net/pcap: include used headers
  net/pcap: remove unnecessary casts
  net/pcap: avoid using rte_malloc and rte_memcpy
  net/pcap: advertise Tx multi segment
  net/pcap: replace stack bounce buffer
  net/pcap: fix error accounting and backpressure on transmit
  net/pcap: add datapath debug logging
  net/pcap: consolidate boolean flag handling
  net/pcap: support VLAN strip and insert offloads
  net/pcap: add link state and speed for interface mode
  net/pcap: support nanosecond timestamp precision
  net/pcap: reject non-Ethernet interfaces
  net/pcap: reduce scope of file-level variables
  net/pcap: avoid use of volatile
  net/pcap: clarify maximum received packet
  eal/windows: add wrapper for access function
  net/pcap: add snapshot length devarg
  net/pcap: add link status change support for iface mode
  net/pcap: add EOF notification via link status change
  test: add comprehensive test suite for pcap PMD

 MAINTAINERS                            |    1 +
 app/test/meson.build                   |    2 +
 app/test/test_pmd_pcap.c               | 3424 ++++++++++++++++++++++++
 doc/guides/nics/features/pcap.ini      |    9 +
 doc/guides/nics/pcap.rst               |   41 +
 doc/guides/rel_notes/release_26_03.rst |   13 +
 drivers/net/pcap/pcap_ethdev.c         |  935 +++++--
 drivers/net/pcap/pcap_osdep.h          |   39 +
 drivers/net/pcap/pcap_osdep_freebsd.c  |   98 +-
 drivers/net/pcap/pcap_osdep_linux.c    |  124 +-
 drivers/net/pcap/pcap_osdep_windows.c  |  103 +-
 lib/eal/windows/include/rte_os_shim.h  |    1 +
 lib/eal/windows/include/unistd.h       |    7 +
 13 files changed, 4553 insertions(+), 244 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.51.0

