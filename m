Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C9DC369DC
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 May 2025 08:35:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7ED76402C5;
	Thu,  1 May 2025 10:35:26 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id EF1A14028E
 for <dev@dpdk.org>; Thu,  1 May 2025 10:35:24 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A70F7208EC;
 Thu,  1 May 2025 10:35:24 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: Thread priority for background tasks
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 1 May 2025 10:35:20 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FC1C@smartserver.smartshare.dk>
In-Reply-To: <aBMnKlCGNu6fp7hu@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Thread priority for background tasks
Thread-Index: Adu6bX9O+aidVbNRSI2UYQwefbMd1AAAMmJg
References: <98CBD80474FA8B44BF855DF32C47DC35E9FC19@smartserver.smartshare.dk>
 <20250430124526.6184f79f@hermes.local>
 <98CBD80474FA8B44BF855DF32C47DC35E9FC1A@smartserver.smartshare.dk>
 <aBMnKlCGNu6fp7hu@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>,
 "Harry van Haaren" <harry.van.haaren@intel.com>
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Thursday, 1 May 2025 09.48
>=20
> On Thu, May 01, 2025 at 09:05:32AM +0200, Morten Br=F8rup wrote:
> > > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > > Sent: Wednesday, 30 April 2025 21.45
> > >
> > > On Wed, 30 Apr 2025 20:40:52 +0200
> > > Morten Br=F8rup <mb@smartsharesystems.com> wrote:
> > >
> > > > There are only two thread priorities in the enum
> rte_thread_priority:
> > > Normal and Real-time Critical.
> > > >
> > > > I would like to poll ethdev counters, collect garbage and =
perform
> > > other jitter non-sensitive tasks in a control thread with lower
> > > priority than my ordinary control threads, so it will be preempted
> by
> > > any work ready for my ordinary control threads.
> > > >
> > > > Which DPDK API am I supposed to use to assign this below-normal
> > > priority to my "background" control thread?
> > > >
> > > > Or: Aren't we missing a priority like Linux' SCHED_BATCH?
> > >
> > > Short answer: if your application is running on Linux, only ever
> use
> > > Normal.
> > > DPDK applications usually never sleep and this will starve the OS
> and
> > > cause instability.
> >
> > I was asking for the opposite of Critical priority.
> >
> > For the sake of discussion, imagine a (registered or unregistered)
> non-EAL thread doing something like this:
> > loop {
> > 	poll_counters(); // 1 ms execution time
> > 	sleep(99 ms);
> > }
> >
> > With normal scheduling priority, it will rack up a lot of scheduling
> credits during sleep(), so it might not be preempted by other threads
> while executing poll_counters().
> >
> > But if some other thread (on the same CPU core) changes state from
> Sleeping to Runnable, I want it to preempt the counter polling thread.
> > This other thread could be a control plane application, e.g. a DNS
> Server, which shouldn't suffer up to 1 ms scheduling lag if it becomes
> Runnable the instant the counter polling thread started executing
> poll_counters().
> >
> > So I'm looking for a DPDK API to apply a "low priority" scheduling
> policy, like SCHED_BATCH, to the counter polling thread.
> >
>=20
> Does this need to be done in DPDK?

No, not really.

> Unless you need to target Windows, would
> using the standard Unix/Posix scheduling/pthread APIs directly not be
> best,
> rather than having us try to wrap all such things inside DPDK APIs?

It probably would. That's how we do it today, anyway. :-)

> I worry
> about scope creep for such things, with us ending up wrapping a whole
> bunch
> of scheduling stuff into DPDK that we should not need to do.

I'm mainly asking for academic reasons.

I think the scope of my question was included into DPDK when it =
introduced the rte_thread_priority with RTE_THREAD_PRIORITY_NORMAL and =
RTE_THREAD_PRIORITY_REALTIME_CRITICAL.

I know this is mainly related to the control plane, and thus not the =
most relevant thing for DPDK.
But I think we need to offer something. Not only for applications, but =
drivers might want to run separate low-priority threads for background =
tasks, such as garbage collection, counter polling, or a link state =
machine.

IMHO, the kernel scheduler is a much better choice than DPDK's =
non-preemptive "Service Cores" scheduler for many purposes.

