Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68682D73EAA
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 01:13:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3979B402D8;
	Fri, 30 Jan 2026 02:13:52 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 4BCBB402C6
 for <dev@dpdk.org>; Fri, 30 Jan 2026 02:13:50 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-48069a48629so15954785e9.0
 for <dev@dpdk.org>; Thu, 29 Jan 2026 17:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769735630;
 x=1770340430; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7J7N4QTQyI3W98avgKEmGbq4wnpYz/wdqWKlGYas8Rs=;
 b=0isBPFLp4tG78DUPmGSh1zr/Z+nmCvv9aTZHQ8KVfAn56l8Qq96UGi7PbN3YsXR2rf
 f/5i1cxWr8qj9XX71o+6gpiYg7jk03sgmCkTczbKbtbqMWsllRpYZgFgxDyT8R4x4cRX
 EPm5JPv2Yld0/EwTf/dhqODFd6lI0gJ/FajV0kO0fBc2aMu4SxbeWss5TKNaNKrAejIf
 UttY13vzjY2u180ZpJZjXAc6/+ZRrn0aJ7HpB6hXT8V6lVFbXJ5QDGGbo4BZAOfxqRqB
 gy0yMN5E8pu7UqnG5Bk/IcVWSVlkNc2VJdOU4q4/0GpqoEQK5hSHl/v57S4Pc5PAJCIF
 GE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769735630; x=1770340430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7J7N4QTQyI3W98avgKEmGbq4wnpYz/wdqWKlGYas8Rs=;
 b=Au4vSUOxdjKIa6/y1rxAVFuFU1VqGz66gdYClzxMj7ooMEGkXU8EVE9t1bOJ1q9y2E
 7mV0A4Paz1w3scP9pouiePb5aeVnKVgUb7vp2gQUb0yZD7KDS1anx9/alNL5lCljHpIa
 ABaspfqXdDImKwLlUIVzaV0G4AteDPAoP/eP8UPLHLQI805FscmyVfds5ScIYBChO53r
 YQMlcQfH6TCpYs/BS70N15Fya6jni2wvw/lgFq4PH1a0I0g8mx0s3JxUekPdITlDgwRv
 YAPGX0bDbItyHAYj5iMyrmmBCN8zD8M2MRRekAPBeZho0Er9HrIqtEiNxj8X5WN7nLe7
 4mIA==
X-Gm-Message-State: AOJu0YzQT1w99XOD1E8o8AUL9MZSGlh0oLg/DldG9AbcQ7MOfQ1NQDVm
 NBgGsTAH536/My7/5M0sMtmWS8pvzRhwdWTqPQFMOuSgdYcbE5salvGmLW7lLbI06vrJ3XZbeEj
 njxiw
X-Gm-Gg: AZuq6aLXFKiu0yvFv1mijAfH4uJd+wlcQ+5a4bdU6qhPTrGsjvab7Gj5lSAXgZbv3l9
 wxVFoQpYx1DrJcfCNsSMsvhm/Aq73SR0FhHypP2c1yMV/xjP8mRNwy7+dWWV/r+gFmU9VO/kRIj
 hvlaIJeHxy6geQCXg7bD+sNjov5aeSjt2goYnW+w+yn0uB3xI2H+vIL/c2aj96qJCYj67o2nXfC
 I6XiSIJq24XSh/K8xEvE9BrNoHtR4ENYkiwNRJi3ifn36B5U3jODITUpiM55zGoT9ZxWmmc2h0o
 6rKhZmRaZj5iO+1zFea4l//WmDFF7BJ6CCjjFuX6FSzjtSKqbwg4SmFmmgLqn/LMo4R5G5oD5g0
 bKEzq2/7WotqjUf8u7BdBCP3mv1aizzpbyD5aT5JT29Y7mSE/Zwp/vhQO6ujdMwhJTSG2YQGD4T
 IuPhngv/hDitbdMy4P36lV/fL/7K7DMxPAHaoEBCeCzPIOz2OcjA==
X-Received: by 2002:a05:600c:c16d:b0:477:63b5:7148 with SMTP id
 5b1f17b1804b1-482db44d22dmr12830565e9.6.1769735629515; 
 Thu, 29 Jan 2026 17:13:49 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e1d0f9sm2934825e9.18.2026.01.29.17.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 17:13:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 00/19] net/pcap: improvements and test suite
Date: Thu, 29 Jan 2026 17:12:16 -0800
Message-ID: <20260130011344.204233-1-stephen@networkplumber.org>
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

v8:
  - Fix pcap header length in VLAN transmit
  - Fix clang warnings from ethtool link_mode array

v7:
  - Drop MTU configuration patch; not necessary as underlying OS
    commands (ip link, ifconfig) can be used directly
  - Add patch to remove unnecessary volatile on queue statistics
  - Add test_link_status to unit test suite
  - Add Acked-by from Marat Khalili on patch 11

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
 drivers/net/pcap/pcap_osdep_freebsd.c  |   79 +-
 drivers/net/pcap/pcap_osdep_linux.c    |  115 +-
 drivers/net/pcap/pcap_osdep_windows.c  |   95 +-
 11 files changed, 3398 insertions(+), 238 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.51.0

