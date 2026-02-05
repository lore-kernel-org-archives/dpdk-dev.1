Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9439CECD994
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 17:57:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAC1E42670;
	Thu,  5 Feb 2026 18:57:56 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 57E8B40684
 for <dev@dpdk.org>; Thu,  5 Feb 2026 18:57:55 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-480706554beso12651145e9.1
 for <dev@dpdk.org>; Thu, 05 Feb 2026 09:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770314275;
 x=1770919075; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P6SQIocQsNuZ5GCxf1nOTgKfxngkNZ531l05OMuKHB0=;
 b=VZD96GAsawzrpAlPGmfbtoxlHpG0GwfW/2D+gz0MNhrGmWe10J4SfHYlVla+bDyxMk
 ouxKfVs3CNpbDX4cTxg8bKQ9iypRuQXEbj84LcMlSpUj/jPR5ZZS77nxxdExa2rdXjUc
 dSPNk8wyzF2UsJe9VwYeMb6QOWMdYJcZU+wb479QPFLmaNppxo/QtV+LVm/Q4E7PVw1j
 BJuOVRl+7JQA4ZNa91+9/UVdEfwo8NgcpDiQOjrWoNLB3lBkZxQle1kembtYBW2rqnni
 5i5fdGVTCjnGXk4nGXuFZJXD5AnkvgWXKNWwseD14cyiksUPWxUb0UZt2q2a2Mm2l7+0
 AZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770314275; x=1770919075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P6SQIocQsNuZ5GCxf1nOTgKfxngkNZ531l05OMuKHB0=;
 b=BZBBm6DtkRmjjhyN+U/OnZBE7A419Xuo+2CjJd8XNCxBVpB0tZv2qtvn6lm8lGo202
 wDb9+nhiqr2P+jCkm/BxsnxsTMqIfndc6v3YXBErggiQZOtzVhfui+mTcc7xbW98875V
 WXDR8gGuawMpbqO7ZcB0wJVS1hRqJcJjAD23XbOoTD1U+VVdbRtOiSJMV9H3Vq0/VX+S
 K3AGqHdwfl6n6Nd561d9MetR9CDwc5Ryv/SJGQXVwZjhisKVgrM2xwi+KRY1c1jBX5tI
 5V2B83ILYXqpJblIKgtCqfLe6yz+fynUK2P2tjo93smWrqLjawQMECsMFy/7+CjqtMUt
 gMiw==
X-Gm-Message-State: AOJu0YxXGGo90t7wFVSaKTBaA3f9osV3kjdaF7AbIjk4J0IgJHxl7REn
 FWUAV2on2pYSDdQvHvgpEhSDmcJ5hIj9nBPGGWPQ5TWXgUgElfMNbqE2C1wMEf0AdEMetaU1eWU
 +XM8u
X-Gm-Gg: AZuq6aK/wPOY/5SwhR7rlO1T+OpGHhAGwDuLmpsgf9TJsws00YPV532jsM5i+mT7Bs+
 udFlWyVC9GuvTwRwKxNs6OLvpGnMuTo34Nbn0QE0ybWgxANF158V03JlKwdkBkh8a0DC7YCrRSg
 4nIAuJEa/D38DBlIZqkbM38HmayYwEgYpCkhXGgNAaMiue8maZAdwj3/hqaimXXoPYzS+8a/UUh
 FMx1ioJAzdcVoM7opXKCI0Z7sxiQi+RPSqYKDDwhdbAW9wEvaIV+y6mscHHULW/lJLPZ34n4v9R
 jRPK3jdvvNyKfD09fqZO1QGuNY5Jdj+o+A3dCPYoH798k8pv9qVi77C18IcPUKj8qg7bmLQkACc
 wG+pqhP14V6opW19+LNrSniPmcRPONycC8N8o1yQnOJtFKJDN1vw6eJGHeMI9K6f24ckx4SuAmN
 MsKO+Beb/CA6o2wCCdPTCX1J2RJ2Kzffi4QH/9kC/odAtO/PzHcw==
X-Received: by 2002:a05:600c:4745:b0:47e:e48b:506d with SMTP id
 5b1f17b1804b1-483201e4b18mr3738775e9.16.1770314274904; 
 Thu, 05 Feb 2026 09:57:54 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43618057f7csm15465594f8f.23.2026.02.05.09.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:57:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 0/6] Fix LTO compilation warnings
Date: Thu,  5 Feb 2026 09:55:52 -0800
Message-ID: <20260205175750.653353-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120195418.466318-1-stephen@networkplumber.org>
References: <20260120195418.466318-1-stephen@networkplumber.org>
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

This series fixes compilation warnings and one buffer overflow bug
exposed when building DPDK with Link Time Optimization (LTO) enabled.

v6:
  - net/mlx5: use __rte_assume() instead of runtime bounds check
    per Dariusz Sosnowski's review, avoiding any overhead on the
    flow creation fast path

Stephen Hemminger (6):
  common/cnxk: replace variable length state array
  common/cnxk: replace variable length array
  common/cnxk: re-enable vla warnings
  common/cnxk: fix buffer overflow in SA setup
  ring: use inline instead of always inline in soring
  net/mlx5: fix LTO stringop-overflow warning

 drivers/common/cnxk/meson.build      |  1 -
 drivers/common/cnxk/roc_aes.c        |  3 ++-
 drivers/common/cnxk/roc_nix_inl.c    |  2 +-
 drivers/common/cnxk/roc_platform.c   |  4 ++--
 drivers/net/mlx5/hws/mlx5dr_action.c | 11 +++++++++++
 lib/ring/soring.c                    |  4 ++--
 6 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.51.0

