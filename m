Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B65DC021A1
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 14:56:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9204D4060C;
	Tue, 11 Feb 2025 15:56:56 +0100 (CET)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id CAB574042E
 for <dev@dpdk.org>; Tue, 11 Feb 2025 15:56:55 +0100 (CET)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2fa8ada6662so3361319a91.1
 for <dev@dpdk.org>; Tue, 11 Feb 2025 06:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739285815;
 x=1739890615; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1qluvXKA/mNwlBNJ+I9ZmUiuN90wYf0DHds0F+lSWik=;
 b=ETHYU5JkNJSRWpxUZBol8zIryOIV2GX+bw7SlZWojKFqAN51p7ksWEN2PCC0iYEvTv
 2kVd0R9nq6bICm6w9lgstO0QmWwN9mrHify6t7WuNt5ahsJ7oOqq+q1W9ZeRZ227aO/+
 ZD+LQ6ULxS84PZ0Nso6ppVDXAJHjDDwUu/2Ytbt0c6fDSocydz/mEFet3bT3kp9BWVBg
 +XZB/7IOekH9CfY7zxyJ9eNiu8kusI89TurC8oJaJT5705iMxtoYk1McDP5FWjv2viV+
 9MFn2vhejfFkYgxKAwtHTM16NldWEwjV3aH7K8zVFVKZuB+WI/taErIfb1HkgVX4hVLc
 I/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739285815; x=1739890615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1qluvXKA/mNwlBNJ+I9ZmUiuN90wYf0DHds0F+lSWik=;
 b=xKY9aQ3F9vn2uRAQde1QVMovfE22NpZf3nazgOcLUW5xMf1HSSdJy7pMDbVT3BReI9
 R3RSBx+IgTYRPPC1FUEZ287vjVNgwgRStK8Ik21Xqj9voEccfBYswV+4K8IICCLXg8LU
 aNeOFWQV44NXqanZ86Q4KknQPECGLUmj8D5dy98gdf+FNWFJUHqFN0qPEeaz47dJes+r
 prIf7aauDSeTmR4I4yes4SMmEyrVJYEYHo+S7mCwkWdFP22UiFDRBHxO5nmuhAvPo7fz
 g4C9Qy8SxHRHHGGfiQ7apH7AptFym0ELD8P8q0XI133YDbCZS3JF24HqxkO/zLEva5SC
 HOEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2MMkKsgJ0cWT0pFUMoq+4aHbVnm/OQQZu48ftC8XKjEOh5ZM5S+W0T8wf3C12+dipAYU=@dpdk.org
X-Gm-Message-State: AOJu0Yy76YIm2ntuGa0zSz4l0k0pLvE+aW1Sl1qZtLQSXUaeSzscJu97
 YA22KylHOtxclb0irJvPNLqHOL3LFgkQ2+IOkDHhWV4QyRcVJ9J1ItpmQwpziarkhPy+dhG9r64
 3
X-Gm-Gg: ASbGncvQWBX2v38rY+gtTEhAYYPDyfYyQ7Ny+vdpcCQz5MKEl0hrFGpy5XqT9yLY4GI
 ITa2W0a/hb9LvHTzPbi2JGl5vjSuIPbhF2P+f3obg3z/tXcvRi4KLT2HeGsM+5U62wF1p6aN6Vr
 aILqEm3FRvQOXyVRpvsSrUBMfbV56o2vywgLkhbrbsS4vE/Q5vgRot2ZmvciFYXw+T9fU+Z41ut
 IBw4rUVazdzC39X6gOUqsDP1cHn1mKG/fROVAR/f/ye7x0pzKTxGVANrIDYEC5YvvrpY5vWZMQJ
 apFvqe9Xh/g+xbgzBowgxmm40ybki6J2g8IWFOLnB9XgU9HuyO/57NpJm4FcEDQlT3lW
X-Google-Smtp-Source: AGHT+IGGtXgzo8VceASzS7Few4R4jKwLb0wtL6vlKwBjcu+HnQx0aQxwz6rkQ9Mjw6uLgXclboHuqg==
X-Received: by 2002:a17:90b:2dd0:b0:2fa:13ce:bf16 with SMTP id
 98e67ed59e1d1-2fb63d15de7mr68816a91.11.1739285814881; 
 Tue, 11 Feb 2025 06:56:54 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa20eba0dasm9269277a91.45.2025.02.11.06.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 06:56:54 -0800 (PST)
