Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38F3C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 03:03:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09A1940666;
	Mon,  9 Jun 2025 05:03:12 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 1A32C40661
 for <dev@dpdk.org>; Mon,  9 Jun 2025 05:03:10 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-7d21cecc11fso661460585a.3
 for <dev@dpdk.org>; Sun, 08 Jun 2025 20:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749438189;
 x=1750042989; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mSisxc5HBumeT+fjlbWbkUANgBkNQzeyW6ZqPK3RUeE=;
 b=RCzMrxBjpZWRhMXYrkLpeiF7FWX9nrkgci1SfhGAwN+MNu6lpnL/RfIxgWzgVd0Bfk
 awn6k67bGkkKiULJ5mgM6kchfDcryMftz723e4bJgQRiGjfIoCF2IPzeNn/WtYkpXTQp
 BCxKcUCN+gkNoDoSEhlX1hRv63y9ECpD1XSq5N/V/mNHwsolyCuCiIhr0X3EQQG6voHE
 VvJkU/3k2DgH1zbN5z4mzHWQAnZ/Ur2Ck/MTdeYf3DdP7gJ2uKltYUvtU++7Q0jFGlk0
 fpf5EIzxbePaMFl/ih9tMNSbGXlx43mf4dR3RBl0r8P2Zaxc8BWj/z8dOXQxT1LN8GRa
 t1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749438189; x=1750042989;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mSisxc5HBumeT+fjlbWbkUANgBkNQzeyW6ZqPK3RUeE=;
 b=MtJwz/HyHAaknKDLo3Y9We7SrZibqN13FBXGYHQGnk7BPQ82EZXHFm6o9r9sQrdXc3
 A1d+X2h7aIAL2uG28cPdmx3a+lg+6mM5+RH9MjDbbznvIbAjiPE/KkQpzis0WDdovt9J
 rh9gJ21bM0obme15Y2R7uPCkXSo9WXV203kBL4UyA3yo+VphM4K8N8iqNdLh9iBGcfrh
 QnD/T9qucquxGVURcNlR7Ff3EgW5UZHC4KQSLJpMno1Gqe6V0u1G/zzMDyu25TyIQU3O
 GW7oVq9PjxdJC0qkX33QNtAa8fxmnOkhiU3DmcS2fTFsMFIMdF2B7v58FgDMQrImRrZp
 5BJQ==
X-Gm-Message-State: AOJu0YyCMEr+x/+YA54rxQHV26gYsbLbCb3A0rczUrvoouq/1k6kOw8M
 ZOw9GRsZzz9CImvdalRUD8cRK3EKXcr9DK+0uU54F0HpQt8SoWg5pkuSMNtUUlCvBagBukJsm0A
 fAjJr
X-Gm-Gg: ASbGncuywWljIc3vAO/tYEd3jUQYyZbU0DqpXpFXdIg1cHEbJaeMrJBUpN0ILPXpGQn
 wMHUJshiZtg9fNFgeOrbhF8qnxXF80uzI9PFN3YMw4trfzDHShsDb26TsSnswrq+Idivn9hyFyP
 Z46T/BeabwP8kIcUiJNvw9CClc8VcH0TRVAOP3RWM4YtrrQoStxJYAWbW/8rNXvfNUv0PoXDMeN
 +WoYYTF25QPD9aBiG36IjI5qlJdH3MWl4SbTnck0f+vt/VXnWKI7hxdvg1/E0uErJmPPfrtIYiB
 8hlL26aBOzs4HkickgwKj2hqSCK3w/aDwpn7sresPKxBELt5AhRvOvqpr/qcjRpdKCxadjAWsiS
 22wX6nln6L467NB+dWkGnr1OVJg==
X-Google-Smtp-Source: AGHT+IEbbdmWetMh4B+WvQ/DYVcixuYCiU5w+li+bIkWZ3xpUkLvUOrq8D1Jr6PahGxljFfdLD7StA==
X-Received: by 2002:a05:620a:3910:b0:7c5:5cd6:5cea with SMTP id
 af79cd13be357-7d22987df9amr1623459785a.15.1749438189370; 
 Sun, 08 Jun 2025 20:03:09 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d3901b12easm174180685a.67.2025.06.08.20.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 20:03:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC] doc: change recommendation for installation of tools on Fedora
Date: Sun,  8 Jun 2025 20:03:05 -0700
Message-ID: <20250609030306.17171-1-stephen@networkplumber.org>
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

The syntax changed with Fedora 41 and the old command is now:
$ sudo dnf group install development-tools

Not sure what is on RHEL 9 or later.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/howto/af_xdp_dp.rst    | 2 +-
 doc/guides/linux_gsg/sys_reqs.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/howto/af_xdp_dp.rst b/doc/guides/howto/af_xdp_dp.rst
index 9da68e0bfa..b3681af2f7 100644
--- a/doc/guides/howto/af_xdp_dp.rst
+++ b/doc/guides/howto/af_xdp_dp.rst
@@ -159,7 +159,7 @@ Build a DPDK container image (using Docker)
           python3-pyelftools \
           python38 \
           iproute
-      RUN dnf groupinstall -y 'Development Tools'
+      RUN dnf group install -y development-tools
 
       # Create DPDK dir and copy over sources
       # Create DPDK dir and copy over sources
diff --git a/doc/guides/linux_gsg/sys_reqs.rst b/doc/guides/linux_gsg/sys_reqs.rst
index 4c9d0c55c0..c53e79f7d5 100644
--- a/doc/guides/linux_gsg/sys_reqs.rst
+++ b/doc/guides/linux_gsg/sys_reqs.rst
@@ -31,7 +31,7 @@ Compilation of the DPDK
     including standard atomics, for example: GCC (version 5.0+) or Clang (version 3.6+),
     and ``pkg-config`` or ``pkgconf`` to be used when building end-user binaries against DPDK.
 
-    * For RHEL/Fedora systems these can be installed using ``dnf groupinstall "Development Tools"``
+    * For RHEL/Fedora systems these can be installed using ``dnf group install development-tools``
     * For Ubuntu/Debian systems these can be installed using ``apt install build-essential``
     * For Alpine Linux, ``apk add alpine-sdk bsd-compat-headers``
 
-- 
2.47.2

