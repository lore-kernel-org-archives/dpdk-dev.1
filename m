Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E90C35FFF
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 10:42:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EB3740B95;
	Fri, 21 Mar 2025 11:42:40 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9999440269;
 Fri, 21 Mar 2025 11:42:38 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 4AEC42209C;
 Fri, 21 Mar 2025 11:42:38 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: Clarification on Minimum Supported Kernel Version for DPDK
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 21 Mar 2025 11:42:36 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FB38@smartserver.smartshare.dk>
In-Reply-To: <Z90kpNrf8HjicUkI@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Clarification on Minimum Supported Kernel Version for DPDK
Thread-Index: AduaPDH5+IXM2vfFQuykqxkvZ3te2QADONHg
References: <CAMEVEZvCoVpMjFpmY29-x0zB2tQvNrJsTacs6-Zzx4jJB_GsoQ@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB37@smartserver.smartshare.dk>
 <Z90kpNrf8HjicUkI@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: "Cody Cheng" <ccheng@iol.unh.edu>, "Kevin Traynor" <ktraynor@redhat.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>, <techboard@dpdk.org>,
 "Tyler Retzlaff" <roretzla@linux.microsoft.com>,
 "Thomas Monjalon" <thomas@monjalon.net>,
 "David Marchand" <david.marchand@redhat.com>, <dev@dpdk.org>,
 "Ali Alnubani" <alialnu@nvidia.com>, <galco@nvidia.com>,
 <maxime.coquelin@redhat.com>
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
>=20
> On Fri, Mar 21, 2025 at 07:28:45AM +0100, Morten Br=F8rup wrote:
> > @Kevin, @Stephen, @Bruce,
> >
> > I cannot reliably answer Cody's question, and it may need further
> discussion.
> >
> > What is your opinion on minimum Linux kernel version requirements?
> >
> > @Thomas: In the future, the DPDK release notes should mention the
> minimum Linux kernel requirements.
> >
>=20
> Another question is - should we even have a minimum kernel version? =
Are
> we
> aware of any kernel features beyond vfio-pci driver which DPDK =
requires
> to
> run?
> As a userspace application, I think DPDK should just work with
> whatever distro-provided kernel is provided (assuming distro is
> relatively
> recent).

I agree regarding distros.

However, embedded systems may be stuck on ancient kernel versions for a =
variety of reasons.
Documenting the explicit requirements to the kernel are relevant for =
these.

I would expect all of the DPDK's EAL to behave as expected, so this =
should be the basis for defining DPDK's minimum kernel requirements - =
regarding both kernel version and optional kernel features required.
<noise>
In this context, "all of the EAL" really should mean the core of the =
EAL, exclusive the non-optional bloat that has nothing to do with =
abstracting the HW and O/S, and thus shouldn't be part of the EAL. But =
for now, I think we need to consider the EAL as-is, incl. any bloat.
</noise>

Some DPDK drivers may have additional kernel requirements.
Any such requirements should be documented with the individual drivers.
And, preferably, any driver should be able to degrade its capabilities =
gracefully when some optional requirements are not fulfilled.

In other words: We don't want DPDK's minimum kernel requirements to =
depend on some driver requiring some new and shiny kernel feature - the =
minimum kernel requirements should only depend on the EAL.

And - going back to the original question, triggering this discussion - =
we need to settle on a minimum kernel version for the CI testing at UNH.

