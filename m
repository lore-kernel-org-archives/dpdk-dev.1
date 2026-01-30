Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659FCE6BF30
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 17:34:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5929A40274;
	Fri, 30 Jan 2026 18:34:58 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id B329A4025F
 for <dev@dpdk.org>; Fri, 30 Jan 2026 18:34:57 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so20477515e9.0
 for <dev@dpdk.org>; Fri, 30 Jan 2026 09:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769794497;
 x=1770399297; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0XbPf1TOPy0AQh1AV+/FNaZ/9zxxO2esdVjEhP6VE0=;
 b=csakW7JNHS3H3mKF4+4nffRjtufVzzfoiIWyxJqpZVOXACRTwhUF6wgT/C/sCOhw2q
 krT/ZWElLzw725TsWC+e15HeszYr4VMcU0w1I3YYbaqIVbH3kLu57zFYHY7AmoXtm0Qz
 2J6kuqbizaOO+awcGmBkHPURH+Z5cHoc43hOMALkFSsczlUxzbJxVtfWTpO3/6gehCqu
 R9w+IsA3ZItKLND3mdNlEvSvNj4G6lEv1X9SrdYeNZvqwcNLBgdK5P/+zykqXC8meaLf
 aCCVdhMtWWlBlOKTftPzuKRppletVosBZn88rXKY9A8Lp6fzGs8XuGGk6AtLXfx4bwVO
 xfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769794497; x=1770399297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C0XbPf1TOPy0AQh1AV+/FNaZ/9zxxO2esdVjEhP6VE0=;
 b=K2IxtosdJoVetnCBDK2O63FRtfRMA8SQLrzrM4fY8eZhI5EnFoB0ucwLxapaG4j6ar
 4knDe6dvtOWNe82LOQgpbQ4FjNMT5n+qVj2Ve2pFK412YTVdOGcHzPoNXwul6GVI/2NG
 kmm4fvRhyrChPlMud0tXJLMLyhuhumgyH+sYSRHC9joBTGGv+/juPZVj/sArD7voM8aT
 wCy8BFofdkaXNBvf8b3Oa8FVMX4OPYVG0jws8GW9D8lBLmTqhHumtVPxDQXulD7RCpg7
 QFHVQNF/XnUNrcE7TEgBTo3P07vhEkpmFnnJBKkk3B0alxmV1lSOkiDKBtNtAiz3negZ
 8FmQ==
X-Gm-Message-State: AOJu0Yzn1wlwe8rNa/LsiTuYi0jHSi9RvnxpFIIqTxyhOmRZrkTRnQH1
 7R541jVIOvuRiAroMqsUixStg8NPPRUMMfM+LkCU7muluz5qAZcU4vAypclXUywdkQ+UWxf9kHr
 2IO1r
X-Gm-Gg: AZuq6aJlhweuWJYaTJmort6K5eam21PaMeMWG5klubjt10z9soeYtHSO88jt5rg0M2n
 74w7suWsMZWFrdKWswVRnnbXJW62xyJMH3bkILc8hXwTCdbgu1diRpJs5wDk2fF3NztJtQly1ea
 gaQNtDDorGj62eVz1XrbOiECZMqLourCmazw35vLWN0hGlSh8ISrKl0TrOeWEvrwpxP5rLN48Ge
 gd3GStHcqNBbUi2WNMAhEgaYm1/GzAqZFMD4HfVKC6p8QhlM24ahXPEP1WWdfVa1W7zxlnuRXsu
 NPgrK1rRsoVC00+q+pjVk1SFQnxedsmmNKi86t8O1+HXrNTvoQS3+hTU6Wp6EFmsBdMAbE/Ol3x
 C6PoqQZcD+alZ4Uxn3LFD/UuxTrmcY/Qv1gPqKMwViI4mqy0fKCUKScMem+21/brt2jrqyFdigb
 aqFNkTGlbvBA1qadLNFqMzyHhkgdVUTm9W+8YOo6fEQN+czKrLGQ==
X-Received: by 2002:a05:600c:628c:b0:480:2521:4d92 with SMTP id
 5b1f17b1804b1-482db47ce39mr44742055e9.24.1769794496721; 
 Fri, 30 Jan 2026 09:34:56 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm201085325e9.12.2026.01.30.09.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 09:34:56 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 00/19] net/pcap: improvements and test suite
Date: Fri, 30 Jan 2026 09:33:13 -0800
Message-ID: <20260130173447.14546-1-stephen@networkplumber.org>
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
  - Nanosecond precision timestamps (when hardware/libpcap supports it)
  - Accurate link state, speed, and duplex reporting in interface mode
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

v11:
  - Fix build on FreeBsd

v10:
  - Split transmit handling into separate patches for bulk free,
    bounce buffer allocation, and cleanup for easier review
  - Add patch to reject non-Ethernet interfaces (fixes loopback
    issues on FreeBSD/macOS where DLT_NULL is used)
  - Test uses pcap_findalldevs() for portable interface discovery
    instead of hardcoded interface names

v9:
  - Add configurable snapshot length parameter (snapshot_len devarg)
  - Defer opening of pcap files and interfaces until eth_dev_start()
    instead of during probe, passing configured snapshot length

Stephen Hemminger (19):
  maintainers: update for pcap driver
  doc: update features for PCAP PMD
  net/pcap: include used headers
  net/pcap: remove unnecessary casts
  net/pcap: avoid using rte_malloc and rte_memcpy
  net/pcap: use bulk free
  net/pcap: allocate Tx bounce buffer
  net/pcap: cleanup transmit buffer handling
  net/pcap: report multi-segment transmit capability
  net/pcap: consolidate boolean flag handling
  net/pcap: support VLAN insert and strip
  net/pcap: add link state and speed for interface mode
  net/pcap: support nanosecond timestamp precision
  net/pcap: reject non-Ethernet interfaces
  net/pcap: reduce scope of file-level variables
  net/pcap: avoid use of volatile
  net/pcap: clarify maximum received packet
  net/pcap: add snapshot length devarg
  test: add test for pcap PMD

 MAINTAINERS                            |    1 +
 app/test/meson.build                   |    2 +
 app/test/test_pmd_pcap.c               | 2622 ++++++++++++++++++++++++
 doc/guides/nics/features/pcap.ini      |    8 +
 doc/guides/nics/pcap_ring.rst          |   27 +
 doc/guides/rel_notes/release_26_03.rst |    9 +
 drivers/net/pcap/pcap_ethdev.c         |  655 ++++--
 drivers/net/pcap/pcap_osdep.h          |   23 +
 drivers/net/pcap/pcap_osdep_freebsd.c  |   98 +-
 drivers/net/pcap/pcap_osdep_linux.c    |  115 +-
 drivers/net/pcap/pcap_osdep_windows.c  |   95 +-
 11 files changed, 3417 insertions(+), 238 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.51.0

