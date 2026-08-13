Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C33AC5CFDB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 22:06:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7538740287;
	Fri, 14 Aug 2026 00:06:43 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 3DB324026E
 for <dev@dpdk.org>; Fri, 14 Aug 2026 00:06:41 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2ce7d2adef4so6895385ad.3
 for <dev@dpdk.org>; Thu, 13 Aug 2026 15:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786658800;
 x=1787263600; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wfiJP//hqPOwsDtE6yuz+48PYB38qCDKUKsbCytR780=;
 b=FdxPn61Ul+GIR99nhvgal1UUKIZCwCXljeF9x2p0Hfnrr//dGifrd3pie9/mXgAAK4
 RAdDVuN6jwmMQro5nyjl0amsGUUhkyJJM1JzdJgRGrzeF9SjJWPMHFuhY84h1Y092rI3
 LR6QHQaRkaM3IA86bj1yed1nvKpvnliRPqm5QM5CER/6eZ9fClZeY3HKNVGQADsS+Dut
 2LzbKtmvc8V/uB4jLbcK6fyPuSd5WLf+fiUS+k6StXZQOcWZZP3TvGAxdcm1VwZ3+88N
 43FGIjHw3VQKCRy8zInGM8Sh0nT8jBC7D+7Lt5n2dF1MMbxW57yIxTcRlUQUenFVLFdF
 e9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786658800; x=1787263600;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wfiJP//hqPOwsDtE6yuz+48PYB38qCDKUKsbCytR780=;
 b=mfADgWe7GzYdMzzMn3AvI26S39wtfljUloAVGpL7yWQkwPRrK/em0PgmTZKg7nvnxn
 QkddMrDTxXit4vdBBns6NlWI3i7jyRTg68LWMyQjtk7zstUjYXRKuZNU4d2JvMa9oMfR
 N77M/YeUgWySZmKlgxqzUDIR+erASJQaykK3/FnbP3/XbEacbGqou3f02v4ETMEX4rie
 6vKpUjcC/KVmf0G2+TsLBPplfv3dssC15C/UJARuUswMVVblAhI7IobFD6dnYsCuEm96
 bsPIkkYvf/RjXDQiR0X5A5Zg09TDkz6Nq3VeyDuncUHSQzrcOZvKl5RFe/qKT38UKjjQ
 /L1g==
X-Gm-Message-State: AOJu0Yxa69OrwSyPRjrql75CWT5IYuoASr8vi5ul+xBht5IG8ePULi8d
 bxEzkUQvALOBeaSLuwP+qyEAYFeK86k/7aGrg46MrfIt2LZjihOUgG9c5+dj+a8h59hqUwjvWQu
 qZ91y
X-Gm-Gg: AR+sD11GN4BA1EEnX3uVGkU2LjKvkejZ/0T/h9Bh6vuM3iQc9UkoHSHQ69R1zUjQftC
 9yRf5s86bpc/SqF91uUN4bQIKPMTEopdSQ3AVuZfMonQLGUwJNuxRovI/r7xXXNpgU9+Uxx1RoV
 9WPgU9e4qbsqBunAT3+/QZ67OizlenQRhAHnC8CO0RWQ8iDoGFU/tQFn3vr/BVzbnY5+bOVqwKE
 QVkAmFnxANmWRx1OVOZ4A7fLZlObZlrlewBb2vI+L6+BnWLkCqW+sajN71saaU/IUUirsLwuNbf
 QgdhuAIv+jhLbW6fWEarROqJ5KKEymGH5HuGTjLqO381m3vmNgJkR6i86bK7g0k7ZFYs2ZqxoOR
 vPkKWp0olofkj0xIrYodtjhj3GJ0pFEXK1rzfHBJKRPqKhQE9SOHeGazpNuzGAf7cpJ6G/5CXto
 vkCMO/q45ux/2x+rDNaqYmaYo5TRl7bTj2cZhJ81ch6l82ReG991lEkj61STm13/+nldlVG5wmC
 E9wetXha+m7LWm6H7RnWalI1xw=
X-Received: by 2002:a05:6a20:d497:b0:3c3:bb13:438 with SMTP id
 adf61e73a8af0-3cc71d4a14cmr1036654637.32.1786658800132; 
 Thu, 13 Aug 2026 15:06:40 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ebf731dbasm13735901eec.17.2026.08.13.15.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 15:06:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH] MAINTAINERS: update for NFP drivers
Date: Thu, 13 Aug 2026 15:06:31 -0700
Message-ID: <20260813220631.41472-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Mail to chaoyong.he@corigine.com now bounces with
"Address not found" error.

No other maintainer listed, so this leaves these drivers as
unmaintained.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e99a65d197..2f7972540c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -964,7 +964,6 @@ F: doc/guides/nics/nfb.rst
 F: doc/guides/nics/features/nfb.ini
 
 Netronome nfp
-M: Chaoyong He <chaoyong.he@corigine.com>
 F: drivers/common/nfp/
 F: drivers/net/nfp/
 F: doc/guides/nics/nfp.rst
@@ -1458,7 +1457,6 @@ T: git://dpdk.org/next/dpdk-next-virtio
 F: drivers/vdpa/meson.build
 
 Corigine nfp vDPA
-M: Chaoyong He <chaoyong.he@corigine.com>
 F: drivers/vdpa/nfp/
 F: doc/guides/vdpadevs/nfp.rst
 F: doc/guides/vdpadevs/features/nfp.ini
-- 
2.53.0

