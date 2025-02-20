Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D06C021B3
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 17:44:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D4DA402CB;
	Thu, 20 Feb 2025 18:44:38 +0100 (CET)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com
 [209.85.222.42]) by mails.dpdk.org (Postfix) with ESMTP id CBE4D402C3
 for <dev@dpdk.org>; Thu, 20 Feb 2025 18:44:35 +0100 (CET)
Received: by mail-ua1-f42.google.com with SMTP id
 a1e0cc1a2514c-860f0e91121so1572902241.0
 for <dev@dpdk.org>; Thu, 20 Feb 2025 09:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740073475;
 x=1740678275; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TpfvN6T6ibp8+yqF8PqIZar8kSI63Y33xIaUtqgBo3Y=;
 b=BLiiVPghyx9qlv+0oPSetEVm0nKt5/wQl64elOCHsK92s39MKvPkDlA36swK5JOrMC
 NsMT0gsl9bT1/+Ul9HBvxtjgToZZitTqfSbqUGwKEh5t4yArxef8zbFm8OOskFdoVJBk
 DOl5NCjPFaw3tu6McUzw2Zl5hQUDsVb5qwyjqQNshr31mo4DsXAR9hPo1NHoulcdDV54
 /Fk5lQAXafyohqN9ihMVvgTfAacvUEj+ejbkdygLm00/iNnOrYc3gugKJJBoF7pX8IvV
 MVpQq+yOAw1aqV8YHuAO6pfX0KWdAdCtmRbchPsMWl4XlRT6O1ynijAZKzZnxKpk65iP
 2BiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740073475; x=1740678275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TpfvN6T6ibp8+yqF8PqIZar8kSI63Y33xIaUtqgBo3Y=;
 b=iksVEi7HBV/adGSjSLIN/rGdS4ciISWN/rXncPd98QAxADDIrIwI4jFv6+5cBPJSpg
 Mej1W35gr/NdwQYtUvRcUzNl+JqB77KeC0yhk0qYj0NJrSk3ylKb8RQDjqpXvpOVNW3+
 o/L7nP8eF/ZLs4Xa4fYc8x7nd97zN0x/rjkekzNaxSN4TW1RXN6bLfbpiresmQVBdMR+
 GqwcpGwRDCzY92CXCNC6ioX6H/1BEhagFmW4ZNsgozbigfZaOzNqmzE/cLNSVjrh+E/X
 FYXhfeWvTKoRGWot42VtpDC/C04hQKS75I+91p4GQp1+0A0YeCYMtsmssrNB79JymWZ1
 YkKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsQUOUuPPLQWuxDfJufrl4UcW6Ug9dPJvODqLbo5Rl1XKtF4/z+MGw1yL+sitpEGCn55Y=@dpdk.org
X-Gm-Message-State: AOJu0Yzwp+o3kGJjHXeIHkPgP27HFDCuKCmYHXQpDeOa402lCWamltHm
 qhSB7ibuJ4vsSBwHf5PK1AZlAukrGgrUF7zJwQivQm4wLqqbuArb82RJS7lS/E+9IVOzA5rzp0K
 Wl7ZTmVFiA3nRRZhCilB2GCNxHMC+/2gpD3fWcg==
X-Gm-Gg: ASbGncsH8jjRU2CfPCJ9zVtOTuJne+YU11d/utHDNDQvz4+FD7SoyLDhI+ykpMRQFwo
 gRnfB7TnsyLetZC0Avm0Jos4HAHx9H5+L7qkCiVUiPbDvszzKFLwxZ0Bbs0QpjVKKOGD1dfFZCA
 ==
X-Google-Smtp-Source: AGHT+IGOLraJtGwPukjOqBxjJ/XsB4avscDbKaZvQe0w+32O8q5GWRS/WiycGGkVIb81Q3JzrW0TuIl8hnVyPyaBMNM=
X-Received: by 2002:a05:6122:d13:b0:520:f35e:1a42 with SMTP id
 71dfb90a1353d-521dcf81ce6mr2667840e0c.4.1740073474884; Thu, 20 Feb 2025
 09:44:34 -0800 (PST)
MIME-Version: 1.0
References: <1739951849-67601-1-git-send-email-caowenbo@mucse.com>
In-Reply-To: <1739951849-67601-1-git-send-email-caowenbo@mucse.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Thu, 20 Feb 2025 09:44:24 -0800
X-Gm-Features: AWEUYZns-2kK_27H5Zqo6O_tnKELQWMgGJsD-LWUDUohQB4gsW9vs8808IfNL18
Message-ID: <CAOaVG14Xh899t0auHc+ePdV0tzg9Oa+2O29aA5M1bbRBQ5RkzQ@mail.gmail.com>
Subject: Re: [PATCH v13 00/28] [v13]drivers/net Add Support mucse N10 Pmd
 Driver
