Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06467606EE8A
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=w5/y1IGF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=diOpeFiz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26345402D1;
	Fri,  6 Nov 2026 12:17:54 +0100 (CET)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTPS id A9706402B8
 for <dev@dpdk.org>; Fri,  6 Nov 2026 12:17:52 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id B0C9AEC018B
 for <dev@dpdk.org>; Fri,  6 Nov 2026 06:17:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 06 Nov 2026 06:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1793963871;
 x=1794050271; bh=zfEvQahE3K9DgVf1hpZUWpejpAQbti6fRPScZe/f1DM=; b=
 w5/y1IGFK6VhqXOvBrcZ6gOdqRKufQi3GMj/PmK4gH2ncy7w3PvoOJ3i+hzA+XVu
 gv97m6FyEzfy22+aTWrlpozE1zE/kivuAm/gZvbpjBj1omSsICdzyZeyrZZwCRCO
 d0FHxP8euLp3q/+Nu5GGuyeW8bOlz3LtzX2Ip4iVuU2Nzdo7AlmVlexjtM3OOgPm
 QdZALAU+OEflm7BcmWz+V9Z75P4/lRWx1SP1v3juaiZgSYDN5RCGlQkWGMAAbFHk
 Bg7YoHEI9YpFuSuufsLZ0GkWaR7UJ8PluH/JQGki1ZCE2ezqMmvq7rUt8C4dvVDl
 m6+lJG7tt6G16C02QMZybQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793963871; x=
 1794050271; bh=zfEvQahE3K9DgVf1hpZUWpejpAQbti6fRPScZe/f1DM=; b=d
 iOpeFizwJZo42/Z5h5KinAaL92N5JJm+pa6Intr8E8puPPYi6bMyaYfRQ5Qi27Lo
 qSy0tpVnK1fP8wELDHa69pX1j+PYlEf07N/kHNa3NB6/qY1EyfCaAfrVN0N/PnHq
 9+ZW+0OwIr9RaD6hphEBDqQ1Ao3r83C4PAvYZvSWpDhMWZtwdmgnWR+qrPQ8i/hn
 FwRhbg5FE9eA5ThoYB4kAXmfFJDFdm5O4PkvQGzVUQof71fUTqlKX+dS4yOOZp0Q
 A2RABRBsd5Dh2kmg08OfKMwvbPOz7/n0uJeWnhuwKSss0ikFT53GC9zptq6IPyJg
 jtJmoISbYkUb9Hldu0IjQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793963871; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:TYu6/kOH3UNHBdVQQ4bo4+LUyGbku8P6FB4ILAWzJgHaFcO
 uvu7kRBsmWIFB1g82eUFF6Or7reynWhrcayDS6z+S3dU+M0CCawUW0yHhA5LtJXB
 Qh8YglYWy1txGY8TCjb7MjhxPiLV+1X5zOjMh3gANzU3QN1xCLoferDOPs0mdGmQ
 ZafNfTvDZOB/uZPmAUaFuWKzODU7lzqI6dHm/Qh9Qz2SPWEWVH/RRVVNDqsoJT+N
 ZniEAVkk2r9n1fZJDSDPnTHcFdAy1U+ZHU+j2roqAHGUvxo/6HRdbnxs8jwvkERo
 t89r9KpoM1IuYA/fjs/qB5qgfQqIBC1gPxzgNlQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:JPAJL/mpp4bqLayrA70gX06XbnkswEQKjaExBOrmd28=:kGVhz3MvF1vwxVF2MJmp235nuY/qgZxXfhl3KerbXvQ=;
X-ME-Sender: <xms:X7ftahoTATLvk6Ts5IxF4QMrNaZ_sLEadl-lS1l7y5Dmy4bL-EyTyQ>
 <xme:X7ftav9qQSuHThcslHXBZ3WULUfwqunqAGV2tBE5mqzz96IHwaJuEoXIR3D-Bfw3P
 wTxoI4ShOWfqRmuciz-6C5PQsZT126qV6OxrEqcbZSXS-4uh4Ah8BI>
X-ME-Received: <xmr:X7ftag-yDgXqqC2TIaWaclHeWMmc-H718LnXrjhk5OWNSer2o8mcvQGMDfyH0dn1ktzFOvx6-8I80k8mo3kgqdM>
X-ME-Proxy-Cause: dmFkZTGFJGy0hUx//7pniaptOJk4PoMC9/5OUkXODXw3cZYHgiUzY2VRS9mBSIXCNGmG+v
 8SYKLVQ5eudPOxrw01P4l9JLmYX8GCgNkWr1WMp5e7/VvBDEM8OIweGzv+zA16ToJcQ1u9
 5unv2LBGc1jkCx+z2QJgwLOvL8eJBCl78O5aE+tWJy1fsIw76Te2TBGhF757y74ovd1F56
 DHhkUwb5FRBc4FzartODSFND8vYj3uzRRwlz3GTKMWz7SOBH+RaQa+X8KnxnipCgAmcjez
 aE29wvUByh39H8LjrKby5Vt5SvERH17/eD+RYzBn7tQPwJPwh4zNgLcbt38KVgB++zXPWZ
 p/Q8igxGB63XpeF/nHv4PKlhSTni7A/4wJhZAgr1tS7eLGV8jfVxoXvEt4Pg6n43WGxK/w
 moI3tE4dWHl1IUqC0ksOlNX1zrPVs7tlDiwT7N9vQzwwvTOaU/ROKtkNZPzMjGVuTEhs0w
 V8naw2hpIhExIwZ3sRStbL9kt6Q0lsWNByZ8XJJjbUV5aVM9YoTRAew2QmF0pyb7B0clRi
 j6dGHQN3pWUdBVI3Df0J3VW3cwfoE+6rwNFBk4bxsh2fjUQNzGinxQGdO6UO/1q+7RjneJ
 RI+lfUUSDhuKhRdWqbpLoe7v7GHj2Sb1WgUruMr6exrUqYcye0w1LuOlk1VQ
