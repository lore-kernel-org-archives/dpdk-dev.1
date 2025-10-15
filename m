Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02732CCD199
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 18:12:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EB8940A76;
	Wed, 15 Oct 2025 20:12:59 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id 25BA240273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 20:12:58 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-b5579235200so4353758a12.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760551977;
 x=1761156777; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1EHEqWCSJSyCppahkSUH1uApzUNzdsrVzGY5+90pXsI=;
 b=ff89jY6uyJthNFtCgTYtSbJoRfAdQc3Qy7qukoQL4Z8cOV6aJ3aDQNni99pJHwin7w
 XEB9M7DYZDF5t3+Ph6kEpdJ7Z+3TtwWgoOcfoBvSiyWznI39/OpYpKRW9dJ0vu9FkN9l
 wP/L/UtUiQ8R+bUUjZ3CFcmJx/f77W9PzcXO689VKyi61brOixzfXkpGB81PgDArQeqE
 3Oe9AabEVINF3/ypuhbmObAl1ddbMxLqo1PeumWE5vcV0BOjIndMecfzu+TAZHHI6O/Y
 9ztB8zNuijKpfeOY3yClGHySSTwnT/9+hmsDFhdqsPGrQPaUHb9R7O31ULbtxX+LYJ11
 G5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760551977; x=1761156777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1EHEqWCSJSyCppahkSUH1uApzUNzdsrVzGY5+90pXsI=;
 b=EiXtSffvb/5xkA3B2bac7a7WeQtBQ6UVbAa1n+wgqpG+6q7tfVTtG0NoxwA6QXLXtW
 waZKZce3ZpOp2YCYsdY95zTwi8nxvh0JOQP8xS2Q1vpqxmRHNZz4zPYUyHqn3NMIIp45
 /O8aZIvrEPi+xZMvbBHeZtsYdQ+f1VFkrgvjmxyoYr1gpCDx9zU1v3xISsHAuM2m9DAo
 4gDE2kafWWwUoJn2LEqLDK3yZgJsSI7E/+0wPskyqNGdGoIPVGzWhO4AFM/8dcXnMQtA
 KKdbhUL2rZGoNUUPm5k29uaPp76cvWZVbJnalxfk8ItyfBW4H1HPPiYZUVcoT1vTwMzo
 5QnA==
X-Gm-Message-State: AOJu0YwwL/HsuscdVD8VOJfB6FVsL0y6ZfzlSFczfCto4cxE8zz9Yne0
 wNtGdEzRfQ4i4vhSvl5qsz+Xo6Fta59yfGm6eCyKcR8GbsgGQvzwXZmxW6HBVkxSWAc=
X-Gm-Gg: ASbGncvPmGbjXsNr7aLYEJ3SdOrMb3zU8Hb/BbYZ3fzScE2I+Tbic1ZeU+tYdJCZght
 Do2tunP8DzntCcdwTdWBcM5Ih/0Nide4+DzhnkqPegDZG+zzuQxq1e0ETTMx9kgtcPOTJcXrlyJ
 1gk2lDZp4eIzsvyIqnoYSvv1j1kmiBA6yxo8JVRq6ZGVpbeQ7WlHE9rc1rXU2kL8wOyvRr1R86a
 F6K56IFd9mCjsq7dXJFQRygg3iPo7NZc6zxV46tnDRz3esqPz+Rxll+yOljH1d+1httrXLztdFk
 QWcIMrqF8Y72ArJ5rQUMEALM1BFXnQvjURLRx56Wdc7TmI6jVq8K/uHVy3695wiaAbvPjVpyy88
 s5xX7ucZSIZ/yN1dL2wCtfg3VM7//EQob3WGXYzmIel6DUAOgoNGbt3LzrcgHINgB7T8485cOip
 sz40LUVV0IZnfC5lu52dhcNrh40i1o
X-Google-Smtp-Source: AGHT+IFmDwzxDBPQORhGZtISpcj6phun88byxRUX/QUfPmQ7bz92pU3mcpnW+vP79Up4mUaq+HGKTQ==
X-Received: by 2002:a17:902:d50f:b0:278:9051:8ea9 with SMTP id
 d9443c01a7336-290272dc4a7mr407673175ad.40.1760551977094; 
 Wed, 15 Oct 2025 11:12:57 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2909930a756sm3144055ad.14.2025.10.15.11.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 11:12:56 -0700 (PDT)
Date: Wed, 15 Oct 2025 11:12:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shai Brandes <shaibran@amazon.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH 00/21] net/ena: Release 2.14.0
Message-ID: <20251015111254.4d04167f@hermes.local>
In-Reply-To: <20251015070707.340-1-shaibran@amazon.com>
References: <20251015070707.340-1-shaibran@amazon.com>
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

On Wed, 15 Oct 2025 10:06:46 +0300
Shai Brandes <shaibran@amazon.com> wrote:

> This patchset includes an upgrade of the ENA HAL,
> introduces a new feature, and addresses three bug fixes.
> Based on repository: dpdk-next-net; branch: origin/main; hash: 1d627ea13a
> 
> Thank you in advance to the net maintainers and community members
> for your time and effort reviewing the code.
> 
> Best regards,
> Shai Brandes
> AWS Elastic Network Adapter team
> 
> Shai Brandes (21):
>   net/ena/base: optimize Tx desc fields setting
>   net/ena/base: rework admin timeout handling
>   net/ena/base: add extended Tx cdesc support
>   net/ena/base: add IO ring helper functions
>   net/ena/base: add lost interrupt indication
>   net/ena/base: add Rx cdesc dump on bad request ID
>   net/ena: add Rx HW timestamping support
>   net/ena: rework sanity checks
>   net/ena: add verification of DMA address width
>   net/ena: fix PCI BAR mapping on 64K page size
>   net/ena: style and comment changes
>   net/ena/base: rework log format
>   net/ena/base: add phc error statistics
>   net/ena/base: remove redundant zeroing of Tx desc
>   net/ena/base: style changes in hal
>   net/ena/base: improve admin logging
>   net/ena/base: remove redundant if sentence
>   net/ena/base: fix unsafe memcpy on invalid memory
>   net/ena/base: optimize branch prediction
>   net/ena/base: change return type and improve logging
>   net/ena: upgrade driver version to 2.14.0
> 
>  doc/guides/nics/ena.rst                       |   4 +
>  doc/guides/rel_notes/release_25_11.rst        |   5 +
>  drivers/net/ena/base/ena_com.c                | 346 ++++++++++++------
>  drivers/net/ena/base/ena_com.h                |  63 +++-
>  .../net/ena/base/ena_defs/ena_admin_defs.h    |  44 +++
>  .../net/ena/base/ena_defs/ena_eth_io_defs.h   |  12 +-
>  drivers/net/ena/base/ena_eth_com.c            | 218 +++++++----
>  drivers/net/ena/base/ena_eth_com.h            |  59 +--
>  drivers/net/ena/base/ena_plat_dpdk.h          |  24 +-
>  drivers/net/ena/ena_ethdev.c                  | 140 ++++++-
>  drivers/net/ena/ena_ethdev.h                  |  19 +-
>  drivers/net/ena/ena_rss.c                     |   2 +
>  12 files changed, 693 insertions(+), 243 deletions(-)
> 

There are some merge conflicts (common problem) on the release notes.
Recommend that in future, release note changes be last or standalone patch.

