Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20733C021B0
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 05:06:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C9144014F;
	Thu, 20 Feb 2025 06:06:47 +0100 (CET)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id 6313340041
 for <dev@dpdk.org>; Thu, 20 Feb 2025 06:06:43 +0100 (CET)
X-QQ-mid: bizesmtp77t1740027992tm320lcl
X-QQ-Originating-IP: 1SLYWM6UDFjTpayJw4l2k4SygajMvHIRX0Oskq5Mg38=
Received: from LAPTOP96V0OHHN ( [103.233.162.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 20 Feb 2025 13:06:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5612190513338588610
From: "11" <caowenbo@mucse.com>
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>, <ferruh.yigit@amd.com>,
 <andrew.rybchenko@oktetlabs.ru>, <yaojun@mucse.com>
References: <1739951849-67601-1-git-send-email-caowenbo@mucse.com>
 <20250219081435.3c780063@hermes.local>
In-Reply-To: <20250219081435.3c780063@hermes.local>
Subject: RE: [PATCH v13 00/28] [v13]drivers/net Add Support mucse N10 Pmd
 Driver
Date: Thu, 20 Feb 2025 13:06:30 +0800
Message-ID: <7965B24DF5ABB77F+000101db8355$35272be0$9f7583a0$@mucse.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLBOjsSwLQOTPmCxcqviTF+lamJvAFN9UvUsXnEW5A=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: Obfty5iaetlm6hq7UVEwhqiiiy0XgG4fuaN+//jTDLSOVkqUfGra+H1Q
 vIKoS6/wFDyQpEJ5jGRyUZatx6r4upf8noHpdX1hLfo+qmv1K7GHhO/V1Rr1uN7if7/izgm
 WIPzav/2/GQkTCapD6EDeuttlKPAvUaqUou3DAxuf2jhOngcaydhVp1BmPMGB2ppERkjFmG
 1CnLp8OkWye6uJF82yo1KKXM8+fM83yik75U1nB8LPW9xITBou6cG83a9vDhXNjpEs0Z2tv
 uKmsZZDFE5rREDhfNAaSegwqeqQ23TeL2JI/+r1jrrNIRCJHJwjk0/TN0mGldjeAUt70r8j
 M1F0h2/xRaPdEE2PibzCwVxdi++heZCt/FDCx1IM08ULi9jRcUjrh5DQtbhpQhyXpIv4auH
 Nho04HUNfALDYRxTPleCrcV39T7Ifq5KIp2h7cEzQAFRVIIS0K0lOJWtxNCMJux6MsON5n/
 /16JXFPlwlj+g66moMosbfCRnXxfsiwuP927c1WIY/BhuzH3S8Zd9nQKTqIMK7ZD8y7szc/
 YSnuQ3Ka+zkuJ8MGeSG5pjnIR+SrRDyxcKsrPggEva1olRLIMXtFtzoCDPjwySXMugfdxWw
 bGGTRW9bVTavPL4ynqK6yp0KEVL3Z26B2je7dPtvGuWGjSIb2fPUgEFVer+TNBr5qnMWsUP
 14CGTNIzo/nSVZ5UKb+vxetGpm6YU15IRruQNrrBe+umCBfbn31+WDCXRCJbuM5T5WVKZWo
 ziCuszthOz59p7IqiZ/2bJD5i1DKxkr5AZK5+aA8shsosQgsoWAXMRSQ9qSOD09hsLhva0g
 QCoJeqk+cijsgzVCIUOH5sM21GD4baqdoS88jGmQPFPUPeu0z1yIgqu32Yv0+UX1v3Nin8J
 2TWX73fm74MS3P8rO9JqjvjiRcd3Ta/YOCwuwrN0Kzb6PPkkIpZf0rOQXRcuzj/V
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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

For the release thing, that be ok.

But for Debian 12 with MUSDK it be failed, do I need to fixed it ,
The ability when I used it that I had been memset it. But the =
compile-tool
is warning it,
 hw->phy_port_ids[idx] =3D ability.port_ids[idx];

Branch: master
CommitID:968f7b6d7b6a7e60e6e551db430c4eecaccbbfd2

151613-151639 --> testing issues

Upstream job id: Generic-DPDK-Compile-Meson#362983

Test environment and result as below:

+----------------------------------------+--------------------+
|              Environment               | dpdk_meson_compile |
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
| RHEL9 (ARM)                            | PASS               |
+----------------------------------------+--------------------+
| Ubuntu 20.04 ARM GCC Cross Compile     | PASS               |
+----------------------------------------+--------------------+
| Ubuntu 20.04 ARM SVE                   | PASS               |
+----------------------------------------+--------------------+
| Debian 12 with MUSDK                   | FAIL               |
+----------------------------------------+--------------------+
| Fedora 40 (ARM Clang)                  | PASS               |
+----------------------------------------+--------------------+
| Fedora 41 (ARM Clang)                  | PASS               |
+----------------------------------------+--------------------+
| Fedora 41 (ARM)                        | PASS               |
+----------------------------------------+--------------------+
| Fedora 40 (ARM)                        | PASS               |
+----------------------------------------+--------------------+
| Ubuntu 20.04 (ARM)                     | PASS               |
+----------------------------------------+--------------------+
| Ubuntu 22.04 (ARM)                     | PASS               |
+----------------------------------------+--------------------+
| Ubuntu 24.04 (ARM)                     | PASS               |
+----------------------------------------+--------------------+
| CentOS Stream 9 (ARM)                  | PASS               |
+----------------------------------------+--------------------+
| CentOS Stream 10 (ARM)                 | PASS               |
+----------------------------------------+--------------------+
| Debian 11 (Buster) (ARM)               | PASS               |
+----------------------------------------+--------------------+
| Ubuntu 20.04 ARM Clang Cross Compile   | PASS               |
+----------------------------------------+--------------------+
| Ubuntu 20.04 aarch32 GCC Cross Compile | PASS               |
+----------------------------------------+--------------------+
| Debian 12 (arm)                        | PASS               |
+----------------------------------------+--------------------+

=3D=3D=3D=3D 20 line log output for Debian 12 with MUSDK =
(dpdk_meson_compile): =3D=3D=3D=3D
[888/1284] Linking static target drivers/libtmp_rte_net_r8169.a =
[889/1284]
Generating rte_net_r8169.pmd.c with a custom command [890/1284] =
Compiling C
object =
drivers/librte_net_r8169.a.p/meson-generated_.._rte_net_r8169.pmd.c.o
[891/1284] Linking static target drivers/librte_net_r8169.a [892/1284]
Compiling C object
drivers/librte_net_r8169.so.25.1.p/meson-generated_.._rte_net_r8169.pmd.c=
.o
[893/1284] Linking target drivers/librte_net_r8169.so.25.1 [894/1284]
Compiling C object drivers/net/rnp/base/librnp_base.a.p/rnp_mbx.c.o
[895/1284] Compiling C object
drivers/net/rnp/base/librnp_base.a.p/rnp_fw_cmd.c.o
[896/1284] Compiling C object
drivers/net/rnp/base/librnp_base.a.p/rnp_mbx_fw.c.o
FAILED: drivers/net/rnp/base/librnp_base.a.p/rnp_mbx_fw.c.o
ccache aarch64-linux-gnu-gcc -Idrivers/net/rnp/base/librnp_base.a.p
-Idrivers/net/rnp/base -I../drivers/net/rnp/base -I. -I.. -Iconfig
-I../config -Ilib/eal/include -I../lib/eal/include =
-Ilib/eal/linux/include
-I../lib/eal/linux/include -Ilib/eal/arm/include =
-I../lib/eal/arm/include
-I../kernel/linux -Ilib/eal/common -I../lib/eal/common -Ilib/eal
-I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log
-Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry =
-Ilib/net
-I../lib/net -Ilib/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool
-Ilib/ring -I../lib/ring -Ilib/ethdev -I../lib/ethdev -Ilib/meter
-I../lib/meter -fdiagnostics-color=3Dalways -pipe =
-D_FILE_OFFSET_BITS=3D64 -Wall
-Winvalid-pch -Wextra -Werror -std=3Dc11 -O3 -include rte_config.h -Wvla
-Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral -Wformat-security
-Wmissing-declarations -Wmissing-prototypes -Wnested-externs
-Wold-style-definition -Wpointer-arith -Wsign-compare =
-Wstrict-prototypes
-Wundef -Wwrite-st  rings -Wno-packed-not-aligned
-Wno-missing-field-initializers -D_GNU_SOURCE -fPIC -mcpu=3Dcortex-a72
-DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation
-Wno-address-of-packed-member -DRTE_LIBRTE_IXGBE_BYPASS =
-Wno-unused-value
-Wno-unused-but-set-variable -Wno-unused-parameter -MD -MQ
drivers/net/rnp/base/librnp_base.a.p/rnp_mbx_fw.c.o -MF
drivers/net/rnp/base/librnp_base.a.p/rnp_mbx_fw.c.o.d -o
drivers/net/rnp/base/librnp_base.a.p/rnp_mbx_fw.c.o -c
../drivers/net/rnp/base/rnp_mbx_fw.c
../drivers/net/rnp/base/rnp_mbx_fw.c: In function
'rnp_mbx_fw_get_capability':
../drivers/net/rnp/base/rnp_mbx_fw.c:257:65: error: 'ability' may be =
used
uninitialized [-Werror=3Dmaybe-uninitialized]
257 |                         hw->phy_port_ids[idx] =3D =
ability.port_ids[idx];
|                                                 ~~~~~~~~~~~~~~~~^~~~~
../drivers/net/rnp/base/rnp_mbx_fw.c:235:38: note: 'ability' declared =
here
235 |         struct rnp_phy_abilities_rep ability;
|                                      ^~~~~~~
cc1: all warnings being treated as errors
ninja: build stopped: subcommand failed.
=3D=3D=3D=3D End log output =3D=3D=3D=3D

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: 2025=C4=EA2=D4=C220=C8=D5 0:15
> To: Wenbo Cao <caowenbo@mucse.com>
> Cc: thomas@monjalon.net; dev@dpdk.org; ferruh.yigit@amd.com;
> andrew.rybchenko@oktetlabs.ru; yaojun@mucse.com
> Subject: Re: [PATCH v13 00/28] [v13]drivers/net Add Support mucse N10 =
Pmd
> Driver
>=20
> On Wed, 19 Feb 2025 15:57:01 +0800
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
> > Wenbo Cao (28):
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
> >
> >  .mailmap                               |    1 +
> >  MAINTAINERS                            |    6 +
> >  doc/guides/nics/features/rnp.ini       |   33 +
> >  doc/guides/nics/img/mucse_nic_port.svg | 4023 =
++++++++++++++++++++++++
> >  doc/guides/nics/index.rst              |    1 +
> >  doc/guides/nics/rnp.rst                |  124 +
> >  doc/guides/rel_notes/release_25_03.rst |    5 +
> >  drivers/net/meson.build                |    1 +
> >  drivers/net/rnp/base/meson.build       |   17 +
> >  drivers/net/rnp/base/rnp_bdq_if.c      |  398 +++
> >  drivers/net/rnp/base/rnp_bdq_if.h      |  154 +
> >  drivers/net/rnp/base/rnp_bitrev.h      |   64 +
> >  drivers/net/rnp/base/rnp_common.c      |  103 +
> >  drivers/net/rnp/base/rnp_common.h      |   17 +
> >  drivers/net/rnp/base/rnp_crc32.c       |   37 +
> >  drivers/net/rnp/base/rnp_crc32.h       |   10 +
> >  drivers/net/rnp/base/rnp_dma_regs.h    |   68 +
> >  drivers/net/rnp/base/rnp_eth_regs.h    |   91 +
> >  drivers/net/rnp/base/rnp_fw_cmd.c      |  162 +
> >  drivers/net/rnp/base/rnp_fw_cmd.h      |  357 +++
> >  drivers/net/rnp/base/rnp_hw.h          |  136 +
> >  drivers/net/rnp/base/rnp_mac.c         |  358 +++
> >  drivers/net/rnp/base/rnp_mac.h         |   34 +
> >  drivers/net/rnp/base/rnp_mac_regs.h    |  208 ++
> >  drivers/net/rnp/base/rnp_mbx.c         |  510 +++
> >  drivers/net/rnp/base/rnp_mbx.h         |   58 +
> >  drivers/net/rnp/base/rnp_mbx_fw.c      |  493 +++
> >  drivers/net/rnp/base/rnp_mbx_fw.h      |   24 +
> >  drivers/net/rnp/base/rnp_osdep.h       |  172 +
> >  drivers/net/rnp/meson.build            |   27 +
> >  drivers/net/rnp/rnp.h                  |  258 ++
> >  drivers/net/rnp/rnp_ethdev.c           | 1845 +++++++++++
> >  drivers/net/rnp/rnp_link.c             |  439 +++
> >  drivers/net/rnp/rnp_link.h             |   52 +
> >  drivers/net/rnp/rnp_logs.h             |   36 +
> >  drivers/net/rnp/rnp_rss.c              |  367 +++
> >  drivers/net/rnp/rnp_rss.h              |   44 +
> >  drivers/net/rnp/rnp_rxtx.c             | 1818 +++++++++++
> >  drivers/net/rnp/rnp_rxtx.h             |  162 +
> >  39 files changed, 12713 insertions(+)  create mode 100644
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
> Thank you for the update, due to release timing it is unlikely this =
will
be able to be
> in 25.03 release.
>=20


