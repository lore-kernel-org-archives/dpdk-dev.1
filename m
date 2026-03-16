Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29A1F53D69
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 15:46:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C42F74025E;
	Mon, 16 Mar 2026 16:45:59 +0100 (CET)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 55D8C400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 16:45:58 +0100 (CET)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so6645363eec.0
 for <dev@dpdk.org>; Mon, 16 Mar 2026 08:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773675957;
 x=1774280757; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2NlG6KpmeKwT7GKM/BaJFp5Pltbo/c+VRutZJICcygU=;
 b=XhbuBbMA+QBkWBypqo4g+a8MWr27HqlAZdBgp3azp2SEXr/CzO934dut7LbGGYRY81
 Uw/c5SQ5eAc+I1MK0lpq+JP/J2MgRtkYVQV6wlmxsqAqQ9nrKGsPYFMKa3KGoW1ON9ma
 EKmEMtRO29CPz1g6JDi3LsrWm18myAoEA9TGA84UjsCe1lZUB3S0ETRCTCMEtNou/mGn
 TS8zZJZXOgkX6YiAhxZLbnqmoQSU0AuGBXDNTgEnmhw/Dl/YoNSNy/KSreNig54eCowY
 psFWXHrC97a4+//anur3rsjyCikYH/eoV+71c58muB7uPAFsXpmIpIQrvwc4sVXPDh5B
 Rk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773675957; x=1774280757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2NlG6KpmeKwT7GKM/BaJFp5Pltbo/c+VRutZJICcygU=;
 b=TQ6UKrOe6xIPpAU/nSd74YzW5PGqR/cAAFL/6MLZHBfyjVy/SnHdNu3Lx4/W2Lc7U/
 DmWiaUTsF/D5ZFOiJ5zGMugwb0fc1wZYaIdjJhHNU74AOw9tJGtoqNMKXEcq9gx61nfd
 UkFT7r+aK8o4eVH1U95VxHO5IhRSuJ3EWjHn1vt4scvy8Zee34n7R8nuOlBvPzNQYdYP
 AoDfPbLsdswk5ao0GrO0+OyP9KEpmPAtvO9WVxPECm9myYADoGJdLpfMw6PUws71ckyz
 ZMMYQKxVrcEnXRihbQeTeqj3l6PNR/Zfiiz0mt6JikNaV0jJk6vUJiq196uCwRF/Ns82
 9GpA==
X-Gm-Message-State: AOJu0YxcsSLHYeu5DGGDSKbrvF6l8lYVC5XFuI6dnx+a0LaNBEi5IiDz
 WOGxOIY4Ay54SnKfhgxHysGCvBwbVFaRZjlfGIW3R8ulKzRkuQyw8cFPFcc4yejLTQQ=
X-Gm-Gg: ATEYQzxgtGuXhwhgSNAfTVhUjQ2gBoksaJ8db/ddBT+l96qLou3NiqDBcJ9ypz7AKJe
 A0S+cMtGy4SlrUAd9m7yqWsBol0om7pympigtSE6r1b0So3jOG6WP+J8EYMb1jyh+O/60AqNFPM
 XZU8wvLUVGN4Bx4safl2E4EXFqA5jLjLyPb67+CE89mBRT5kLSemvJoWofhXkpe1P48VQda7alI
 PaUja+i28DGpLTgGQexlANtv7xO6HwusprUY5ZoBmRzdc9EgrgeuCWMcGxmrTvmEQz1UaY/JKX6
 +sCSywWuD3QIaNxdH6CDox0PmrIH9wUe4/vi4P1jE0RCIYRz8Qlydwt0Zi71iVaeDzCf1mgR1Iw
 SkLRwcKbGcp33A+2Lne9S+eQSaT7uskggFgBTInSga/ASCoqqYAdpGsn9I7WLm48oefzT+jTWcK
 Mbf+m7KmaH1STNa19EdOD8EuM1yXSxkg/7THs=
