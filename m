Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4BBC02198
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Feb 2025 00:44:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B50DE4028A;
	Sat, 15 Feb 2025 01:44:05 +0100 (CET)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172])
 by mails.dpdk.org (Postfix) with ESMTP id 39F4640281
 for <dev@dpdk.org>; Sat, 15 Feb 2025 01:44:04 +0100 (CET)
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-51eb1823a8eso730971e0c.3
 for <dev@dpdk.org>; Fri, 14 Feb 2025 16:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739580243;
 x=1740185043; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NV8aMFFg1gQdubE3BPQ7ubRR0tc4p1LxgJTV4mBD+4Y=;
 b=m4q+9FfvFpYj6pPT0NpszCb9EHFcfJJ7zF1CphBOcLBgpbO7i3q3dk/7IJkmFa/PtA
 4NqS8HBtVKYLbUs4A9l0mWzgPZXkcEJBHsBdJmVvy+FLqGEbbW9VR1F4d1rD3hAIrYJr
 rXETyrlbo3tLGPgwIqbteO43gOZjGiALtL4MPEe4dNCm+ZGZaX4AUCGHwlvuOuSuKVuR
 /yq9vMcNP3+bmSufd+HmYJ48025gvnSkl/Mj7gg/TWYb4dpRmQYq3ZyIiCmn2wpCJJoL
 LLfo5KW1bcX1vOf+dOaen+uIAJWay98SfCjbSRHWAQ/nkqBxXW4il4X9GKT93LE9siSv
 TDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739580243; x=1740185043;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NV8aMFFg1gQdubE3BPQ7ubRR0tc4p1LxgJTV4mBD+4Y=;
 b=ijR3WWW+dIGki/lvEITjGhr6EQ/JU8XCyAP1qaBYAtbta7BhyoVWe+fVJLGFjrQssD
 hW39Uk4qv6k/7xpDP/8WkKRi7WwpxZ1Ihc9Tp9Vvd9vCdaI5eu1ARoq1AcfxD4rnbWBc
 SFFJf25tW+X6hobe59TTxfcaDETxId38q95AnvnKaPjd4FNznb8hROqBMhYP6elgU31n
 yaVRNQ5ue50fsECPGefALbIgNEHKTeXWD9+UIOvIghoSHpqSh7GlzVzrpS7zZH/L0aT0
 s5LfmAVPL3UMH172/XV7Hpnp1pOpKyJJdKuepCSQubBXzeBuOhbk2meVbdxMT0ipbK/W
 aaDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSxvcMUUC/JvANYWDPgEbtSIfEa9iX9NayH4Xm/GVhYlBAKhr2lqi7MSqWiwOCzxNtgvQ=@dpdk.org
X-Gm-Message-State: AOJu0YyXz8YmqqjG3XAf673WmtdNye9LH6w/I1kz3PQP0L7ZUq6rV8TE
 BF8GuMZFkDKjLYpySMsjGqyvTm8O/0c0qWduz8U+AnWbJw/R44RIJs9ZmhMurbo7nSb9IbtIw7M
 KrbrJvWj8HS5lhJyTrr3ugAvzDc8Doytb0ITYjA==
X-Gm-Gg: ASbGncvtfP3kFKB0lh/aYha2HH3wOayXqKpLW2utyK1K4A8gLDFGEccOv+bqAcq2JIM
 2HNlh4giw8C2P731EFyKYGJub7NET4EhlI+MCWU1dKdyM9b2mJtZosvFJEgEfcr5ex3Ve/SMdng
 ==
X-Google-Smtp-Source: AGHT+IHgXBDVtCgZ8Hvl2OqeFO52gt5+83TXekHf+rO0rrQbUhzWZyVJOHZ6z1+HpbN5VxTRhCMYfSm70KVx98qT1Qw=
X-Received: by 2002:a05:6122:270c:b0:520:42d3:91d2 with SMTP id
 71dfb90a1353d-5209da3cd5fmr728954e0c.1.1739580243238; Fri, 14 Feb 2025
 16:44:03 -0800 (PST)
MIME-Version: 1.0
References: <1739374368-4949-1-git-send-email-caowenbo@mucse.com>
In-Reply-To: <1739374368-4949-1-git-send-email-caowenbo@mucse.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Fri, 14 Feb 2025 16:43:52 -0800
X-Gm-Features: AWEUYZkwVMB_JE2rSxE4wcdbDkiCLtUNGAXFrivl38JHbO5nc9O2qBVBnRQdKsw
Message-ID: <CAOaVG16TbQ3mTJn0Xr-sbOfCowV3AfR7RTTALajTqwCLoMYCxA@mail.gmail.com>
Subject: Re: [PATCH v12 00/28] [v12]drivers/net Add Support mucse N10 Pmd
 Driver
To: Wenbo Cao <caowenbo@mucse.com>
Cc: thomas@monjalon.net, dev@dpdk.org, ferruh.yigit@amd.com, 
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Content-Type: multipart/alternative; boundary="000000000000750149062e239631"
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

--000000000000750149062e239631
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I ran this driver through the evaluation copy of PVS studio and it reported
many warnings you should address.
Not all of them are valid, the tool seems to have a lot of false positives.

MESSAGES
LocationCodeMessage
Fails/Info

