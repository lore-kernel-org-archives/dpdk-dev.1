Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0518EEA71A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 16:11:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF4DB402D9;
	Sun, 19 Apr 2026 18:11:04 +0200 (CEST)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com
 [209.85.160.47]) by mails.dpdk.org (Postfix) with ESMTP id DA62840291
 for <dev@dpdk.org>; Sun, 19 Apr 2026 18:11:03 +0200 (CEST)
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-40ef10ec84cso1924218fac.2
 for <dev@dpdk.org>; Sun, 19 Apr 2026 09:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776615063;
 x=1777219863; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6sB2aAx8NlOdduyAvlXcdCLtECIHc8Hn8NRA/1nhR8=;
 b=e67YaGbb/MZaZJHwdO3IlOEEJBrp65Qh9rqLnyArYL0bUL3gazVx5C6kLg7+TWvCLO
 5O2DO5pe8Ql0HnDEMtB3wS8lD47r+E4BXhq1bie1twfLEApVe3jOlI/4cktAS/9imv5U
 Nn8/Dmnkm+EsLtnhhIC8GEKXOyUjlgcrLgumnW9FoWkhAzL4ZA+08BmRmKfru/o3+ubs
 qsTOAtOwh/iZfRoKwh6Y+Y5p7KiASSM5nnomfynwQs3n2ZPDK4jc2t7XEXwat4+Axx7+
 zGzESfwl1QON3ZNff62KSOyXm6rEsV0i+FlRgItRGuHdZjSGGDfPJUNhx0YQC09J137l
 Zi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776615063; x=1777219863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j6sB2aAx8NlOdduyAvlXcdCLtECIHc8Hn8NRA/1nhR8=;
 b=IyvUtbW7uezu9O8x2Tv16iGy/zBv74Pcyaol5bB0Ab2A0eIG5+CD7LKtmnsN+yBjlp
 WXvamVZtaowSUv1gpKh3dx4Bd/j/D7o43J6pAcHSunsRGXHcNTreoMp/3lQuHPDPXXJc
 wHES072uxrXPTqsjRJKOHJ5YsBgEAo8j7jZw5JNI1GhshFOvk3lNbG/31jjeimiBeBnz
 mX1LlRP/3CfRZuRDOqTjbr+cjddqQDsHlFA3Uc/TZqp3IqnDRcPjfleNm/CtofpAhaj7
 pSBUu5KZEH41Es9HmPUokW1CE3plJaMdjwL47MXofCmtVMLa/M5ZopCOUuy6bo297bRp
 v3lg==
X-Gm-Message-State: AOJu0Yxhx6QH+VvdSXELICAc4ECMYc8/j41IJDq81PEaiQA75HmRIvpN
 6S/KgNvUMDP2uoc7cgFmbtWM94dapwCjbKyGBRepVEgrlxFzSgeB+L1a2Z7GRf9v3sxFIyxyurX
 sR2GY
X-Gm-Gg: AeBDiesOzpVVMrR2DtZG9SSIhIznnhs7muSIW7xxVMmmfHSrhb5y3pOu7Y0kdsC9QJ4
 8+aA63CMit7+m0JtXG2gTRPjso/s6HhayYO4AdVfNV2wd1pJd4649Gg4awOrMpjPVa5NRxXNsi1
 i7LYey4tBF6CmGS7TxQNyKiVL7EJ71Cp5TzVd9ZA1hP+4iGD60CDzgwWUCn0qnW8lvq0cMoBgfw
 JYayeNyDMTaYA7iiQtiPYlmVSm0ZDoPuZOsNL8dreGfEfiEkMOO62uyzQp25OooDTAzewxGjWnl
 5CHZKCkepEFTd4j4XzXGWEKLDoBIqWTUKlXYOnukccZPyc73kgHg/lvXUzXurR6wjo55cORAxZt
 d0R1XQUygJ3LoQL7adFYJqDPfFa7PpisnO5OGjBN4Jr9eVwtG6jxEai31iRhRrNUqiDoTM/15sZ
 ppCYxqo6iFdRhu1guMJXAP6xkcK6snafVCNirdN5mKKcKjBXdu5+5q2A==
X-Received: by 2002:a05:6870:9619:b0:41c:5a3b:1afd with SMTP id
 586e51a60fabf-42abf2f01bemr6128372fac.13.1776615062939; 
 Sun, 19 Apr 2026 09:11:02 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b930bca47sm5970632fac.7.2026.04.19.09.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 09:11:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v25 00/24] net/pcap: bug fixes and new features
Date: Sun, 19 Apr 2026 09:09:33 -0700
Message-ID: <20260419161059.205954-1-stephen@networkplumber.org>
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

v25 - fix build on one intermediate step for bisectability

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

