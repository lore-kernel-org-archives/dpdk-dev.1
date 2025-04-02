Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52685C28B20
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 14:45:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 781A040275;
	Wed,  2 Apr 2025 16:45:16 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 40A0A40273
 for <dev@dpdk.org>; Wed,  2 Apr 2025 16:45:15 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E21C521791;
 Wed,  2 Apr 2025 16:45:14 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v3 2/3] eal: fix unckeck pipe
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 2 Apr 2025 16:45:12 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FB8D@smartserver.smartshare.dk>
In-Reply-To: <20250402122454.2148612-3-huangdengdui@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 2/3] eal: fix unckeck pipe
Thread-Index: AdujykF+pDPU+xISRgexPSmRKH5EAgAD+9Sg
References: <20250321040316.104126-1-huangdengdui@huawei.com>
 <20250402122454.2148612-1-huangdengdui@huawei.com>
 <20250402122454.2148612-3-huangdengdui@huawei.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Dengdui Huang" <huangdengdui@huawei.com>,
	<dev@dpdk.org>
Cc: <fengchengwen@huawei.com>, <lihuisong@huawei.com>, <haijie1@huawei.com>,
 <liuyonglong@huawei.com>, <roretzla@linux.microsoft.com>,
 <dmitry.kozliuk@gmail.com>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>,
 "Harry van Haaren" <harry.van.haaren@intel.com>
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
> Sent: Wednesday, 2 April 2025 14.25
>=20
> The communication pipe may be unavailable, for example,
> when the lcore role is ROLE_OFF or ROLE_NON_EAL.
> So check whether the pipe is available before using it.
>=20
> Fixes: a95d70547c57 ("eal: factorize lcore main loop")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> ---
>  lib/eal/unix/eal_unix_thread.c | 3 +++
>  lib/eal/windows/eal_thread.c   | 3 +++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/lib/eal/unix/eal_unix_thread.c
> b/lib/eal/unix/eal_unix_thread.c
> index ef6cbff0ee..103571cabf 100644
> --- a/lib/eal/unix/eal_unix_thread.c
> +++ b/lib/eal/unix/eal_unix_thread.c
> @@ -17,6 +17,9 @@ eal_thread_wake_worker(unsigned int worker_id)
>  	char c =3D 0;
>  	int n;
>=20
> +	if (m2w =3D=3D 0 || w2m =3D=3D 0)
> +		return -EINVAL;
> +
>  	do {
>  		n =3D write(m2w, &c, 1);
>  	} while (n =3D=3D 0 || (n < 0 && errno =3D=3D EINTR));
> diff --git a/lib/eal/windows/eal_thread.c
> b/lib/eal/windows/eal_thread.c
> index 9e3df200b9..82bb974868 100644
> --- a/lib/eal/windows/eal_thread.c
> +++ b/lib/eal/windows/eal_thread.c
> @@ -24,6 +24,9 @@ eal_thread_wake_worker(unsigned int worker_id)
>  	char c =3D 0;
>  	int n;
>=20
> +	if (m2w =3D=3D 0 || w2m =3D=3D 0)
> +		return -EINVAL;
> +
>  	do {
>  		n =3D _write(m2w, &c, 1);
>  	} while (n =3D=3D 0 || (n < 0 && errno =3D=3D EINTR));
> --
> 2.33.0

This internal function eal_thread_wake_worker() is only called from =
rte_eal_remote_launch().
It would be better to check the lcore role there.

References:
https://elixir.bootlin.com/dpdk/v25.03-rc2/A/ident/eal_thread_wake_worker=

https://elixir.bootlin.com/dpdk/v25.03-rc2/source/lib/eal/common/eal_comm=
on_launch.c#L52

Furthermore, in theory, file descriptor 0 is a valid file descriptor; if =
"stdin" has been closed, a newly opened file (or pipe) may be assigned =
file descriptor 0.

