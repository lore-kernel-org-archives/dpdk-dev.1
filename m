Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC014C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 16:25:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D8E840A84;
	Tue, 11 Feb 2025 17:24:54 +0100 (CET)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id B786C40A7F
 for <dev@dpdk.org>; Tue, 11 Feb 2025 17:24:52 +0100 (CET)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2fa1a3c88c5so7554652a91.3
 for <dev@dpdk.org>; Tue, 11 Feb 2025 08:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739291092;
 x=1739895892; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AAAzoiVwGRMRqOff+yLRvRQEn8GnS33u5+dBkYenTO0=;
 b=vcD+eGWV9cFL9lp11F7dWIg7FKIaV8jUyOFFWIrSF+xX78zaxeIZvIK5GLY5dI0pDg
 cXOfXPejyl3ZTaXPEt6k8LbHtR+jIq4cdp/3BAQar1aUREEEpnhaZ4dxXRbmWZIOqdJK
 rPhJYkZext47Bgq9E9Y+9dKBWhJEOsHyAbd3BxwXV4Eu9i0MPBn09mwLT+pz0QjftR+r
 nJ8tW6piHSwe8rtZaR77acss3Pu6h8XXuTTgyNdqigCnP67rkw/jumRx0SMV2iTQK5lX
 XaEsU3lu/3SBlQ7UKky5WgaSXPsIrWM+7BXR+IQ9K+bkaOkyocvgeqfUZWBpjimiM0PE
 +dTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291092; x=1739895892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AAAzoiVwGRMRqOff+yLRvRQEn8GnS33u5+dBkYenTO0=;
 b=ZIRMI/lu9HHCb+nSeNbpMIqLD4wGjLqDKVKlZA6AKKnbW1KmtaRSKZ9iMdR6q96Fij
 M7ZJdJYtzVVSdl0kaUKpRafsQ3HstNunjUIIr5VyqSD3tZY2YSRxTShhnzmMszGLGKLr
 cmo83e8FUlzbdOBmpONGpA7kzdv+KOOUF/YknhESVJDA/fPObGyqzsYCVQMgu5rDMn0i
 bdlHPQetYQK0YI4daYhcf3NyNvlsg+XdyGfUvkLE8cjNPENF7vsCo8vbahiNMBQKL70o
 D2lXHtONmjmu7vHc5ec4piflKXdGZ2OZSj4zAfEf6xQKMkji/h+1htENb4Rns1wlCCdB
 yFcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpuXjlz7h7oVYVz7RXyYQtzHGfUyRCwRR5WfAl92g8yo3qVA3A3P4BRHJZg9kZEymAFvE=@dpdk.org
X-Gm-Message-State: AOJu0Yz5rt7tK+iCNhlRqju50LwL027rg7swWKdGhEzbYBJ9fIxJYpLM
 lazx2c6OcPkWaITvoygbFtjDNYbWV3I7BWrQWDrl8sguiDbhGwrjoseyvxvUGUQ=
X-Gm-Gg: ASbGnctO+8ugQIljvRZ0yWshCDuC5j1UxsijorlB9C+zejkmQqPuQ/mCNiapJTYO8NM
 TwigpNvlhcg+b0GHZnfK+UrN3kO9v45sabLKlONse+3OIflmryJgZKJcl6WovQS7v4Wphk010G0
 ReIT9EwGQqG2lTJ7gxDTPsm6sd3NaukqzHBxoSkzUbiZ0Z1qvvYjVBy3fuAz/t/iQsAlCE7YYD4
 7+8xxhbvwR+kUvkRO3W/efXTHHait+1pCRMA05iFY1HWmobH+P2PTeSEU79aDs0wB90eOgieoMK
 PAE+oaW8ryRcCtVtE+JY0aBQ/3Vu71urBRZfGJmUV4X8fZe6TyGTvNgKZartt0eCwHp3
X-Google-Smtp-Source: AGHT+IEALO+f7BZUId9obF0UiHezU+bko+wutjYzADfCwxaD0/1w/bGErmsgovTkpCYx0TCdqT+0IQ==
X-Received: by 2002:a17:90b:4f45:b0:2ea:7fd8:9dc1 with SMTP id
 98e67ed59e1d1-2fa9eda445fmr6987363a91.18.1739291091946; 
 Tue, 11 Feb 2025 08:24:51 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa2d831a1csm8617326a91.44.2025.02.11.08.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:24:51 -0800 (PST)
Date: Tue, 11 Feb 2025 08:24:22 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: thomas@monjalon.net, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: Re: [PATCH v10 00/28] [v10]drivers/net Add Support mucse N10 Pmd
 Driver
Message-ID: <20250211082422.321cb893@hermes.local>
In-Reply-To: <1739286398-61972-1-git-send-email-caowenbo@mucse.com>
References: <1739286398-61972-1-git-send-email-caowenbo@mucse.com>
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

