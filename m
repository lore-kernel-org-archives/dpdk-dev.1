Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE59C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 12:51:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FB0E4069F;
	Tue,  3 Jun 2025 14:51:02 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B9E5640697
 for <dev@dpdk.org>; Tue,  3 Jun 2025 14:51:00 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 7D75720100;
 Tue,  3 Jun 2025 14:51:00 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v17 0/4] add support for self monitoring
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 3 Jun 2025 14:50:56 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FCB7@smartserver.smartshare.dk>
In-Reply-To: <20250117090033.2807073-1-tduszynski@marvell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v17 0/4] add support for self monitoring
Thread-Index: Adto3Lq2kuUyVdtYSUeLxqbV5peqNRrp88VA
References: <20241118073706.3129423-1-tduszynski@marvell.com>
 <20250117090033.2807073-1-tduszynski@marvell.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Tomasz Duszynski" <tduszynski@marvell.com>,
	<dev@dpdk.org>
Cc: <Ruifeng.Wang@arm.com>, <bruce.richardson@intel.com>,
 <david.marchand@redhat.com>, <jerinj@marvell.com>,
 <konstantin.v.ananyev@yandex.ru>, <mattias.ronnblom@ericsson.com>,
 <roretzla@linux.microsoft.com>, <stephen@networkplumber.org>,
 <thomas@monjalon.net>, <zhoumin@loongson.cn>,
 "David Christensen" <drc@linux.ibm.com>,
 "Stanislaw Kardach" <stanislaw.kardach@gmail.com>,
 "Wathsala Vithanage" <wathsala.vithanage@arm.com>,
 "Vipin Varghese" <vipin.varghese@amd.com>
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

+CC David Christensen (IBM POWER maintainer) and Stanislaw Kardach =
(RISC-V maintainer)
+CC Stanislaw Kardach (RISC-V maintainer)
+CC Wathsala Vithanage (ARM maintainer)
+CC Vipin Varghese (AMD x86 maintainer)