rnp_mac.c (258)
V610 <https://pvs-studio.com/en/docs/warnings/v610/> Undefined behavior.
Check the shift operator '>>'. The right operand ('....' =3D
[0x0..0xFFFFFFFFFFFFFFFF]) is greater than or equal to the length in bits
of the promoted left operand.

rnp_mac.c (81)
V1037 <https://pvs-studio.com/en/docs/warnings/v1037/> Two or more
case-branches perform the same actions. Check lines: 81, 84

rnp_mac.c (205)
V525 <https://pvs-studio.com/en/docs/warnings/v525/> The code contains the
collection of similar blocks. Check items 'flt_reg', 'vlan_reg', 'vlan_reg'
in lines 205, 206, 207.

rnp_mac.c (209)
V525 <https://pvs-studio.com/en/docs/warnings/v525/> The code contains the
collection of similar blocks. Check items 'flt_reg', 'vlan_reg', 'vlan_reg'
in lines 209, 210, 211.

rnp_mbx.c (398)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression '!ret_val'
is always true.

rnp_mbx_fw.c (259)
V530 <https://pvs-studio.com/en/docs/warnings/v530/> The return value of
function 'rte_fls_u32' is required to be utilized.

rnp_mbx_fw.c (256)
V519 <https://pvs-studio.com/en/docs/warnings/v519/> The 'is_sgmii_bits'
variable is assigned values twice successively. Perhaps this is a mistake.
Check lines: 255, 256.

rnp_mbx_fw.c (177)
V1086 <https://pvs-studio.com/en/docs/warnings/v1086/> A call of the
'memcpy' function will lead to underflow of the buffer 'cookie->priv'.

rnp_mbx_fw.c (332)
V1086 <https://pvs-studio.com/en/docs/warnings/v1086/> A call of the
'memcpy' function will lead to underflow of the buffer
'mac->addrs[nr_lane].mac'.

rnp_mbx_fw.c (271)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the 15th actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

rnp_mbx_fw.c (389)
V1048 <https://pvs-studio.com/en/docs/warnings/v1048/> The
'phy_meta->link_autoneg' variable was assigned the same value.

rnp_osdep.h (126)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fourth actual argument of the 'snprintf' function.
The memsize type argument is expected.

rnp_osdep.h (32)
V677 <https://pvs-studio.com/en/docs/warnings/v677/> Custom declaration of
a standard 'dma_addr_t' type. The declaration from system header files
should be used instead.

rnp_ethdev.c (750)
V530 <https://pvs-studio.com/en/docs/warnings/v530/> The return value of
function 'rte_fls_u32' is required to be utilized.

rnp_ethdev.c (1386)
V519 <https://pvs-studio.com/en/docs/warnings/v519/> The 'reg' variable is
assigned values twice successively. Perhaps this is a mistake. Check lines:
1381, 1386.

rnp_ethdev.c (1003)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression 'frame_size
< 64' is always false.

rnp_ethdev.c (1003)
V649 <https://pvs-studio.com/en/docs/warnings/v649/> There are two 'if'
statements with identical conditional expressions. The first 'if' statement
contains function return. This means that the second 'if' statement is
senseless. Check lines: 988, 1003.

rnp_ethdev.c (583)
V684 <https://pvs-studio.com/en/docs/warnings/v684/> A value of the
variable 'cvlan_ctrl' is not modified. Consider inspecting the expression.
It is possible that '1' should be present instead of '0'.

rnp_ethdev.c (598)
V684 <https://pvs-studio.com/en/docs/warnings/v684/> A value of the
variable 'svlan_ctrl' is not modified. Consider inspecting the expression.
It is possible that '1' should be present instead of '0'.

rnp_ethdev.c (618)
V684 <https://pvs-studio.com/en/docs/warnings/v684/> A value of the
variable 'ctrl' is not modified. Consider inspecting the expression. It is
possible that '1' should be present instead of '0'.

rnp_ethdev.c (106)
V1032 <https://pvs-studio.com/en/docs/warnings/v1032/> The pointer 'msgbuf'
is cast to a more strictly aligned pointer type.

rnp_ethdev.c (254)
V1051 <https://pvs-studio.com/en/docs/warnings/v1051/> Consider checking
for misprints. It's possible that the 'dma_ctrl' should be checked here.

rnp_ethdev.c (1348)
V525 <https://pvs-studio.com/en/docs/warnings/v525/> The code contains the
collection of similar blocks. Check items 'mac_stats', 'mac_stats',
'eth_stats' in lines 1348, 1354, 1360.

rnp_ethdev.c (1444)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

rnp_ethdev.c (1458)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

rnp_ethdev.c (110)
V641 <https://pvs-studio.com/en/docs/warnings/v641/> The size of the
'msgbuf' buffer is not a multiple of the element size of the type 'struct
rnp_mbx_fw_cmd_reply'.

rnp_ethdev.c (113)
V641 <https://pvs-studio.com/en/docs/warnings/v641/> The size of the
'msgbuf' buffer is not a multiple of the element size of the type 'struct
rnp_mbx_fw_cmd_req'.

rnp_ethdev.c (718)
V1027 <https://pvs-studio.com/en/docs/warnings/v1027/> Pointer to an object
of the 'rte_device' class is cast to unrelated 'rte_pci_device' class.

rnp_ethdev.c (1637)
V1027 <https://pvs-studio.com/en/docs/warnings/v1027/> Pointer to an object
of the 'rte_device' class is cast to unrelated 'rte_pci_device' class.

