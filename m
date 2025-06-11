Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B97DC677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 02:01:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 210B040144;
	Wed, 11 Jun 2025 04:01:02 +0200 (CEST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id 3DF71400EF
 for <dev@dpdk.org>; Wed, 11 Jun 2025 04:01:01 +0200 (CEST)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-4a58b120bedso79327351cf.2
 for <dev@dpdk.org>; Tue, 10 Jun 2025 19:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749607260;
 x=1750212060; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zcSrNMzEK3kr3O8lyRxqWvQI4AX80Ak+a18o8T7DZoY=;
 b=q1UQZe6aJ2rd4BjKE18jIck4adTJGgD1rBrAOhrvJD9b1yLE8qdAoMiay5rFuyf/J6
 Jg6nRyQjYzg19p+pBtY+6us0F0Ickp/NEt03Y2rXySvr8Ex3kv0ZXmyu/U2gR8RsfWvg
 kA/1HNEqo2WhPU/2x4CX9dPde704w1A+4Ai00xmVyQnCLRVfBwhEjh978mEsSunNZJHk
 GARF4lZo0LJiAOKoEjd2nEPgvu5gdv3hU16dOYuC/baxAL0PKB5Lk83sCucXS75CsCLS
 plo+CjFraxnn2jJcS8sHlpd+yQOdAFiR2e3CDFJQVi4iBsWqx18boxCeRwGvi+AtFdIX
 d8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749607260; x=1750212060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zcSrNMzEK3kr3O8lyRxqWvQI4AX80Ak+a18o8T7DZoY=;
 b=BDK9cnwXd/UZvxdSnHtK8x6VpCIQOLSqd6X8nwCFPUDnqkbk2LfywfhKFXoD2AVv/+
 d0nHgKlOW2A/4VELmOa8lx8CdvhBoIDRu//YW8AuCJINdttjmfkyGblSs0/Ai3PuKcfK
 aLAUpMikSFFADb5NvT/SntRKONyh9/bwpUIJaKp8vWoxT1rGkg334U+ZZdZy1XGGdQZK
 r5RP7Kpzm4ETx5kRAN6FtvGpv8KwR65da2T4i5bVWjuRjvEeyFvl9mzxbXqGrJp/pUs5
 wyt6gFD769Eakx18hh2kw9vcWhuPfUUO5IoEdBSzjdwy14OQskVAH/k6TWmccvXCfrdE
 zedw==
X-Gm-Message-State: AOJu0Yy0Vv1Q5EyqvEffYB8Ch90o78cwIhRil4dOYIMCWzMC5plsLqvp
 r/1eNPymBWuSqMCIQARkyHhYQfVrxLd3vG83ikamjzzq90SdyC2Y+WqgEMNCzH/SMBu5EEfaii6
 Ft9dp
X-Gm-Gg: ASbGncukyYKrgfvJLypPOTULl0eNMazcnrEBiqnHOmIyNdzkAZ2L1jOb5c5HHukSCL3
 CWig+JDzVrUVKy0rpoSG12eoNXnnDkRvrnulKJUTZXUiyxPHXyg+kpzCeYvTHAcl0L7AS1rZkK5
 lce7EcaxT1dOt8bVs6w7W7dt7zSjzDwG0q3gioXzCPCJn3ubU8iAzqfMQwTP1tCsKZhIcwhxrPb
 Nu7/x37lcwZWg3rNxULUDpZMvxXKEv0zvaERPOLdVAkT32D+PB9ih0YCL2LJOeVjDfZ2zhmN7n+
 Cw5yJU+eQc+37TUvfEf58YLWzYUBDX6njirFgxsgwe/4K2Z5WEXwwa/Y/y28aIbi0tdGMK+iKt0
 thpUJ8o09T0G5nppqwQM8gKwYMwxR/SzoDOMeI+4=
X-Google-Smtp-Source: AGHT+IGvJ2an9DvKGri8pTMKPEny/55Q8sirxx45lCmsrR1JO/w2iG1+B2ZLjtcGYHSboU32q3Gt5Q==
X-Received: by 2002:a05:622a:1c19:b0:4a6:f546:e157 with SMTP id
 d75a77b69052e-4a713b8ba0emr32893441cf.4.1749607260308; 
 Tue, 10 Jun 2025 19:01:00 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a619852d27sm82627681cf.42.2025.06.10.19.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 19:01:00 -0700 (PDT)
Date: Tue, 10 Jun 2025 19:00:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: dev@dpdk.org, zaiyuwang@trustnetic.com
Subject: Re: [PATCH 00/12] Fixes and supports for Wangxun NICs
Message-ID: <20250610190053.07167571@hermes.local>
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
