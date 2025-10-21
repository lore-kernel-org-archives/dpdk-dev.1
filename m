Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217A2CCD19F
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 05:25:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9B7A402BC;
	Tue, 21 Oct 2025 07:25:50 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 2B434400D5
 for <dev@dpdk.org>; Tue, 21 Oct 2025 07:25:49 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-33082c95fd0so5156766a91.1
 for <dev@dpdk.org>; Mon, 20 Oct 2025 22:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761024348;
 x=1761629148; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vX1sQ5rqm71hSOna1jsFmhBZ1BpOT4ZoJasre7Rfpn4=;
 b=V1lZwplizw1lT3YnxB46f5P0h3DmMmy/pB2ZNw/aYRaV/Et2As/GunZg6W0Z6hV5Jm
 yk0/upS/5tBAhIhwXuO2tq+05l9qLGqDMOUFtE4Fuh7QgR/aXfqIDiEmHwlsjaVizAvd
 rB31ukHOuxXfuQZZJJXNCO38ReKiXaP6Q4Z1lIsytK8UXMnqusLaGKABcgTv8NhEls9N
 FlrOpjP4mhQrgdZHI8tib9ZAdy8cx/g66I+CoUQH6mpwALdQ4O0/m++UThioYqmsCkCq
 42cqjk/U6DvcgLVciv/ZljZXvTGHSAfVGG5e5+UG4F7OeydR8bO7AlWZ2JMII0zE0Qa6
 lMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761024348; x=1761629148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vX1sQ5rqm71hSOna1jsFmhBZ1BpOT4ZoJasre7Rfpn4=;
 b=IXNFHZJrzatBqud+ZFJZLd3QTNKDzSP/HjQXqO9sjuqxrJOcQFRJs8xZv+tnhFdYdz
 8udx1slJklEfmNNMjf11nk0YFLZb5MMRqESlZ7ovGgUv1fgFr80QowUzHBOHft0B/N6f
 XbCz9vRsBcA6z9cMtrO4zyLLmj+4PrG+DeKGomOirIl4x4mhfvBgOTDZHrm6TG+ySOup
 39H/kOZS1Wf3UZ1qBO+kJOEctOWA/BsewspJeE0KuVlK5XLM/UvzoCF4yAVU7VqT/nXS
 LSePRkNegRR+ogyh6A/NRr37Q9ezxiebSdQ9hG74Bh50++qNNPubc8spNcst1UADc3ZJ
 cn1g==
X-Gm-Message-State: AOJu0YxUHkDjJsMKZGAuoDDqW20ChcMC03JQBJqJldJ/ugug6ew2/x37
 OzZuyvL/JdA3H2j+Kyb0wLPnTTQprZBHkyZCPyAB576yGb8ouFDI7rvNcFBPHkVg8bY=
X-Gm-Gg: ASbGncsonZVpkQ0rVtj+b8w5BxpRJul5eYFNEY9HDdntPQZpOMppxzLNUjI4VAv0gJf
 +nKUYuex9OxTs3vv4CMW2c4E9Utud58Za48pRjGPxo54XbMftfSWzX+/6LgloBusWLXYgRZM4in
 37LE5Sb1ARusOs7+hrh5Jak8uAVOe6pHUxg9zVDzzWulkvtpRPdFDzuB2WXUctvQgOSlftLT7O5
 wgMl9ObybfXsTVGPvabExH08PXERpdIeNTRoZvnoxuYMZriEqN79c+39sB6vXWRJ14ZPepNXnub
 8ctK1tIZGIUrKUMcc3SdFDO9VCWqGrE9CWlC0C3RS3AyGj8mv4SDizzT2s7p9y82WI5lGNwkcar
 F3mflrTPTaVE6ntwR3mFZVq52XFnun6t/aLa1+ILH411XB5QfUzzhqn9mkAQ2eA+2lB455XJ29t
 GBcI3aHI37YBhj+S/UiQ8JMrBByVTvdg0KC8agB8RngQE4PaBYrA==
X-Google-Smtp-Source: AGHT+IHqxtzM9lPgr0uVfW0nAXMftfnKZNF2vPz6hut7e1tNz0tK/IE6XqIgE/J+AvpnqD316k8oyA==
X-Received: by 2002:a17:90b:2883:b0:32e:3830:65d5 with SMTP id
 98e67ed59e1d1-33bcf9222aemr17055184a91.36.1761024347969; 
 Mon, 20 Oct 2025 22:25:47 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33d5de8091fsm9913961a91.19.2025.10.20.22.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 22:25:47 -0700 (PDT)
Date: Mon, 20 Oct 2025 22:25:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shai Brandes <shaibran@amazon.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH v2 00/20] net/ena: Release 2.14.0
Message-ID: <20251020222546.04adb7ad@phoenix.lan>
In-Reply-To: <20251015120415.2204-1-shaibran@amazon.com>
References: <20251015120415.2204-1-shaibran@amazon.com>
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

On Wed, 15 Oct 2025 15:03:55 +0300
Shai Brandes <shaibran@amazon.com> wrote:

> This patchset includes an upgrade of the ENA HAL,
> introduces a new feature, and addresses few bug fixes.
> Based on repository: dpdk-next-net; branch: origin/main; hash: 1d627ea13a
> 
> Thank you in advance to the net maintainers and community members
> for your time and effort reviewing the code.
> 
> Best regards,
> Shai Brandes
> AWS Elastic Network Adapter team
> 
> ---
> v2:
> removed 0002-net-ena-base-rework-admin-timeout-handling.patch which caused compilation failure in ubuntu-22.04-clang-stdatomic test
> 
> 
> Shai Brandes (20):
>   net/ena/base: optimize Tx desc fields setting
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
>  drivers/net/ena/base/ena_com.c                | 273 +++++++++++++-----
>  drivers/net/ena/base/ena_com.h                |  62 +++-
>  .../net/ena/base/ena_defs/ena_admin_defs.h    |  44 +++
>  .../net/ena/base/ena_defs/ena_eth_io_defs.h   |  12 +-
>  drivers/net/ena/base/ena_eth_com.c            | 218 ++++++++------
>  drivers/net/ena/base/ena_eth_com.h            |  59 ++--
>  drivers/net/ena/base/ena_plat_dpdk.h          |   2 +-
>  drivers/net/ena/ena_ethdev.c                  | 140 ++++++++-
>  drivers/net/ena/ena_ethdev.h                  |  19 +-
>  drivers/net/ena/ena_rss.c                     |   2 +
>  12 files changed, 626 insertions(+), 214 deletions(-)
> 


Queued to next-net