On Tue, 11 Feb 2025 23:06:10 +0800
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
> v10:
>   * fixed mingw windows meson issue
>   * rnp not support windows for now.
>   * change ffs use osdep rte_fls_u32
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
>  drivers/net/rnp/base/rnp_mac.c      |  366 ++++++
>  drivers/net/rnp/base/rnp_mac.h      |   34 +
>  drivers/net/rnp/base/rnp_mac_regs.h |  207 +++
>  drivers/net/rnp/base/rnp_mbx.c      |  512 ++++++++
>  drivers/net/rnp/base/rnp_mbx.h      |   58 +
>  drivers/net/rnp/base/rnp_mbx_fw.c   |  499 ++++++++
>  drivers/net/rnp/base/rnp_mbx_fw.h   |   24 +
>  drivers/net/rnp/base/rnp_osdep.h    |  175 +++
>  drivers/net/rnp/meson.build         |   27 +
>  drivers/net/rnp/rnp.h               |  258 ++++
>  drivers/net/rnp/rnp_ethdev.c        | 1845 +++++++++++++++++++++++++++
>  drivers/net/rnp/rnp_link.c          |  439 +++++++
>  drivers/net/rnp/rnp_link.h          |   38 +
>  drivers/net/rnp/rnp_logs.h          |   36 +
>  drivers/net/rnp/rnp_rss.c           |  367 ++++++
>  drivers/net/rnp/rnp_rss.h           |   43 +
>  drivers/net/rnp/rnp_rxtx.c          | 1820 ++++++++++++++++++++++++++
>  drivers/net/rnp/rnp_rxtx.h          |  162 +++
>  37 files changed, 8678 insertions(+)
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

Review checklist for rnp v9 patches

Mark items with:
    =E2=9C=94 passed
    =E2=9C=98 Failed

Basic hygiene
    =E2=9C=98 Look at CI results in patchwork; notify submitter if any fail=
ures
    =E2=9C=94 Merge cleanly with git am; look for missing newline at EOF etc
    =E2=9C=98 Run checkpatches; warnings are ok, but look more carefully.
      Lots of warnings from base code (allowed but not preferred).

      The osdep code should be using rte_common.h
	WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__=
((packed))
	#999: FILE: drivers/net/rnp/base/rnp_osdep.h:49:
	+#define _PACKED_ALIGN4 __attribute__((packed, aligned(4)))

	Warning in drivers/net/rnp/base/rnp_osdep.h:
	Using compiler attribute directly
	Warning in drivers/net/rnp/base/rnp_hw.h:
	Do not use variadic argument pack in macros

	Warning in drivers/net/rnp/rnp_ethdev.c:
	Using __builtin helpers, prefer EAL macros

	Warning in drivers/net/rnp/rnp_ethdev.c:
	Using rte_atomicNN_xxx

	WARNING:MULTILINE_DEREFERENCE: Avoid multiple line dereference - prefer 'r=
te_eth_devices[rxq->attr.port_id].data->rx_mbuf_alloc_failed'
	#63: FILE: drivers/net/rnp/rnp_rxtx.c:854:
	+			rte_eth_devices[rxq->attr.port_id].data->
	+				rx_mbuf_alloc_failed++;

	Warning in drivers/net/rnp/base/rnp_mac.c:
	Writing to stdout or stderr

    =E2=9C=94 Run check-git-log
    =E2=9C=94 Run check-symbol-maps.sh
    =E2=9C=94 Run check-doc-vs-code
    =E2=9C=94 Run check-spdk-tag

Builds
    =E2=9C=94 Normal Gcc build
    =E2=9C=94 Use latest experimental Gcc 15 to catch new warnings
    =E2=9C=94 Clang build using current version (clang-19)
    =E2=9C=94 Doc build
    =E2=9C=94 Build for 32 bit x86
    =E2=9C=94 Debug build
    =E2=9C=94 Enable asserts
    Test meson builds

Experimental builds:
    =E2=9C=94 Enable address sanitizer
    =E2=9C=98 Enable extra warnings (edit meson.build) for
        -Wvla, -Wformat-truncation, -Waddress-of-packed-member

../drivers/net/rnp/base/rnp_mbx_fw.c: In function =E2=80=98rnp_fw_init=E2=
=80=99:
../drivers/net/rnp/base/rnp_mbx_fw.c:196:40: warning: =E2=80=98%s=E2=80=99 =
directive output may be truncated writing up to 63 bytes into a region of s=
ize 18 [-Wformat-truncation=3D]
  196 |                         "fw_req_cookie_%s",
      |                                        ^~
../drivers/net/rnp/base/rnp_mbx_fw.c:195:9: note: =E2=80=98snprintf=E2=80=
=99 output between 15 and 78 bytes into a destination of size 32
  195 |         snprintf(fw_info->cookie_name, RTE_MEMZONE_NAMESIZE,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  196 |                         "fw_req_cookie_%s",
      |                         ~~~~~~~~~~~~~~~~~~~
  197 |                         hw->device_name);


Look for anti-patterns:
    =E2=9C=98 Driver must not disable warnings with compiler flags or pragm=
a's
    =E2=9C=94 Driver must not use thread and signal
    =E2=9C=98 Apply coccinelle scripts; look that for example null free che=
cks
    =E2=9C=98 Review use of memcpy/rte_memcpy
    =E2=9C=94 Review use of malloc
    =E2=9C=94 Review use of memset
    =E2=9C=94 Review locking
      Unnecessary locking in base code??

