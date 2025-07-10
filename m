Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D57C83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Jul 2025 08:24:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E6FB402D8;
	Thu, 10 Jul 2025 10:24:16 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 2C275402D1;
 Thu, 10 Jul 2025 10:24:14 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bd78W2F3bz6L5KG;
 Thu, 10 Jul 2025 16:20:59 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
 by mail.maildlp.com (Postfix) with ESMTPS id 0CEA51402F3;
 Thu, 10 Jul 2025 16:24:14 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Jul 2025 10:24:13 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 10 Jul 2025 10:24:13 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "techboard@dpdk.org"
 <techboard@dpdk.org>
Subject: RE: [PATCH] doc: announce changes in structure alignments for UBSan
Thread-Topic: [PATCH] doc: announce changes in structure alignments for UBSan
Thread-Index: AQHb8M65Ug/Rgx1shEGQMc2UFWQn7rQrBjpw
Date: Thu, 10 Jul 2025 08:24:13 +0000
Message-ID: <70844e94235d40f09a375e10b2d50a35@huawei.com>
References: <20250709124022.4105481-1-david.marchand@redhat.com>
In-Reply-To: <20250709124022.4105481-1-david.marchand@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.73]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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



> As part of the effort to limit undefined behaviors in DPDK code, some
> structure alignments revealed not to be accurate enough.
> At the moment two structures have been identified but others may be
> found while running more parts of DPDK with UBSan.
>=20
> Though the calling code can explicitly request alignment,
> we would prefer to put the alignment constraints as part of the
> structure definition itself.
>=20
> Such changes are ABI breakages.
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  doc/guides/rel_notes/deprecation.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/=
deprecation.rst
> index e2d4125308..4ae561d670 100644
> --- a/doc/guides/rel_notes/deprecation.rst
> +++ b/doc/guides/rel_notes/deprecation.rst
> @@ -57,6 +57,10 @@ Deprecation Notices
>    ``__atomic_thread_fence`` must be used for patches that need to be mer=
ged in
>    20.08 onwards. This change will not introduce any performance degradat=
ion.
>=20
> +* lib: multiple issues relating to unaligned accesses have been detected=
 using the UBSan checker.
> +  As part of resolving those issues, alignment in some structures will b=
e updated in 25.11,
> +  namely (but not exhaustively): ``struct rte_stack_lf_head`` and ``stru=
ct rte_mp_msg``.
> +
>  * lib: will fix extending some enum/define breaking the ABI. There are m=
ultiple
>    samples in DPDK that enum/define terminated with a ``.*MAX.*`` value w=
hich is
>    used by iterators, and arrays holding these values are sized with this
> --
> 2.50.0

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
