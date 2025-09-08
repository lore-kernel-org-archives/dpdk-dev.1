Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D75DCAC582
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 23:12:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF3C940281;
	Tue,  9 Sep 2025 01:12:11 +0200 (CEST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 7C42E4025D
 for <dev@dpdk.org>; Tue,  9 Sep 2025 01:12:10 +0200 (CEST)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-45cb5e1adf7so41041255e9.0
 for <dev@dpdk.org>; Mon, 08 Sep 2025 16:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757373130;
 x=1757977930; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KnaULeiAdqX/a04E56ERk5gZ9le02QSI+W6SWakGzXM=;
 b=1CiOQXmlZem98Q2hRwK5fDOJK8g48KAVrRQkDfP2tbD9KKkQsEKqr4sx4ypdn8fVRp
 ERunhHGQ8WPgVduIQ/DpoqG2c4OFjQhNkIQCRCmKDRJG0ucuXGRtcorim7MtA2tgeysz
 4U5VK4dEBrfIvfplalmtgWLj8QuYvNs9HcZe4tiSPvl8JBTzAg0wlug+jsrMA6YVrBfz
 /IwlF4mg3usdrWP5QX4DyFXQf61Jc3Qj9JRqJ68symOEJG/k2tF1/S44RHT+wqH/RE5h
 GFNw36NzeTKbT6HSCI3K3Im3TaVlFt8ib9cMDIc8kozjuR3ihUrG73aU+28/8+pbfbTV
 O5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757373130; x=1757977930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KnaULeiAdqX/a04E56ERk5gZ9le02QSI+W6SWakGzXM=;
 b=WvS4wdm5OpKI8lEdN1zciw9m7NtEieOj/SXeWzXQSGiJoQnziFS0PBpwrjVUAPU3Av
 +NgWmzfC+BT+r4gUJWDLL/uYWyVoNRRdFkjRk1qgwpF5zekSqRL8w/M4ciH/I00+UqJv
 lvk1zIjKlGCZ2CRTomu5rqTCwXuCCU8PP7KWGuGWwhGw8SLGVzvprpz/EJnWbgGIHkIR
 n5kedAAbBlTqJz1oR4QY7b9rVlNZWiNKuyrkNi45n6q/uy1wQmjxHlwWn8rnqIbQQVpy
 b9+6d+jinh2hdWiSMv4JUiYGg24Cy9zdeHXW1FbMdt0AIIRggHLKbot2kk9eEXdTxbl2
 UZ3Q==
X-Gm-Message-State: AOJu0YzeP+K5Vt3ABMYNhp1uCT0UrX646GwNI+DEz9OMdj+VSb+Vnv9X
 IsKkxpOgch66rZjBPudSBSJ4kYsnu2OKXEvGDeEzgLn3DhX4/j3ZKNtK9mdKDJnilYk=
X-Gm-Gg: ASbGncvcFK2sYVLkdzJAgcoo6yPMude0ni3nuuBgb4NpD+CkjDVv8M4k/xcHxc+6QdX
 JyporYnasaOqTc+Fms7Muk0wVyoc0aH7SdhW/Mzx8kEMfCL5M/283u3S9cVkdYNMf/pfToER3/U
 S8CpiZWD198+uKKPR4RCh0iofqT8jCTN27DNvn+4mQYW966vGIvSy4XANumRxekVY8f0k+er1s6
 MwOU28JEiyXmGEkk3wQI0zsLbb4dB3XVmZhOQ0we4JlHc27D2WYB/xxtN2IUbvP0MkLE+BfTg/Z
 GeDVk3gpiPb5wkqfKji8D7CydLxEEFbca4H91M0S++X4t28japA/m1/VTLZfynP31ZmSXCnEarD
 10/Y+nXvkEBFNgbxQ9b4/gjxSorCVXUj5BWAajqbEaleVjn7amtxKF3nLzqolv/9+2ReVuKgb0s
 +Fp8iJedCxf+Sx5QxIUCsH
X-Google-Smtp-Source: AGHT+IHNags0eA6S48/ldGttQeNK1/R+93eWpVVrHAScnuUt1En8i+W1hRb6NNOKZaOMItr+cv+wCw==
X-Received: by 2002:a05:600c:6305:b0:45d:5c71:76a9 with SMTP id
 5b1f17b1804b1-45ddded7652mr94140125e9.24.1757373129781; 
 Mon, 08 Sep 2025 16:12:09 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e752238760sm66521f8f.34.2025.09.08.16.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 16:12:09 -0700 (PDT)
Date: Mon, 8 Sep 2025 16:12:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org
Subject: Re: [V8 00/17] add-hinic3-PMD-driver
Message-ID: <20250908161203.50380440@hermes.local>
In-Reply-To: <20250908135236.11873-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250908135236.11873-1-wff_light@vip.163.com>
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

On Mon,  8 Sep 2025 21:52:08 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> The hinic3 PMD (**librte_net_hinic3**) provides poll mode driver support
> for 25Gbps/100Gbps/200Gbps Huawei SPx series Network Adapters.
>=20
> v8:
> -resolve CI compile error
> -modify mbox section
>=20
> v7:
> -remove unused-functions
>=20
> v6:
> -modify based on community comments
> -remove mml files
>=20
> v5:
> -fix build err
>=20
> v4:=20
> -solve patch application conflict issue=20
>=20
> v3:
> -fix checkpatchs errors issue
>=20
> v2:
> -modify CI compile errors
>=20
> v1:
> -modify community comments and compile issues
> -remove the compilation flags in the meson build
> -remove (void) cur_link_machine_state
> -remove '*** BLURE HERE ***' in cover letter
>=20
> Feifei Wang (2):
>   net/hinic3: add dev ops
>   net/hinic3: add Rx/Tx functions
>=20
> Xin Wang (6):
>   net/hinic3: add basic header files
>   net/hinic3: add support for cmdq mechanism
>   net/hinic3: add NIC event module
>   net/hinic3: add context and work queue support
>   net/hinic3: add device initialization
>   net/hinic3: add RSS promiscuous ops
>=20
> Yi Chen (9):
>   doc: add hinic3 driver
>   net/hinic3: add hardware interfaces of BAR operation
>   net/hinic3: add eq mechanism
>   net/hinic3: add mgmt module function code
>   net/hinic3: add module about hardware operation
>   net/hinic3: add a NIC business configuration module
>   net/hinic3: add a mailbox communication module
>   net/hinic3: add flow control and FDIR module
>   drivers/net: add hinic3 PMD build and doc files
>=20
>  .mailmap                                   |    4 +-
>  MAINTAINERS                                |    6 +
>  doc/guides/nics/features/hinic3.ini        |   60 +
>  doc/guides/nics/hinic3.rst                 |   47 +
>  doc/guides/nics/index.rst                  |    1 +
>  doc/guides/rel_notes/release_25_11.rst     |    3 +
>  drivers/net/hinic3/base/hinic3_cmd.h       |  156 +
>  drivers/net/hinic3/base/hinic3_cmdq.c      |  972 +++++
>  drivers/net/hinic3/base/hinic3_cmdq.h      |  230 ++
>  drivers/net/hinic3/base/hinic3_compat.h    |  144 +
>  drivers/net/hinic3/base/hinic3_csr.h       |  108 +
>  drivers/net/hinic3/base/hinic3_eqs.c       |  710 ++++
>  drivers/net/hinic3/base/hinic3_eqs.h       |   98 +
>  drivers/net/hinic3/base/hinic3_hw_cfg.c    |  194 +
>  drivers/net/hinic3/base/hinic3_hw_cfg.h    |  117 +
>  drivers/net/hinic3/base/hinic3_hw_comm.c   |  449 +++
>  drivers/net/hinic3/base/hinic3_hw_comm.h   |  365 ++
>  drivers/net/hinic3/base/hinic3_hwdev.c     |  558 +++
>  drivers/net/hinic3/base/hinic3_hwdev.h     |  183 +
>  drivers/net/hinic3/base/hinic3_hwif.c      |  741 ++++
>  drivers/net/hinic3/base/hinic3_hwif.h      |  144 +
>  drivers/net/hinic3/base/hinic3_mbox.c      | 1225 +++++++
>  drivers/net/hinic3/base/hinic3_mbox.h      |  181 +
>  drivers/net/hinic3/base/hinic3_mgmt.c      |  355 ++
>  drivers/net/hinic3/base/hinic3_mgmt.h      |  112 +
>  drivers/net/hinic3/base/hinic3_nic_cfg.c   | 1795 ++++++++++
>  drivers/net/hinic3/base/hinic3_nic_cfg.h   | 1530 ++++++++
>  drivers/net/hinic3/base/hinic3_nic_event.c |  407 +++
>  drivers/net/hinic3/base/hinic3_nic_event.h |   38 +
>  drivers/net/hinic3/base/hinic3_wq.c        |  140 +
>  drivers/net/hinic3/base/hinic3_wq.h        |  109 +
>  drivers/net/hinic3/base/meson.build        |   50 +
>  drivers/net/hinic3/hinic3_ethdev.c         | 3782 ++++++++++++++++++++
>  drivers/net/hinic3/hinic3_ethdev.h         |  164 +
>  drivers/net/hinic3/hinic3_fdir.c           | 1379 +++++++
>  drivers/net/hinic3/hinic3_fdir.h           |  398 ++
>  drivers/net/hinic3/hinic3_flow.c           | 1501 ++++++++
>  drivers/net/hinic3/hinic3_flow.h           |  196 +
>  drivers/net/hinic3/hinic3_nic_io.c         |  806 +++++
>  drivers/net/hinic3/hinic3_nic_io.h         |  171 +
>  drivers/net/hinic3/hinic3_rx.c             | 1067 ++++++
>  drivers/net/hinic3/hinic3_rx.h             |  353 ++
>  drivers/net/hinic3/hinic3_tx.c             | 1024 ++++++
>  drivers/net/hinic3/hinic3_tx.h             |  313 ++
>  drivers/net/hinic3/meson.build             |   31 +
>  drivers/net/meson.build                    |    1 +
>  46 files changed, 22417 insertions(+), 1 deletion(-)
>  create mode 100644 doc/guides/nics/features/hinic3.ini
>  create mode 100644 doc/guides/nics/hinic3.rst
>  create mode 100644 drivers/net/hinic3/base/hinic3_cmd.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_cmdq.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_cmdq.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_compat.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_csr.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_eqs.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_eqs.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_hw_cfg.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_hw_cfg.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_hw_comm.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_hw_comm.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_hwdev.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_hwdev.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_hwif.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_hwif.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_mbox.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_mbox.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_mgmt.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_mgmt.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_nic_cfg.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_nic_cfg.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_nic_event.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_nic_event.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_wq.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_wq.h
>  create mode 100644 drivers/net/hinic3/base/meson.build
>  create mode 100644 drivers/net/hinic3/hinic3_ethdev.c
>  create mode 100644 drivers/net/hinic3/hinic3_ethdev.h
>  create mode 100644 drivers/net/hinic3/hinic3_fdir.c
>  create mode 100644 drivers/net/hinic3/hinic3_fdir.h
>  create mode 100644 drivers/net/hinic3/hinic3_flow.c
>  create mode 100644 drivers/net/hinic3/hinic3_flow.h
>  create mode 100644 drivers/net/hinic3/hinic3_nic_io.c
>  create mode 100644 drivers/net/hinic3/hinic3_nic_io.h
>  create mode 100644 drivers/net/hinic3/hinic3_rx.c
>  create mode 100644 drivers/net/hinic3/hinic3_rx.h
>  create mode 100644 drivers/net/hinic3/hinic3_tx.c
>  create mode 100644 drivers/net/hinic3/hinic3_tx.h
>  create mode 100644 drivers/net/hinic3/meson.build
>=20

Needs to be rebased after the current round of merges to main
which changed release notes and return value of rx_queue_count
../drivers/net/hinic3/hinic3_ethdev.c: In function =E2=80=98hinic3_func_ini=
t=E2=80=99:
../drivers/net/hinic3/hinic3_ethdev.c:3585:33: error: assignment to =E2=80=
=98eth_rx_queue_count_t=E2=80=99 {aka =E2=80=98int (*)(void *)=E2=80=99} fr=
om incompatible pointer type =E2=80=98uint32_t (*)(void *)=E2=80=99 {aka =
=E2=80=98unsigned int (*)(void *)=E2=80=99} [-Wincompatible-pointer-types]
 3585 |         eth_dev->rx_queue_count =3D hinic3_dev_rx_queue_count;
      |                                 ^

