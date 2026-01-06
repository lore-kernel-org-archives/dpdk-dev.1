Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5357CEFCE6
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 18:33:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4F7240DD5;
	Tue,  6 Jan 2026 19:33:17 +0100 (CET)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53]) by mails.dpdk.org (Postfix) with ESMTP id 0E7DB400D7
 for <dev@dpdk.org>; Tue,  6 Jan 2026 19:33:15 +0100 (CET)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-64b7a38f07eso1922651a12.0
 for <dev@dpdk.org>; Tue, 06 Jan 2026 10:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767724395;
 x=1768329195; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iMJZxw+AZnCYC2zErpJlsIUrD//pfZBTGe5z57uIVUM=;
 b=W5MZnE+Q+bGiJvDbTfmfK0U8OOpkabPc6bjFHxIVva86LxO8p3/mVGtQa5w45i/gnI
 VnPByXkbn33xPBxz0FRPec8ujJcJO17Mq85subArJqLgglwg26W16m5ET3OYudiGY4pK
 /xRNpQhI3BG1J4Wfah30489P8dj8hLiPMOID/CtvZW6F6mgQZaibc71Sv7S5To37sGJW
 1hWposBDWsQzXt/3KvNKY3Yu2wcEQ0xKNwn1baareevyywGwichLyGCjriFsddKg9ZOM
 P3IXGQ5jKh1VSYWCYirK7x/uuTyv8cpKKaYMtTFQ6EaJckew4oru/MdJjRuLCidSv/pS
 KtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767724395; x=1768329195;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iMJZxw+AZnCYC2zErpJlsIUrD//pfZBTGe5z57uIVUM=;
 b=P8VoofiXrBzhGJKPVVwHYCdrq62TyxTMX1Mn1IreuQQGzVJIIdC0vZxXiYtXdbRHYg
 oaS/snZzXWhXmkrSlPDMVgTwQlsLCPfNesIpREV7VOD15HPHSzwAakhIrjwFI3NQlaH7
 bX5vP3xUYkj47p5f+XIws3Mtjl64r0Njf9vXfYjVDbSGPEmq7G3/R7g/A+W44fHFGnSf
 VtdVaLknPJ7lUmHLJ6OWMd79RonKKuqkfkpoXqoSqsI4ZwQHynjrm3lDCU7AYzcbeD04
 CwfwBGfa8SLK7tGAbQsU/3JK6yFNG0YyL95etmFbixus6pHnHoFO2QXuTNmGI199i5G+
 /OFw==
X-Gm-Message-State: AOJu0YzAoh7Zo1FWBiVty+COCtoXmMBdhrbQR65mGLluB9GHX1nF5F3k
 GYKGRErEqCXLtuggVtybeetp+LFEPO1DCLHEfhWNBgUr7pTnWHlmsnhHQBw4SLT4/62MTRnfyE+
 eMqWxWCA=
X-Gm-Gg: AY/fxX5S4E3KJGVty/pvyH6Jl7Y2MVmE03hrPEtMRGfgKpfnJnGJx1bUKWt27L4xVdr
 yVIqO+ZxqhpuoqPGPbNZJQjD/kpH4dLnwL/uS1d1qL9NppjdXNvEISyfhyp87zgWxPBNpuh/ZEY
 mtHR8VldmO7B2ziIdMo+v/AAfriFoGeMzkZDGuf0Jtx60PUTH9lOEl24qoOmCpobGgEYqUsqwUF
 PmqHjONK2x5OPxuImgF2OJwaIn5WoLvut2fdZjI+sLF/rKuSgvrWS7Zt4cGQ8y1v8HCB5zSH7Gd
 3TfeTS66OmkgM2flZvpPBxPsStoqncNhQq5Cyi5L/qsgNTsZiNAyFraWcxegV7lNO+L+EKpGfkI
 5FLAZaAW6qD1RnQXvApnNpxwg1no+n2sQUl7Ud92ZyMC9WgJWyZ7wKe2iPphY6wfYXxd++9PNyV
 fZOfV16TqPyEtDF/TWdQVgXEjYlTjTXM1vsXJeVAQ9vw+7f7Whew==
X-Google-Smtp-Source: AGHT+IGh9/e6ayCWR1DdNPTCmo06tA42w02/nu9nnbS/Bj4/p8jU6CwxZAMvextfS8YvyH4So64Glw==
X-Received: by 2002:a05:6402:3548:b0:64b:5f4e:9e6d with SMTP id
 4fb4d7f45d1cf-6507956190amr3560530a12.18.1767724395402; 
 Tue, 06 Jan 2026 10:33:15 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d4acsm2728525a12.30.2026.01.06.10.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 10:33:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 00/12] net/pcap: cleanups and test
Date: Tue,  6 Jan 2026 10:26:39 -0800
Message-ID: <20260106182823.192350-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

This is a set of enhancements and tests to the PCAP PMD.
It started out when looking at the handling of timestamps
then realized lots of other cleanups were needed here.

Stephen Hemminger (12):
  net/pcap: avoid using rte_malloc and rte_memcpy
  net/pcap: support MTU set
  net/pcap: use bool for flags
  net/pcap: support Tx offloads
  net/pcap: support nanosecond timestamp precision
  net/pcap: remove global variables
  net/pcap: avoid use of volatile
  net/pcap: optimize calculation of receive timestamp
  net/pcap: report receive clock
  net/pcap: cleanup MAC address handling
  net/pcap: support MAC address set
  test: add test for pcap PMD

 app/test/meson.build                  |    2 +
 app/test/test_pmd_pcap.c              | 1471 +++++++++++++++++++++++++
 drivers/net/pcap/pcap_ethdev.c        |  373 ++++---
 drivers/net/pcap/pcap_osdep.h         |    2 +
 drivers/net/pcap/pcap_osdep_freebsd.c |   60 +-
 drivers/net/pcap/pcap_osdep_linux.c   |   51 +-
 drivers/net/pcap/pcap_osdep_windows.c |    5 +
 7 files changed, 1830 insertions(+), 134 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.51.0