X-Received: by 2002:a05:7300:7b90:b0:2ba:a60a:15ef with SMTP id
 5a478bee46e88-2bea54500e2mr5673430eec.1.1773675957046; 
 Mon, 16 Mar 2026 08:45:57 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c0c12fb4a8sm5904531eec.0.2026.03.16.08.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 08:45:56 -0700 (PDT)
Date: Mon, 16 Mar 2026 08:45:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, chenyi221 <chenyi221@huawei.com>
Subject: Re: [V2 0/7] hinic3 change for support new SPx NIC
Message-ID: <20260316084553.0b732977@phoenix.local>
In-Reply-To: <20260316134335.1640-1-wff_light@vip.163.com>
References: <20260131100608.12429-2-wff_light@vip.163.com>
 <20260316134335.1640-1-wff_light@vip.163.com>
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

On Mon, 16 Mar 2026 21:43:22 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> From: chenyi221 <chenyi221@huawei.com>
> 
> Change hinic3 driver to support Huawei new SPx series NIC.
> 
> v2:
> --fix build issues
> 
> Feifei Wang (7):
>   net/hinic3: add support for new SPx series NIC
>   net/hinic3: add enhance cmdq support for new SPx series NIC
>   net/hinic3: use different callback func to split new/old cmdq
>     operations
>   net/hinic3: add fun init ops to support Compact CQE
>   net/hinic3: add rx ops to support Compact CQE
>   net/hinic3: add tx ops to support Compact CQE
>   net/hinic3: use different callback func to support htn fdir
> 
>  drivers/net/hinic3/base/hinic3_cmd.h          |  80 ++-
>  drivers/net/hinic3/base/hinic3_cmdq.c         | 370 ++++------
>  drivers/net/hinic3/base/hinic3_cmdq.h         | 112 ++-
>  drivers/net/hinic3/base/hinic3_cmdq_enhance.c | 111 +++
>  drivers/net/hinic3/base/hinic3_cmdq_enhance.h | 125 ++++
>  drivers/net/hinic3/base/hinic3_csr.h          |  18 +-
>  drivers/net/hinic3/base/hinic3_hw_comm.c      |  15 +-
>  drivers/net/hinic3/base/hinic3_hw_comm.h      |  31 +-
>  drivers/net/hinic3/base/hinic3_hwdev.c        |  13 +-
>  drivers/net/hinic3/base/hinic3_hwdev.h        |  18 +
>  drivers/net/hinic3/base/hinic3_hwif.c         |  10 +-
>  drivers/net/hinic3/base/hinic3_mgmt.c         |   5 +-
>  drivers/net/hinic3/base/hinic3_mgmt.h         |   2 +
>  drivers/net/hinic3/base/hinic3_nic_cfg.c      | 182 ++---
>  drivers/net/hinic3/base/hinic3_nic_cfg.h      |  98 ++-
>  drivers/net/hinic3/base/meson.build           |   1 +
>  drivers/net/hinic3/hinic3_ethdev.c            | 280 ++++++--
>  drivers/net/hinic3/hinic3_ethdev.h            | 120 ++--
>  drivers/net/hinic3/hinic3_fdir.c              | 657 +++++++++++++-----
>  drivers/net/hinic3/hinic3_fdir.h              | 361 ++++++++--
>  drivers/net/hinic3/hinic3_nic_io.c            | 525 ++++++--------
>  drivers/net/hinic3/hinic3_nic_io.h            | 163 ++++-
>  drivers/net/hinic3/hinic3_rx.c                | 265 +++++--
>  drivers/net/hinic3/hinic3_rx.h                | 182 ++++-
>  drivers/net/hinic3/hinic3_tx.c                | 458 ++++++------
>  drivers/net/hinic3/hinic3_tx.h                | 154 +++-
>  .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    | 167 +++++
>  .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |  63 ++
>  drivers/net/hinic3/htn_adapt/meson.build      |   7 +
>  drivers/net/hinic3/meson.build                |   8 +-
>  .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    | 151 ++++
>  .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |  46 ++
>  drivers/net/hinic3/stn_adapt/meson.build      |   7 +
>  33 files changed, 3362 insertions(+), 1443 deletions(-)
>  create mode 100644 drivers/net/hinic3/base/hinic3_cmdq_enhance.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_cmdq_enhance.h
>  create mode 100644 drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c
>  create mode 100644 drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h
>  create mode 100644 drivers/net/hinic3/htn_adapt/meson.build
>  create mode 100644 drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c
>  create mode 100644 drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h
>  create mode 100644 drivers/net/hinic3/stn_adapt/meson.build
> 
> --
> 2.45.1.windows.1
> 

