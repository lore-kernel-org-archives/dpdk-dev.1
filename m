Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EB1E63F08
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Feb 2026 19:53:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A80940274;
	Sun, 15 Feb 2026 20:53:55 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 6969640269
 for <dev@dpdk.org>; Sun, 15 Feb 2026 20:53:54 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so23505315e9.1
 for <dev@dpdk.org>; Sun, 15 Feb 2026 11:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771185234;
 x=1771790034; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fGMKY70Hu8egWImWdufgspKX2vgvwtwWsnEv3hYYTAw=;
 b=bTl9ofS6G2mW+HkIYVWe5vyPCBjWBvZaBfqvDPtuRIZKzU/MO2Tq976a8lC7HCBTFl
 biVqOHtQioppCWCGzO02EB1HjUESyQeHOEzXlTIXB1bjHqixtpAsNbwNWx2V31kIiv/C
 4DZOGlA4eZPVXXiT3rp0nZQyWkIuoeiz/tKjN9v8LrAzTjiqM6W8Y9zJtKxdDfZIIu03
 JcEQIb28AwFVfvor9pJaitP6VJcSVCrmDqUuIDVEm0WNzPD6RTJ626mG0/k5GxvvxQXP
 PPPYoRTr/YfsARPv7kZc5Y7ogvchZLCTIKMdivupgaWj/TPm1+AJWp76DOxyt7b+5MLp
 4Arg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771185234; x=1771790034;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fGMKY70Hu8egWImWdufgspKX2vgvwtwWsnEv3hYYTAw=;
 b=b6luA+qs8csXWZNy1t005LG6zVvae4vjLOQMAaautyy+LHO17DdB8RbAbtFbyUbDF6
 95HH3TFBBO4PlqmgfFLWuxRX4ARgmh+Sj5CopIYeURiN+2bfSlcSFQ1tPMl/8NlHGdEH
 qZ4CsVkYf4lrzswJyrZiNvMXq25vECSLlqfvAQMttowj2Jw+83MjcX7d8h621LGjLruC
 j1RLAptk8SVzhqRKFezQ1bZsAvnd0p0V0UM6qDN43K/6SXwpQg7nwwrmvqzqK5PxYU2e
 QEGWkhxLK8vHoFnPzvzUwcv4872FOpGqlvRzvFbuLqo9WG0/HI0kafrBMupkb6W97I+j
 ayZQ==
X-Gm-Message-State: AOJu0YygLmR88YBTHgu5xd5gry4VoYPddfISUtaxqDaFq6a4NaJSjdMB
 BNouVF7ByDrT66g17lsRPmWPQxxSpF3dPNG++mZptmKGjUZCqqmNXdimfZRxOVpnvtekcyQvfnc
 x9f7bi2s=
X-Gm-Gg: AZuq6aJpnWEzgxgLZpiOyEecvu5SYDNXW961KyGWsamR+r18hlxJKHvTb7OSUN5pmVp
 ZM7v+dMsauE2oY0CKTUwAwdHCxksUpbtiJZM4CgwoVisqkMky+Z7jUf0BP708xTaxN0jDoCR8C+
 MdsgI5PWlMKfMrsTd3zoWyVBnPA8ZRP/LIRYJgQSfL4GQfqnYmVgLImYMyrQxdN+CRQyyy09C8E
 xcHyj/HGgnBN7C9Qvx4ZhdLPojzxOXMkTSkAe09zHgBGcBBwPLnp2qHfC9gMzV8NasR+Jc333dA
 STlQ7+A9AxHHmowSnkNgB3qR/7DaN1Fg7ORWWPy//Xp68vWG2gtqSXWccRZyndhWzSuhceRlTB3
 iZeOgYQw+EcArMz7L09WcNGtVmtuu8LJ9lSWzfAXJXGD0KQKrS+HHeXdleGG+iyGCXIMuALoUMG
 l4q2tuIOs4rRdRTHCHtTYPUJ5xkzBFwkrS+sndQLNtt7cUxhBxIFErX4PNsSGXOXJe7mB+SyC8
X-Received: by 2002:a05:600c:1c29:b0:482:eec4:76d with SMTP id
 5b1f17b1804b1-48373a5d5a8mr134434195e9.17.1771185233334; 
 Sun, 15 Feb 2026 11:53:53 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d99497asm526490415e9.6.2026.02.15.11.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 11:53:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 00/10] net/tap: tests, cleanups, and error path fixes
Date: Sun, 15 Feb 2026 11:52:18 -0800
Message-ID: <20260215195348.557945-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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
 app/test/test_pmd_tap.c       | 896 ++++++++++++++++++++++++++++++++++
 drivers/net/tap/rte_eth_tap.c |  99 ++--
 drivers/net/tap/tap_flow.c    |  23 +-
 4 files changed, 957 insertions(+), 62 deletions(-)
 create mode 100644 app/test/test_pmd_tap.c

-- 
2.51.0

