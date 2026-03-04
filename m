Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CB0EF8FF4
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 15:16:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BABE84027F;
	Wed,  4 Mar 2026 16:16:29 +0100 (CET)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com
 [209.85.208.172])
 by mails.dpdk.org (Postfix) with ESMTP id B813D40041
 for <dev@dpdk.org>; Wed,  4 Mar 2026 01:34:13 +0100 (CET)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-389f9895c81so45507491fa.2
 for <dev@dpdk.org>; Tue, 03 Mar 2026 16:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772584453; x=1773189253; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cAvGg4mAj2oQPy0OWde7SyfnkEOr5f12PPvMIXHVySQ=;
 b=ScEoZVAA26oAK3yfiPTH+x4y24/vwcpqyG6Iymw4qWdfqxWg/OupTs7Yzy1wEMvZMH
 Uf7kc/eBaZziSube7I9Bh2SyC670/cdzOUi5dquu3pLOSuEMNFw8z6+IiGpIoSte/Ctx
 H/4qGsIpPmckgTOvGVmsNQg6GwDLKtE5PdOBGwRWpo6Nz9y2hII9bAr4ZyOLnrtz1mrt
 U55SxEyn7E64kwpPjl5qpUcVhBoa6S0X1iVuCfXRTWu2jxB4GXAPm1uS+rOBtGnumJvv
 tpZW/tL+Kdd6Hx4/YC3Tkte/e2/tUOQdKyiGgYCkAXtdfl3S/Y/2fdSEV9paOodZtKqT
 BtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772584453; x=1773189253;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cAvGg4mAj2oQPy0OWde7SyfnkEOr5f12PPvMIXHVySQ=;
 b=DpVzPrDee/hSNSPq0DEM0Eigamvi8Ij/wS8eo0yNSXA/84LxW1cg2Ns8heNVdPDM0Z
 1cmG4e1p1ckHsHq+AnM/y7NSY2jwYzTEqhss2BgKYoW7TzYVqgV7Un84EPCf9Dj/oXs9
 1ZQ9osNX3sQfHKr5JD9ZzV048ynWMjBlooYn9JPbVinBkkEJ0qNaBK3b/lDzicp5uld9
 VWMPzLV3Lk2TPL0ojlorGS1Fhw/RQIfXQ2Q3Yl+uHbEvAloDXghGc1PbZqATX82PlLIX
 B4fs1+j4l2MWzlFb2rkLMyiSJ71qxq6k4Rour/7eJJyRqHGx1BteYq/CwLCl/grJzwUo
 eWEA==
X-Gm-Message-State: AOJu0YwSG3i2GWFD1rNa032T4XIdzZN1nXGp8QfuFAaM/Yv3nY/1vscZ
 NCgnf3V/w6VNdWGgB+KUwMByMcvx2dVoyQmm+JhvY7wwfW1/hxj7PNOSM3+cleQ=
X-Gm-Gg: ATEYQzxG70JtkYRqkLDjix+w+SnXjv49wYJvuxtmPpQuMU3XIRChQ5VDhGnE5AzOPJV
 rXEr4+C7m/ZKyMIJIHjbgqtdd6PMBT1QK1OyCqvel9VT8HxaUsE+5Gw4dUrSiVWnj4dPtpaPDsE
 dpSYIwhmGzBny8CvRhagSN0s4pwyZ0SUBozQANaDEksBN/6tg17b5vUtU99t47ViDXuhljifx0M
 9/teBfONfO1S5Akd3B2pkZuVnA9G6ixcd82qh5E7XTGgm9u3QfuPn9U4hM1aIrBOJr4+j9Lk+MD
 ud3g8AsEnrt6zUQjDjPcZ+WgdPpaPSsFdui0cLFzN68xorY5DnnxOlrilH1j0FgJzYHObLHlDLb
 CzpTa7Yi349NHWKONbpYdgYq/iAINEd3qBvzgVbAWgu3vHih8cY5PSJPFepcnDG20H5i2DalaY1
 Er0+rXtxb/kauCWTTKVfrRtauAhqJ5
X-Received: by 2002:a2e:ae1a:0:b0:37a:2d23:9e78 with SMTP id
 38308e7fff4ca-38a2c597ca0mr2041251fa.11.1772584452462; 
 Tue, 03 Mar 2026 16:34:12 -0800 (PST)
Received: from dev-debian-1.home ([95.165.2.1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a123581424sm898843e87.26.2026.03.03.16.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 16:34:12 -0800 (PST)
From: Sergei Iashin <yashin.sergey@gmail.com>
To: 
Cc: dev@dpdk.org,
	Sergei Iashin <yashin.sergey@gmail.com>
Subject: [PATCH 0/2] eventdev: fix eth dev ID truncation in telemetry
Date: Wed,  4 Mar 2026 03:34:04 +0300
Message-Id: <20260304003406.252929-1-yashin.sergey@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Mar 2026 16:16:28 +0100
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

This series fixes an out-of-bounds access in eventdev rx adapter telemetry
handlers caused by eth dev ID truncation.

Patches:
- eventdev: fix eth dev ID truncation in telemetry
- mailmap: add Sergei Iashin

Sergei Iashin (2):
  eventdev: fix eth dev ID truncation in telemetry
  mailmap: add Sergei Iashin

 .mailmap                                |  1 +
 lib/eventdev/rte_event_eth_rx_adapter.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.39.5

