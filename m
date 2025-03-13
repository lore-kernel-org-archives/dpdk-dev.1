Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7F7C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 21:52:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 748BF4025D;
	Thu, 13 Mar 2025 22:52:05 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 0B0B74025A
 for <dev@dpdk.org>; Thu, 13 Mar 2025 22:52:03 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-22113560c57so30052465ad.2
 for <dev@dpdk.org>; Thu, 13 Mar 2025 14:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741902723;
 x=1742507523; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0404H3nk+Sj94w4wmlCIxlQZ6i37ww7i0eOuhP52ink=;
 b=OIXCzDbDfDPBTJslwsIF0QP06a1mXRJiKkIX3/so4fqXGDQyqjd6sJgNbi4EnmPkNC
 U4amnTHgdnyZG0YOUJ2Q5r/o0u07iEUpxh/7nY7ORub3Lw5DAOW6PQh0GMGW11Oh+7B8
 um6U5JPSrgkhy9HhCOsgj9Q/WL1tEtf1jFFLClxMqioJDKl7lvCcnuy4BIVtuFs6xMkA
 4NF83gAktegUtwpNL1caw5dwCumMD3p0f8EYsYQZiyESEXDVPFNTNO8/ep6C7CqnV6U7
 +Q2oaXu2cyYQyx7j4rRZyEikigsSFrGEJcYTyktdP+ZWtKxQ95MemBM96jq24oTbS9k1
 aQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741902723; x=1742507523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0404H3nk+Sj94w4wmlCIxlQZ6i37ww7i0eOuhP52ink=;
 b=ThMZezIrIeFgYkP8YQ+xErPD1aQOrGWXeUmEwNS+w6KsXrEMZcgaHmgi8a0pRqLCfh
 eaiDiXwP/l6IbxUkszDqeTgHwOyp/ndyKZW41gyqlPII3Sr8ByOmJxBiBM18Cx6gEtsq
 3Fv3UJUW+Ohvgr+MT3ReQfaBqSs2QkQTZ8jzlMKZPiAr7yyLH5jfmm+512bFLwX47sn+
 yeepz3AS5gZJqaBirwIsXzBGhWlfo9UCrUwBuhyrkWXKKA0kfCj9FrPSdixMGYYIU09i
 VqOTEMjy118H3JKbgnWS8ToCE5wYM5S/a716cPGuwvp71DvD134rY4O0JmBPLmvPGvhV
 f0Jg==
X-Gm-Message-State: AOJu0YxW0rDqdZ5r6K480G6+pOf+Ap8EAH4Y3vgBDBd/PR9f0wBmDSYJ
 bP27qrQqrO564QA474XmLIyb8gE/hMuzQ4Iya909OnG+Z5ASrs25/OAR+Ym75MMm2esgTpDp08Y
 J
X-Gm-Gg: ASbGncukToOzmA3Llch+Vn7kfGF5LPa9NGDLMj3zc7pB9lGE0p8avVwIIbhrbGK70yJ
 LjWGEHiqbamAn/KlQICbJJ7sctfNYZWohsM/Sqm0IGXLKe3AvE6gFuYFvL7LmV0EXZydGk9SRcY
 +rLqxDCCqA4ko6osF4R2hBiHpYl0ht2vnoqAB7s5XogMTtdW+WY21Vo/HIEMrdHDYT4VyprwAwG
 e5IwbjlpjZryiGbiBqOtdz0/Vjmo3mimEkvTPnfcmcIbkbxlOsZj7qGRKsL3nGgrzioSIWF7L9Y
 P8OzH/bY5ubAyEzszX5iZrdC2kugCA+PhJ8l73VnCDAisqbpeawe/kNzaSDQ5DmppR4KO2RKklH
 M5GbCR5bFO+aJ79zglLhsbQ==
X-Google-Smtp-Source: AGHT+IG+OBodtF4h6nxM1LnyLz9R8E9wgH1YzsKwV5SOfiQSxAwlnOlo0uYaMsBw7fAppCWO5svxgQ==
X-Received: by 2002:a17:903:1b6d:b0:223:fd7f:2752 with SMTP id
 d9443c01a7336-225e0a954abmr2496585ad.29.1741902722824; 
 Thu, 13 Mar 2025 14:52:02 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd3d5bsm18337775ad.217.2025.03.13.14.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 14:52:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 00/10] new ioring PMD
Date: Thu, 13 Mar 2025 14:50:51 -0700
Message-ID: <20250313215151.292944-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20241210212757.83490-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
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

This is a new simplified TAP device that uses the Linux kernel
ioring API to provide a read/write ring with kernel.

This is split from tap device because there are so many
unnecessary things in existing tap, and supporting ioring is
better without ifdefs etc. The default name of the tap
device is different that other uses in DPDK but the driver
tries to keep the same relevant devargs as before.

This driver will only provide features that match what kernel
does, so no flow support etc. The next version will add checksum
and multi-segment packets. Some of the doc files may need update
as well.

v4 - more testing and offload support

Stephen Hemminger (10):
  net/ioring: introduce new driver
  net/ioring: implement link state
  net/ioring: implement control functions
  net/ioring: implement management functions
  net/ioring: implement secondary process support
  net/ioring: implement receive and transmit
  net/ioring: implement statistics
  net/ioring: support multi-segment Rx and Tx
  net/ioring: support Tx checksum and segment offload
  net/ioring: add support for Rx offload

 MAINTAINERS                         |    6 +
 doc/guides/nics/features/ioring.ini |   18 +
 doc/guides/nics/index.rst           |    1 +
 doc/guides/nics/ioring.rst          |   60 ++
 drivers/net/ioring/meson.build      |   15 +
 drivers/net/ioring/rte_eth_ioring.c | 1288 +++++++++++++++++++++++++++
 drivers/net/meson.build             |    1 +
 7 files changed, 1389 insertions(+)
 create mode 100644 doc/guides/nics/features/ioring.ini
 create mode 100644 doc/guides/nics/ioring.rst
 create mode 100644 drivers/net/ioring/meson.build
 create mode 100644 drivers/net/ioring/rte_eth_ioring.c

-- 
2.47.2

