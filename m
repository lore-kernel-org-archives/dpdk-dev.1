Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3A6C021A6
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 19:52:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC4E640263;
	Thu, 13 Feb 2025 20:52:31 +0100 (CET)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 06E354003C
 for <dev@dpdk.org>; Thu, 13 Feb 2025 20:52:30 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-220ecbdb4c2so2193105ad.3
 for <dev@dpdk.org>; Thu, 13 Feb 2025 11:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739476350;
 x=1740081150; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2DqYeC5iMmRN+Sm963ihvzvU7tJlCamUS1CWkSgYn20=;
 b=nqtlwVkIBp4UFKX/uype/m57Hj1xZjNxJkd9/Wm8VmCY/27K2xegZDofGpn/rxUx13
 R0jN1PGn4eC74L6qtRtq7m+xQqjMvx0bw9O2vVgzXABziRot8hq9y9xruM+OcdJW0xDv
 BBeqtrPQMG1o+FZCXSgtr7BH8j9ALU1mYHun4fHV++pYIws9qlcDq3on4Ps8TJlmc6c/
 xuqE0zq8uR0eRuJlaLAI5YoPwf9Y3wjjyqGdigLZkUJ8HUMT0JjCxONBgR+lWeB8vZSX
 Z6B0+Qx85W7Skh1qDPiaHIYgnXev5D17ar8ss4YWgoIjbFq0VqaY5OGIBXjbyeAprhwi
 A5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739476350; x=1740081150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2DqYeC5iMmRN+Sm963ihvzvU7tJlCamUS1CWkSgYn20=;
 b=HQa2gNn2WExYZuloSycUXGNHxxbgCYTFuqJtoSCqJUv+9QldLq0GZykno5FFnLeT9y
 0kuEoNbPswKS6OoFwNTN/8prw92AkYTvn1QyWsQ4BQ9Bx2D6RxKFxZfZ0WNec+2upjQz
 vrZ2m1XH8q1Nv9chKrZjripe667PZ82do3pxf1x8J91z56+Jmwz44FrkKVD8DHg8ziKm
 VKasV/OjYHChC9DgnG1Q8/heJ60WIOeWAp6/xq1hwUU4OdxQug2vpn9dD2wyf6T0QoLY
 s1xr2iGQrEntMXf2wfSfnmz8c2xEfOS3t/WG+GXpCUdPj4dfBlymz3yVJ3FxOvbXeY1b
 1cCQ==
X-Gm-Message-State: AOJu0Yw6ib0K2rUFNYKxXb/vix3KlGiQ0xa8X2RraVhiQtSiPt8ylPpT
 aZ5pJoeKOsgV4TbRUY/7L2Y0CErpGdn4dHSPck/RPsfTVSXy4Uz0nuayonvoqXQzt4bW6KitYJJ
 x
X-Gm-Gg: ASbGncsGAh02Mb6652TVAPwZ2R7LHkKRwI5yANn+r37gXH+TYl9IYB34RWezEUU1SeZ
 JSVyX8ce4bzaF3hN1YporJZuC/TVC3rJ3hnMRmE8a7R9sJn4GZhfaafMn1FJ9KdxHKssnapK/4m
 t6kaIJRhJZtwJWHam/hwnPQNkaMkLgpcSU0RGNx60tFKfBJzRSuzcK4q2ChTyDWKJr5t9UTRei4
 NgrI3TxfkQCzOtorTZvhGfj9j+EU3VXQS7PxTvZ6UzECo6H46LQ6rMrGaOmCoY7TXy4aZy8V/hu
 hhDx88p3AvYlnqCM4nIhiRn11EdOe/f208AfrBv/QXGyZG0EbumWlUUFW2W8VWMWF2q/
X-Google-Smtp-Source: AGHT+IFjzu5ZKCZtLBE+7IVBaPi5urxgs92Xb02uVGJSnnLFiHe35LFam5C4ZhVDoW8hRchb4Iu82Q==
X-Received: by 2002:a17:902:ea02:b0:21f:135e:76bf with SMTP id
 d9443c01a7336-220bbb210abmr138754845ad.12.1739476349922; 
 Thu, 13 Feb 2025 11:52:29 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d072sm16044465ad.107.2025.02.13.11.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 11:52:29 -0800 (PST)
Date: Thu, 13 Feb 2025 11:52:25 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 00/16] net/zxdh: updated net zxdh driver
Message-ID: <20250213115225.659a26cb@hermes.local>
In-Reply-To: <20250213064134.88166-1-wang.junlong1@zte.com.cn>
References: <20250121034433.3033681-2-wang.junlong1@zte.com.cn>
 <20250213064134.88166-1-wang.junlong1@zte.com.cn>
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

