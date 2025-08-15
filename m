Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC66CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 16:26:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 539AF4026A;
	Fri, 15 Aug 2025 18:26:37 +0200 (CEST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 8DDE9400EF
 for <dev@dpdk.org>; Fri, 15 Aug 2025 18:26:35 +0200 (CEST)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-3b9edf0e4efso1293913f8f.2
 for <dev@dpdk.org>; Fri, 15 Aug 2025 09:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755275195;
 x=1755879995; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=37kjJg0/Ml7Bfd32LcxUyJ8/Wwv2uaeIvBWplJTvrlA=;
 b=wLmv3BRdItDVqeET1K1PVlmK/S+zlvj+pQyqTjiSY5gQxMSre40IkBfzhWPIpQhzln
 jH8m8Pyn99Mm9usiNDCvbWWjKnTGNhmJlJP7UTHnDdFHRpToasNirhS1PqqjgLdIdMlv
 y6a6NLt4PXVm4fvmgvNMy1QV6LWcspvCI49ZmQN5LrixOTeNA/4mMDGC+DsHPwACuY9q
 SyesNjNKs3pdO2IT2UkFCi8UmYhA4ylmDuMj6STtleyiovhajPo1CWO9gQ91+pCCfv5y
 Y5/13WsNRGX6pfW7TOp66JQGM4rja/qt8r2IeFwutc8cZGzFStI+DRsv3Pc5jz1KwBtt
 ZViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755275195; x=1755879995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=37kjJg0/Ml7Bfd32LcxUyJ8/Wwv2uaeIvBWplJTvrlA=;
 b=mpkpI5wc9/o8Y9Jhj71n2lGYnZMbWqeanKLSZo3hWaJKa14osMINGZ4fQJrRS8xjhA
 LMM3tftjapYwadwE4KiPe1zagN+rCc0eUDZ6MHwjmRO7cFZww/XJFvNAHFzw3lmDTrIy
 PUDoEKA9HufxTB1RREYaUcoJPn4017rmlWp/QDNwWqbsvOCex225XgQ5lMLNl9YEjBqX
 btzn8Q+sHGT3h8gQExpPtYh7E/1x3UkclIHTz07GRoL7DBLgI8+LIXad23DaLMPNw2gs
 Zv5Q/9aoStmVa4h/waStK0hjdWp9BSeaPh8UlWMLl/VrX13KYPOs3wvmmtTz0OEg+i3U
 dRBw==
X-Gm-Message-State: AOJu0YyWCJF3Az1nP8H+x6pQsw4WytiD1T2KtX9FdNT6EgtXLEV5KX6d
 k76sHtwh4Usn8Q5GwND9mth0+d3iWHKm9QiHKjCcoKFc/NYV5+5JZ22Fjw80Bo4/pVEVT6vxGpj
 Yqy1d
X-Gm-Gg: ASbGncsBss1Jbkz5q/nQxxrTPJAGlgJna62WLOZR/gbLVnOtnXOS9FAN4dYkdie1pCz
 dy7jbuwy9BwjDHiUyKRIo0LlPqVyTikmLsDbq3BorKI2CN67z4CqkAmw/OfswyeNkN9P+PBpc+q
 4R0akNVaS6MCxjzqO4eNZe6KQXnVi56gmFCsZjxFqrtU4npBwhA8OEAEEktMnJAIk4mlgbGLEsF
 FN33tRe5vFo/m0qW3MVfJVMCIms0eLm5wy3IaKDyetnBHUNe4dAQgdtHqnwtLfhKf1J2jA2Lht2
 0tCBz+yuGwNWwrMohSR+Bcj8qY8ptiH3PA5xUnBvPn8k3eeS/AjnrXmkRrxxp2HCFZA+1+1zFTX
 nM8aITJitCiaTVAzSTKuIjLSWnAow2dlE4J6pIY6dACDBzm2CdfZH9Vav5DrWo0VFM6qyFMtl
X-Google-Smtp-Source: AGHT+IFR/WxOWLiBQld7O4kRsCONK0AJzwZLnJORmJShQUPWlKp0NMO1V+z8xhi/t7M/pvgsKbL0cg==
X-Received: by 2002:a05:6000:2902:b0:3b8:eb9f:a756 with SMTP id
 ffacd0b85a97d-3bb66567decmr1899018f8f.11.1755275195087; 
 Fri, 15 Aug 2025 09:26:35 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3bb676c9431sm2665278f8f.40.2025.08.15.09.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 09:26:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/7] avoid unnecessary use of comma operator
Date: Fri, 15 Aug 2025 09:26:16 -0700
Message-ID: <20250815162629.161782-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250312232739.228295-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
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

Clang has ability to detect suspicious use of comma operator
where a semicolon would have the same effect.
Easy enough to fix in DPDK code.

V3 - fix examples as well

Stephen Hemminger (7):
  eal: replace unnecessary comma operator
  ipsec: replace unnecessary comma operator
  graph: replace unnecessary comma operator
  test: replace unnecessary comma operators
  app/testpmd: replace comma operator with bracket
  examples: remove unnecessary use of comma operator
  config: enable comma warnings

 app/test-pmd/cmdline_flow.c                |  6 ++++--
 app/test-pmd/config.c                      | 10 ++++++----
 app/test/test_compressdev.c                |  4 ++--
 app/test/test_link_bonding_rssconf.c       |  2 +-
 app/test/test_thash.c                      |  2 +-
 config/meson.build                         |  1 +
 drivers/meson.build                        |  2 +-
 examples/l2fwd-event/l2fwd_event_generic.c |  2 +-
 examples/l3fwd/l3fwd_event_generic.c       |  2 +-
 lib/eal/common/rte_malloc.c                |  4 ++--
 lib/eal/linux/eal_alarm.c                  |  6 ++++--
 lib/graph/graph_stats.c                    |  2 +-
 lib/ipsec/misc.h                           |  3 ++-
 13 files changed, 27 insertions(+), 19 deletions(-)

--
2.47.2
