Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94077C021B3
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 20:58:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E333410E8;
	Fri, 21 Feb 2025 21:58:31 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 8D805410E6
 for <dev@dpdk.org>; Fri, 21 Feb 2025 21:58:30 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 4D87320989;
 Fri, 21 Feb 2025 21:58:30 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v5 08/10] test-pmd: declare lcore_count atomic
Date: Fri, 21 Feb 2025 21:58:28 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FA65@smartserver.smartshare.dk>
In-Reply-To: <1740167563-12332-9-git-send-email-andremue@linux.microsoft.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5 08/10] test-pmd: declare lcore_count atomic
Thread-Index: AduEmk/SCwiUidtSSfmUFysSwW7SEAAB2cIw
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740167563-12332-1-git-send-email-andremue@linux.microsoft.com>
 <1740167563-12332-9-git-send-email-andremue@linux.microsoft.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Andre Muezerie" <andremue@linux.microsoft.com>,
 <konstantin.ananyev@huawei.com>
Cc: <dev@dpdk.org>,
	"Chengwen Feng" <fengchengwen@huawei.com>
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

> From: Andre Muezerie [mailto:andremue@linux.microsoft.com]
> Sent: Friday, 21 February 2025 20.53
>=20
> Compiling with MSVC results in the error below:
>=20
> app/test/test_ring_perf.c(197): error C7712: address argument to =
atomic
>     operation must be a pointer to an atomic integer,
>     'volatile unsigned int *' is not valid
>=20
> The fix is to mark lcore_count as atomic.
>=20
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  app/test/test_ring_perf.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/app/test/test_ring_perf.c b/app/test/test_ring_perf.c
> index 57cd04a124..921aa902c5 100644
> --- a/app/test/test_ring_perf.c
> +++ b/app/test/test_ring_perf.c
> @@ -34,7 +34,7 @@ struct lcore_pair {
>  	unsigned c1, c2;
>  };
>=20
> -static volatile unsigned lcore_count =3D 0;
> +static volatile RTE_ATOMIC(unsigned int) lcore_count;

Using rte_atomic_xxx to access the RTE_ATOMIC qualified lcore_count =
seems more clean than making it volatile and sometimes access it =
non-atomically.
It is only accessed two more times, so not a big change.

Anyway, this could just be my personal preference. No change required if =
you disagree.

