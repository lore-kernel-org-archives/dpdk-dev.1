Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBA3E63CBF
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Jan 2026 20:24:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 283004026F;
	Sun, 25 Jan 2026 21:24:33 +0100 (CET)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id F0F0040269
 for <dev@dpdk.org>; Sun, 25 Jan 2026 21:24:30 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-432d256c2e6so3774317f8f.3
 for <dev@dpdk.org>; Sun, 25 Jan 2026 12:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769372670;
 x=1769977470; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I3Oy7n4T70FKlNpY3i2vT3V/Z2s1n6c3V1qdfbdFKFA=;
 b=piwg6bkTDlaGGR4lD6qFvL3MTIcvhjV+aQsBqyraFrABsDlJ1bzeeYxRT7RrdZVVw2
 WAIZKEO5/RkIgiN1phadWC47US4XKMKRo2SesnoQGDPHnG5zke4yGF+0D3HZoHWvFXfK
 QC3BFOFXv+T/4w0sdx6PShRU2oRfOBEBRnX5QutIgSQf9N4HE3iqDaNvSUNl8vn1flE/
 0CNwiAZd7byNGReAnnF/iS0Cx4B3SGRdio3++W0GCa8oFRmvyt8Y6+o0HMXkevrLoaU7
 Zchx+DO9fE7IXMoSr5oi/w1U1Hyc1xo5tOZbhSKQAJuXzTzyb0q7Eztcj967BEhMo/is
 gtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769372670; x=1769977470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I3Oy7n4T70FKlNpY3i2vT3V/Z2s1n6c3V1qdfbdFKFA=;
 b=Ux6zy3tYk4UIHmAqXewcNR+O3iNP92e3crMx9+AzUqI7PaC/pFFaAWTW8r8pSpk+Nf
 3488WX//aeqT0NuqLs+KnhER3Ra4rFiyoLbAbBNonjZc5lDDX2ilyoOpANhuQv96VB0B
 DTT+YH9l5Vzrr9dXm6suBFmgqIgEbRWkJlcHAiFboS9bEdrbK8gWyNYrJOYIC/PG2N9Z
 gAZHGOeqyKUj0TZ/jmWqiC4kBuY1RxRTgySNG1rN2jvEORHoXc1Ocj5/ibb9GCzLdLO8
 h9HrXXmk+bjGK0Uvvd3QrnCx5Q1hVMnN6RQaMgB0+0fSkJbCrcYz/K3/Oeu/kHKF2Puc
 PZBA==
X-Gm-Message-State: AOJu0Yy3UkIz5+SJG0J51+yvpPS8uk9Iq5V1TLjXFGR//W+PScgR9H57
 YTfXaKub0ql6wfHJlVgpT13uNGogjfLNVDv+eeHoima3Mi85btXXv7W5FMsIp5Cnk3/faCQUYdx
 ZjgjD
X-Gm-Gg: AZuq6aKiflUJrYSWLjrN0Rb/wm8n/E8zZKkGc0VGhW2hc+eQ8IJBLg0MvjyIkWfPEyC
 q0WwY7LccvP/oS3kYY57gl3rek8uWIsSHCAwsD4QfF1yz6r/ZhYVoTUyr0iq+wDzBGWGtNvamxR
 16So2MVoGISSk1fUXGxcBQXZCkr3ppaJjqqbnmKqu3ClnrU79oTMLDSxLOCEI1iRebmZt6G2B5z
 LchqnMYSnTyYustRLPpqIi+N8LSWjZyyow2NM0WzO3WSGEG0lRbXhK59jHmQlG1UH0rmfFBc0gQ
 59XnuZDFtOsWbSufhBntL9WVlVcltu/NsnF18u54hsk7y7y0SbNn1nd3V6pVzJFcnxWRLTQd5ZM
 pn7gN70w+sa6bBfW9UJ/jLlxOauMaZLw8Dvmyw7WX3RU6le1hWgzzWdAJofqcCLs/9ab1SZ8Ux6
 L5uB/LcZ79JAL9G9Kumu95DiiEWAY98c74kA+VdVET5qeGhpvGWQ==
X-Received: by 2002:a05:6000:2502:b0:430:f3ab:56af with SMTP id
 ffacd0b85a97d-435ca399121mr3948937f8f.48.1769372670357; 
 Sun, 25 Jan 2026 12:24:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24bedsm23682024f8f.17.2026.01.25.12.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 12:24:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 0/5] net/null: improvements and bug fixes
Date: Sun, 25 Jan 2026 12:23:00 -0800
Message-ID: <20260125202425.532542-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260104222523.329760-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
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

This series makes several improvements to the null PMD driver and
adds comprehensive unit tests.

Changes in v7:
- Added release notes to patch 1
- Simplified test code by using single-line comments and struct
  initializers instead of explicit zeroing
- Added two new bug fix patches (patches 4 and 5) that validate
  packet size against mbuf data room constraints

The series:
1) Cleans up the info_get callback by removing redundant argument
   checks and using proper constants (UINT32_MAX instead of cast).

2) Extends the packet burst generator to support larger packets
   by changing type from uint8_t to uint16_t, enabling better
   testing of drivers with various packet sizes.

3) Adds a comprehensive unit test for the null PMD covering RX/TX,
   statistics, custom packet sizes, copy mode, no-RX mode, link
   status, device info, RSS, RETA, and multi-threaded TX.

4) Adds validation that the mbuf pool passed to rx_queue_setup
   has sufficient data room for the configured packet size.
   This prevents generating invalid mbufs in copy mode.

5) Adds validation that the packet size devarg doesn't exceed
   UINT16_MAX, which is the maximum size for a single mbuf
   data segment.

Patches 4 and 5 are marked for stable backport as they fix
potential issues where invalid mbufs could be generated.

Stephen Hemminger (5):
  net/null: cleanup info response
  test: generate larger packet bursts
  test: add a test for null PMD
  net/null: add check for pool vs packet size
  net/null: check packet size argument

 app/test/meson.build                   |   1 +
 app/test/packet_burst_generator.c      |  34 +-
 app/test/packet_burst_generator.h      |   4 +-
 app/test/test_pmd_null.c               | 916 +++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_03.rst |  10 +
 drivers/net/null/rte_eth_null.c        |  21 +++---
 6 files changed, 959 insertions(+), 27 deletions(-)
 create mode 100644 app/test/test_pmd_null.c

-- 
2.51.0



Stephen Hemminger (5):
  net/null: cleanup info response
  test: generate larger packet bursts
  test: add a test for null PMD
  net/null: add check for pool vs packet size
  net/null: check packet size argument

 app/test/meson.build                   |   1 +
 app/test/packet_burst_generator.c      |  34 +-
 app/test/packet_burst_generator.h      |   4 +-
 app/test/test_pmd_null.c               | 938 +++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_03.rst |   8 +
 drivers/net/null/rte_eth_null.c        |  21 +-
 6 files changed, 980 insertions(+), 26 deletions(-)
 create mode 100644 app/test/test_pmd_null.c

-- 
2.51.0

