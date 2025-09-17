Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C00CAC598
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 11:00:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 011B64042C;
	Wed, 17 Sep 2025 13:00:33 +0200 (CEST)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id 5F4A9402C3;
 Wed, 17 Sep 2025 13:00:32 +0200 (CEST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id BEA434025A
 for <announce@dpdk.org>; Wed, 17 Sep 2025 13:00:30 +0200 (CEST)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-45b9c35bc0aso58428695e9.2
 for <announce@dpdk.org>; Wed, 17 Sep 2025 04:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758106830; x=1758711630; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=IWlk9V8L/mx1QBXVkMlTT98YBX6sID96O+p2dsX2+S0=;
 b=eo1mX2P+Y5enozoJnJYmUiAEDMonug65sQiC/w4U4GqY8y5m0VRVG/6r4GFSRGXT/B
 fADbPBpssM36ZMp+poDf1Z1It/f8+HlCR3iBhE7+1oHdsK+oFfd/8Z5EkwqFw1GOMbRO
 kAvUgp5cEtTZlb8j3w0k+Z030l+dhkLlzZcKExPQtCZsncxU0MLDWVKHXwaMynkCQw6T
 yFcaZuG+wG92iL5WHMZ8NE7BApQ59a0H16Prs6Rj52QswH3k/qWXi0QYe+3tAZ4aDjbO
 5dg0F8ZKyqlFIpJr0RJCEAhzjMOyGHo+4NnZmaCuc94AGjqpdUD7Z5OMau8JW25eq/Kz
 K2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758106830; x=1758711630;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IWlk9V8L/mx1QBXVkMlTT98YBX6sID96O+p2dsX2+S0=;
 b=Otld6VErWwm0VBqYA+e2QacTDWdOyZBS5lHrwI3UAdLKJmBO30KujfLJ4UC+h/NakA
 LvOEvJCiIyQgeMEDGNGhWUXkAM4ZqG2EjjYrycc7JLoEUHslmrU4jJJWtoAwLgZH4gfX
 F8vZZaN87fv2n3tqAdmhU2djBeQ3CmH4mybJ04ZP7XYgJ2tRzzJD5r866bgtPxWTBP7a
 5UBdlFdGaywegljoHMEddg8ptFk4NnStcYVCWMoGhJUI7Vr9dcRcXk9VMq2sby1ILmXv
 +Dd64yStmiUH0lRTCYEICBtLvK/rhAf7jQ2G6o/qRCqL+DoghC733eIxAVqiObawcdeM
 h/8w==
X-Gm-Message-State: AOJu0Yxh/3P5TimoalVwYGkOHrT8goZR717Cl0K9S+yDTTZtxhwlmCSc
 yKwr5d/osl3zHRNSv6GLIOr0gpDZzEnPoSjZSfiZgV5dY1ru5rHTBGmz0XenJQDH
X-Gm-Gg: ASbGncuuivU+a7nfQMFSI5nr9zy2a6AzfR20ib26hQOlHrf+LkRTRSEpifmzCVWc5gZ
 i6pr7YNNWeq9i+iJCJrLFhJNysehFxGHZW42BkqaTQkQCSVGbwlJMh3dVl2j5KlAwqJ/98X9B06
 iDv+jm5N+FYuAJ4YksMa6G7ga5+AUZuu/CE8oJKItWbF8YKMa4bx62KtykJVtWBDJpoK4Px5aic
 Vn7HzLZLoM96X9qQKnDiq938w1Evz1Uz8Ze9/d/KY1J9GkaQAa2iop1wSxzwXZ1Utgi4lbHSWBa
 qvT00xAbwZkG2mHP528Us3zFqgjxT4WZJcuT1RG/JEx9KU5PWoIlJCg4PaYVGOh1G7/JkOevAfh
 gcpUYD/syI7C9yqfI3PV5Kv3OnKFt
X-Google-Smtp-Source: AGHT+IEIZkRFNh786sza+5XKQbDyZhDk/Eo53pJPE+aVJ8J5NZf24pL5slWoEimBBF5QVEsrCSrG/g==
X-Received: by 2002:a05:600c:c87:b0:45d:d1b0:5fa2 with SMTP id
 5b1f17b1804b1-46205cc85ccmr15599235e9.19.1758106829863; 
 Wed, 17 Sep 2025 04:00:29 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:cc34:6a12:5564:42df])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4613dccb4fesm33878605e9.16.2025.09.17.04.00.29
 for <announce@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 04:00:29 -0700 (PDT)
From: luca.boccassi@gmail.com
To: announce@dpdk.org
Subject: DPDK 22.11.10 released
Date: Wed, 17 Sep 2025 12:00:23 +0100
Message-ID: <20250917110024.2548019-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: announce@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
X-BeenThere: dev@dpdk.org
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Hi all,

Here is a new stable release:
	https://fast.dpdk.org/rel/dpdk-22.11.10.tar.xz

This is a security update to fix CVE-2025-23259.

The git tree is at:
	https://dpdk.org/browse/dpdk-stable/?h=22.11

Luca Boccassi

---
 VERSION                                |   2 +-
 doc/guides/rel_notes/release_22_11.rst |  14 ++
 drivers/net/mlx5/linux/mlx5_verbs.c    |   8 +-
 drivers/net/mlx5/mlx5_devx.c           |   7 +-
 drivers/net/mlx5/mlx5_ethdev.c         |   8 +-
 drivers/net/mlx5/mlx5_rx.c             | 281 ++++++++++++++++++++++++++++++++-
 drivers/net/mlx5/mlx5_rx.h             |  28 +++-
 drivers/net/mlx5/mlx5_rxq.c            |  11 +-
 8 files changed, 346 insertions(+), 13 deletions(-)
Luca Boccassi (1):
      version: 22.11.10

Viacheslav Ovsiienko (1):
      net/mlx5: fix out-of-order completions in ordinary Rx burst
