Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66138ECD6F6
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 22:21:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52550402B5;
	Wed, 11 Feb 2026 23:21:42 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 033D9402AB
 for <dev@dpdk.org>; Wed, 11 Feb 2026 23:21:40 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-436356740e6so5144809f8f.2
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770848500;
 x=1771453300; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D4zAcS/duSKia0Bn4BtQDH2ntW0ouEc+eNuwzlQVbiE=;
 b=iuj7+lQMQYqkVQ7kG+ScSVElZ/OTZRuOUV5xdzrBncGBxOs7hE9G82dhMYKl7Oz4qH
 aoTvDu1Kpmbf5cUzc72MiIMD3W/ReXQ3CMkY/MQU0WBxn/KCUoX7FH+eNr6eRltEio0Q
 7i2A5tStkOS1IZOnmZVksbCUdnrMG/6BmHilrBYnfa3xrJFsw+AwKpuzAkEi1P+JpZK2
 15+2m64e5HMlFxZ79J9a3BnxuBHoPH5JseSzul9AT4E9y3kN3fiuVW3f7SrfDTKIGwCv
 J5hrQv2u2WZ2Vj4lOd7rwVWSQC5MoxUfujmQyFTkJcXA4KkZtE7u5ygkpIYDvNYEKi1a
 +gQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770848500; x=1771453300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D4zAcS/duSKia0Bn4BtQDH2ntW0ouEc+eNuwzlQVbiE=;
 b=fBIvzSzYObh0LqGgfpl535qu1PMw0ix78zCT80mpHQd+t8aBUBI5Im13maOlUBWbjt
 LBZZL0g0vDw/GWRIZJFlqQ4DcIKYGo1wo9yuaAJ7X3buBpZ4zqjteMVvdWpwrexCBiPS
 ZHzrsfcYES8tKIwW9QQfKGkmJ4djdOgPOpXgXpWZ495zBgFHCz5vlXFg+IR+Wg7oHLtC
 gWOEA++aU7Tq+N+5hN8VksyU8CzQ5+9oxTwp1BMaPDyihpfwbkaxO78nSL0buvQcW/rW
 1QJqihCT30d1VQc8qyVfK7AdXSmo6/kDXCfZVchuyt1Ig2OD1Hk1SaHLU7hFLtk2Rhp0
 nEgw==
X-Gm-Message-State: AOJu0Yw6mg+tslBB2pH/tC8b1vrDKlVN586Wsay9/G6qFJhJ9aRaPQQq
 VmJJN6q9h4aqrOPmJRP54LDPntXQQtACPCgPjpiXl7lyEY/gp81JxdzjzrRbVkA5bkwVlJ1j2W0
 wIv+b
X-Gm-Gg: AZuq6aJhRz+NI4LnqXexQrECmkdp+TIdEmlYLbHofgdUNIa6qf9YzdQbV8ggylfWdzG
 A2op14VDH0DCj0Lv+u38cAKT0ZjwxSrszmXrpFOeYEkf6o8Tb9lX1vAxG0mEAEG7Lwt8FkKstkB
 OnTGVPrazW26MPuy80PzBW1XcARpjk49btXqwHFs9LBh2z1njN2Z+csSWQtS5FjRG0oaYk+88F4
 JBJwHbsZ58fznXcoPSMMfoj6oHAtjPFp4dxHfG0Jc2Yx1BWeHz6NstosEKxoYrRwqDh+NMU7ed5
 F9uMT0dveTl3HFOm+iRKgCq0LyOpa6r2lPxDcCtvgtxJ39SN3nyShFxztDvKVxMfNIdxawltTOf
 s/BJDUuNBtsRiI+IAmDDxZfbRdrjr5Y7d3Jyk5HyPHyxbsrNRnDaxD1PX9WCvUuQMRlSHWS2TcZ
 qhD23U8NPecg/qRDOQ9lvc++KeqoiAodJmWXlu9lIvtpErIsEg2200rFvtPirbvQ==
X-Received: by 2002:a05:6000:604:b0:437:6e6e:6f95 with SMTP id
 ffacd0b85a97d-4378aa14292mr1657924f8f.27.1770848500432; 
 Wed, 11 Feb 2026 14:21:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e0196bsm7877965f8f.23.2026.02.11.14.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 14:21:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v14 00/18] net/pcap: improvements and test suite
Date: Wed, 11 Feb 2026 13:09:33 -0800
Message-ID: <20260211222130.338797-1-stephen@networkplumber.org>
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
  - Configurable snapshot length via snapshot_len devarg

Bug fixes:
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

v14:
  - Add LSC interrupt support for iface mode using alarm-based polling
  - Add EOF devarg for rx_pcap mode: signals end-of-file via link
    down and LSC event (mutually exclusive with infinite_rx)
  - Fix mbuf leak in eth_pcap_tx() when dropping oversized
    multi-segment packets (missing rte_pktmbuf_free before continue)
  - Fix rte_pktmbuf_read() NULL path falling through to success
    counters (num_tx/tx_bytes now inside else branch only)
  - Fix VLAN insert for indirect/shared mbufs: use rte_pktmbuf_adj()
    to advance data_off, preventing duplicated Ethernet header in
    the mbuf chain

v13:
  - Fix VLAN insert to pass mbuf by reference so caller sees
    updated pointer after indirect mbuf handling
  - Fix VLAN insert error path to not free mbuf (let bulk free
    handle it, avoiding double-free)
  - Fix handling of pcap_sendpacket() errors
  - Fix theoretical format string overflows in test suite

Stephen Hemminger (18):
  maintainers: update for pcap driver
  doc: update features for PCAP PMD
  net/pcap: include used headers
  net/pcap: remove unnecessary casts
  net/pcap: avoid using rte_malloc and rte_memcpy
  net/pcap: rework transmit burst handling
  net/pcap: consolidate boolean flag handling
  net/pcap: support VLAN strip and insert offloads
  net/pcap: add link state and speed for interface mode
  net/pcap: support nanosecond timestamp precision
  net/pcap: reject non-Ethernet interfaces
  net/pcap: reduce scope of file-level variables
  net/pcap: avoid use of volatile
  net/pcap: clarify maximum received packet
  net/pcap: add snapshot length devarg
  net/pcap: add link status change support for iface mode
  net/pcap: add EOF notification via link status change
  test: add comprehensive test suite for pcap PMD

 MAINTAINERS                            |    1 +
 app/test/meson.build                   |    2 +
 app/test/test_pmd_pcap.c               | 3422 ++++++++++++++++++++++++
 doc/guides/nics/features/pcap.ini      |    9 +
 doc/guides/nics/pcap.rst               |   41 +
 doc/guides/rel_notes/release_26_03.rst |   12 +
 drivers/net/pcap/pcap_ethdev.c         |  920 +++++--
 drivers/net/pcap/pcap_osdep.h          |   39 +
 drivers/net/pcap/pcap_osdep_freebsd.c  |   98 +-
 drivers/net/pcap/pcap_osdep_linux.c    |  124 +-
 drivers/net/pcap/pcap_osdep_windows.c  |   95 +-
 11 files changed, 4524 insertions(+), 239 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.51.0

