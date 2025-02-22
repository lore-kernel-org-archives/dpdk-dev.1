Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F0FC021B2
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 21:42:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 406CC4025E;
	Sat, 22 Feb 2025 22:42:02 +0100 (CET)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2E986400D6
 for <dev@dpdk.org>; Sat, 22 Feb 2025 22:42:01 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-22114b800f7so62642205ad.2
 for <dev@dpdk.org>; Sat, 22 Feb 2025 13:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740260520;
 x=1740865320; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eAc2zZ+mJy0soDoOKMsDuX1GYyEyxzK53vDd1XbYank=;
 b=I+AnzUaL4qbxBqtNBFuiteyYsqKU/A6qG+yZpxZWligffooDRrtJra/rpYTYaXFnZm
 uDfWEVEYn4dTcEdyhVBqhWy8yKX6xaXdT/drBT/KLFd7bKnFr83mHU1M2DXg/moaqRe6
 z+3r4W1TcSgspxHZAp+WkyDBAnxpK2p+QKzajYCFgYo1kKls6b5lOsQuEyujeQqtXca3
 ByOeN9xBRZcIfwLKRS1bH9a7qy05awUIsAFc2tYoT3QA2lchs35MQJ8xzLw1Ueb/QE5k
 8oi72SPM45eM+AARNeDLGTrfZcI+IQ6jS+qIRFrF4RzoN6ydUcudj+5ZqleS6elrBx5B
 BfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740260520; x=1740865320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eAc2zZ+mJy0soDoOKMsDuX1GYyEyxzK53vDd1XbYank=;
 b=VfqT9MPzFvfqbbEkwTcxrfZcW3N9rfOvvEdYawrU4UI+lPCIKibWJz2h9kmBDC+R0Y
 Tbws4TtJVq27qo3ZpmW5L4vHIVtV1BGnIPOYcTjZyTEyB3wE7KVy6N73tEUZmkisRp1g
 sPxDRHCKAeg7ScPW2r/mt6IDelhx0NJSMthcvAw2yySRj+FBMOaQyoSv7+8mwmkGTYpe
 Qms5PIpLrX52Qbl1z+Uo3z1EX5g3KX187bpMXBy92q7EK/Rru15+KAZdBDOrC0L0CQyP
 AoSvKIVCe3PlI1h1Vc4HDYCd62x4ucPNwrl6LlkwyloPagsbx1pAsb8+nLiMb8z5UtoY
 3S8g==
X-Gm-Message-State: AOJu0YzeqdvbLfiM8v7ehZCcRm9+v5R5q0H9LPzSVhn5s0J0dM68NZ89
 deuODhTE843zQPZ5rWhSdeF5qFL2ofkOPGkpSVM89WLd3MDN/FVuqybgOqYP/Xnm5orQ6Gw6sFm
 h
X-Gm-Gg: ASbGncs4gRCByCupuzJQLwbTuHDA+g+l1+4wt7XxjU+SEWcF/9uSH+V2X8OHeo/UmAm
 HNS2PDu5ax5U3uf012tUWsGppWP3fFmAC35q6qrynkmu9Gjo0Y109bstDx6gtbjV+D+u8oESqyU
 Y/PC3cXaN6ZtAe7n3QI0CbrcXmVhSMuNPqPggi99aju4lTeS/ecRe0XLVi+LxWMhisJJKNDAlTG
 +77fkG/RNFzKNiG6Vx7iFN+5hS2cTweoq96Vw7xZ2Kq1I56E8WSh1RF3/e4Z9Kf7txl42zC2Ru+
 vj6D98y454xiMJra7wkIAqn+N4olnXEpNt4T4tlVtEEsbu9TLPmCSIMv9/KMMJlyNPgjM2Pob6g
 /LV8=