To: Wenbo Cao <caowenbo@mucse.com>
Cc: thomas@monjalon.net, dev@dpdk.org, ferruh.yigit@amd.com, 
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Content-Type: multipart/alternative; boundary="0000000000005aa03f062e966dfe"
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

--0000000000005aa03f062e966dfe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ran PVS studio against this patchset. The resulting warnings for
drivers/net/rnp were:

MESSAGES
LocationCodeMessage
Fails/Info

rnp_mac.c (251)
V610 <https://pvs-studio.com/en/docs/warnings/v610/> Undefined behavior.
Check the shift operator '>>=3D'. The right operand ('....' =3D [0..65535])=
 is
greater than or equal to the length in bits of the promoted left operand.

rnp_mac.c (198)
V525 <https://pvs-studio.com/en/docs/warnings/v525/> The code contains the
collection of similar blocks. Check items 'flt_reg', 'vlan_reg', 'vlan_reg'
in lines 198, 199, 200.

rnp_mac.c (202)
V525 <https://pvs-studio.com/en/docs/warnings/v525/> The code contains the
collection of similar blocks. Check items 'flt_reg', 'vlan_reg', 'vlan_reg'
in lines 202, 203, 204.

rnp_osdep.h (129)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fourth actual argument of the 'snprintf' function.
The memsize type argument is expected.

rnp_osdep.h (33)
V677 <https://pvs-studio.com/en/docs/warnings/v677/> Custom declaration of
a standard 'dma_addr_t' type. The declaration from system header files
should be used instead.

rnp_ethdev.c (106)
V1032 <https://pvs-studio.com/en/docs/warnings/v1032/> The pointer 'msgbuf'
is cast to a more strictly aligned pointer type.

rnp_ethdev.c (254)
V1051 <https://pvs-studio.com/en/docs/warnings/v1051/> Consider checking
for misprints. It's possible that the 'dma_ctrl' should be checked here.

rnp_ethdev.c (1325)
V525 <https://pvs-studio.com/en/docs/warnings/v525/> The code contains the
collection of similar blocks. Check items 'eth_stats', 'mac_stats',
'mac_stats' in lines 1325, 1331, 1337.

rnp_ethdev.c (110)
V641 <https://pvs-studio.com/en/docs/warnings/v641/> The size of the
'msgbuf' buffer is not a multiple of the element size of the type 'struct
rnp_mbx_fw_cmd_reply'.

rnp_ethdev.c (113)
V641 <https://pvs-studio.com/en/docs/warnings/v641/> The size of the
'msgbuf' buffer is not a multiple of the element size of the type 'struct
rnp_mbx_fw_cmd_req'.

rnp_ethdev.c (725)
V1027 <https://pvs-studio.com/en/docs/warnings/v1027/> Pointer to an object
of the 'rte_device' class is cast to unrelated 'rte_pci_device' class.

rnp_ethdev.c (1646)
V1027 <https://pvs-studio.com/en/docs/warnings/v1027/> Pointer to an object
of the 'rte_device' class is cast to unrelated 'rte_pci_device' class.

rnp_ethdev.c (1777)
V1027 <https://pvs-studio.com/en/docs/warnings/v1027/> Pointer to an object
of the 'rte_device' class is cast to unrelated 'rte_pci_device' class.

rnp_link.c (192)
V519 <https://pvs-studio.com/en/docs/warnings/v519/> The
'link.link_autoneg' variable is assigned values twice successively. Perhaps
this is a mistake. Check lines: 186, 192.

rnp_link.c (359)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression
'!port->attr.link_ready' is always true.

rnp_link.c (113)
V1048 <https://pvs-studio.com/en/docs/warnings/v1048/> The 'lane' variable
was assigned the same value.

rnp_rxtx.c (1412)
V684 <https://pvs-studio.com/en/docs/warnings/v684/> A value of the
variable 'txbd->d.cmd' is not modified. Consider inspecting the expression.
It is possible that '1' should be present instead of '0'.

rnp_rxtx.c (1226)
V1027 <https://pvs-studio.com/en/docs/warnings/v1027/> Pointer to an object
of the 'rte_ether_hdr' class is cast to unrelated 'rte_vlan_hdr' class.

On Tue, Feb 18, 2025 at 11:58=E2=80=AFPM Wenbo Cao <caowenbo@mucse.com> wro=
te:

> For This patchset just to support the basic chip init work
> and user can just found the eth_dev, but can't control more.
> For Now just support 2*10g nic,the chip can support
> 2*10g,4*10g,4*1g,8*1g,8*10g.
> The Feature rx side can support rx-cksum-offload,rss,vlan-filter
> flow_clow,uncast_filter,mcast_filter,1588,Jumbo-frame
> The Feature tx side can support tx-cksum-offload,tso,vxlan-tso
> flow director base on ntuple pattern of tcp/udp/ip/ eth_hdr->type
> for sriov is also support.
>
> Because of the chip design defect, for multiple-port mode
> one pci-bdf will have multiple-port (max can have four ports)
> so this code must be care of one bdf init multiple-port.
> v13:
>   * Supplementary document about n10 network card characteristics.
>   * update release_25_03.rst.
>   * fixed the code style advisea Stephen Hemminger.
>   * fixed the code issue check PVS-stdio for Static compilation error.
>
> v12:
>   * fixed __rte_packed __deprecated__ compile issue.
>
> v11:
>   * fixed array-bounds issue when used rte_memcpy src addr is
>   * not enough to hold align dst.
>   * improve efficient_code advised by Stephen
>
> v10:
>   * fixed mingw windows meson issue
>   * rnp not support windows for now.
>
> v9:
>   * fixed commit log format check by devtools.
>   * fixed code compile issue.
>
> v8:
>   * fixed codespell issue.
>   * fixed MAINTAINERS file
>
> v7:
>   * add support nic basic feature such as rss vlan strip/filter,
>   * mtu-change recv/send scater-recv/mutltiple-send.
>   * fixed code rationality, advised by Ferruh Yigit.
> v6:
>   * fixed the doc(rst) format problem advise by Thomas Monjalon
>
> v5:
>   * fixed the symbol name require by the style documentation
>
> v4:
>   * one patch has been forgot to upload :(
>
> v3:
>   * fixed http://dpdk.org/patch/129830 FreeBSD 13 compile Issue
>   * change iobar type to void suggest by Stephen Hemminger
>   * add KMOD_DEP support for vfio-pci
>   * change run-cmd argument parse check for invalid extra_args
>
> v2:
>   * fixed MAINTAIN maillist fullname format
>   * fixed driver/net/meson the order issue of new driver to driver list
>   * improve virtual point function usage suggest by Stephen Hemminger
>
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
>
>  .mailmap                               |    1 +
>  MAINTAINERS                            |    6 +
>  doc/guides/nics/features/rnp.ini       |   33 +
>  doc/guides/nics/img/mucse_nic_port.svg | 4023 ++++++++++++++++++++++++
>  doc/guides/nics/index.rst              |    1 +
>  doc/guides/nics/rnp.rst                |  124 +
>  doc/guides/rel_notes/release_25_03.rst |    5 +
>  drivers/net/meson.build                |    1 +
>  drivers/net/rnp/base/meson.build       |   17 +
>  drivers/net/rnp/base/rnp_bdq_if.c      |  398 +++
>  drivers/net/rnp/base/rnp_bdq_if.h      |  154 +
>  drivers/net/rnp/base/rnp_bitrev.h      |   64 +
>  drivers/net/rnp/base/rnp_common.c      |  103 +
>  drivers/net/rnp/base/rnp_common.h      |   17 +
>  drivers/net/rnp/base/rnp_crc32.c       |   37 +
>  drivers/net/rnp/base/rnp_crc32.h       |   10 +
>  drivers/net/rnp/base/rnp_dma_regs.h    |   68 +
>  drivers/net/rnp/base/rnp_eth_regs.h    |   91 +
>  drivers/net/rnp/base/rnp_fw_cmd.c      |  162 +
>  drivers/net/rnp/base/rnp_fw_cmd.h      |  357 +++
>  drivers/net/rnp/base/rnp_hw.h          |  136 +
>  drivers/net/rnp/base/rnp_mac.c         |  358 +++
>  drivers/net/rnp/base/rnp_mac.h         |   34 +
>  drivers/net/rnp/base/rnp_mac_regs.h    |  208 ++
>  drivers/net/rnp/base/rnp_mbx.c         |  510 +++
>  drivers/net/rnp/base/rnp_mbx.h         |   58 +
>  drivers/net/rnp/base/rnp_mbx_fw.c      |  493 +++
>  drivers/net/rnp/base/rnp_mbx_fw.h      |   24 +
>  drivers/net/rnp/base/rnp_osdep.h       |  172 +
>  drivers/net/rnp/meson.build            |   27 +
>  drivers/net/rnp/rnp.h                  |  258 ++
>  drivers/net/rnp/rnp_ethdev.c           | 1845 +++++++++++
>  drivers/net/rnp/rnp_link.c             |  439 +++
>  drivers/net/rnp/rnp_link.h             |   52 +
>  drivers/net/rnp/rnp_logs.h             |   36 +
>  drivers/net/rnp/rnp_rss.c              |  367 +++
>  drivers/net/rnp/rnp_rss.h              |   44 +
>  drivers/net/rnp/rnp_rxtx.c             | 1818 +++++++++++
>  drivers/net/rnp/rnp_rxtx.h             |  162 +
>  39 files changed, 12713 insertions(+)
>  create mode 100644 doc/guides/nics/features/rnp.ini
>  create mode 100644 doc/guides/nics/img/mucse_nic_port.svg
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
>
> --
> 2.25.1
>
>

--0000000000005aa03f062e966dfe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:arial,sans-serif;font-size:small">Ran PVS studio against this patc=
hset. The resulting warnings for drivers/net/rnp were:<br></div><div class=
=3D"gmail_default" style=3D"font-family:arial,sans-serif;font-size:small"><=
br></div><div class=3D"gmail_default" style=3D"font-family:arial,sans-serif=
;font-size:small"><table style=3D"color:rgb(0,0,0);font-variant-numeric:nor=
mal;font-variant-east-asian:normal;font-variant-alternates:normal;font-size=
-adjust:none;font-kerning:auto;font-feature-settings:normal;font-stretch:no=
rmal;font-size:12pt;line-height:normal;font-family:&quot;normal Century Got=
hic&quot;;width:2273px"><caption style=3D"font-weight:bold;background-image=
:initial;background-position:initial;background-size:initial;background-rep=
eat:initial;background-origin:initial;background-clip:initial;border:none">=
MESSAGES</caption><tbody><tr style=3D"background:black;color:white"><th sty=
le=3D"width:677.5px">Location</th><th style=3D"width:111.25px">Code</th><th=
 style=3D"width:1470.25px">Message</th></tr><tr style=3D"background:lightcy=
an"><td colspan=3D"5" style=3D"padding:0px;text-align:center;vertical-align=
:top;color:red;font-size:1.2em">Fails/Info</td></tr><tr><td style=3D"paddin=
g:0px;vertical-align:top;width:679.5px"><div title=3D"/home/shemminger/DPDK=
/rnp/drivers/net/rnp/base/rnp_mac.c">rnp_mac.c (251)</div></td><td style=3D=
"padding:0px;vertical-align:top;width:113.25px"><a target=3D"_blank" href=
=3D"https://pvs-studio.com/en/docs/warnings/v610/">V610</a></td><td style=
=3D"padding:0px;vertical-align:top;width:1472.25px">Undefined behavior. Che=
ck the shift operator &#39;&gt;&gt;=3D&#39;. The right operand (&#39;....&#=
39; =3D [0..65535]) is greater than or equal to the length in bits of the p=
romoted left operand.</td></tr><tr><td style=3D"padding:0px;vertical-align:=
top;width:679.5px"><div title=3D"/home/shemminger/DPDK/rnp/drivers/net/rnp/=
base/rnp_mac.c">rnp_mac.c (198)</div></td><td style=3D"padding:0px;vertical=
-align:top;width:113.25px"><a target=3D"_blank" href=3D"https://pvs-studio.=
com/en/docs/warnings/v525/">V525</a></td><td style=3D"padding:0px;vertical-=
align:top;width:1472.25px">The code contains the collection of similar bloc=
ks. Check items &#39;flt_reg&#39;, &#39;vlan_reg&#39;, &#39;vlan_reg&#39; i=
n lines 198, 199, 200.</td></tr><tr><td style=3D"padding:0px;vertical-align=
:top;width:679.5px"><div title=3D"/home/shemminger/DPDK/rnp/drivers/net/rnp=
/base/rnp_mac.c">rnp_mac.c (202)</div></td><td style=3D"padding:0px;vertica=
l-align:top;width:113.25px"><a target=3D"_blank" href=3D"https://pvs-studio=
.com/en/docs/warnings/v525/">V525</a></td><td style=3D"padding:0px;vertical=
-align:top;width:1472.25px">The code contains the collection of similar blo=
cks. Check items &#39;flt_reg&#39;, &#39;vlan_reg&#39;, &#39;vlan_reg&#39; =
in lines 202, 203, 204.</td></tr><tr><td style=3D"padding:0px;vertical-alig=
n:top;width:679.5px"><div title=3D"/home/shemminger/DPDK/rnp/drivers/net/rn=
p/base/rnp_osdep.h">rnp_osdep.h (129)</div></td><td style=3D"padding:0px;ve=
rtical-align:top;width:113.25px"><a target=3D"_blank" href=3D"https://pvs-s=
tudio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;ver=
tical-align:top;width:1472.25px">Incorrect format. Consider checking the fo=
urth actual argument of the &#39;snprintf&#39; function. The memsize type a=
rgument is expected.</td></tr><tr><td style=3D"padding:0px;vertical-align:t=
op;width:679.5px"><div title=3D"/home/shemminger/DPDK/rnp/drivers/net/rnp/b=
ase/rnp_osdep.h">rnp_osdep.h (33)</div></td><td style=3D"padding:0px;vertic=
al-align:top;width:113.25px"><a target=3D"_blank" href=3D"https://pvs-studi=
o.com/en/docs/warnings/v677/">V677</a></td><td style=3D"padding:0px;vertica=
l-align:top;width:1472.25px">Custom declaration of a standard &#39;dma_addr=
_t&#39; type. The declaration from system header files should be used inste=
ad.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:679.5px"=
><div title=3D"/home/shemminger/DPDK/rnp/drivers/net/rnp/rnp_ethdev.c">rnp_=
ethdev.c (106)</div></td><td style=3D"padding:0px;vertical-align:top;width:=
113.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warni=
ngs/v1032/">V1032</a></td><td style=3D"padding:0px;vertical-align:top;width=
:1472.25px">The pointer &#39;msgbuf&#39; is cast to a more strictly aligned=
 pointer type.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;wid=
