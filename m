Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0349FC28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 12:35:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7E6D402CB;
	Fri, 28 Mar 2025 13:35:53 +0100 (CET)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id 594B1402C1
 for <dev@dpdk.org>; Fri, 28 Mar 2025 13:35:50 +0100 (CET)
X-QQ-mid: bizesmtp88t1743165344tge4fvrl
X-QQ-Originating-IP: fkSvd4W0y/Xi+tVQO7IRZdih4vAxU7CkO3yQpydFKOg=
Received: from LAPTOP96V0OHHN ( [103.233.162.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 28 Mar 2025 20:35:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15950028692985401726
EX-QQ-RecipientCnt: 4
From: "11" <caowenbo@mucse.com>
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <thomas@monjalon.net>,
	<dev@dpdk.org>,
	<yaojun@mucse.com>
References: <1740555736-19894-1-git-send-email-caowenbo@mucse.com>
 <20250327102917.5d3b1ade@hermes.local>
In-Reply-To: <20250327102917.5d3b1ade@hermes.local>
Subject: RE: [PATCH v16 00/28] [v16]drivers/net Add Support mucse N10 Pmd
 Driver
Date: Fri, 28 Mar 2025 20:35:28 +0800
Message-ID: <837AB9FFC7D3B790+003601db9fdd$ed0d4420$c727cc60$@mucse.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHmWlp8uSRLFRnsJwF7bFAlAInk4AGsXzePs2WhG7A=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: MmIUUz9KGMMd5XJW/vUFHmPYXL89Ds56D+MOaf9oHHeLug2siNPcF2wZ
 +r1oP/geKr4zl8M4FFknaDtTo73jFdVQCukCIHLOirn538LI+Gud7sc+sD4lTrMbNRIOwfx
 o0MVueAq4jM+FZqxuZYTAs4OXWuAkG25sisOzgleym8OB23Pl6wcHrPQ/+0Y+eJ80T/Sf2P
 mi+V5lvxP2WiQdcuMEeO9VNEnBPCA5UatB5PNRI9WfCxxj8xq08Yx0G1p2m0/qVxsf/mksl
 s8tn8yPykjEnAnNgHUxscKNHG7mhBLfRLq+6HvThQVIRcTQEstUkpljYUrddEiYgWvV+Yln
 pnkS9eQBts7e4z2DTL4HstqcWa7OqqkNxYy9KbDKJ06Mf/bfSnKPKqiIu9wizO9obcdORXD
 aDXQzXUK3TvhiSu1LN0L6Z24CNT8KfDXG6bghvGvh5OPidOyspWMZjhLE4qDWDyha4Niu5H
 RloZt6I4wlcxASqEwBgfs50+MSLyU2Mq8mJCLPck/z+CWm6c7tbQmnrKvRPv3X2Obq9IrX7
 LxPK/mZudFBmiiyMuS643KEipbnPVd2pSd3NXwpzc4S+mLTZcXD6ptfnkCUIqqtADuYkldh
 uN1kQmqb+R9zpxWTGkmqkowiOKi1bYQ0nptwmXYXfEjIfvdzTgNVz3lMmjW+7k+KyGq2JG7
 GxeQYAhpI3njFqipLlH1MRsHmcLDc0yrQVBatRTmc+xDx5Oclf0F75YP+uBLgb1WAoHC0XW
 P1f/maCx8JKw4SA8wJWzlBdbBnpnKOpwEqnje9OK1NR+j3dwKuyeD7wiFqmvwpH4xOklfll
 ujHN1OwaM+l2xAtlHNmLlqzkVEwNz/UK/l2fyfuS01slJkRmJmAlaxMnqNJRudon7j/Y0QD
 dD7xjhTBcfxWkxOX22Xw7gxuitcdy2NnAKZNvmvXyoc1FOkWBjIDoT7f0X8BqQIrebZe6GU
 KGUfoJgpwoFt2pw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0
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

Hi Stephen,

I wanted to extend my sincere thanks for your tremendous help and =
valuable
advice during patch submit.
The next submit will be soon. Thank for your patience and understanding.

Regards Wenbo

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: 2025=C4=EA3=D4=C228=C8=D5 1:29
> To: Wenbo Cao <caowenbo@mucse.com>
> Cc: thomas@monjalon.net; dev@dpdk.org; yaojun@mucse.com
> Subject: Re: [PATCH v16 00/28] [v16]drivers/net Add Support mucse N10 =
Pmd
> Driver
>=20
> On Wed, 26 Feb 2025 15:41:47 +0800
> Wenbo Cao <caowenbo@mucse.com> wrote:
>=20
> > For This patchset just to support the basic chip init work and user
> > can just found the eth_dev, but can't control more.
> > For Now just support 2*10g nic,the chip can support
> > 2*10g,4*10g,4*1g,8*1g,8*10g.
> > The Feature rx side can support rx-cksum-offload,rss,vlan-filter
> > flow_clow,uncast_filter,mcast_filter,1588,Jumbo-frame
> > The Feature tx side can support tx-cksum-offload,tso,vxlan-tso flow
> > director base on ntuple pattern of tcp/udp/ip/ eth_hdr->type for =
sriov
> > is also support.
> >
> > Because of the chip design defect, for multiple-port mode one =
pci-bdf
> > will have multiple-port (max can have four ports) so this code must =
be
> > care of one bdf init multiple-port.
> >
> > v16
> >   * fixed rxq/txq stop/start not add to eth_ops as rnp doc descript.
> >
> > v15:
> >   * fixed scatter recv for jumbo frame test by dts mtu.
> >
> > v14:
> >   * add multicast mac filter feature for basic nic feature.
> >   * fixed pvs studio low,media,high level warning as the below cmd
> >     pvs-studio-analyzer analyze -f build/compile_commands.json -j 8
> >     plog-converter -a GA:1,2,3 -t fullhtml PVS-Studio.log -o
> > /root/report
> >
> > v13:
> >   * Supplementary document about n10 network card characteristics.
> >   * update release_25_03.rst.
> >   * fixed the code style advisea Stephen Hemminger.
> >   * fixed the code issue check PVS-stdio for Static compilation =
error.
> >
> > v12:
> >   * fixed __rte_packed __deprecated__ compile issue.
> >
> > v11:
> >   * fixed array-bounds issue when used rte_memcpy src addr is
> >   * not enough to hold align dst.
> >   * improve efficient_code advised by Stephen
> >
> > v10:
> >   * fixed mingw windows meson issue
> >   * rnp not support windows for now.
> >
> > v9:
> >   * fixed commit log format check by devtools.
> >   * fixed code compile issue.
> >
> > v8:
> >   * fixed codespell issue.
> >   * fixed MAINTAINERS file
> >
> > v7:
> >   * add support nic basic feature such as rss vlan strip/filter,
> >   * mtu-change recv/send scater-recv/mutltiple-send.
> >   * fixed code rationality, advised by Ferruh Yigit.
> > v6:
> >   * fixed the doc(rst) format problem advise by Thomas Monjalon
> >
> > v5:
> >   * fixed the symbol name require by the style documentation
> >
> > v4:
> >   * one patch has been forgot to upload :(
> >
> > v3:
> >   * fixed http://dpdk.org/patch/129830 FreeBSD 13 compile Issue
> >   * change iobar type to void suggest by Stephen Hemminger
> >   * add KMOD_DEP support for vfio-pci
> >   * change run-cmd argument parse check for invalid extra_args
> >
> > v2:
> >   * fixed MAINTAIN maillist fullname format
> >   * fixed driver/net/meson the order issue of new driver to driver =
list
> >   * improve virtual point function usage suggest by Stephen =
Hemminger
> >
> > Wenbo Cao (29):
> >   net/rnp: add skeleton
> >   net/rnp: add ethdev probe and remove
> >   net/rnp: add log
> >   net/rnp: support mailbox basic operate
> >   net/rnp: add device init and uninit
> >   net/rnp: add get device information operation
> >   net/rnp: add support MAC promisc mode
> >   net/rnp: add queue setup and release operations
> >   net/rnp: add queue stop and start operations
> >   net/rnp: add support device start stop operations
> >   net/rnp: add RSS support operations
> >   net/rnp: add support link update operations
> >   net/rnp: add support link setup operations
> >   net/rnp: add Rx burst simple support
> >   net/rnp: add Tx burst simple support
> >   net/rnp: add MTU set operation
> >   net/rnp: add Rx scatter segment version
> >   net/rnp: add Tx multiple segment version
> >   net/rnp: add support basic stats operation
> >   net/rnp: add support xstats operation
> >   net/rnp: add unicast MAC filter operation
> >   net/rnp: add supported packet types
> >   net/rnp: add support Rx checksum offload
> >   net/rnp: add support Tx TSO offload
> >   net/rnp: support VLAN offloads
> >   net/rnp: add support VLAN filters operations
> >   net/rnp: add queue info operation
> >   net/rnp: support Rx/Tx burst mode info
> >   net/rnp: add multicast MAC filter operation
> >
> >  .mailmap                               |    1 +
> >  MAINTAINERS                            |    6 +
> >  doc/guides/nics/features/rnp.ini       |   34 +
> >  doc/guides/nics/img/mucse_nic_port.svg | 4023 =
++++++++++++++++++++++++
> >  doc/guides/nics/index.rst              |    1 +
> >  doc/guides/nics/rnp.rst                |  130 +
> >  doc/guides/rel_notes/release_25_03.rst |    5 +
> >  drivers/net/meson.build                |    1 +
> >  drivers/net/rnp/base/meson.build       |   18 +
> >  drivers/net/rnp/base/rnp_bdq_if.c      |  398 +++
> >  drivers/net/rnp/base/rnp_bdq_if.h      |  154 +
> >  drivers/net/rnp/base/rnp_bitrev.h      |   64 +
> >  drivers/net/rnp/base/rnp_common.c      |  103 +
> >  drivers/net/rnp/base/rnp_common.h      |   17 +
> >  drivers/net/rnp/base/rnp_crc32.c       |   53 +
> >  drivers/net/rnp/base/rnp_crc32.h       |   11 +
> >  drivers/net/rnp/base/rnp_dma_regs.h    |   68 +
> >  drivers/net/rnp/base/rnp_eth_regs.h    |   94 +
> >  drivers/net/rnp/base/rnp_fw_cmd.c      |  162 +
> >  drivers/net/rnp/base/rnp_fw_cmd.h      |  357 +++
> >  drivers/net/rnp/base/rnp_hw.h          |  141 +
> >  drivers/net/rnp/base/rnp_mac.c         |  480 +++
> >  drivers/net/rnp/base/rnp_mac.h         |   36 +
> >  drivers/net/rnp/base/rnp_mac_regs.h    |  210 ++
> >  drivers/net/rnp/base/rnp_mbx.c         |  507 +++
> >  drivers/net/rnp/base/rnp_mbx.h         |   59 +
> >  drivers/net/rnp/base/rnp_mbx_fw.c      |  495 +++
> >  drivers/net/rnp/base/rnp_mbx_fw.h      |   24 +
> >  drivers/net/rnp/base/rnp_osdep.h       |  176 ++
> >  drivers/net/rnp/meson.build            |   27 +
> >  drivers/net/rnp/rnp.h                  |  262 ++
> >  drivers/net/rnp/rnp_ethdev.c           | 1868 +++++++++++
> >  drivers/net/rnp/rnp_link.c             |  436 +++
> >  drivers/net/rnp/rnp_link.h             |   52 +
> >  drivers/net/rnp/rnp_logs.h             |   36 +
> >  drivers/net/rnp/rnp_rss.c              |  367 +++
> >  drivers/net/rnp/rnp_rss.h              |   44 +
> >  drivers/net/rnp/rnp_rxtx.c             | 1822 +++++++++++
> >  drivers/net/rnp/rnp_rxtx.h             |  162 +
> >  39 files changed, 12904 insertions(+)  create mode 100644
> > doc/guides/nics/features/rnp.ini  create mode 100644
> > doc/guides/nics/img/mucse_nic_port.svg
> >  create mode 100644 doc/guides/nics/rnp.rst  create mode 100644
> > drivers/net/rnp/base/meson.build  create mode 100644
> > drivers/net/rnp/base/rnp_bdq_if.c  create mode 100644
> > drivers/net/rnp/base/rnp_bdq_if.h  create mode 100644
> > drivers/net/rnp/base/rnp_bitrev.h  create mode 100644
> > drivers/net/rnp/base/rnp_common.c  create mode 100644
> > drivers/net/rnp/base/rnp_common.h  create mode 100644
> > drivers/net/rnp/base/rnp_crc32.c  create mode 100644
> > drivers/net/rnp/base/rnp_crc32.h  create mode 100644
> > drivers/net/rnp/base/rnp_dma_regs.h
> >  create mode 100644 drivers/net/rnp/base/rnp_eth_regs.h
> >  create mode 100644 drivers/net/rnp/base/rnp_fw_cmd.c  create mode
> > 100644 drivers/net/rnp/base/rnp_fw_cmd.h  create mode 100644
> > drivers/net/rnp/base/rnp_hw.h  create mode 100644
> > drivers/net/rnp/base/rnp_mac.c  create mode 100644
> > drivers/net/rnp/base/rnp_mac.h  create mode 100644
> > drivers/net/rnp/base/rnp_mac_regs.h
> >  create mode 100644 drivers/net/rnp/base/rnp_mbx.c  create mode =
100644
> > drivers/net/rnp/base/rnp_mbx.h  create mode 100644
> > drivers/net/rnp/base/rnp_mbx_fw.c  create mode 100644
> > drivers/net/rnp/base/rnp_mbx_fw.h  create mode 100644
> > drivers/net/rnp/base/rnp_osdep.h  create mode 100644
> > drivers/net/rnp/meson.build  create mode 100644 =
drivers/net/rnp/rnp.h
> > create mode 100644 drivers/net/rnp/rnp_ethdev.c  create mode 100644
> > drivers/net/rnp/rnp_link.c  create mode 100644
> > drivers/net/rnp/rnp_link.h  create mode 100644
> > drivers/net/rnp/rnp_logs.h  create mode 100644
> > drivers/net/rnp/rnp_rss.c  create mode 100644
> > drivers/net/rnp/rnp_rss.h  create mode 100644
> > drivers/net/rnp/rnp_rxtx.c  create mode 100644
> > drivers/net/rnp/rnp_rxtx.h
> >
>=20
> Added this patch series to next-net with a couple of small changes.
>   1. Moved the release note to 25.07
>   2. Replaced rte_memcpy() of process private data in rnp_ethdev.c =
with
memcpy


