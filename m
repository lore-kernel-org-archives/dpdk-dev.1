Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBD6F53D6E
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 16:04:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 900A44025E;
	Mon, 16 Mar 2026 17:04:44 +0100 (CET)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id A8D57400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 17:04:43 +0100 (CET)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-128e3125372so3471839c88.0
 for <dev@dpdk.org>; Mon, 16 Mar 2026 09:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773677083;
 x=1774281883; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=koBO8Vv6H/EVcSKyCGbgFnCvz4GdiR9h0CNXSr0yZIY=;
 b=SeAHR3t8/RsXr7a4PUCUN6DPa9cCSfdP3B92Md6x9RN25yKOi5LJdJjJ1M1a7iCD9G
 WZHApr2C6HCaVTGkMrg2m3ON6O24eps6bWL+2Lik+dJFnhDOa21adND/kOrQqyA/uTV+
 9k+7R3iE0CkgyMSoB1up41YrP2Gr0vspc3koJh23dBzw/4SvZMWKeIKc91ISFyLY4TUa
 UBq+gO7B/3v1Gk9w4F1nl2kbwUphD6QFNxa6/jEeDm1Tjj6HEmOBSus0CWZSg1sCkfuy
 wowKdkXv045AzuwfNm7Tzaj6UunwcqBMia4r23zQkTQk83KaIHahFl7TQAkcJxp+2bU4
 EiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773677083; x=1774281883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=koBO8Vv6H/EVcSKyCGbgFnCvz4GdiR9h0CNXSr0yZIY=;
 b=EVrGe6K2aAMchdKrPd5NWug7GenwqlTlEXhpYoPL3EAY9C1MqQCc9RnCxSMjmWt92M
 ytsW6krF64o5FLSzeyyel8LAWrFilEnMSG3IGQyLGZTXGrSRQbOymRqjD00FgMFs3+FK
 hOcqmN4/QXHF26APA6VHFQIEc+tcfLVOyo84uWNTiTefI28IBsV4QdXvyPH19Pz4NEVT
 9c7yDkPCtAr16ZbtNRnDkGiu+nc/nLmEN6QxBShu7TW38xRUfPcC9a3pnmCsw57GNGyx
 myJuqyXtV12Ztc5bF4gmHHx4JDXzweEMY0v1NK/zi3WlBpD9/rkBjqcxE+Z3DsNYewcI
 ss7A==
X-Gm-Message-State: AOJu0YystY1phw5eHRuypyQknHsjSLWyeQcsbHQbjtHzkhPEeeCoRwyW
 lThldYzL8g+ctRlL9KthmuoFD/DVulA7P9W7tAMw1KH/Rj/frk1OGbmaGos8rfVhjcI=
X-Gm-Gg: ATEYQzzzc4ee15zU6bMA4OPC0hs2NbcUSN9iOB3or+QzWM4a9yjn1+bgoMDcNbKjgkZ
 kRv3nqsdL8k2AqQLosftCX7RzCr7F+4SVj8A5mg9E5PFMNufo/EhBeQE/ht6Vm3anMzTh+OT8Di
 hSZiVSfJWCQ2Kld7kQHY5it2AOyX1I/qveLfa1NptxtokkbdjtxU9Gs6KeAfvrd6GTQV/hdrmEd
 Y0vx4/+RoPRg/GYwfQZ0tbm1JPWxhZu2/2coxm8G+eUeDabdlYbnHsClm0i2tbTcf2Z5VuPM0fx
 LChLO7qA0iNJyXsY8frIF1EG+ic7HTwYPTGHQsBP6GtjKCAxbII6n6I9FdZJ5dpKbjGREW4Dfpe
 kPBDmAr4tnzzU75zWbSVaQJKVRRBVn0hHOKnCG5ZUEv/maWJsYW+XXGuE43pbdtUs2wkFPCF/yk
 JBN5uDDPWEIt2qBXUl13aqMLtTup3PyBlHWJs=