th:679.5px"><div title=3D"/home/shemminger/DPDK/rnp/drivers/net/rnp/rnp_eth=
dev.c">rnp_ethdev.c (254)</div></td><td style=3D"padding:0px;vertical-align=
:top;width:113.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en=
/docs/warnings/v1051/">V1051</a></td><td style=3D"padding:0px;vertical-alig=
n:top;width:1472.25px">Consider checking for misprints. It&#39;s possible t=
hat the &#39;dma_ctrl&#39; should be checked here.</td></tr><tr><td style=
=3D"padding:0px;vertical-align:top;width:679.5px"><div title=3D"/home/shemm=
inger/DPDK/rnp/drivers/net/rnp/rnp_ethdev.c">rnp_ethdev.c (1325)</div></td>=
<td style=3D"padding:0px;vertical-align:top;width:113.25px"><a target=3D"_b=
lank" href=3D"https://pvs-studio.com/en/docs/warnings/v525/">V525</a></td><=
td style=3D"padding:0px;vertical-align:top;width:1472.25px">The code contai=
ns the collection of similar blocks. Check items &#39;eth_stats&#39;, &#39;=
mac_stats&#39;, &#39;mac_stats&#39; in lines 1325, 1331, 1337.</td></tr><tr=
><td style=3D"padding:0px;vertical-align:top;width:679.5px"><div title=3D"/=
home/shemminger/DPDK/rnp/drivers/net/rnp/rnp_ethdev.c">rnp_ethdev.c (110)</=
div></td><td style=3D"padding:0px;vertical-align:top;width:113.25px"><a tar=
get=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v641/">V641<=
/a></td><td style=3D"padding:0px;vertical-align:top;width:1472.25px">The si=
ze of the &#39;msgbuf&#39; buffer is not a multiple of the element size of =
the type &#39;struct rnp_mbx_fw_cmd_reply&#39;.</td></tr><tr><td style=3D"p=
adding:0px;vertical-align:top;width:679.5px"><div title=3D"/home/shemminger=
/DPDK/rnp/drivers/net/rnp/rnp_ethdev.c">rnp_ethdev.c (113)</div></td><td st=
yle=3D"padding:0px;vertical-align:top;width:113.25px"><a target=3D"_blank" =
href=3D"https://pvs-studio.com/en/docs/warnings/v641/">V641</a></td><td sty=
le=3D"padding:0px;vertical-align:top;width:1472.25px">The size of the &#39;=
msgbuf&#39; buffer is not a multiple of the element size of the type &#39;s=
truct rnp_mbx_fw_cmd_req&#39;.</td></tr><tr><td style=3D"padding:0px;vertic=
al-align:top;width:679.5px"><div title=3D"/home/shemminger/DPDK/rnp/drivers=
/net/rnp/rnp_ethdev.c">rnp_ethdev.c (725)</div></td><td style=3D"padding:0p=
x;vertical-align:top;width:113.25px"><a target=3D"_blank" href=3D"https://p=
vs-studio.com/en/docs/warnings/v1027/">V1027</a></td><td style=3D"padding:0=
px;vertical-align:top;width:1472.25px">Pointer to an object of the &#39;rte=
_device&#39; class is cast to unrelated &#39;rte_pci_device&#39; class.</td=
></tr><tr><td style=3D"padding:0px;vertical-align:top;width:679.5px"><div t=
itle=3D"/home/shemminger/DPDK/rnp/drivers/net/rnp/rnp_ethdev.c">rnp_ethdev.=
c (1646)</div></td><td style=3D"padding:0px;vertical-align:top;width:113.25=
px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v1=
027/">V1027</a></td><td style=3D"padding:0px;vertical-align:top;width:1472.=
25px">Pointer to an object of the &#39;rte_device&#39; class is cast to unr=
elated &#39;rte_pci_device&#39; class.</td></tr><tr><td style=3D"padding:0p=
x;vertical-align:top;width:679.5px"><div title=3D"/home/shemminger/DPDK/rnp=
/drivers/net/rnp/rnp_ethdev.c">rnp_ethdev.c (1777)</div></td><td style=3D"p=
adding:0px;vertical-align:top;width:113.25px"><a target=3D"_blank" href=3D"=
https://pvs-studio.com/en/docs/warnings/v1027/">V1027</a></td><td style=3D"=
padding:0px;vertical-align:top;width:1472.25px">Pointer to an object of the=
 &#39;rte_device&#39; class is cast to unrelated &#39;rte_pci_device&#39; c=
