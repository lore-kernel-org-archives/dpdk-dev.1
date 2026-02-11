Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEA9ECD6EA
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 21:03:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4AD0402B5;
	Wed, 11 Feb 2026 22:03:15 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 0C131402AB
 for <dev@dpdk.org>; Wed, 11 Feb 2026 22:03:14 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id EE778208FB;
 Wed, 11 Feb 2026 22:03:12 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v3 06/27] net/i40e: use unsigned types for queue
 comparisons
Date: Wed, 11 Feb 2026 22:03:08 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6570F@smartserver.smartshare.dk>
In-Reply-To: <a2be771c0d9bb6653145c04ba4ff86a49e11e649.1770817884.git.anatoly.burakov@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 06/27] net/i40e: use unsigned types for queue
 comparisons
Thread-Index: AdybXemlx+FFub70SJqikeqokCCISwAOZOjw
References: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
 <a2be771c0d9bb6653145c04ba4ff86a49e11e649.1770817884.git.anatoly.burakov@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Anatoly Burakov" <anatoly.burakov@intel.com>, <dev@dpdk.org>,
 "Bruce Richardson" <bruce.richardson@intel.com>
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

> Currently, when we compare queue numbers against maximum traffic class
> value of 64, we do not use unsigned values, which results in compiler
> warning when attempting to compare `I40E_MAX_Q_PER_TC` to an unsigned
> value. Make it unsigned, and adjust callers to use correct types. As a
> consequence, `i40e_align_floor` now returns unsigned value as well -
> this
> is correct, because nothing about that function implies signed usage
> being
> a valid use case.
>=20
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_ethdev.c | 2 +-
>  drivers/net/intel/i40e/i40e_ethdev.h | 6 +++---
>  drivers/net/intel/i40e/i40e_hash.c   | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/intel/i40e/i40e_ethdev.c
> b/drivers/net/intel/i40e/i40e_ethdev.c
> index 2deb87b01b..d5c61cd577 100644
> --- a/drivers/net/intel/i40e/i40e_ethdev.c
> +++ b/drivers/net/intel/i40e/i40e_ethdev.c
> @@ -9058,7 +9058,7 @@ i40e_pf_reset_rss_reta(struct i40e_pf *pf)
>  	struct i40e_hw *hw =3D &pf->adapter->hw;
>  	uint8_t lut[RTE_ETH_RSS_RETA_SIZE_512];
>  	uint32_t i;
> -	int num;
> +	size_t num;

Why not just unsigned int? size_t seems weird when not counting bytes.

Or uint16_t, considering its use.

>=20
>  	/* If both VMDQ and RSS enabled, not all of PF queues are
>  	 * configured. It's necessary to calculate the actual PF
> diff --git a/drivers/net/intel/i40e/i40e_ethdev.h
> b/drivers/net/intel/i40e/i40e_ethdev.h
> index 0de036f2d9..d144297360 100644
> --- a/drivers/net/intel/i40e/i40e_ethdev.h
> +++ b/drivers/net/intel/i40e/i40e_ethdev.h
> @@ -24,7 +24,7 @@
>  #define I40E_AQ_LEN               32
>  #define I40E_AQ_BUF_SZ            4096
>  /* Number of queues per TC should be one of 1, 2, 4, 8, 16, 32, 64 */
> -#define I40E_MAX_Q_PER_TC         64
> +#define I40E_MAX_Q_PER_TC         64U
>  #define I40E_NUM_DESC_DEFAULT     512
>  #define I40E_NUM_DESC_ALIGN       32
>  #define I40E_BUF_SIZE_MIN         1024
> @@ -1517,8 +1517,8 @@ i40e_init_adminq_parameter(struct i40e_hw *hw)
>  	hw->aq.asq_buf_size =3D I40E_AQ_BUF_SZ;
>  }
>=20
> -static inline int
> -i40e_align_floor(int n)
> +static inline uint32_t
> +i40e_align_floor(uint32_t n)
>  {
>  	if (n =3D=3D 0)
>  		return 0;
> diff --git a/drivers/net/intel/i40e/i40e_hash.c
> b/drivers/net/intel/i40e/i40e_hash.c
> index f20b40e7d0..cbb377295d 100644
> --- a/drivers/net/intel/i40e/i40e_hash.c
> +++ b/drivers/net/intel/i40e/i40e_hash.c
> @@ -949,7 +949,7 @@ i40e_hash_parse_queues(const struct rte_eth_dev
> *dev,
>  	struct i40e_pf *pf;
>  	struct i40e_hw *hw;
>  	uint16_t i;
> -	int max_queue;
> +	size_t max_queue;

Why not just unsigned int? size_t seems weird when not counting bytes.

Or uint16_t, like rss_act->queue[i].
But then I40E_MAX_Q_PER_TC should maybe also be defined as UINT16_C(64), =
and maybe more should be uint16_t too.

>=20
>  	hw =3D I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
>  	if (!rss_act->queue_num ||
> @@ -971,7 +971,7 @@ i40e_hash_parse_queues(const struct rte_eth_dev
> *dev,
>  	max_queue =3D RTE_MIN(max_queue, I40E_MAX_Q_PER_TC);
>=20
>  	for (i =3D 0; i < rss_act->queue_num; i++) {
> -		if ((int)rss_act->queue[i] >=3D max_queue)
> +		if (rss_act->queue[i] >=3D max_queue)
>  			break;
>  	}
>=20
> --
> 2.47.3