rnp_ethdev.c (1766)
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

rnp_rss.c (218)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression
'rss_hash_level =3D=3D (2UL << 50)' is always false.

rnp_rxtx.c (1409)
V684 <https://pvs-studio.com/en/docs/warnings/v684/> A value of the
variable 'txbd->d.cmd' is not modified. Consider inspecting the expression.
It is possible that '1' should be present instead of '0'.

rnp_rxtx.c (253)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the tenth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

rnp_rxtx.c (461)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the tenth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

rnp_rxtx.c (1224)
V1027 <https://pvs-studio.com/en/docs/warnings/v1027/> Pointer to an object
of the 'rte_ether_hdr' class is cast to unrelated 'rte_vlan_hdr' class.

On Wed, Feb 12, 2025 at 7:34=E2=80=AFAM Wenbo Cao <caowenbo@mucse.com> wrot=
e:

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
>  .mailmap                            |    1 +
>  MAINTAINERS                         |    6 +
>  doc/guides/nics/features/rnp.ini    |   33 +
>  doc/guides/nics/index.rst           |    1 +
>  doc/guides/nics/rnp.rst             |  101 ++
>  drivers/net/meson.build             |    1 +
>  drivers/net/rnp/base/meson.build    |   17 +
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
>  drivers/net/rnp/base/rnp_fw_cmd.h   |  357 ++++++
>  drivers/net/rnp/base/rnp_hw.h       |  136 ++
>  drivers/net/rnp/base/rnp_mac.c      |  366 ++++++
>  drivers/net/rnp/base/rnp_mac.h      |   34 +
>  drivers/net/rnp/base/rnp_mac_regs.h |  207 +++
>  drivers/net/rnp/base/rnp_mbx.c      |  512 ++++++++
>  drivers/net/rnp/base/rnp_mbx.h      |   58 +
>  drivers/net/rnp/base/rnp_mbx_fw.c   |  499 ++++++++
>  drivers/net/rnp/base/rnp_mbx_fw.h   |   24 +
>  drivers/net/rnp/base/rnp_osdep.h    |  169 +++
>  drivers/net/rnp/meson.build         |   27 +
>  drivers/net/rnp/rnp.h               |  258 ++++
>  drivers/net/rnp/rnp_ethdev.c        | 1841 +++++++++++++++++++++++++++
>  drivers/net/rnp/rnp_link.c          |  439 +++++++
>  drivers/net/rnp/rnp_link.h          |   38 +
>  drivers/net/rnp/rnp_logs.h          |   36 +
>  drivers/net/rnp/rnp_rss.c           |  367 ++++++
>  drivers/net/rnp/rnp_rss.h           |   43 +
>  drivers/net/rnp/rnp_rxtx.c          | 1815 ++++++++++++++++++++++++++
>  drivers/net/rnp/rnp_rxtx.h          |  162 +++
>  37 files changed, 8651 insertions(+)
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
>
> --
> 2.48.1
>
>

--000000000000750149062e239631
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:arial,sans-serif;font-size:small">I ran this driver through the ev=
aluation copy of PVS studio and it reported many warnings you should addres=
s.<br>Not all of them are valid, the tool seems to have a lot of false posi=
tives.</div><div class=3D"gmail_default" style=3D"font-family:arial,sans-se=
rif;font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-f=
amily:arial,sans-serif;font-size:small"><table style=3D"color:rgb(0,0,0);fo=
nt-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alter=
nates:normal;font-size-adjust:none;font-kerning:auto;font-feature-settings:=
normal;font-stretch:normal;font-size:12pt;line-height:normal;font-family:&q=
uot;normal Century Gothic&quot;;width:2265px"><caption style=3D"font-weight=
:bold;background-image:initial;background-position:initial;background-size:=
initial;background-repeat:initial;background-origin:initial;background-clip=
:initial;border:none">MESSAGES</caption><tbody><tr style=3D"background:blac=
k;color:white"><th style=3D"width:675.094px">Location</th><th style=3D"widt=
h:110.844px">Code</th><th style=3D"width:1465.06px">Message</th></tr><tr st=
yle=3D"background:lightcyan"><td colspan=3D"5" style=3D"padding:0px;text-al=
ign:center;vertical-align:top;color:red;font-size:1.2em">Fails/Info</td></t=
r><tr><td style=3D"padding:0px;vertical-align:top;width:677.094px"><div tit=
le=3D"DPDK/rnp/drivers/net/rnp/base/rnp_mac.c">rnp_mac.c (258)</div></td><t=
d style=3D"padding:0px;vertical-align:top;width:112.844px"><a target=3D"_bl=
ank" href=3D"https://pvs-studio.com/en/docs/warnings/v610/">V610</a></td><t=
d style=3D"padding:0px;vertical-align:top;width:1467.06px">Undefined behavi=
or. Check the shift operator &#39;&gt;&gt;&#39;. The right operand (&#39;..=
..&#39; =3D [0x0..0xFFFFFFFFFFFFFFFF]) is greater than or equal to the leng=
th in bits of the promoted left operand.</td></tr><tr><td style=3D"padding:=
0px;vertical-align:top;width:677.094px"><div title=3D"DPDK/rnp/drivers/net/=
rnp/base/rnp_mac.c">rnp_mac.c (81)</div></td><td style=3D"padding:0px;verti=
cal-align:top;width:112.844px"><a target=3D"_blank" href=3D"https://pvs-stu=
dio.com/en/docs/warnings/v1037/">V1037</a></td><td style=3D"padding:0px;ver=
tical-align:top;width:1467.06px">Two or more case-branches perform the same=
 actions. Check lines: 81, 84</td></tr><tr><td style=3D"padding:0px;vertica=