X-Google-Smtp-Source: AGHT+IGlOL0cPKMOWk4JmMX7CO8gqLUyVIypklUP449EcnWZlMevsuPNIOkq8Hql4gXGOE2kiBxTeg==
X-Received: by 2002:a17:902:dac5:b0:220:e991:480a with SMTP id
 d9443c01a7336-2219ff50eafmr112625295ad.15.1740260519874; 
 Sat, 22 Feb 2025 13:41:59 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d480sm157594675ad.142.2025.02.22.13.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Feb 2025 13:41:59 -0800 (PST)
Date: Sat, 22 Feb 2025 13:41:57 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, ckm@napatech.com
Subject: Re: [PATCH v1 00/32] add new adapter NT400D13
Message-ID: <20250222134157.73763253@hermes.local>
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
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

On Thu, 20 Feb 2025 23:03:24 +0100
Serhii Iliushyk <sil-plv@napatech.com> wrote:

> This patchset adds support for the new adapter NT400D13.
>=20
> Danylo Vodopianov (23):
>   net/ntnic: add link agx 100g
>   net/ntnic: add link state machine
>   net/ntnic: add rpf and gfg init
>   net/ntnic: add agx setup for port
>   net/ntnic: add host loopback init
>   net/ntnic: add line loopback init
>   net/ntnic: add 100 gbps port init
>   net/ntnic: add port post init
>   net/ntnic: add nim low power API
>   net/ntnic: add link handling API
>   net/ntnic: add port init to the state machine
>   net/ntnic: add port disable API
>   net/ntnic: add nt400d13 pcm init
>   net/ntnic: add HIF clock test
>   net/ntnic: add nt400d13 PRM module init
>   net/ntnic: add nt400d13 PRM module reset
>   net/ntnic: add SPI v3 support for FPGA
>   net/ntnic: add i2cm init
>   net/ntnic: add pca init
>   net/ntnic: add pcal init
>   net/ntnic: add reset PHY init
>   net/ntnic: add igam module init
>   net/ntnic: init IGAM and config PLL for FPGA
>=20
> Serhii Iliushyk (9):
>   net/ntnic: add minimal initialization new NIC NT400D13
>   net/ntnic: add minimal reset FPGA
>   net/ntnic: add FPGA modules and registers
>   net/ntnic: add setup for fpga reset
>   net/ntnic: add default reset setting for NT400D13
>   net/ntnic: add DDR calibration to reset stage
>   net/ntnic: add PHY ftile reset
>   net/ntnic: add clock init
>   net/ntnic: revert untrusted loop bound
>=20
>  doc/guides/nics/ntnic.rst                     |    7 +-
>  doc/guides/rel_notes/release_25_03.rst        |    4 +
>  drivers/net/ntnic/adapter/nt4ga_adapter.c     |    9 +
>  drivers/net/ntnic/include/nt4ga_link.h        |    7 +
>  drivers/net/ntnic/include/nthw_gfg.h          |   33 +
>  drivers/net/ntnic/include/ntnic_nim.h         |    5 +
>  .../include/ntnic_nthw_fpga_rst_nt400dxx.h    |   34 +
>  .../link_agx_100g/nt4ga_agx_link_100g.c       | 1029 ++++++
>  drivers/net/ntnic/meson.build                 |   16 +
>  drivers/net/ntnic/nim/i2c_nim.c               |  158 +-
>  drivers/net/ntnic/nim/i2c_nim.h               |    6 +
>  ...00D13_U62_Si5332-GM2-RevD-1_V5-Registers.h |  425 +++
>  .../net/ntnic/nthw/core/include/nthw_fpga.h   |   10 +
>  .../net/ntnic/nthw/core/include/nthw_gmf.h    |    2 +
>  .../net/ntnic/nthw/core/include/nthw_hif.h    |    4 +
>  .../net/ntnic/nthw/core/include/nthw_i2cm.h   |    3 +
>  .../net/ntnic/nthw/core/include/nthw_igam.h   |   40 +
>  .../ntnic/nthw/core/include/nthw_pca9532.h    |   25 +
>  .../ntnic/nthw/core/include/nthw_pcal6416a.h  |   33 +
>  .../nthw/core/include/nthw_pcm_nt400dxx.h     |   40 +
>  .../ntnic/nthw/core/include/nthw_phy_tile.h   |  156 +
>  .../nthw/core/include/nthw_prm_nt400dxx.h     |   32 +
>  .../nthw/core/include/nthw_si5332_si5156.h    |   63 +
>  .../net/ntnic/nthw/core/include/nthw_spi_v3.h |  107 +
>  .../net/ntnic/nthw/core/include/nthw_spim.h   |   58 +
>  .../net/ntnic/nthw/core/include/nthw_spis.h   |   63 +
>  .../nthw/core/nt400dxx/nthw_fpga_nt400dxx.c   |  220 ++
>  .../core/nt400dxx/reset/nthw_fpga_rst9574.c   |  377 ++
>  .../nt400dxx/reset/nthw_fpga_rst_nt400dxx.c   |  427 +++
>  drivers/net/ntnic/nthw/core/nthw_fpga.c       |  464 +++
>  drivers/net/ntnic/nthw/core/nthw_gfg.c        |  340 ++
>  drivers/net/ntnic/nthw/core/nthw_gmf.c        |   41 +
>  drivers/net/ntnic/nthw/core/nthw_hif.c        |   92 +
>  drivers/net/ntnic/nthw/core/nthw_i2cm.c       |  139 +
>  drivers/net/ntnic/nthw/core/nthw_igam.c       |   93 +
>  drivers/net/ntnic/nthw/core/nthw_pca9532.c    |   60 +
>  drivers/net/ntnic/nthw/core/nthw_pcal6416a.c  |  103 +
>  .../net/ntnic/nthw/core/nthw_pcm_nt400dxx.c   |   80 +
>  drivers/net/ntnic/nthw/core/nthw_phy_tile.c   | 1242 +++++++
>  .../net/ntnic/nthw/core/nthw_prm_nt400dxx.c   |   55 +
>  .../net/ntnic/nthw/core/nthw_si5332_si5156.c  |  142 +
>  drivers/net/ntnic/nthw/core/nthw_spi_v3.c     |  358 ++
>  drivers/net/ntnic/nthw/core/nthw_spim.c       |  113 +
>  drivers/net/ntnic/nthw/core/nthw_spis.c       |  121 +
>  drivers/net/ntnic/nthw/nthw_drv.h             |   31 +
>  drivers/net/ntnic/nthw/nthw_platform.c        |    3 +
>  drivers/net/ntnic/nthw/nthw_platform_drv.h    |    2 +
>  .../supported/nthw_fpga_9574_055_049_0000.c   | 3124 +++++++++++++++++
>  .../nthw/supported/nthw_fpga_instances.c      |    5 +-
>  .../nthw/supported/nthw_fpga_instances.h      |    1 +
>  .../ntnic/nthw/supported/nthw_fpga_mod_defs.h |   11 +
>  .../nthw/supported/nthw_fpga_mod_str_map.c    |   11 +
>  .../ntnic/nthw/supported/nthw_fpga_reg_defs.h |   11 +
>  .../nthw/supported/nthw_fpga_reg_defs_igam.h  |   32 +
>  .../supported/nthw_fpga_reg_defs_pci_ta.h     |   33 +
>  .../nthw_fpga_reg_defs_pcm_nt400dxx.h         |   29 +
>  .../nthw/supported/nthw_fpga_reg_defs_pdi.h   |   49 +
>  .../supported/nthw_fpga_reg_defs_phy_tile.h   |  213 ++
>  .../nthw_fpga_reg_defs_prm_nt400dxx.h         |   26 +
>  .../nthw/supported/nthw_fpga_reg_defs_rfd.h   |   38 +
>  .../supported/nthw_fpga_reg_defs_rst9574.h    |   35 +
>  .../nthw/supported/nthw_fpga_reg_defs_spim.h  |   76 +
>  .../nthw/supported/nthw_fpga_reg_defs_spis.h  |   51 +
>  .../nthw/supported/nthw_fpga_reg_defs_tint.h  |   28 +
>  drivers/net/ntnic/ntnic_ethdev.c              |    1 +
>  drivers/net/ntnic/ntnic_filter/ntnic_filter.c |    2 +-
>  drivers/net/ntnic/ntnic_mod_reg.c             |   47 +
>  drivers/net/ntnic/ntnic_mod_reg.h             |   25 +
>  68 files changed, 10709 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/net/ntnic/include/nthw_gfg.h
>  create mode 100644 drivers/net/ntnic/include/ntnic_nthw_fpga_rst_nt400dx=
x.h
>  create mode 100644 drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_l=
ink_100g.c
>  create mode 100644 drivers/net/ntnic/nthw/core/include/NT400D13_U62_Si53=
32-GM2-RevD-1_V5-Registers.h
>  create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_igam.h
>  create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_pca9532.h
>  create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h
>  create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx=
.h
>  create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
>  create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_prm_nt400dxx=
.h
>  create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_si5332_si515=
6.h
>  create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_spi_v3.h
>  create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_spim.h
>  create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_spis.h
>  create mode 100644 drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400d=
xx.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_=
rst9574.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_=
rst_nt400dxx.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nthw_gfg.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nthw_igam.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nthw_pca9532.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nthw_pcal6416a.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nthw_phy_tile.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nthw_prm_nt400dxx.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nthw_spi_v3.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nthw_spim.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nthw_spis.c
>  create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_9574_055_0=
49_0000.c
>  create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_i=
gam.h
>  create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_p=
ci_ta.h
>  create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_p=
cm_nt400dxx.h
>  create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_p=
di.h
>  create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_p=
hy_tile.h
>  create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_p=
rm_nt400dxx.h
>  create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_r=
fd.h
>  create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_r=
st9574.h
>  create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_s=
pim.h
>  create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_s=
pis.h
>  create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_t=
int.h
>=20

