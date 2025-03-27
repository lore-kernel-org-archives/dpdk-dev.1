Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B4DC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 09:32:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 624464066C;
	Thu, 27 Mar 2025 10:32:03 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 20E5040275
 for <dev@dpdk.org>; Thu, 27 Mar 2025 10:32:02 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E22C121733;
 Thu, 27 Mar 2025 10:32:01 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2 1/2] eal: fix uncheck worker ID
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 27 Mar 2025 10:32:02 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FB7A@smartserver.smartshare.dk>
In-Reply-To: <20250327090116.3357137-2-huangdengdui@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 1/2] eal: fix uncheck worker ID
Thread-Index: Adue9tBED5ua1VQcRgyiH1ywJzeU5wAAS67g
References: <20250321040316.104126-1-huangdengdui@huawei.com>
 <20250327090116.3357137-1-huangdengdui@huawei.com>
 <20250327090116.3357137-2-huangdengdui@huawei.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Dengdui Huang" <huangdengdui@huawei.com>,
	<dev@dpdk.org>
Cc: <honest.jiang@foxmail.com>, <fengchengwen@huawei.com>,
 <roretzla@linux.microsoft.com>, <lihuisong@huawei.com>,
 <haijie1@huawei.com>, <liuyonglong@huawei.com>,
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

> From: Dengdui Huang [mailto:huangdengdui@huawei.com]
> Sent: Thursday, 27 March 2025 10.01
>=20
> The worker_id may come from user input.
> So it is necessary to verify it.
>=20
> Fixes: a95d70547c57 ("eal: factorize lcore main loop")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> ---
>  lib/eal/common/eal_common_launch.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/lib/eal/common/eal_common_launch.c
> b/lib/eal/common/eal_common_launch.c
> index 5320c3bd3c..76313d5cdf 100644
> --- a/lib/eal/common/eal_common_launch.c
> +++ b/lib/eal/common/eal_common_launch.c
> @@ -35,6 +35,9 @@ rte_eal_remote_launch(lcore_function_t *f, void =
*arg,
> unsigned int worker_id)
>  {
>  	int rc =3D -EBUSY;
>=20

Also check the lcore_id:
+	if (unlikely(lcore_id >=3D RTE_MAX_LCORE))
+		return -EINVAL;
+

> +	if (!rte_lcore_has_role(worker_id, ROLE_RTE))
> +		return -EINVAL;
> +

Although rte_lcore_has_role() checks the lcore_id and returns -EINVAL if =
invalid, "if (!-EINVAL))" will not take the branch to return -EINVAL =
here. So this check alone does not suffice. You could change it to "if =
(rte_lcore_has_role(worker_id, ROLE_RTE) <=3D 0) return -EINVAL;".
However, I prefer the separate lcore_id check, as mentioned above, =
rather than changing this check.

>  	/* Check if the worker is in 'WAIT' state. Use acquire order
>  	 * since 'state' variable is used as the guard variable.
>  	 */
> --
> 2.33.0

<feature creep>
While you are at it, please also add "if (unlikely(lcore_id >=3D =
RTE_MAX_LCORE)) return -EINVAL;" checks in the other functions in =
eal_common_lcore.c where lcore_id comes from user input and the check is =
missing.
</feature creep>

