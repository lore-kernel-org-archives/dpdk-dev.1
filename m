Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFD210F9304
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 21:30:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDB8540BA0;
	Tue, 31 Mar 2026 23:30:17 +0200 (CEST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 4C5FD40B95
 for <dev@dpdk.org>; Tue, 31 Mar 2026 23:30:16 +0200 (CEST)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso52831535e9.3
 for <dev@dpdk.org>; Tue, 31 Mar 2026 14:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774992616; x=1775597416; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G3rAt2zLloeC4ST/y05GuXLfVY3p2aSt4sQY4a2XmDg=;
 b=gQtYdVEYrjPlFA1Ov+DT7Ku1qNzAx5wRXdE83LQs2agENXiiRpyaMIwYsrM2B2p/lT
 bvCWRLmK6WGxnG3TxyplsjBQew4GvMGjwqV8d1nt+6rcCn/TDbXXo4c3NOizwfzW54/U
 hlJS3enFFhi4JO9uZedSuGNE8bI5brLbzErJ63r2ne674tZzBjfvWETdoTVmnrtrCw0E
 sK86pO2P/QTD27e7fmEqHzL8sf9x6hxwU2Qf3X1urxq5xiZ61xDKs6JdRU08G3875aT4
 r/7BrH0bvU6XJDGrTQJPOj1PCo7VrJWQtgyCsKoekH+VP6n2tT63bAQREfAvId9J1iAP
 r7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774992616; x=1775597416;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G3rAt2zLloeC4ST/y05GuXLfVY3p2aSt4sQY4a2XmDg=;
 b=esvUgeFD1J4wxEJ5Y/HKS17yz3pT2n4lpWMSP0KmYEoq/I39rEn9ln3lquCVPjm6GJ
 gEk17hzWGG42L+iZ0bOntdHLRqjhx3ZPAWQphD7EtWW5RwV4operh2NdiQUB28/LeLA7
 lHm76hdO5je6b0I1NitQZlDDNuLgihaSJ0DKRT1CTUXOFEGVfyTjPUGJWBiaYzzB0UK4
 SFpGxJFVl5DZmEADcOSagaAuOUtuBf+13lpm1Mw/xuBtcEtLbktvsLryEbWKlv7gdEKX
 sQepI4OEsFBLun5Bqtd9CspAeYzND6CmgQU/2oaegs/yaY+HUZxOBqPxFJKxHimXLa8M
 hE1w==
X-Gm-Message-State: AOJu0YznrqmlmPRTIAnhmAkgTlGg6IsdkB0HomJURLUJgMiF1jvnIVp0
 eTmCy2NRhbW9TyVx1cHBYrw0Ku1vKfvMLc+Yl80GFMczBijSLgPFsbNiNRbUdw==
X-Gm-Gg: ATEYQzxzhpQ5PSP2uW6aeoGhl3o7Kq4Xh2XPap8VX8mH0QCHlIrA8WHQ3x8arJHPf9B
 U2mhMGPl0PVTIHvo9Ejk3vgZUbA3c+muVuJ5KbqRtTwkwozfZbAC5KWrB9RQRzea6h14xGjIHCX
 TTrJmFHhf0NTRwdweCpccvE1pdYg7IBD9+bqxO4bRYOSQ9uY34LsEyXMB7SczqsNPwxLvq4V5it
 U2WVfRjXC4TNbfU4m+0Yjgn0ARTGoQQ8toTmc8D7OAXmoRuc4PmAYtx/PKtuLLA4HB4vQnFoO/D
 ULAcCr6jWS16MOP/pXxMieY3F7K4ciNgP2Hj0QqE4h3NAW7aXAdBtEpJXBUliN4aSVNFdU8m/jR
 MK1OR6ixLr+KMAXH0o9Ga4sSUWsV/mm69P4Gg/f9bcVwfX+vgQH8O9++FBkJcHR15PEvaFp3Hm8
 zcNW3nH6nD1mjucQSvOa2AI8d7Od2WZc2leNs+GX8=
X-Received: by 2002:a05:600c:34d5:b0:487:20ee:bef6 with SMTP id
 5b1f17b1804b1-48883566134mr18758085e9.11.1774992615468; 
 Tue, 31 Mar 2026 14:30:15 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:d751:7f28:43f1:6bdc])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4887e9630ddsm59318375e9.13.2026.03.31.14.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 14:30:14 -0700 (PDT)
From: luca.boccassi@gmail.com
To: dev <dev@dpdk.org>
Cc: dpdk stable <stable@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Maxime Leroy <maxime@leroys.fr>, Nipun Gupta <nipun.gupta@amd.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: please help backporting some patches to stable release 24.11.5
Date: Tue, 31 Mar 2026 22:30:06 +0100
Message-ID: <20260331213008.4179620-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
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

Hi commit authors (and maintainers),

Despite being selected by the DPDK maintenance tool ./devtools/git-log-fixes.sh
I didn't apply following commits from DPDK main to 24.11
stable branch, as conflicts or build errors occur.

Can authors check your patches in the following list and either:
    - Backport your patches to the 24.11 branch, or
    - Indicate that the patch should not be backported

Please do either of the above by 2026/04/03.

You can find the a temporary work-in-progress branch of the coming 24.11.5
release at:
    https://github.com/bluca/dpdk-stable
It is recommended to backport on top of that to minimize further conflicts or
misunderstandings.

Some notes on stable backports:

A backport should contain a reference to the DPDK main branch commit
in it's commit message in the following fashion:
    [ upstream commit <commit's dpdk main branch SHA-1 checksum> ]

For example:
    https://git.dpdk.org/dpdk-stable/commit/?h=18.11&id=d90e6ae6f936ecdc2fd3811ff9f26aec7f3c06eb

When sending the backported patch, please indicate the target branch in the
subject line, as we have multiple branches, for example:
    [PATCH 24.11] foo/bar: fix baz

With git format-patch, this can be achieved by appending the parameter:
    --subject-prefix='PATCH 24.11'

Send the backported patch to "stable@dpdk.org" but not "dev@dpdk.org".

FYI, branch 24.11 is located at tree:
   https://git.dpdk.org/dpdk-stable

Thanks.

Luca Boccassi

---
f9b31cf4a6  Maxime Leroy     net/dpaa2: fix Rx error queue memory leaks
