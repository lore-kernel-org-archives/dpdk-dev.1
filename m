Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1BDCCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 23:09:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A909C4060F;
	Thu, 16 Oct 2025 01:09:38 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 0450C40273
 for <dev@dpdk.org>; Thu, 16 Oct 2025 01:09:36 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b5a631b9c82so34820a12.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 16:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760569776;
 x=1761174576; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=js/x0H8wpp5/D3WWqUCr44lmLK9urduxQlFoHyKwY4w=;
 b=SDg/Te5oEJnURtO82paKI57ph2dxw/DmlltAp8NQtY4PMt0zmmbqE/TgwWzrBvjLI3
 HoiINIm5HKa8C+C4meC6ZiwM7GiVJtOLc+bn8RjlITWod70ug1mFa9I4zFOen+S7fwIw
 6pZcan+UTsK0sRH02Yjfuw9J9uOMh2ph0xgL6HkJUyMVbTgswtrZXxODo76v7wIAdfWQ
 fGd9KxE7Xt6OHFJuR7bZDX9eWaBCpSP0hl1Gqo4Q9mnHZEqLgsxkUpqIB1uYliv9mN6S
 QLAl8phWJy0LJJfZDzDoQmKdM/XkXadehTHA16BAmNZkumdLgPKGEbtLK3PZHO2G/jpR
 nWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760569776; x=1761174576;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=js/x0H8wpp5/D3WWqUCr44lmLK9urduxQlFoHyKwY4w=;
 b=Txi/IX12925b3xHuuSZx33rnr8g/xkuxjCOzI3Jrzpk0u6bTfZTjKJ5QgM0iKkRDai
 2TBVKcmAzsxrGCKCsedgLGRdepmE5BOx9q9bndwo6KAcflZHmDCKKPYtCadcTO5/bxy9
 B2elxS5flrrW88VdppX44ldeQ80Z8z9fk8AksZPiWSHyItm38Z3B2BUgNN6ZqtVwCHzJ
 hsea6RN8/04Zwoi1IYuwsxLvIXEff2zD7bHSTAlI/3XOgxrwNvbL4sZWfO1qQpp35+gZ
 vvZjg0iYSAWAC59bGyq7pySKg/gElW/ZDSFBJmFCOxMM1Ktex6ZLhw7h3PvJrP+nomAu
 0MTw==
X-Gm-Message-State: AOJu0YxPe9Wa+kA2qwfkqt0ZCl+/SSb51EIZP2jVYWS7hHV4260R4iyl
 ixzqe/5KMLotIxH/5d+IXUYUozKRoSvd4A51zwqrRJpzwmnsQM7EWqTMtGnc902186YZMqTxr6S
 hS3umO80=
X-Gm-Gg: ASbGncuLv+uT9EoinxCtB2bFOLmJkkEENDr2gf8bzBeQ9DJuMvCMfMWiwWb/hyWXMZx
 RarPYEffzdYYJVgyLS2+I1DUx212BQSdQbp/OEG6rkNmwggAyRfOuiybWG8dKVykvTDaBxo6Kog
 7+Z8PkmhFdeHHWMGOcqrIKOLLCBK29wNZG8iUygqd3QsP/ogq2ua16gY2qRRSyG7RemoHFlqFP6
 9dWLAbUyVn+j7jnxuWNqrsKJnBtrDW/elDMwrKwqO++ylIebuIQR+Gzuw72i8sqBu/zAuuZvJRb
 bJuxXKPn9CrIMrDlpxEQAeOThfhBqIABvTcfTOqf2QXiX1sjmGq4+ucG/wsv6nVtjvI8qiObwlU
 utOhBgSWrxmF24VOaz2vhP9HZ93MTgYb868oQu1uwKvaJVzHx0C0MOcKPSWPNMNR0fZq43UwG1Y
 HKwquytVyzLkXcQAN1NzifaakQvtwu2aBteJSAeELPZlGBGv6nAA==
X-Google-Smtp-Source: AGHT+IGY6HQSodJ7+dtV084+oUy+g9HbGYXAYJJ1peQj3xdpgrMMqNJVNhM13y+fs5vKrBVzzhZXtA==
X-Received: by 2002:a17:903:8c8:b0:28e:cc75:15f8 with SMTP id
 d9443c01a7336-290272df709mr405621705ad.46.1760569775991; 
 Wed, 15 Oct 2025 16:09:35 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7de45sm7600155ad.54.2025.10.15.16.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 16:09:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFT 0/3] net/dpaa2: global symbol fixes
Date: Wed, 15 Oct 2025 16:07:36 -0700
Message-ID: <20251015230933.875860-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
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

While looking at how some PMD's are sloppy about exporting global symbol
names, found that dpaa2 driver was defining some  globals that could
cause problems.

These need to be tested on real hardware.

Stephen Hemminger (3):
  net/dpaa2: remove unused frame array
  net/dpaa2: make local array static
  net/dpaa2: make total rx descriptors per device

 drivers/net/dpaa2/dpaa2_ethdev.c  |   9 +--
 drivers/net/dpaa2/dpaa2_ethdev.h  |   1 +
 drivers/net/dpaa2/dpaa2_sparser.c | 119 +-----------------------------
 3 files changed, 6 insertions(+), 123 deletions(-)

-- 
2.47.3