I will merge this for next-net BUT
The driver is better after this patch series, but still low quality.

Several pre-existing issues in this driver; looks like it did not get enough
review during 24.11 release when it was merged.

    =E2=9C=94 passed
    =E2=9C=98 Failed

Basic hygiene
    =E2=9C=94 Look at CI results in patchwork
    =E2=9C=94 Merge cleanly with git am
    =E2=9C=94 Run checkpatches
    =E2=9C=94 Run check-git-log
    =E2=9C=94 Run check-symbol-maps.sh
    =E2=9C=94 Run check-doc-vs-code
    =E2=9C=94 Run check-spdk-tag

Builds
    =E2=9C=94 Normal Gcc build; make sure driver is built!
    =E2=9C=94 Use latest experimental Gcc 15
    =E2=9C=94 Clang build using current version (clang-19)
    =E2=9C=94 Doc build
    o Build for 32 bit x86
    o Cross build for Windows (if applicable)
    =E2=9C=94 Debug build
    =E2=9C=94 Enable asserts
    =E2=9C=94 Test meson builds

Experimental builds:
    =E2=9C=94 Enable address sanitizer

    =E2=9C=98 Enable extra warnings (edit meson.build) for
        -Wvla, -Wformat-truncation, -Waddress-of-packed-member

    Let's not add more VLA's, these could be arrays with a fixed size.

