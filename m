Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6A2C0218A
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jan 2025 22:19:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7587A40DCE;
	Thu, 30 Jan 2025 23:19:10 +0100 (CET)
Received: from mail-lf1-f99.google.com (mail-lf1-f99.google.com
 [209.85.167.99]) by mails.dpdk.org (Postfix) with ESMTP id 6D1BC40275
 for <dev@dpdk.org>; Thu, 30 Jan 2025 23:19:08 +0100 (CET)
Received: by mail-lf1-f99.google.com with SMTP id
 2adb3069b0e04-54025432becso1451345e87.1
 for <dev@dpdk.org>; Thu, 30 Jan 2025 14:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738275548; x=1738880348; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NhorAvam/boCtfUQ64EFlkxq2P8yeQUNXouTbrDrpAA=;
 b=FYdqVj6xa929k4bWsrSQLPP64woTSnNLLT/KRCk9QY7+anmvUIv4nYbsE58v6ZRWBo
 FD+j+u+rvmOVu1SEpD85FgxB1KKO+NEsoUXJKWaj5isE0RP21q/MKJLx0YbVM+i6rw9S
 S0RN12BiJc8pY+Skt+lDDvEpZ0PwCev3d62rd4Vw5ZTIk+lypTmzg5RdsHEy+GU7lVP7
 BDuefS8cJjPVhLVCSjH+r5P9+AaKUFrZ1zdFXlxTBvsOsJtXA12kq4GdjhExNW1nid7g
 lWhGNLrQ163RuqSlFdCuxBrN+sDer+2c8JQHuzSVafVUgDTzuj33ryET2LX39FOiEHLg
 aWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738275548; x=1738880348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NhorAvam/boCtfUQ64EFlkxq2P8yeQUNXouTbrDrpAA=;
 b=Bm8aTUDIjCwskG7i8WlBFqYtfIA6U0nGwnIboImijBEw8ODwF7WbKCrgpjLUcm0BwB
 OTvAxDMr9CAcoBblinQ6ZrTNU+qeRG+I/TTUFPjFuDhaaQ1IRiQzaJSdgHTrawzqCd7c
 a2mOEyq5sRdSCS2CWm/9YqNpLHWvC/+NwZ9uvyCMvisIw4xzCEbvLCyMTo3BybnvMATY
 BnSP3zGpyODgzRpSNr5+mDWM3zslwPKDkN5/FUV4P62pIoTyH949Zqt3YLx5EfSRepy3
 CCIX7gDxXnVoGLaSBH9AxerqxlAeaiSnKAB4ojVrvWUrs4lZLj4HOJzd/dNy4pa72UMu
 uTNw==
X-Gm-Message-State: AOJu0YyKbq489B6I5Ky+V/xewCHzMLf7b1CpfvW/hhpzzu4iu7EY1uOa
 GSlfxGmLg0KnyzBifDaoOQ3R4kD2IqVw0sCnu62TljcJMsQYLssn7wxD/vfZ5NNtreIq9JDqcjn
 fR+qNu8ZV+QJIXV+NdrxY4zIQKlBZkBtDKXybPFC2
X-Gm-Gg: ASbGncteTm+x6AKHGvGMtbjYinfaDhlyMXmMpl1SV5MjBT1IMSDGA4pqcwbVI6Obw1d
 E5hpJmJnTqnx00y4uBGXvduyI+829fJ01RPQlocRz6HbjvqbCmSQdsls/zwRRjIEJM7DGVmVDtT
 rFOBJ1LpBxXQR+B367puuqIpisHlP2cVm5goqUJ+l3EqM8g1GPQGibeaWngS7CL4I6YCT5BhBUX
 j4kpUdkUZGH2bR9pwBGQ/alLYOdj1/5I1Je3QW9lIEAzMkFrNx/spBM2ZhviJKRwiDeDjHZF19v
 oy5OJ+Pv38U+1Cy3yRD/gPWrhHdcTyAEhoImMg+78vJYMaR8ww==
X-Google-Smtp-Source: AGHT+IG9dOUd8+78WmolHLZmKhYZ1w6d05E+I9+Za3KbM87UIhIJ9OUHAuVhRHlch3HXxkP5jKLDy/+1M1ZH
X-Received: by 2002:a05:6512:118b:b0:543:bb21:4256 with SMTP id
 2adb3069b0e04-543e4c02dc0mr2299164e87.25.1738275547657; 
 Thu, 30 Jan 2025 14:19:07 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 2adb3069b0e04-543ebeb0459sm79677e87.89.2025.01.30.14.19.07; 
 Thu, 30 Jan 2025 14:19:07 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 45750194F4;
 Thu, 30 Jan 2025 23:19:07 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 0/2] Fix use after free, and refactor af_xdp_tx_zc
Date: Thu, 30 Jan 2025 23:18:51 +0100
Message-Id: <20250130221853.789366-1-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250116195640.68885-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
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

Hello,

The series addresses Bugzilla ID 1440 in two steps;

1. Fix use after free.
2. Refactor af_xdp_tx_zc().

Thank you,
---
v4
* redid the refactor (Maryam Tahhan)
* marked the fix as acked (Stephen Hemminger)
* updated .mailmap, my main e-mail is @6wind.com (https://inbox.dpdk.org/dev/20250115121152.487360-4-otilibil@eurecom.fr/)
v3 (https://inbox.dpdk.org/dev/20250128231152.249497-1-ariel.otilibili@6wind.com/)
* reworded commit message of patch-1
* addressed feedback of Maryam Tahhan
v2 (https://inbox.dpdk.org/dev/20250116225151.188214-1-ariel.otilibili@6wind.com/)
* reworded commit messages
* addressed feedback from Stephen Hemminger
v1 (http://inbox.dpdk.org/dev/20250116195640.68885-1-ariel.otilibili@6wind.com/)

Ariel Otilibili (2):
  net/af_xdp: Fix use after free in af_xdp_tx_zc
  net/af_xdp: Refactor af_xdp_tx_zc

 .mailmap                            |  2 +-
 drivers/net/af_xdp/rte_eth_af_xdp.c | 64 ++++++++++++++++-------------
 2 files changed, 36 insertions(+), 30 deletions(-)

-- 
2.30.2

