Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A965D19502
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 18:08:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19DEA40276;
	Mon, 26 Jan 2026 19:08:14 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id A5DA3400D7
 for <dev@dpdk.org>; Mon, 26 Jan 2026 19:08:12 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4359249bbacso3731384f8f.0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 10:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769450892;
 x=1770055692; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NYfzuoW3XuODSGQtK87ZMSdGS4q9CSyY3okiAqWk1Ds=;
 b=ZcvhBLM63JPVdyZvk9sHFkgSRaqhWXzWBeZoAv7PkncH0O8QzugBo2YEsa5UnHCVhs
 dIrXGRIskoZ0jG4qIFea059pPCe88DKsdPaSLugheO3sFwdZNf0tiTFVCzIQNgAucGZf
 xBQC7Lej7j6GKcckSJRDsjoznW6qoLwCJSFJAcCMW9gm1IdLBX81FVXxe20EC9QUkv22
 2TyS+g8hEQ3MgY0F6TgCBdHHYutVTlC1ICtlgi7YYih1R5M/PqteB7NQ9AHoye2H548r
 Ah2YfbFtVHclaDg7hfJiCBWs7vJ3d8AnNpX4UoIrTmawTqizU09M4xmpxrCFspD+XpqR
 umRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769450892; x=1770055692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NYfzuoW3XuODSGQtK87ZMSdGS4q9CSyY3okiAqWk1Ds=;
 b=kacFHugCcZxMupP0gKH2WYwN9XETlM/E7Gyy8L4y9hrP+lMaKd9ozDrDdyTpYBCcR7
 rHkRY1bg5CM7ARkJGCp+8R5zSMZb/Caf+XOECM7IRqBqoDC8P7BPNNHP3eCfxvZO7sD+
 frpawFL4qcJbaX8BDNqCCFlOfX5dAuqn/5OQdWB/Zpxgi0f3XVlb84wM/vNdbh4/Zgwy
 jv6wfkjnBmAtnR4obXSuD7zFi3JhAKzCmSxU62y+SQrqEgQjmnjmHdO8jU1Y2ab49Gxq
 GooegjD1hRpSqHtxws2HObaiNvptrP15zTBfsoJb7MnEa6dKSb0I3EVSXDCgPMtncxBG
 aJVw==
X-Gm-Message-State: AOJu0YzEuFlabHJk6p5Zfaxc7pMgor0ReraREUZZ4fRWttvmR6QsU4J6
 NUdhXSOWJEFVUHURgdv00yG/bhPVvj8WmOeHSNeL1YTCJWMsKrruaXwzaXgQn8Cx5ddV3D2j/Gq
 wrrju
X-Gm-Gg: AZuq6aKiSKtDir+3Dcz1PANoVS12btNiL7ORonJU8n9aEQZd0xWCRbthXmY9/MCoQMW
 2JvbKRUfir3AcBTjmtvCwANfMTMyUNiFe2aY0PsayO/V1VFA9WC5b5Edhp33HW2C5knJ0MYGFb4
 sLv0u5HHYLTFXOkSXEnnlBmLI7Dmtatb3zHu6/1CcMQ7R9GrK96+0nstZL4QNjMHGhaX37jNYS1
 rZ/5pW2jqD/rl6SyEbV16ZiFw0aqtuN0yBwCDk5dhM2N0uQZ37jZv945F/54lOL0IHRb5GjegU3
 i2SRopI7LdR9W3J5N+rmPXAKdkRcH4ujum/jASLqklFbYqkun05+CrPSGI9s2lEJW8NjVsnMzjM
 62wg0CJ1FC/5sOoHMdovRH5sb83ZRFpNDCsbZuGKyQduotZqmLq8/L0GvzXCzklErFfjG4vrDEQ
 0xeHdMwpRcW8yLwXnAh8INqXVKdvX1vtcsd6EW7R7EV/3T9BUn7w==
X-Received: by 2002:a05:6000:2409:b0:430:fcbc:dc4a with SMTP id
 ffacd0b85a97d-435c9b1f2d7mr8788727f8f.19.1769450891837; 
 Mon, 26 Jan 2026 10:08:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02c91sm31845864f8f.9.2026.01.26.10.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 10:08:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 00/13] net/pcap: improvements and test suite
Date: Mon, 26 Jan 2026 10:06:37 -0800
Message-ID: <20260126180807.100891-1-stephen@networkplumber.org>
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
  - Advertise RTE_ETH_TX_OFFLOAD_MULTI_SEGS capability

Bug fixes:
  - Fix multi-segment transmit to dynamically allocate instead of
    silently truncating packets larger than 9K stack buffer
  - Change Tx burst to always consume all packets; failed sends
    increment error counter rather than leaving mbufs for retry
    (pcap_sendpacket failures are not transient)

Code cleanup:
  - Convert internal flags from int to bool
  - Remove unnecessary casts of void* from rte_zmalloc
  - Replace rte_malloc/rte_memcpy with libc equivalents in osdep code
  - Include headers explicitly rather than relying on indirect includes
  - Remove unnecessary volatile qualifier on statistics
  - Reduce scope of file-level variables

Testing:
  - Add comprehensive unit test suite covering basic operations,
    timestamps, jumbo frames, VLAN handling, multi-queue, and more

v7:
  - Drop MTU configuration patch; not necessary as underlying OS
    commands (ip link, ifconfig) can be used directly
  - Add patch to remove unnecessary volatile on queue statistics
  - Add test_link_status to unit test suite
  - Add Acked-by from Marat Khalili on patch 11

v6:
  - Rebase to latest main
  - Address review comments

Stephen Hemminger (13):
  maintainers: update for pcap driver
  doc: update features for PCAP PMD
  net/pcap: include used headers
  net/pcap: remove unnecessary casts
  net/pcap: avoid using rte_malloc and rte_memcpy
  net/pcap: improve multi-segment transmit handling
  net/pcap: consolidate boolean flag handling
  net/pcap: support VLAN insert and strip
  net/pcap: add link state and speed for interface mode
  net/pcap: support nanosecond timestamp precision
  net/pcap: reduce scope of file-level variables
  net/pcap: avoid use of volatile
  test: add test for pcap PMD

 MAINTAINERS                            |    1 +
 app/test/meson.build                   |    2 +
 app/test/test_pmd_pcap.c               | 2334 ++++++++++++++++++++++++
 doc/guides/nics/features/pcap.ini      |    8 +
 doc/guides/rel_notes/release_26_03.rst |    9 +
 drivers/net/pcap/pcap_ethdev.c         |  474 +++--
 drivers/net/pcap/pcap_osdep.h          |   23 +
 drivers/net/pcap/pcap_osdep_freebsd.c  |  288 ++-
 drivers/net/pcap/pcap_osdep_linux.c    |  118 +-
 drivers/net/pcap/pcap_osdep_windows.c  |   95 +-
 10 files changed, 3180 insertions(+), 172 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.51.0

