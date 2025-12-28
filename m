Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B98D3B7E5
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 18:45:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 215A7402A0;
	Sun, 28 Dec 2025 19:45:42 +0100 (CET)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id ED5A340267
 for <dev@dpdk.org>; Sun, 28 Dec 2025 19:45:37 +0100 (CET)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-432755545fcso1366348f8f.1
 for <dev@dpdk.org>; Sun, 28 Dec 2025 10:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766947537;
 x=1767552337; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ym+yb0SEJ9g8BR5l+79ZJYpxLubtfjd+KktiXjRRcnk=;
 b=HbNFyLdZh0BzPZ9U0gQ9az/JD4do3+CvMC+0U3b6+Vn+s7Vujuyi7ffB4EHqOD4tAV
 sHJfAuepPW9A5jfq64DtzU2VLXjVdV6MhwJkdQZ1uMjjZXe5z6O+FVICV+V2RetyRlEE
 avhnJptZ4w8yBf+uH2PsWMzG/inGgCe11xtjcbIxFEyaqX5GYh+MuXt9AGtCSHLhSmtI
 p6OeT7GiI0y4QbbzAcvFmxED0osIr3ondr0SurrtblmvcNx4yIhme/q5wabzOiXqPzr5
 KTp2Dx6YzeGO5GuL2wA/P6fslbRUrtPBSlC1xjU8C417TkYYlwV/na741+D1RFHKyQeH
 dYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766947537; x=1767552337;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ym+yb0SEJ9g8BR5l+79ZJYpxLubtfjd+KktiXjRRcnk=;
 b=k4YXhZ6b7XEljsraFrIjtH+SH4qtU+T4lxI3IWDdIOzWAlLDw68xBUFjkJDDpgMvyE
 YZsmrvlUv+JPqJkNudU8rX5LsFUtNVM0+oXND9C4t8EcSinzyXRYI8lvLrNjm52blpIc
 vpzaXBvZdmGwmeKytN3rnzY7osgbkxZj26Z2tpsFm1rBaa97UDiD+HDxzOCH14I2h25I
 VPXzXp2P39OlTSN/UZgbVKqoGul+wDb/4EeZ/ey8DcGOMtsPJ+T5f2Zz/tzW0zpvXZi6
 e2CiMi+cR3xUQ8yT3KuCPtPQz6qY6QX9jy+dzvruJnUWvXEe+8nmeNuueJaoPXOCHO/b
 u+Zw==
X-Gm-Message-State: AOJu0Yzdy+GkafNzaBUiJdoVm3msD/MdXF7uDbn2Iyiwfb44z0Pi4Sms
 DFtc0o6Mkj4WwAI3H/xD4POFsL72lwe6ltVFnYZurGoRb8E5eIi+qoGYHk39fEHQ//kz4B6YLS3
 MEKfoQKM=
X-Gm-Gg: AY/fxX68mtXN+89Yd9/ibiX6uvLV2h/oarZ0oI5KFoLIXcUvpYyo4O5HgNDvmtOC29v
 u7alBP/UWppUV536i20FFOmjU38E7WkP8P5XpYebLs+dHy5utW7zo3vnglwAA5CTbC0PWgfjrDd
 udBR89GgRXmSLBdGgYKMThunrOKrmELkbSbMYyiOI84NZacD402xF5N2UDI71YYyuhSkZx0oSEn
 ghp7J/1Ijo7BNjNm+LKsLQ+bphElkMTVJmTudG8w348EshkgI8WnANZjmOTlav7MotC2QcNXipK
 vbjTD4sB4SJIYU0wrR9e/hsoqJo7YLfk0fktqGNKRaOcfmeSVqbXO4Am1QjEwY5TK7CP2tU6CZx
 hGVaw/0ugr7ebAHT89ihFOyP1fBcW4BdPvpgwPW2pGpIELwGaU7VyOSP7mmx1C2GBBkJCgLzThS
 wEMmd3w3Znh9iW00WlDasEpN6F3RSa8Y9ktGvkuAWRq1hMesB8sA==
X-Google-Smtp-Source: AGHT+IH+cUQ9mnZ0t9mIy85vlSYGD8ro82vE4iGaWQl20EPXw7Be3hEqdyoUUnYlN/Egwear8qUWXg==
X-Received: by 2002:a05:6000:288b:b0:431:a50:6ea7 with SMTP id
 ffacd0b85a97d-4324e50685emr36012076f8f.49.1766947537178; 
 Sun, 28 Dec 2025 10:45:37 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa2bdfsm59150275f8f.32.2025.12.28.10.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 10:45:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/7] Fix build with gcc-16
Date: Sun, 28 Dec 2025 10:40:13 -0800
Message-ID: <20251228184300.541639-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

This is a collection of previous patches and a couple of new
ones which allow building DPDK with latesg Gcc 16.

Stephen Hemminger (7):
  pcapng: use alloca instead of fixed buffer
  pcapng: add additional mbuf if space required on copy
  test: add more tests for comments in pcapng
  test: vary size of packets in pcapng test
  net/bnxt: fix uninitialized warning
  common/cnxk: fix array out of bounds
  examples/fips_validation: avoid rte_memcpy alignment restriction

 app/test/test_pcapng.c                   |  116 +-
 drivers/common/cnxk/roc_nix_inl_dev.c    |   10 +-
 drivers/net/bnxt/tf_ulp/ulp_mapper.c     |    5 +
 drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c |    4 +
 examples/fips_validation/#main.c#        | 3082 ++++++++++++++++++++++
 examples/fips_validation/main.c          |   14 +-
 lib/pcapng/rte_pcapng.c                  |   38 +-
 7 files changed, 3212 insertions(+), 57 deletions(-)
 create mode 100644 examples/fips_validation/#main.c#

-- 
2.51.0

