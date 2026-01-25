Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C979FE63CBF
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Jan 2026 19:23:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A029240276;
	Sun, 25 Jan 2026 20:23:14 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id C996740269
 for <dev@dpdk.org>; Sun, 25 Jan 2026 20:23:12 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4801c731d0aso29942555e9.1
 for <dev@dpdk.org>; Sun, 25 Jan 2026 11:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769368992;
 x=1769973792; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JnUDnDEMdBcUm2CuLdtQi/EzeuUNcv+I5CfmkWO9UYg=;
 b=Kq5jHD2NtaWsYvP+Y2p3vf3KPiiMiSyyVKtPQv2HPPaF1cjQpUwXhafpLBGVqccgMb
 YK2l3rL9GoHPgjDRiBViMzcmXCWPibA10XkyqWsVCiYjiqbyhJyrBQP5VOGrB3XJ0Juz
 +4xYWWT9EKWSRfEgbLddTTdP9HA381LukfVXgjPf8ApC2Y1BxV8iA2lFaS0X3QxOHj7O
 dD/8DiCMw/riknQsQkV8duc92J9gzlWQop6WzzhpYHkeyNdiLqtERzXX2zzW2iOTnTbT
 cnBGklEB8+C+XiCG5bpRyl9O4WCJwTDgubCQi259FE7R47tE8faWnYsVrN3CSrDH1rBx
 r51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769368992; x=1769973792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JnUDnDEMdBcUm2CuLdtQi/EzeuUNcv+I5CfmkWO9UYg=;
 b=i8jkobb5UqcFHoHJf7gH2DgEK7b6ZDLApoaaSbRbgryTCBZCvgIt+cgOULBHQWXz5D
 AjoAsrBN4/2w2dsKV6PeWjIOhlM52RRHi2jWCQOQsa8lOszpnYWuu1pi0lA1BOT4A9Oz
 E+BgllONI0Tql1rUk7JCZvMptxLmaMISOZ9vj9RzmUvpPpLggAoKLFRWEhgfnVW+iMNW
 dVRtNqIDPQe5pkZjY5K5AU+kJYSNwCIYLNOHjVYwzLZZYE5pafTjdWCdO3LLYFV17Kvy
 4O5yWHBUZo5zrwCnFBmch1p5siII8i5C+93c8JXxOedQVlNjMTEwTvaNoi7Yefd+Glc/
 jINA==
X-Gm-Message-State: AOJu0Yzg1j9xJR046SulJ9DabihIyBjSLCVCPMG+P85Utxtlph6lYLox
 0AGkuKB0pQVf4b9LHDKbP8tQV28nfEPcTlXMOLF9KGL7nFYz0hh39xl8Z5U5Pl/sJZnBhqInTiu
 DC8zv
X-Gm-Gg: AZuq6aL337wF1yz8Dv8F9Tbt8GmP2ONQ295SJwFweLPnRKMQxCfgVqENBnKAFBnjDcF
 DTmiWdAosYwA30tiMBV3z0Le3aygfkgyMmUmqymWYW2ZdEu81hJXBX+bM5aHAbl3Tys+8pRRgZw
 Goi3Pq6YbWcdH/clknfB8wDuCVCOEY6af9PU3HX8zZvKO3N+EJSvrmrIwHpqiRv4dZVt3Yr8MD7
 3+tr2gIgj0sSGEsACED/wgjzvbvLKNE7EjUxcj0dThbJc2/zsXNxqGFoP7EMGoMreL8dgR1c6o5
 zjSllZJocDa6PV83UWo313hHMirtKa0+HSh6bxAiFLrtnsWkQ2+RFgSIgKIeop3+XPR4+s3XP0R
 sT+Kqs0AOs+gt1Qqs6M8Inv8fRDcvJLjWWZVX8E7BP9zGa7dPFi3RFLHOGnd0kYql/hCZM/mVWj
 HfAgrIocSnnX2fwVHgtRhaYF02sE5GDUb4Z6zj8ueW9BrVT4foU3OLcH7ROhBt
X-Received: by 2002:a05:600c:8b81:b0:480:52fe:58f5 with SMTP id
 5b1f17b1804b1-4805cf6e244mr39599195e9.31.1769368991975; 
 Sun, 25 Jan 2026 11:23:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b4d8sm22854362f8f.38.2026.01.25.11.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 11:23:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 00/13] net/pcap: improvements and new features
Date: Sun, 25 Jan 2026 11:19:58 -0800
Message-ID: <20260125192248.497563-2-stephen@networkplumber.org>
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

This series modernizes the PCAP PMD with bug fixes, code cleanup,
and new features.

**New features:**
- VLAN insert and strip offload support
- Nanosecond timestamp precision (using pcap_create/pcap_activate API)
- MTU configuration in single interface mode
- Advertise multi-segment TX capability

**Bug fixes:**
- Transmit now always consumes all packets, counting failures as errors
  rather than returning early (matches other PMD behavior)
- Remove silent truncation of oversized multi-segment packets
- Replace large stack buffers with dynamic allocation

**Code cleanup:**
- Add explicit header includes
- Remove unnecessary casts and rte_malloc/rte_memcpy usage
- Consolidate boolean flag parsing with input validation
- Reduce scope of file-level variables
- Replace volatile with proper atomics

**Other:**
- Update feature matrix documentation
- Add comprehensive unit test suite
- Take on maintainership

v6:
- Add maintainers patch
- Add patches for explicit header includes and removing unnecessary casts
- Fold release notes into individual patches
- Improve commit message subjects for clarity

---

Stephen Hemminger (13):
  maintainers: update for pcap driver
  doc: update features for PCAP PMD
  net/pcap: include used headers
  net/pcap: remove unnecessary casts
  net/pcap: avoid using rte_malloc and rte_memcpy
  net/pcap: improve multi-segment transmit handling
  net/pcap: support MTU configuration in single interface mode
  net/pcap: consolidate boolean flag handling
  net/pcap: support VLAN insert and strip
  net/pcap: support nanosecond timestamp precision
  net/pcap: reduce scope of file-level variables
  net/pcap: avoid use of volatile
  test: add test for pcap PMD

 MAINTAINERS                            |    1 +
 app/test/meson.build                   |    2 +
 app/test/test_pmd_pcap.c               | 2263 ++++++++++++++++++++++++
 doc/guides/nics/features/pcap.ini      |    9 +
 doc/guides/rel_notes/release_26_03.rst |   10 +
 drivers/net/pcap/pcap_ethdev.c         |  383 ++--
 drivers/net/pcap/pcap_osdep.h          |    2 +
 drivers/net/pcap/pcap_osdep_freebsd.c  |   36 +-
 drivers/net/pcap/pcap_osdep_linux.c    |   28 +-
 drivers/net/pcap/pcap_osdep_windows.c  |    6 +
 10 files changed, 2591 insertions(+), 149 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.51.0

