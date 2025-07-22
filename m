Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4AFC83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 03:52:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2829D402CC;
	Tue, 22 Jul 2025 05:52:06 +0200 (CEST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id CF08E402CA
 for <dev@dpdk.org>; Tue, 22 Jul 2025 05:52:04 +0200 (CEST)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-706f2d1036eso1173566d6.1
 for <dev@dpdk.org>; Mon, 21 Jul 2025 20:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753156324;
 x=1753761124; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XGDUNO6ZnShMH/gkRNKRWkaWEBt0YUSJyBw7BC0gFs4=;
 b=LsYOEz5J+94IymV8eQ4yR4eeIMy6uNEls9QOsYn6EMuxiddy6LVJHPrjzdiNutu8mp
 DNxNZjVkbXlYFuvWvXnd/U+K4AK2ID6Qt98WqA/W6BzWCAmY+jx/f+wV268O6ngGldAu
 vpdhLtiLEgaw34Jrljetv8QyZ/al+dgaH9qmfCbrkWZCpW05JYL0co/lHOU2hSO+e5ae
 9bMoPogXnK1X8QTnJVwmdsvDMp17SO7bX35dXBeJUTT1xkWplYx3dspUzf6viobe6nM4
 4gD7ADpNGDoJq0J9ocSJZC+RifOLaJlV45HD1NF8zOG1HNZbq0YoT3J7DhqI5k94XPJv
 Jnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753156324; x=1753761124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XGDUNO6ZnShMH/gkRNKRWkaWEBt0YUSJyBw7BC0gFs4=;
 b=imn0wc+SeI51RLVTLKGpOOKxUaSTBhiz1gaRKkRuN8U2PWLsq//2EZGKCacB1+gBce
 xRiDfKuN/bw0ra4PAa+54FwJV7twGTOwRSUC1w/iZSwaDzxV37W2iCifXb0TMBXjFRzY
 tq8da2G+TWY8fQLxoIYpAPdRk1WTrGICDQgIz3b3B6jFQ5vHJbvcAQQDlqkf/P5H4tcA
 rHqPWeArKoM5KsR3g8F7aW9N0uJi3eZYa81WGs+fh2SsVqhgbVPCAxPIFHB5j+19skUa
 Zhl1xZkLDfpsfrUrIhiF7hueOekOwzrCuKT6HzvJJuxTCRy+/z+6QL3O9PYngi+owYI/
 5d/A==
X-Gm-Message-State: AOJu0YxlCOY9q25VZavD8aAj+e7u/029K8j4IjBk19hivYimyEkKz947
 y0qSaz6mj11UX5w6koa6TmO0vs22XX+/DteoyTkxtkKZOcald65OyG9azTvuppoJZPd1zDiVqS+
 p/fmZ
X-Gm-Gg: ASbGncv1/FBOelI6qzVC3WDIpPFHIx7l9c6Shx0NGwScQF4CkAYzMLP6Y97XbJDOP8t
 eKQCSN8xAOFeZW3Htt13mPVewY85RPgRAdDoVxhJFGbSosEcg4tUlRdK05ZtX0JJyLiFRDy0bn9
 C5WW5yzzIuTRrWAY+gXl8Hm48UirlDayCQJknId6qR64BtUgNkEyNk+/4iycBmL3t+ld8I2/T1I
 KJmvyaqvxukrUnLEE8Gh5uFedvPiQQ32y8F1ZGrAZgvGamkjtlJ3LWN87jVZrtkQezI72h5l6qA
 TlWaEbhu86ZhrdHgoJbXl51cVys5Q47jxXpJlIh3CJG89OoPxkWGVBjvpTMbDfzJxPs21ECGuqI
 MPGtebhTMWCrvcY/tzN5/BOCUHLY8ON3/0Q7K1ifhLh1aGcU80ZkCZfBzfH+r2kxPOHlXutxnfR
 k=
X-Google-Smtp-Source: AGHT+IHcmKEV710JJoTXf9IIFr00rr2hiZphnuEABJU/lvGbQnh62E6XcGGs/M8dPewhorSZOzmJbQ==
X-Received: by 2002:a05:6214:3c9d:b0:705:b2d:1396 with SMTP id
 6a1803df08f44-7050b2d19edmr285288836d6.32.1753156324087; 
 Mon, 21 Jul 2025 20:52:04 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7051bad4f60sm47441536d6.111.2025.07.21.20.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 20:52:03 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:52:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org
Subject: Re: [v9 0/8] DPAA specific fixes
Message-ID: <20250721205201.450d74a9@hermes.local>
In-Reply-To: <20250717094238.899294-1-vanshika.shukla@nxp.com>
References: <20250703053743.3710482-1-vanshika.shukla@nxp.com>
 <20250717094238.899294-1-vanshika.shukla@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 17 Jul 2025 15:12:30 +0530
vanshika.shukla@nxp.com wrote:

> From: Vanshika Shukla <vanshika.shukla@nxp.com>
> 
> This series includes fixes for NXP DPAA drivers.
> 
> V8:
> This is a resend of the previous patch series with the correct series name.
> No changes to the patches themselves.
> 
> V7:
> Fixed compilation issues on some platforms.
> 
> V6:
> Removed the "add Tx rate limiting DPAA PMD API" patch.
> Handled comments by the reviewer.
> 
> V5:
> Fixed comments by the reviewer.
> 
> V4:
> Fixed compilation errors in the "bus/dpaa: optimize qman enqueue check" patch
> on Ubuntu 22.04.
> - Ensured buffer bounds are respected and added validation for buffer count
> extracted from mcr->verb.
> 
> V3:
> Fixed compilation errors for "bus/dpaa: optimize qman enqueue check" patch.
> 
> V2:
> Handled review comments and checkpatch warnings
> 
> Gagandeep Singh (1):
>   bus/dpaa: improve DPAA cleanup
> 
> Hemant Agrawal (1):
>   bus/dpaa: optimize qman enqueue check
> 
> Jun Yang (5):
>   bus/dpaa: add FMan node
>   bus/dpaa: enhance DPAA SoC version
>   bus/dpaa: optimize bman acquire/release
>   mempool/dpaa: fast acquire and release
>   mempool/dpaa: adjust pool element for LS1043A errata
> 
> Vanshika Shukla (1):
>   net/dpaa: add devargs for enabling err packets on main queue
> 
>  doc/guides/nics/dpaa.rst                  |   4 +
>  drivers/bus/dpaa/base/fman/fman.c         | 279 ++++++++++++---------
>  drivers/bus/dpaa/base/fman/netcfg_layer.c |   8 +-
>  drivers/bus/dpaa/base/qbman/bman.c        | 147 +++++++++--
>  drivers/bus/dpaa/base/qbman/qman.c        |  50 ++--
>  drivers/bus/dpaa/base/qbman/qman_driver.c |   2 -
>  drivers/bus/dpaa/bus_dpaa_driver.h        |   9 +-
>  drivers/bus/dpaa/dpaa_bus.c               | 129 ++++++++--
>  drivers/bus/dpaa/include/fman.h           |  40 +--
>  drivers/bus/dpaa/include/fsl_bman.h       |  20 +-
>  drivers/bus/dpaa/include/fsl_qman.h       |   2 +-
>  drivers/bus/dpaa/include/netcfg.h         |  14 --
>  drivers/mempool/dpaa/dpaa_mempool.c       | 229 +++++++++++++----
>  drivers/mempool/dpaa/dpaa_mempool.h       |  13 +-
>  drivers/net/dpaa/dpaa_ethdev.c            | 291 +++++++++++++++-------
>  drivers/net/dpaa/dpaa_ptp.c               |  12 +-
>  drivers/net/dpaa/dpaa_rxtx.c              |   4 +-
>  17 files changed, 859 insertions(+), 394 deletions(-)
> 

Queued to next-net for 25.11