On Thu, 13 Feb 2025 14:41:16 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> V1:
>   - updated net zxdh driver.
>     optimize init and some ops.
>     provided csum/lro/tso =E3=80=81extend stats=E3=80=81fw_version=E3=80=
=81module_info =E3=80=81meter, etc.
>=20
> Junlong Wang (16):
>   net/zxdh: optimize np dtb channel initialization
>   net/zxdh: optimize queue res alloc/free process
>   net/zxdh: optimize link update process
>   net/zxdh: update rx/tx to latest
>   net/zxdh: provided msg(pfvf) intr callback
>   net/zxdh: optimize mac ops
>   net/zxdh: optimize promisc ops
>   net/zxdh: optimize vlan filter/offload ops
>   net/zxdh: optimize rss hash config/update,reta update/get
>   net/zxdh: optimize mtu set ops
>   net/zxdh: optimize basic stats ops
>   net/zxdh: provided csum/tso/lro config
>   net/zxdh: provided rxq/txq info get implementations
>   net/zxdh: provide extended stats ops implementations
>   net/zxdh: provide ptypes fw_version module info/eeprom ops
>   net/zxdh: provide meter ops implementations
>=20
>  doc/guides/nics/features/zxdh.ini  |    8 +
>  doc/guides/nics/zxdh.rst           |    5 +
>  drivers/net/zxdh/meson.build       |    1 +
>  drivers/net/zxdh/zxdh_common.c     |   48 +-
>  drivers/net/zxdh/zxdh_common.h     |    3 +
>  drivers/net/zxdh/zxdh_ethdev.c     |  660 ++++++++++++---
>  drivers/net/zxdh/zxdh_ethdev.h     |   63 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.c |  906 ++++++++++++++++++---
>  drivers/net/zxdh/zxdh_ethdev_ops.h |   53 +-
>  drivers/net/zxdh/zxdh_msg.c        |  940 ++++++++++++++++++++-
>  drivers/net/zxdh/zxdh_msg.h        |  112 ++-
>  drivers/net/zxdh/zxdh_mtr.c        | 1223 ++++++++++++++++++++++++++++
>  drivers/net/zxdh/zxdh_mtr.h        |  114 +++
>  drivers/net/zxdh/zxdh_np.c         |  728 +++++++++++++++++
>  drivers/net/zxdh/zxdh_np.h         |  262 ++++++
>  drivers/net/zxdh/zxdh_pci.c        |   10 -
>  drivers/net/zxdh/zxdh_queue.c      |  132 +--
>  drivers/net/zxdh/zxdh_queue.h      |  118 +--
>  drivers/net/zxdh/zxdh_rxtx.c       |  696 +++++++++-------
>  drivers/net/zxdh/zxdh_rxtx.h       |   27 +
>  drivers/net/zxdh/zxdh_tables.c     |  378 +++++++--
>  drivers/net/zxdh/zxdh_tables.h     |  206 +++--
>  22 files changed, 5890 insertions(+), 803 deletions(-)
>  create mode 100644 drivers/net/zxdh/zxdh_mtr.c
>  create mode 100644 drivers/net/zxdh/zxdh_mtr.h
>=20

When doing follow on patches go ahead start a new mail thread.
It gets confusing if all patches are chained of initial version that was me=
rged.

Review checklist for updated zxdh driver - lots of small things

Some of these problems are pre-existing problems that should have been
caught in last review cycle.

Mark items with:
    =E2=9C=94 passed
    =E2=9C=98 Failed

Basic hygiene
    =E2=9C=98 Look at CI results in patchwork

    =E2=9C=94 Merge cleanly with git am; look for missing newline at EOF etc

    =E2=9C=98 Run checkpatches; warnings are ok, but look more carefully.
    Spelling errors, and C99 // comments need to be fixed

    =E2=9C=98 Run check-git-log; should fix
Wrong headline format:
	net/zxdh: optimize rss hash config/update, reta update/get
	net/zxdh: provide ptypes fw_version module info/eeprom ops
Wrong headline case:
			"net/zxdh: provide ptypes fw_version module info/eeprom ops": eeprom -->=
 EEPROM
Wrong headline case:
			"net/zxdh: provided csum/tso/lro config": lro --> LRO
Wrong headline case:
			"net/zxdh: optimize mac ops": mac --> MAC
Wrong headline case:
			"net/zxdh: optimize mtu set ops": mtu --> MTU
Wrong headline case:
			"net/zxdh: optimize rss hash config/update, reta update/get": reta --> R=
ETA
Wrong headline case:
			"net/zxdh: optimize rss hash config/update, reta update/get": rss --> RSS
Wrong headline case:
			"net/zxdh: update rx/tx to latest": rx --> Rx
Wrong headline case:
			"net/zxdh: provided csum/tso/lro config": tso --> TSO
Wrong headline case:
			"net/zxdh: update rx/tx to latest": tx --> Tx
Wrong headline case:
			"net/zxdh: optimize vlan filter/offload ops": vlan --> VLAN

    =E2=9C=94 Run check-symbol-maps.sh
    =E2=9C=98 Run check-doc-vs-code
rte_flow doc out of sync for zxdh
	action drop

    =E2=9C=94 Run check-spdk-tag

Builds
    =E2=9C=94 Use latest experimental Gcc 15 to catch new warnings
    =E2=9C=94 Clang build using current version (clang-19)
    =E2=9C=94 Doc build

    Enable asserts
    $ meson setup '-Dc_args=3D'-DRTE_ENABLE_ASSERT -DRTE_LIBRTE_ETHDEV_DEBU=
G=3D1' build

    Test meson builds

Experimental builds:
    =E2=9C=98 Enable address sanitizer
