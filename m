Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F1FC5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 16:42:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E253240E34;
	Mon,  9 Jun 2025 18:42:17 +0200 (CEST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id 312FA4064F
 for <dev@dpdk.org>; Mon,  9 Jun 2025 18:42:17 +0200 (CEST)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-7d098f7bd77so517241785a.0
 for <dev@dpdk.org>; Mon, 09 Jun 2025 09:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749487336;
 x=1750092136; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hvBJoudKI4BMdomM90sMhk3X9U43hd+4156aLxqwIa0=;
 b=BsrLMqykZrM+ICjQSqJLBAZ41mjgYydG/ot6RskDaYFcZnUOceJrw9YhKiKvJfJhYs
 a5Pdy28Dp1SmRi4oJcBftm6B5wv32OQQ7yn2U9QGeY4HyavaKsYo4DMkkhb5WTIjI6C1
 G4duFJ7TiBBEEtPM3KLpWn+Tozn7aQpwieoBvKpQX/L4fu/8/qjun2aFtP/rl4XM3yFj
 OEKe7jx3iEFZlHTj+9aJXY+bpHZuxQ0qJFMf/l+CPjt4Dye6FLi8d2eElONz3OiYK85I
 SK9XOlqnItBUvEhDP267d+n4j5b3sDjNZVcETTWx2VYMRyR99jHzq4hgdwdwU4edpsaO
 2NZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749487336; x=1750092136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hvBJoudKI4BMdomM90sMhk3X9U43hd+4156aLxqwIa0=;
 b=J6ZnG/86Di93vL0QxxbH6dMTSmMZVSIDu8J5pm4EtQAmRbm1xaZNc0TCr8lRWRmhd5
 ySPbX7RU0vPzQKrPpLDG85wGM9Lj2MQ0dj3uFz9R3VaVzhEudwr6KR/Rjs85/mBcSKMz
 emzw67SVgxHO1hVo+fmBbrjkXthbEhGjZmC7FZ34vdeo/ic/XWcf4jvQoEG0hl24MDpP
 UHHAXxsswbDRoIfULjD+06yRCIKV0h4a2ibFBJgWbIAB37oPNOipbsNgY6CQJWlCLgjg
 OUK3HXU+U3N5WUCHV1lbE9/SXkyq/rPB/+c8k37fi8ja85j6Vo0A/ouS3CmLQQwBLUoI
 w+vw==
X-Gm-Message-State: AOJu0YzW4JkiO+TuiEqVLgGZXV90dkqUhmHMRT2uDn52l+gH2CYGpHa2
 Vjoe+ueAC+8lW/PJ7q1ZeHnn60ccEF7oneSOD1Fg5tiExWXGat2rhZ/noQLjdQCmbMs=
X-Gm-Gg: ASbGncsWwUwbS2bJ5b2nX89mWQbELyyOnffmFlrwEj6Fm6xe3tF6DfMqtOnvDLJ9kBX
 7Epiyjp1kZcnBA+0Eg5WDHvUSu3VOq+NDD3rBr12eOXGetYKJTJq2zl7IWKsa/7lRZNNyHIQE/y
 qfVTPi4JTEahOZqEk9FtPsRZt1mX3Xk2KcMrEH2NvnMsmbXmx7LyjdHcjZ9zYsGSmRXHiG5oIs6
 btCWwousqqJTerwA6j7V8DKxxPNeGBIF7WdaO/hl1USUFWdxFaqHWVTwTKG/4ndIzwKvsv4qvCg
 ggTBqlz0Q+C8wNMfig2h8Tg8h/l7wp2MC3k9HIxhAzU/8BmLto7qVkjkjTVwEvPqrzPRFuAvnCb
 JJS3Vv7vZh4pBLDqwmJwcRT0jZUBv5mSgEO1GG1A=
X-Google-Smtp-Source: AGHT+IHIsj9jMRJ0f62KrwjJTupOhcHghreRGIOz7dPgdSiocA1kuaTb//iDklcxOTEI3L1gIsayTg==
X-Received: by 2002:a05:620a:29cb:b0:7cb:de0d:ba59 with SMTP id
 af79cd13be357-7d39d91528dmr32911685a.17.1749487336490; 
 Mon, 09 Jun 2025 09:42:16 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d25a61a8f6sm565019485a.90.2025.06.09.09.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 09:42:15 -0700 (PDT)
Date: Mon, 9 Jun 2025 09:42:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH 00/11] NXP DPAA2 driver enhancements and fixes
Message-ID: <20250609094212.21550a87@hermes.local>
In-Reply-To: <20250530071344.2939434-1-g.singh@nxp.com>
References: <20250530071344.2939434-1-g.singh@nxp.com>
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

On Fri, 30 May 2025 12:43:33 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> This patch series introduces enhancements and fixes to the
> NXP DPAA2 Ethernet driver. 
> It includes support for
>  - software taildrop on ordered queues.
>  - setup speed capabilities.
>  - DPAA2 resource version.
>  - MAC level statistics.
>  - improve PA-VA conversion.
>  - add buffer pool depletion state configuration.
>  - fixes for shaper rate and buffer prepration.
> 
> 
> Apeksha Gupta (4):
>   net/dpaa2: add dpmac MC header file
>   net/dpaa2: support dpmac counters in stats
>   net/dpaa2: support dpmac Tx stats
>   net/dpaa2: support dpmac Tx stats in xstats
> 
> Gagandeep Singh (2):
>   net/dpaa2: fix shaper rate
>   net/dpaa2: enable software taildrop for ordered queues
> 
> Ioana Ciornei (2):
>   net/dpaa2: retrieve DPNI API version at init time
>   net/dpaa2: setup the speed cap based on the actual MAC
> 
> Jun Yang (2):
>   net/dpaa2: fix issue of extract buffer preparation
>   mempool/dpaa2: use unified VA to IOVA conversion
> 
> Vanshika Shukla (1):
>   bus/fslmc: add DPBP APIs for setting depletion thresholds
> 
>  .mailmap                                  |   1 +
>  doc/guides/platform/dpaa2.rst             |   2 +-
>  drivers/bus/fslmc/mc/dpbp.c               |  78 ++-
>  drivers/bus/fslmc/mc/fsl_dpbp.h           |  41 +-
>  drivers/mempool/dpaa2/dpaa2_hw_mempool.c  | 246 ++++++----
>  drivers/mempool/dpaa2/dpaa2_hw_mempool.h  |   1 +
>  drivers/mempool/dpaa2/rte_dpaa2_mempool.h |  12 +
>  drivers/net/dpaa2/dpaa2_ethdev.c          | 276 ++++++++++-
>  drivers/net/dpaa2/dpaa2_ethdev.h          |  36 +-
>  drivers/net/dpaa2/dpaa2_rxtx.c            |  24 +-
>  drivers/net/dpaa2/dpaa2_tm.c              |  68 ++-
>  drivers/net/dpaa2/mc/dpni.c               |  50 +-
>  drivers/net/dpaa2/mc/fsl_dpmac.h          | 551 ++++++++++++++++++++++
>  drivers/net/dpaa2/mc/fsl_dpni.h           |   8 +-
>  drivers/net/dpaa2/mc/fsl_dpni_cmd.h       |  15 +-
>  15 files changed, 1262 insertions(+), 147 deletions(-)
>  create mode 100644 drivers/net/dpaa2/mc/fsl_dpmac.h
> 

Series is not applying and building.
Looks like you have to rebase to main.
