Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C6BC88E75
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 16:02:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 513D340E21;
	Mon, 14 Sep 2026 18:02:32 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 78D3F40A75
 for <dev@dpdk.org>; Mon, 14 Sep 2026 18:02:29 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so3434281a91.2
 for <dev@dpdk.org>; Mon, 14 Sep 2026 09:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789401748;
 x=1790006548; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lYHe66DifJO1QfEATbqNEkmjsDihRgyD+SW7PRDNVTg=;
 b=jRohvqwBSyw1i3obzjSUZfYLaNVuleF1D0n35e8F/o0WGn2LWXV38uiYGNc08d4b6r
 febu3qxCOusAuAmB9jcDrEIledAS3Coltw+eJaAVDNS+8iF8vz3RhO6QHpxXuO4Z4Epv
 jrDP97VCPVJ2bj+dqmP4q01FsLsXotxO+ePu4O6X8XoXK9MZVzoBHcRJuQRQoP93kEPF
 Oiez3XDULJh1F3TUrVvFXBqt9XkrM3K4dA4nJ68Vjs/obqxRbzad58YaA0TfbCqx7HWz
 voW1U/X5ch/rFQsaEnPUVn8WypWNBBs/MWVU5MKBPX+JC/h6+5Gr3Jvnnhx3eMglgCVB
 yiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789401748; x=1790006548;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lYHe66DifJO1QfEATbqNEkmjsDihRgyD+SW7PRDNVTg=;
 b=nJsPPdQpbC8RhbMYPRqXImMcZrTdNQRNElIqP1Laece3buWE0RHCpJMyUa4fZFQ7G9
 isf6TJzwfZwPAhFqtVbNucAu9w8fPqnusEs61y78grCBuOGZpRrIHdgyh+P0I84J+iQb
 NNSfZ7nOyEg3ZlLzRLWRwTvOtxfLdrH5T4bdgDoYk3SeCPc66HzsflNdNn4olezDzgTu
 8B2Dm+tAfMJBFtjpcKtH3va0V0RM0RcNE0VSrE2m/WOz46o0mSdFRGnKaQ42R3QDpNUM
 eokIY7BegsaPw80S8M8tQnbkh473f0rCrOupkzfGpJFpLm8fK2ubYy4PXzVOOumwQo0K
 DCRg==
X-Gm-Message-State: AFuF++mFsDAILiGDN7U7DMMfxJn+5PaImZAfA3bMFW2vRfvxlPH+vlaR
 DVPifm7vvvEuMK62FBc4DUYF3bYVAaAtOfcKKkxRaXXcedpm4EhTZmfcxCd+5lRK4/zClgNH6yA
 UVcACtWI=
X-Gm-Gg: AYBFou04mdQJ9t2R5oxn/w5snymqpHg8XR6sAeI7OZDoUKHH7xeUZXYLShX/GExIQOc
 eXVtG48sQLRKgv21fNmeCNWcCIgHhKLjEoayhv7+OyOswnhp3KBV0XxdFQ6raluF389yTHdaudT
 GAQSbUU5chmm8C/w3ajsQ3+zV1CXTg0DXXJ3+wWDbAh28bCyKdXZHkPNRx74L9bNpvoyDjnJayF
 e9KoU46aJiGdy5Bq46W3K/MIF8+xmVQz3OrlG4A9i+91ZNBJsjgCVSHBAuvEQtep3/A7KLywdaG
 1fwkicC4aQnpapT81cbcgzxjYWPhKUEOzMSZLsVKninu7Gw6Z5wJZ46X2A279HVkpqK7aVkSH2e
 0jdXtmi+IR4dSgc3x1id33dG8qNXptVd+g3OvZ7lxGKJ9peoo0AInzTOqJPka7dJLleGI72W0WN
 LxXLUUlL2QI7Az5aLdrcVEPwXSkQOmrVUo+uWx5Abu5ag6ai2neDmkPiUSKgGpog5kWUQ+AhVsp
 PowLklsr1D6O/NkGVGtdRr0RqjFF7PC2sAibw==
X-Received: by 2002:a17:90b:3850:b0:39d:fcee:8d10 with SMTP id
 98e67ed59e1d1-39dfcee8d72mr471419a91.16.1789401748292; 
 Mon, 14 Sep 2026 09:02:28 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdcb4615sm130500a91.4.2026.09.14.09.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 09:02:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH] MAINTAINERS: Remove Long Li
Date: Mon, 14 Sep 2026 09:02:19 -0700
Message-ID: <20260914160220.2283910-1-stephen@networkplumber.org>
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

Mail to Long Li at Microsoft is getting rejected.
Confirmed with Wei that Long has left MS.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e99a65d197..3c6b874ab4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -657,7 +657,6 @@ F: drivers/bus/vdev/
 F: app/test/test_vdev.c
 
 VMBUS bus driver
-M: Long Li <longli@microsoft.com>
 M: Wei Hu <weh@microsoft.com>
 F: drivers/bus/vmbus/
 
@@ -939,7 +938,6 @@ F: doc/guides/nics/mlx5.rst
 F: doc/guides/nics/features/mlx5.ini
 
 Microsoft mana
-M: Long Li <longli@microsoft.com>
 M: Wei Hu <weh@microsoft.com>
 F: drivers/net/mana/
 F: doc/guides/nics/mana.rst
@@ -951,7 +949,6 @@ F: drivers/net/vdev_netvsc/
 F: doc/guides/nics/vdev_netvsc.rst
 
 Microsoft Hyper-V netvsc
-M: Long Li <longli@microsoft.com>
 M: Wei Hu <weh@microsoft.com>
 F: drivers/net/netvsc/
 F: doc/guides/nics/netvsc.rst
-- 
2.53.0

