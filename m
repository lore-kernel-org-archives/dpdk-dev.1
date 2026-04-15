Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDF9F43821
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:06:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E255C4042F;
	Wed, 15 Apr 2026 16:06:58 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id A45BD402F0
 for <dev@dpdk.org>; Wed, 15 Apr 2026 16:06:57 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 5CB5F20912;
 Wed, 15 Apr 2026 16:06:57 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v5 v5 1/3] eal/topology: add Topology grouping for lcores
Date: Wed, 15 Apr 2026 16:06:51 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F657EE@smartserver.smartshare.dk>
In-Reply-To: <20260414193850.1696-2-vipin.varghese@amd.com>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5 v5 1/3] eal/topology: add Topology grouping for lcores
Thread-Index: AdzMRnhTZWs4XsuNTumito9TK8+ZlwAl4uPg
References: <20241105102849.1947-1-vipin.varghese@amd.com>
 <20260414193850.1696-1-vipin.varghese@amd.com>
 <20260414193850.1696-2-vipin.varghese@amd.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Vipin Varghese" <vipin.varghese@amd.com>, <dev@dpdk.org>,
 <sivaprasad.tummala@amd.com>
Cc: <konstantin.ananyev@huawei.com>, <wathsala.vithanage@arm.com>,
 <bruce.richardson@intel.com>, <viktorin@cesnet.cz>
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

> @@ -40,6 +45,63 @@ struct lcore_config {
>=20
>  extern struct lcore_config lcore_config[RTE_MAX_LCORE];
>=20
> +struct core_domain_mapping {
> +	rte_cpuset_t core_set;	/**< cpu_set representing lcores within
> domain */
> +	uint16_t core_count;	/**< dpdk enabled lcores within domain */
> +	uint16_t *cores;	/**< list of cores */
> +};

In Linux, rte_cpu_set_t is the same as cpu_set_t, which is limited to =
CPU_SETSIZE (1024) cores.

We should stop using that (fixed size) type, and use dynamically sized =
CPU sets instead.
Ref: https://man7.org/linux/man-pages/man3/CPU_SET.3.html

IMHO, both the fd_set type, limited to FDSET_SIZE (1024) file =
descriptors, and the cpu_set_t type, limited to CPU_SETSIZE (1024) =
cores, should be considered obsolete, and not used in new DPDK code.

It's hard to change old DPDK APIs relying on the fixed size =
rte_cpu_set_t type, but let's avoid adding new APIs using that =
(obsolete) type.

Also refer to: https://bugs.dpdk.org/show_bug.cgi?id=3D1704

PS: I guess a larger CPU_SETSIZE is available for systems built entirely =
from scratch, including libc and all libraries and applications. Not a =
generic solution.

-Morten

