Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD7FC0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 15:18:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75D8C402C9;
	Tue, 11 Feb 2025 16:18:46 +0100 (CET)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 76BF3402C6
 for <dev@dpdk.org>; Tue, 11 Feb 2025 16:18:43 +0100 (CET)
X-QQ-mid: bizesmtp91t1739287115t56cez9s
X-QQ-Originating-IP: lFl+LRjowitz5hvYCO0PlnHvzla+blGdRrWRV942tCw=
Received: from LAPTOP96V0OHHN ( [103.233.162.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 11 Feb 2025 23:18:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10994067984590081140
From: "11" <caowenbo@mucse.com>
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>, <ferruh.yigit@amd.com>,
 <andrew.rybchenko@oktetlabs.ru>, <yaojun@mucse.com>
References: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>
 <20250211065649.1885ab26@hermes.local>
In-Reply-To: <20250211065649.1885ab26@hermes.local>
Subject: RE: [PATCH v9 00/28] [v9]drivers/net Add Support mucse N10 Pmd Driver
Date: Tue, 11 Feb 2025 23:18:34 +0800
Message-ID: <D097802739E0FA43+000801db7c98$387d2380$a9776a80$@mucse.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLqICmjQftEF0oQ/zI69QXbQqbszQDiSxVNsR3bbPA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NtlZ4W2gZhzd7YtSetnpj7uetxlVwngDEwc+vwbJjfxsEJvAQ4XvteWs
 vH+yzP2IHwUsGCZLb+MFCnthAN0EOo38/ARvkgMEyWaJ85QQhlBPeqrf4p5Un2Gb2ft+u/T
 nCfcUi6X8H16NtqvBYCS2eTjmKNw8FmM09TX2Kn/w5uN/TGMA7MX51asmkWaIQZTAES/kBw
 i1UGtd5JTSCIJLGcSyBMp5t8oialJtH+CWHQ3+tzLMF3OKCfcaNmwbzDIbzgNdSEXTYJg1Z
 SD3tmv8mNkAyNIhg9eXsaTiC0QB6lqrhnbeiFREy9CAr10qIeybk5q4fuZ+8OJVrLLxfuCX
 6Gfa72jw0dXId4jYe4N7RjigcjpgoKSSHCi3S3uw5HKDRV9er1YCSpHqs05ISx+nhmwrci1
 wreYbMpgjqO3ejgeqZ+JyUJBD/l/Bqan+Bs11iaBCbv6uA6I2DeeDBOlscoAMI7eN0Cxc9V
 JVAo5aFcxJdvAvcSCzf7oQMM3WRFNjgO88sCU+EAPEL5z6Rx6wxniJOVQ8HK9wiKmG1GA65
 Tw+MbxNlDr2hzCpKXM0ufoEwKtkMxDRx3sptOinb22dAxAkA4CfFv72kgpGFhfyGxZQyWS/
 9YZx+e5j4nrIZgNVPhOKZe3GQ3BSAW59paphRqVI88Q7qj/oC1J5gF2+BzQ1B5uNlsYqzTf
 F3KhozV9L4QMK0UFRoG0LhccCm9tNsTlrjsdnU0ecTsGOWCPHlqOevluvOINv11jojW7BgN
 s3r8onFYuLn38OCrH1a3t4fSjg0DJMjAgS1R4UPFNxPx+o66Ue7X4FzT8EioJsqNc1khiq1
 WTyu06O6Z5OrqMwk30HTEhehbLwfj29xYF3F39VTshB/gPIl3bQodTA+8C/yTPbBsIa28Xt
 PN/FWVZE/0KrbHk7OjZWJstlfAcIyuzYeCwwdMT/foCuy1mji1v1uLJ568H2bL32dI5tI6i
 1OHQ=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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

Hi Stephen=EF=BC=8C

For rsic-v,windows freebsd plaform, I need to limit compile meson file =
what we not support ?

Regards Wenbo

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: 2025=E5=B9=B42=E6=9C=8811=E6=97=A5 22:57
> To: Wenbo Cao <caowenbo@mucse.com>
> Cc: thomas@monjalon.net; dev@dpdk.org; ferruh.yigit@amd.com;
> andrew.rybchenko@oktetlabs.ru; yaojun@mucse.com
> Subject: Re: [PATCH v9 00/28] [v9]drivers/net Add Support mucse N10 =
Pmd
> Driver
>=20
> On Tue, 11 Feb 2025 16:49:50 +0800
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
> >  .mailmap                            |    1 +
> >  MAINTAINERS                         |    6 +
> >  doc/guides/nics/features/rnp.ini    |   33 +
> >  doc/guides/nics/index.rst           |    1 +
> >  doc/guides/nics/rnp.rst             |  101 ++
> >  drivers/net/meson.build             |    1 +
> >  drivers/net/rnp/base/meson.build    |   28 +
> >  drivers/net/rnp/base/rnp_bdq_if.c   |  398 ++++++
> >  drivers/net/rnp/base/rnp_bdq_if.h   |  154 +++
> >  drivers/net/rnp/base/rnp_bitrev.h   |   64 +
> >  drivers/net/rnp/base/rnp_common.c   |  103 ++
> >  drivers/net/rnp/base/rnp_common.h   |   17 +
> >  drivers/net/rnp/base/rnp_crc32.c    |   37 +
> >  drivers/net/rnp/base/rnp_crc32.h    |   10 +
> >  drivers/net/rnp/base/rnp_dma_regs.h |   68 +
> >  drivers/net/rnp/base/rnp_eth_regs.h |   90 ++
> >  drivers/net/rnp/base/rnp_fw_cmd.c   |  162 +++
> >  drivers/net/rnp/base/rnp_fw_cmd.h   |  358 ++++++
> >  drivers/net/rnp/base/rnp_hw.h       |  136 ++
> >  drivers/net/rnp/base/rnp_mac.c      |  367 ++++++
> >  drivers/net/rnp/base/rnp_mac.h      |   34 +
> >  drivers/net/rnp/base/rnp_mac_regs.h |  207 +++
> >  drivers/net/rnp/base/rnp_mbx.c      |  512 ++++++++
> >  drivers/net/rnp/base/rnp_mbx.h      |   58 +
> >  drivers/net/rnp/base/rnp_mbx_fw.c   |  499 ++++++++
> >  drivers/net/rnp/base/rnp_mbx_fw.h   |   24 +
> >  drivers/net/rnp/base/rnp_osdep.h    |  173 +++
> >  drivers/net/rnp/meson.build         |   20 +
> >  drivers/net/rnp/rnp.h               |  258 ++++
> >  drivers/net/rnp/rnp_ethdev.c        | 1841 =
+++++++++++++++++++++++++++
> >  drivers/net/rnp/rnp_link.c          |  439 +++++++
> >  drivers/net/rnp/rnp_link.h          |   38 +
> >  drivers/net/rnp/rnp_logs.h          |   36 +
> >  drivers/net/rnp/rnp_rss.c           |  367 ++++++
> >  drivers/net/rnp/rnp_rss.h           |   43 +
> >  drivers/net/rnp/rnp_rxtx.c          | 1820 =
++++++++++++++++++++++++++
> >  drivers/net/rnp/rnp_rxtx.h          |  162 +++
> >  37 files changed, 8666 insertions(+)
> >  create mode 100644 doc/guides/nics/features/rnp.ini  create mode
> > 100644 doc/guides/nics/rnp.rst  create mode 100644
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
> Two copies of v9 received.
> Build is failing in CI
> -------------------------------BEGIN LOGS----------------------------
> #################################################################
> ###################
> #### [Begin job log] "ubuntu-22.04-gcc-static-mingw" at step Build and =
test
> #################################################################
> ###################
> [632/3011] Linking static target drivers/libtmp_rte_net_ring.a =
[633/3011] Linking
> static target drivers/librte_net_r8169.a [634/3011] Generating
> rte_net_ring.pmd.c with a custom command [635/3011] Linking target
> drivers/librte_net_r8169-25.dll [636/3011] Compiling C object
> =
drivers/librte_net_ring-25.dll.p/meson-generated_.._rte_net_ring.pmd.c.ob=
j
> [637/3011] Compiling C object drivers/librte_net_ring.a.p/meson-
> generated_.._rte_net_ring.pmd.c.obj
> [638/3011] Linking target drivers/librte_net_ring-25.dll [639/3011] =
Linking static
> target drivers/librte_net_ring.a [640/3011] Compiling C object
> drivers/net/rnp/base/librnp_base.a.p/rnp_mbx_fw.c.obj
> FAILED: drivers/net/rnp/base/librnp_base.a.p/rnp_mbx_fw.c.obj
> ccache x86_64-w64-mingw32-gcc -Idrivers/net/rnp/base/librnp_base.a.p -
> Idrivers/net/rnp/base -I../drivers/net/rnp/base -I. -I.. -Iconfig =
-I../config -
> Ilib/eal/include -I../lib/eal/include -Ilib/eal/windows/include -
> I../lib/eal/windows/include -Ilib/eal/x86/include =
-I../lib/eal/x86/include -
> Ilib/eal/common -I../lib/eal/common -Ilib/eal -I../lib/eal -Ilib/log =
-I../lib/log -
> Ilib/kvargs -I../lib/kvargs -Ilib/net -I../lib/net -Ilib/mbuf =
-I../lib/mbuf -
> Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/metrics =
-I../lib/metrics -
> Ilib/telemetry -I../lib/telemetry -Ilib/ethdev -I../lib/ethdev =
-Ilib/meter -
> I../lib/meter -fdiagnostics-color=3Dalways -pipe =
-D_FILE_OFFSET_BITS=3D64 -Wall -
> Winvalid-pch -Wextra -Werror -std=3Dc11 -O2 -g -include rte_config.h =
-Wvla -
> Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral -Wformat-security =
-
> Wmissing-declarations -Wmissing-prototypes -Wnested-externs =
-Wold-style-
> definition -Wpointer-arith -Wsign-compare -Wstrict-prototypes -Wundef =
-
> Wwrite-strings -Wno-packed-not-aligned -Wno-missing-field-initializers =
-
> D_GNU_SOURCE -D_WIN32_WINNT=3D0x0A00 -D__USE_MINGW_ANSI_STDIO -
> march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -
> Wno-format-truncation -Wno-address-of-packed-member -Wno-unused-value =
-
> Wno-unused-but-set-variable -Wno-unused-parameter -MD -MQ
> drivers/net/rnp/base/librnp_base.a.p/rnp_mbx_fw.c.obj -MF
> drivers/net/rnp/base/librnp_base.a.p/rnp_mbx_fw.c.obj.d -o
> drivers/net/rnp/base/librnp_base.a.p/rnp_mbx_fw.c.obj -
> c ../drivers/net/rnp/base/rnp_mbx_fw.c
> ../drivers/net/rnp/base/rnp_mbx_fw.c: In function =
=E2=80=98rnp_mbx_fw_get_capability=E2=80=99:
> ../drivers/net/rnp/base/rnp_mbx_fw.c:259:15: error: implicit =
declaration of
> function =E2=80=98ffs=E2=80=99; did you mean =E2=80=98fls=E2=80=99? =
[-Werror=3Dimplicit-function-declaration]
>   259 |    lane_bit =3D ffs(temp_mask) - 1;
>       |               ^~~
>       |               fls
>=20
>=20
> You need to use rte_ffs32 (or rte_ffs64) from rte_bitops.h instead.


