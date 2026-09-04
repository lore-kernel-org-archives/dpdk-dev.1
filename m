Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16251C624DE
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 22:10:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C7CB40298;
	Sat,  5 Sep 2026 00:10:03 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 942954028F
 for <dev@dpdk.org>; Sat,  5 Sep 2026 00:10:02 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-84e84a6c4bfso1478163b3a.1
 for <dev@dpdk.org>; Fri, 04 Sep 2026 15:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788559801;
 x=1789164601; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=siiorHjGc3esN2nxgvcgRC4vNkWXxfTVFOSIOejiT/c=;
 b=Psub2o0huu2cvRtCuzoGohhgyCXD3oXlNmO0Qq9Ms7FWYUylOvuPa67nKiZhGp4vR2
 ZGjHEcyJCIIr4C6XKQ7UqnjjiKhi3vOsNUnSJ0pvOptV4KsPFfOTxVqZmJrPhhzfJQv5
 q2+LsPme3cvmH0f91K2J2CufHDAP8N5FX8kZCW2a6xzIWunM2NeKW6pEHHFVjqdCj1WA
 JNUSwdevOd3Mr3OZ+vTuKfTwOfFeB3m9jOQ9Qi0mRDbhP0Ium4GYbn8RP5xOsT1peYA3
 DvBDSbQDZNgnQWYcqW2Y/7cpGmkU29JQ06CdEW4dmONKz5X1+4FpL8mC8k0nvsPnFcv+
 v54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788559801; x=1789164601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=siiorHjGc3esN2nxgvcgRC4vNkWXxfTVFOSIOejiT/c=;
 b=qeAw2flJKoDZQPIaI6Gq3qVDlotEzhAMzZMZEkXQnl5yt/9kIlyZipZ5xcAgYuQD0R
 HLLd+CyKPOm1rlopkhd8jFkbzEUfWPI8G7JP/M7PEmgOyhZc3G6L/X6RcbA7M3FXWVY9
 FjAPr4rz3ztJLRkTNKUEqtW9K8ExxLzrokaoBb2sxdxQW2Lw7V6dVsmoNFpFz6V4SkVM
 0D6IXgSu34CdVp4PdInl9p+tp/4WvrQ/0HU4dM+qLr/CxCGZtMpAN6C02dkqJOU5eJoN
 8WjDQMxtBPFTdz6T2TT0QmvJ2UBY7APR9Ad/Gvy5Lmoi9h3xue57Xni+2RXFMOSVr9ZM
 eZ2w==
X-Gm-Message-State: AFuF++m3Q1i7hOX+cYWor2BMtE2acyB+SsFnIT8HchURjPlTEoG61h5H
 QKJjwxfaVG4ZcgH8OwRdRBTEJfi47q92UDsnvj6b6rd8qrrYXu8YHGJuBalHfE6D3llMPWmYToi
 XLVm7
X-Gm-Gg: AYBFou1pO207uueXmcl0tMSUVjLA8G13C7Z1wyajdUKfs2BW2knbvt/jmY0IWACemwu
 fd7wK61+A7OskK02zFW1brXxQcLH4TYQty8Dghghv9FYMBbx3mQwYCJElRtLH8dMJqe4hYO9lxn
 Tjm+BfvwckIVxGUYIpHYS3C1ksPUrYbQFsh+oflJO3xqLZg7aDA1qlq47PKh/GpiO36MHzMa3FN
 RT49jZP/Kw/cWkYKoXoHsQZhS8TyHE1xBRVIPed7zpfaCYV/Nf03E3gzoCHTqXZ69COAEbclgDj
 gipMod4FObNp7FcrAUcvPJomIyIkgo3Pnx7QbYb84Yi+IS59+aL5hSiz9u7lQW8ti2qW5cJPrbq
 V50sRJXsqq37+JXuBXfVgj/Xlg0S5aUMxJR/+dRbOncbP7W3oMFfBDdqrwVJJhepGHDLub5xOK4
 lKVMqo0/3gZkDV4iltGhLKTtFZJQjkIK3fNr13jema2GVtqGim03hJ5xA4EjxqEmMRZXKlO4POz
 lTtlpNlYqJvikyDgNhHrsogHsc=
X-Received: by 2002:a05:6a00:1818:b0:84a:32ba:a262 with SMTP id
 d2e1a72fcca58-85ffc77528amr13876856b3a.7.1788559801322; 
 Fri, 04 Sep 2026 15:10:01 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86153a1c1basm1614076b3a.52.2026.09.04.15.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 15:10:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 0/3] eal: make unaligned types really unaligned
Date: Fri,  4 Sep 2026 15:09:05 -0700
Message-ID: <20260904220953.3105930-1-stephen@networkplumber.org>
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

UBSAN reported issues in the tests added by the RTE_PTR_ADD/SUB patch.
The root cause is that unaligned_uint16_t, unaligned_uint32_t and
unaligned_uint64_t are not really unaligned on x86; they only get an
alignment of 1 when RTE_ARCH_STRICT_ALIGN is set.

Once that is fixed, RTE_ARCH_STRICT_ALIGN is no longer needed and can
be removed along with its last user in mlx5.

Stephen Hemminger (3):
  eal: make unaligned really unaligned
  net/mlx5: drop unnecessary STRICT_ALIGN
  arm: remove no longer used RTE_ARCH_STRICT_ALIGN

 config/arm/meson.build                 |  1 -
 doc/guides/rel_notes/release_26_11.rst |  6 ++++++
 drivers/net/mlx5/mlx5_tx.h             | 12 +-----------
 lib/eal/include/rte_common.h           |  9 +++------
 4 files changed, 10 insertions(+), 18 deletions(-)

--
2.51.0

Stephen Hemminger (3):
  eal: make unaligned really unaligned
  net/mlx5: drop unnecessary STRICT_ALIGN
  arm: remove no longer used RTE_ARCH_STRICT_ALIGN

 config/arm/meson.build                 |  1 -
 doc/guides/rel_notes/release_26_11.rst |  6 ++++++
 drivers/net/mlx5/mlx5_tx.h             | 12 +-----------
 lib/eal/include/rte_common.h           |  9 +++------
 4 files changed, 10 insertions(+), 18 deletions(-)

-- 
2.53.0

