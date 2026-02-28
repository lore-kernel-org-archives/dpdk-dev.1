Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3171048925
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Feb 2026 00:41:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA5C640615;
	Sat, 28 Feb 2026 01:41:54 +0100 (CET)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 442AD4013F
 for <dev@dpdk.org>; Sat, 28 Feb 2026 01:41:53 +0100 (CET)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2bdc8db07a3so2347041eec.0
 for <dev@dpdk.org>; Fri, 27 Feb 2026 16:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772239312;
 x=1772844112; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y7chlI0PnynxhugM+gV2ubigzUqaY9ylW6Cu5ge+MIs=;
 b=ZjE22dnl+cbJkm2AHwb8X3xF69jSH2MeQl6xB+aeBFS+tFADH6dalxYmyT6tPmythG
 svdVEHhIjAOs+nkm3pPHt0wN5+Y+oyLWApMzikCBA8n4ynI87yulObGEh/8ZwtNLhigI
 pCQQjEWbNQftTuQ0+PJ4Q7gc8AaNULLMDZ6KQCxBExx3Ap++7eLVO4EuU2nJ40+ZUjTz
 51TQW2kjLt9WBv4/E4yTp3oBuGUJdj7sqasytQnZZoQgQokEFr3R+dz/3QaVeHnRCugV
 ndK/50kkkZ8363P9c7UvHTqij91XRUD1cfVuEfYnFoYG6aKH2udV7ZOHwXGbpkVc07HA
 vCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772239312; x=1772844112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y7chlI0PnynxhugM+gV2ubigzUqaY9ylW6Cu5ge+MIs=;
 b=GiPeKaisxkLh66n/qVgcBRgluMmIndYogHYA9mC5ipJhz/OIJFdcFBFhZw2UoucK9Z
 UwhsHhEPncNQ0EvVBTjNpjjY0BvE7ZQMazPv6JFQa0tYwlwtTJQ9VqwwaPJBmCzqj/iQ
 oBFFHuqyTJa6bqM3bFvWlYvu7IFk9QRNbWH2830tjQwCinyJX84J/CgNmUVWXJkQISbn
 sMexrjNiCPh9LF1gcjs1W8VOAjxDfYNNkZ0tesNXmfRxAbLt6uiUhMINFX31wuB6shTq
 53IT6h3AKaoguYT+iE5GVh+Y0o+9htk6CDm6YVGjBMi6QSkeYEAs4GN3LlLurgnPR7Vr
 MNpQ==
X-Gm-Message-State: AOJu0YwG6lCgnTXmuZC8LZx4Ao9i7kDzTL4AKJvyWOagO1nUZR99djKI
 K+lzZC+7iBI1Nvw4ySVjRBIuh9MNglImNsC5txgqggvGu9EanPi4CnFngGh73T5W6Wk=
X-Gm-Gg: ATEYQzzCQFpfILdxz4c21qPzF4BoZvRa+1JcTXkLJeSRcUzml/m3vN/yfnWBBa8B752
 Z/yu1iWvputHM5dKL9AyzRpoK0DWr/vGwyLZ0p8ws2At3se2zVcAN/BZNChPe6cuMWXhZVP38pJ
 ctJszw4mbAnAfkox+jyYDvRkUwClHqZc+PB8oRd8mXj4PHCB8P+x8Lizs/m1CPoQ5UEdQvGgmpj
 +d3iyNqG3ik6dGYuJpzq7VFgFM9Bh5lcHv8HqscV691l/cz9AISUAmh/wI8rdJyiIxZRkWgsAF+
 FE9IYrsaUkztiiBCjgLWjEaSoARSPH/AuOfXqViUkvHBdcoXiC97TZ1j7wVEUP06iyV8fOel6lt
 ZxlsHuotJf8tVrNqcdmMUnYZV2cuI93Xhnlrc39rTc5eeKygKI0elRWYBBmERkpInXBZzC+mSpt
 Wx89etxiYsfcPaEwfSH0SGF5UlkYMS1reOHM5rme66QsG804ffyyr2/hq016n2dQat
X-Received: by 2002:a05:7301:2b06:b0:2ba:8706:d022 with SMTP id
 5a478bee46e88-2bde1d6f6e9mr1735935eec.18.1772239311960; 
 Fri, 27 Feb 2026 16:41:51 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdf5731c85sm125958eec.3.2026.02.27.16.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 16:41:51 -0800 (PST)
