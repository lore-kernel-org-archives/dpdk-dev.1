Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7322EC83F09
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 19:10:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54F5440649;
	Tue,  8 Jul 2025 21:10:03 +0200 (CEST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id D1A9D40292
 for <dev@dpdk.org>; Tue,  8 Jul 2025 21:10:01 +0200 (CEST)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-7d3f5796755so459066085a.1
 for <dev@dpdk.org>; Tue, 08 Jul 2025 12:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752001801;
 x=1752606601; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+TnoWMu6VRs3htIn5ZOGEt+f3T0oPe3+lYM0vDuwLiA=;
 b=E0HqPeH40m4VDktHJ1NBwUkNLZeG/T8XTGKI8NRq6COT4FtOx8V+6QmcQI2VN+QScy
 zSjq8/lgRIo5oqTEM1Je2LRn6Oa4iPAmTcgunfeVX8TMnjL2cIiweBpI/uq0Jb3R01Sy
 dJf70SCYrLZzztXDeiLb8xg3rzSRMBIhQVOl6nab4SCpJjotc7OxriQX0H7BfYhfYIAc
 CBzS0fVLmF/dwzqg0/c+vUSSUVJOxJcBEo9oIejRdiJcigdOuOXQ/LHeNhuPMK6H1lxx
 as0y+KQdBaYoZdBqiVvVMNT+fzCNeYv9ZT38LWtuPNeQ3e/N1oztJoiBcbr/ztKXTwS0
 m+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752001801; x=1752606601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+TnoWMu6VRs3htIn5ZOGEt+f3T0oPe3+lYM0vDuwLiA=;
 b=wK3aUcRJibllIBXpuBow4FN3z4vd1zm2NnvpDtuN/4NtyjdRcKDMVzlc76PfakOsQN
 ZcSrq/dMPokC6yAAQQTk1HmZA/G/juBs/jlyY1d2GepiUO/l2PW8R/TcJkEGfBWPMB5S
 T+y6L5emtACL3pbEFoJx+eXwKJsXUmI3nJXui7mni5r5EH2ilmh3LyS2KxjmXnYbB+NX
 q4DVjwTLHD5fABHxuBzzg+sNZTgGtIwx3hcEt3h9R/O1y4b9Zx0I95sm3epdJZa+GCS8
 ixHMwduawmQreeQQujaOLoZk4XZGwvTCP7oPhdPYNwdR99o2vUsza2UyMdHdvVimAO8h
 toag==
X-Gm-Message-State: AOJu0YxA1SkxHPVj5yQXPVxitrhcXg8Nn2lIZzQOVgmf/KsSOX0rt2vY
 yyBLkUGpJaml3Rby1tu1vJt4VDHEIQ0byp0UZdeVRiO9Lmx9W80wN0ouCbofpXXFJXeRchswntA
 g4JkD
X-Gm-Gg: ASbGnctKZZNsa+ifXfrNFaGuO1zaWm9vVVz8MoSGjGJi3ewVU00pILcN1Z7rmlrmq83
 9d01yiXllB0E7E0lYDoGE2HicpJ7nFBWUeTHF9DjlFIaf4LHJADBRtmpDN4L96cueZzQQoC8zMt
 XZttVbioSnP2N8Q1+FilXXP8NwiYyhdurOTMACluolYVesA3Myo/sWqwgyrfiyRNwD/0pE4rhJ6
 uM/aqvYrSFoZMgfT+vVLo4MZdJmTbpcS+ZhNSV3duaYn0qauyJotujN8riYjj0ybJKgst8gFj0K
 HDDNDAFOfx2Oiqnoiuy5it1bodfdfSqBFOEGkoBefpEOlEp6I8l+7AbU++5wfpQRK/L423BPf4I
 SH2yiLo0FWN79YR4jPfOusCBZfcwON5atDE6WjiCxbQTCgyo=
X-Google-Smtp-Source: AGHT+IESAf07UPQ2edkZz5BLjFCQ7k0dfMXRW7dr2OpYWzixaaRMW/hhRZcpiu5OLPpUpiae+LofqQ==
X-Received: by 2002:a05:620a:bce:b0:7cd:3f01:7c83 with SMTP id
 af79cd13be357-7da03a750efmr594912285a.39.1752001801118; 
 Tue, 08 Jul 2025 12:10:01 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d5dbdc9f16sm821109685a.52.2025.07.08.12.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 12:10:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC] add hints to CLAUDE
Date: Tue,  8 Jul 2025 12:09:41 -0700
Message-ID: <20250708190957.10108-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

Soon users are going to want to use AI code generation like Claude
with DPDK. There is a convention for giving hints to AI tool.
Rough first draft

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 CLAUDE.md | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 CLAUDE.md

diff --git a/CLAUDE.md b/CLAUDE.md
new file mode 100644
index 0000000000..42dd2e2ade
--- /dev/null
+++ b/CLAUDE.md
@@ -0,0 +1,33 @@
+# Project: DPDK
+
+## Project Description
+DPDK is a set of libraries and drivers for fast packet processing.
+It supports many processor architectures and both Linux, FreeBSD and Windows.
+
+## Licensing
+Overall project use BSD-3-Clause license with some approved exceptions.
+
+## Build Commands
+This is a C library project that uses the meson build system:
+- Build: meson setup build && ninja -C build
+- Run tests: meson test -C build  --suite fast-tests
+
+## Code Conventions
+- license is per file via SPDX-License-Identifier
+- use Tabs for indentation
+- closing and opening braces on same line as the keyword
+- braces that are not necessary should be left out
+- avoid using camelCase and PascalCase
+
+
+## Project Structure
+- /lib/ - libraries
+- /license - reference copy of licenses
+- /drivers - device drivers
+- /examples - sample applications
+- /doc - documentation
+- /devtools - developer tools
+- /usertools - user tools
+- /kernel/
+  - /linux/uapi - exported kernel headers
+  - /freebsd - drivers for FreeBSD
-- 
2.47.2