X-ME-Proxy: <xmx:X7ftauvpolsY6cBsYnz6PHAy43QjgfaX_n1_CymRFWubOCcYYq3YqA>
 <xmx:X7ftajqxcwXuox0mdFS3CGAQQ3q169-Xa5-v-gsje5zleb_Mm4jV4g>
 <xmx:X7ftarnazhiwov_gtp0YGookqODaOoImV_Rse3DuUiRoe_KJqYLFTw>
 <xmx:X7ftanzU52JNNIYUCqkZpRHgOPmbqvZYeCHRC5Z-au8rHXagVrvPCw>
 <xmx:X7ftaicTnZqCVXYl9vsLecZ6IrqpMxH32OKN90RhN3dKNpo4vVyPn_Ni>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 06:17:51 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] ipc: increase hotplug devargs limit
Date: Fri, 06 Nov 2026 12:17:49 +0100
Message-ID: <qp7MH_QfRzaHgjOqw40uCA@monjalon.net>
In-Reply-To: <CAJFAV8yi5jPC-S=-ByFn80eEgnccWH5T1n6UeLug7fSATJJeKQ@mail.gmail.com>
References: <20261103170717.1243319-1-thomas@monjalon.net>
 <CAJFAV8yi5jPC-S=-ByFn80eEgnccWH5T1n6UeLug7fSATJJeKQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

06/11/2026 10:58, David Marchand:
> On Tue, 3 Nov 2026 at 18:07, Thomas Monjalon <thomas@monjalon.net> wrote:
> >
> > Derive the hotplug devargs buffer size from the IPC parameter capacity.
> > This increases the maximum devargs length in multi-process mode
> > from 127 to 247 bytes, excluding the terminating null byte.
> >
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > ---
> >  lib/eal/common/eal_common_dev.c | 2 +-
> >  lib/eal/common/hotplug_mp.h     | 8 +++++++-
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
> > index f42a8d2349..febb584313 100644
> > --- a/lib/eal/common/eal_common_dev.c
> > +++ b/lib/eal/common/eal_common_dev.c
> > @@ -276,7 +276,7 @@ rte_dev_probe(const char *devargs)
> >                 goto skip_mp_req;
> >
> >         if (strlen(devargs) >= EAL_DEV_MP_DEV_ARGS_MAX_LEN) {
> > -               EAL_LOG(ERR, "devargs truncated (len %zu, max %d)",
> > +               EAL_LOG(ERR, "devargs truncated (len %zu, max %zu)",
> >                         strlen(devargs), EAL_DEV_MP_DEV_ARGS_MAX_LEN);
> >                 return -E2BIG;
> >         }
> > diff --git a/lib/eal/common/hotplug_mp.h b/lib/eal/common/hotplug_mp.h
> > index 7221284286..bd2f0f296a 100644
> > --- a/lib/eal/common/hotplug_mp.h
> > +++ b/lib/eal/common/hotplug_mp.h
> > @@ -5,6 +5,7 @@
> >  #ifndef _HOTPLUG_MP_H_
> >  #define _HOTPLUG_MP_H_
> >
> > +#include "rte_eal.h"
> >  #include "rte_dev.h"
> >
> >  #define EAL_DEV_MP_ACTION_REQUEST      "eal_dev_mp_request"
> > @@ -12,7 +13,9 @@
> >
> >  #define EAL_DEV_MP_DEV_NAME_MAX_LEN RTE_DEV_NAME_MAX_LEN
> >  #define EAL_DEV_MP_BUS_NAME_MAX_LEN 32
> > -#define EAL_DEV_MP_DEV_ARGS_MAX_LEN 128
> > +#define EAL_DEV_MP_DEV_ARGS_MAX_LEN (RTE_MP_MAX_PARAM_LEN \
> > +       - sizeof(enum eal_dev_req_type) - sizeof(int))
> > +       /* minus t and result from struct eal_dev_mp_req */
> >
> >  enum eal_dev_req_type {
> >         EAL_DEV_REQ_TYPE_ATTACH,
> > @@ -27,6 +30,9 @@ struct eal_dev_mp_req {
> >         int result;
> >  };
> >
> > +static_assert(sizeof(struct eal_dev_mp_req) <= RTE_MP_MAX_PARAM_LEN,
> > +       "Hotplug message struct exceeds IPC parameter capacity");
> > +
> 
> A bit ugly to list those fields, even with the assert.
> 
> No strong opinion, just listing an alternative.
> 
> The idea is to switch to a flexible array for devargs.
> 
>  struct eal_dev_mp_req {
>      enum eal_dev_req_type t;
> -    char devargs[EAL_DEV_MP_DEV_ARGS_MAX_LEN];
>      int result;
> +    char devargs[];
>  };
> 
> +#define EAL_DEV_MP_DEV_ARGS_MAX_LEN \
> +    (RTE_MP_MAX_PARAM_LEN - sizeof(struct eal_dev_mp_req))
> 
> 
> This requires an update of
> eal_dev_hotplug_request_to_primary/eal_dev_hotplug_request_to_secondary
> so they manipulate a rte_mp_msg object.
> A bonus side effect is that it avoids copies on stack for the message,
> as the caller already provides the message buffer.

Yes it looks better.


