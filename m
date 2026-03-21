Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9E9109448A
	for <dpdk-dev@archiver.kernel.org>; Sat, 21 Mar 2026 17:32:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 834E7402DB;
	Sat, 21 Mar 2026 18:32:06 +0100 (CET)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id B7AD4402C9
 for <dev@dpdk.org>; Sat, 21 Mar 2026 18:32:04 +0100 (CET)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-1279eced0b9so2205871c88.0
 for <dev@dpdk.org>; Sat, 21 Mar 2026 10:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774114324;
 x=1774719124; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CNP4YohwLu8amjMsEV+Iy6IQ95j93odbSXEg3eedkqs=;
 b=F1xXtpddAKpU1sHXO+PBwhpW9SK0J20+l9TrzvA7ATJD8BpW7aw+L02t0QwQrnQXOA
 bxUVV+JkCiU6YaypfkWZBnofy/WleBbwVO35tmabFZwF+nVOs3gY/HmpvYredvs0G7T+
 ED4QgK6/I6saO8zr0ASR5dz1EycRp+uevBB8J1IhhEUbhmI/LbxVs35sMDzYLrrOAtu6
 qBXwBEPUi7539un/BKrKMmxjwLdoqUQCN1YRRWLABWElvaOLezZi47bMrRaJggLTtb6z
 5EhB/MmybTfX7cPDrfrLPfyxUIRkhNFs3x/+jgVEVZA11RUkeuj8u/pcBoJDDN/aF2jY
 oLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774114324; x=1774719124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CNP4YohwLu8amjMsEV+Iy6IQ95j93odbSXEg3eedkqs=;
 b=b/kp7xI/SrONn15SW20hLJNbUBgc5ZaGayO/LRyBtx98b1GafwrkgkosKzZA67OUIh
 4SKRwRNngHfpUaj3J9IUCJZ6KdGeSv9rL9xkMfM3iYrnkUfrPHKjOn4xh9vNbTV5V5Y5
 l/jR6p5M5xb+6aJofr9zwtovJCEDzwJOOVyDiGf2+d39MWQnfAa6A/Ztc6BUNsnne880
 Yth35QnkAgzrVUlRGpktMehLMu2P0p/d7D5g0xiuEyr2vWbcqMQrKp5t5GNA02SZzIun
 QxyRGz0mM0g6SkoYbBYNb0LgT7VfUOxYkLXrbJTwLsKSQ73csQ7sR67S66lcctMKHlz6
 IpBA==
X-Gm-Message-State: AOJu0YzBYtkMvp/Fw0gQuHsE6nw02ZaeXQrYFWsfaOIVFW9AvbDrvFOu
 S0I6nmgk9p9l+EogYgH1yzWlY4iZMypDnTOdQyLIv16P8Nm9bsF9Ia0EE7aLsYqzBB4=
X-Gm-Gg: ATEYQzykURxqU30NOVOFV4HfrSUDRitsewF+qakKKNkXJd1DaqNWKoVgEUUXTPnLkhE
 H5wESppYPuavYe7X0alu4RRlZ6MBm7PdSZ37wdM7XL3U9rxVsqPBQnqGHgTwUVIs3W6DbrEZIn7
 4Us9KA2Q74O5BemcaNGnhfWQZSU/27qjnWSDlZyFYiS0ye3ehB0GlCpcAk9Jpmhs3+/MovpRCyq
 MxPGZYMB2buTaN9frxBJ9NrcGqNKGqkscPOmTszAXdst3q3kxDtSSXtbgd6Onfo721fKDnK5ipT
 XCwk2kaJ9IuUQV33WMVPqm+VmaNjRmcPk3Tl+JoqoFWhGQQ1Wz/aTWLqmTwRWLjWDWV5SPjIRAH
 IdpbcbGsivzH967irWenptn/wSy6HIgjGnEa7tTUuKU2CioASnFxKcm7CcYJuvXDcARaBy85B3j
 5a86IAvuCR1RAy7b5KAii15yQaIPiWDzMEYjs=