lass.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:679.5p=
x"><div title=3D"/home/shemminger/DPDK/rnp/drivers/net/rnp/rnp_link.c">rnp_=
link.c (192)</div></td><td style=3D"padding:0px;vertical-align:top;width:11=
3.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warning=
s/v519/">V519</a></td><td style=3D"padding:0px;vertical-align:top;width:147=
2.25px">The &#39;link.link_autoneg&#39; variable is assigned values twice s=
uccessively. Perhaps this is a mistake. Check lines: 186, 192.</td></tr><tr=
><td style=3D"padding:0px;vertical-align:top;width:679.5px"><div title=3D"/=
home/shemminger/DPDK/rnp/drivers/net/rnp/rnp_link.c">rnp_link.c (359)</div>=
</td><td style=3D"padding:0px;vertical-align:top;width:113.25px"><a target=
=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v547/">V547</a>=
</td><td style=3D"padding:0px;vertical-align:top;width:1472.25px">Expressio=
n &#39;!port-&gt;attr.link_ready&#39; is always true.</td></tr><tr><td styl=
e=3D"padding:0px;vertical-align:top;width:679.5px"><div title=3D"/home/shem=
minger/DPDK/rnp/drivers/net/rnp/rnp_link.c">rnp_link.c (113)</div></td><td =
style=3D"padding:0px;vertical-align:top;width:113.25px"><a target=3D"_blank=
" href=3D"https://pvs-studio.com/en/docs/warnings/v1048/">V1048</a></td><td=
 style=3D"padding:0px;vertical-align:top;width:1472.25px">The &#39;lane&#39=
