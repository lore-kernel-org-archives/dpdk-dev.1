Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC06E9B368
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 11:08:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 231C9402B0;
	Mon,  2 Mar 2026 12:08:19 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id F1D024028C
 for <dev@dpdk.org>; Mon,  2 Mar 2026 12:08:17 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C21AC20525;
 Mon,  2 Mar 2026 12:08:17 +0100 (CET)
Subject: RE: [RFC v2 5/5] eal: configure initial device probing
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 2 Mar 2026 12:08:16 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6575B@smartserver.smartshare.dk>
Content-class: urn:content-classes:message
In-Reply-To: <aaVSHYANsEFRx-oQ@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC v2 5/5] eal: configure initial device probing
Thread-Index: AdyqI4UGHs3CyTsSSLe//K2Gi2BlhAAD62iQ
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260226162057.207202-6-david.marchand@redhat.com>
 <DGP1R1WJWJGI.1TU6RUU13GBYQ@redhat.com> <4506449.8Dcp7MaWsk@thomas>
 <aaGhdEEgxiA4Z33A@bricha3-mobl1.ger.corp.intel.com>
 <20260227141045.236af55b@phoenix.local>
 <aaVSHYANsEFRx-oQ@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
 "David Marchand" <david.marchand@redhat.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
Cc: "Thomas Monjalon" <thomas@monjalon.net>, "Robin Jarry" <rjarry@redhat.com>,
 <dev@dpdk.org>, "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Stephen Hemminger" <stephen@networkplumber.org>
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
> Sent: Monday, 2 March 2026 10.02
>=20
> On Fri, Feb 27, 2026 at 02:10:45PM -0800, Stephen Hemminger wrote:
> > On Fri, 27 Feb 2026 13:51:48 +0000=09
> > Bruce Richardson <bruce.richardson@intel.com> wrote:
> >
> > > On Fri, Feb 27, 2026 at 02:43:46PM +0100, Thomas Monjalon wrote:
> > > > 26/02/2026 17:50, Robin Jarry:
> > > > > David Marchand, Feb 26, 2026 at 17:20:
> > > > > > Some applications use port hotplug as their primary way for
> using DPDK
> > > > > > resources.
> > > > > > Having a systematic device probing is a problem when not all
> available
> > > > > > resources will be used by the application, as such
> applications won't set
> > > > > > an explicit allow list at startup.
> > > > > >
> > > > > > This is the case for OVS on systems with multiple mlx5
> devices:
> > > > > > one device can be used by the kernel while the other(s) are
> used by DPDK.
> > > > > > In such a setup, the kernel used device may get reconfigured
> in
> > > > > > unexpected ways and trigger issues like the one described by
> Kevin
> > > > > > not so long ago in bugzilla 1873.
> > > > > >
> > > > > > Add an EAL option so that we can change the default behavior
> from
> > > > > > block-listing to allow-listing.
> > > > [...]
> > > > > > +	const char * const argv29[] =3D {prgname, prefix, mp_flag,
> eal_debug_logs,
> > > > > > +				       "--allow-explicitly" };
> > > > >
> > > > > I am not convinced by the option name. What do you think of:
> > > > >
> > > > > 	--no-autoprobe
> > > > >
> > > > > That would match the Linux sriov_drivers_autoprobe sysfs.
> > > >
> > > > The name --no-autoprobe is better indeed.
> > > >
> > > > The exact effect of this option is to disable initial probing
> > > > of devices on all buses (except vdev).
> > > > Another name could be --no-initial-probing
> > > >
> > > > I think we should add the opposite option as well
> > > > to allow changing the default mode later.
> > > > For such an option, --autoprobe looks better than --initial-
> probing.
> > > >
> > > > Other opinions?
> > > >
> > > >
> > > > [...]
> > > > > Depending on what option name we settle on, could you add a
> short flag
> > > > > too? E.g.:
> > > > >
> > > > > BOOL_ARG("--no-autoprobe", "-N", "Disable automatic probing of
> non-blocked devices", no_autoprobe)
> > > > >
> > > > > Or:
> > > > >
> > > > > BOOL_ARG("--no-autoprobe", "-P", "Disable automatic probing of
> non-blocked devices", no_autoprobe)
> > > >
> > > > I don't see the benefit of a short flag.
> > > > It makes reading commands less obvious.
> > > >
> > > I actually would prefer to have a short option available, and I'd
> really
> > > like that short option to be "-A" since it serves as the perfect
> addition
> > > to the "-a" flag to specify devices to probe.
> > >
> > > Based on that, I would look for long options which allow "-A" as
> the short
> > > version for example:
> > >
> > > --allowlisted-devs-only
> > >
> > > /Bruce
> >
> > Also if -b or --block-list become a no op with --no-autoprobe. So it
> should be a warning?
>=20
> Yes, I think a warning about ignored parameter would be appropriate.
>=20
> /Bruce

I haven't been following this discussion, so I might me completely off =
here.

IIUC, this option is used for specifying which devices to probe.
(And as a side effect disables auto-probing of all devices.)

When naming it, please take a fresh view.
Imagine you are defining this option and an auto-probe option.

The discussion assumes the user is familiar with auto-probe, and expects =
auto-probe. Don't design based on that.

-Morten

