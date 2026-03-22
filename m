Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5ECFC72C4
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Mar 2026 16:32:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACE33402EE;
	Sun, 22 Mar 2026 17:32:27 +0100 (CET)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by mails.dpdk.org (Postfix) with ESMTP id 27B92402CC
 for <dev@dpdk.org>; Sun, 22 Mar 2026 17:32:25 +0100 (CET)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-128e4d0cc48so2143455c88.1
 for <dev@dpdk.org>; Sun, 22 Mar 2026 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774197144;
 x=1774801944; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6URVqu6072UJhzPtfdkdROb17Tf8yizsYhlNtDrqLH8=;
 b=z+qfcdtttPEzi5OJ6+4WuSJ/jVm0UeKB0S7Lz+fQpDEpDPMtXMmRUCL0zS2AtZk8Sv
 5oSinOeOV/rxKzINwe0S07gtAalmMcv+qyAaavqw4sWkAV6r0MwGi6g+kZChdw69dLYe
 NYt2r9QvXvVYFCU5oi0TjRbO9Rp4h/0We8gjMeE4zkj5yOHSCv84VNXrEFPh1Zp/cOpu
 3RF5MbtpIaytvQNExtlzWI/I5tpDXPUqC7YkAANVMUsYl+7r54jZxduhUPyNMkKeLDd5
 51RsqTP8sR/k9BtDj2yA8hE3iP3Zun3E4kJckuXKINAK0Untsn1BjNLFA7Ry4sVUa9cT
 +Vpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774197144; x=1774801944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6URVqu6072UJhzPtfdkdROb17Tf8yizsYhlNtDrqLH8=;
 b=gxOodKwzzdEuotHVcK1BI8d8U+xm5WSqFmLemN9dFTHF58tq0iTPojav3S4DazASvO
 I6zHBlpemeCO3CevuLLdk2jG/z/KUiLtoP6Ku9KMIxg0p4S6wWiOze5rXV0aNHA3wZlf
 Idd/+s/U2gexp6lWZXb5Z+qhYcFHBgdj4+rgnVVnTZOYqYlpZnbBndObG8CVnWHakGeR
 Wbft+sMYXpCI1A5dFBoxByusGiqKXOI/WNRQFeBmXaYRv6yVOayTLstqf3RiJT546cFd
 Dl8yUr3r8bBSZ30CUqC3PQz2K9WqI8A7uLQY4fLQTTuMUoGsCt9jTR9lzlS+XoLmky79
 NdbQ==
X-Gm-Message-State: AOJu0YwD1tbLWbzoSAZbuKbE8+98g7JDqcyGztph8mhJRNqGXfB/ptli
 aiIhBdAQqLzWq+wYLarXrMsLtHCn0za+/RhMAD2dp3lZN96xggQgY9RxjNf1LM1G2J4=
X-Gm-Gg: ATEYQzz0RPxFsewo5TC4cwzaIn2DeTS9KWm+KDv4xko7g2GmgE6L81vayL8bhbPr45V
 8sbX4oAVIiV39qEiHmtalx7L6CvAeVVj3op0gNyPKAOQRQQy+dx81wd3EEQvRz++Y5jsU+VgaUU
 5iO4fFoC8B5wi9TBG86D+e0W6Si2Q4uAtZqiBEylpizOy3euxd/HJDkfxrmf6JXiwOjPbxNzN4a
 GQNpM0P8GsNAitQPkHgF2XBMUi/KZoKata+/nPEAzom2yuL5tKQ1Xw/Qxx8B/cz5Ef7AQSh+ysG
 OejOC1xT6G+broz92Vx8i7WZ3RKckb9UuRepy1T5Pii2yOHlu7OLsDjDWCbFaxIlQLQzvdIRIR1
 h9C9xiE12/xqTXypWMnzED6kZBwUVjYRu9WW0dIKkLViVaQTUtStImipSz4Dk8+pIwJOCkYxFbc
 Pv3Tcd71gygh1SoRelLZiFtm8NnBc3HywoL/Y=