X-Received: by 2002:a05:7022:e1b:b0:119:e569:f875 with SMTP id
 a92af1059eb24-12917268285mr55003c88.18.1773677082453; 
 Mon, 16 Mar 2026 09:04:42 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-128f6384e7asm12038268c88.11.2026.03.16.09.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 09:04:42 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:04:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Jardin <vjardin@free.fr>
Cc: dev@dpdk.org, rasland@nvidia.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, bingz@nvidia.com, orika@nvidia.com,
 suanmingm@nvidia.com, matan@nvidia.com
Subject: Re: [PATCH v3 00/9] net/mlx5: per-queue Tx rate limiting via packet
 pacing
Message-ID: <20260316090438.70b8f7d9@phoenix.local>
In-Reply-To: <20260312220120.3256755-1-vjardin@free.fr>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260312220120.3256755-1-vjardin@free.fr>
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

On Thu, 12 Mar 2026 23:01:11 +0100
Vincent Jardin <vjardin@free.fr> wrote:

> This series adds per-queue Tx data-rate limiting to the mlx5 PMD using
> hardware packet pacing (PP), and a symmetric rte_eth_get_queue_rate_limit=
()
> ethdev API to read back the configured rate.
>=20
> Each Tx queue can be assigned an individual rate (in Mbps) at runtime via
> rte_eth_set_queue_rate_limit(). The mlx5 implementation allocates a
> dedicated PP index per rate from the HW rate table, programs it into the
> SQ via modify_sq, and shares identical rates across queues to conserve
> table entries. A PMD-specific API exposes per-queue PP diagnostics and
> rate table capacity.
>=20
> Patch breakdown:
>=20
>   1. doc/nics/mlx5: fix stale packet pacing documentation
>   2-3. common/mlx5: query PP capabilities and extend SQ modify
>   4-6. net/mlx5: per-queue PP infrastructure, rate_limit callback,
>        burst pacing devargs (tx_burst_bound, tx_typical_pkt_sz)
>   7. net/mlx5: testpmd command to query per-queue rate state
>   8. ethdev: add rte_eth_get_queue_rate_limit() symmetric getter
>        + testpmd "show port <id> queue <id> rate" command
>   9. net/mlx5: rate table capacity query API
>=20
> Usage with testpmd:
>   set port 0 queue 0 rate 1000
>   set port 0 queue 1 rate 5000
>   set port 0 queue 0 rate 0      # disable
>   show port 0 queue 0 rate       # generic ethdev query
>   mlx5 port 0 txq 0 rate show    # mlx5 PMD-specific query
>=20
> Changes since v2:
>=20
> Patch 4 (per-queue packet pacing infrastructure):
>   - Folded "share pacing rate table entries across queues" into
>     this patch (was a separate patch in v2)
>=20
> Patch 5 (support per-queue rate limiting):
>   - Remove redundant queue_idx >=3D nb_tx_queues check (ethdev
>     layer already validates before calling the PMD callback)
>=20
> Patch 8 (ethdev getter):
>   - Add testpmd "show port <id> queue <id> rate" command
>     in app/test-pmd/cmdline.c using rte_eth_get_queue_rate_limit()
>   - Drop release notes (targeting 26.07, not 26.03)
>   - Remove redundant queue_idx bounds check from mlx5 getter
>=20
> Patch 9 (rate table capacity query):
>   - Use MLX5_MEM_SYS flag in mlx5_malloc() for system memory
>   - Minor code style cleanups (line wrapping, cast formatting)
>=20
> Changes since v1:
>=20
> Addressed review feedback from Stephen Hemminger's AI:
>=20
> Patch 4 (per-queue packet pacing infrastructure):
>   - Validate rate_mbps against HCA packet_pacing_min_rate and
>     packet_pacing_max_rate bounds; return -ERANGE on out-of-range
>   - Widen rate_kbps from uint32_t to uint64_t to prevent
>     overflow on rate_mbps * 1000
>   - Remove early mlx5_txq_free_pp_rate_limit() call from the
>     allocator (moved to caller, see patch 5)
>=20
> Patch 5 (support per-queue rate limiting):
>   - Fix PP index leak on modify_sq failure: allocate new PP into a
>     temporary struct mlx5_txq_rate_limit; only swap into txq_ctrl->rl
>     after modify_sq succeeds. On failure the old PP context stays intact.
>   - Set rte_errno =3D -ret before returning errors from both the
>     disable (tx_rate=3D0) and enable paths
>=20
> Patch 7 (testpmd command to query per-queue rate limit):
>   - Fix inverted rte_eth_tx_queue_is_valid() return value check:
>     was "if (rte_eth_tx_queue_is_valid(...))" (accepts invalid queues),
>     changed to "if (rte_eth_tx_queue_is_valid(...) !=3D 0)"
>=20
> Patch 9 (rate table capacity query, was patch 10 in v1):
>   - Replace uint16_t seen[RTE_MAX_QUEUES_PER_PORT] (2 KB stack array)
>     with heap-allocated mlx5_malloc(priv->txqs_n, ...) + mlx5_free()
>   - Add early return when txqs =3D=3D NULL || txqs_n =3D=3D 0
>   - Document in the API Doxygen that "used" reflects only the queried
>     port's queues; other ports on the same device may also consume
>     rate table entries
>   - Add -ENOMEM to documented return values
>=20
> Hardware tested:
>   - ConnectX-6 Dx (packet pacing with MLX5_DATA_RATE)
>=20
> Vincent Jardin (9):
>   doc/nics/mlx5: fix stale packet pacing documentation
>   common/mlx5: query packet pacing rate table capabilities
>   common/mlx5: extend SQ modify to support rate limit update
>   net/mlx5: add per-queue packet pacing infrastructure
>   net/mlx5: support per-queue rate limiting
>   net/mlx5: add burst pacing devargs
>   net/mlx5: add testpmd command to query per-queue rate limit
>   ethdev: add getter for per-queue Tx rate limit
>   net/mlx5: add rate table capacity query API
>=20
>  app/test-pmd/cmdline.c               |  69 +++++++++++++
>  doc/guides/nics/mlx5.rst             | 125 ++++++++++++++++++------
>  drivers/common/mlx5/mlx5_devx_cmds.c |  20 ++++
>  drivers/common/mlx5/mlx5_devx_cmds.h |  14 ++-
>  drivers/net/mlx5/mlx5.c              |  46 +++++++++
>  drivers/net/mlx5/mlx5.h              |  13 +++
>  drivers/net/mlx5/mlx5_testpmd.c      |  93 ++++++++++++++++++
>  drivers/net/mlx5/mlx5_tx.c           | 104 +++++++++++++++++++-
>  drivers/net/mlx5/mlx5_tx.h           |   5 +
>  drivers/net/mlx5/mlx5_txpp.c         |  85 ++++++++++++++++
>  drivers/net/mlx5/mlx5_txq.c          | 141 +++++++++++++++++++++++++++
>  drivers/net/mlx5/rte_pmd_mlx5.h      |  62 ++++++++++++
>  lib/ethdev/ethdev_driver.h           |   7 ++
>  lib/ethdev/rte_ethdev.c              |  28 ++++++
>  lib/ethdev/rte_ethdev.h              |  24 +++++
>  15 files changed, 802 insertions(+), 33 deletions(-)
>=20

Only minor things left to address.

Error (1):

Patch 5 =E2=80=94 git bisect breakage with obj->sq vs obj->sq_obj.sq. Patch=
 5 accesses the SQ DevX object via txq_ctrl->obj->sq, which is the hairpin =
union member. For non-hairpin DevX/HWS queues the correct field is obj->sq_=
obj.sq. Patch 7 fixes this, but patch 5 is broken as submitted =E2=80=94 ea=
ch commit needs to be independently correct for bisect. The sq_obj.sq chang=
e should be moved into patch 5.

Warnings (3):

Patch 8: mlx5_get_queue_rate_limit() doesn't bounds-check queue_idx before =
array access (the ethdev layer does, but the set path checks it too =E2=80=
=94 inconsistent). Also missing release notes for the new ethdev API, and t=
he new eth_dev_ops member needs ethdev maintainer agreement.
Patch 9: The "used" count is per-port but the API name suggests device-wide=
 =E2=80=94 consider renaming or iterating all ports on the shared context.

