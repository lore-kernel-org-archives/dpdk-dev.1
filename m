Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ED3D232C7
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 01:18:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D6C34066C;
	Fri,  9 Jan 2026 02:18:02 +0100 (CET)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42]) by mails.dpdk.org (Postfix) with ESMTP id A2EEA40279
 for <dev@dpdk.org>; Fri,  9 Jan 2026 02:18:00 +0100 (CET)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-b8440cb2dbeso380844666b.3
 for <dev@dpdk.org>; Thu, 08 Jan 2026 17:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767921480;
 x=1768526280; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HbJOK5T8VEGglPjXXiv39vcDOkVnU/+o5jpkggHxsvY=;
 b=cxLmypKafT/jlBIOH2jJKUW7KJSf+PYMfMV7x1JnO1gVqxu2+btabgZeMohCgsoC2b
 3Yv8mq+knXDtQiPapteO8gI2EfqrxRvaCmSHIh6cakfxNxTjbRMa6eWTVSDGSNdHR5+J
 85xfhox8tSbL+2NQV69JsyT8mWPKYTrNwmoG/j0IZDXui11AxkPKs30bkC8gohGl3Kfk
 tVLfEAzdQ8TQB2yswncLOIZZSCNNNnQ17S+7D5qCNPBp05eauBYEM7vcdc+xQWBHxQux
 DxGxtGCzhsGGItvSYPRaVwQwQor0lboSxSzpTIYdLVmorxjAOXsPwdC8XPBVKvFWZmsb
 zr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767921480; x=1768526280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HbJOK5T8VEGglPjXXiv39vcDOkVnU/+o5jpkggHxsvY=;
 b=vH6xHLzFEM1O7/nxZuIoYGf1V7vgKBqH2TTSxowO3Xrk2+cz4+4NrpuHpq1x7LLY1J
 r+EzkZIWUU59GtKbHesoc9nf07fEc+USEwR8oO3+keq52oQa6k9E4FRYzFvxWCElwA6W
 Lss+3DzieIGU6ekSwqmCqfNr0QIUjsVb+L6yaBLmooBICvw5TzKf2SLiEZc1p8rRfa3g
 H0ra7o/eV7x1ssQfvJEra2517zkjfwX0EMtO7TyNz0KY61yLGNIXQ8u2iNIZCm+TIw4/
 Z1u4Ou3Kl7mlACHkZjzhh1RGGYkSeVfvzT5ViHNZjHgYqBBWTrMJ053Pu80h6ASkNN7W
 3eIw==
X-Gm-Message-State: AOJu0Yzl8eGaHwQatH71KrbtIgWirEpeGi9TD2nWZObHWbFnETMK+UQp
 oxVUU8DIfbYUa4w9AnUaAuEoJRm3CcD6yx0icZn+oE8lqfOBV42rA/ffkpPjNrbUlGs7mJGEsMg
 9dBbP
X-Gm-Gg: AY/fxX58NLWFT+uiZBlYYo2p846mdprmv5y/9N4iMc99b/IUn6YaYsZW3UhA1nK43oc
 ePHAC/NBJgHe/0NNe5ZozzlSP57dS+GcNii0WCMljCpzuq+uqwrPdPW8XJ0U78XP5cb811Qpw0U
 cgakMu1Vq2R7cjg1PIl4sWTDMD1flgH/Kw+QX7c1sgNsNPH0Uk8Ns48fJsTyuEsPtG6lHNq2QCK
 btz3oGyoFM0mz/UIzK4jcBl6zPU//jAytdeluCuXmdHItsdJIZWObalxYrXicM0zGPexPj9qSco
 2Aw1QqvfGdIJ7BEvmuHuGY143bJCKqFJO6uKcNLlL64nUHeKNvyJaNDspFaxPvQrhzy7t/CyyDS
 BMF4e8ZkQtTlikpBDM4Kc3Jt+U97nS0r2WfTO/rPKo48Uy9hEaXCmRvRW1cMYYhmMiP+T9xGxnp
 BM/+/+InXPIIrd/rDvTMxB2mFmeQYHrzft0hhog3ANoXBzwrOiyQ==
X-Google-Smtp-Source: AGHT+IHVcsrW1S/ne9Rv2FLrjxCqwD9cp1dQ71ir+Ub2JXDrnIp+MUSKeojPSX3rFz9PKdltHQYAfA==
X-Received: by 2002:a17:907:84c1:b0:b7a:1bdb:30d6 with SMTP id
 a640c23a62f3a-b84453e28c8mr547719666b.62.1767921480017; 
 Thu, 08 Jan 2026 17:18:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a27cac3sm954886566b.20.2026.01.08.17.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 17:17:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/9] pcap: cleanup pcap PMD and add test
Date: Thu,  8 Jan 2026 17:16:17 -0800
Message-ID: <20260109011755.362857-1-stephen@networkplumber.org>
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

This is a set of enhancements and tests to the PCAP PMD.
It started out when looking at the handling of timestamps
then realized lots of other cleanups were needed here.

v2 - review feedback
   - consolidate patches

Stephen Hemminger (9):
  net/pcap: avoid using rte_malloc and rte_memcpy
  net/pcap: support MTU set
  net/pcap: use bool for flags
  net/pcap: support Tx offloads
  net/pcap: support nanosecond timestamp precision
  net/pcap: remove global variables
  net/pcap: avoid use of volatile
  net/pcap: support MAC address set
  test: add test for pcap PMD

 app/test/meson.build                  |    2 +
 app/test/test_pmd_pcap.c              | 1846 +++++++++++++++++++++++++
 drivers/net/pcap/pcap_ethdev.c        |  353 +++--
 drivers/net/pcap/pcap_osdep.h         |    2 +
 drivers/net/pcap/pcap_osdep_freebsd.c |   60 +-
 drivers/net/pcap/pcap_osdep_linux.c   |   51 +-
 drivers/net/pcap/pcap_osdep_windows.c |    5 +
 7 files changed, 2184 insertions(+), 135 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.51.0

