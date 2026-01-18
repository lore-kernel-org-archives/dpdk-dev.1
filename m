Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1915D4A5F4
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 16:59:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C431F402E8;
	Sun, 18 Jan 2026 17:59:50 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 81644402D6
 for <dev@dpdk.org>; Sun, 18 Jan 2026 17:59:49 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4801c731d0aso19385425e9.1
 for <dev@dpdk.org>; Sun, 18 Jan 2026 08:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768755589;
 x=1769360389; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BOL2CcOS76eDS12i4tnlo/zmjQzq0D1xLfDPwOLZOTg=;
 b=N4l21vV54gG0udMVj55VnbA+JRDOHX5k3Htg/pfB8qZYiKrWydp0/nd0Al2OqfgJ1v
 dOS/ALgLPVaJf5IZ+Q+Pnyjif1bYsf0U1QG+LQrPpmYY8tezD37uau3LJ10g+smNiuyg
 AtXKEHjXiVrh2Cq7GnM98iRc4Cexuym9M6LJmNeFCz/eeaiqF9LoUSCmFjeKVR0/d0+X
 Vco/lVNgAqSe2jDMLW/1lJPAhzg0R3WPvImMePoz341ClUIYfMgzlG/v43pExLveiww/
 tHhJSfGWup62jqPnuE2qmjL6nGIhCeMR0/N0FamrQdQGisdcsbM/dYpBGHZq5BIC+REU
 4cAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768755589; x=1769360389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BOL2CcOS76eDS12i4tnlo/zmjQzq0D1xLfDPwOLZOTg=;
 b=WtACdfvw844xjBA5sPVdZp8KSZ0CygKgPjIJQNlyXikIxmAE9C7zeQQDrMiZGn9agJ
 jUbrhWRTrMmKyIrgxnJN1C1iw1mI46rXjoMkkdmI64tn1cKpBaJUs3nyQBMPC4saz3jE
 1COIC6AZ/BRKSA6Bt05FDDC9OydZTwZa/juII+IzF+IirbWrh3rClJ0Cj/ppqdkJobNm
 pcXNVd5zshkhCm32KGCNAEEmQyYtnDb+sipzlekTb8KHtp2XVcTamYiciywVxdZcSxYq
 RL+ODa3VjnA9Nl96vuBAkSo7W63hr01wI3qm+9a5i1ZGI6fiWC+rjj22mHpRG0ac0S+g
 d+Og==
X-Gm-Message-State: AOJu0YyTrbpvsVTb5A9fjPSgjSmlII8B9ekXaB7hdNmX960gqn3TwWpN
 /POMxtLH5RQsc4FywpEgkjdvgLxvm7aIhZGjeoxjVhPNSknQxTL2xIVyeY/A4vXEhuKWiAw368V
 u/orV
X-Gm-Gg: AY/fxX6eHBYBiz+nExkCn1nHJHVv7+46WHpDJKsvwT3GtzX5B5KUt/gRE/yYzXq+dZE
 NcNT4gzXMnOKWWPziDZA41W++y+p6Y9+QWLHDjNkvvKFKrZsmGEFdtaR5oBnQKfloekc4lTRWn+
 X0+M6sqXwP3sSSM+YsGzynt47OnaJ9zHFyQ8Np47vBfPxUrZUYLl/UAY/o5PB8T/jbZtvyTEfBS
 qCRMqaw3HdSierNW+XSuRlsdx5OUsF1nhMQJWDCegHJZxHpOXFLm+Y8OGsgbeLYId+6bc5k6BPt
 x2nZH8yU1q6op4MyMpe04CIfoL+QfJxECO2NqtgkC9ReK/79fJvkorBArhRHyRM7JHEWHba+rzs
 rZxHh2wW7gW6DuMW+/6mHm1JmW5xE9od0PcBxhEsnC1mbf/A7vYjifiLZfHHtXkvVgheYCDupMX
 pQJflnSNUuRWmMC454OCoJmGz4lr51j8dAv58WiwwFJ30rtYwo6AuOFwjumiGO
X-Received: by 2002:a05:600c:1d0a:b0:477:8ba7:fe0a with SMTP id
 5b1f17b1804b1-4801e343051mr121744365e9.24.1768755589059; 
 Sun, 18 Jan 2026 08:59:49 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e86c1b2sm146849365e9.3.2026.01.18.08.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 08:59:48 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 00/11] PCAP PMD improvements
Date: Sun, 18 Jan 2026 08:58:35 -0800
Message-ID: <20260118165944.41374-1-stephen@networkplumber.org>
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

v5 - fix typo in features table
   - resolve minor checkpatch complaint

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
 doc/guides/nics/features/pcap.ini      |    9 +
 doc/guides/rel_notes/release_26_03.rst |    7 +
 drivers/net/pcap/pcap_ethdev.c         |  375 ++--
 drivers/net/pcap/pcap_osdep.h          |    1 +
 drivers/net/pcap/pcap_osdep_freebsd.c  |   37 +-
 drivers/net/pcap/pcap_osdep_linux.c    |   21 +
 drivers/net/pcap/pcap_osdep_windows.c  |    6 +
 9 files changed, 2584 insertions(+), 137 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.51.0

