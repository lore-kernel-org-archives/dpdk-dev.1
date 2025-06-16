Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7662BC71157
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 02:50:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34D6740292;
	Mon, 16 Jun 2025 04:50:41 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id B63394027A
 for <dev@dpdk.org>; Mon, 16 Jun 2025 04:50:37 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b2c3c689d20so2608194a12.3
 for <dev@dpdk.org>; Sun, 15 Jun 2025 19:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750042237; x=1750647037; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w61g3gODFBcHd3L0MBW/LEyh2qurxab3uNr5nMysw1g=;
 b=ukZldHoAnmPxupuT7gvt+UiUWISg6GvWsVcLDy5xR1Fny6hDL02dQowJuRePwUvIac
 ETVEaGMNzTDRi2ytRCuC0IJ+mY0nj+xa3rYwnjCMtCo4Uge7876naAeAuTLeXE247TaR
 X3pziUKc5A613qvUELaKFs1ddG2W+RTQagox5cShmQy2zbmPk3mwiuU3jSKRvjS1T3UU
 lgxt+WuMK1UsfuEHoakYoUi7ED9vAOLOaSY6p5MWai8oc68MwGLNa+p1jR3tNAUJuvAJ
 HbuCxfB5YdiZKWp9kXoUxLeF5oD9wcQOKmHPNRSjwFtfkSFGbTOFNgW/VLfiMlJkRZZH
 fX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750042237; x=1750647037;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w61g3gODFBcHd3L0MBW/LEyh2qurxab3uNr5nMysw1g=;
 b=tZ642/xjZaxvbP1gao+qviQOLyQANcxb0eEqLCphWxHcVbIL4eloQ+Ool2avoQC+fp
 O4Zn4DXGf3hZs5ZNrxTsEWeH5wsAyOEyGXV6bhBewaPs+OcbJliYSVMf7FLPIgn5Sa/W
 K36VtoCEEO3fgpIywChIql3hzjBNoIHXaDRqlBo7yC+HDKGj+oxignw8Tmlv+vLCl0kS
 Xsw90YjEkMmRc2oCbCbcAcnnbIpX1xif2AMe9jHvorviNCV9qygJGzyQ5gLL4w8aUPRZ
 yQDYLghh89Xvy2Fs1f3BTlkahImoZ5YF4QRA/YNQwMqG7vT+LLJDy7EOXo/jrRRvxDLZ
 iBsg==
X-Gm-Message-State: AOJu0YwpyMvsXwwFTkI7Uc4DeWoaSIMO1OQCj4QC1lnhIkDSdPEwWIcr
 fWEVIQvV87aaO69PPCVJmOmUiPM48HCAezGJAQd+ftuTLojCOl7I98WExVBauVde9Dc=
X-Gm-Gg: ASbGncsSnx34PIYaWzEkpCBHKD2p/SjiXLes0eWqmlzTcPCZR/yJzFEdP5T7pOkMaPl
 5aIDa0kUcXkDZq9Qkoahpmb3VoDHxLThOEh6Rc059L8LFkTUWwZGObOw4amZAGDQJ27oZpaGAnU
 Ye2YVJDOvKqX3ZqkBnhk37hqzfoOYg/wENjVScnLS8XiW6e5kKKiu1a2mldXMg4pzJ63c+8wUpd
 sbv3ePhSAvwY3fH4FyDAOpR0KgH31lJiydqGEP9lb+G6wu6Eqm/S+3o0TzQPPwWrNkh8a3SSFJa
 f9i7qxdW3yzl/cInKKxC2dcTnn6eG1+YENUM/Osm/b5bjvwGS72fDPexVr7o8EAzZuHBw2lzhCs
 =
X-Google-Smtp-Source: AGHT+IHvvCdOhR2sYs0RBV0AQhr7DhUmVLuIr/UXzF9jtodCjQ4qiOu+jv154hV9kKicZoqHVMgDbQ==
X-Received: by 2002:a17:90a:dfc4:b0:311:c1ec:7cfb with SMTP id
 98e67ed59e1d1-313f1d4dc20mr10957192a91.21.1750042236626; 
 Sun, 15 Jun 2025 19:50:36 -0700 (PDT)
Received: from gmail.com ([121.37.54.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-313c19d2ccdsm7415027a91.19.2025.06.15.19.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Jun 2025 19:50:35 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashish.gupta@marvell.com>
Cc: dev@dpdk.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v2 0/2] uadk: realize async mode
Date: Mon, 16 Jun 2025 02:50:25 +0000
Message-Id: <20250616025027.209883-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Realize async mode to replace sync mode for better performance

v2:
Add version check, requires uadk >= 2.9
Add version table describing DPDK and external UADK library
	version compatibility
Mention version dependence in release notes

Zhangfei Gao (2):
  compress/uadk: use async mode to replace sync mode
  crypto/uadk: use async mode to replace sync mode

 doc/guides/compressdevs/uadk.rst              |  15 +
 doc/guides/cryptodevs/uadk.rst                |  15 +
 doc/guides/rel_notes/release_25_07.rst        |   5 +
 drivers/compress/uadk/meson.build             |   4 +-
 drivers/compress/uadk/uadk_compress_pmd.c     |  94 ++++--
 .../compress/uadk/uadk_compress_pmd_private.h |   2 +-
 drivers/crypto/uadk/meson.build               |   4 +-
 drivers/crypto/uadk/uadk_crypto_pmd.c         | 297 ++++++++++++------
 drivers/crypto/uadk/uadk_crypto_pmd_private.h |   8 +-
 9 files changed, 320 insertions(+), 124 deletions(-)

-- 
2.25.1

