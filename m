Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFAFC3ABAA
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 15:33:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3227D4060A;
	Fri,  2 May 2025 17:33:35 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 7839C402F0
 for <dev@dpdk.org>; Fri,  2 May 2025 17:33:34 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 27D61209B2;
 Fri,  2 May 2025 17:33:34 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v1 1/1] app/testpmd: add sleep command
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 2 May 2025 17:33:31 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FC26@smartserver.smartshare.dk>
In-Reply-To: <aBTaK9NnqTiQTP8F@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v1 1/1] app/testpmd: add sleep command
Thread-Index: Adu7cMMRBqxi0ov3TOaDZIhi+uxyrgABWwqQ
References: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
 <aBS8e9GZkyXiCCJS@bricha3-mobl1.ger.corp.intel.com>
 <60e02461-362c-4edd-b917-36a524670c5d@intel.com>
 <aBTaK9NnqTiQTP8F@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
 "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: <dev@dpdk.org>,
	"Aman Singh" <aman.deep.singh@intel.com>
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
> Sent: Friday, 2 May 2025 16.44
>=20
> On Fri, May 02, 2025 at 04:35:08PM +0200, Burakov, Anatoly wrote:
> > On 5/2/2025 2:37 PM, Bruce Richardson wrote:
> > > On Fri, May 02, 2025 at 01:27:29PM +0100, Anatoly Burakov wrote:
> > > > Test-pmd already has a way to run a list of commands from file,
> but there
> > > > is no way to pause execution for a specified amount of time
> between two
> > > > commands. This may be necessary for simple automation,
> particularly for
> > > > waiting on some asynchronous operation such as link status
> update.
> > > >
> > > > Add a simple sleep command to wait until certain number of
> milliseconds has
> > > > passed.
> > > >
> > > > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > > > ---
> > > >   app/test-pmd/cmdline.c | 35 =
+++++++++++++++++++++++++++++++++++
> > > >   1 file changed, 35 insertions(+)
> > > >
> > > > diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
> > > > index d4bb3ec998..1e429e6d0a 100644
> > > > --- a/app/test-pmd/cmdline.c
> > > > +++ b/app/test-pmd/cmdline.c
> > > > @@ -151,6 +151,9 @@ static void cmd_help_long_parsed(void
> *parsed_result,
> > > >   			"quit\n"
> > > >   			"    Quit to prompt.\n\n"
> > > > +
> > > > +			"sleep ms\n"
> > > > +			"    Sleep for ms milliseconds.\n\n"
> > > >   		);
> > > >   	}
> > >
> > > A "sleep" command, I would expect to sleep for a certain number of
> seconds,
> > > for compatibility e.g. with terminal "sleep" command.
> > > To keep this as "ms" granularity, how about making it explicit as =
a
> > > "sleep_ms" command. Alternatively, how about adding a usleep
> command? [Not
> > > sure "msleep" works, which is why I suggested sleep_ms instead]
> > >
> > > /Bruce
> >
> > I have no strong opinions on what it should do. My initial version
> *was* a
> > "sleep in seconds" command, I just thought that maybe someone would
> want it
> > more flexible. I suspect that actually "sleep" and second =
granularity
> is
> > just fine.
> >
>=20
> I think we do need to support sub-second sleep granularity, though. If
> we
> only add "sleep" with time specified in seconds, I think we'd also =
need
> to
> add in usleep with micro-sec granularity too.
>=20
> Other alternatives:
> - have sleep take an option 3rd parameter of time in
>   minisecond. So "sleep 1" is to sleep for one second, but "sleep 0
> 500" is
>   to sleep for 1/2 sec, and "sleep 2 750" is to sleep for 2.75 =
seconds.
> - add floating point support to the cmdline library, and then allow
> sleep time
>   specified in seconds using that.
>=20
> /Bruce

"sleep" should take one parameter: seconds.

It can be float, or a separate "usleep" command taking a microseconds =
parameter can be added. This change (using float instead of int) or =
addition (usleep command) can be added later, if you like.

Initially, I would lean towards a float parameter, but maybe it's easier =
for scripts to use "usleep" with an integer.
In real life, the duration will probably be either "N" (i.e. a natural =
number) or "0.N" (i.e. less than one second), so an "usleep" might be =
just as good.

