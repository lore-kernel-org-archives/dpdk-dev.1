Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96855C83F26
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Jul 2025 14:44:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 828DC40285;
	Thu, 24 Jul 2025 16:44:50 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 8663840262
 for <dev@dpdk.org>; Thu, 24 Jul 2025 16:44:49 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 5FDB120446;
 Thu, 24 Jul 2025 16:44:48 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v4] eal: fix uncheck lcore ID and lcore role
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 24 Jul 2025 16:44:47 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FDC0@smartserver.smartshare.dk>
In-Reply-To: <20250724112551.2502389-1-huangdengdui@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v4] eal: fix uncheck lcore ID and lcore role
Thread-Index: Adv8jbmcko9mRsmkQzOfFYnUgOEX0AAGeI7Q
References: <20250321040316.104126-1-huangdengdui@huawei.com>
 <20250724112551.2502389-1-huangdengdui@huawei.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Dengdui Huang" <huangdengdui@huawei.com>,
	<dev@dpdk.org>
Cc: <stephen@networkplumber.org>, <david.marchand@redhat.com>,
 <roretzla@linux.microsoft.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
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

> From: Dengdui Huang [mailto:huangdengdui@huawei.com]
> Sent: Thursday, 24 July 2025 13.26
>=20
> The worker_id may come from user input. So it is necessary to verify =
it.
>=20
> In addition, only the lcore whose role is ROLE_RTE or ROLE_SERVICE can
> be
> launched. This patch adds the lcore role check.
>=20
> Fixes: a95d70547c57 ("eal: factorize lcore main loop")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> ---
>  lib/eal/common/eal_common_launch.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/lib/eal/common/eal_common_launch.c
> b/lib/eal/common/eal_common_launch.c
> index a7deac6ecd..09366ea404 100644
> --- a/lib/eal/common/eal_common_launch.c
> +++ b/lib/eal/common/eal_common_launch.c
> @@ -20,6 +20,9 @@ RTE_EXPORT_SYMBOL(rte_eal_wait_lcore)
>  int
>  rte_eal_wait_lcore(unsigned worker_id)
>  {
> +	if (unlikely(worker_id >=3D RTE_MAX_LCORE))
> +		return -EINVAL;
> +
>  	while (rte_atomic_load_explicit(&lcore_config[worker_id].state,
>  			rte_memory_order_acquire) !=3D WAIT)
>  		rte_pause();
> @@ -37,6 +40,18 @@ int
>  rte_eal_remote_launch(lcore_function_t *f, void *arg, unsigned int
> worker_id)
>  {
>  	int rc =3D -EBUSY;
> +	uint8_t role;

Use the correct type:
enum rte_lcore_role_t role;

> +
> +	if (unlikely(worker_id >=3D RTE_MAX_LCORE)) {
> +		rc =3D -EINVAL;
> +		goto finish;
> +	}
> +
> +	role =3D lcore_config[worker_id].core_role;
> +	if (role !=3D ROLE_RTE && role !=3D ROLE_SERVICE) {
> +		rc =3D -EINVAL;
> +		goto finish;
> +	}
>=20
>  	/* Check if the worker is in 'WAIT' state. Use acquire order
>  	 * since 'state' variable is used as the guard variable.
> @@ -98,6 +113,9 @@ RTE_EXPORT_SYMBOL(rte_eal_get_lcore_state)
>  enum rte_lcore_state_t
>  rte_eal_get_lcore_state(unsigned lcore_id)
>  {
> +	if (unlikely(lcore_id >=3D RTE_MAX_LCORE))
> +		return -EINVAL;

The return type of this function is enum rte_lcore_state_t, so it cannot =
return (int)-EINVAL.

Maybe it's better to update the function's documentation instead of its =
implementation.
Like the documentation of the lcore_id parameter passed to =
rte_eal_lcore_role():
https://elixir.bootlin.com/dpdk/v25.07/source/lib/eal/include/rte_lcore.h=
#L44

After further consideration, updating the documentation might also be a =
better solution for the other functions.

If you add a new return value (-EINVAL) to a function, it must be listed =
in function's documentation, and in the documentation of functions =
calling that function.

> +
>  	return lcore_config[lcore_id].state;
>  }
>=20
> --
> 2.33.0

