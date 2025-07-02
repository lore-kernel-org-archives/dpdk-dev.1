Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2968AC7EE30
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 02:42:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 184AB40298;
	Wed,  2 Jul 2025 04:42:35 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id E019A4028C
 for <dev@dpdk.org>; Wed,  2 Jul 2025 04:42:33 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-b31d578e774so6852554a12.1
 for <dev@dpdk.org>; Tue, 01 Jul 2025 19:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751424153; x=1752028953; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IDvovF0wioTqc9lMp1J7hgAU6g5KxpgT5wvDmKRZZeo=;
 b=LEM3mo9o2JGNURUnm+FCn44iZWaqvl4kOj0mZfkRAdfAx08wS1CbsLkCeaPeRqjRcU
 y/tkMdSpGp+R7D5uZCG/+CH0LhkylVWv995U44OYxkLHVR1jdOIiPTmOevxc2uljkquo
 rNfK1Wb8Dzer512ov5cCgq6Je3gxQ99yalQfbaWCT7zvFtija02yAkfjxI+ue9EWuO+U
 BFVy4gjMR6PC3xUZ4Z4dGwXoM6YZNoWsueGWQw9ZxbJAOMcwZj52PICDuHDPbXIxHkIv
 b4j9Ry3Rx/gW/wwRUFGZOJdTv3yJV7gAjUFwg3jKO1fpxaEgeh4O54z3Tu8EzrVbDOLO
 T+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751424153; x=1752028953;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IDvovF0wioTqc9lMp1J7hgAU6g5KxpgT5wvDmKRZZeo=;
 b=MOu4r0Zi17KNqBr5tFWASTv3N1xs0M1kDxnWpv93hp93c4Uukuk0b39tTFJYbP7pxH
 4Y7te3thRXScBC9fltSodZg6XRfh0MIJSxvLqtixr++002zORaO3kta0Ohlb9kqYUoxx
 dwbV13DieWCjRN6mmS+2aR+EfnPLqeahTDW5Hz+kcJ718fvZEAwZiicObDjvPE6Xp0Dk
 R+YwNdx6B1caAOFEn/GArlEGe047QwMwqFvtklP1ULb5wwutwc3Zlx4Qs2vqpaTAnPcO
 /mFbYu6g+GClKfKGnfuO1kayTVdn/jBzyeJ43BPzwuJv15s8AW1PBEkbkV0Nl5lbZqMy
 4mrA==
X-Gm-Message-State: AOJu0YzrPYiQ672emgMM88fdem5bpoms/n9Dv5FQHFt6mL3R586zTXed
 B/44hV/1yjn5ph0h5kA8zZxJeBU5cy9ZAK/Rwjm1MbYPT2XDkgTTMYeO1EF/FJJ0Jt8=
X-Gm-Gg: ASbGncuuAYsiYwEAHm2MoggVxGAoXWVbO8TdAgb5dEpYcc90EJksE5iT8wXHPos2pXb
 jgckSwD5R1swqqa4OnGI9wxuBQRRG1DN3/Uhj6bXHnua4H33NEo8Yh02ERZ5BAQTovMofL+ZolV
 fE4u94IWJ3h1JEUo2tBolVVVjqmbksQFtBJffi7TCoGSqR/SdPTHNwqtJUxHM8RiRP299+AGor8
 Y9JGmZnfBsT67zTEaGMBYnVrh0QX7fV4lfuml44QIGA7Ldh1UbVK1eUhtQrmOCdGq+T9EIsyxKe
 SKhO2bUK2QLzJqELd4oOqn2PCEMqgicyiMZ+uh+mx7qoGVJQw1aBI7fVIgwS7tZl
X-Google-Smtp-Source: AGHT+IGECUF4QuhbGyx+RQkX/M6TDA/IxheBeY+xJEUApgGKDeUgbO/1AvsthjEversfM8oqxsDgxQ==
X-Received: by 2002:a17:90b:5546:b0:30e:6a9d:d78b with SMTP id
 98e67ed59e1d1-31a9181f5ffmr1294304a91.12.1751424152937; 
 Tue, 01 Jul 2025 19:42:32 -0700 (PDT)
Received: from gmail.com ([121.37.54.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-315f539e69fsm18171096a91.11.2025.07.01.19.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 19:42:30 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashish.gupta@marvell.com>
Cc: dev@dpdk.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v4 0/2] uadk: realize async mode
Date: Wed,  2 Jul 2025 02:42:14 +0000
Message-Id: <20250702024216.49587-1-zhangfei.gao@linaro.org>
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

v4:
Akril pointed uadk build issue on x86
uadk 2.9.1 has fixed the issue
https://github.com/Linaro/uadk/releases/tag/v2.9.1
Update doc accordingly

v3:
uadk 2.9 is released
use different label name to fix build warning:
	"duplicate label table_uadk_versions" 

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

