Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DB1C282EC
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Mar 2025 13:46:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8E46402D1;
	Mon, 17 Mar 2025 14:46:11 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 44760402BB
 for <dev@dpdk.org>; Mon, 17 Mar 2025 14:46:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1742219169;
 bh=VWh0p9gKE325yVAH+LFWOcwpK7+v4bIqmHpADIFFukM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=d+8Os8ZgOtFNA/tUO8Y6jNK8HN2l4N5ZWIIkSNqSTlj4Oc52KRReOWjttevJLDA17
 s733HE7XiX5eKIEIlxBRcFqNvMViJw9wdJEH8srjR7sNzVvJoU04WSTvyx/yEVskb0
 wKcsjGavix5a5QfMwVXLf4uHqhoSbRKROgNRRrmcGNQupRi8Izf49uDKGtB7m+iVWd
 uMK8RB7QueHdqTgVGPGNCcHV7s7A2qRrL5ug31EyxmOnfEUtshr3rt78YytkjPY1QZ
 eolRHG4Vk1F4GoNoJnRolCJ1SFZxWpiJS9eke1iTxYYvENWvP0eaIw3FgF10qrMGyM
 21Mg7HsMN//nA==
Received: from coaster.localdomain (viktorin-esprimo.cesnet.cz
 [IPv6:2001:718:812:27::83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 5DEC41180072;
 Mon, 17 Mar 2025 14:46:08 +0100 (CET)
Date: Mon, 17 Mar 2025 14:46:07 +0100
From: Jan Viktorin <viktorin@cesnet.cz>
To: Vipin Varghese <vipin.varghese@amd.com>
Cc: <dev@dpdk.org>, <roretzla@linux.microsoft.com>,
 <bruce.richardson@intel.com>, <john.mcnamara@intel.com>,
 <dmitry.kozliuk@gmail.com>, <pbhagavatula@marvell.com>,
 <jerinj@marvell.com>, <ruifeng.wang@arm.com>,
 <mattias.ronnblom@ericsson.com>, <anatoly.burakov@intel.com>,
 <stephen@networkplumber.org>, <ferruh.yigit@amd.com>,
 <honnappa.nagarahalli@arm.com>, <wathsala.vithanage@arm.com>,
 <konstantin.ananyev@huawei.com>, <mb@smartsharesystems.com>
Subject: Re: [PATCH v4 0/4] Introduce Topology NUMA grouping for lcores
Message-ID: <20250317144607.118a40b0@coaster.localdomain>
In-Reply-To: <20241105102849.1947-1-vipin.varghese@amd.com>
References: <20241105102849.1947-1-vipin.varghese@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Hello Vipin and others,

please, will there be any progress or update on this series?

I successfully tested those changes on our Intel and AMD machines and
would like to use it in production soon.

The API is a little bit unintuitive, at least for me, but I
successfully integrated into our software.

I am missing a clear relation to the NUMA socket approach used in DPDK.
E.g. I would like to be able to easily walk over a list of lcores from
a specific NUMA node grouped by L3 domain. Yes, there is the
RTE_LCORE_DOMAIN_IO, but would it always match the appropriate socket
IDs?

Also, I do not clearly understand what is the purpose of using domain
selector like:

  RTE_LCORE_DOMAIN_L1 | RTE_LCORE_DOMAIN_L2

or even:

  RTE_LCORE_DOMAIN_L3 | RTE_LCORE_DOMAIN_L2

the documentation does not explain this. I could not spot any kind of
grouping that would help me in any way. Some "best practices" examples
would be nice to have to understand the intentions better.

I found a little catch when running DPDK with more lcores than there
are physical or SMT CPU cores. This happens when using e.g. an option
like --lcores=(0-15)@(0-1). The results from the topology API would not
match the lcores because hwloc is not aware of the lcores concept. This
might be mentioned somewhere.

Anyway, I really appreciate this work and would like to see it upstream.
Especially for AMD machines, some framework like this is a must.

Kind regards,
Jan

On Tue, 5 Nov 2024 15:58:45 +0530
Vipin Varghese <vipin.varghese@amd.com> wrote:

> This patch introduces improvements for NUMA topology awareness in
> relation to DPDK logical cores. The goal is to expose API which allows
> users to select optimal logical cores for any application. These
> logical cores can be selected from various NUMA domains like CPU and
> I/O.
> 
> Change Summary:
>  - Introduces the concept of NUMA domain partitioning based on CPU and
>    I/O topology.
>  - Adds support for grouping DPDK logical cores within the same Cache
>    and I/O domain for improved locality.
>  - Implements topology detection and core grouping logic that
>    distinguishes between the following NUMA configurations:
>     * CPU topology & I/O topology (e.g., AMD SoC EPYC, Intel Xeon SPR)
>     * CPU+I/O topology (e.g., Ampere One with SLC, Intel Xeon SPR
> with SNC)
>  - Enhances performance by minimizing lcore dispersion across
> tiles|compute package with different L2/L3 cache or IO domains.
> 
> Reason:
>  - Applications using DPDK libraries relies on consistent memory
> access.
>  - Lcores being closer to same NUMA domain as IO.
>  - Lcores sharing same cache.
> 
> Latency is minimized by using lcores that share the same NUMA
> topology. Memory access is optimized by utilizing cores within the
> same NUMA domain or tile. Cache coherence is preserved within the
> same shared cache domain, reducing the remote access from
> tile|compute package via snooping (local hit in either L2 or L3
> within same NUMA domain).
> 
> Library dependency: hwloc
> 
> Topology Flags:
> ---------------
>  - RTE_LCORE_DOMAIN_L1: to group cores sharing same L1 cache
>  - RTE_LCORE_DOMAIN_SMT: same as RTE_LCORE_DOMAIN_L1
>  - RTE_LCORE_DOMAIN_L2: group cores sharing same L2 cache
>  - RTE_LCORE_DOMAIN_L3: group cores sharing same L3 cache
>  - RTE_LCORE_DOMAIN_L4: group cores sharing same L4 cache
>  - RTE_LCORE_DOMAIN_IO: group cores sharing same IO
> 
> < Function: Purpose >
> ---------------------
>  - rte_get_domain_count: get domain count based on Topology Flag
>  - rte_lcore_count_from_domain: get valid lcores count under each
> domain
>  - rte_get_lcore_in_domain: valid lcore id based on index
>  - rte_lcore_cpuset_in_domain: return valid cpuset based on index
>  - rte_lcore_is_main_in_domain: return true|false if main lcore is
> present
>  - rte_get_next_lcore_from_domain: next valid lcore within domain
>  - rte_get_next_lcore_from_next_domain: next valid lcore from next
> domain
> 
> Note:
>  1. Topology is NUMA grouping.
>  2. Domain is various sub-groups within a specific Topology.
> 
> Topology example: L1, L2, L3, L4, IO
> Domian example: IO-A, IO-B
> 
> < MACRO: Purpose >
> ------------------
>  - RTE_LCORE_FOREACH_DOMAIN: iterate lcores from all domains
>  - RTE_LCORE_FOREACH_WORKER_DOMAIN: iterate worker lcores from all
> domains
>  - RTE_LCORE_FORN_NEXT_DOMAIN: iterate domain select n'th lcore
>  - RTE_LCORE_FORN_WORKER_NEXT_DOMAIN: iterate domain for worker n'th
> lcore.
> 
> Future work (after merge):
> --------------------------
>  - dma-perf per IO NUMA
>  - eventdev per L3 NUMA
>  - pipeline per SMT|L3 NUMA
>  - distributor per L3 for Port-Queue
>  - l2fwd-power per SMT
>  - testpmd option for IO NUMA per port
> 
> Platform tested on:
> -------------------
>  - INTEL(R) XEON(R) PLATINUM 8562Y+ (support IO numa 1 & 2)
>  - AMD EPYC 8534P (supports IO numa 1 & 2)
>  - AMD EPYC 9554 (supports IO numa 1, 2, 4)
> 
> Logs:
> -----
> 1. INTEL(R) XEON(R) PLATINUM 8562Y+:
>  - SNC=1
>         Domain (IO): at index (0) there are 48 core, with (0) at
> index 0
>  - SNC=2
>         Domain (IO): at index (0) there are 24 core, with (0) at
> index 0 Domain (IO): at index (1) there are 24 core, with (12) at
> index 0
> 
> 2. AMD EPYC 8534P:
>  - NPS=1:
>         Domain (IO): at index (0) there are 128 core, with (0) at
> index 0
>  - NPS=2:
>         Domain (IO): at index (0) there are 64 core, with (0) at
> index 0 Domain (IO): at index (1) there are 64 core, with (32) at
> index 0
> 
> Signed-off-by: Vipin Varghese <vipin.varghese@amd.com>
> 
> Vipin Varghese (4):
>   eal/lcore: add topology based functions
>   test/lcore: enable tests for topology
>   doc: add topology grouping details
>   examples: update with lcore topology API
> 
>  app/test/test_lcores.c                        | 528 +++++++++++++
>  config/meson.build                            |  18 +
>  .../prog_guide/env_abstraction_layer.rst      |  22 +
>  examples/helloworld/main.c                    | 154 +++-
>  examples/l2fwd/main.c                         |  56 +-
>  examples/skeleton/basicfwd.c                  |  22 +
>  lib/eal/common/eal_common_lcore.c             | 714
> ++++++++++++++++++ lib/eal/common/eal_private.h                  |
> 58 ++ lib/eal/freebsd/eal.c                         |  10 +
>  lib/eal/include/rte_lcore.h                   | 209 +++++
>  lib/eal/linux/eal.c                           |  11 +
>  lib/eal/meson.build                           |   4 +
>  lib/eal/version.map                           |  11 +
>  lib/eal/windows/eal.c                         |  12 +
>  14 files changed, 1819 insertions(+), 10 deletions(-)
> 

