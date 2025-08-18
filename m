Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8794CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 16:18:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B11240267;
	Mon, 18 Aug 2025 18:18:24 +0200 (CEST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 3F80540262
 for <dev@dpdk.org>; Mon, 18 Aug 2025 18:18:22 +0200 (CEST)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-3b9df0bffc3so2999721f8f.1
 for <dev@dpdk.org>; Mon, 18 Aug 2025 09:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755533902;
 x=1756138702; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rSx3bdOjWPCLWK3qG3yysnJKkWqKTHUhY78VjY8M34k=;
 b=ihQzZ8niFLlbBBCwiTJ4+J7mq/wMauF7M7IVIqy7uPOoVOOIGdsjBhkP3FE4cj9wHf
 E71cQqHccLkNmR9FFZ7g140ICUNXGOJEaHkqCTXUXYNRdlwbwLR57mrCevlU0g+V/kUS
 jazwSExIaZgI2KC2hOc7FsEXuU4YOdyMAPvIYNb1lnv3HtJGTKJM6xgJYTLoD9t1VmuH
 RpTV8PrlSIzV8lcGFAJMKVjZ6M1H5Lxrkda/Vc5khDw0ol+mL+0w5dAUHpzvmow2onuH
 zewHwwmBvPoMUAl1Q9mF5UBBoIlmuj0TzfSmYOB5TpO8inre9q3YmN9UlJvr781GaNmS
 34Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755533902; x=1756138702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rSx3bdOjWPCLWK3qG3yysnJKkWqKTHUhY78VjY8M34k=;
 b=J15kLrqR27DCzZ212qO77AIMMu1xQ9kLbi97H1TgbdvAFwKtbpwg8rYLq2437vw7c8
 M0TbDP499N4FGPlDxOK2D0yY+Q50J22+NH13x8U0cRwbBfqAOlfcbxXy8zwS9ELgivlT
 VwMDBbIJmtI9rbPYAd/UTko3puO5TY4UQSKEKgvlE1QpTnkkwd0N8V9hflHJs2Rh3tH8
 Vk3P0j69yQHs1FFKJo+URGs7u2zsuxPfdEZeENRLZSB3gUtEZg564/idgMD4FclXSRIV
 L6J77h1NvlftSmT5NIvlL16GKiNoSrHf4mr/ynCOxE+CjKONBhLIsvv3zj20GKrvbXIb
 vGIg==
X-Gm-Message-State: AOJu0YyT9yZ1C53w2FPg/PfGOcC4UCqhW6sA/fdtq6rhz4ZaJ+WoGHnL
 NrpGSMA7B8NCG4f3pnTAqtOls6Ul3Ex3jCCD0x9CVnXS51Weh23Ldf4FOC3DyAeadE7WmPcPtC6
 U0Blw
X-Gm-Gg: ASbGncsNObUIyEmVgpwst8wWlTR7EJMYb1CSRuuxuqTp+J//CfS7gJzjXs00QMsw3ey
 UQ2RHUFkY/4+MHWJ4wGsUmtfzLqbREOFaCcIsLqQRojObZixBrbwDE1YqHpIA73HOU0o50uGd5M
 IXWn/3nhn/S6c78WQF4ekelg3Ijzr0MuieT3IT2agLiYadAdPJtKhH48xWuDE1nynGZ7TWI9lh1
 37+4xe7T8X0qKUkkCN+EJGquTBZcJ1NjgiKoVH7n0mOMTFw2JvUeE3EdmSUAARXUfMPxbd+qKvt
 uFYU7OYROBdFtn60L0KE9N51Jeoti/QGaOA4L6gT+PAu3ee0zr1ZpaH0Wu9R5jZf46wVOL5UZ4M
 1871lwYGbvWXYbhdKBGMSwugNEo6f3HU+hq2dJUB9LBMr85QRR0oBUUzUG1Jck6A8mE1cFsrRtc
 C71ar5T7A=
X-Google-Smtp-Source: AGHT+IHgF5rpxwURyD7PP+ATGFIWcKPK/JdTLEJ2OC0NwRv231YOyrGVJMXgGR/r61rgZ/dJB1IJ9g==
X-Received: by 2002:a05:6000:26c9:b0:3b9:10af:59f2 with SMTP id
 ffacd0b85a97d-3bb68546002mr9194640f8f.28.1755533901491; 
 Mon, 18 Aug 2025 09:18:21 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fcbsm147865f8f.9.2025.08.18.09.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 09:18:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 0/9] avoid unnecessary use of commaa operator
Date: Mon, 18 Aug 2025 09:18:05 -0700
Message-ID: <20250818161815.23611-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250312232739.228295-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
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

Clang has ability to detect suspicious use of comma operator
where a semicolon would have the same effect.
Easy enough to fix in DPDK code.

v4 - review feedback about consolidating assignments
     fix Broadcom drivers (Intel and Nvidia still have warnings)

Stephen Hemminger (9):
  eal: replace unnecessary comma operator
  ipsec: replace unnecessary comma operator
  graph: replace unnecessary comma operator
  test: replace unnecessary comma operators
  app/testpmd: replace comma operator with bracket
  examples: remove unnecessary use of comma operator
  net/bnx2x: remove unnecessary comma operator
  net/bnxt: remove unnecessary use of comma operator
  config: enable comma warnings

 app/test-pmd/cmdline_flow.c                |  6 ++++--
 app/test-pmd/config.c                      | 10 ++++++----
 app/test/test_compressdev.c                |  4 ++--
 app/test/test_link_bonding_rssconf.c       |  2 +-
 app/test/test_thash.c                      |  7 +++----
 config/meson.build                         |  1 +
 drivers/meson.build                        |  2 +-
 drivers/net/bnx2x/bnx2x.c                  |  4 ++--
 drivers/net/bnxt/tf_core/tf_msg.c          |  4 ++--
 examples/l2fwd-event/l2fwd_event_generic.c |  2 +-
 examples/l3fwd/l3fwd_event_generic.c       |  2 +-
 lib/eal/common/rte_malloc.c                |  4 ++--
 lib/eal/linux/eal_alarm.c                  |  6 ++++--
 lib/graph/graph_stats.c                    |  2 +-
 lib/ipsec/misc.h                           |  8 +++-----
 15 files changed, 34 insertions(+), 30 deletions(-)

--
2.47.2