[1612/3246] Compiling C object drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxd=
h_np.c.o
In function =E2=80=98zxdh_np_dtb_smmu0_write_entry_data=E2=80=99,
    inlined from =E2=80=98zxdh_np_dtb_se_smmu0_ind_write=E2=80=99 at ../dri=
vers/net/zxdh/zxdh_np.c:1113:7,
    inlined from =E2=80=98zxdh_np_dtb_eram_one_entry=E2=80=99 at ../drivers=
/net/zxdh/zxdh_np.c:1201:8,
    inlined from =E2=80=98zxdh_np_dtb_table_entry_write=E2=80=99 at ../driv=
ers/net/zxdh/zxdh_np.c:1473:9:
../drivers/net/zxdh/zxdh_np.c:75:12: warning: =E2=80=98rc=E2=80=99 may be u=
sed uninitialized [-Wmaybe-uninitialized]
   75 |         if ((rc) !=3D 0) {\
      |            ^
../drivers/net/zxdh/zxdh_np.c:1052:17: note: in expansion of macro =E2=80=
=98ZXDH_COMM_CHECK_RC_NO_ASSERT=E2=80=99
 1052 |                 ZXDH_COMM_CHECK_RC_NO_ASSERT(rc, "dpp_dtb_write_tab=
le_cmd");
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_np.c: In function =E2=80=98zxdh_np_dtb_table_entry=
_write=E2=80=99:
../drivers/net/zxdh/zxdh_np.c:984:26: note: =E2=80=98rc=E2=80=99 was declar=
ed here
  984 |         uint32_t         rc;
      |                          ^~

    =E2=9C=98 Enable extra warnings (edit meson.build) for
        -Wvla, -Wformat-truncation, -Waddress-of-packed-member
[1616/3247] Compiling C object drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxd=
h_mtr.c.o
../drivers/net/zxdh/zxdh_mtr.c: In function =E2=80=98zxdh_mtr_hw_counter_qu=
ery=E2=80=99:
../drivers/net/zxdh/zxdh_mtr.c:454:55: warning: taking address of packed me=
mber of =E2=80=98union <anonymous>=E2=80=99 may result in an unaligned poin=
ter value [-Waddress-of-packed-member]
  454 |                 struct zxdh_mtr_stats *hw_mtr_stats =3D &reply_info=
.reply_body.hw_mtr_stats;
      |                                                       ^~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~
[1620/3247] Compiling C object drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxd=
h_ethdev_ops.c.o
../drivers/net/zxdh/zxdh_ethdev_ops.c: In function =E2=80=98zxdh_dev_xstats=
_get_names=E2=80=99:
../drivers/net/zxdh/zxdh_ethdev_ops.c:1983:26: warning: =E2=80=98%s=E2=80=
=99 directive output may be truncated writing up to 1359 bytes into a regio=
n of size 64 [-Wformat-truncation=3D]
 1983 |                         "%s", zxdh_np_stat_strings[i].name);
      |                          ^~
../drivers/net/zxdh/zxdh_ethdev_ops.c:1982:25: note: =E2=80=98snprintf=E2=
=80=99 output between 1 and 1360 bytes into a destination of size 64
 1982 |                         snprintf(xstats_names[count].name, sizeof(x=
stats_names[count].name),
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~
 1983 |                         "%s", zxdh_np_stat_strings[i].name);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_ethdev_ops.c:1989:34: warning: =E2=80=98%s=E2=80=
=99 directive output may be truncated writing up to 2991 bytes into a regio=
n of size 64 [-Wformat-truncation=3D]
 1989 |                                 "%s", zxdh_mac_stat_strings[i].name=
);
      |                                  ^~
../drivers/net/zxdh/zxdh_ethdev_ops.c:1988:33: note: =E2=80=98snprintf=E2=
=80=99 output between 1 and 2992 bytes into a destination of size 64
 1988 |                                 snprintf(xstats_names[count].name, =
sizeof(xstats_names[count].name),
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1989 |                                 "%s", zxdh_mac_stat_strings[i].name=
);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_ethdev_ops.c:1994:34: warning: =E2=80=98%s=E2=80=
=99 directive output may be truncated writing up to 271 bytes into a region=
 of size 64 [-Wformat-truncation=3D]
 1994 |                                 "%s", zxdh_mac_bytes_strings[i].nam=
e);
      |                                  ^~
../drivers/net/zxdh/zxdh_ethdev_ops.c:1993:33: note: =E2=80=98snprintf=E2=
=80=99 output between 1 and 272 bytes into a destination of size 64
 1993 |                                 snprintf(xstats_names[count].name, =
sizeof(xstats_names[count].name),
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1994 |                                 "%s", zxdh_mac_bytes_strings[i].nam=
e);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
../drivers/net/zxdh/zxdh_ethdev_ops.c:2000:26: warning: =E2=80=98%s=E2=80=
=99 directive output may be truncated writing up to 339 bytes into a region=
 of size 64 [-Wformat-truncation=3D]
 2000 |                         "%s", zxdh_vqm_stat_strings[i].name);
      |                          ^~
