Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E4AC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 08:00:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFE2340E49;
	Thu, 13 Mar 2025 09:00:11 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9FE3240DFD
 for <dev@dpdk.org>; Thu, 13 Mar 2025 09:00:10 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 6B5AF20FF3;
 Thu, 13 Mar 2025 09:00:10 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2 1/7] eal: add queue macro extensions from FreeBSD
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 13 Mar 2025 09:00:09 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FAF6@smartserver.smartshare.dk>
In-Reply-To: <20250312160225.2d90e78a@hermes.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 1/7] eal: add queue macro extensions from FreeBSD
Thread-Index: AduTotXyWBNXD2sVT7C6m9id4XRe6wASbrTg
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250214172134.73908-1-stephen@networkplumber.org>
 <20250214172134.73908-2-stephen@networkplumber.org>
 <12279496.nUPlyArG6x@thomas> <20250312160225.2d90e78a@hermes.local>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
 "Thomas Monjalon" <thomas@monjalon.net>
Cc: <dev@dpdk.org>,
	"Tyler Retzlaff" <roretzla@linux.microsoft.com>
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
> Sent: Thursday, 13 March 2025 00.02
>=20
> On Wed, 19 Feb 2025 15:55:17 +0100
> Thomas Monjalon <thomas@monjalon.net> wrote:
>=20
> > 14/02/2025 18:20, Stephen Hemminger:
> > > The Linux version of sys/queue.h is frozen at an older version
> > > and is missing the _SAFE macro variants. Several drivers started
> > > introducing the own workarounds for this. Should be handled in =
EAL.
> > >
> > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> >
> > We may want to unify with lib/eal/windows/include/sys/queue.h
> >
> >
>=20
> Not sure, we have several options here:
>   1. Keep using Linux sys/queue.h and add enhancements in rte_queue.h
>   2. Make rte_queue.h a copy of FreeBSD version of queue.h (that is
> what Windows did)
>   3. Use the bsd version of queue.h.
>      On Debian/Ubuntu this in libbsd-dev package and referred to as
> bsd/sys/queue.h
>=20
> I chose #1 as simplest. But all of these could work. #3 means DPDK has
> least new
> code, but adds another dependency to the build.

+1 to #2:
If Linux sys/queue.h is frozen, and is a subset of FreeBSD queue.h, #2 =
would consolidate all the queue macros in one file.
That seems easier to navigate (for a developer/reviewer looking at the =
macro definitions/implementations) than including sys/queue.h, queue.h =
or lib/eal/windows/include/sys/queue.h depending on O/S, and then =
defining the missing macros in rte_queue.h.
A comment at the top of the rte_queue.h file could mention that it is a =
copy of the FreeBSD queue.h file.

-1 to #3; it adds an unnecessary dependency.

>=20
> No matter what, should add to checkpatch to block any new files that
> include sys/queue.h
> directly.

+1 to this.

