Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FA9FCC05C
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 18:51:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58E7D4066B;
	Fri,  6 Mar 2026 19:51:19 +0100 (CET)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com
 [209.85.160.52]) by mails.dpdk.org (Postfix) with ESMTP id 0EB36402E3
 for <dev@dpdk.org>; Fri,  6 Mar 2026 19:51:17 +0100 (CET)
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-40ef10ec84cso3373632fac.2
 for <dev@dpdk.org>; Fri, 06 Mar 2026 10:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772823077;
 x=1773427877; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=keNE/aasiJKN2AcBWmEV7zBuYeffb5+F0pO8jAiLuRA=;
 b=px0J5oC/+eVlQI/lKNXcMcWOdeT0ufL+o3MYo8uF9x9P02DBDhAdkKFvHBBH+ewPSy
 /sdo4d++UEJ18DNdDiPavHI6z+mlHVnKIxTNC+ERCklIBPYK+vhJu00Qsk0nJQJKJjt4
 vs2iZ3thUnrdcv4SvulqqUxKZ940Zo2Pfcr0OdlENxOvquQh1k6JjuO8594H1RUkZgRp
 9fERJaP9HobE4PDPMhKlwvn//wtvctDq9POPc69p7bMLRG9Z5fBVvkxylxr8TmyC2emS
 Ptl7YuIHKRRsbPcm49Z50niMDormSX+lGGaDy7zFVAYIQc0pvYH3k4Q55ltLO+tt4sZV
 jSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772823077; x=1773427877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=keNE/aasiJKN2AcBWmEV7zBuYeffb5+F0pO8jAiLuRA=;
 b=rMbg5+49ExOSzJ9VNX/6tZ8BgQifOEM1DGhqKv9vsBjpKlnzFm/oY1nNH0wl3szl6h
 E9zt70YifbZaH8GG2Skluxk9yud02rO/7Xyajzm00Ht7mCLGFKypEQLZSA92MN/43dPX
 80/NWZWTNe+36qCmwIhtHdV3hHZdon7+g+mwd4FowBkEViK3X4bg7VPfYAVFh8ZxmHL5
 1kc9+QAHB7Xa/N216G720a+zFLt+/3DceN/SThjXLRdLQnDyskqlogkyw6D54tW6Is/H
 Bz5VcaCyKAKYRtKoyvEMavm91HhULxuTWSuORpRg5oCXrlBAh7EwWj8GpdccnvGfLtk4
 xSdQ==
X-Gm-Message-State: AOJu0YwN9WUbzZH/fR/Uv6sZUWLp+bcPmXQvL06uvRsSg8+nctcYGPx0
 nXXAdHtLsEDvy0yYOF0XNa07tT0shZpcSZHgymbZ0XeCKldBN+CaqR6D5AgOunwPKl8=
X-Gm-Gg: ATEYQzwxyFvIr8k+dDwOI4rAbdFIPk8u42angY//X1hopC1134k7k8/VqncNrpvYhef
 ndtd9wXKN3BFW8nG4cnOO/LSMoGGWXeyNtO3td+wUh3WidSljj/zfj7N9eL7W6hVa0GXy5Yd9bf
 ckXL9GgTa150ylsa5XODObHmVBbKo5O6+Ml5i+jUWYXzt+Lly0RIAlEvWe1YmbW6PjqhiKhSVip
 EzNk6oI47VyDtd09xhkkuHEkxpjKslTF0O5KObh8u9pK52PoCYBaHptwCcKctU0UQWAlpp+rb6H
 yn9aw7V0QkmymP/ibT7ITQg0AcVxwEX4Ecb5p393Tin/scaNmijPyDb3aiiLYLkhaWFF+fRZ111
 8BsZoex0UAPbFbqIT6wxeGJFzzb60NexWafcsy9ASne4DAMH8howPhZPn2qdw0Tzi2vQ5Q9zrDc
 rs6iTGbnoWMGdtKRMIuOGOFEQc+4F+uIy0kcnCpaSsTpC589plMby182oTpje8mvqY1eEmyeUDl
 ms=
X-Received: by 2002:a05:687c:40a3:b0:409:5560:72f8 with SMTP id
 586e51a60fabf-416e39ec1femr1845439fac.0.1772823076886; 
 Fri, 06 Mar 2026 10:51:16 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-416e6561543sm2033153fac.3.2026.03.06.10.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 10:51:16 -0800 (PST)
