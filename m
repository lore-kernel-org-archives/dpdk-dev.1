Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF083CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 21:29:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 045E6400EF;
	Thu, 14 Aug 2025 23:29:13 +0200 (CEST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 49DBE4003C
 for <dev@dpdk.org>; Thu, 14 Aug 2025 23:29:12 +0200 (CEST)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-45a1b0bde14so7240115e9.2
 for <dev@dpdk.org>; Thu, 14 Aug 2025 14:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755206952;
 x=1755811752; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=awBMBfFiWxL6ZW7G+RUyTmpNjG08uaFgaAzhD/Crk20=;
 b=WZNWBLwiykT8+56/s4vnqti/u/44Q3PT7g1c2ULh45ITxoLksNfqnN60puAqgK1x2N
 vOgj1pW1PxJ0uTo6v0hIEyryCLWsgSp/SMubQP5dLtAq450LnG2CawL3EcSZBVPW7v2i
 xlsXNq4ROCCys+POzPy45vre47IFWlCHsFCJavB1iBCSXRz8p2LPYOhWeTQ7B/ANAmS3
 5CIBKCraftfrQZWHHJhRktpeZd2TzCpv+TDJavmiMLUC64GeaN6cMMl+xNdP41WK6GXr
 YP0v+RVCOBwM8Y5kKy/kQo7XnI2wNUTzhhghS9p4PxbHNgBxAtbErEuMEjN2ppoyu08E
 k0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755206952; x=1755811752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=awBMBfFiWxL6ZW7G+RUyTmpNjG08uaFgaAzhD/Crk20=;
 b=uOZEWUKfu+kwfD7cFMVkHm3QJUr35kho3Pko49PeW4PWf1Xcae3zagejMimAEHAv8R
 zjPN4cWyMUGLpRB7h1Mq/rLwC8aoZjA8EDRypWcgHkIRwUjKaowDES5qF0Pmp2Vcgnj3
 Tato1qelbeq9oHhB6AE2X7yx3G65rBN7/7itBiS9eFI6L/GSKEnWvkWZxbSDGsrKTkjT
 eBxVelTCxG6V/goi4qMWcrE0xaNiFb7ZnZ9eK/DwtcWCk7+Y25bCIhsdQB2byYe3baKz
 nOWSslwT76KCO+xtvFrxj+UoMkSiyIk6qBQB5amiyU+guYyuabVAzSbW2SipfjnJEpEO
 tZdA==
X-Gm-Message-State: AOJu0YyUMGbJWuGghGhUPXkurPT2Vlc3EbrA70jeSEPhBFE49RetcLtZ
 sTILF2yD+ItuB0B7E5fc9NMGa+61zNHqyovbj20X3/fADV+z0AgUgngTW9hzxlpSoRDHoTwE3AW
 Vq90q
X-Gm-Gg: ASbGncsQbB0aQBZZqf5DJBrmisuaxN4n+eHclzceCjrA7dbR5DN9KSLp8ITxT2VMRn4
 xfCzDeDx2GfekH+ZOmzjJbI2VMOK24beyZTdJ2jOJdAhFCcHk9LOpDrXAHskCgsxCvp8xyiVOz1
 ITcDKHra1hUQm+ZgAJQyWv7yY5UyDfK/kJVwfJmFunIHG4vc7swwiziKmPywi64w67x9FjS6iB+
 hCCN9I5lcYPYQ7bgp2YY35SDwjyrhu99zlfMnu9rFoCj1TGSuCwER54UlMaPEx9khlg9zijUX4T
 ZFDVf5zeTNvCR0L7JNVnUX1KuTfcp1bJvN0T3VEuzVHAFwalMF04ZqKuR9a/pYZOQ6rGUAxpzbn
 oQsyuH137zQpTeVZN0a7qpe/Gt41OaOZloQAuEuBK//jSfDKraEzyqD6iZYj1yJ/zJ8sSnV0G
X-Google-Smtp-Source: AGHT+IG543Hew4nX39i5wT8KszGtd49Z0b0yEbVSN1rnEIKi78wKQyOOf3qy+eIibv/riTk556SD8w==
X-Received: by 2002:a05:600c:45cd:b0:459:e35e:a90d with SMTP id
 5b1f17b1804b1-45a20c174edmr3071245e9.27.1755206951468; 
 Thu, 14 Aug 2025 14:29:11 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c78b410sm36404425e9.24.2025.08.14.14.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 14:29:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/6] Enable warnings about use of comma operator
Date: Thu, 14 Aug 2025 14:28:46 -0700
Message-ID: <20250814212901.88863-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250312232739.228295-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
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

This series was motivated by recent thread on netdev
about build with -Wcomma in clang. This warning catches code
that uses comma where a semi-colon is a better choice.

v2 - rebase and drop any driver related changes

Stephen Hemminger (6):
  eal: replace unnecessary comma operator
  ipsec: replace unnecessary comma operator
  graph: replace unnecessary comma operator
  test: replace unnecessary comma operators
  app/testpmd: replace comma operator with bracket
  config: enable comma warnings

 app/test-pmd/cmdline_flow.c          |  6 ++++--
 app/test-pmd/config.c                | 10 ++++++----
 app/test/test_compressdev.c          |  4 ++--
 app/test/test_link_bonding_rssconf.c |  2 +-
 app/test/test_thash.c                |  2 +-
 config/meson.build                   |  1 +
 drivers/meson.build                  |  2 +-
 lib/eal/common/rte_malloc.c          |  4 ++--
 lib/eal/linux/eal_alarm.c            |  6 ++++--
 lib/graph/graph_stats.c              |  2 +-
 lib/ipsec/misc.h                     |  3 ++-
 11 files changed, 25 insertions(+), 17 deletions(-)

--
2.47.2
