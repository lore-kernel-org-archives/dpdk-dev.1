Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208DBC0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 23:11:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D9DE402CF;
	Sat,  1 Feb 2025 00:11:09 +0100 (CET)
Received: from mail-lj1-f228.google.com (mail-lj1-f228.google.com
 [209.85.208.228])
 by mails.dpdk.org (Postfix) with ESMTP id A5C7A400EF
 for <dev@dpdk.org>; Sat,  1 Feb 2025 00:11:08 +0100 (CET)
Received: by mail-lj1-f228.google.com with SMTP id
 38308e7fff4ca-30616d71bb0so25980401fa.3
 for <dev@dpdk.org>; Fri, 31 Jan 2025 15:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738365068; x=1738969868; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rh0e7iHlEA3bZA09UtFIB4SRtY9iDOY1wZSYQRHBZ6Q=;
 b=PR2AnfyKWGmDZxA3rQ3Cpfg+iItBeRi5CbbnejdOCXidCIdG3K2WJrkZx6yhkZHusw
 uAXl2Tgl0SPEcTV7tMZtgxwzehf/YAM5wjL+vLJSkl5dU3yRy0/HsGmoWz/JDnbEW92y
 gN1iVvhjlFJkr20HdcwmvtTWsIpciprJD1eTrNH9xaDLFh3wuvz6DILp+iIvY+oz9mP7
 MJG0bj9TBp9KAWJEYtf6VZOsnbLpVvOcrNcO0/C5KrWI8F4iYDAwnfcJ7kRYK4zM3sUA
 2CPPoid+P+F+OJRxTLP9jV94eb8reKGW8DXb8wYm/avCosACFF+7k66Ydlg9zLsN5kZo
 pX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738365068; x=1738969868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rh0e7iHlEA3bZA09UtFIB4SRtY9iDOY1wZSYQRHBZ6Q=;
 b=l5rBxNZx9sxxd6Dnvt2VvfaCdqdd0xTSZ9a1ECIVzbaXHeqsE7qy3NzsYdwcGAzQxq
 QDp77taH0nZfkz1sdF6Y50XPVIqdHNvL/DkEV/u9pMH/YtEergzkL4Bfpl4xOR7K9N9V
 kAEpkPNVyLfkmTFlagkEiVySwzKsXbUlSrdL0Yx4oFwbvIfb7x9OH71kbdh4Z14BTt/5
 ajKego+a4Y+m2E14YyF2BDo36ge6TZVC8nmLg4C0ZQ0OWO5IG/1Uu981e6GDFGc4y07Y
 m8fRy9ddvbRw80Ne1gBFXuHt/SVtjmOt+W4TPaZ1VYTXkgxYbghuyza13sW/TH7bXa1E
 znUg==
X-Gm-Message-State: AOJu0YyYmJMtPaDavJX3CpvhF4wP/QzV1/hQTtGPcDeZDBXO14haiI9r
 lNQk6/ocQapR2E0GaHLg6dZPQ72OI+PbAZCTD+sWgH7k7x64YutjMaxBBls7d0/laQyU7d6oDFY
 j6aAxyTqzb4ZqofT+BMumcNSTlLmVHJ0WtD0viDen
X-Gm-Gg: ASbGnctYpvt0ZT5oRcK6lF6goFel4HNlxkbAuqsEaGgsK/l3qaoxFY21HLtkwHdm4Z1
 n/79eOMCbKSZVzaxsKO1ggJku0qx1zQMcN7FH5fHFOJFdGsU+whUl/yaOozw2dmj5BsFOHVmg5H
 3kLWvFyWFnEN7v5JoPdG3ErwSamY3j3xkclECArkzHzHBCmrno2q21K/8f6/MGVrUjVw7bX4qVd
 9DVZVIqD7uIEUZ95V+ORQXZ5SulOLLbuRTX0VbfxMbDs+QcxL6UFdHc8GEKkeR74eagZ3SRWxFM
 hNobM2q42LrHfOguoJHrx2IZoZ4eHb2/NmP2TVFMYlWh0gFBXA==
X-Google-Smtp-Source: AGHT+IG43R7uQpYJse3ccQANLyMmKEYr5bFv359tk1Z/JDjovcQDls19yNIPMgQLxwEDwJPGy0fn9DSk0msL
X-Received: by 2002:a05:6512:e85:b0:540:2a92:7dac with SMTP id
 2adb3069b0e04-543e4beab07mr4244865e87.17.1738365067969; 
 Fri, 31 Jan 2025 15:11:07 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 2adb3069b0e04-543ebeaffa7sm160290e87.84.2025.01.31.15.11.07; 
 Fri, 31 Jan 2025 15:11:07 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 931AA19E11;
 Sat,  1 Feb 2025 00:11:07 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Maryam Tahhan <mtahhan@redhat.com>, Ciara Loftus <ciara.loftus@intel.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v6 0/2] Fix use after free, and refactor af_xdp_tx_zc
Date: Sat,  1 Feb 2025 00:10:17 +0100
Message-Id: <20250131231018.2163893-1-ariel.otilibili@6wind.com>
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
v6
* added missing credits to Maryam Tahhan in v5 

v5 (https://inbox.dpdk.org/dev/20250131183439.909831-1-ariel.otilibili@6wind.com/)
* fix style issues in the signature of reserve_and_fill() (Stephen Hemminger)

v4 (https://inbox.dpdk.org/dev/20250130221853.789366-1-ariel.otilibili@6wind.com/)
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

