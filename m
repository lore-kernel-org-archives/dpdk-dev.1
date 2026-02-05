Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2346DECD993
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 17:58:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA12A427A3;
	Thu,  5 Feb 2026 18:58:04 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 40F04427B7
 for <dev@dpdk.org>; Thu,  5 Feb 2026 18:58:03 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-436234ef0f0so601053f8f.1
 for <dev@dpdk.org>; Thu, 05 Feb 2026 09:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770314283;
 x=1770919083; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tG3Xqs7sJ99JZUo3PX/5mVr2yzPLwBSuqCbr16ww8N0=;
 b=Ep/r75aJ0jrOgOnWp5uZYu2PnmAqzyR3IKb9xfVDmwpDgo9GXkiToPj2RwfEFI7ShR
 9+/NneiMoAr8Ljh8S9PeuY4nUtN4oAmRnKSMU81+AvmEt85g4tjEfkvcdkjSI95XAGHk
 nIBBLIvIpaxT3YKvUyRf+jUb2ljQML+IVjPAPO2CwgkMv6d37+JINfmmQK9wQVjV/neP
 euPUiIL9KuQVAJ5yo6a4gGat5GjN8nrdPI2uTsVz/zjESUxtYEgMkAtX5RpLFPk9yrwL
 A5PYFzSrdUCCoSxbWwu308+RGSEa7CIM65WH7LHdci1Hwqm6CDZKqDzk2mmoLzPU1rRX
 JY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770314283; x=1770919083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tG3Xqs7sJ99JZUo3PX/5mVr2yzPLwBSuqCbr16ww8N0=;
 b=MA3eU8bW4QCycTF2qjuFPkz6YJdTEHBKvc+7KSjr8TlP2GpzGH6HgvrJosV3iPq6+v
 ApN3+psAnxSISZi646nSVG0iou4OhnuslOrOYM2QRbk18mF0Nd5E4gXUIw26wbKnxM7v
 jHpw8f1FnxP50xUPgh/mPQL+mRVrRi9FrWmaWhXTGoLZihGtx5OLmy11NChXiBhSWDh0
 koBElToqV3rgQn5zIaGb3wjg6vQ4GI+W7b8b0rhOSU8CT/9xfuOoKMVPfrsXo7xO0q39
 c0SDJGuTaLJI3OZiQVioMODaNq5JftqdsRgqNhI2bWqRvXRdoJTNs0HiuXZqBHEy7OYr
 8XkQ==
X-Gm-Message-State: AOJu0YxRzF+5i2VG0njFYH4Po7eJ6BCk2+EPKim6ci2XCkaILTu8d8w6
 tKbZxgUE4W7IcIUWhA0C8n5psx6qAAWJ0uUXv2gy1oyZVL7p425i8O4Arz+MkAuS+itRg9xYP1e
 TSyLR
X-Gm-Gg: AZuq6aJoF2gTY3uuq/1o4FjtacSio3UTayOlVqpyIsufQ0fqS5kVzZtmesG/EKelzAE
 obCy7LZXj1SkK/PQ8oW3IrLr0j7sZXWWiZHRcFofmIjTExZubVhz4d+/h23jzXSU9QAO5TuM1Vm
 cWSEGlTjbLXMMSU8CaTASYoswvJHbICPYCOldCGpi2k5oTgjU1/IBa26yFZ1oPvg3tGtkcZxKwP
 cqgK/dwLgItr6xCo/j5ADVNNdpXwjI8sEMmcqQquionP0rQXmjHxe/6wg6qpPM/wQsbukvt4zTp
 V+n3iqD49SE/XNoDXVnwGjDIV6cWgDQo6Ho2kwyMDshB1IG4i79zyfXX14zT70/HMv3uMsZkrH0
 riPMq5RQNg9BGIT9SSlTl2bz63CG+Opttpyqgpd/ZlPQrvLY7fPK0L1vLXa51HWRwxXTtmK0P8Z
 YjJzn3HllllZoww7Df54scCmKsUlS0nEJINQb4gHpguRV30FVJag==
X-Received: by 2002:a05:6000:2481:b0:435:b68a:3b07 with SMTP id
 ffacd0b85a97d-43629387c4cmr122634f8f.43.1770314282806; 
 Thu, 05 Feb 2026 09:58:02 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43618057f7csm15465594f8f.23.2026.02.05.09.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:58:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v6 3/6] common/cnxk: re-enable vla warnings
Date: Thu,  5 Feb 2026 09:55:55 -0800
Message-ID: <20260205175750.653353-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260205175750.653353-1-stephen@networkplumber.org>
References: <20260120195418.466318-1-stephen@networkplumber.org>
 <20260205175750.653353-1-stephen@networkplumber.org>
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

The code in common/cnxk no longer uses VLAs.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/cnxk/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/common/cnxk/meson.build b/drivers/common/cnxk/meson.build
index 2b33022eb7..9db77a9702 100644
--- a/drivers/common/cnxk/meson.build
+++ b/drivers/common/cnxk/meson.build
@@ -94,7 +94,6 @@ sources += files('cnxk_telemetry_bphy.c',
                  'cnxk_telemetry_sso.c',
 )
 
-cflags += no_wvla_cflag
 cflags += no_shadow_cflag
 
 if meson.is_cross_build()
-- 
2.51.0