Date: Fri, 27 Feb 2026 16:41:48 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@microsoft.com>
Cc: dev@dpdk.org, Wei Hu <weh@microsoft.com>, stable@dpdk.org, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH v5 0/7] multi-process and VF hotplug fixes
Message-ID: <20260227164148.470898ef@phoenix.local>
In-Reply-To: <20260227015928.14338-1-longli@microsoft.com>
References: <20260227015928.14338-1-longli@microsoft.com>
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

On Thu, 26 Feb 2026 17:59:20 -0800
Long Li <longli@microsoft.com> wrote:

> Fix several issues with VF hotplug and multi-process support in
> netvsc, mana, mlx5, and mlx4 drivers:
>=20
> - Fix race conditions between VSP notifications and DPDK device events
>   during VF add/remove, with proper locking of VF-related fields
> - Add multi-process communication infrastructure for coordinating VF
>   removal across primary and secondary processes
> - Fix Protection Domain resource leak on device close in mana
> - Fix devargs memory leak during VF hotplug in netvsc
> - Fix fast-path ops (rte_eth_fp_ops) setup in secondary processes for
>   mana, mlx5, and mlx4, ensuring burst function pointers are restored
>   after STOP->START cycles
>=20
> v5:
> - Patches 5,6,7: Also restore rte_eth_fp_ops burst function pointers
>   (rx_pkt_burst, tx_pkt_burst) in START_RXTX handler, not just queue
>   data pointers. Without this, after a STOP->START cycle the secondary
>   process burst pointers remain set to dummy functions.
>=20
> v4:
> - Patch 1: Check hn_vf_add() return value in netvsc_hotplug_retry
> - Patch 1: Track fresh_attach to avoid tearing down original VF
>   attachment when configure/start fails on an -EEXIST path
> - Patch 2: Move counter decrement and netvsc_uninit_once() after device
>   cleanup in eth_hn_remove() to prevent use-after-free of shared data
> - Patch 2: Clear netvsc_shared_data on init failure paths to prevent
>   dangling pointer
>=20
> v3:
> - Fix review comments from v2
>=20
> v2:
> - Initial rework of VF add/remove locking
>=20
> Long Li (7):
>   net/netvsc: fix race conditions on VF add/remove events
>   net/netvsc: add multi-process VF device removal support
>   net/mana: fix PD resource leak on device close
>   net/netvsc: fix devargs memory leak on hotplug
>   net/mana: fix fast-path ops setup in secondary process
>   net/mlx5: fix fast-path ops setup in secondary process
>   net/mlx4: fix fast-path ops setup in secondary process
>=20
>  drivers/net/mana/mana.c             |  14 ++
>  drivers/net/mana/mp.c               |   8 +
>  drivers/net/mlx4/mlx4_mp.c          |   6 +
>  drivers/net/mlx5/linux/mlx5_mp_os.c |   6 +
>  drivers/net/netvsc/hn_ethdev.c      | 300 +++++++++++++++++++++++++++-
>  drivers/net/netvsc/hn_nvs.h         |   6 +
>  drivers/net/netvsc/hn_rxtx.c        |  40 ++--
>  drivers/net/netvsc/hn_var.h         |   1 +
>  drivers/net/netvsc/hn_vf.c          | 148 ++++++++------
>  9 files changed, 437 insertions(+), 92 deletions(-)
>=20

Looks okay to me, the AI review feedback raised a couple of questions.
If it is ok will take it as is for this release.

The AI summary was:

Patch 1: hn_vf_add_unlocked() =E2=80=94 when hn_nvs_set_datapath() fails at=
 switch_data_path: after a fresh attach, the VF is not detached (no goto de=
tach). This leaves inconsistent state.

Patch 2: netvsc_uninit_once() =E2=80=94 primary can free the shared memzone=
 while secondaries still reference netvsc_shared_data, causing a dangling p=
ointer. The local-only secondary_cnt check doesn't reflect remote secondary=
 processes.

Warnings (should consider)

Patch 1: Potential deadlock in hn_vf_close() =E2=80=94 holding write lock w=
hile calling rte_eth_dev_callback_unregister() which synchronously waits fo=
r in-progress callbacks that may themselves try to acquire the write lock v=
ia hn_remove_delayed().

There were a couple more things but these were just AI being overly paranoi=
d.


