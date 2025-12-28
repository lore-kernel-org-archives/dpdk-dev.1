Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6460D3B7E5
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 20:16:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A26D2402A0;
	Sun, 28 Dec 2025 21:16:55 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id C0B2740267
 for <dev@dpdk.org>; Sun, 28 Dec 2025 21:16:54 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-477770019e4so72209335e9.3
 for <dev@dpdk.org>; Sun, 28 Dec 2025 12:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766953014;
 x=1767557814; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FcelxEO9vo6hBe4A6DzAdoiqNl6Vfj1LeZOLPdlM+XY=;
 b=SapAj/YBhg4iXGe097xaHk5RfmABZcUzOEfHMmyh587Gpai9vn+T+UBqrO3l0zlwQY
 GqTRdIs52majMWFKoG18EdUMfK8MXgppfi7JedWLV00awzdugflkvbW2VrJK8wVoKy5C
 g3AA0SaJpcUbf4QajBOVYUf9T3kfq3i0J9SLDSpZBh7KKN4yNi2J7dofKqqQ+3DLkvSn
 JbRIl3gJGS9iCSwRC0JfxByD2DNCvDug7xntkYLN5sG6Fl9fNiJXROYiErPalY/B4cC7
 bqi2fJClJuWl9yaVBK4DIp8QMlf9aZ0K49RDtuf1AaKjpFQHDTvJb4EThEtqp3gq8q78
 TJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953014; x=1767557814;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcelxEO9vo6hBe4A6DzAdoiqNl6Vfj1LeZOLPdlM+XY=;
 b=fN2xwhpovGJSUsoUUjZG3DJOX8MFQAnukIJOEdlKXT5irTWi2akjao3P+qc+nG/qzd
 5aGCWRPsrVOcG4cOpeLudoa6dsJP7MfEl7a7RhOgNedL8Y3fBVH5eQ0AZAvpaktDgAYs
 rerDcm4jFEjhQsMSk0CsSI7lqPM8aOPwAC7s1XVoI0OvC7WV0lKetpxTJA7hj5qTQ63A
 iSgRLkH5pma3SXZB78n9DH9hDOGZSL4dgmPEVuAcemxj4ZNxF7VUzIDvQHvCDU2Vg/cN
 DN4I/DxMGCM+MQHwq56zt2baek2ASpJDmEZfGBNFvQWLPnyhn8WctyaIF0sHuqSz2SEm
 Sulg==
X-Gm-Message-State: AOJu0YyRviow+Wc2KWrdC+Ro8L78aX3bszOPUK26wyMEAY1dp8Jmh+jB
 Mu3RGui50Dv/iBpwcpO912CQk0phOd6cEwzow9QU5E6GGZ5F7wwe8qVucxRbUd1IJ+Cm9YYH4Rs
 XkGfwTFU=
X-Gm-Gg: AY/fxX6a5W6OpMiuB70QCFz7IeSw/zYC80ysyKmAaAqwEZAvqiNquhhU7Wgcy5ucugT
 Y/VmS3e15NnHJv6SOmrjRQF8G1cNvTtWocHwP6FqvZ8rcEUL8G66D1o1ulzrx7U9Pg3GRZgS7tq
 qIFlaTPrBS9tDXeAa9Jc8BQiMgMOI++weK/ntRbJESHbcGfdcwZ7OvIx8z1M6YsH+TLPjE4Ox6w
 sx5LqNJ74SIc7gwBTi2KGqTIjp6kRoBoJyDdFI3A6e/UuB3Lji6jEAc1NbT6PcgnvKZA6mdv/ua
 rHM6LJXmQ78PsQfkpVFnRVdEcukbH9/Eqd9lXMDQITkDh8lwFyzAs6yS2BjkltViTggv7PfW0df
 iZWJEVRvSGpAjRvhnSgWRnO8SMsQe415g7VCwSt8TEDQWhJAgSAOa8htNSWyaJHgjQWF3+tCknK
 QSZyOItFyMI6vQpifdO6epfBZn/drE60vAoSIHyMAzxa+kUyYwDg==
X-Google-Smtp-Source: AGHT+IHjMNRyahi/hb6g4tjcGtQdfRaGlEtA45jZb3xtiscYO5dVrgeI8nr6EQLKqRV889bvQYtL1g==
X-Received: by 2002:a05:600c:1f84:b0:479:3a87:2093 with SMTP id
 5b1f17b1804b1-47d338a6109mr197951455e9.37.1766953014135; 
 Sun, 28 Dec 2025 12:16:54 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a6c9d4sm226286005e9.3.2025.12.28.12.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 12:16:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/4] Avoid using perror
Date: Sun, 28 Dec 2025 12:10:49 -0800
Message-ID: <20251228201649.555898-1-stephen@networkplumber.org>
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

The DPDK uses its own logging library exclusively and drivers
and libraries should not be printing directly. One function that
was missed was perror() and some code was using it.

This series adds a checkpatch warning and fixes the
places that were using it.

Stephen Hemminger (4):
  checkpatches: warn if perror is used
  bus/dpaa: replace perror with log
  telemetry: replace perror with log
  common/dpaax: replace use of perror with log

 devtools/checkpatches.sh              | 2 +-
 drivers/bus/dpaa/base/qbman/process.c | 8 ++++----
 drivers/common/dpaax/dpaa_of.c        | 2 +-
 lib/telemetry/telemetry.c             | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.51.0