l-align:top;width:677.094px"><div title=3D"DPDK/rnp/drivers/net/rnp/base/rn=
p_mac.c">rnp_mac.c (205)</div></td><td style=3D"padding:0px;vertical-align:=
top;width:112.844px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en=
/docs/warnings/v525/">V525</a></td><td style=3D"padding:0px;vertical-align:=
top;width:1467.06px">The code contains the collection of similar blocks. Ch=
eck items &#39;flt_reg&#39;, &#39;vlan_reg&#39;, &#39;vlan_reg&#39; in line=
s 205, 206, 207.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;w=
idth:677.094px"><div title=3D"DPDK/rnp/drivers/net/rnp/base/rnp_mac.c">rnp_=
mac.c (209)</div></td><td style=3D"padding:0px;vertical-align:top;width:112=
.844px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warning=
s/v525/">V525</a></td><td style=3D"padding:0px;vertical-align:top;width:146=
7.06px">The code contains the collection of similar blocks. Check items &#3=
9;flt_reg&#39;, &#39;vlan_reg&#39;, &#39;vlan_reg&#39; in lines 209, 210, 2=
11.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:677.094p=
x"><div title=3D"DPDK/rnp/drivers/net/rnp/base/rnp_mbx.c">rnp_mbx.c (398)</=
div></td><td style=3D"padding:0px;vertical-align:top;width:112.844px"><a ta=
rget=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v547/">V547=
</a></td><td style=3D"padding:0px;vertical-align:top;width:1467.06px">Expre=
ssion &#39;!ret_val&#39; is always true.</td></tr><tr><td style=3D"padding:=
0px;vertical-align:top;width:677.094px"><div title=3D"DPDK/rnp/drivers/net/=
rnp/base/rnp_mbx_fw.c">rnp_mbx_fw.c (259)</div></td><td style=3D"padding:0p=
x;vertical-align:top;width:112.844px"><a target=3D"_blank" href=3D"https://=
pvs-studio.com/en/docs/warnings/v530/">V530</a></td><td style=3D"padding:0p=
x;vertical-align:top;width:1467.06px">The return value of function &#39;rte=
_fls_u32&#39; is required to be utilized.</td></tr><tr><td style=3D"padding=
:0px;vertical-align:top;width:677.094px"><div title=3D"DPDK/rnp/drivers/net=
/rnp/base/rnp_mbx_fw.c">rnp_mbx_fw.c (256)</div></td><td style=3D"padding:0=
px;vertical-align:top;width:112.844px"><a target=3D"_blank" href=3D"https:/=
/pvs-studio.com/en/docs/warnings/v519/">V519</a></td><td style=3D"padding:0=
px;vertical-align:top;width:1467.06px">The &#39;is_sgmii_bits&#39; variable=
 is assigned values twice successively. Perhaps this is a mistake. Check li=
nes: 255, 256.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;wid=
th:677.094px"><div title=3D"DPDK/rnp/drivers/net/rnp/base/rnp_mbx_fw.c">rnp=
_mbx_fw.c (177)</div></td><td style=3D"padding:0px;vertical-align:top;width=
:112.844px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/war=
nings/v1086/">V1086</a></td><td style=3D"padding:0px;vertical-align:top;wid=
th:1467.06px">A call of the &#39;memcpy&#39; function will lead to underflo=
w of the buffer &#39;cookie-&gt;priv&#39;.</td></tr><tr><td style=3D"paddin=
g:0px;vertical-align:top;width:677.094px"><div title=3D"DPDK/rnp/drivers/ne=
t/rnp/base/rnp_mbx_fw.c">rnp_mbx_fw.c (332)</div></td><td style=3D"padding:=
0px;vertical-align:top;width:112.844px"><a target=3D"_blank" href=3D"https:=
//pvs-studio.com/en/docs/warnings/v1086/">V1086</a></td><td style=3D"paddin=
g:0px;vertical-align:top;width:1467.06px">A call of the &#39;memcpy&#39; fu=
nction will lead to underflow of the buffer &#39;mac-&gt;addrs[nr_lane].mac=
&#39;.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:677.0=
94px"><div title=3D"DPDK/rnp/drivers/net/rnp/base/rnp_mbx_fw.c">rnp_mbx_fw.=
c (271)</div></td><td style=3D"padding:0px;vertical-align:top;width:112.844=
px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v5=
76/">V576</a></td><td style=3D"padding:0px;vertical-align:top;width:1467.06=
px">Incorrect format. Consider checking the 15th actual argument of the &#3=
9;rte_log&#39; function. The SIGNED integer type argument is expected.</td>=
</tr><tr><td style=3D"padding:0px;vertical-align:top;width:677.094px"><div =
title=3D"DPDK/rnp/drivers/net/rnp/base/rnp_mbx_fw.c">rnp_mbx_fw.c (389)</di=
v></td><td style=3D"padding:0px;vertical-align:top;width:112.844px"><a targ=
et=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v1048/">V1048=
</a></td><td style=3D"padding:0px;vertical-align:top;width:1467.06px">The &=
#39;phy_meta-&gt;link_autoneg&#39; variable was assigned the same value.</t=
d></tr><tr><td style=3D"padding:0px;vertical-align:top;width:677.094px"><di=
v title=3D"DPDK/rnp/drivers/net/rnp/base/rnp_osdep.h">rnp_osdep.h (126)</di=
v></td><td style=3D"padding:0px;vertical-align:top;width:112.844px"><a targ=
et=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</=
a></td><td style=3D"padding:0px;vertical-align:top;width:1467.06px">Incorre=
ct format. Consider checking the fourth actual argument of the &#39;snprint=
f&#39; function. The memsize type argument is expected.</td></tr><tr><td st=
yle=3D"padding:0px;vertical-align:top;width:677.094px"><div title=3D"DPDK/r=
np/drivers/net/rnp/base/rnp_osdep.h">rnp_osdep.h (32)</div></td><td style=
=3D"padding:0px;vertical-align:top;width:112.844px"><a target=3D"_blank" hr=
ef=3D"https://pvs-studio.com/en/docs/warnings/v677/">V677</a></td><td style=
=3D"padding:0px;vertical-align:top;width:1467.06px">Custom declaration of a=
 standard &#39;dma_addr_t&#39; type. The declaration from system header fil=
