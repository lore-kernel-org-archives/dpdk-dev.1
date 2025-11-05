Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69298CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 21:07:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 576B44065A;
	Wed,  5 Nov 2025 22:07:03 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id B2F92402E6
 for <dev@dpdk.org>; Wed,  5 Nov 2025 22:07:01 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2957850c63bso3452575ad.0
 for <dev@dpdk.org>; Wed, 05 Nov 2025 13:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762376821;
 x=1762981621; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JlzmuemRcpeKGS0fySGzIN00ARxWLCWXES4J7SQZTaE=;
 b=QOECF9rZauytDuHh8/oinVEJ/XmHLGasgKpmoRtdmCb84p/SFh97FPgvdfnOAhSlqW
 Nh9B5k9w0HaOssj5X8vCtvYQe0HzmGwkEJjI+ox73mzKklWgutpbnSFDIEClQmMYhPaU
 ZeGNwqzc8SSca31gJf973Z/1EDM6QCl2/J4AhGzpvs8nfLQKDM5BF87xDOs7ShY6YYUm
 hZTbO7LpeIT4gAT+K0YklOWLfbEfaaLRTqBvTZkhubNZL3hjkuq6K2Ub6cjKr5j5HvG4
 I7ujuohJuG+3p6B4TWeQDu1SFuoEJYxh50t0CmG8uSBJlWEV4/68KpT1ZzQqnOagSp6W
 WI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762376821; x=1762981621;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JlzmuemRcpeKGS0fySGzIN00ARxWLCWXES4J7SQZTaE=;
 b=TMJ8U0fBGKsbQaB3WwzxhsSlJ5KFQXMxpHpHRMpLFVOuu2zNd0syCtUDH3YHnWjx5D
 y49SCJ8culDkK1ux60IoLMbHm6H5w5Bj9p9rckMOiLdARq3KKb9Vgr5XjB65SxHYCE4h
 sZ/FRKjTsnwXdfJCeoR9qxWf5Y0afKGPtSrHDqzgAPAvt2ai7xAeuowab+qKk8dky8et
 81YrMv4OIjJOmzCpTaBU1Xr7cRYrFrLScKu6FHyXlMPDjdQzO6Tbhz2oudgNkYQJRRD6
 xFcPj7hgf7EOFp7pwc4woilaGBuxyXSwHG1syKvbiQ6p4BaGme2CwWLdbpJp51ZVt5e4
 570w==
X-Gm-Message-State: AOJu0Yy6hfWfxHiarBVbBX6RhkEgaCnJxKATV8dpyDTXoxQlshn6MmJX
 KDvP/nTkSwkJvJMPn6Zl7Ky4NVGa/okn+pe6DXt3+Rent4LZdcoZj8gR1o3yUP/9EvicqF7nfgV
 3J7aq
X-Gm-Gg: ASbGnct3mYyZawJP8CMpVWNzsIQQR+iCLLroVG9CynHWOhqJiDbn1A2LDAi4GjrFDkD
 LMpnC2/AmTmGhFsOy0GlDRo3JheC9tK6KQu1xyHRMCmK7Ld1aId9rKNgj0kOxvUYlh37sNEZu2b
 XdsL9dsTMDNHklEivQgplT4lqSNS3q3h+DQepru5rThaOvD9OP7vRIWWAVQTJvXrnydSiSvfa8a
 YF1+/6QCzI76jM7hxwC86UEyfu1IVtz3BD+06qWLNDQNW4WiENlqwr0OediZUhnuq5iBIkK7rh7
 VKoZ/7Qh7PsjTh1ux40TYqErTvdHWKcBLnLf5ZVMKwU9KbBAiCDgWMx2xOG5Z+Sv7nBnRIKENPa
 +KQpSEjIJPU5+e9ryKGXVd6V7ch/w4YiWfjhpjqYBAmV2/B9SNuKQJ9n+GtQwV/n9uYY2HwB4Cw
 7MWxG6qu2MDlzaf9LnQ7j3utT9T2sD05R6g6ifD1w=
X-Google-Smtp-Source: AGHT+IEjvumXP0N7GXTcb3i4iUOWxA+VRidMVOncpgNTZ3Sf5dazsad4FQjoXv8vpqwW/bBiqCd1Tw==
X-Received: by 2002:a17:902:cf0e:b0:295:3141:4d54 with SMTP id
 d9443c01a7336-29651634db9mr8849965ad.18.1762376820604; 
 Wed, 05 Nov 2025 13:07:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29650c5ee4dsm4725895ad.45.2025.11.05.13.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 13:07:00 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/2] pcpang changes
Date: Wed,  5 Nov 2025 13:03:57 -0800
Message-ID: <20251105210657.871310-1-stephen@networkplumber.org>
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

Fix compilation with Gcc 16 by using alloca, and add additional tests

Stephen Hemminger (2):
  pcapng: use alloca instead of fixed buffer
  test: add more tests for comments

 app/test/test_pcapng.c  | 18 ++++++++++++++++--
 lib/pcapng/rte_pcapng.c | 19 ++++++++++---------
 2 files changed, 26 insertions(+), 11 deletions(-)

-- 
2.51.0

