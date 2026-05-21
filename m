Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B70CD5BAB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 22:45:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CC0040287;
	Fri, 22 May 2026 00:45:55 +0200 (CEST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id DFE40400D5
 for <dev@dpdk.org>; Fri, 22 May 2026 00:45:53 +0200 (CEST)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-12db2e415a7so3329485c88.1
 for <dev@dpdk.org>; Thu, 21 May 2026 15:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779403553;
 x=1780008353; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ZUZxMJkzB485NFZ2u4l4gNKSgYF9yjo7twmGcH9HpY=;
 b=SFlQvPFovlS8s9q2MdAEkNX1XwHrWDLhB8NBOswlLJRl3OmYh6UOqiZ8MRiej9JKdI
 LXnWCNU1mjhxBztBNn/mkpaydzNgLM7ImHERJC+UxU2SHVpOfQNqiLvsZebEVN8ZdsPF
 QmKrP/ZUwUDy5qzQXAgxgsQs+bcO0ZOX2DGLo+l9hQcryNHC6Ty5S320jknfUPtcF596
 aUa3ClTvK6kQ+kmixlOiDGyre8FOVsTuwwQEbreFaIRmuEfN5OW40USb5bq5POfS6kee
 z21Hb8YkcvLYIEvqDdvdaCxo1ww6qHKzx6whGUjFh8Pjd7ZdXGK0uuorvgw79KM2EYh9
 YSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779403553; x=1780008353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3ZUZxMJkzB485NFZ2u4l4gNKSgYF9yjo7twmGcH9HpY=;
 b=UgYstoOFDBAwfxQhoh/U3hiZrzyrBEBQjYowa+tDBKp3ezbgcmJ/9CJJ/WJQTlT5jk
 yqbfctqdEt7htC8OLIKs/pBs7/0Vh8IkN7dmuEIRfK1+s/XXjlV8srOcSoVjef4LI9vA
 Dy8iTpDvhz8U7DMX92k7TzxwL52WSFFKWa0rL1147J2hVNViZi6717pfxt3d3NVfKcwk
 dJoiAW5NP0TiVX8HqNtC7sd4Uzrxhuj9QocRcO5JfPWh96Ux52mQP18tEnSUtoFoJEDU
 UsOdHawb8cpu3TV2Lpsl/NOvZmDsgNzDrLQZh9xIDidJSBPGt8xB4YWAMEkuyNuzRyHb
 ElGw==
X-Gm-Message-State: AOJu0YyN2hJpGxepqJNxMkpxLAsZKX+IIiIUt29EYfVvNaw/4OiUOdRG
 DSvQdfcnIefewdUCHGX3H4dFmhaGIyVQdgToPit+cxO1Cx7Q4ob9MAAT8fYmq3/45KsBohJLpOA
 7LOzj
X-Gm-Gg: Acq92OFDc6IIzYqbufEnNH5BFabMqXIrLdm+KAoBbQmDysBu1uxTZKNj6Q0urOw2MMt
 QHaJt/7KsNZMDdWwqfTqtt+AgMwcELYiyic4ZiPouL5b57VHPtDftzAEnlBqeDTndImWeRvmmSr
 G92+Uhfcw6L/jMWsFGeDtrS5aSmOSO6tAh3t6Ega9EAbrM3re22QwVOc35eaWEl5e+UJmzNj9WN
 dcTTzXGkmIdvo1HAebDYZ+3ghA037BpQCPgXDPawgIfBAS+pQUO2ij9CgMp8veqn9RaAFRwSXNs
 MKRWrv/y/MZFTvXE3L/XKdlfSvhqeRpIt7td6udcn7e7l2ofyBHce3AVzBjzVbEwR6rnh/bYNvL
 ZfMHJ0rOUuJ8vZZJjKkU7lPSpiH8ch49ZeaEjJnHWPmzZ0MM0NiWSUovr3VsKUu6r3Y2JUTymz8
 7qxMoriVfXR/vvM7Nczg8X7XVlJ3bkn49Ba/jzOrmAYBRsrp9s1L6a2s2HvfDYbCouTZbfJY5x
X-Received: by 2002:a05:7022:2528:b0:135:a6a:fcb9 with SMTP id
 a92af1059eb24-1365fb5a001mr474210c88.28.1779403552597; 
 Thu, 21 May 2026 15:45:52 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-136621d3ae9sm496044c88.5.2026.05.21.15.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 15:45:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v15 0/6] Add AI code review tools and AGENTS
Date: Thu, 21 May 2026 15:44:32 -0700
Message-ID: <20260521224550.927338-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260126184205.104629-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
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

Add guidelines and tooling for AI-assisted code review of DPDK
patches.

AGENTS.md provides a two-tier review framework: correctness bugs
(resource leaks, use-after-free, race conditions) are reported at
>=50% confidence; style issues require >80% with false positive
suppression. Mechanical checks handled by checkpatches.sh are
excluded to avoid redundant findings.

The analyze-patch.py and review-doc.py scripts support multiple AI
providers (Anthropic, OpenAI, xAI, Google) with mbox splitting,
prompt caching, direct SMTP sending, and token usage tracking with
optional cost estimation.

v15 - reflow AGENTS per doc guidelines
    - reduce redundancy in AGENTS (i.e don't overlap other tools)
    - move scripts to devtools/ai
    - move common code from scripts to one file
    - incorporate AI and human reviews

Stephen Hemminger (7):
  doc: add AGENTS.md for AI code review tools
  devtools: add common infrastructure for AI review scripts
  devtools: add multi-provider AI patch review script
  devtools: add compare-patch-reviews.sh for multi-provider analysis
  devtools: add multi-provider AI documentation review script
  doc: add AI-assisted patch review to contributing guide
  MAINTAINERS: add section for AI review tools

 AGENTS.md                              | 1826 ++++++++++++++++++++++++
 MAINTAINERS                            |    6 +
 devtools/ai/_common.py                 |  246 ++++
 devtools/ai/analyze-patch.py           | 1330 +++++++++++++++++
 devtools/ai/compare-patch-reviews.sh   |  306 ++++
 devtools/ai/review-doc.py              | 1013 +++++++++++++
 doc/guides/contributing/new_driver.rst |    2 +
 doc/guides/contributing/patches.rst    |   59 +
 doc/guides/rel_notes/release_26_07.rst |    5 +
 9 files changed, 4793 insertions(+)
 create mode 100644 AGENTS.md
 create mode 100644 devtools/ai/_common.py
 create mode 100755 devtools/ai/analyze-patch.py
 create mode 100755 devtools/ai/compare-patch-reviews.sh
 create mode 100755 devtools/ai/review-doc.py

-- 
2.53.0

