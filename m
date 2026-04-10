Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF69F44873
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 14:35:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E4D74026C;
	Fri, 10 Apr 2026 16:35:00 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 929554026C
 for <dev@dpdk.org>; Fri, 10 Apr 2026 16:34:58 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 53FFA20692;
 Fri, 10 Apr 2026 16:34:58 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v3 0/7] Rework device probing
Date: Fri, 10 Apr 2026 16:34:56 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F657DF@smartserver.smartshare.dk>
In-Reply-To: <20260407115211.1903623-1-david.marchand@redhat.com>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 0/7] Rework device probing
Thread-Index: AdzGhP99JzyzkG5RTFqc0XlPw/4tKwCZhw3g
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260407115211.1903623-1-david.marchand@redhat.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "David Marchand" <david.marchand@redhat.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Robin Jarry" <rjarry@redhat.com>,
 "Hemant Agrawal" <hemant.agrawal@nxp.com>,
 "Maxime Leroy" <maxime@leroys.fr>, "Kevin Traynor" <ktraynor@redhat.com>
Cc: <dev@dpdk.org>
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

Is there a workaround until this patch is added, if I don't want =
rte_eal_init() to probe any devices, but I want my application to probe =
devices later by calling rte_bus_scan() followed by rte_bus_probe()?

It's not something we really need, so if you don't know it off the top =
of your head, don't spend time trying to figure it out.


Venlig hilsen / Kind regards,
-Morten Br=F8rup

> -----Original Message-----
> From: David Marchand [mailto:david.marchand@redhat.com]
> Sent: Tuesday, 7 April 2026 13.52
> To: dev@dpdk.org
> Subject: [PATCH v3 0/7] Rework device probing
>=20
> Applications relying on device hotplug don't work well with the =
default
> probing of all available resources.
> This series proposes to change this behavior via a new EAL option.
>=20
>=20
> --
> David Marchand
>=20
> Changes since v2:
> - rebased for late 26.03 fslmc bus changes,
> - fixed devargs lookup,
> - added debug logs,
>=20
> Changes since v1:
> - restored per bus scan mode,
> - fixed logic in device selection for dma/idxd,
> - fixed raw/ifpga hotplug on ifpga bus,
> - fixed some doxygen,
>=20
> Changes since RFC v3:
> - removed per bus scan mode,
>=20
> Changes since RFC v2:
> - went one step further and reworked devargs lookup in buses following
>   Bruce comment (see patch 4 which is cosmetic, and patch 5),
> - updated device selection helper accordingly and
>   changed API to be device name based,
> - renamed option, added check on -b presence, updated doc in the last
>   patch,
>=20
> Changes since RFC v1:
> - reviewed bus probe() and cleaned up NXP drivers,
> - changed approach following Bruce comment,
>=20
> David Marchand (7):
>   devtools: check packet forwarding in null test
>   bus/fslmc: fix bus cleanup
>   drivers/bus: require probe function for NXP drivers
>   drivers/bus: cleanup devargs lookup in scan
>   bus: factorize devargs lookup
>   bus: factorize device selection
>   eal: configure initial device probing
>=20
>  app/test/test_eal_flags.c                    | 63 ++++++++++++++++
>  devtools/test-null.sh                        | 10 ++-
>  doc/guides/linux_gsg/eal_args.include.rst    | 13 ++++
>  drivers/bus/auxiliary/auxiliary_common.c     | 33 +--------
>  drivers/bus/auxiliary/bus_auxiliary_driver.h |  2 -
>  drivers/bus/auxiliary/linux/auxiliary.c      |  2 +-
>  drivers/bus/auxiliary/private.h              |  6 --
>  drivers/bus/cdx/cdx.c                        | 34 +--------
>  drivers/bus/dpaa/dpaa_bus.c                  | 71 ++++++++----------
>  drivers/bus/fslmc/fslmc_bus.c                | 75 =
++++++++------------
>  drivers/bus/fslmc/fslmc_vfio.c               | 21 ++----
>  drivers/bus/ifpga/ifpga_bus.c                |  8 ++-
>  drivers/bus/pci/bsd/pci.c                    |  5 +-
>  drivers/bus/pci/linux/pci.c                  |  2 +-
>  drivers/bus/pci/pci_common.c                 | 51 ++++---------
>  drivers/bus/pci/private.h                    | 11 ---
>  drivers/bus/pci/windows/pci.c                |  4 +-
>  drivers/bus/platform/platform.c              | 43 +----------
>  drivers/bus/uacce/uacce.c                    | 39 +---------
>  drivers/bus/vdev/vdev.c                      |  2 +-
>  drivers/bus/vmbus/linux/vmbus_bus.c          |  2 +-
>  drivers/bus/vmbus/private.h                  |  3 -
>  drivers/bus/vmbus/vmbus_common.c             | 45 +++---------
>  drivers/dma/idxd/idxd_bus.c                  | 18 +----
>  lib/eal/common/eal_common_bus.c              | 54 ++++++++++++++
>  lib/eal/common/eal_common_options.c          | 10 +++
>  lib/eal/common/eal_internal_cfg.h            |  1 +
>  lib/eal/common/eal_option_list.h             |  2 +
>  lib/eal/include/bus_driver.h                 | 38 ++++++++++
>  29 files changed, 301 insertions(+), 367 deletions(-)
>=20
> --
> 2.53.0