X-Received: by 2002:a05:7022:424:b0:11b:9386:8254 with SMTP id
 a92af1059eb24-12a727038b3mr2961030c88.41.1774114323561; 
 Sat, 21 Mar 2026 10:32:03 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12a733d199asm5443147c88.4.2026.03.21.10.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 10:32:03 -0700 (PDT)
Date: Sat, 21 Mar 2026 10:32:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, chenyi221 <chenyi221@huawei.com>
Subject: Re: [v6 0/7] hinic3 change for support new SPx NIC
Message-ID: <20260321103200.267c3610@phoenix.local>
In-Reply-To: <20260319135220.2390-1-wff_light@vip.163.com>
References: <20260316134335.1640-1-wff_light@vip.163.com>
 <20260319135220.2390-1-wff_light@vip.163.com>
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

On Thu, 19 Mar 2026 21:52:06 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> From: chenyi221 <chenyi221@huawei.com>
> 
> Change hinic3 driver to support Huawei new SPx series NIC.
> 
> v2:
> --fix build issues
> 
> v3:
> --fix community review comments and err reports
> 
> v4:
> --fix rss type assignment error
> 
> v5:
> --fix community ubuntu-22.04-clang err
> 
> v6:
> --fix atomic compilation error
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
>  drivers/net/hinic3/hinic3_ethdev.c            | 279 ++++++--
>  drivers/net/hinic3/hinic3_ethdev.h            | 120 ++--
>  drivers/net/hinic3/hinic3_fdir.c              | 657 +++++++++++++-----
>  drivers/net/hinic3/hinic3_fdir.h              | 361 ++++++++--
>  drivers/net/hinic3/hinic3_nic_io.c            | 525 ++++++--------
>  drivers/net/hinic3/hinic3_nic_io.h            | 163 ++++-
>  drivers/net/hinic3/hinic3_rx.c                | 267 +++++--
>  drivers/net/hinic3/hinic3_rx.h                | 182 ++++-
>  drivers/net/hinic3/hinic3_tx.c                | 456 ++++++------
>  drivers/net/hinic3/hinic3_tx.h                | 154 +++-
>  .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    | 167 +++++
>  .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |  63 ++
>  drivers/net/hinic3/htn_adapt/meson.build      |   7 +
>  drivers/net/hinic3/meson.build                |   8 +-
>  .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    | 151 ++++
>  .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |  46 ++
>  drivers/net/hinic3/stn_adapt/meson.build      |   7 +
>  33 files changed, 3362 insertions(+), 1442 deletions(-)
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

Looks good, only minor feedback from AI to address.

---

The V6 series fixes most issues from the V2 review: the uppercase hex `0X0229` is corrected, `rte_smp_rmb()` is replaced with `rte_atomic_thread_fence(rte_memory_order_acquire)`, the `__atomic_load_n()` GCC built-in is gone, the `hinic3_memzone_free(ci_mz)` on NULL is removed, the error-path labels in `hinic3_func_init()` are now correctly ordered, the `cos_num_max` ternary logic is fixed, and the `HINIC3_CMDQ_BUF_SIZE` change is documented. Two issues remain:

---

Patch 3/7: net/hinic3: use different callback func to split new/old cmdq operations

The call sites use `hinic3_cmdq_get_stn_ops()` and
`hinic3_cmdq_get_htn_ops()` but the definitions in stn_adapt/
and htn_adapt/ are `hinic3_nic_cmdq_get_stn_ops()` and
`hinic3_nic_cmdq_get_htn_ops()`. The header declarations also
use the short names without `_nic_`. Patch 4 fixes the call
sites but each commit must compile independently. Please either
use consistent names from the start in patch 3 or squash the
fix into this patch.

Patch 7/7: net/hinic3: use different callback func to support htn fdir

The copy-paste bug in `hinic3_rss_hash_update()` was fixed but the
same bug persists in `hinic3_rss_conf_get()`. The else branch still
has:

    rss_type.ipv6_ext = 0;
    rss_type.ipv6_ext = 0;

The second line should be `rss_type.tcp_ipv6_ext = 0`.


