Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4428ACAC5A7
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 10:17:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 713FD402E7;
	Thu, 25 Sep 2025 12:17:32 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 759B3402AB
 for <dev@dpdk.org>; Thu, 25 Sep 2025 12:17:30 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 595DC20007;
 Thu, 25 Sep 2025 12:17:29 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v3 6/7] buildtools/chkincs: use a staging directory for
 headers
Date: Thu, 25 Sep 2025 12:17:27 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6546A@smartserver.smartshare.dk>
In-Reply-To: <aNUL_Pl6Hf2bmcJJ@bricha3-mobl1.ger.corp.intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 6/7] buildtools/chkincs: use a staging directory for
 headers
Thread-Index: Adwt/zoNoNJjjxdZQ66s61feZp7FpgABRpiQ
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250924172536.2447183-1-david.marchand@redhat.com>
 <20250924172536.2447183-7-david.marchand@redhat.com>
 <aNT2gMD4BH44UB3i@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8z7pnVm51HmfNDTr7=xsALPcKN9fRh7rVGgKgM2sWY8mQ@mail.gmail.com>
 <aNUL_Pl6Hf2bmcJJ@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
 "David Marchand" <david.marchand@redhat.com>
Cc: <dev@dpdk.org>, "Thomas Monjalon" <thomas@monjalon.net>,
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Thursday, 25 September 2025 11.32
>=20
> On Thu, Sep 25, 2025 at 10:42:47AM +0200, David Marchand wrote:
> > Hello Bruce,
> >
> > On Thu, 25 Sept 2025 at 10:00, Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > >
> > > On Wed, Sep 24, 2025 at 07:25:34PM +0200, David Marchand wrote:
> > > > A problem with the current headers check is that it relies on
> > > > meson dependencies objects that come with their
> include_directories
> > > > directives, and all of those point at the library / driver
> sources.
> > > >
> > > > This means that we won't detect a public header including a
> private
> > > > (as in, not exported) header, or a driver only header.
> > > >
> > > > To address this issue, a staging directory is added and every
> header
> > > > is copied to it.
> > > >
> > > > Drivers and library headers are staged to two different
> directories
> > > > and the check is updated accordingly.
> > > >
> > > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > >
> > > In general looks ok to me.
> > > One small comment though - can we not have "staging" as a =
top-level
> > > directory, but instead hide it inside the buildtools directory, or
> even the
> > > chkincs directory? I dislike having too many subdirectories
> directly off
> > > the root of the project, especially ones purely for internal
> tooling.
> >
> > Well, at first I was trying to change the whole build process iow
> rely
> > only on the staging directory and remove all the =
include_directories:
> > directives from the declare_dependency() objects.
> > Libraries and apps were ok, but there were a *lot* of complications
> > with drivers (what a *huge mess*, especially for NXP drivers with
> > "compat.h" includes, and Marvell drivers to a smaller extent).
> > I may retry in the future with some AI tool that will brute force
> this :-).
> >
> > For now, I gave up but did not reconsider the location of the =
staging
> part.
> > Moving to buildtools is indeed saner as it is only for the check =
now,
> > and I can also make this staging stuff dependent on the
> check_includes
> > option now.
> >
>=20
> I wonder should we just consider making chkincs an install-time job
> rather
> than a build-time one? We could look to build chkincs using a custom
> install script (meson.add_install_script) after the header copies are
> already done for us. That should cut down on the complexity within the
> build system, but it does mean an additional install step to a
> temporary
> directory to get it to run. However, for use in our CI I don't see why
> having an install step with DEST_DIR set to /tmp shouldn't be =
feasible.

Such a temporary directory should be local to the developer's working =
directory.
(The CI might have different needs; that's not what I'm commenting.)

Furthermore, test building for upstreaming should remain simple. I use =
something like:
meson setup -Dplatform=3Dgeneric -Dcheck_includes=3Dtrue build
ninja -C build

Disclaimer: Haven't really followed this discussion, so maybe my =
comments above are irrelevant.

