Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B15C369D9
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 May 2025 06:09:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 077D140261;
	Sat,  3 May 2025 08:09:25 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 7A90D4025D
 for <dev@dpdk.org>; Sat,  3 May 2025 08:09:23 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 0C2D6208EC;
 Sat,  3 May 2025 08:09:23 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v3 1/4] eal: deprecate old coremask-based EAL parameters
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sat, 3 May 2025 08:09:20 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FC27@smartserver.smartshare.dk>
In-Reply-To: <aBTsKvlL_Uw-G2wH@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 1/4] eal: deprecate old coremask-based EAL parameters
Thread-Index: Adu7e2SB7QAK5ek6SqmagczHi0lrGgAdM+YQ
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250502151134.536799-1-bruce.richardson@intel.com>
 <20250502151134.536799-2-bruce.richardson@intel.com>
 <20250502085122.2e9db643@hermes.local>
 <aBTsKvlL_Uw-G2wH@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>,
	<david.marchand@redhat.com>
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
> Sent: Friday, 2 May 2025 18.01
>=20
> On Fri, May 02, 2025 at 08:51:22AM -0700, Stephen Hemminger wrote:
> > On Fri,  2 May 2025 16:11:31 +0100
> > Bruce Richardson <bruce.richardson@intel.com> wrote:
> >
> > > As the number of cores/cpus on platforms has increased over the
> years,
> > > the use of coremasks rather than core-lists for identifying DPDK
> cores
> > > has become more and more unwieldy. At this point, let's deprecate
> the
> > > coremask-based EAL parameters for future removal, and point users
> to the
> > > core-list based versions instead.
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> >
> > Agree.
> >
> > There are some more syntax options on Linux kernel command line:
> > https://github.com/torvalds/linux/blob/master/Documentation/admin-
> guide/kernel-parameters.rst#cpu-lists
> >
> > cpu lists
> > Some kernel parameters take a list of CPUs as a value, e.g. =
isolcpus,
> nohz_full, irqaffinity, rcu_nocbs. The format of this list is:
> >
> > <cpu number>,...,<cpu number>
> > or
> >
> > <cpu number>-<cpu number> (must be a positive range in ascending
> order)
> > or a mixture
> >
> > <cpu number>,...,<cpu number>-<cpu number>
> >
>=20
> This we already support.
>=20
> > Note that for the special case of a range one can split the range
> into equal sized groups and for each group use some amount from the
> beginning of that group:
> >
> > <cpu number>-<cpu number>:<used size>/<group size>
> > For example one can add to the command line following parameter:
> >
> > isolcpus=3D1,2,10-20,100-2000:2/25
> > where the final item represents CPUs 100,101,125,126,150,151,...
> >
> > The value "N" can be used to represent the numerically last CPU on
> the system, i.e "foo_cpus=3D16-N" would be equivalent to "16-31" on a =
32
> core system.
> >
> > Keep in mind that "N" is dynamic, so if system changes cause the
> bitmap width to change, such as less cores in the CPU list, then N and
> any ranges using N will also change. Use the same on a small 4 core
> system, and "16-N" becomes "16-3" and now the same boot input will be
> flagged as invalid (start > end).
> >
> > The special case-tolerant group name "all" has a meaning of =
selecting
> all CPUs, so that "nohz_full=3Dall" is the equivalent of =
"nohz_full=3D0-N".
> >
> > The semantics of "N" and "all" is supported on a level of bitmaps =
and
> holds for all users of bitmap_parselist().
> >
>=20
> Those would be good/interesting extensions to have, if someone wants =
to
> add
> them to EAL. Hopefully after this patchset, adding them should be
> easier as
> I think we should only have one place in EAL where we parse groups =
like
> that:
> "eal_parse_set()" function.

Yes, such a syntax parser can be added later.

In the Kernel, it's a generic parser for fixed length bit arrays.
I could imagine using it for other purposes than CPUs, e.g. VLANs or =
ports.

The "N" feature is *must have* in the Kernel, where it's used for Kernel =
boot parameters, set before any script to determine the number of CPUs =
on the system can be run.
That's not the case with EAL parameters, where "N" and "all" only would =
be *nice to have*.

