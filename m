Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C251CA5FE0
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 22:00:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CC0442EFC;
	Sat, 17 Jan 2026 23:00:38 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 6F81242E6E
 for <dev@dpdk.org>; Sat, 17 Jan 2026 23:00:36 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43246af170aso1740120f8f.0
 for <dev@dpdk.org>; Sat, 17 Jan 2026 14:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768687236;
 x=1769292036; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KHoNMRMKCTzx9pNLcWIFjqRdohPYBA8TRlsCDxKaJ/0=;
 b=Za6dDX5r77GHd7iqBs9/ZIHCRZzII4RCu4myRsmUqj4ruu3511O/3PXHoriEGyz0yM
 rUj4/o/Xm5Pq8zBnFmDbbJqZZATEF2GswrdW0UIBMK6Nh/kH6RJqvG2LT7IH3SH06AdP
 j0QSazrNwcwyf4jitwRzHD4OKeFuMrCZu5hbY9OMAcNTF5UK7B4eT7aw8JOxLQr5mJFO
 laRGPJX6Qqe18EreHiB1I9l5AZRHMtCRxZSeopIz2OBKx6oMSZFBJCO6v0hZVt1XdSOT
 0PS5OxBOlRdDBF6Q74j/gUo7MtZsjOSdHON1rztNF3J51RQ2ipBt+3DIozYKYfV0CXcZ
 F6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768687236; x=1769292036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KHoNMRMKCTzx9pNLcWIFjqRdohPYBA8TRlsCDxKaJ/0=;
 b=DTvLlcjV6WkNVKr0e6kQhfqBCAyuFtPC6/iexMII3mZitGRKRVDiDwLuYJwunl6r8w
 Q8y2kudQfvuPR201Au+EIsgh9bpfCJw5mRKJKDFm10rdvLjOJS8kS4cqPLHcxjpTVXCj
 muW9PvNAdQVBFTKhG1ZT45lTB07QNhVoPmzCK7IakYaeTa0EEj8xdJYzQDi0t9KEeNXW
 c9/RNmXQaUHcb639Hl6mNlP8IiPxDRScOVAFAMpuQTC2Jdc7vfnVnjlk4pp9rcVuW3Md
 E8wRHmiSVpflAQiHXUgWsSQesKf77qCMdC1+D0VbE2LHkCA9TMsZKG1tIbEPlXSj7RdW
 wP9g==
X-Gm-Message-State: AOJu0YzqSgNkEMr4zwyhnaXrY3V+lvcU6HR1LzKDZJ4RmXmzcoZwkUrx
 oC2EqXQ8FNf1HPHpWPX5tVEhChz5sV9VNVTf14Whv9dXt+n8XdYmd9dPpJX0kbB6rlmyGTCPnQI
 vvSOD
X-Gm-Gg: AY/fxX6T0VH3eIQZhiWRRXh/18LDaZ2hW96lwfZVyw0KdKuemJta0nwlFaKTrYJw4Ao
 eKdbSZ/taOcE8ZdUtk0Ss9niO2GIDt8WHocCjHHPy4/o3IohNVX4X+YXRC6Xw4SKHeQJquiIM4l
 yTQk8OyW4YwTh89ofGW3uuDvv4rDEKDWs+I8u/9cKTk/MJ78FGvI/oT6LXzcrpJresCjFubEJNd
 FJOR2GFe5gLyzsAW/v7BERGA3ms2laaPIBFZfMOeN5LfqsGceMdv5eY3zSUCo3joWVTDK/4TC6t
 MzihSJ7yhYPs9IAttOb4qTPbvBEI8KYigQG1pfetlHvcHVVswFhu7LtQ9GUR4F8SQQ2dyegA1iC
 vpL1E+3a41SPA2lgANFh5hRFSBrv7bM6NgivCMS23zfm+JLVAZyy5fNordUmDexn9XdAPuTkCd/
 h9s1WCE75Uc1i6F39kis2MP4kOOv1PAcnjFxw46RBWSj1jmq7Pkw==
X-Received: by 2002:a5d:5d0e:0:b0:430:fcbc:dc52 with SMTP id
 ffacd0b85a97d-4356957ac58mr9627378f8f.30.1768687235760; 
 Sat, 17 Jan 2026 14:00:35 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992681esm13309352f8f.11.2026.01.17.14.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 14:00:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 00/11] PCAP PMD improvements
Date: Sat, 17 Jan 2026 13:56:59 -0800
Message-ID: <20260117220030.273471-1-stephen@networkplumber.org>
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

This series improves the PCAP PMD with new features, better code quality,
and a comprehensive test suite.

Changes:
  - Update feature matrix to reflect actual capabilities
  - Replace unnecessary rte_malloc/rte_memcpy with standard libc
  - Fix multi-segment transmit handling (was using 9KB stack buffer)
  - Add MTU setting support for single interface mode
  - Convert integer flags to bool for type safety
  - Add VLAN strip (RX) and insert (TX) offload support
  - Support nanosecond timestamp precision
  - Localize global variables where possible
  - Remove unnecessary volatile from statistics
  - Add comprehensive unit test suite (18 test cases)
  - Add release notes

The VLAN and timestamp offloads follow the same patterns used by
virtio and af_packet PMDs.

The test suite covers basic TX/RX, varied packet sizes, jumbo frames,
infinite RX mode, statistics, MTU configuration, timestamps, multi-queue
operation, and VLAN offloads.

v4:
  - Rebase on current main
  - Add VLAN strip
  - Add release note
  - better multi-segment handling

Stephen Hemminger (11):
  doc: update features for PCAP PMD
  net/pcap: avoid using rte_malloc and rte_memcpy
  net/pcap: cleanup transmit of multi segment
  net/pcap: support setting MTU
  net/pcap: use bool for flags
  net/pcap: support VLAN offloads
  net/pcap: support nanosecond timestamp precision
  net/pcap: remove global variables
  net/pcap: avoid use of volatile
  test: add test for pcap PMD
  net/pcap: add release note

 app/test/meson.build                   |    2 +
 app/test/test_pmd_pcap.c               | 2263 ++++++++++++++++++++++++
 doc/guides/nics/features/pcap.ini      |   10 +
 doc/guides/rel_notes/release_26_03.rst |    7 +
 drivers/net/pcap/pcap_ethdev.c         |  376 ++--
 drivers/net/pcap/pcap_osdep.h          |    1 +
 drivers/net/pcap/pcap_osdep_freebsd.c  |   37 +-
 drivers/net/pcap/pcap_osdep_linux.c    |   21 +
 drivers/net/pcap/pcap_osdep_windows.c  |    6 +
 9 files changed, 2586 insertions(+), 137 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.51.0

