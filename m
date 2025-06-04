Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C57BC5B552
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 10:18:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E59AB427CA;
	Wed,  4 Jun 2025 12:18:07 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 169C1427C3
 for <dev@dpdk.org>; Wed,  4 Jun 2025 12:18:06 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B3FFE21ECB;
 Wed,  4 Jun 2025 12:18:05 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v4 19/25] net/intel: generalize vectorized Rx rearm
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 4 Jun 2025 12:18:04 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FCBE@smartserver.smartshare.dk>
In-Reply-To: <aEAWjK2WYvZbBs8h@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v4 19/25] net/intel: generalize vectorized Rx rearm
Thread-Index: AdvVNezIuVLVCEJyT8OGE3kH4WMjWgAABwjA
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <53edc2bd68e42152358d731d51860c8606ef13a6.1748612803.git.anatoly.burakov@intel.com>
 <aEASlf7t4G8s5coz@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FCBD@smartserver.smartshare.dk>
 <aEAWjK2WYvZbBs8h@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: "Anatoly Burakov" <anatoly.burakov@intel.com>,
	<dev@dpdk.org>
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
> Sent: Wednesday, 4 June 2025 11.49
>=20
> On Wed, Jun 04, 2025 at 11:43:01AM +0200, Morten Br=F8rup wrote:
> > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > Sent: Wednesday, 4 June 2025 11.32
> > >
> > > On Fri, May 30, 2025 at 02:57:15PM +0100, Anatoly Burakov wrote:

[...]

> > > > +#else
> > > > +	/* for 32-byte descriptors only support SSE */
> > > > +	switch (vec_level) {
> > > > +	case CI_RX_VEC_LEVEL_AVX512:
> >
> > If you are respinning this patch, add "/* fall through */" here.
> >
> I disagree, it's not needed and will only make the code less readable.
>=20
> > > > +	case CI_RX_VEC_LEVEL_AVX2:
> >
> > And here.
> >
> > > > +	case CI_RX_VEC_LEVEL_SSE:
> > > > +		_ci_rxq_rearm_sse(rxq);
> > > > +		break;
> > > > +	}
> > > > +#endif /* RTE_NET_INTEL_USE_16BYTE_DESC */
> > > <snip>
> >
> > Please try building with 32-byte descriptors; the compiler should
> have complained about the implicit fall through.
> >
> The fallthrough tags are not necessary where you have a list of tags
> without any statements in between. It's common practice to have a
> couple of
> values match a single switch arm, and the fallthrough is obvious in
> those
> cases, since there are no statements between them. Once you start
> having
> some code for a case, then you need it, since you need to make it =
clear
> that it's not accidental.

Thank you for clarifying, Bruce.
The GCC documentation [1] doesn't mention any exception for cases =
without statements, but Godbolt confirms it (not only for C11, but also =
for C23), so I agree with Bruce about omitting them for readability.

Sorry about the noise. ;-)

[1]: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html

