Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C1DC02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 20:47:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15239410FB;
	Thu,  6 Feb 2025 21:47:04 +0100 (CET)
Received: from mail-ed1-f97.google.com (mail-ed1-f97.google.com
 [209.85.208.97]) by mails.dpdk.org (Postfix) with ESMTP id 0497C410E4
 for <dev@dpdk.org>; Thu,  6 Feb 2025 21:47:02 +0100 (CET)
Received: by mail-ed1-f97.google.com with SMTP id
 4fb4d7f45d1cf-5dce27a72e8so3148659a12.2
 for <dev@dpdk.org>; Thu, 06 Feb 2025 12:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738874821; x=1739479621; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D5lM02m3tmSG9GEpgzC97MSk/qi58ao08+HXZyO2EG4=;
 b=OqUks6hEiz9ojYKNPSi/uMSrewBOd2vdIAThjH8X/VMqAciQEr3e5zPBltoKXCP6RL
 rSYyHf73016mlw+hX4lagU1mHExm5JUgSeQCCX6nX3SI4jItUXUL60gkU0frZHIPJaw5
 eL387wdv2Hl3w20K3VsIpkrgeGAE8XxmRPNr88uAgHzBPujmniTBBgGZEtIDznXQ5SPN
 WWIqNOPYZZ5/hCMuSwV1RoyEm9ruMkLb/g8EYzDWQhWhJhe16s5/J3OdrifOMRvK9Hnu
 z1CkTmfSK0ghTvmwwR+tkspLUZMn6R5Oh7i5/O1pC9XCVMCG4d2NXJQtGzh+5e1YUJ8u
 jGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738874821; x=1739479621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D5lM02m3tmSG9GEpgzC97MSk/qi58ao08+HXZyO2EG4=;
 b=mDY611IcPaiDhgH2rvuLBleey/L5B8OT+6EwRBf/ldmbX9k93MQe0mmUK2ddp4VFg0
 cB/m2bo3olVz/zSw/JaBFHWamYWFfwn+AkDjrnIDja8wog3in7uBSBgU79MfK2mQnw73
 7JJsFydKe4KXv1eG2cnaZfuRAG2yE2U40yo5d9PiJMdINy0J90og5yjBVjqr8kkMzeDX
 ygS/3WF/kvz9n73cr66VfsBo8PX4EWp1lGC3seQmQpdH+SwCDgi6oFgnYdg3Zbf+QT/b
 DGh14D+zYtKjt//tbWIHYWIomvzKROKl1P+O1gP315M6Cb1X4vGjvYiHLL9Q+AexkcSD
 WlQg==
X-Gm-Message-State: AOJu0Yw9Z6T6C440OTwBvs/aYptrIoSOdM0QxdMQI5an2mOhf6EPCpvb
 NfQO4qTdEs5vWgu+uNLDo23DzxkB7RqQDaR/hZyVhz730RNPUjC6gm0J1u0ZtBZSKHjaBeY4Gs3
 4X7qVkrG80vIdLqJHJm6AObIEiK4YAxnMgZoqgIhD
X-Gm-Gg: ASbGncsXmhV7y6U50O1OaDS/LHJVgPKBG0dECmC5KCTh9bYKg6mkgR6xFebpykdyXLo
 lcccao5GXaDo6YDGLDpku+NZCZ0iO22xpFoFVf2ZBDNxze5cr1sof8uDWqw9xLB7g8bO7H6D8U8
 Ok8AITVtSw3pmsrnb8+sY4BdjmZPPMsz6dQcIvgY7RIju/1Rf3CIKrW/N36k/JHR2MbvKfD0UFD
 kVT7ia1KjbvbTWHQ7AVOx60Z7Nc+vBQUdZtRrsLxrEDYjuoPFR+vUVD2UMR8CI13iVkYZSA0yCj
 wxIUKEJjjj3Mj5VuoJDUxn/mtKwr4EDELA+L0DVsna0LvHUAwA==
X-Google-Smtp-Source: AGHT+IG1JNTKW4PJowa8x6zXwx6p/q7XjQhnkUDJS/CoH6Hp+BmAvgCS/4W/iLHrzu+9KrSizKnUBiNoASsr
X-Received: by 2002:a05:6402:3818:b0:5db:d9ac:b302 with SMTP id
 4fb4d7f45d1cf-5de450b1e67mr856840a12.32.1738874821380; 
 Thu, 06 Feb 2025 12:47:01 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 4fb4d7f45d1cf-5dcf1b81620sm48777a12.20.2025.02.06.12.47.01; 
 Thu, 06 Feb 2025 12:47:01 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 255531CE61;
 Thu,  6 Feb 2025 21:47:01 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Maryam Tahhan <mtahhan@redhat.com>, Ciara Loftus <ciara.loftus@intel.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v8 0/2] Fix use after free, and refactor af_xdp_tx_zc
Date: Thu,  6 Feb 2025 21:46:43 +0100
Message-Id: <20250206204645.1564535-1-ariel.otilibili@6wind.com>
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
v8
* fixed seg fault (https://inbox.dpdk.org/dev/CAFdtZitaNGhC5Q10ATNa7xXX1JbuWob=YzrcWmq8LTz+qjiu4A@mail.gmail.com/)
* addressed feedback from Maryam Tahhan

v7 (https://inbox.dpdk.org/dev/20250201100300.2194018-1-ariel.otilibili@6wind.com/)
* no change
* resent because CI didn't take patch-2 into the series

v6 (https://inbox.dpdk.org/dev/20250131231018.2163893-1-ariel.otilibili@6wind.com/)
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
 drivers/net/af_xdp/rte_eth_af_xdp.c | 77 ++++++++++++++++-------------
 2 files changed, 43 insertions(+), 36 deletions(-)

-- 
2.30.2

