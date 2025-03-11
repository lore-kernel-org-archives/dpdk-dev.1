Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C180C28B2F
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 23:54:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24FEA40265;
	Wed, 12 Mar 2025 00:54:41 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id E5E5D4025A
 for <dev@dpdk.org>; Wed, 12 Mar 2025 00:54:39 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-224100e9a5cso116435905ad.2
 for <dev@dpdk.org>; Tue, 11 Mar 2025 16:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741737279;
 x=1742342079; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=az4Ug9NNpPKGuGDTJEckBKHCGgamLf5ohS26VuAku4M=;
 b=BoKnhzbXUpsF0OlOUSeUM5boppMWFkSBw5sviznbCuBBaTVOjcd/00WYbHRBnuZrTI
 q/k1OROjmhFRNNApFaVCKzfyPRqjjhBXqZ2FcbsF846bpEtTyVj/51Z2Gk0ooYZzXpLL
 dXihg9ZNUftM4KvcrFZNh3Z7Ht/4mErAQv7i+tl8aKSH6YLPEdSlHsw1b0KfAJsLLZjv
 ArWJk8AGgKCjFhhsWxeqzUPYFkfogR6bdug46LBHFoXHbj1+mACDax7+FXXJXqUrMgXZ
 byCJ8HTJDLj4QE5hJc67V/JUILE70dT7wozTZ9auJWZ8lrWKtEY33sEtjaT7RXDAysF1
 YgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741737279; x=1742342079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=az4Ug9NNpPKGuGDTJEckBKHCGgamLf5ohS26VuAku4M=;
 b=YZp/F1zLXaWuXadf8RBJWv95hvdZlaLsubWr5rIKgSyermrzGBtbPvEgDICWqcTmyY
 F9mw4DqLtz91YspQsdiuk5rq1OrErRtXjYTGK8p1j7YqYnqA3xGOJ7AVBYzsJWeWVnfs
 0F4+z6OpEjygcPGaTlBHZlPCGcjxyY6N3le/LNR5HtsqrmOt1mhZC5fT5gCBaiMyPjsj
 8wItzwkH9rKn3e6I6Rqs3v40TaxmRGQkMScDTrcvrS9+qywPvPfjk18yT0XF4gvWzjPM
 E85O/7M/Ta8qFyjOSHER31GktZhGT1YATzAFZ8Th3qFZNVk13j0W3HWJ7HhZ+FOxhIVK
 wx+g==
X-Gm-Message-State: AOJu0Yww3yrrsBspz3r4ujYkPVMvHUIKywx2i69AIsZJO5a+ybKcjwWR
 imPA94p0hsVQp1V5XqajZa9SToV8eHFDiWHbNP3mDJ1kRMvP/BWPwF93X6MJ7v4h6RL4QbTVPbi
 N
X-Gm-Gg: ASbGncsbtEF+1g/axRPYpf1cju+jUh6UrVVP8u5hRuhKNsJO1g47SdFHhzUYqujjZb/
 l0xT3zoevxuXvWqA2z934H4BdpKaHxXV/64xY+u1pNGD3XNuJQ+AYEFQSUq6oDvPDAUt/X0s0yI
 U/m4nAaXD8zo/uldW4hpsyw08II6tl0JRdVkXFJPXy7hv6eQhZH9Aisc9k/3PA5LiA6I6gZBHen
 XYSoEXZFP/lPUDFwhIjlhfMrzcitzF9u8RPsez6+MdUJTOw4X7kKXBDKKFR3r16nfEZJZJHdW4y
 2XO5INOfPbJPCZCWdslVB8RYPfCCcufuUvdjZXB8D6lFmNUNgc4iHPpjz1fooKmr0VT1PMbElmw
 3mqQlgIzoB2cuxSTnzi9OaQ==
X-Google-Smtp-Source: AGHT+IFljB/l1ldeQQDES50h7EpjbtVjgCaFQVSsK1XCLXkvZD/yOID6ybOpUXN0kH2AdORyalEzLA==
X-Received: by 2002:a17:902:e5d2:b0:224:e33:8896 with SMTP id
 d9443c01a7336-22428886514mr290532845ad.11.1741737278960; 
 Tue, 11 Mar 2025 16:54:38 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91cf4sm103734145ad.200.2025.03.11.16.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 16:54:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/9] ioring PMD device
Date: Tue, 11 Mar 2025 16:51:18 -0700
Message-ID: <20250311235424.172440-1-stephen@networkplumber.org>
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

v3 - add multi-segment support
     review feedback

Stephen Hemminger (9):
  net/ioring: introduce new driver
  net/ioring: implement link state
  net/ioring: implement control functions
  net/ioring: implement management functions
  net/ioring: implement secondary process support
  net/ioring: implement receive and transmit
  net/ioring: add VLAN support
  net/ioring: implement statistics
  net/ioring: support multi-segment Rx and Tx

 doc/guides/nics/features/ioring.ini |   16 +
 doc/guides/nics/index.rst           |    1 +
 doc/guides/nics/ioring.rst          |   66 ++
 drivers/net/ioring/meson.build      |   15 +
 drivers/net/ioring/rte_eth_ioring.c | 1129 +++++++++++++++++++++++++++
 drivers/net/meson.build             |    1 +
 6 files changed, 1228 insertions(+)
 create mode 100644 doc/guides/nics/features/ioring.ini
 create mode 100644 doc/guides/nics/ioring.rst
 create mode 100644 drivers/net/ioring/meson.build
 create mode 100644 drivers/net/ioring/rte_eth_ioring.c

-- 
2.47.2