Date: Fri, 6 Mar 2026 10:51:12 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com, david.marchand@redhat.com
Subject: Re: [PATCH v3 00/17] net/dpaa2: fixes and improvements
Message-ID: <20260306105112.46d8d0c2@phoenix.local>
In-Reply-To: <20260306133035.179709-1-maxime@leroys.fr>
References: <20260226143341.282188-1-maxime@leroys.fr>
 <20260306133035.179709-1-maxime@leroys.fr>
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

On Fri,  6 Mar 2026 14:30:18 +0100
Maxime Leroy <maxime@leroys.fr> wrote:

> Various fixes and improvements for the dpaa2 net driver and fslmc bus.
> 
> Patches 1-6 fix resource leaks on port close, error paths, link status
> and devargs propagation on hotplug.
> 
> Patches 7-14 fix additional bugs: spurious VLAN insertion, error packet
> dump crash, packet type classification, checksum offload flags, software
> taildrop buffer access, burst mode info reporting, SG table walk bounds,
> and MAC stats DMA allocation.
> 
> Patch 15 is a minor cleanup in the link status area.
> 
> Patches 16-17 add devargs alternatives for getenv-based configuration
> of taildrop and data stashing options.
> 
> Changes since v2:
> - Fix checkpatch warnings: short SHA in Fixes tag (patch 14),
>   long line in commit message (patch 10)
> - Fix check-git-log warnings: shorten headlines (patches 3, 9, 12, 14),
>   fix tag order Fixes/Cc (patches 10, 11), fix wrong Fixes reference
>   (patch 8), remove colon after function name in commit body (patch 8),
>   lowercase macro name in headline (patch 15)
> 
> Changes since v1:
> - Add Cc: stable@dpdk.org on patches with Fixes: tags (Stephen)
> - Reorder series: fixes first, then improvements (Stephen)
> - Patch 2: squash with former patch 4 (Hemant)
> - Patch 6: move devargs refresh from plug to scan rescan path (David)
> - Patch 17: keep getenv for backward compatibility, add devargs as
>   alternative instead of replacement
> - Drop former patch 11 (bus/fslmc: remove dead blocklist check) to
>   avoid disaligning with other buses (David)
> - New patches 8, 11-14 fixing issues reported by Stephen
> - New patches 7, 9-10 fixing VLAN insertion and packet classification
>   issues
> 
> Maxime Leroy (17):
>   net/dpaa2: fix queue block memory leak on port close
>   net/dpaa2: fix Rx error queue memory leaks
>   net/dpaa2: warn on Rx descriptor limit in high perf mode
>   net/dpaa2: fix resource leak on softparser failure
>   net/dpaa2: fix link not up after port stop/start
>   bus/fslmc: fix devargs not propagated on hotplug
>   net/dpaa2: fix spurious VLAN insertion on non-VLAN packets
>   net/dpaa2: fix error packet dump crash and memory leak
>   net/dpaa2: fix L4 packet type in slow parse path
>   net/dpaa2: fix L3/L4 checksum offload flags
>   net/dpaa2: fix software taildrop buffer access
>   net/dpaa2: fix burst mode info report
>   net/dpaa2: add SG table walk upper bound in Rx path
>   net/dpaa2: fix MAC stats DMA alloc per xstats call
>   net/dpaa2: use check interval macro in link down path
>   net/dpaa2: add devargs to disable Rx taildrop
>   net/dpaa2: add devargs alternative for data stashing getenv
> 
>  drivers/bus/fslmc/fslmc_bus.c           |   4 +
>  drivers/bus/fslmc/portal/dpaa2_hw_pvt.h |  16 +-
>  drivers/net/dpaa2/dpaa2_ethdev.c        | 211 ++++++++++++------------
>  drivers/net/dpaa2/dpaa2_ethdev.h        |   3 +
>  drivers/net/dpaa2/dpaa2_rxtx.c          |  85 +++++-----
>  drivers/net/dpaa2/mc/fsl_dpni.h         |   6 +
>  6 files changed, 164 insertions(+), 161 deletions(-)
> 

Applied to next-net, minor edits to first commit message to fix
the reference commit; problem reported by checkpatches
