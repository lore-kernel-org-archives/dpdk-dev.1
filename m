Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEABBCAC5B8
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 07:42:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B633A402E2;
	Mon,  6 Oct 2025 09:42:23 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B5F20402AF
 for <dev@dpdk.org>; Mon,  6 Oct 2025 09:42:22 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A81F5202CC;
 Mon,  6 Oct 2025 09:42:21 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v8 00/18] Simplify running with high-numbered CPUs
Date: Mon, 6 Oct 2025 09:42:20 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65499@smartserver.smartshare.dk>
In-Reply-To: <20251002174315.962992-1-bruce.richardson@intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v8 00/18] Simplify running with high-numbered CPUs
Thread-Index: AdwzxA/5cJzVXngnSse0jEgvAzptTQCy4/mg
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251002174315.962992-1-bruce.richardson@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
	<dev@dpdk.org>
Cc: <david.marchand@redhat.com>
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

Bruce,

cpu_set_t is a fixed size array, with the size CPU_SETSIZE.
This is part of libc.

However, the kernel may be built with support for a different number of =
CPUs.
This means that e.g. sched_getaffinity() will fail with EINVAL if =
cpusetsize is smaller than the number of CPUs the kernel was built for.
For more information, refer to the description about "Dynamically sized =
CPU sets" here:
https://linux.die.net/man/3/cpu_alloc_size

With this series, consider ensuring that all DPDK functions taking a cpu =
set parameter also take a cpu set size parameter, to align with kernel =
APIs.
E.g.:
int sched_getaffinity(pid_t pid,
	size_t cpusetsize, cpu_set_t *mask), and
void CPU_ZERO_S(size_t setsize, cpu_set_t *set),
instead of:
void CPU_ZERO(cpu_set_t *set).

<feature creep>
Consider not using fixed size cpu sets (and CPU_SETSIZE) at all, but =
dynamically allocated cpu sets.
</feature creep>

<joke>
Consider not using fixed size lcore arrays (and RTE_MAX_LCORE) at all, =
but dynamically allocated lcore arrays.
</joke>


Venlig hilsen / Kind regards,
-Morten Br=F8rup

