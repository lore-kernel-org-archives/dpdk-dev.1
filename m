Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78712C61DB2
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 23:38:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BB1D40144;
	Wed, 11 Jun 2025 01:38:14 +0200 (CEST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id E930E400EF
 for <dev@dpdk.org>; Wed, 11 Jun 2025 01:38:12 +0200 (CEST)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-4a5a196f057so129834721cf.3
 for <dev@dpdk.org>; Tue, 10 Jun 2025 16:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749598692;
 x=1750203492; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zcSrNMzEK3kr3O8lyRxqWvQI4AX80Ak+a18o8T7DZoY=;
 b=HqCXTLuMewtyLA13e1Qc9S+tUj0+lCHwx8ZEiLzKGvmX8WDkEcOeJs03XM3y8YJuOG
 xAHihGaLLQbTSidRbFemf+jOHYtdtgbOvgLs/c4SjnPIerJdyu+vDNmZ6NZaln9/aNpq
 ya5Idnd03pzj+4RuxPE0H+ZkXjF0bkuJb0ev6b9pVBA+OXJL6Lkpqh3gAvU2rYQihzR+
 JcDkG8gftcHkE6Ku0qVDW12sisE5GtRfgq9dERt+pUTQszvpoDYm5DzzEpaP2V5igL55
 mY8O1F9UMNs5jkbxr5Ad6SyeNFzaaq5QVVZ5Acp6muRnVKIteVTfTVhKzh8gk/GdoTT7
 jtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749598692; x=1750203492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zcSrNMzEK3kr3O8lyRxqWvQI4AX80Ak+a18o8T7DZoY=;
 b=h52qV8ADXQ2hTwTqw2neZt8r0NAIIPXLVPDQLwuUZE5UMOZtzK2mDE61H1eLzYL16J
 xwHoa8/pVb7PyaIjNqmNH/9wgW24svpLH/3KAivIiD1G/M3HfDkdVJt9jvYt+AcC5UJk
 ZfaF+V6ce9xrcM+Q+ViBdZAOL08Ui6yZJc2X6ZYKC3428yD0KxagSJ9m2giXf6/zWTsq
 25tTQ35wW3gsFS0U/6pnIefyB4nc+lfq4wzhtphXVJi8qdPMTa/m69aWdEqGMhXvm4oq
 ftcEYfbGrhTQUqXFtcuj5d2Wqh3QQZwrweoV51nHtYEzDGUe7J4XKdRKBqbI8bgfiEK8
 yHNA==
X-Gm-Message-State: AOJu0Ywm/LQep6r7h+KlcDda1Rt5pzg/jFRWdLWsYD389gNYpsRLLKtP
 y+y60Es255Y1qPw/HaBHFQvCOSFjc/cXvs88borQnzAfB4Ofj/UCLzS3ILOQKrsw9Xv69ZMvrBe
 nOCB/
X-Gm-Gg: ASbGncszjs2bFmT0uZaGm0YRHdnsYUG8BLFSLgIfH27yoST7vLrBo2BEFeznxXVkFy2
 Igqp0vUIkQ0Rx3KCVyHm9T6/KWN9KxD2m6dyDD3xUA8DREU/pypWWvjgcCEG/4w585x9AtXtpC+
 cH/tqTKkX1vqMlgLLananGw5xxzmgUAJJIrkuEmuKpFoOntuuPmPg4eMq6VbS/zGI0pHSN407ZN
 OgXpspfamW77Gypz9rVbHkuYtwe+Umvb1haFsyBabzQyTfWV71HMUQCWE4qIUTHrBWcdrihAGAx
 BSk16exWHHKBDwNo6km2KLIX6lacTVdJalrR31wXalVjB2CLa5z6rJnJrxRt1aOWBKozaiguAtX
 JK2v4vq4NwZFyJlHqKOZKva9LyrUY7FH2jmnGe2M=
X-Google-Smtp-Source: AGHT+IEGrjPVVYwrRgQpSIYIZmfROZtOzmorFmP2rinTx1HICQIkz3JHYG9WclJbk8fa65u+8MDF3w==
X-Received: by 2002:a05:622a:40c8:b0:4a1:511a:b99f with SMTP id
 d75a77b69052e-4a714b37ab1mr16332661cf.3.1749598692138; 
 Tue, 10 Jun 2025 16:38:12 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a6f3f76489sm55104281cf.13.2025.06.10.16.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 16:38:11 -0700 (PDT)
Date: Tue, 10 Jun 2025 16:38:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: dev@dpdk.org, zaiyuwang@trustnetic.com
Subject: Re: [PATCH 00/12] Fixes and supports for Wangxun NICs
Message-ID: <20250610163807.129625f7@hermes.local>
In-Reply-To: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
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

On Fri,  6 Jun 2025 16:01:05 +0800
Jiawen Wu <jiawenwu@trustnetic.com> wrote:

> Fix some bugs and improve flow filters.
> 
> Jiawen Wu (12):
>   net/txgbe: support flow filter for VF
>   net/txgbe: refactor FDIR filter to improve functionality
>   net/txgbe: fix reserved extra FDIR headroom
>   net/txgbe: support RSS offload for SCTP port
>   net/ngbe: support RSS offload for SCTP port
>   net/txgbe: fix MAC control frame forwarding
>   net/ngbe: fix MAC control frame forwarding
>   net/txgbe: fix incorrect device statistics
>   net/ngbe: fix incorrect device statistics
>   net/txgbe: restrict VLAN strip configuration on VF
>   net/ngbe: restrict VLAN strip configuration on VF
>   net/txgbe: add missing LRO flag in mbuf when LRO enabled
> 
>  drivers/net/ngbe/base/ngbe_hw.c     |   9 +
>  drivers/net/ngbe/base/ngbe_regs.h   |   2 +
>  drivers/net/ngbe/base/ngbe_type.h   |   1 +
>  drivers/net/ngbe/ngbe_ethdev.c      |   6 +-
>  drivers/net/ngbe/ngbe_ethdev.h      |   2 +
>  drivers/net/ngbe/ngbe_ethdev_vf.c   |  24 +-
>  drivers/net/ngbe/ngbe_rxtx.c        |   8 +
>  drivers/net/txgbe/base/txgbe_hw.c   |  23 +-
>  drivers/net/txgbe/base/txgbe_hw.h   |   1 +
>  drivers/net/txgbe/base/txgbe_mbx.h  |  17 +
>  drivers/net/txgbe/base/txgbe_regs.h |   4 +
>  drivers/net/txgbe/base/txgbe_type.h |  21 +-
>  drivers/net/txgbe/base/txgbe_vf.c   |  29 +
>  drivers/net/txgbe/base/txgbe_vf.h   |   2 +
>  drivers/net/txgbe/txgbe_ethdev.c    |  18 +-
>  drivers/net/txgbe/txgbe_ethdev.h    |  16 +-
>  drivers/net/txgbe/txgbe_ethdev_vf.c | 111 +++-
>  drivers/net/txgbe/txgbe_fdir.c      |  62 +-
>  drivers/net/txgbe/txgbe_flow.c      | 857 ++++++++++++++++++++--------
>  drivers/net/txgbe/txgbe_rxtx.c      |  18 +
>  20 files changed, 943 insertions(+), 288 deletions(-)
> 

Applied to next-net with some minor changes to commit messages
to workaround complaints from devtools/check-git-log.sh.
The script is fussy about the use of the word Fix in commit logs.
