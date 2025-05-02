Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB846C3ABA3
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 08:57:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95E9A402A0;
	Fri,  2 May 2025 10:57:03 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 027AC4029E;
 Fri,  2 May 2025 10:57:02 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id CBB7721B59;
 Fri,  2 May 2025 10:57:01 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: rte_control event API?
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 2 May 2025 10:56:58 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FC23@smartserver.smartshare.dk>
In-Reply-To: <20250501080630.440a78ba@hermes.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: rte_control event API?
Thread-Index: Adu6qqMbeFPPUl0lQJGTFCxF/SjFqgAiWTHg
References: <20250501080630.440a78ba@hermes.local>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<techboard@dpdk.org>
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

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Thursday, 1 May 2025 17.07
>=20
> There was recent discussions about drivers creating control threads.
> The current drivers that use rte_thread_create_internal_control keeps
> growing,
> but it got me looking at if this could be done better.
>=20
> Rather than having multiple control threads which have potential
> conflicts, why not
> add a new API that has one control thread and uses epoll. The current
> multi-process
> control thread could use epoll as well. Epoll scales much better and
> avoids
> any possibility of lock scheduling/priority problems.
>=20
> Some ideas:
>    - single control thread started (where the current MP thread is
> started)
>    - have control_register_fd and control_unregister_fd
>    - leave rte_control_thread API for legacy uses
>=20
> Model this after well used libevent library https://libevent.org
>=20
> Open questions:
>    - names are hard, using event as name leads to possible confusion
> with eventdev
>    - do we need to support:
>         - multiple control threads doing epoll?
>         - priorities
>         - timers?
>         - signals?
>         - manual activation?
>         - one off events?
>    - could alarm thread just be a control event
>=20
>    - should also have stats and info calls
>=20
>    - it would be good to NOT support as many features as libevent,
> since
>      so many options leads to bugs.

I think we need both:

1. Multi threading.
Multiple control threads are required for preemptive scheduling between =
latency sensitive tasks and long-running tasks (that violate the latency =
requirements of the former).
For improved support of multi threading between driver control threads =
and other threads (DPDK control threads and other, non-DPDK, processes =
on the same host), we should expand the current control thread APIs, =
e.g. by expanding the DPDK threads API with more than the current two =
priorities ("Normal" and "Real-Time Critical").
E.g. if polling ethdev counters takes 1 ms, I don't want to add 1 ms =
jitter to my other control plane tasks, because they all have to share =
one control thread only.
I want the O/S scheduler to handle that for me. And yes, it means that I =
need to consider locking, critical sections, and all those potential =
problems coming with multithreading.

2. Event passing.
Some threads rely on using epoll as dispatcher, some threads use =
different designs.
Dataplane threads normally use polling (or eventdev, or Service Cores, =
or ...), i.e. non-preemptive scheduling of tiny processing tasks, but =
may switch to epoll for power saving during low traffic.
In low traffic periods, drivers may raise an RX interrupt to wake up a =
sleeping application to start polling. DPDK currently uses an epoll =
based design for passing this "wakeup" event (and other events, e.g. =
"link status change").

(Disclaimer: Decades have passed since I wrote Windows applications, =
using the Win32 API, so the following might be complete nonsense...)
If the "epoll" design pattern is not popular on Windows, we should not =
force it upon Windows developers. We should instead offer something =
compatible with the Windows "message pump" standard design pattern.
I think it would better to adapt some DPDK APIs to the host O/S than =
forcing the APIs of one O/S onto another O/S, if it doesn't fit.

Here's an idea related to "epoll": We could expose DPDK's internal file =
descriptors for the application developer to use her own preferred epoll =
library, e.g. libevent. Rather this than requiring using some crippled =
DPDK epoll library.

At high level...
The application developer should be free to use any design pattern =
preferred. We should not require using epoll as the application's main =
dispatcher, and thereby prevent application developers from using other =
design patterns.
Remember: DPDK is only a library (with a lot of features). It is not a =
complete framework requiring a specific application design. Let's keep =
it that way.

PS: I strongly prefer "epoll" events over "signals" for passing events =
to the application. Thanks to whoever made that decision. ;-)

