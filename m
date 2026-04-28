Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C015CFF8868
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Apr 2026 11:54:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2F9D40395;
	Tue, 28 Apr 2026 13:54:58 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 35C9D402A3
 for <dev@dpdk.org>; Tue, 28 Apr 2026 13:54:57 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E07ED20778;
 Tue, 28 Apr 2026 13:54:56 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v4 1/2] ring: make soring to always finalize its own stage
Date: Tue, 28 Apr 2026 13:54:54 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65827@smartserver.smartshare.dk>
In-Reply-To: <20260423091625.123642-2-konstantin.ananyev@huawei.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v4 1/2] ring: make soring to always finalize its own stage
Thread-Index: AdzTAfMVKeREnAHdRQyie70cWSqU5wEAzGsw
References: <20260417212358.212692-1-konstantin.ananyev@huawei.com>
 <20260423091625.123642-1-konstantin.ananyev@huawei.com>
 <20260423091625.123642-2-konstantin.ananyev@huawei.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
	<dev@dpdk.org>
Cc: <wathsala.vithanage@arm.com>
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

> From: Konstantin Ananyev [mailto:konstantin.ananyev@huawei.com]
> Sent: Thursday, 23 April 2026 11.16
>=20
> SORING internal finalize() function is MT-safe and can be called from
> multiple places: from it's own stage release(), also from 'acquire()'
> for next stage or even from consumer's 'dequeue().
> But calling finalize() from not its own stage release() function
> creates extra contention and might slow-down ring operations,
> especially
> for the cases when we have multiple threads doing acquire/release
> for the same stage.
> We can't compeletely avoid calling finalize() from all these multiple
> places, as it can in some rare cases break soring behavior.
> But we can make release() for given stage to invoke it always.
> That increases number of 'finalize()' operations done from 'release()'
> for current stage, and helps to minimize number of finalize() calls
> from
> other stages, which in turn, help to reduce the contention.
> According to the soring_stress_autotest, for multiple workers (8+)
> it reduces number of cycles spent by 1.5x-1.8x factor.
> For l3fwd-like workload it improves things by ~20%.
> For small number of workers, I didn't observe any serious change.
> Note that it doesn't introduce any changes in functionality provided.
>=20
> Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Good idea.
Not peeking into the tail to determine if finalize() might be omitted =
also makes release() cleaner.

Removing an optimization that was not really an optimization. :-)

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>


> ---
>  lib/ring/soring.c | 33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
>=20
> diff --git a/lib/ring/soring.c b/lib/ring/soring.c
> index 3b90521bdb..4bc2321fb5 100644
> --- a/lib/ring/soring.c
> +++ b/lib/ring/soring.c
> @@ -37,24 +37,24 @@
>   * plus current stage index).
>   * 'release()' extracts old head value from provided ftoken and =
checks
> that
>   * corresponding 'state[]' contains expected values(mostly for sanity
> - * purposes).
> - * Then it marks this state[] with 'SORING_ST_FINISH' flag to =
indicate
> - * that given subset of objects was released.
> - * After that, it checks does old head value equals to current tail
> value?
> - * If yes, then it performs  'finalize()' operation, otherwise
> 'release()'
> - * just returns (without spinning on stage tail value).
> - * As updated state[] is shared by all threads, some other thread can
> do
> - * 'finalize()' for given stage.
> - * That allows 'release()' to avoid excessive waits on the tail =
value.
> + * purposes). Then it marks this state[] with 'SORING_ST_FINISH' flag
> to
> + * indicate that given subset of objects was released.
> + * After that, it calls 'finalize()'.
>   * Main purpose of 'finalize()' operation is to walk through =
'state[]'
>   * from current stage tail up to its head, check state[] and move
> stage tail
>   * through elements that already are in SORING_ST_FINISH state.
>   * Along with that, corresponding state[] values are reset to zero.
> - * Note that 'finalize()' for given stage can be done from multiple
> places:
> + * Note that updated state[] is shared by all threads, so
> + * 'finalize()' for given stage can be done from multiple places:
>   * 'release()' for that stage or from 'acquire()' for next stage
>   * even from consumer's 'dequeue()' - in case given stage is the last
> one.
>   * So 'finalize()' has to be MT-safe and inside it we have to
> - * guarantee that only one thread will update state[] and stage's =
tail
> values.
> + * guarantee that only one thread at a time will update state[] and
> + * stage's tail values (sort of critical-section).
> + * When multiple threads trying to do finalize() for the same stage,
> + * simultaneously one thread will win the race and do all the pending
> + * updates, while others will simply return (kind of try-lock
> scenario).
> + * That allows 'release()' to avoid excessive waits on the tail =
value.
>   */
>=20
>  #include "soring.h"
> @@ -442,7 +442,7 @@ static __rte_always_inline void
>  soring_release(struct rte_soring *r, const void *objs,
>  	const void *meta, uint32_t stage, uint32_t n, uint32_t ftoken)
>  {
> -	uint32_t idx, pos, tail;
> +	uint32_t idx, pos;
>  	struct soring_stage *stg;
>  	union soring_state st;
>=20
> @@ -479,12 +479,9 @@ soring_release(struct rte_soring *r, const void
> *objs,
>  	rte_atomic_store_explicit(&r->state[idx].raw, st.raw,
>  			rte_memory_order_relaxed);
>=20
> -	/* try to do finalize(), if appropriate */
> -	tail =3D rte_atomic_load_explicit(&stg->sht.tail.pos,
> -			rte_memory_order_relaxed);
> -	if (tail =3D=3D pos)
> -		__rte_soring_stage_finalize(&stg->sht, stage, r->state, r-
> >mask,
> -				r->capacity);
> +	/* now, try to do finalize() */
> +	__rte_soring_stage_finalize(&stg->sht, stage, r->state, r->mask,
> +			r->capacity);
>  }
>=20
>  /*
> --
> 2.51.0