Date: Tue, 11 Feb 2025 06:56:49 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: thomas@monjalon.net, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: Re: [PATCH v9 00/28] [v9]drivers/net Add Support mucse N10 Pmd Driver
Message-ID: <20250211065649.1885ab26@hermes.local>
In-Reply-To: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>
References: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>
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

On Tue, 11 Feb 2025 16:49:50 +0800
Wenbo Cao <caowenbo@mucse.com> wrote:

> For This patchset just to support the basic chip init work
> and user can just found the eth_dev, but can't control more.
> For Now just support 2*10g nic,the chip can support
> 2*10g,4*10g,4*1g,8*1g,8*10g.
> The Feature rx side can support rx-cksum-offload,rss,vlan-filter
> flow_clow,uncast_filter,mcast_filter,1588,Jumbo-frame
> The Feature tx side can support tx-cksum-offload,tso,vxlan-tso=20
> flow director base on ntuple pattern of tcp/udp/ip/ eth_hdr->type
> for sriov is also support.
>=20
> Because of the chip design defect, for multiple-port mode
> one pci-bdf will have multiple-port (max can have four ports)
> so this code must be care of one bdf init multiple-port.
>=20
> v9:
>   * fixed commit log format check by devtools.
>   * fixed code compile issue.
>=20
> v8:
>   * fixed codespell issue.
>   * fixed MAINTAINERS file
>=20
> v7:
>   * add support nic basic feature such as rss vlan strip/filter,
>   * mtu-change recv/send scater-recv/mutltiple-send.
>   * fixed code rationality, advised by Ferruh Yigit.
> v6:
>   * fixed the doc(rst) format problem advise by Thomas Monjalon
>=20
> v5:
>   * fixed the symbol name require by the style documentation
>=20
> v4:
>   * one patch has been forgot to upload :(
>=20
> v3:
>   * fixed http://dpdk.org/patch/129830 FreeBSD 13 compile Issue
>   * change iobar type to void suggest by Stephen Hemminger
>   * add KMOD_DEP support for vfio-pci
>   * change run-cmd argument parse check for invalid extra_args
>=20
> v2:
>   * fixed MAINTAIN maillist fullname format
>   * fixed driver/net/meson the order issue of new driver to driver list
>   * improve virtual point function usage suggest by Stephen Hemminger
>=20
> Wenbo Cao (28):
>   net/rnp: add skeleton
>   net/rnp: add ethdev probe and remove
>   net/rnp: add log
>   net/rnp: support mailbox basic operate
>   net/rnp: add device init and uninit
>   net/rnp: add get device information operation
>   net/rnp: add support MAC promisc mode
>   net/rnp: add queue setup and release operations
>   net/rnp: add queue stop and start operations
>   net/rnp: add support device start stop operations
>   net/rnp: add RSS support operations
>   net/rnp: add support link update operations
>   net/rnp: add support link setup operations
>   net/rnp: add Rx burst simple support
>   net/rnp: add Tx burst simple support
>   net/rnp: add MTU set operation
>   net/rnp: add Rx scatter segment version
>   net/rnp: add Tx multiple segment version
>   net/rnp: add support basic stats operation
>   net/rnp: add support xstats operation
>   net/rnp: add unicast MAC filter operation
>   net/rnp: add supported packet types
>   net/rnp: add support Rx checksum offload
>   net/rnp: add support Tx TSO offload
>   net/rnp: support VLAN offloads
>   net/rnp: add support VLAN filters operations
>   net/rnp: add queue info operation
>   net/rnp: support Rx/Tx burst mode info
>=20
>  .mailmap                            |    1 +
>  MAINTAINERS                         |    6 +
>  doc/guides/nics/features/rnp.ini    |   33 +
>  doc/guides/nics/index.rst           |    1 +
>  doc/guides/nics/rnp.rst             |  101 ++
>  drivers/net/meson.build             |    1 +
>  drivers/net/rnp/base/meson.build    |   28 +
>  drivers/net/rnp/base/rnp_bdq_if.c   |  398 ++++++
>  drivers/net/rnp/base/rnp_bdq_if.h   |  154 +++
>  drivers/net/rnp/base/rnp_bitrev.h   |   64 +
>  drivers/net/rnp/base/rnp_common.c   |  103 ++
>  drivers/net/rnp/base/rnp_common.h   |   17 +
>  drivers/net/rnp/base/rnp_crc32.c    |   37 +
>  drivers/net/rnp/base/rnp_crc32.h    |   10 +
>  drivers/net/rnp/base/rnp_dma_regs.h |   68 +
>  drivers/net/rnp/base/rnp_eth_regs.h |   90 ++
>  drivers/net/rnp/base/rnp_fw_cmd.c   |  162 +++
>  drivers/net/rnp/base/rnp_fw_cmd.h   |  358 ++++++
>  drivers/net/rnp/base/rnp_hw.h       |  136 ++
>  drivers/net/rnp/base/rnp_mac.c      |  367 ++++++
>  drivers/net/rnp/base/rnp_mac.h      |   34 +
>  drivers/net/rnp/base/rnp_mac_regs.h |  207 +++
>  drivers/net/rnp/base/rnp_mbx.c      |  512 ++++++++
>  drivers/net/rnp/base/rnp_mbx.h      |   58 +
>  drivers/net/rnp/base/rnp_mbx_fw.c   |  499 ++++++++
>  drivers/net/rnp/base/rnp_mbx_fw.h   |   24 +
>  drivers/net/rnp/base/rnp_osdep.h    |  173 +++
>  drivers/net/rnp/meson.build         |   20 +
>  drivers/net/rnp/rnp.h               |  258 ++++
>  drivers/net/rnp/rnp_ethdev.c        | 1841 +++++++++++++++++++++++++++
>  drivers/net/rnp/rnp_link.c          |  439 +++++++
>  drivers/net/rnp/rnp_link.h          |   38 +
>  drivers/net/rnp/rnp_logs.h          |   36 +
>  drivers/net/rnp/rnp_rss.c           |  367 ++++++
>  drivers/net/rnp/rnp_rss.h           |   43 +
>  drivers/net/rnp/rnp_rxtx.c          | 1820 ++++++++++++++++++++++++++
>  drivers/net/rnp/rnp_rxtx.h          |  162 +++
>  37 files changed, 8666 insertions(+)
>  create mode 100644 doc/guides/nics/features/rnp.ini
>  create mode 100644 doc/guides/nics/rnp.rst
>  create mode 100644 drivers/net/rnp/base/meson.build
>  create mode 100644 drivers/net/rnp/base/rnp_bdq_if.c
>  create mode 100644 drivers/net/rnp/base/rnp_bdq_if.h
>  create mode 100644 drivers/net/rnp/base/rnp_bitrev.h
>  create mode 100644 drivers/net/rnp/base/rnp_common.c
>  create mode 100644 drivers/net/rnp/base/rnp_common.h
>  create mode 100644 drivers/net/rnp/base/rnp_crc32.c
>  create mode 100644 drivers/net/rnp/base/rnp_crc32.h
>  create mode 100644 drivers/net/rnp/base/rnp_dma_regs.h
>  create mode 100644 drivers/net/rnp/base/rnp_eth_regs.h
>  create mode 100644 drivers/net/rnp/base/rnp_fw_cmd.c
>  create mode 100644 drivers/net/rnp/base/rnp_fw_cmd.h
>  create mode 100644 drivers/net/rnp/base/rnp_hw.h
>  create mode 100644 drivers/net/rnp/base/rnp_mac.c
>  create mode 100644 drivers/net/rnp/base/rnp_mac.h
>  create mode 100644 drivers/net/rnp/base/rnp_mac_regs.h
>  create mode 100644 drivers/net/rnp/base/rnp_mbx.c
>  create mode 100644 drivers/net/rnp/base/rnp_mbx.h
>  create mode 100644 drivers/net/rnp/base/rnp_mbx_fw.c
>  create mode 100644 drivers/net/rnp/base/rnp_mbx_fw.h
>  create mode 100644 drivers/net/rnp/base/rnp_osdep.h
>  create mode 100644 drivers/net/rnp/meson.build
>  create mode 100644 drivers/net/rnp/rnp.h
>  create mode 100644 drivers/net/rnp/rnp_ethdev.c
>  create mode 100644 drivers/net/rnp/rnp_link.c
>  create mode 100644 drivers/net/rnp/rnp_link.h
>  create mode 100644 drivers/net/rnp/rnp_logs.h
>  create mode 100644 drivers/net/rnp/rnp_rss.c
>  create mode 100644 drivers/net/rnp/rnp_rss.h
>  create mode 100644 drivers/net/rnp/rnp_rxtx.c
>  create mode 100644 drivers/net/rnp/rnp_rxtx.h
>=20

Two copies of v9 received.
Build is failing in CI
-------------------------------BEGIN LOGS----------------------------
###########################################################################=
#########
#### [Begin job log] "ubuntu-22.04-gcc-static-mingw" at step Build and test
###########################################################################=
#########
[632/3011] Linking static target drivers/libtmp_rte_net_ring.a
[633/3011] Linking static target drivers/librte_net_r8169.a
[634/3011] Generating rte_net_ring.pmd.c with a custom command
[635/3011] Linking target drivers/librte_net_r8169-25.dll
[636/3011] Compiling C object drivers/librte_net_ring-25.dll.p/meson-genera=
ted_.._rte_net_ring.pmd.c.obj
[637/3011] Compiling C object drivers/librte_net_ring.a.p/meson-generated_.=
._rte_net_ring.pmd.c.obj
[638/3011] Linking target drivers/librte_net_ring-25.dll
[639/3011] Linking static target drivers/librte_net_ring.a
[640/3011] Compiling C object drivers/net/rnp/base/librnp_base.a.p/rnp_mbx_=
fw.c.obj
FAILED: drivers/net/rnp/base/librnp_base.a.p/rnp_mbx_fw.c.obj=20
ccache x86_64-w64-mingw32-gcc -Idrivers/net/rnp/base/librnp_base.a.p -Idriv=
ers/net/rnp/base -I../drivers/net/rnp/base -I. -I.. -Iconfig -I../config -I=
lib/eal/include -I../lib/eal/include -Ilib/eal/windows/include -I../lib/eal=
/windows/include -Ilib/eal/x86/include -I../lib/eal/x86/include -Ilib/eal/c=
ommon -I../lib/eal/common -Ilib/eal -I../lib/eal -Ilib/log -I../lib/log -Il=
ib/kvargs -I../lib/kvargs -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf -=
Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/metrics -I../l=
ib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/ethdev -I../lib/ethdev =
-Ilib/meter -I../lib/meter -fdiagnostics-color=3Dalways -pipe -D_FILE_OFFSE=
T_BITS=3D64 -Wall -Winvalid-pch -Wextra -Werror -std=3Dc11 -O2 -g -include =
rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral -W=
format-security -Wmissing-declarations -Wmissing-prototypes -Wnested-extern=
s -Wold-style-definition -Wpointer-arith -Wsign-compare -Wstrict-prototypes=
 -Wundef -Wwrite-strings -Wno-packed-not-aligned -Wno-missing-field-initial=
izers -D_GNU_SOURCE -D_WIN32_WINNT=3D0x0A00 -D__USE_MINGW_ANSI_STDIO -march=
=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-t=
runcation -Wno-address-of-packed-member -Wno-unused-value -Wno-unused-but-s=
et-variable -Wno-unused-parameter -MD -MQ drivers/net/rnp/base/librnp_base.=
a.p/rnp_mbx_fw.c.obj -MF drivers/net/rnp/base/librnp_base.a.p/rnp_mbx_fw.c.=
obj.d -o drivers/net/rnp/base/librnp_base.a.p/rnp_mbx_fw.c.obj -c ../driver=
s/net/rnp/base/rnp_mbx_fw.c
../drivers/net/rnp/base/rnp_mbx_fw.c: In function =E2=80=98rnp_mbx_fw_get_c=
apability=E2=80=99:
../drivers/net/rnp/base/rnp_mbx_fw.c:259:15: error: implicit declaration of=
 function =E2=80=98ffs=E2=80=99; did you mean =E2=80=98fls=E2=80=99? [-Werr=
or=3Dimplicit-function-declaration]
  259 |    lane_bit =3D ffs(temp_mask) - 1;
      |               ^~~
      |               fls


You need to use rte_ffs32 (or rte_ffs64) from rte_bitops.h instead.