../drivers/net/zxdh/zxdh_ethdev_ops.c:1999:25: note: =E2=80=98snprintf=E2=
=80=99 output between 1 and 340 bytes into a destination of size 64
 1999 |                         snprintf(xstats_names[count].name, sizeof(x=
stats_names[count].name),
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~
 2000 |                         "%s", zxdh_vqm_stat_strings[i].name);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_ethdev_ops.c:2010:41: warning: =E2=80=98%s=E2=80=
=99 directive output may be truncated writing up to 1359 bytes into a regio=
n of size between 54 and 58 [-Wformat-truncation=3D]
 2010 |                                 "rx_q%u_%s", i, zxdh_rxq_stat_strin=
gs[t].name);
      |                                         ^~
../drivers/net/zxdh/zxdh_ethdev_ops.c:2009:33: note: =E2=80=98snprintf=E2=
=80=99 output between 7 and 1370 bytes into a destination of size 64
 2009 |                                 snprintf(xstats_names[count].name, =
sizeof(xstats_names[count].name),
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2010 |                                 "rx_q%u_%s", i, zxdh_rxq_stat_strin=
gs[t].name);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~
../drivers/net/zxdh/zxdh_ethdev_ops.c:2022:41: warning: =E2=80=98%s=E2=80=
=99 directive output may be truncated writing up to 1291 bytes into a regio=
n of size between 54 and 58 [-Wformat-truncation=3D]
 2022 |                                 "tx_q%u_%s", i, zxdh_txq_stat_strin=
gs[t].name);
      |                                         ^~
../drivers/net/zxdh/zxdh_ethdev_ops.c:2021:33: note: =E2=80=98snprintf=E2=
=80=99 output between 7 and 1302 bytes into a destination of size 64
 2021 |                                 snprintf(xstats_names[count].name, =
sizeof(xstats_names[count].name),
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2022 |                                 "tx_q%u_%s", i, zxdh_txq_stat_strin=
gs[t].name);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~
[1625/3247] Compiling C object drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxd=
h_msg.c.o
../drivers/net/zxdh/zxdh_msg.c: In function =E2=80=98zxdh_add_vf_mac_table=
=E2=80=99:
../drivers/net/zxdh/zxdh_msg.c:1372:39: warning: taking address of packed m=
ember of =E2=80=98struct zxdh_mac_filter=E2=80=99 may result in an unaligne=
d pointer value [-Waddress-of-packed-member]
 1372 |         struct rte_ether_addr *addr =3D &mac_filter->mac;
      |                                       ^~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c: In function =E2=80=98zxdh_del_vf_mac_table=
=E2=80=99:
../drivers/net/zxdh/zxdh_msg.c:1425:45: warning: taking address of packed m=
ember of =E2=80=98struct zxdh_mac_filter=E2=80=99 may result in an unaligne=
d pointer value [-Waddress-of-packed-member]
 1425 |         ret =3D zxdh_del_mac_table(hw, vport, &mac_filter->mac, hw-=
>hash_search_index, 0, 0);
      |                                             ^~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1436:74: warning: taking address of packed m=
ember of =E2=80=98struct zxdh_mac_filter=E2=80=99 may result in an unaligne=
d pointer value [-Waddress-of-packed-member]
 1436 |                 if (rte_is_same_ether_addr(&hw->vfinfo[vf_id].vf_ma=
c[i], &mac_filter->mac))
      |                                                                    =
      ^~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c: In function =E2=80=98zxdh_vf_np_stats_updat=
e=E2=80=99:
../drivers/net/zxdh/zxdh_msg.c:1744:28: warning: taking address of packed m=
ember of =E2=80=98union <anonymous>=E2=80=99 may result in an unaligned poi=
nter value [-Waddress-of-packed-member]
 1744 |         zxdh_data_hi_to_lo(&res_info->np_stats.tx_unicast_pkts);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1745:28: warning: taking address of packed m=
ember of =E2=80=98union <anonymous>=E2=80=99 may result in an unaligned poi=
nter value [-Waddress-of-packed-member]
 1745 |         zxdh_data_hi_to_lo(&res_info->np_stats.tx_unicast_bytes);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1755:28: warning: taking address of packed m=
ember of =E2=80=98union <anonymous>=E2=80=99 may result in an unaligned poi=
nter value [-Waddress-of-packed-member]
 1755 |         zxdh_data_hi_to_lo(&res_info->np_stats.rx_unicast_pkts);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1756:28: warning: taking address of packed m=
ember of =E2=80=98union <anonymous>=E2=80=99 may result in an unaligned poi=
nter value [-Waddress-of-packed-member]
 1756 |         zxdh_data_hi_to_lo(&res_info->np_stats.rx_unicast_bytes);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1765:28: warning: taking address of packed m=
ember of =E2=80=98union <anonymous>=E2=80=99 may result in an unaligned poi=
nter value [-Waddress-of-packed-member]
 1765 |         zxdh_data_hi_to_lo(&res_info->np_stats.tx_multicast_pkts);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1766:28: warning: taking address of packed m=
ember of =E2=80=98union <anonymous>=E2=80=99 may result in an unaligned poi=
nter value [-Waddress-of-packed-member]
 1766 |         zxdh_data_hi_to_lo(&res_info->np_stats.tx_multicast_bytes);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1776:28: warning: taking address of packed m=
