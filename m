Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2B5C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 15:22:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24F6740E03;
	Thu, 15 May 2025 17:22:05 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id E4C8440E03
 for <dev@dpdk.org>; Thu, 15 May 2025 17:22:03 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id CC0FC208EC;
 Thu, 15 May 2025 17:22:02 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: CPU affinity of control threads
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 15 May 2025 17:22:00 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FC57@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CPU affinity of control threads
Thread-Index: AdvFrRqnKMEXaaDQRluw/Fi3vk50Ww==
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <bruce.richardson@intel.com>
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

Bruce,

I found another gap in the documentation of CPU affinities.

Let's assume a 6-core system.

If a DPDK application is run using:
taskset --cpu-list 0-2 dpdk-app --lcores 3-5

Lcores 3-5 are EAL cores, and each of the three lcores is bound to one =
cpu, respectively cpu 3, 4 and 5?
Lcore 3 is the main lcore, and lcores 4-5 are worker lcores?
And the original thread of the process (a.k.a. the main lcore) gets its =
cpuset is changed from 0-2 to 3?

Now, calling rte_thread_create_control() starts a control thread.
Its documentation says:
"Creates a control thread with the given name and attributes. The
affinity of the new thread is based on the CPU affinity retrieved
at the time rte_eal_init() was called, the EAL threads are then
excluded. If setting the name of the thread fails, the error is
ignored and a debug message is logged."

What does that mean?
I.e., what is the affinity of that control thread?

A) Cpu 0-2, controlled by taskset, or
B) cpu 3-5, controlled by the EAL --lcores parameter?


Now, what if the application was run with:
taskset --cpu-list 0-5 dpdk-app --lcores 0-5

Since all cpus are now EAL threads, what happens with =
rte_thread_create_control() when "the EAL treads are then excluded", and =
there are no cpus left?


-Morten

