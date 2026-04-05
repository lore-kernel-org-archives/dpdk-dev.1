Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C10E9D826
	for <dpdk-dev@archiver.kernel.org>; Sun,  5 Apr 2026 23:03:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5186E4026D;
	Mon,  6 Apr 2026 01:03:33 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 062DD40265
 for <dev@dpdk.org>; Mon,  6 Apr 2026 01:03:31 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-354bc7c2c46so1915726a91.0
 for <dev@dpdk.org>; Sun, 05 Apr 2026 16:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775430211;
 x=1776035011; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZOlECqzznQr9aXPLQmLxn/FtzW8un5nL/wpxI3ylj40=;
 b=TxD9GeK8Z0VqDZCLO7rj7QYBQWykyUDA15IFG4luab1gMfm6S2NBbPM1RWI7KohpM9
 /Ip4DNMgP25ut5Xj7ZZQhusrF0Flimb1P97t6X7O3Duhs+9X3D5bdgz8xv0hL5C2xc/E
 dSrSVCdiZRO9boKBHanV3Wbky4J/CqLO2bKB+MiNpaQ8LBQjcaHWdmkZmj1lfrmT5DAE
 E+Irf+ZMzy7U8g+Kx7MWcL5F+2czKsy16YMhLD9y0j1X9lRApofwCk37RhSanBwktGOf
 x2c0+cO3NbQohY58uXA8MyZePlIEAoMooxj1+nbMgTVbfcSEAczaZQRtbfevFs6fZhvq
 25kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775430211; x=1776035011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZOlECqzznQr9aXPLQmLxn/FtzW8un5nL/wpxI3ylj40=;
 b=f7Q8YVFAm0aOMV9TzC+x3KM0Hkr43Rr7WLAAK/9pNLnKnMKpqDf9t7n/anTe+u2B0b
 pVOEPN0qZerQKypJ6MnYn013ouWs2qMDGm6+tV4p9bMYEDeA4VWGPxo/m2t/YpW3WqD9
 H+4OUdsfjY6FlddwAT0Jip83oiMJhg31UcD8L2kEU+gkdoZCFuyAarbz4ofjUbYx0+Yn
 GW2ZqaPDjdpbX7Q3uXZ6EmWiW0Ec+mfL9e7UU1mLeyiCh42PJgt2EH+dXFJzjZlehRm1
 IeZYC8o3WGEIMU8ro3bciw/0vrhKp4Q4HqpNXcBGqJ4YgIcmSLPBsqna6wD8DFNKMs30
 0NsA==
X-Gm-Message-State: AOJu0YxKjeYwQGEbVdWrNtuoMekz2F15MncO1lcXZPwLzbw/EFhBZnCb
 Nshce+FDa1ZVrGpd7TR0i9XVfh9D5R+O5TXB1OJudA4w9jpdghN/Mz3NhLp1l6GGusw=
X-Gm-Gg: AeBDiesuOmDWXgIGxGie5JOW6QFQuWRs1nWpWS5HTlVloG2ICR9i6QRRH1V9WoLFspO
 a2pCZbEN4LCeltB5hWoMNgEWnx5aPMUF9cxvBOBqAxApuv7hbjZF0U51hsvS5cG3dZ5lLqH7snL
 58M7WbAnqnHDFe4Z2a5RKQ2UqJKaKO/biRgUQ+sr2IoLYPIgH42ulPI2p07lRbGJ+fYi1l7gVce
 FPQ1J/vY+DfwDylKCB2fgpCnAc4ASYtxcIn/YEZGHephqRB3PsVV7RTooGxCET3JVBdyZYXuKAE
 2Gcpim8XIOT5mTvodmgPOHlsF+DRsfcWG4mGaGTl0JVwcJy3eE60CIEkcRYLCVWEezrW6nNyHje
 lXhezHwOCm1j/rLw/EOkgdMMq0rIHy3+qjZR+SXyE4UZC+SOq5SBxJw46tzpSa1Miezx/l8Vv/w
 VNB0Jzq72XQMs99+Aub3NujhhYGoncnQFJn6o=
X-Received: by 2002:a17:902:e748:b0:2b0:571f:6f09 with SMTP id
 d9443c01a7336-2b2818934camr113069355ad.44.1775430210862; 
 Sun, 05 Apr 2026 16:03:30 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749cdc61sm119664035ad.80.2026.04.05.16.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 16:03:30 -0700 (PDT)
Date: Sun, 5 Apr 2026 16:03:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Jasper Tran O'Leary" <jtranoleary@google.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Subject: Re: [PATCH] net/gve: add passive device-requested reset
Message-ID: <20260405160318.6d23ddd9@phoenix.local>
In-Reply-To: <20260327002038.3386577-1-jtranoleary@google.com>
References: <20260327002038.3386577-1-jtranoleary@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, 27 Mar 2026 00:20:38 +0000
"Jasper Tran O'Leary" <jtranoleary@google.com> wrote:

> In addition to application-initiated resets, during normal operation,
> the device can indicate the need to reset by writing a value to a device
> status register. This patch introduces an alarm that polls the
> status of that register and informs the application of the need to
> reset. The application is responsible for registering a callback that
> will execute in the event that the alarm discovers that the device
> requests a reset.
>=20
> Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
> Reviewed-by: Joshua Washington <joshwash@google.com>

Makes sense, AI analysis had one item worth noting.
Not sure where documentation related (if any) should go.

The alarm callback calls rte_eth_dev_callback_process() synchronously,
which means the application's reset handler runs in the alarm thread
context. The documentation example shows calling rte_eth_dev_reset()
directly in the callback =E2=80=94 this works (rte_eal_alarm_cancel from wi=
thin
a callback is allowed), but a production application would likely want
to set a flag and handle the reset from the main thread. Worth a note
in the doc example.
The polling interval is 1 second vs 20 seconds in the kernel gve driver.
Not wrong, but more aggressive =E2=80=94 is there a reason for the shorter =
interval?
Otherwise looks good.

Applied to next-net