ember of =E2=80=98union <anonymous>=E2=80=99 may result in an unaligned poi=
nter value [-Waddress-of-packed-member]
 1776 |         zxdh_data_hi_to_lo(&res_info->np_stats.rx_multicast_pkts);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1777:28: warning: taking address of packed m=
ember of =E2=80=98union <anonymous>=E2=80=99 may result in an unaligned poi=
nter value [-Waddress-of-packed-member]
 1777 |         zxdh_data_hi_to_lo(&res_info->np_stats.rx_multicast_bytes);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1786:28: warning: taking address of packed m=
ember of =E2=80=98union <anonymous>=E2=80=99 may result in an unaligned poi=
nter value [-Waddress-of-packed-member]
 1786 |         zxdh_data_hi_to_lo(&res_info->np_stats.tx_broadcast_pkts);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1787:28: warning: taking address of packed m=
ember of =E2=80=98union <anonymous>=E2=80=99 may result in an unaligned poi=
nter value [-Waddress-of-packed-member]
 1787 |         zxdh_data_hi_to_lo(&res_info->np_stats.tx_broadcast_bytes);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1797:28: warning: taking address of packed m=
ember of =E2=80=98union <anonymous>=E2=80=99 may result in an unaligned poi=
nter value [-Waddress-of-packed-member]
 1797 |         zxdh_data_hi_to_lo(&res_info->np_stats.rx_broadcast_pkts);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1798:28: warning: taking address of packed m=
ember of =E2=80=98union <anonymous>=E2=80=99 may result in an unaligned poi=
nter value [-Waddress-of-packed-member]
 1798 |         zxdh_data_hi_to_lo(&res_info->np_stats.rx_broadcast_bytes);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1810:28: warning: taking address of packed m=
ember of =E2=80=98union <anonymous>=E2=80=99 may result in an unaligned poi=
nter value [-Waddress-of-packed-member]
 1810 |         zxdh_data_hi_to_lo(&res_info->np_stats.tx_mtu_drop_pkts);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1811:28: warning: taking address of packed m=
ember of =E2=80=98union <anonymous>=E2=80=99 may result in an unaligned poi=
nter value [-Waddress-of-packed-member]
 1811 |         zxdh_data_hi_to_lo(&res_info->np_stats.tx_mtu_drop_bytes);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1823:28: warning: taking address of packed m=
ember of =E2=80=98union <anonymous>=E2=80=99 may result in an unaligned poi=
nter value [-Waddress-of-packed-member]
 1823 |         zxdh_data_hi_to_lo(&res_info->np_stats.rx_mtu_drop_pkts);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1824:28: warning: taking address of packed m=
ember of =E2=80=98union <anonymous>=E2=80=99 may result in an unaligned poi=
nter value [-Waddress-of-packed-member]
 1824 |         zxdh_data_hi_to_lo(&res_info->np_stats.rx_mtu_drop_bytes);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1836:28: warning: taking address of packed m=
ember of =E2=80=98union <anonymous>=E2=80=99 may result in an unaligned poi=
nter value [-Waddress-of-packed-member]
 1836 |         zxdh_data_hi_to_lo(&res_info->np_stats.tx_mtr_drop_pkts);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1837:28: warning: taking address of packed m=
ember of =E2=80=98union <anonymous>=E2=80=99 may result in an unaligned poi=
nter value [-Waddress-of-packed-member]
 1837 |         zxdh_data_hi_to_lo(&res_info->np_stats.tx_mtr_drop_bytes);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1849:28: warning: taking address of packed m=
ember of =E2=80=98union <anonymous>=E2=80=99 may result in an unaligned poi=
nter value [-Waddress-of-packed-member]
 1849 |         zxdh_data_hi_to_lo(&res_info->np_stats.rx_mtr_drop_pkts);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c:1850:28: warning: taking address of packed m=
ember of =E2=80=98union <anonymous>=E2=80=99 may result in an unaligned poi=
nter value [-Waddress-of-packed-member]
 1850 |         zxdh_data_hi_to_lo(&res_info->np_stats.rx_mtr_drop_bytes);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c: In function =E2=80=98zxdh_vf_mtr_hw_stats_g=
et=E2=80=99:
../drivers/net/zxdh/zxdh_msg.c:1878:53: warning: taking address of packed m=
ember of =E2=80=98union <anonymous>=E2=80=99 may result in an unaligned poi=
nter value [-Waddress-of-packed-member]
 1878 |                                 1, idx, (uint32_t *)&res_info->hw_m=
tr_stats);
      |                                                     ^~~~~~~~~~~~~~~=
~~~~~~~~
../drivers/net/zxdh/zxdh_msg.c: In function =E2=80=98zxdh_vf_mtr_hw_profile=
_cfg=E2=80=99:
../drivers/net/zxdh/zxdh_msg.c:2025:54: warning: taking address of packed m=
ember of =E2=80=98struct zxdh_plcr_profile_cfg=E2=80=99 may result in an un=
aligned pointer value [-Waddress-of-packed-member]
 2025 |         union zxdh_offload_profile_cfg *plcr_param =3D &zxdh_plcr_p=
rofile_cfg->plcr_param;
      |                                                      ^~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~
[3246/3247] Linking target app/dpdk-test