es should be used instead.</td></tr><tr><td style=3D"padding:0px;vertical-a=
lign:top;width:677.094px"><div title=3D"DPDK/rnp/drivers/net/rnp/rnp_ethdev=
.c">rnp_ethdev.c (750)</div></td><td style=3D"padding:0px;vertical-align:to=
p;width:112.844px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/d=
ocs/warnings/v530/">V530</a></td><td style=3D"padding:0px;vertical-align:to=
p;width:1467.06px">The return value of function &#39;rte_fls_u32&#39; is re=
quired to be utilized.</td></tr><tr><td style=3D"padding:0px;vertical-align=
:top;width:677.094px"><div title=3D"DPDK/rnp/drivers/net/rnp/rnp_ethdev.c">=
rnp_ethdev.c (1386)</div></td><td style=3D"padding:0px;vertical-align:top;w=
idth:112.844px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs=
/warnings/v519/">V519</a></td><td style=3D"padding:0px;vertical-align:top;w=
idth:1467.06px">The &#39;reg&#39; variable is assigned values twice success=
ively. Perhaps this is a mistake. Check lines: 1381, 1386.</td></tr><tr><td=
 style=3D"padding:0px;vertical-align:top;width:677.094px"><div title=3D"DPD=
K/rnp/drivers/net/rnp/rnp_ethdev.c">rnp_ethdev.c (1003)</div></td><td style=
=3D"padding:0px;vertical-align:top;width:112.844px"><a target=3D"_blank" hr=
ef=3D"https://pvs-studio.com/en/docs/warnings/v547/">V547</a></td><td style=
=3D"padding:0px;vertical-align:top;width:1467.06px">Expression &#39;frame_s=
ize &lt; 64&#39; is always false.</td></tr><tr><td style=3D"padding:0px;ver=
tical-align:top;width:677.094px"><div title=3D"DPDK/rnp/drivers/net/rnp/rnp=
_ethdev.c">rnp_ethdev.c (1003)</div></td><td style=3D"padding:0px;vertical-=
align:top;width:112.844px"><a target=3D"_blank" href=3D"https://pvs-studio.=
com/en/docs/warnings/v649/">V649</a></td><td style=3D"padding:0px;vertical-=
align:top;width:1467.06px">There are two &#39;if&#39; statements with ident=
ical conditional expressions. The first &#39;if&#39; statement contains fun=
ction return. This means that the second &#39;if&#39; statement is senseles=
s. Check lines: 988, 1003.</td></tr><tr><td style=3D"padding:0px;vertical-a=
lign:top;width:677.094px"><div title=3D"DPDK/rnp/drivers/net/rnp/rnp_ethdev=
.c">rnp_ethdev.c (583)</div></td><td style=3D"padding:0px;vertical-align:to=
p;width:112.844px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/d=
ocs/warnings/v684/">V684</a></td><td style=3D"padding:0px;vertical-align:to=
p;width:1467.06px">A value of the variable &#39;cvlan_ctrl&#39; is not modi=
fied. Consider inspecting the expression. It is possible that &#39;1&#39; s=
hould be present instead of &#39;0&#39;.</td></tr><tr><td style=3D"padding:=
0px;vertical-align:top;width:677.094px"><div title=3D"DPDK/rnp/drivers/net/=
rnp/rnp_ethdev.c">rnp_ethdev.c (598)</div></td><td style=3D"padding:0px;ver=
tical-align:top;width:112.844px"><a target=3D"_blank" href=3D"https://pvs-s=
tudio.com/en/docs/warnings/v684/">V684</a></td><td style=3D"padding:0px;ver=
tical-align:top;width:1467.06px">A value of the variable &#39;svlan_ctrl&#3=
9; is not modified. Consider inspecting the expression. It is possible that=
 &#39;1&#39; should be present instead of &#39;0&#39;.</td></tr><tr><td sty=
