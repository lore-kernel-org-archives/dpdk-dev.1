Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30D6E94623
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 00:02:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCDEA402DC;
	Tue, 10 Feb 2026 01:02:08 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id DD0CD400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 01:02:07 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-48336a6e932so12776655e9.3
 for <dev@dpdk.org>; Mon, 09 Feb 2026 16:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770681727;
 x=1771286527; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iN6F6yeYCo8us9oC4D2lHWDsnsgq4dmWCAtKaJnkW/k=;
 b=ehInqC48MeYXYUkENdEvD+abyyMgaGPbjpHskhV89UzVT4VuN/8SjNLjLce1Cnobl5
 r+ANlnfs1YA9cg2DzYRCGYDu0ak2QXKdbHRCnSDAbsNPLj6xC0FuoKoAkPdWt9JkINVM
 7LpvrUtpVw6YibPN0EVDIleZRdNIdLLHx08oK5NGO6ARw1S0R6Mega/mMD8hrBcF+zw1
 q/8yJPsRIqt5KnvIYG8CGiy+ZJibPxApv1uh6HiGoA5Yu97zk3bZVHUrP9qFhPRM4Cbu
 6NEwzGUm5UFtNxUhv4KXjVbt6uyhD+njAlsjI2PKKSbi+8px2iOkMsSCW8eH9nA/fTKe
 d2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770681727; x=1771286527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iN6F6yeYCo8us9oC4D2lHWDsnsgq4dmWCAtKaJnkW/k=;
 b=P3PqXUa7u6AdkL8A1J6v7BAyV+MCGiLaeeNKAVLbkqEmf4R7EeQ8S5nfSVbizGwqyx
 MYqfckbyii77yAIyNjChtypYYU5syVgOGljMhnkomhoprTKDKgFJNRJa0F/uLVHQjbY8
 /nLNH9qKnO8ccvwR1z1rhWyohZIBiJoSc60GNxoCqunZZ4Axqoz93Dnbt5DqtMs9/dVS
 4wwa6nXXQf/uwcUh+PEGWD02FXx5HydNw7f05sOSthieLOXiQPVbxqss4x+2eOOJ7vhX
 EKEShPq21A1zzDL+IJwv+0WxbEA+usp2TxHsOLrJebFbYfRbmZiSpQRXLkdJ+QFpwT/P
 IHRA==
X-Gm-Message-State: AOJu0Yx3l+7v9haUq8eiQ2uh9/latx6CPHRZ5+qJ5B19qj/OkoCq+rNb
 3g33lJFbooQ3dvrI1UWx2bNzqKEKv+UNIG/ZNxYn/PKNHeQGln1bJXwh2F3LEY8MPKbIpWBj+Av
 Ym4Ri
X-Gm-Gg: AZuq6aIHJ+Xolgx24Zw7QqGOPXcmIZrUL5Ex9i8dd3/hDApcrBy5RU3v6xqwRW0hRwW
 pUzHMu2TSXWt4xTr0kl9qAy5t1I2PVhsHb4BcpRctzm6yacftTc0X1n79RDi26PKKTLE69wRYyQ
 J0v9h1QPSyEejR6WZ8mlQMa08PoUBXuH8Hvw++rxdaQtPLHZ+6z/YIgYM08/jrCE53CiKSC0wed
 nF9nOYtyRFUCiCEZ8TBGLWbSDVkjwbPA+IKfercU41y4KUZCeCU7BRVyLczLNIJCkyS77tftAqb
 ZxlWaSuCW/E0k3MPxJeUmjSA46j5abVLaXO/bg7JZ9hVfuAGXuv0XGnlvkrgHifKygWaK8MsZsc
 6JSzsa3UsZf+DFC+jg3Nw9iQiRsm6DW07Q+bghTj+bEMYgf1RmiTJlkF5nO4nknKw2IUpmm8rD8
 35UXIwFgKBCPCEEJGiV495VQKZQurINcWYK2AnK2TIEeGux2pk0FhmI2B9P4Au1Q==
X-Received: by 2002:a05:600c:8b0f:b0:47e:e5c5:f3a3 with SMTP id
 5b1f17b1804b1-4832021613fmr203053695e9.24.1770681727158; 
 Mon, 09 Feb 2026 16:02:07 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd211sm31529133f8f.13.2026.02.09.16.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 16:02:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v13 00/16] net/pcap: improvements and test suite
Date: Mon,  9 Feb 2026 16:00:31 -0800
Message-ID: <20260210000201.295839-1-stephen@networkplumber.org>
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

v13:
  - Fix VLAN insert to pass mbuf by reference so caller sees
    updated pointer after indirect mbuf handling
  - Fix VLAN insert error path to not free mbuf (let bulk free
    handle it, avoiding double-free)
  - Fix handling of pcap_sendpacket() errors
  - Fix theoretical format string overflows in test suite

Stephen Hemminger (16):
  maintainers: update for pcap driver
  doc: update features for PCAP PMD
  net/pcap: include used headers
  net/pcap: remove unnecessary casts
  net/pcap: avoid using rte_malloc and rte_memcpy
  net/pcap: cleanup transmit burst logic
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
 app/test/test_pmd_pcap.c               | 3023 ++++++++++++++++++++++++
 doc/guides/nics/features/pcap.ini      |    8 +
 doc/guides/nics/pcap_ring.rst          |   27 +
 doc/guides/rel_notes/release_26_03.rst |    9 +
 drivers/net/pcap/pcap_ethdev.c         |  794 +++++--
 drivers/net/pcap/pcap_osdep.h          |   39 +
 drivers/net/pcap/pcap_osdep_freebsd.c  |   98 +-
 drivers/net/pcap/pcap_osdep_linux.c    |  124 +-
 drivers/net/pcap/pcap_osdep_windows.c  |   95 +-
 11 files changed, 3979 insertions(+), 241 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.51.0

