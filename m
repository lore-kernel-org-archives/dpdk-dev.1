Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86320E83837
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 21:43:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7660E40289;
	Mon, 16 Feb 2026 22:43:18 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 93CEC4026C
 for <dev@dpdk.org>; Mon, 16 Feb 2026 22:43:16 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso7942115e9.3
 for <dev@dpdk.org>; Mon, 16 Feb 2026 13:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771278196;
 x=1771882996; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FqTmdBGVyP0Q+3EpJdei7EPt3fM2OxEY2kiCppDT5iY=;
 b=RBnttXFU2lKr0i8gUnl5BCw1yeIwDiMjiElZcvCATjAvm56ELstuazKUcVoCED5BOO
 UW661IxlaH46K07+URoWdvY900Rh7Ci+w3tRzo2yMXTOtLm1wBDE/JX1ZKKwdCXE/Byd
 NkCKaVZ0pobq3/Zwao5fK67yZHlYWOLYX5pMS7i3QQ1f7CzZuiOHIVDL3l+CtsRXtWf+
 emQLKbY03vpHc/JrtuyOdc6uNryufLlObt2YB0ZZ0RltwddK7z5dZA4SxZG4WFN+iJxC
 OoA1vwWIX/aKBdahNO6E4DkN6N5Fo0dzMK0PB2R8lmk/SIah4DDXUyUnbnIdfMRriFsw
 vVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771278196; x=1771882996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FqTmdBGVyP0Q+3EpJdei7EPt3fM2OxEY2kiCppDT5iY=;
 b=A6OpA3yhPP6EfPpyv8TOBD4g3VRSMSHbU7Nix/hMQ6DK1tEH5aI+5jg+opjegoW2Yf
 81b1xea7qRgxLp6jS+qUs/eCA0DzDGMRGfZfsMPasRgx2JiHC//PsfyeBvdn5QWu+U0n
 XnZpfV81SCee8Bla1H0d+E4XYnq0rOMtnrwch7HlMR5BbWTTaD8YLEFwivNQugHfvknY
 y4sgp6DhEgIWdIfLp7XeAlNhPR8NANvqCmsxjvGdZ6gCQMUjDHW8Xoi6wo+VscjsrRma
 shqf32ftAyMUqHp9F0ulSc84oY3Nw8Pz943BNR/x1Xshn/53O8BkVtIhqqt8sKMZ5/vP
 x/9A==
X-Gm-Message-State: AOJu0YzuNicEJVIEAazmL9RRtQRIIgqvjSw0gKjmyslm1HyE1NMgSTKp
 K/LUtAeakuCxz++N+d+AKBCWYkSEgLaOT1OeL5pBcgCwyCtruHJtPNjtoGZoIpoPHq7ruBlsgWU
 tVtgqTeA=
X-Gm-Gg: AZuq6aJ1mrEv50etJBLAar2SkQQNwCj+dIg++zx6FO3O+PJn4Dd78opf04sXTqhm3mL
 1khPf+WlurAZdOh41sL7yGWdKe7ksrx4X/zw5UoNJ+UJTHZE0C/wBQ6i+DhyWMrHSrYD2TAA/Oy
 OPbjRrEmhInQHpcnA9uJuuJa/Qljkyl9bOHFJnCGFtuokMchNFOYTcjrZYuQckm/1Sz/QMnTXGK
 9YVe4RO6J2frDEyVofcIJpcGntRJXKbdoDM5GUgVg1y9lu7712HjekRrKdKwQ5K1kQApTcOR57r
 dl4EOtt1zoC4m07ScWOJD4FCGVVQBD61/W7N6T24bnUyqkXQ5kOqZA924dw1MlFpOfUzTeVchAK
 xNKMOvTCVBJDlXZSY8CtMyhvQL/WPjg1GNvYrxld+GfRuRaoEBSKChcOocLdxa8E85jir9xLHav
 lxw0C2k7PY89EsNP3S6MAVSywWD8F84RVsYCfefp7V6vkwnCilURmT1Leao7QV9A==
X-Received: by 2002:a05:600c:3b10:b0:480:4b59:9327 with SMTP id
 5b1f17b1804b1-4838c063f8emr40252495e9.1.1771278195844; 
 Mon, 16 Feb 2026 13:43:15 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5ac87sm32146354f8f.3.2026.02.16.13.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 13:43:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 0/8] pcapng: fixes and improvements
Date: Mon, 16 Feb 2026 13:37:57 -0800
Message-ID: <20260216214311.717492-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126210615.175816-1-stephen@networkplumber.org>
References: <20260126210615.175816-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Fix string handling in the pcapng library and improve test coverage.

The pcapng format uses 16-bit length fields for option data, but the
library did not validate input lengths and used fixed-size stack
buffers that could overflow with large strings.

Patches 1-4 add string validation, dynamic allocation, and return
value documentation. Existing return value conventions are preserved
to avoid an ABI break.

Patch 5 chains an additional mbuf segment when a comment exceeds
tailroom instead of dropping the packet.

Patch 6 replaces per-packet timestamp divisions with a precomputed
reciprocal multiply-shift.

Patches 7-8 improve test coverage and fix the build dependency on
the null PMD.

v8:
  - Split patches for clarity (typo, Doxygen, validation, malloc)
  - Preserve existing API/ABI — no error return changes
  - Drop dumpcap patch (no API change to handle)
  - Truncate overlong comments via strnlen on fast path
  - Defer port_index update until after successful write

v7:
  - Add meson build fix for disabled null PMD
  - Add dumpcap error reporting improvements


Stephen Hemminger (8):
  pcapng: correct typo in comment
  pcapng: document return values
  pcapng: add length checks to string arguments
  pcapng: use malloc instead of fixed buffer size
  pcapng: chain additional mbuf when comment exceeds tailroom
  pcapng: improve performance of timestamping
  test/pcapng: skip test if null driver missing
  test/pcapng: add tests for comments

 app/test/meson.build                   |   2 +-
 app/test/test_pcapng.c                 | 154 +++++++++++++-----
 doc/guides/rel_notes/release_26_03.rst |   5 +
 lib/pcapng/rte_pcapng.c                | 207 +++++++++++++++++++------
 lib/pcapng/rte_pcapng.h                |  13 +-
 5 files changed, 288 insertions(+), 93 deletions(-)

-- 
2.51.0