Look for anti-patterns:
    =E2=9C=98 Do not put brackets on each switch case.

	switch (opr_mode) {
	case ZXDH_ERAM128_TBL_128b:
	{
		opr_mode =3D ZXDH_ERAM128_OPR_128b;
		break;
	}

     =E2=9C=98 Do not expose unnecessary global symbols
       If DPDK is statically linked these can cause problems.

$ nm build/drivers/librte_net_zxdh.a | grep ' [BDT] ' | grep -v ' zxdh_'
0000000000000120 B g_dev_sd
0000000000014f20 B g_mtr_res
0000000000014920 B g_net_hdr_dl
0000000000000000 D ZXDH_PMD_SHARED_DATA_MZ
0000000000000010 D chan_id_tbl
0000000000000020 D lock_type_tbl
0000000000000000 D subchan_id_tbl
00000000000001c0 B g_dpp_dtb_table_info
0000000000000080 B g_dpp_reg_info
00000000000002a0 D g_nppu_pktrx_cfg_pktrx_glbal_cfg_0_reg
0000000000000070 B g_p_dpp_tlb_mgr
0000000000000000 B g_ppu_cls_bit_map
0000000000001220 B g_ppu_stat_cfg
0000000000000220 B g_sdt_info
0000000000000000 D g_stat_car0_cara_queue_ram0_159_0_reg
00000000000000e0 D g_stat_car0_carb_queue_ram0_159_0_reg
00000000000001c0 D g_stat_car0_carc_queue_ram0_159_0_reg
0000000000000050 B p_dpp_dtb_mgr
0000000000000060 B p_riscv_dtb_queue_mgr

    =E2=9C=98 Apply coccinelle scripts; look that for example null free che=
cks

diff --git a/drivers/net/zxdh/zxdh_ethdev.c b/drivers/net/zxdh/zxdh_ethdev.c
index 2c24e99a77..fd02d97b0d 100644
--- a/drivers/net/zxdh/zxdh_ethdev.c
+++ b/drivers/net/zxdh/zxdh_ethdev.c
@@ -1102,8 +1102,7 @@ zxdh_np_dtb_data_res_free(struct zxdh_hw *hw)
                if (ret)
                        PMD_DRV_LOG(ERR, "%s dpp_np_online_uninstall failed=
", dev->data->name);

-               if (dtb_data->dtb_table_conf_mz)
-                       rte_memzone_free(dtb_data->dtb_table_conf_mz);
+               rte_memzone_free(dtb_data->dtb_table_conf_mz);

                if (dtb_data->dtb_table_dump_mz) {
                        rte_memzone_free(dtb_data->dtb_table_dump_mz);
diff --git a/drivers/net/zxdh/zxdh_np.c b/drivers/net/zxdh/zxdh_np.c
index 926880fd4e..5483abdebe 100644
--- a/drivers/net/zxdh/zxdh_np.c
+++ b/drivers/net/zxdh/zxdh_np.c
@@ -914,8 +914,7 @@ zxdh_np_sdt_mgr_destroy(uint32_t dev_id)
        p_sdt_tbl_temp =3D ZXDH_SDT_SOFT_TBL_GET(dev_id);
        p_sdt_mgr =3D ZXDH_SDT_MGR_PTR_GET();

-       if (p_sdt_tbl_temp !=3D NULL)
-               free(p_sdt_tbl_temp);
+       free(p_sdt_tbl_temp);

        ZXDH_SDT_SOFT_TBL_GET(dev_id) =3D NULL;


    =E2=9C=98 Apply memcpy script for coccinelle
      rte_memcpy should not be used for fixed size values (hides overruns f=
rom checkers)

diff --git a/drivers/net/zxdh/zxdh_ethdev_ops.c b/drivers/net/zxdh/zxdh_eth=
dev_ops.c
index 512e1cce2e..92e12585ca 100644
--- a/drivers/net/zxdh/zxdh_ethdev_ops.c
+++ b/drivers/net/zxdh/zxdh_ethdev_ops.c
@@ -440,7 +440,7 @@ zxdh_dev_mac_addr_set(struct rte_eth_dev *dev, struct r=
te_ether_addr *addr)
 	} else {
 		struct zxdh_mac_filter *mac_filter =3D &msg_info.data.mac_filter_msg;
 		mac_filter->filter_flag =3D ZXDH_MAC_UNFILTER;
-		rte_memcpy(&mac_filter->mac, addr, sizeof(struct rte_ether_addr));
+		memcpy(&mac_filter->mac, addr, sizeof(struct rte_ether_addr));
 		zxdh_msg_head_build(hw, ZXDH_MAC_ADD, &msg_info);
 		ret =3D zxdh_vf_send_msg_to_pf(dev, &msg_info, sizeof(msg_info), NULL, 0=
);
 		if (ret) {
@@ -456,7 +456,8 @@ zxdh_dev_mac_addr_set(struct rte_eth_dev *dev, struct r=
te_ether_addr *addr)

 		mac_filter->filter_flag =3D ZXDH_MAC_UNFILTER;
 		mac_filter->mac_flag =3D true;
-		rte_memcpy(&mac_filter->mac, old_addr, sizeof(struct rte_ether_addr));
+		memcpy(&mac_filter->mac, old_addr,
+		       sizeof(struct rte_ether_addr));
 		zxdh_msg_head_build(hw, ZXDH_MAC_DEL, &msg_info);
 		ret =3D zxdh_vf_send_msg_to_pf(dev, &msg_info, sizeof(msg_info), NULL, 0=
);
 		if (ret) {
@@ -526,7 +527,8 @@ zxdh_dev_mac_addr_add(struct rte_eth_dev *dev, struct r=
te_ether_addr *mac_addr,
 		struct zxdh_mac_filter *mac_filter =3D &msg_info.data.mac_filter_msg;

 		mac_filter->filter_flag =3D ZXDH_MAC_FILTER;
-		rte_memcpy(&mac_filter->mac, mac_addr, sizeof(struct rte_ether_addr));
+		memcpy(&mac_filter->mac, mac_addr,
+		       sizeof(struct rte_ether_addr));
 		zxdh_msg_head_build(hw, ZXDH_MAC_ADD, &msg_info);
 		if (rte_is_unicast_ether_addr(mac_addr)) {
 			if (hw->uc_num < ZXDH_MAX_UC_MAC_ADDRS) {
@@ -1411,7 +1413,8 @@ zxdh_hw_vqm_stats_get(struct rte_eth_dev *dev, enum z=
xdh_agent_msg_type opcode,
 	}
 	struct zxdh_msg_reply_body *reply_body =3D &reply_info.reply_body;

-	rte_memcpy(hw_stats, &reply_body->vqm_stats, sizeof(struct zxdh_hw_vqm_st=
ats));
+	memcpy(hw_stats, &reply_body->vqm_stats,
+	       sizeof(struct zxdh_hw_vqm_stats));
 	return 0;
 }

@@ -1433,8 +1436,10 @@ zxdh_hw_mac_stats_get(struct rte_eth_dev *dev,
 		bytes_addr =3D virt_addr + ZXDH_MAC_BYTES_OFFSET + 32 * 4;
 	}

-	rte_memcpy(mac_stats, (void *)stats_addr, sizeof(struct zxdh_hw_mac_stats=
));
-	rte_memcpy(mac_bytes, (void *)bytes_addr, sizeof(struct zxdh_hw_mac_bytes=
));
+	memcpy(mac_stats, (void *)stats_addr,
+	       sizeof(struct zxdh_hw_mac_stats));
+	memcpy(mac_bytes, (void *)bytes_addr,
+	       sizeof(struct zxdh_hw_mac_bytes));
 	return 0;
 }

diff --git a/drivers/net/zxdh/zxdh_mtr.c b/drivers/net/zxdh/zxdh_mtr.c
index 09e601d336..72dc6124b6 100644
--- a/drivers/net/zxdh/zxdh_mtr.c
+++ b/drivers/net/zxdh/zxdh_mtr.c
@@ -580,9 +580,8 @@ static int zxdh_hw_profile_config(struct rte_eth_dev *d=
ev, uint16_t hw_profile_i
 		zxdh_plcr_profile_cfg->car_type =3D CAR_A;
 		zxdh_plcr_profile_cfg->packet_mode =3D mp->profile.packet_mode;
 		zxdh_plcr_profile_cfg->hw_profile_id =3D hw_profile_id;
-		rte_memcpy(&zxdh_plcr_profile_cfg->plcr_param,
-			&mp->plcr_param,
-			sizeof(zxdh_plcr_profile_cfg->plcr_param));
+		memcpy(&zxdh_plcr_profile_cfg->plcr_param, &mp->plcr_param,
+		       sizeof(zxdh_plcr_profile_cfg->plcr_param));

 		zxdh_msg_head_build(hw, ZXDH_PLCR_CAR_PROFILE_CFG_SET, &msg_info);
 		ret =3D zxdh_vf_send_msg_to_pf(dev,
@@ -675,7 +674,7 @@ zxdh_meter_profile_add(struct rte_eth_dev *dev,
 	mp->meter_profile_id =3D meter_profile_id;
 	mp->dpdk_port_id =3D dev->data->port_id;
 	mp->hw_profile_id =3D UINT16_MAX;
-	rte_memcpy(&mp->profile, profile, sizeof(struct rte_mtr_meter_profile));
+	memcpy(&mp->profile, profile, sizeof(struct rte_mtr_meter_profile));

 	ret =3D zxdh_mtr_profile_offload(dev, mp, profile, error);
 	if (ret) {
@@ -762,7 +761,8 @@ zxdh_meter_policy_add(struct rte_eth_dev *dev,
 	memset(mtr_policy, 0, sizeof(struct zxdh_meter_policy));
 	mtr_policy->policy_id =3D policy_id;
 	mtr_policy->dpdk_port_id =3D dev->data->port_id;
-	rte_memcpy(&mtr_policy->policy, policy, sizeof(struct rte_mtr_meter_polic=
y_params));
+	memcpy(&mtr_policy->policy, policy,
+	       sizeof(struct rte_mtr_meter_policy_params));
 	/* Add to list. */
 	TAILQ_INSERT_TAIL(&zxdh_shared_data->mtr_policy_list, mtr_policy, next);
 	mtr_policy->ref_cnt++;
diff --git a/drivers/net/zxdh/zxdh_tables.c b/drivers/net/zxdh/zxdh_tables.c
index 253d9ce438..092b81b3c8 100644
--- a/drivers/net/zxdh/zxdh_tables.c
+++ b/drivers/net/zxdh/zxdh_tables.c
@@ -252,7 +252,8 @@ zxdh_add_mac_table(struct zxdh_hw *hw, uint16_t vport, =
struct rte_ether_addr *ad
 	uint16_t vfid =3D vport_num.vfid;

 	if (rte_is_unicast_ether_addr(addr)) {
-		rte_memcpy(unicast_table.key.dmac_addr, addr, sizeof(struct rte_ether_ad=
dr));
+		memcpy(unicast_table.key.dmac_addr, addr,
+		       sizeof(struct rte_ether_addr));
 		unicast_table.key.sriov_vlan_tpid =3D srv_tpid;
 		unicast_table.key.sriov_vlan_id =3D srv_vlanid;

@@ -290,8 +291,8 @@ zxdh_add_mac_table(struct zxdh_hw *hw, uint16_t vport, =
struct rte_ether_addr *ad
 	} else {
 		for (group_id =3D 0; group_id < 4; group_id++) {
 			multicast_table.key.vf_group_id =3D group_id;
-			rte_memcpy(multicast_table.key.mac_addr,
-					addr, sizeof(struct rte_ether_addr));
+			memcpy(multicast_table.key.mac_addr, addr,
+			       sizeof(struct rte_ether_addr));
 			ZXDH_DTB_HASH_ENTRY_INFO_T dtb_hash_entry =3D {
 				.p_actu_key =3D (uint8_t *)&multicast_table.key,
 				.p_rst =3D (uint8_t *)&multicast_table.entry
@@ -357,7 +358,8 @@ zxdh_del_mac_table(struct zxdh_hw *hw, uint16_t vport, =
struct rte_ether_addr *ad
 	uint16_t vfid =3D zxdh_vport_to_vfid(port);

 	if (rte_is_unicast_ether_addr(addr)) {
-		rte_memcpy(unicast_table.key.dmac_addr, addr, sizeof(struct rte_ether_ad=
dr));
+		memcpy(unicast_table.key.dmac_addr, addr,
+		       sizeof(struct rte_ether_addr));
 		unicast_table.key.sriov_vlan_id =3D srv_vlanid;
 		unicast_table.key.sriov_vlan_tpid =3D srv_tpid;

@@ -387,7 +389,8 @@ zxdh_del_mac_table(struct zxdh_hw *hw, uint16_t vport, =
struct rte_ether_addr *ad
 		}
 	} else {
 		multicast_table.key.vf_group_id =3D vport_num.vfid / 64;
-		rte_memcpy(multicast_table.key.mac_addr, addr, sizeof(struct rte_ether_a=
ddr));
+		memcpy(multicast_table.key.mac_addr, addr,
+		       sizeof(struct rte_ether_addr));

 		ZXDH_DTB_HASH_ENTRY_INFO_T dtb_hash_entry =3D {
 			.p_actu_key =3D (uint8_t *)&multicast_table.key,
@@ -417,8 +420,8 @@ zxdh_del_mac_table(struct zxdh_hw *hw, uint16_t vport, =
struct rte_ether_addr *ad

 		for (group_id =3D 0; group_id < ZXDH_MC_GROUP_NUM; group_id++) {
 			multicast_table.key.vf_group_id =3D group_id;
-			rte_memcpy(multicast_table.key.mac_addr, addr,
-				sizeof(struct rte_ether_addr));
+			memcpy(multicast_table.key.mac_addr, addr,
+			       sizeof(struct rte_ether_addr));
 			ZXDH_DTB_HASH_ENTRY_INFO_T dtb_hash_entry =3D {
 				.p_actu_key =3D (uint8_t *)&multicast_table.key,
 				.p_rst =3D (uint8_t *)&multicast_table.entry
@@ -442,8 +445,8 @@ zxdh_del_mac_table(struct zxdh_hw *hw, uint16_t vport, =
struct rte_ether_addr *ad
 		if (del_flag) {
 			for (group_id =3D 0; group_id < ZXDH_MC_GROUP_NUM; group_id++) {
 				multicast_table.key.vf_group_id =3D group_id;
-				rte_memcpy(multicast_table.key.mac_addr, addr,
-					sizeof(struct rte_ether_addr));
+				memcpy(multicast_table.key.mac_addr, addr,
+				       sizeof(struct rte_ether_addr));
 				ZXDH_DTB_HASH_ENTRY_INFO_T dtb_hash_entry =3D {
 					.p_actu_key  =3D (uint8_t *)&multicast_table.key,
 					.p_rst =3D (uint8_t *)&multicast_table.entry


    =E2=9C=98 Review use of malloc
An example of unnecessary init and unneccessary cast of void.
	uint32_t *recv_buffer =3D NULL;
...
	recv_buffer =3D (uint32_t *)rte_zmalloc(NULL, rep_len + ZXDH_CHANNEL_REPS_=
LEN, 0);

	uint32_t *profile_id =3D NULL;
...
	profile_id =3D (uint32_t *)rte_zmalloc(NULL, ZXDH_G_PROFILE_ID_LEN, 0);