Still lots of things that need to be addressed here.
See the following AI patch review.


Patch 1/7: net/hinic3: add support for new SPx series NIC

HINIC3_DEV_ID_SP230 is defined as 0X0229 with an uppercase X.
Every other hex constant in the file uses lowercase 0x. Should be
0x0229.

HINIC3_DEV_ID_SP920 has no VF counterpart and no entry in
hinic3_is_vf_dev(). Is that intentional?

Patch 2/7: net/hinic3: add enhance cmdq support

The unified cmdq_sync_cmd() retains rte_smp_rmb() which is a
deprecated barrier. Since this function is being rewritten, please
convert to rte_atomic_thread_fence(rte_memory_order_acquire).

HINIC3_CMDQ_BUF_SIZE changed from 2048 to 1024 without any
explanation in the commit message. If existing normal-cmdq commands
relied on the larger buffer this could silently truncate them.

Patch 3/7: net/hinic3: use different callback func to split new/old cmdq operations

The call sites in hinic3_ethdev.c use hinic3_cmdq_get_stn_ops()
and hinic3_cmdq_get_htn_ops() but the actual definitions are
hinic3_nic_cmdq_get_stn_ops() and hinic3_nic_cmdq_get_htn_ops().
This will not link. Patch 4 fixes the call site but each commit
must compile independently.

In htn_adapt/hinic3_htn_cmdq.c the static function
prepare_rss_indir_table_cmd_header() is called before it is
defined, with no forward declaration. This will fail with
-Werror=implicit-function-declaration.

Patch 4/7: net/hinic3: add fun init ops to support Compact CQE

In hinic3_rx_queue_setup(), when ci_mz allocation fails the code
calls hinic3_memzone_free(ci_mz) on a NULL pointer before jumping
to the error label. This call is either a NULL dereference or dead
code and should be removed.

The error-path goto labels in hinic3_func_init() are misordered.
The allocation order is mac_addrs, cmdq_ops, rx_ops, tx_ops,
mc_list but the cleanup labels do not reverse this properly. For
example if cmdq_ops allocation fails, mac_addrs is never freed.
If tx_ops fails, neither cmdq_ops nor mac_addrs are freed. This
leaks memory on every init failure path.

The ternary in hinic3_pf_get_default_cos() assigns
HINIC3_COS_NUM_MAX (8) when NIC_F_HTN_CMDQ is set and
HINIC3_COS_NUM_MAX_HTN (4) when it is not. The naming suggests
this is backwards. Please verify.

Patch 5/7: net/hinic3: add rx ops to support Compact CQE

hinic3_poll_integrated_cqe_rq_empty() uses __atomic_load_n() with
__ATOMIC_ACQUIRE. New code must use rte_atomic_load_explicit()
with rte_memory_order_acquire instead of the GCC built-in.

Patch 7/7: net/hinic3: use different callback func to support htn fdir

Copy-paste bug in hinic3_rss_hash_update() and hinic3_rss_conf_get().
In both functions the else branch has:

    rss_type.ipv6_ext = 0;
    rss_type.ipv6_ext = 0;

The second line should be rss_type.tcp_ipv6_ext = 0. As written
tcp_ipv6_ext is never cleared on non-HTN hardware which will
produce incorrect RSS configuration.
