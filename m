Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB76D1CDC6
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 11:06:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CF3440270;
	Tue,  9 Dec 2025 12:06:51 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 331E94025F
 for <dev@dpdk.org>; Tue,  9 Dec 2025 12:06:50 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dQbdW6TwlzHnHFk;
 Tue,  9 Dec 2025 19:06:39 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id 3E9A940565;
 Tue,  9 Dec 2025 19:06:49 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 9 Dec 2025 11:06:48 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Tue, 9 Dec 2025 11:06:48 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: =?iso-2022-jp?B?bWFubnl3YW5nKBskQjImMUpKdhsoQik=?=
 <mannywang@tencent.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v6] acl: support custom memory allocators
Thread-Topic: [PATCH v6] acl: support custom memory allocators
Thread-Index: AQHcY22PWbrv6GKo5kS8T6P61cmsvLUXhRKwgACl9ACAAQPdgA==
Date: Tue, 9 Dec 2025 11:06:48 +0000
Message-ID: <f1d4e2f3dd2841dd86799faf00a6d559@huawei.com>
References: <58cca566-08bd-469e-b244-1800e0456cb0@huawei.com>
 <BFA8D0B9488D3A67+20251202092502.165081-1-mannywang@tencent.com>
 <2571c074e438491e837c51d1bdc5a538@huawei.com>
 <20251208112916.2743f596@phoenix.local>
In-Reply-To: <20251208112916.2743f596@phoenix.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.220]
Content-Type: text/plain; charset="iso-2022-jp"
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



> On Mon, 8 Dec 2025 09:43:01 +0000
> Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:
>=20
> > > Allow users to provide custom
> > > memory allocation hooks for runtime memory in rte_acl_ctx, via
> > > struct rte_acl_mem_hook.
> >
> > LGTM in general, few extra comments below.
> >
> > > Key changes:
> > > - Added struct rte_acl_mem_hook with zalloc, free, and udata.
> > > - Added rte_acl_set_mem_hook / rte_acl_get_mem_hook to set/get
> callbacks.
> > > - Default allocation uses existing rte_zmalloc_socket/rte_free.
> > > - Modified ACL code to call callbacks for runtime allocations instead
> > >   of rte_zmalloc_socket/rte_free directly.
> > >
> > > v5:
> > > - Remove temporary memory allocation callback for build stage.
> > > - Introduce new API (rte_acl_set_mem_hook / rte_acl_get_mem_hook)
> > >   instead of modifying existing rte_acl_config to preserve
> > >   ABI compatibility.
> > >
> > > v6:
> > > - Reworked API to meet consistency and naming conventions.
> > > - Adjusted parameter order for better readability and alignment.
> > > - Renamed internal variables for clarity and code consistency.
> > >
> > > Signed-off-by: YongFeng Wang <mannywang@tencent.com>
> > > ---
> > >  app/test/test_acl.c                           | 121 ++++++++++++++++=
++
> > >  .../prog_guide/packet_classif_access_ctrl.rst |  31 +++++
> > >  lib/acl/acl.h                                 |   1 +
> > >  lib/acl/acl_bld.c                             |   2 +-
> > >  lib/acl/acl_gen.c                             |   4 +-
> > >  lib/acl/rte_acl.c                             |  45 ++++++-
> > >  lib/acl/rte_acl.h                             |  47 +++++++
> > >  7 files changed, 247 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/app/test/test_acl.c b/app/test/test_acl.c
> > > index 43d13b5b0f..3c9a0cb8c0 100644
> > > --- a/app/test/test_acl.c
> > > +++ b/app/test/test_acl.c
> > > @@ -1721,6 +1721,125 @@ test_u32_range(void)
> > >  	return rc;
> > >  }
> > >
> > > +struct acl_ctx_wrapper {
> > > +	struct rte_acl_ctx *ctx;
> > > +	void *running_buf;
> > > +	bool running_buf_using;
> > > +};
> > > +
> > > +#define ACL_RUNNING_BUF_SIZE (10 * 1024 * 1024)
> > > +
> > > +static void *running_alloc(char *name, size_t size,
> > > +	size_t align, int32_t socket_id, void *udata)
> > > +{
> > > +	RTE_SET_USED(align);
> > > +	RTE_SET_USED(name);
> > > +	RTE_SET_USED(socket_id);
> > > +	if (size > ACL_RUNNING_BUF_SIZE)
> > > +		return NULL;
> > > +	struct acl_ctx_wrapper *acl_ctx =3D (struct acl_ctx_wrapper *)udata=
;
> > > +	if (acl_ctx->running_buf_using)
> > > +		return NULL;
> > > +	printf("running memory alloc for acl context, size=3D%zu, pointer=
=3D%p\n",
> > > +		size,
> > > +		acl_ctx->running_buf);
> > > +	memset(acl_ctx->running_buf, 0, size);
> > > +	acl_ctx->running_buf_using =3D true;
> > > +	return acl_ctx->running_buf;
> > > +}
> >
> > Is there any point to have such memhook in our UT?
> > From one side: it doesn't test anything new, as memory is still allocst=
ed via
> rte_zmalloc().
> > From other side it is error prone, as you don't check that pre-allocate=
d buffer
> > will really satisfy requested  size and alignment parameters.
> > Might be just use libc malloc/free here?
>=20
> A lot of the problems would go away if ACL just used regular malloc/free =
more,
> and rte_malloc/rte_free less.

It uses rte_malloc in just two places - to allocate ctx itself and for actu=
al Run-Time table.
All temporary allocations are done with normal malloc.
There are obvious reasons why people prefer to use rte_malloc-ed memory
in their data-path functions: rte-malloc-ed memory uses hugepages and is MP=
 shared. =20
So I suppose providing users a choice where they want their ACL tables to b=
e located
is a good option.

> The existing rte_malloc is slow and fragments badly.=20
Then we probably need to improve it, don't we?


