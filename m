Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A9AD3EE67
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 13:40:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 212254027A;
	Thu, 22 Jan 2026 14:40:50 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id E88594021F
 for <dev@dpdk.org>; Thu, 22 Jan 2026 14:40:48 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 1082E20AD6;
 Thu, 22 Jan 2026 14:40:48 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH 3/3] drivers: always enable the null net driver [RFC]
Date: Thu, 22 Jan 2026 14:40:45 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6568F@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <aXImy8tDAqFygz_T@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 3/3] drivers: always enable the null net driver [RFC]
Thread-Index: AdyLo4HieH0fciLFQwa03FQCm65smgAAFCXA
References: <20260122122354.1820368-1-bruce.richardson@intel.com>
 <20260122122354.1820368-4-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6568E@smartserver.smartshare.dk>
 <aXImy8tDAqFygz_T@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>,
	<stephen@networkplumber.org>
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
> Sent: Thursday, 22 January 2026 14.32
>=20
> On Thu, Jan 22, 2026 at 02:13:06PM +0100, Morten Br=F8rup wrote:
> > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > Sent: Thursday, 22 January 2026 13.24
> > >
> > > Having the net_null driver always available can be convenient and
> > > allows
> > > use by unit tests, so add this trivial driver to the always-enable
> > > list.
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > >
> > > ---
> > > I'm not sure if we want this to be always enabled or not, so
> sending
> > > this as an RFC. I can see definite advantages to doing so, but I
> also
> > > dislike having too many components on the always-enable list.
> > >
> > > Since I'm ambivilent myself, including this patch so the community
> can
> > > decide.
> >
> > I don't think real applications use this.
> > If they do, they can include it manually.
> >
> > My main objection is:
> > We are setting the wrong precedence if we make stuff like this
> mandatory for convenience.
> >
> > But I agree with the reason you are suggesting it.
> >
> > Is there some other way it can be enabled for unit tests?
> > Maybe the null driver can depend on the unit tests being built?
> >
> > I don't mind that the driver is being built.
> > I just don't want it included by default when statically linking a
> monolithic application.
> >
> > I'm flexible on this RFC, so it's a very soft NAK from me.
> > If it can be disabled at build time, I'm OK with it. (But still
> concerned about setting the wrong precedence.)
> >
> Yes, I agree.
>=20
> Why I'm proposing this is because, in order to give me faster rebuilds
> and
> because of the hardware I have available to me, I generally set up my
> builds with "-Denable_drivers=3Dnet/intel/*", since that really speeds =
up
> my
> dev-build-test cycle. In doing so, though, I do miss out on having =
some
> unit tests available when I run the fast-test suite, which is why I
> suggested this addition in case there are others who limit the builds
> to
> just the hardware they are using.

You can build with "-Denable_drivers=3Dnet/intel/*,net/null".

Then I'll suggest an alternative to this patch:
Change the fast-test application, so it emits an informational message =
about which tests are being skipped because the net/null driver is =
missing.