le=3D"padding:0px;vertical-align:top;width:677.094px"><div title=3D"DPDK/rn=
p/drivers/net/rnp/rnp_ethdev.c">rnp_ethdev.c (618)</div></td><td style=3D"p=
adding:0px;vertical-align:top;width:112.844px"><a target=3D"_blank" href=3D=
"https://pvs-studio.com/en/docs/warnings/v684/">V684</a></td><td style=3D"p=
adding:0px;vertical-align:top;width:1467.06px">A value of the variable &#39=
;ctrl&#39; is not modified. Consider inspecting the expression. It is possi=
ble that &#39;1&#39; should be present instead of &#39;0&#39;.</td></tr><tr=
><td style=3D"padding:0px;vertical-align:top;width:677.094px"><div title=3D=
"DPDK/rnp/drivers/net/rnp/rnp_ethdev.c">rnp_ethdev.c (106)</div></td><td st=
yle=3D"padding:0px;vertical-align:top;width:112.844px"><a target=3D"_blank"=
 href=3D"https://pvs-studio.com/en/docs/warnings/v1032/">V1032</a></td><td =
style=3D"padding:0px;vertical-align:top;width:1467.06px">The pointer &#39;m=
sgbuf&#39; is cast to a more strictly aligned pointer type.</td></tr><tr><t=
d style=3D"padding:0px;vertical-align:top;width:677.094px"><div title=3D"DP=
DK/rnp/drivers/net/rnp/rnp_ethdev.c">rnp_ethdev.c (254)</div></td><td style=
=3D"padding:0px;vertical-align:top;width:112.844px"><a target=3D"_blank" hr=
ef=3D"https://pvs-studio.com/en/docs/warnings/v1051/">V1051</a></td><td sty=
le=3D"padding:0px;vertical-align:top;width:1467.06px">Consider checking for=
 misprints. It&#39;s possible that the &#39;dma_ctrl&#39; should be checked=
 here.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:677.0=
94px"><div title=3D"DPDK/rnp/drivers/net/rnp/rnp_ethdev.c">rnp_ethdev.c (13=
48)</div></td><td style=3D"padding:0px;vertical-align:top;width:112.844px">=
<a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v525/"=
>V525</a></td><td style=3D"padding:0px;vertical-align:top;width:1467.06px">=
The code contains the collection of similar blocks. Check items &#39;mac_st=
ats&#39;, &#39;mac_stats&#39;, &#39;eth_stats&#39; in lines 1348, 1354, 136=
0.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:677.094px=
"><div title=3D"DPDK/rnp/drivers/net/rnp/rnp_ethdev.c">rnp_ethdev.c (1444)<=
/div></td><td style=3D"padding:0px;vertical-align:top;width:112.844px"><a t=
arget=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V57=
6</a></td><td style=3D"padding:0px;vertical-align:top;width:1467.06px">Inco=
rrect format. Consider checking the fifth actual argument of the &#39;rte_l=
og&#39; function. The SIGNED integer type argument is expected.</td></tr><t=
r><td style=3D"padding:0px;vertical-align:top;width:677.094px"><div title=
=3D"DPDK/rnp/drivers/net/rnp/rnp_ethdev.c">rnp_ethdev.c (1458)</div></td><t=
d style=3D"padding:0px;vertical-align:top;width:112.844px"><a target=3D"_bl=
ank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><t=
d style=3D"padding:0px;vertical-align:top;width:1467.06px">Incorrect format=
. Consider checking the fifth actual argument of the &#39;rte_log&#39; func=
tion. The SIGNED integer type argument is expected.</td></tr><tr><td style=
=3D"padding:0px;vertical-align:top;width:677.094px"><div title=3D"DPDK/rnp/=
drivers/net/rnp/rnp_ethdev.c">rnp_ethdev.c (110)</div></td><td style=3D"pad=
ding:0px;vertical-align:top;width:112.844px"><a target=3D"_blank" href=3D"h=
ttps://pvs-studio.com/en/docs/warnings/v641/">V641</a></td><td style=3D"pad=
ding:0px;vertical-align:top;width:1467.06px">The size of the &#39;msgbuf&#3=
9; buffer is not a multiple of the element size of the type &#39;struct rnp=
_mbx_fw_cmd_reply&#39;.</td></tr><tr><td style=3D"padding:0px;vertical-alig=
n:top;width:677.094px"><div title=3D"DPDK/rnp/drivers/net/rnp/rnp_ethdev.c"=
>rnp_ethdev.c (113)</div></td><td style=3D"padding:0px;vertical-align:top;w=
idth:112.844px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs=
/warnings/v641/">V641</a></td><td style=3D"padding:0px;vertical-align:top;w=
idth:1467.06px">The size of the &#39;msgbuf&#39; buffer is not a multiple o=
f the element size of the type &#39;struct rnp_mbx_fw_cmd_req&#39;.</td></t=
r><tr><td style=3D"padding:0px;vertical-align:top;width:677.094px"><div tit=
le=3D"DPDK/rnp/drivers/net/rnp/rnp_ethdev.c">rnp_ethdev.c (718)</div></td><=
td style=3D"padding:0px;vertical-align:top;width:112.844px"><a target=3D"_b=
lank" href=3D"https://pvs-studio.com/en/docs/warnings/v1027/">V1027</a></td=
><td style=3D"padding:0px;vertical-align:top;width:1467.06px">Pointer to an=
 object of the &#39;rte_device&#39; class is cast to unrelated &#39;rte_pci=