[1470/3259] Compiling C object drivers...ofile_inline_flow_api_hw_db_inline=
.c.o
../drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c: =
In function =E2=80=98hw_db_inline_alloc_prioritized_cfn=E2=80=99:
../drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c:1=
346:9: warning: ISO C90 forbids variable length array =E2=80=98sorted_prior=
ity=E2=80=99 [-Wvla]
 1346 |         } sorted_priority[db->nb_cat];
      |         ^

[1479/3259] Compiling C object drivers...ile_inline_flow_api_profile_inline=
.c.o
../drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c=
: In function =E2=80=98setup_db_qsl_data=E2=80=99:
../drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c=
:3193:17: warning: ISO C90 forbids variable length array =E2=80=98ports=E2=
=80=99 [-Wvla]
 3193 |                 uint32_t ports[fd->dst_num_avail];
      |                 ^~~~~~~~
../drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c=
:3194:17: warning: ISO C90 forbids variable length array =E2=80=98queues=E2=
=80=99 [-Wvla]
 3194 |                 uint32_t queues[fd->dst_num_avail];
      |                 ^~~~~~~~

This is not doing what you expect, ports is uint32_t array

		uint32_t ports[fd->dst_num_avail];
		uint32_t queues[fd->dst_num_avail];

		memset(ports, 0, fd->dst_num_avail);
		memset(queues, 0, fd->dst_num_avail);

