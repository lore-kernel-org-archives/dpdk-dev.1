Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3168C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 15:12:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09DDA42EAD;
	Tue, 10 Jun 2025 17:12:04 +0200 (CEST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id 6C15B40672
 for <dev@dpdk.org>; Tue, 10 Jun 2025 17:12:02 +0200 (CEST)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-4a6f6d07bb5so29868291cf.2
 for <dev@dpdk.org>; Tue, 10 Jun 2025 08:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749568322;
 x=1750173122; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bge+GMQ2SYwizQI/SuUHr5cmrz0ynTjy48IkDmFAJdU=;
 b=zZXkYOZrN9tCbS9k/Hhbc81+JXDp0a/K916jLO4GLbr05s8mbD9s0MZipicJdz5aQo
 32QYZTZckR9LE8SITA2E0VQT7xvwPETaSnEbUQx8pvGhoyLka86ui5AHj7ykF9HXFZxc
 zNrWX3MScuvKzDBwotcdVHzk7fZQu7zjC1rlpAtITHMqGgNc7ueo/WGsTWLVOfMUFKCG
 yWh/DMQRaFPEN/h9KIa1Vi27TLqt6Xv/NLoixMOy6PdcKKEtJtilCuS9gxN9se7EuvCY
 B8ddWkR9E9227rRU9otX20/HWPTTmqAp4Wc0DOEvvzAa9goTPsRo+CZo7wckkzz9XH5W
 l98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749568322; x=1750173122;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bge+GMQ2SYwizQI/SuUHr5cmrz0ynTjy48IkDmFAJdU=;
 b=VpJMOQwJBWe3fgRzKoOTGVZkN0VC6UBkJkTSpiRxclFEAYMdrTRO3+axYPm+552Vm4
 e1XVW7gStRmNo6OqVDRXaWN+QEGe71vNB3C8Xd61HsYcsf7rcS232NJFq3BnwRtMH7wY
 kzN3Zjrsr2gWBIOsY31kQFKztY6mZmu+uPao2bXPFuhn+ZfGMl0XryXo3mkP2tNys9FV
 aPaP9AX5x5XBuTknTlUynheBHTU2Z8QTlhP78u9T+35MC5yJvExVF+RabLGCA0w9ztdG
 q3BqF6YK0HfM7F9MMq6yWAmZoUjpc+JQV8+GFWR4oZwXUvifFenHcKhFovaAo1uewhmA
 XKhA==
X-Gm-Message-State: AOJu0YzB67AoHnI2H2/qEUpr90sXw2E0Yj/spJHK9jVTdPqqGYajwgPD
 XmCqCHtsDqBeRPUVC14f/nnDVTqQ16iFpv70CUUDv+2wNXrdJd9Htjy5OV7nIbiwq+E/DH6AA0W
 zP5yc
X-Gm-Gg: ASbGncvlCSp2N0iakuQNprcVoZZh4n4DjyHl/Yxg10Fitzq2Tx/4it+FLTB0wt/LFR1
 Q5GB0naNSG1zKtu2S8pPaC8c/cbACf9R+FROLs1fXNXRWY9xnXz4OssAJeyJYZXTJ44nxtVsLOl
 s5qzP7zqzqrFAqtT7LUkDWmzRp5n9jkLvzc6qEqYKRCBV9luuUL6JDDYPzq006rzhkB7G/V3oLb
 QJZE7OHpUhid9ciXkvEauX9sIpNS7LsNUoQ1OfFknYFaVlxqIjvhcPWpGdlk+Gb3HvU959sdIZP
 wtmlTx4r+8amNP/u+d1jkLvRT0dEo/uZLtHWCfRorIvLP6+qPhtujcXtrrbLUeCxOIMIK2UAp4A
 1EnVupHYXTVgdcQSL64y2UGnWmN2VodUFldcrlECAKcDHCcc=
X-Google-Smtp-Source: AGHT+IHEcy9NShuSAaK8CgQMMmv6iLZtkXPoWYrP/2dz/PiOCRtdddrthAbrT6mWiVCXAaK8AXIlXA==
X-Received: by 2002:a05:620a:44c1:b0:7d0:69ff:385a with SMTP id
 af79cd13be357-7d229933d8dmr2325224285a.58.1749568321445; 
 Tue, 10 Jun 2025 08:12:01 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d2517fa678sm705822685a.22.2025.06.10.08.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 08:12:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/2] uapi: script and header update
Date: Tue, 10 Jun 2025 08:11:19 -0700
Message-ID: <20250610151158.209572-1-stephen@networkplumber.org>
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

Make the script do what "make headers install" does and
update existing headers.

Stephen Hemminger (2):
  devtools/linux-uapi: conform to kernel headers install
  uapi: update headers to 6.15 kernel

 devtools/linux-uapi.sh          | 16 ++++++++++++++--
 kernel/linux/uapi/linux/vduse.h |  6 +++---
 kernel/linux/uapi/version       |  2 +-
 3 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.47.2

