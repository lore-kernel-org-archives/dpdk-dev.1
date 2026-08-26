Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899BFC5DF97
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 23:59:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36FB640268;
	Thu, 27 Aug 2026 01:59:44 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 36C1A40264
 for <dev@dpdk.org>; Thu, 27 Aug 2026 01:59:43 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so96520a91.2
 for <dev@dpdk.org>; Wed, 26 Aug 2026 16:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787788782;
 x=1788393582; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JHmDcIlyo9Y5BK1BgXaluvqWRq9lRYQDr3bLyXK0PR0=;
 b=UFPSuARamELn1TIEY2zLFJvut41InHs+nkCt0Q8hjFLN3j0xt/Dwmw4huq6nHl/mLJ
 ywVN34MxWyF1JW8+DMpYGXFJlEMQ4mVg8IYuob8PL9Dj+DFj+yboJcoM7kkdYnxmTTPm
 arwF6LopoB9xjAEKULb4rIZIUXyCX/PYpFbHnifqsCaSSEl7F+S64lAGNMsUjCHzcMIV
 /tdeXeLWMmSVCg1cNm+R4UC2lVfHttngpTQaRpQPw+/1LQoZoQXBbB6IaVTEbdsx0mge
 8FUsohtpyMzkTZeszmklXOeeOQuZP+K42rmvNeOCJxW+b0U5oA9Tl42e6ZlOglQoR3km
 RzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787788782; x=1788393582;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JHmDcIlyo9Y5BK1BgXaluvqWRq9lRYQDr3bLyXK0PR0=;
 b=JuGl55LLLTggWlnRhDMfRrMHYZZ1ZudGXndsNcWSljtlcdnn3tYssXH1Ag9n6ilcoX
 dcOizqRNfRNxyduLxHhREb40el9rXcuq+sxRQG6cQtAyBAE5hJzMeUMBDyRY3knGiQC9
 dnosywA28wEp2LYxAH+ftZmMo8Xq6xBAIEI8TiQGJctbbae6DIa6T2fu1RA24ad0fjwG
 fSWp6i0q48yrgNdY6cJ6sOAui1FTAW8L5PnqoEp/OM0dav+EJ+65BQb7LwtJZz/f7nQU
 BnY1Kt5O3UB6O+o/FgOxrEzC8F+bkzLI7jAk9td22FATBwzs5zxqpwtgAy2rr1ZeOuAa
 qW/g==
X-Gm-Message-State: AFuF++lEI6a754S5BoX/quXnk6sTfl+Pp++YwwgVN5jnZO1QsOdjHXpk
 hnig48wsAh2KkzMywDhvuqF4NvZBTaPEG7M+bOFZAZvr4oaEFfDG03B5wtkBjR67fPIDNR5pzlg
 wWNmZ
X-Gm-Gg: AR+sD13Z845LzCEhlSy4V+0itzvvGjyv5LL+VoP00/GGnA51xan4qviSRX/Io2yEzy+
 XVHb9IJvXsOJ0gP7CHXAifAbjsh8O6vxwnBVcXuOp9JwNaglTvVzCbVfHng1wcLfktmZltMX8eJ
 vQhnW17o4eNkcRRUFjn+vQSy7XYwFsLslqtdj37d/AxOjNo6CYBb4bpj/eN7kpdaxoLONyIzXCo
 lr7ljsqo2C3dJPDyuzXc+n0ImBI/nc33EGzqfX/ww0Qbq2r9VmZ3QK/QZEN/HZD5D+uwMdM9Vls
 5c2tFly92n8oCLiAukWeqUA+9VSBGWxwhZysFGn+6GTWkgxZnNPHyXMRX6pez/fZt1j2RRFoNAz
 7VFJPaT0XKtwwkXpkmeT9TmXqLAz/ce6j6syy2HogJODXuvjXlePAP0aAWl9CoCG2PksVWKeam5
 oH6f748plNJIIEI6JU80X1M4TlgYKN/irjXJtcZ3duPByYIyAaE0eUyErQw5JCKUu8FoYG8IpzX
 uT/q6AN/rNxJot/gbxf9Fc3a2E=
X-Received: by 2002:a17:90b:3b4b:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-3966d8b6295mr21878457a91.14.1787788781964; 
 Wed, 26 Aug 2026 16:59:41 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141a8eedd13sm11019596c88.1.2026.08.26.16.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 16:59:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/4] fix unused-but-set-global warnings
Date: Wed, 26 Aug 2026 16:43:00 -0700
Message-ID: <20260826235933.194681-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

  Clang 23 adds -Wunused-but-set-global, which reports file scope
  variables that are assigned but never read. It is enabled by -Wall and
  does not appear with gcc or with clang 20 through 22.

  Three of these are dead variables and are simply removed. The fourth,
  'alive' in dpaa_of.c, is a real debug aid: it is only read by
  DPAAX_HWWARN, which discards its condition when RTE_LIBRTE_DPAAX_DEBUG
  is not defined. That one is fixed by making the empty expansion consume
  its argument, which keeps the condition compiled in both builds and
  covers every other DPAAX_HWWARN user as well.

  The patches are independent and touch four unrelated drivers.

Stephen Hemminger (4):
  common/dpaax: fix unused variable warning in non-debug build
  bus/dpaa: remove unused qman_clk variable
  common/zsda: remove unused device counter
  net/qede: remove unused app version variable

 drivers/bus/dpaa/base/qbman/qman_driver.c | 4 ----
 drivers/common/dpaax/dpaax_logs.h         | 3 ++-
 drivers/common/zsda/zsda_device.c         | 5 -----
 drivers/net/qede/qede_debug.c             | 9 ---------
 4 files changed, 2 insertions(+), 19 deletions(-)

-- 
2.53.0