X-Received: by 2002:a05:7300:f68c:b0:2c0:d233:d7c0 with SMTP id
 5a478bee46e88-2c1096d532dmr3571704eec.21.1774197143933; 
 Sun, 22 Mar 2026 09:32:23 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29c74bsm10402335eec.17.2026.03.22.09.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 09:32:23 -0700 (PDT)
Date: Sun, 22 Mar 2026 09:32:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, chenyi221 <chenyi221@huawei.com>
Subject: Re: [v6 0/7] hinic3 change for support new SPx NIC
Message-ID: <20260322093218.0b349797@phoenix.local>
In-Reply-To: <20260319135220.2390-1-wff_light@vip.163.com>
References: <20260316134335.1640-1-wff_light@vip.163.com>
 <20260319135220.2390-1-wff_light@vip.163.com>
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

On Thu, 19 Mar 2026 21:52:06 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> From: chenyi221 <chenyi221@huawei.com>
>=20
> Change hinic3 driver to support Huawei new SPx series NIC.
>=20
> v2:
> --fix build issues
>=20
> v3:
> --fix community review comments and err reports
>=20
> v4:
> --fix rss type assignment error
>=20
> v5:
> --fix community ubuntu-22.04-clang err
>=20
> v6:
> --fix atomic compilation error
>=20
> Feifei Wang (7):
>   net/hinic3: add support for new SPx series NIC
>   net/hinic3: add enhance cmdq support for new SPx series NIC
>   net/hinic3: use different callback func to split new/old cmdq
>     operations
>   net/hinic3: add fun init ops to support Compact CQE
>   net/hinic3: add rx ops to support Compact CQE
>   net/hinic3: add tx ops to support Compact CQE
>   net/hinic3: use different callback func to support htn fdir
>=20
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
>=20
> --
> 2.45.1.windows.1
>=20
>=20

You should also check and update the documentation.

Full list found by AI.

New capabilities added by the patches with no corresponding documentation:

New device IDs =E2=80=94 SP230 (0x0229/0x3750) and SP920 (0x0224) are added=
 in patch 1, but hinic3.rst is not updated to list the new adapter models. =
The existing text just says "SPx series" which is vague enough to arguably =
cover it, but specific model names would be helpful.
GENEVE tunnel TSO =E2=80=94 Patch 4/6 adds RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TS=
O to tx_offload_capa when NIC_F_GENEVE_OFFLOAD is set. The features matrix =
hinic3.ini does not have a GENEVE tunnel TSO entry, nor does it list geneve=
 under [rte_flow items].
IP-in-IP tunnel TSO =E2=80=94 Patch 4/6 adds RTE_ETH_TX_OFFLOAD_IPIP_TNL_TS=
O. Not reflected in hinic3.ini.
VXLAN-GPE tunnel support =E2=80=94 Patch 6 adds HINIC3_PKT_TX_TUNNEL_VXLAN_=
GPE handling in the TX path. Not in hinic3.ini.
Outer UDP checksum =E2=80=94 Patch 6 adds RTE_MBUF_F_TX_OUTER_UDP_CKSUM sup=
port. Not in hinic3.ini.
QinQ / double VLAN =E2=80=94 Patch 4 adds HINIC3_PKT_TX_QINQ_PKT (mapped to=
 RTE_MBUF_F_TX_QINQ). Not in hinic3.ini (QinQ offload is available in defau=
lt.ini but not set for hinic3).
Release notes =E2=80=94 Adding support for new NIC hardware (SP230, SP920) =
and new offload features (GENEVE TSO, IP-in-IP TSO) should be mentioned in =
the current release notes file.

Features already documented that are unchanged (no action needed):
The existing features in hinic3.ini =E2=80=94 RSS, TSO, LRO, VLAN filter, c=
hecksum offloads, scattered Rx, promiscuous/allmulticast, Inner L3/L4 check=
sum, vxlan flow item =E2=80=94 all remain correct. The series does not remo=
ve any existing capability.
Summary for mailing list:
The series adds new device support (SP230, SP920) and new offload capabilit=
ies (GENEVE tunnel TSO, IP-in-IP tunnel TSO, VXLAN-GPE, outer UDP checksum,=
 QinQ) but includes no documentation updates. Please update doc/guides/nics=
/features/hinic3.ini and the release notes to reflect the new hardware and =
offload capabilities.