> From: Tomasz Duszynski [mailto:tduszynski@marvell.com]
> Sent: Friday, 17 January 2025 10.00
>=20
> This series adds self monitoring support i.e allows to configure and
> read performance measurement unit (PMU) counters in runtime without
> using perf utility. This has certain advantages when application runs
> on
> isolated cores running dedicated tasks.
>=20
> Events can be read directly using rte_pmu_read() or using dedicated
> tracepoint rte_eal_trace_pmu_read(). The latter will cause events to =
be
> stored inside CTF file.
>=20
> By design, all enabled events are grouped together and the same group
> is attached to lcores that use self monitoring funtionality.
>=20
> Events are enabled by names, which need to be read from standard
> location under sysfs i.e
>=20
> /sys/bus/event_source/devices/PMU/events
>=20
> where PMU is a core pmu i.e one measuring cpu events. As of today
> raw events are not supported.
>=20
> v17:
> - improve docs
> - use safer strtok_r()
> v16:
> - fix build issue related to ALLOW_EXPERIMENTAL_API not always defined
> - rename tracepoints upfront to make it easier to decouple for tracing
> - minor doc improvements
> - make sure non EAL threads can't read PMU
> v15:
> - add some basic logs related to API failures
> - get rid of thread-local-storage
> - do not support MT-safety (which was buggy anyway) in management APIs
> (rte_pmu_init(),
>   rte_pmu_fini(), rte_pmu_add_{event,events_by_pattern}() as it =
impacts
> rte_pmu_read()
>   performance because more logic needs to be incorporated to handle =
all
> corner cases
> - improve documentation slightly
> - various other improvements here and there
> v14:
> - replace __atomic_xxx with rte_atomic_xxx
> - rebase to dpdk/main since that's a new feature
> v13:
> - allow init/fini calling from multiple contexts
> - get rid of conditional compilation and return erors in case APIs are
>   used on unsupported OS
> v12:
> - rebase old series
> - slightly refresh existing documentation
> - make sure compiler won't optimize accesses to certain variables
> during
>   event readout
> - drop previous Acked-by to respin a fresh review cycle
> v11:
> - skip fast test in case init fails
> v10:
> - check permissions before using counters
> - do not use internal symbols in exported functions
> - address review comments
> v9:
> - fix 'maybe-uninitialized' warning reported by CI
> v8:
> - just rebase series
> v7:
> - use per-lcore event group instead of global table index by lcore-id
> - don't add pmu_autotest to fast tests because due to lack of suported
>   on every arch
> v6:
> - move codebase to the separate library
> - address review comments
> v5:
> - address review comments
> - fix sign extension while reading pmu on x86
> - fix regex mentioned in doc
> - various minor changes/improvements here and there
> v4:
> - fix freeing mem detected by debug_autotest
> v3:
> - fix shared build
> v2:
> - fix problems reported by test build infra
>=20
> Tomasz Duszynski (4):
>   lib: add generic support for reading PMU events
>   pmu: support reading ARM PMU events in runtime
>   pmu: support reading Intel x86_64 PMU events in runtime
>   eal: add PMU support to tracing library
>=20
>  MAINTAINERS                              |   5 +
>  app/test/meson.build                     |   1 +
>  app/test/test_pmu.c                      |  55 +++
>  app/test/test_trace_perf.c               |  10 +
>  doc/api/doxy-api-index.md                |   3 +-
>  doc/api/doxy-api.conf.in                 |   1 +
>  doc/guides/prog_guide/glossary.rst       |   3 +
>  doc/guides/prog_guide/profile_app.rst    |  38 ++
>  doc/guides/prog_guide/trace_lib.rst      |  32 ++
>  doc/guides/rel_notes/release_25_03.rst   |   7 +
>  lib/eal/common/eal_common_trace.c        |   5 +-
>  lib/eal/common/eal_common_trace_pmu.c    |  38 ++
>  lib/eal/common/eal_common_trace_points.c |   5 +
>  lib/eal/common/eal_trace.h               |   4 +
>  lib/eal/common/meson.build               |   1 +
>  lib/eal/include/rte_eal_trace.h          |  11 +
>  lib/eal/meson.build                      |   3 +
>  lib/eal/version.map                      |   1 +
>  lib/meson.build                          |   1 +
>  lib/pmu/meson.build                      |  22 +
>  lib/pmu/pmu_arm64.c                      |  94 ++++
>  lib/pmu/pmu_private.h                    |  32 ++
>  lib/pmu/rte_pmu.c                        | 537 =
+++++++++++++++++++++++
>  lib/pmu/rte_pmu.h                        | 251 +++++++++++
>  lib/pmu/rte_pmu_pmc_arm64.h              |  30 ++
>  lib/pmu/rte_pmu_pmc_x86_64.h             |  24 +
>  lib/pmu/version.map                      |  15 +
>  27 files changed, 1227 insertions(+), 2 deletions(-)
>  create mode 100644 app/test/test_pmu.c
>  create mode 100644 lib/eal/common/eal_common_trace_pmu.c
>  create mode 100644 lib/pmu/meson.build
>  create mode 100644 lib/pmu/pmu_arm64.c
>  create mode 100644 lib/pmu/pmu_private.h
>  create mode 100644 lib/pmu/rte_pmu.c
>  create mode 100644 lib/pmu/rte_pmu.h
>  create mode 100644 lib/pmu/rte_pmu_pmc_arm64.h
>  create mode 100644 lib/pmu/rte_pmu_pmc_x86_64.h
>  create mode 100644 lib/pmu/version.map
>=20
> --
> 2.34.1

Series-acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

I think the PMU library will be useful, and hope it gets into the 25.11 =
LTS release.
Let's see if it can go into 25.07 to begin with.

NB: Although this is Linux only, consider using rte_ffs64() instead of =
__builtin_ffsll() in the FIELD_PREP() macro.