_device&#39; class.</td></tr><tr><td style=3D"padding:0px;vertical-align:to=
p;width:677.094px"><div title=3D"DPDK/rnp/drivers/net/rnp/rnp_ethdev.c">rnp=
_ethdev.c (1637)</div></td><td style=3D"padding:0px;vertical-align:top;widt=
h:112.844px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/wa=
rnings/v1027/">V1027</a></td><td style=3D"padding:0px;vertical-align:top;wi=
dth:1467.06px">Pointer to an object of the &#39;rte_device&#39; class is ca=
st to unrelated &#39;rte_pci_device&#39; class.</td></tr><tr><td style=3D"p=
adding:0px;vertical-align:top;width:677.094px"><div title=3D"DPDK/rnp/drive=
rs/net/rnp/rnp_ethdev.c">rnp_ethdev.c (1766)</div></td><td style=3D"padding=
:0px;vertical-align:top;width:112.844px"><a target=3D"_blank" href=3D"https=
://pvs-studio.com/en/docs/warnings/v1027/">V1027</a></td><td style=3D"paddi=
ng:0px;vertical-align:top;width:1467.06px">Pointer to an object of the &#39=
;rte_device&#39; class is cast to unrelated &#39;rte_pci_device&#39; class.=
</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:677.094px">=
<div title=3D"DPDK/rnp/drivers/net/rnp/rnp_link.c">rnp_link.c (192)</div></=
td><td style=3D"padding:0px;vertical-align:top;width:112.844px"><a target=
=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v519/">V519</a>=
</td><td style=3D"padding:0px;vertical-align:top;width:1467.06px">The &#39;=
link.link_autoneg&#39; variable is assigned values twice successively. Perh=
aps this is a mistake. Check lines: 186, 192.</td></tr><tr><td style=3D"pad=
ding:0px;vertical-align:top;width:677.094px"><div title=3D"DPDK/rnp/drivers=
/net/rnp/rnp_link.c">rnp_link.c (359)</div></td><td style=3D"padding:0px;ve=
rtical-align:top;width:112.844px"><a target=3D"_blank" href=3D"https://pvs-=
studio.com/en/docs/warnings/v547/">V547</a></td><td style=3D"padding:0px;ve=
rtical-align:top;width:1467.06px">Expression &#39;!port-&gt;attr.link_ready=
&#39; is always true.</td></tr><tr><td style=3D"padding:0px;vertical-align:=
top;width:677.094px"><div title=3D"DPDK/rnp/drivers/net/rnp/rnp_link.c">rnp=
_link.c (113)</div></td><td style=3D"padding:0px;vertical-align:top;width:1=
12.844px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warni=
ngs/v1048/">V1048</a></td><td style=3D"padding:0px;vertical-align:top;width=
:1467.06px">The &#39;lane&#39; variable was assigned the same value.</td></=
tr><tr><td style=3D"padding:0px;vertical-align:top;width:677.094px"><div ti=
tle=3D"DPDK/rnp/drivers/net/rnp/rnp_rss.c">rnp_rss.c (218)</div></td><td st=
yle=3D"padding:0px;vertical-align:top;width:112.844px"><a target=3D"_blank"=
 href=3D"https://pvs-studio.com/en/docs/warnings/v547/">V547</a></td><td st=
