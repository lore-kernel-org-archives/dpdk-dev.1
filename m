Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE47CEF5868
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Feb 2026 08:58:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94AC340274;
	Sun, 15 Feb 2026 09:58:18 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id A3BCB40269
 for <dev@dpdk.org>; Sun, 15 Feb 2026 09:58:16 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fDKYY1wsmzHnGhT;
 Sun, 15 Feb 2026 16:57:53 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id 179B74056A;
 Sun, 15 Feb 2026 16:58:15 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sun, 15 Feb 2026 08:58:14 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Sun, 15 Feb 2026 08:58:14 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v6 00/11] net/rtap: add io_uring based TAP driver
Thread-Topic: [PATCH v6 00/11] net/rtap: add io_uring based TAP driver
Thread-Index: AQHcngxe12gE1PU2DkypNs8C+K5/SrWDddZQ
Date: Sun, 15 Feb 2026 08:58:14 +0000
Message-ID: <f1c3abe8bccc44ae96992945d379447f@huawei.com>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20260214234726.188947-1-stephen@networkplumber.org>
In-Reply-To: <20260214234726.188947-1-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.200.200]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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



>=20
> This series adds net_rtap, an experimental poll mode driver that uses
> Linux io_uring for asynchronous packet I/O with kernel TAP interfaces.
>=20
> Like net_tap, net_rtap creates a kernel network interface visible to
> standard tools (ip, ethtool) and the Linux TCP/IP stack.  From DPDK
> it is an ordinary ethdev.
>=20
> Motivation
> ----------
>=20
> This driver started as an experiment to determine whether Linux
> io_uring could deliver better packet I/O performance than the
> traditional read()/write() system calls used by net_tap.  By posting
> batches of I/O requests asynchronously, io_uring amortizes system
> call overhead across multiple packets.
=20
Sounds interesting...
Curious did you make any perf comparisons vs our traditional tap?
=20
> The project also served as a testbed for using AI tooling to help
> build a comprehensive test suite, refactor code, and improve
> documentation.  The result is intended as an example for other PMD
> authors: the driver has thorough unit tests covering data path,
> offloads, multi-queue, fd lifecycle, and more, along with detailed
> code comments explaining design choices.
>
>
>=20
> Why not extend net_tap?
> -----------------------
>=20
> The existing net_tap driver was designed to provide feature parity
> with mlx5 when used behind the failsafe PMD.  That goal led to
> significant complexity: rte_flow support emulated via eBPF programs,
> software GSO implementation, and other features that duplicate in
> user space what the kernel already does.
>=20
> net_rtap takes the opposite approach -- use the kernel efficiently
> and let it do what it does well.  There is no rte_flow support;
> receive queue selection is left to the kernel's native RSS/steering.
> There is no software GSO; the driver passes segmentation requests
> to the kernel via the virtio-net header and lets the kernel handle
> it.  The result is a much simpler driver that is easier to maintain
> and reason about.
>=20
> Given these fundamentally different design goals, a clean
> implementation was more practical than refactoring net_tap.
>=20
> Acknowledgement
> ---------------
>=20
> Parts of the test suite, code review, and refactoring were done
> with the assistance of Anthropic Claude (AI).  All generated code
> was reviewed and tested by the author.
>=20
> Requirements:
>   - Kernel headers with IORING_ASYNC_CANCEL_ALL (upstream since 5.19)
>   - liburing >=3D 2.0
>=20
> Should work on distributions: Debian 12+, Ubuntu 24.04+,
> Fedora 37+, SLES 15 SP6+ / openSUSE Tumbleweed.
> RHEL 9 is not supported (io_uring is disabled by default).
>=20
> v6:
>   - fix lots of bugs found doing automated review
>   - convert to use ifindex and netlink to avoid rename issues
>   - implement xstats
>=20
> Stephen Hemminger (11):
>   net/rtap: add driver skeleton and documentation
>   net/rtap: add TAP device creation and queue management
>   net/rtap: add Rx/Tx with scatter/gather support
>   net/rtap: add statistics and device info
>   net/rtap: add link and device management operations
>   net/rtap: add checksum and TSO offload support
>   net/rtap: add multi-process support
>   net/rtap: add link state change interrupt
>   net/rtap: add Rx interrupt support
>   net/rtap: add extended statistics support
>   test: add unit tests for rtap PMD
>=20
>  MAINTAINERS                            |    7 +
>  app/test/meson.build                   |    1 +
>  app/test/test_pmd_rtap.c               | 2620 ++++++++++++++++++++++++
>  doc/guides/nics/features/rtap.ini      |   26 +
>  doc/guides/nics/index.rst              |    1 +
>  doc/guides/nics/rtap.rst               |  101 +
>  doc/guides/rel_notes/release_26_03.rst |    7 +
>  drivers/net/meson.build                |    1 +
>  drivers/net/rtap/meson.build           |   30 +
>  drivers/net/rtap/rtap.h                |  152 ++
>  drivers/net/rtap/rtap_ethdev.c         |  864 ++++++++
>  drivers/net/rtap/rtap_intr.c           |  207 ++
>  drivers/net/rtap/rtap_netlink.c        |  445 ++++
>  drivers/net/rtap/rtap_rxtx.c           |  803 ++++++++
>  drivers/net/rtap/rtap_xstats.c         |  293 +++
>  15 files changed, 5558 insertions(+)
>  create mode 100644 app/test/test_pmd_rtap.c
>  create mode 100644 doc/guides/nics/features/rtap.ini
>  create mode 100644 doc/guides/nics/rtap.rst
>  create mode 100644 drivers/net/rtap/meson.build
>  create mode 100644 drivers/net/rtap/rtap.h
>  create mode 100644 drivers/net/rtap/rtap_ethdev.c
>  create mode 100644 drivers/net/rtap/rtap_intr.c
>  create mode 100644 drivers/net/rtap/rtap_netlink.c
>  create mode 100644 drivers/net/rtap/rtap_rxtx.c
>  create mode 100644 drivers/net/rtap/rtap_xstats.c
>=20
> --
> 2.51.0