; variable was assigned the same value.</td></tr><tr><td style=3D"padding:0=
px;vertical-align:top;width:679.5px"><div title=3D"/home/shemminger/DPDK/rn=
p/drivers/net/rnp/rnp_rxtx.c">rnp_rxtx.c (1412)</div></td><td style=3D"padd=
ing:0px;vertical-align:top;width:113.25px"><a target=3D"_blank" href=3D"htt=
ps://pvs-studio.com/en/docs/warnings/v684/">V684</a></td><td style=3D"paddi=
ng:0px;vertical-align:top;width:1472.25px">A value of the variable &#39;txb=
d-&gt;d.cmd&#39; is not modified. Consider inspecting the expression. It is=
 possible that &#39;1&#39; should be present instead of &#39;0&#39;.</td></=
tr><tr><td style=3D"padding:0px;vertical-align:top;width:679.5px"><div titl=
e=3D"/home/shemminger/DPDK/rnp/drivers/net/rnp/rnp_rxtx.c">rnp_rxtx.c (1226=
)</div></td><td style=3D"padding:0px;vertical-align:top;width:113.25px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v1027/">V=
1027</a></td><td style=3D"padding:0px;vertical-align:top;width:1472.25px">P=
ointer to an object of the &#39;rte_ether_hdr&#39; class is cast to unrelat=
ed &#39;rte_vlan_hdr&#39; class.</td></tr></tbody></table></div></div></div=
><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Tue, Feb 18, 2025 at 11:58=E2=80=AFPM Wenbo Cao &lt;<a =
href=3D"mailto:caowenbo@mucse.com">caowenbo@mucse.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">For This patchset just=
 to support the basic chip init work<br>
