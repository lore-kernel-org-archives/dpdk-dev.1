Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD74BC5B552
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 09:43:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B3964042E;
	Wed,  4 Jun 2025 11:43:03 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 007D34029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 11:43:01 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B848F21ECB;
 Wed,  4 Jun 2025 11:43:01 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v4 19/25] net/intel: generalize vectorized Rx rearm
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 4 Jun 2025 11:43:01 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FCBD@smartserver.smartshare.dk>
In-Reply-To: <aEASlf7t4G8s5coz@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v4 19/25] net/intel: generalize vectorized Rx rearm
Thread-Index: AdvVM6IxcvZkkMNeQr+AFQufFJbIPQAALtDg
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <53edc2bd68e42152358d731d51860c8606ef13a6.1748612803.git.anatoly.burakov@intel.com>
 <aEASlf7t4G8s5coz@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
 "Anatoly Burakov" <anatoly.burakov@intel.com>
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Wednesday, 4 June 2025 11.32
>=20
> On Fri, May 30, 2025 at 02:57:15PM +0100, Anatoly Burakov wrote:
> > There is certain amount of duplication between various drivers when
> it
> > comes to Rx ring rearm. This patch takes implementation from ice
> driver
> > as a base because it has support for no IOVA in mbuf as well as all
> > vector implementations, and moves them to a common file.
> >
> > While we're at it, also make sure to use common definitions for
> things like
> > burst size, rearm threshold, and descriptors per loop, which is
> currently
> > defined separately in each driver.
> >
> > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > ---
> >
>=20
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>=20
> One minor comment inline below.
>=20

[...]

> > +
> > +static __rte_always_inline void
> > +ci_rxq_rearm(struct ci_rx_queue *rxq, const enum ci_rx_vec_level
> vec_level)
>=20
> I think a comment on this function would be good to point out that
> since
> it's inlined from the header and the final parameter is a compile-time
> constant, the compiler eliminates all the branches in the switch
> statement
> below.
>=20
> > +{
> > +	const uint16_t rearm_thresh =3D CI_VPMD_RX_REARM_THRESH;
> > +	uint16_t rx_id;
> > +
> > +	/* Pull 'n' more MBUFs into the software ring */
> > +	if (_ci_rxq_rearm_get_bufs(rxq) < 0)
> > +		return;
> > +
> > +#ifdef RTE_NET_INTEL_USE_16BYTE_DESC
> > +	switch (vec_level) {
> > +	case CI_RX_VEC_LEVEL_AVX512:
> > +#ifdef __AVX512VL__
> > +		_ci_rxq_rearm_avx512(rxq);
> > +		break;
> > +#else
> > +		/* fall back to AVX2 */
> > +		/* fall through */
> > +#endif
> > +	case CI_RX_VEC_LEVEL_AVX2:
> > +#ifdef __AVX2__
> > +		_ci_rxq_rearm_avx2(rxq);
> > +		break;
> > +#else
> > +		/* fall back to SSE */
> > +		/* fall through */
> > +#endif
> > +	case CI_RX_VEC_LEVEL_SSE:
> > +		_ci_rxq_rearm_sse(rxq, desc_len);
> > +		break;
> > +	}
> > +#else
> > +	/* for 32-byte descriptors only support SSE */
> > +	switch (vec_level) {
> > +	case CI_RX_VEC_LEVEL_AVX512:

If you are respinning this patch, add "/* fall through */" here.

> > +	case CI_RX_VEC_LEVEL_AVX2:

And here.

> > +	case CI_RX_VEC_LEVEL_SSE:
> > +		_ci_rxq_rearm_sse(rxq);
> > +		break;
> > +	}
> > +#endif /* RTE_NET_INTEL_USE_16BYTE_DESC */
> <snip>

Please try building with 32-byte descriptors; the compiler should have =
complained about the implicit fall through.

