Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD49C53214
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:04:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B89DF402C6;
	Fri, 20 Feb 2026 06:04:15 +0100 (CET)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id 786334026D
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:04:13 +0100 (CET)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8cb20bcff5aso163748385a.3
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771563853;
 x=1772168653; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WARMINlbGxx7j/aCN+k6pusapkEX1G66fKuSmKZ/g74=;
 b=gURQhT1e3Zj7DuIgNM1AY1GQrJmqC49pnHQTI7okJK3gWx2Aa73+zBgxEcPso8xzW3
 cb5ZFmZ2N7tv9nv/+XOPvCEVIMjQ6m9ZUSNOvSc3Cq99DOlSYDr6SYTy77rMM0UuBCkw
 nHIk+T6ZhDar7WZ8llzWIY/dzjs/yMWvCdPesGzh9Ztys3MikushwqvpozhwQb1bArpz
 l4ZWnBnVnxIytHid+Q3vjLd5UbWKFx5LIR0TNE9IrLoZ4i+yQor5J4RhUd500QI0CUhE
 irJEk1GAJaa3NkBIp6nxq3yEyao0RmuGUvqe5oNx2YLuIDkH6GndmF3rCq6DbxwM4SC0
 64Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771563853; x=1772168653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WARMINlbGxx7j/aCN+k6pusapkEX1G66fKuSmKZ/g74=;
 b=Jcoh7KCyx2upbKfiBmO5p/WRucA5lVA+aeRiJHip+cP34tCVJ5X+V3wkBpP0PbYNeS
 0xcFE5SlEGb3SFsYX02nVfzU/FNFlOBAN/OQmf6N1SHbocDKDo3qSn3E165mcJinUOzh
 jXqAO/KEDlOtIMj7CePV98s7/jL8WJyvF4VIvJqSTruEeX3UllHVfKtidiaJG94gcK4k
 XaiQztbKJShQrpSg0f5aHZcGiD7ZG+h3vWdpL8IEQ0MpUaChA9vcG+Zw0FI/Bkm9WdqW
 hlcUsQK8jjIVwvG61+8FfPOm6azU966ZSOf/CsxYcgYmkPpBrlHBXPFY/n91JpBd2sMT
 SiNg==
X-Gm-Message-State: AOJu0YwjINYckAF7nPjhSw0kCOI9XxNwIIaXe3Bp8z5jbSlvGoW6Txlm
 QZAUzkWvpxAzczdWT71VUIvcES99dQcaAtw57DsgWgnw43d5ncHCmOkhgdtAehpmuBPIAkXBUSU
 fytwN
X-Gm-Gg: AZuq6aI2anSjunZAI9ZwmdMM/YFGDFC01HqBVG6RCtyw7vNkKSKA6NO+AdJYaXkJKqy
 xtC6GGAoYYXg2nVQ+Mj/XGs4DHkv9j4tJwXNg3hcROtbzZOoPl/RlexmoYsWkkEXeZWd+DnXhXg
 2UZ/NbQQRllS2dKGLl4wwSobpp+2F/NNln8BrrO2C44serLpVuaq2K0zdEst7geDVA21csvQME5
 A7wmRoY7RW9XFzW43HPe0uolMgbM34OuWGG8Wu7vx3NH/hJ5tA1sQn2z/6KgNmm1c5WbcZZao5y
 izF0DtUqvukSxC+OXg3848/eezOFMCZc5GtnBYUQUqFtYfbwd48NZBiwnSPblFvsUFz0lSl5ak6
 JlX6VdVR6YlRqcYCDDk9o2Ksm3f71LzbN6aMaGn18A3GwpDP+Js6b6vrytEw3FyOv4b0PsMJcnN
 dsPLlj9rSJ/evRX/uU09frcdmYTBfMO5msRJDDfZ+e8RSZSHh0PgAiR/PeMEkvHQ==
X-Received: by 2002:a05:620a:4096:b0:8c6:edcc:3f80 with SMTP id
 af79cd13be357-8cb85a34254mr46363985a.13.1771563853155; 
 Thu, 19 Feb 2026 21:04:13 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb2b0f38dbsm2289278685a.21.2026.02.19.21.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:04:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 00/10] net/tap: bug fixes and add test
Date: Thu, 19 Feb 2026 21:02:02 -0800
Message-ID: <20260220050409.1571022-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215195348.557945-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
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

Add a unit test suite for the TAP PMD, clean up minor code issues,
and fix several resource leaks and a use-after-free on error paths.

v3
  - drop not ready full ifindex change
  - fix AI review feedback in test code

v2
  - fix typos in previous version
  - preserve same fixed MAC address as original

Stephen Hemminger (10):
  test: add unit tests for TAP PMD
  net/tap: replace runtime speed capability with constant
  net/tap: clarify TUN/TAP flag assignment
  net/tap: extend fixed MAC range to 16 bits
  net/tap: skip checksum on truncated L4 headers
  net/tap: fix resource leaks in tap create error path
  net/tap: fix resource leaks in secondary process probe
  net/tap: free IPC reply buffer on queue count mismatch
  net/tap: fix use-after-free on remote flow creation failure
  net/tap: free remote flow when implicit rule already exists

 app/test/meson.build          |   1 +
 app/test/test_pmd_tap.c       | 906 ++++++++++++++++++++++++++++++++++
 drivers/net/tap/rte_eth_tap.c |  97 ++--
 drivers/net/tap/tap_flow.c    |  23 +-
 4 files changed, 966 insertions(+), 61 deletions(-)
 create mode 100644 app/test/test_pmd_tap.c

-- 
2.51.0