and user can just found the eth_dev, but can&#39;t control more.<br>
For Now just support 2*10g nic,the chip can support<br>
2*10g,4*10g,4*1g,8*1g,8*10g.<br>
The Feature rx side can support rx-cksum-offload,rss,vlan-filter<br>
flow_clow,uncast_filter,mcast_filter,1588,Jumbo-frame<br>
The Feature tx side can support tx-cksum-offload,tso,vxlan-tso <br>
flow director base on ntuple pattern of tcp/udp/ip/ eth_hdr-&gt;type<br>
for sriov is also support.<br>
<br>
Because of the chip design defect, for multiple-port mode<br>
one pci-bdf will have multiple-port (max can have four ports)<br>
so this code must be care of one bdf init multiple-port.<br>
v13:<br>
=C2=A0 * Supplementary document about n10 network card characteristics.<br>
=C2=A0 * update release_25_03.rst.<br>
=C2=A0 * fixed the code style advisea Stephen Hemminger.<br>
=C2=A0 * fixed the code issue check PVS-stdio for Static compilation error.=
<br>
<br>
v12:<br>
=C2=A0 * fixed __rte_packed __deprecated__ compile issue.<br>
<br>
v11:<br>
=C2=A0 * fixed array-bounds issue when used rte_memcpy src addr is<br>
=C2=A0 * not enough to hold align dst.<br>
=C2=A0 * improve efficient_code advised by Stephen<br>
<br>
v10:<br>
=C2=A0 * fixed mingw windows meson issue<br>
=C2=A0 * rnp not support windows for now.<br>
<br>
v9:<br>
=C2=A0 * fixed commit log format check by devtools.<br>
=C2=A0 * fixed code compile issue.<br>
<br>
v8:<br>
=C2=A0 * fixed codespell issue.<br>
=C2=A0 * fixed MAINTAINERS file<br>
<br>
v7:<br>
=C2=A0 * add support nic basic feature such as rss vlan strip/filter,<br>
=C2=A0 * mtu-change recv/send scater-recv/mutltiple-send.<br>
=C2=A0 * fixed code rationality, advised by Ferruh Yigit.<br>
v6:<br>
=C2=A0 * fixed the doc(rst) format problem advise by Thomas Monjalon<br>
<br>
v5:<br>
=C2=A0 * fixed the symbol name require by the style documentation<br>
<br>
v4:<br>
=C2=A0 * one patch has been forgot to upload :(<br>
<br>
v3:<br>
=C2=A0 * fixed <a href=3D"http://dpdk.org/patch/129830" rel=3D"noreferrer" =
target=3D"_blank">http://dpdk.org/patch/129830</a> FreeBSD 13 compile Issue=
<br>
=C2=A0 * change iobar type to void suggest by Stephen Hemminger<br>
=C2=A0 * add KMOD_DEP support for vfio-pci<br>
=C2=A0 * change run-cmd argument parse check for invalid extra_args<br>
<br>
v2:<br>
=C2=A0 * fixed MAINTAIN maillist fullname format<br>
=C2=A0 * fixed driver/net/meson the order issue of new driver to driver lis=
t<br>
=C2=A0 * improve virtual point function usage suggest by Stephen Hemminger<=
br>
<br>
Wenbo Cao (28):<br>
=C2=A0 net/rnp: add skeleton<br>
=C2=A0 net/rnp: add ethdev probe and remove<br>
=C2=A0 net/rnp: add log<br>
=C2=A0 net/rnp: support mailbox basic operate<br>
=C2=A0 net/rnp: add device init and uninit<br>
=C2=A0 net/rnp: add get device information operation<br>
=C2=A0 net/rnp: add support MAC promisc mode<br>
=C2=A0 net/rnp: add queue setup and release operations<br>
=C2=A0 net/rnp: add queue stop and start operations<br>
=C2=A0 net/rnp: add support device start stop operations<br>
=C2=A0 net/rnp: add RSS support operations<br>
=C2=A0 net/rnp: add support link update operations<br>
=C2=A0 net/rnp: add support link setup operations<br>
=C2=A0 net/rnp: add Rx burst simple support<br>
=C2=A0 net/rnp: add Tx burst simple support<br>
=C2=A0 net/rnp: add MTU set operation<br>
=C2=A0 net/rnp: add Rx scatter segment version<br>
=C2=A0 net/rnp: add Tx multiple segment version<br>
=C2=A0 net/rnp: add support basic stats operation<br>
=C2=A0 net/rnp: add support xstats operation<br>
=C2=A0 net/rnp: add unicast MAC filter operation<br>
=C2=A0 net/rnp: add supported packet types<br>
=C2=A0 net/rnp: add support Rx checksum offload<br>
=C2=A0 net/rnp: add support Tx TSO offload<br>
=C2=A0 net/rnp: support VLAN offloads<br>
=C2=A0 net/rnp: add support VLAN filters operations<br>
=C2=A0 net/rnp: add queue info operation<br>
=C2=A0 net/rnp: support Rx/Tx burst mode info<br>
<br>
=C2=A0.mailmap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 1 +<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 6 +<br>
=C2=A0doc/guides/nics/features/rnp.ini=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A033 +<br>
=C2=A0doc/guides/nics/img/mucse_nic_port.svg | 4023 +++++++++++++++++++++++=
+<br>
=C2=A0doc/guides/nics/index.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 1 +<br>
=C2=A0doc/guides/nics/rnp.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 124 +<br>
=C2=A0doc/guides/rel_notes/release_25_03.rst |=C2=A0 =C2=A0 5 +<br>
=C2=A0drivers/net/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A0 1 +<br>
=C2=A0drivers/net/rnp/base/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A017 +<br>
=C2=A0drivers/net/rnp/base/rnp_bdq_if.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 398 +++=
<br>
=C2=A0drivers/net/rnp/base/rnp_bdq_if.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 154 +<b=
r>
=C2=A0drivers/net/rnp/base/rnp_bitrev.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06=
4 +<br>
=C2=A0drivers/net/rnp/base/rnp_common.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 103 +<b=
r>
=C2=A0drivers/net/rnp/base/rnp_common.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01=
7 +<br>
=C2=A0drivers/net/rnp/base/rnp_crc32.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A037 +<br>
=C2=A0drivers/net/rnp/base/rnp_crc32.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A010 +<br>
=C2=A0drivers/net/rnp/base/rnp_dma_regs.h=C2=A0 =C2=A0 |=C2=A0 =C2=A068 +<b=
r>
=C2=A0drivers/net/rnp/base/rnp_eth_regs.h=C2=A0 =C2=A0 |=C2=A0 =C2=A091 +<b=
r>
=C2=A0drivers/net/rnp/base/rnp_fw_cmd.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 162 +<b=
r>
=C2=A0drivers/net/rnp/base/rnp_fw_cmd.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 357 +++=
<br>
=C2=A0drivers/net/rnp/base/rnp_hw.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 136 +<br>
=C2=A0drivers/net/rnp/base/rnp_mac.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 358 +++<br>
=C2=A0drivers/net/rnp/base/rnp_mac.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A034 +<br>
=C2=A0drivers/net/rnp/base/rnp_mac_regs.h=C2=A0 =C2=A0 |=C2=A0 208 ++<br>
=C2=A0drivers/net/rnp/base/rnp_mbx.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 510 +++<br>
=C2=A0drivers/net/rnp/base/rnp_mbx.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A058 +<br>
=C2=A0drivers/net/rnp/base/rnp_mbx_fw.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 493 +++=
<br>
=C2=A0drivers/net/rnp/base/rnp_mbx_fw.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02=
4 +<br>
=C2=A0drivers/net/rnp/base/rnp_osdep.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 17=
2 +<br>
=C2=A0drivers/net/rnp/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 =C2=A027 +<br>
=C2=A0drivers/net/rnp/rnp.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 258 ++<br>
=C2=A0drivers/net/rnp/rnp_ethdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| 1845 +++++++++++<br>
=C2=A0drivers/net/rnp/rnp_link.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 439 +++<br>
=C2=A0drivers/net/rnp/rnp_link.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A052 +<br>
=C2=A0drivers/net/rnp/rnp_logs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A036 +<br>
=C2=A0drivers/net/rnp/rnp_rss.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 367 +++<br>
=C2=A0drivers/net/rnp/rnp_rss.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A044 +<br>
=C2=A0drivers/net/rnp/rnp_rxtx.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 1818 +++++++++++<br>
=C2=A0drivers/net/rnp/rnp_rxtx.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 162 +<br>
=C2=A039 files changed, 12713 insertions(+)<br>
=C2=A0create mode 100644 doc/guides/nics/features/rnp.ini<br>
=C2=A0create mode 100644 doc/guides/nics/img/mucse_nic_port.svg<br>
=C2=A0create mode 100644 doc/guides/nics/rnp.rst<br>
=C2=A0create mode 100644 drivers/net/rnp/base/meson.build<br>
=C2=A0create mode 100644 drivers/net/rnp/base/rnp_bdq_if.c<br>
=C2=A0create mode 100644 drivers/net/rnp/base/rnp_bdq_if.h<br>
=C2=A0create mode 100644 drivers/net/rnp/base/rnp_bitrev.h<br>
=C2=A0create mode 100644 drivers/net/rnp/base/rnp_common.c<br>
=C2=A0create mode 100644 drivers/net/rnp/base/rnp_common.h<br>
=C2=A0create mode 100644 drivers/net/rnp/base/rnp_crc32.c<br>
=C2=A0create mode 100644 drivers/net/rnp/base/rnp_crc32.h<br>
=C2=A0create mode 100644 drivers/net/rnp/base/rnp_dma_regs.h<br>
=C2=A0create mode 100644 drivers/net/rnp/base/rnp_eth_regs.h<br>
=C2=A0create mode 100644 drivers/net/rnp/base/rnp_fw_cmd.c<br>
=C2=A0create mode 100644 drivers/net/rnp/base/rnp_fw_cmd.h<br>
=C2=A0create mode 100644 drivers/net/rnp/base/rnp_hw.h<br>
=C2=A0create mode 100644 drivers/net/rnp/base/rnp_mac.c<br>
=C2=A0create mode 100644 drivers/net/rnp/base/rnp_mac.h<br>
=C2=A0create mode 100644 drivers/net/rnp/base/rnp_mac_regs.h<br>
=C2=A0create mode 100644 drivers/net/rnp/base/rnp_mbx.c<br>
=C2=A0create mode 100644 drivers/net/rnp/base/rnp_mbx.h<br>
=C2=A0create mode 100644 drivers/net/rnp/base/rnp_mbx_fw.c<br>
=C2=A0create mode 100644 drivers/net/rnp/base/rnp_mbx_fw.h<br>
=C2=A0create mode 100644 drivers/net/rnp/base/rnp_osdep.h<br>
=C2=A0create mode 100644 drivers/net/rnp/meson.build<br>
=C2=A0create mode 100644 drivers/net/rnp/rnp.h<br>
=C2=A0create mode 100644 drivers/net/rnp/rnp_ethdev.c<br>
=C2=A0create mode 100644 drivers/net/rnp/rnp_link.c<br>
=C2=A0create mode 100644 drivers/net/rnp/rnp_link.h<br>
=C2=A0create mode 100644 drivers/net/rnp/rnp_logs.h<br>
=C2=A0create mode 100644 drivers/net/rnp/rnp_rss.c<br>
=C2=A0create mode 100644 drivers/net/rnp/rnp_rss.h<br>
=C2=A0create mode 100644 drivers/net/rnp/rnp_rxtx.c<br>
=C2=A0create mode 100644 drivers/net/rnp/rnp_rxtx.h<br>
<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div>

--0000000000005aa03f062e966dfe--
