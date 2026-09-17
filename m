Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D12C88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 12:48:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6DEB40299;
	Thu, 17 Sep 2026 14:48:29 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5C6B6400D5
 for <dev@dpdk.org>; Thu, 17 Sep 2026 14:48:28 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 249EB20817;
 Thu, 17 Sep 2026 14:48:28 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: EAL feature request
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 17 Sep 2026 14:48:24 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A50@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: EAL feature request
Thread-Index: Ad1GotPN4gjQ6ZYES+Sh5fvZHAH79A==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
 "David Marchand" <david.marchand@redhat.com>
Cc: "Robin Jarry" <rjarry@redhat.com>,
	<dev@dpdk.org>
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

Bruce, David,

I don't know if this would be useful or not, but here goes...

Situation today:

DPDK has 3 types of threads with a valid lcore_id:
1. EAL threads,=20
2. Service threads,
3. Non-EAL threads.

EAL threads are controlled by DPDK, and associated with physical cores =
at startup using the --lcores=3D<lcore_id>@<cpu_ids> parameter, and =
their OS cpuset/affinity etc. is managed by DPDK.

Service threads are also managed by DPDK.

Non-EAL threads are application created threads, which are simply =
assigned a valid lcore_id, but their OS cpuset/affinity etc. remains =
managed by the application.

Furthermore, macros such as RTE_LCORE_FOREACH_WORKER() only iterate over =
EAL threads, and rte_lcore_is_enabled() is only true for EAL threads.
AFAIU, this means that DPDK only considers EAL threads as fastpath =
("WORKER") threads.
(The main thread is also an EAL thread, although it is usually not a =
fastpath thread. But its OS cpuset/affinity etc. is managed by DPDK, =
which is good.)


Feature request:

Functions to create and destroy EAL threads at runtime, so applications =
like Grout could dynamically create/destroy threads that:
1. DPDK considers EAL (i.e. WORKER) threads,
2. Have their OS cpuset/affinity etc. managed by DPDK.

Such functions would probably need to take <lcore_id> and <cpu_ids> =
parameters, for dynamically updating the list of DPDK managed lcores and =
CPUs at runtime.

Maybe the ability to dynamically manipulate the <lcore_id>@<cpu_ids> =
mapping could be a separate set of APIs, so rte_thread_create_eal() =
would not require those parameters. (Don't know, just brainstorming.)


Reason for asking:

Because DPDK doesn't provide this feature (hot-plug/remove of EAL =
threads), Grout has to take on the task of performing its own thread =
management (OS cpuset/affinity etc.), register its fastpath threads as =
Non-EAL threads, and cannot use =
RTE_LCORE_FOREACH_WORKER()/rte_lcore_is_enabled() for them, but =
considers Non-EAL as fastpath threads.


Generally it would be logical for an application to register its control =
plane threads as Non-EAL threads to get the benefits that come with a =
valid lcore_id. But how then can DPDK discriminate between control plane =
and fastpath threads? Only the application knows.

It would be nice if DPDK's perception of which threads are fastpath or =
control plane was aligned with the application's perception.


NB:
For completeness, I should mention threads with no lcore_id, created via =
rte_thread_create_control(), and the OS cpuset/affinity etc. managed by =
the application.


Venlig hilsen / Kind regards,
-Morten Br=F8rup