yle=3D"padding:0px;vertical-align:top;width:1467.06px">Expression &#39;rss_=
hash_level =3D=3D (2UL &lt;&lt; 50)&#39; is always false.</td></tr><tr><td =
style=3D"padding:0px;vertical-align:top;width:677.094px"><div title=3D"DPDK=
/rnp/drivers/net/rnp/rnp_rxtx.c">rnp_rxtx.c (1409)</div></td><td style=3D"p=
adding:0px;vertical-align:top;width:112.844px"><a target=3D"_blank" href=3D=
"https://pvs-studio.com/en/docs/warnings/v684/">V684</a></td><td style=3D"p=
adding:0px;vertical-align:top;width:1467.06px">A value of the variable &#39=
;txbd-&gt;d.cmd&#39; is not modified. Consider inspecting the expression. I=
t is possible that &#39;1&#39; should be present instead of &#39;0&#39;.</t=
d></tr><tr><td style=3D"padding:0px;vertical-align:top;width:677.094px"><di=
v title=3D"DPDK/rnp/drivers/net/rnp/rnp_rxtx.c">rnp_rxtx.c (253)</div></td>=
<td style=3D"padding:0px;vertical-align:top;width:112.844px"><a target=3D"_=
blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td>=
<td style=3D"padding:0px;vertical-align:top;width:1467.06px">Incorrect form=
at. Consider checking the tenth actual argument of the &#39;rte_log&#39; fu=
nction. The SIGNED integer type argument is expected.</td></tr><tr><td styl=
e=3D"padding:0px;vertical-align:top;width:677.094px"><div title=3D"DPDK/rnp=
/drivers/net/rnp/rnp_rxtx.c">rnp_rxtx.c (461)</div></td><td style=3D"paddin=
g:0px;vertical-align:top;width:112.844px"><a target=3D"_blank" href=3D"http=
s://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"paddin=
g:0px;vertical-align:top;width:1467.06px">Incorrect format. Consider checki=
ng the tenth actual argument of the &#39;rte_log&#39; function. The SIGNED =
integer type argument is expected.</td></tr><tr><td style=3D"padding:0px;ve=
rtical-align:top;width:677.094px"><div title=3D"DPDK/rnp/drivers/net/rnp/rn=
p_rxtx.c">rnp_rxtx.c (1224)</div></td><td style=3D"padding:0px;vertical-ali=
gn:top;width:112.844px"><a target=3D"_blank" href=3D"https://pvs-studio.com=
/en/docs/warnings/v1027/">V1027</a></td><td style=3D"padding:0px;vertical-a=
lign:top;width:1467.06px">Pointer to an object of the &#39;rte_ether_hdr&#3=
9; class is cast to unrelated &#39;rte_vlan_hdr&#39; class.</td></tr></tbod=
y></table></div></div></div><br><div class=3D"gmail_quote gmail_quote_conta=
iner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 12, 2025 at 7:34=E2=
=80=AFAM Wenbo Cao &lt;<a href=3D"mailto:caowenbo@mucse.com">caowenbo@mucse=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">For This patchset just to support the basic chip init work<br>
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
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 1 +<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 6 +<br>
=C2=A0doc/guides/nics/features/rnp.ini=C2=A0 =C2=A0 |=C2=A0 =C2=A033 +<br>
=C2=A0doc/guides/nics/index.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 1 +<br>
=C2=A0doc/guides/nics/rnp.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 101 ++<br>
=C2=A0drivers/net/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 1 +<br>
=C2=A0drivers/net/rnp/base/meson.build=C2=A0 =C2=A0 |=C2=A0 =C2=A017 +<br>
=C2=A0drivers/net/rnp/base/rnp_bdq_if.c=C2=A0 =C2=A0|=C2=A0 398 ++++++<br>
=C2=A0drivers/net/rnp/base/rnp_bdq_if.h=C2=A0 =C2=A0|=C2=A0 154 +++<br>
=C2=A0drivers/net/rnp/base/rnp_bitrev.h=C2=A0 =C2=A0|=C2=A0 =C2=A064 +<br>
=C2=A0drivers/net/rnp/base/rnp_common.c=C2=A0 =C2=A0|=C2=A0 103 ++<br>
=C2=A0drivers/net/rnp/base/rnp_common.h=C2=A0 =C2=A0|=C2=A0 =C2=A017 +<br>
=C2=A0drivers/net/rnp/base/rnp_crc32.c=C2=A0 =C2=A0 |=C2=A0 =C2=A037 +<br>
=C2=A0drivers/net/rnp/base/rnp_crc32.h=C2=A0 =C2=A0 |=C2=A0 =C2=A010 +<br>
=C2=A0drivers/net/rnp/base/rnp_dma_regs.h |=C2=A0 =C2=A068 +<br>
=C2=A0drivers/net/rnp/base/rnp_eth_regs.h |=C2=A0 =C2=A090 ++<br>
=C2=A0drivers/net/rnp/base/rnp_fw_cmd.c=C2=A0 =C2=A0|=C2=A0 162 +++<br>
=C2=A0drivers/net/rnp/base/rnp_fw_cmd.h=C2=A0 =C2=A0|=C2=A0 357 ++++++<br>
=C2=A0drivers/net/rnp/base/rnp_hw.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 136 +=
+<br>
=C2=A0drivers/net/rnp/base/rnp_mac.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 366 ++++++=
<br>
=C2=A0drivers/net/rnp/base/rnp_mac.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A034 +=
<br>
=C2=A0drivers/net/rnp/base/rnp_mac_regs.h |=C2=A0 207 +++<br>
=C2=A0drivers/net/rnp/base/rnp_mbx.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 512 ++++++=
++<br>
=C2=A0drivers/net/rnp/base/rnp_mbx.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A058 +=
<br>
=C2=A0drivers/net/rnp/base/rnp_mbx_fw.c=C2=A0 =C2=A0|=C2=A0 499 ++++++++<br=
>
=C2=A0drivers/net/rnp/base/rnp_mbx_fw.h=C2=A0 =C2=A0|=C2=A0 =C2=A024 +<br>
=C2=A0drivers/net/rnp/base/rnp_osdep.h=C2=A0 =C2=A0 |=C2=A0 169 +++<br>
=C2=A0drivers/net/rnp/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A027 +<br>
=C2=A0drivers/net/rnp/rnp.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 258 ++++<br>
=C2=A0drivers/net/rnp/rnp_ethdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1841 ++++++=
+++++++++++++++++++++<br>
=C2=A0drivers/net/rnp/rnp_link.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
439 +++++++<br>
=C2=A0drivers/net/rnp/rnp_link.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A038 +<br>
=C2=A0drivers/net/rnp/rnp_logs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A036 +<br>
=C2=A0drivers/net/rnp/rnp_rss.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 367 ++++++<br>
=C2=A0drivers/net/rnp/rnp_rss.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A043 +<br>
=C2=A0drivers/net/rnp/rnp_rxtx.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1815 +=
+++++++++++++++++++++++++<br>
=C2=A0drivers/net/rnp/rnp_rxtx.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
162 +++<br>
=C2=A037 files changed, 8651 insertions(+)<br>
=C2=A0create mode 100644 doc/guides/nics/features/rnp.ini<br>
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
2.48.1<br>
<br>
</blockquote></div>

--000000000000750149062e239631--