Instead use HW_DB_INLINE_MAX_QST_PER_QSL


Look for anti-patterns:
    =E2=9C=98 Driver must not disable warnings with compiler flags or pragm=
a's
      Using pragma pack()

    =E2=9C=98 Driver must not use thread and signal
      Using thread to monitor, should not be done by PMD specific thread.

    =E2=9C=98 Driver should not call abort() or assert() directly
      Is using assert() when should be using RTE_ASSERT()

    =E2=9C=98 Review exposed symbol names
      The driver exposes lots of global symbols (when statically linked)
      that do not have a consistent prefix of nthw_...
      Examples: get_rx_idle(), set_rx_idle(), dev_flow_init()


    =E2=9C=94 Apply coccinelle scripts

    =E2=9C=98 Review use of malloc
      Several places call malloc but do not check return value

    =E2=9C=98 Review use of memset

The code related to stats has several issues:
   - function returns -1 but never checked by callers
   - stats structure is already zero'd by ethdev
   - if queue is greater than RTE_ETHDEV_QUEUE_STAT_CNTRS the statistics sh=
ould
     still be counted for that queue, just no per-queue stats
   - the use of term if_index is potentially confusing; normally if_index r=
efers to the interface
     index assigned by the OS used for ioctl's etc. In this driver it appea=
rs to be the index
     of the phy.

static int dpdk_stats_collect(struct pmd_internals *internals, struct rte_e=
th_stats *stats)
{
	const struct ntnic_filter_ops *ntnic_filter_ops =3D get_ntnic_filter_ops();

	if (ntnic_filter_ops =3D=3D NULL) {
		NT_LOG_DBGX(ERR, NTNIC, "ntnic_filter_ops uninitialized");
		return -1;
	}
...
	ntnic_filter_ops->poll_statistics(internals);
	memset(stats, 0, sizeof(*stats));

	for (i =3D 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS && i < internals->nb_rx_queu=
es; i++) {
		stats->q_ipackets[i] =3D internals->rxq_scg[i].rx_pkts;
		stats->q_ibytes[i] =3D internals->rxq_scg[i].rx_bytes;
		rx_total +=3D stats->q_ipackets[i];
		rx_total_b +=3D stats->q_ibytes[i];
	}

	for (i =3D 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS && i < internals->nb_tx_queu=
es; i++) {
		stats->q_opackets[i] =3D internals->txq_scg[i].tx_pkts;
		stats->q_obytes[i] =3D internals->txq_scg[i].tx_bytes;
		stats->q_errors[i] =3D internals->txq_scg[i].err_pkts;
		tx_total +=3D stats->q_opackets[i];
		tx_total_b +=3D stats->q_obytes[i];
		tx_err_total +=3D stats->q_errors[i];
	}

Other:
    The handling of queue start/stop in this device is odd.
    Doesn't do deferred start.
    When Rx is stopped most drivers do some action to stop the hardware.

    Given the use of thread, driver should *not* have been merged in 24.11.
    The DPDK has a set of assumptions about thread and process model, and
    drivers making their own threads can cause problems in applications.
    (Other drivers use alarm for this type of port monitor function).
