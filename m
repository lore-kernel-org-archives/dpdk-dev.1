Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD0DC83F09
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 13:34:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CBE640677;
	Tue,  8 Jul 2025 15:34:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id DA7A0402A0
 for <dev@dpdk.org>; Tue,  8 Jul 2025 15:34:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751981649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uHjBTFVxJQZ4BOw7gEBBKVjJMD3rKm8XLvpvf6lKOu4=;
 b=UeoO2nFjqoV259ESTfdsy+I+HLbS6hoaQp4TaVlq+rxEmJxBPq7ewe9vR9Uknc7xvxjZ11
 HheLnzKmvygNv8VvxueENiHcIiJrkedJWvxBBpisbxjHUgKUF9rbh+T+pp6udkORWmLrpZ
 8/B8Zp8YTRcN9bRUfUzAkKGf5rhPM54=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-MdzuIVWlP-aIob705rtSuA-1; Tue, 08 Jul 2025 09:34:08 -0400
X-MC-Unique: MdzuIVWlP-aIob705rtSuA-1
X-Mimecast-MFC-AGG-ID: MdzuIVWlP-aIob705rtSuA_1751981647
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-553d57646d0so3068930e87.1
 for <dev@dpdk.org>; Tue, 08 Jul 2025 06:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751981647; x=1752586447;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uHjBTFVxJQZ4BOw7gEBBKVjJMD3rKm8XLvpvf6lKOu4=;
 b=M56wSfX3pyjKOaL7k7JqqZf6av97pPoR0s1I9rfjMbqOvgjkBwTnrN0BWpfv0ayUKx
 3YULGwbNA/7ydWHrBHRuG9PRkkgT2sW/RcUv+veS2DRb1EPV5nSdm4NV1Ti6ZO1lSBZt
 kLMo2bLlDfjpZ3L3lRK4zGf7SDGfJOS7eOyUyJ45HlRVOZiFbvjE2yNBkOXPBXKmwkKn
 G2SA5EpWXPbpXqMPZExv+o0vHA6t1ZYRseKy11oaUyUN0lqls6CJ8jj3O91bRSdLWUxN
 D3hZoAxFkaWB9SnIGejOdx3yWLiNYFSuvydZguRyOq88vvO7TUZvPkZXVCUfE9Id98ps
 eN+w==
X-Gm-Message-State: AOJu0Yz1MaxOcbgjX4Sm0Svji2tV+AQdWK4ZEPHL1ooP2tJUItDAGVxM
 AIuLoBL3kGrnCxfBgHCclZK3qE2tiZg66RRldiKYlCa1sCxeKUh0U2MSM9WeKQWzs8AJ5z751FA
 gCasRuBsRpN1nhpf5WjlAsby71wN/LKyqt9fZeTGg2Arpmg5ELq0jjYXuR1CV5/Bk74FAkJa2Ez
 id6E8XKW0zMdGblRNzLKc=
X-Gm-Gg: ASbGncsmpBVUFiQKs+M8oauE5NhVY+Hc+myuwyRm8cUEfssq8yxZS4ZNbFcs4fQRWNh
 ILQmHiGzpGG9Szp4n6Ei8VPNnHy02FKLcEBOZY7K9AnKmVM6GDpWb17bi1lnlCgB8E/YKNq8PFx
 TuHhMfxA==
X-Received: by 2002:a05:6512:2513:b0:54f:c1cc:1241 with SMTP id
 2adb3069b0e04-557f8de647cmr1106058e87.25.1751981646592; 
 Tue, 08 Jul 2025 06:34:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFErA9LRggXMA5Vwdq/t3dfFbTLPzE8u5gtn68CaB3fm6A21mwb3NAAQY5Z6P51NyC/9Ewo+O4+Tpddea7bPR8=
X-Received: by 2002:a05:6512:2513:b0:54f:c1cc:1241 with SMTP id
 2adb3069b0e04-557f8de647cmr1106043e87.25.1751981646046; Tue, 08 Jul 2025
 06:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250708122823.3406288-1-david.marchand@redhat.com>
 <20250708122823.3406288-13-david.marchand@redhat.com>
 <aG0SmKmMAnW3hrfE@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8wj=EmaJnOVj4n8eVUR+BOAYhu38cJDu29Um4TkxFS9Tg@mail.gmail.com>
 <aG0cVcB55BF2mEDd@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aG0cVcB55BF2mEDd@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 8 Jul 2025 15:33:53 +0200
X-Gm-Features: Ac12FXzTnjAwfVB175Hwy4ZBjAaAMmGMeibffLe8A4niqaVnPeeeuk3jjM01WZg
Message-ID: <CAJFAV8xSHyv4dcRyK9bOQsKuR=e_yPJfcp8pt6_pQoD_FAOmCw@mail.gmail.com>
Subject: Re: [PATCH v3 12/18] malloc: fix mp message alignment
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BBZ6C6y7O1NQ69OeqItE5Bj7Bn5MXRp6XK1EjDN6wqk_1751981647
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jul 8, 2025 at 3:26=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Tue, Jul 08, 2025 at 02:46:04PM +0200, David Marchand wrote:
> > On Tue, Jul 8, 2025 at 2:44=E2=80=AFPM Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > >
> > > On Tue, Jul 08, 2025 at 02:28:16PM +0200, David Marchand wrote:
> > > > Content (param[]) of received multiprocess messages are aligned wit=
h
> > > > a 4 bytes constraint.
> > > >
> > > > Before patch:
> > > > struct mp_msg_internal {
> > > >  int type;                                                     /*  =
 0     4 */
> > > >  struct rte_mp_msg {
> > > >   char name[64];                                               /*  =
 4    64 */
> > > >   /* --- cacheline 1 boundary (64 bytes) was 4 bytes ago --- */
> > > >   int len_param;                                               /*  =
68     4 */
> > > >   int num_fds;                                                 /*  =
72     4 */
> > > >   /* typedef uint8_t -> __uint8_t */ unsigned char param[256]; /*  =
76   256 */
> > > >   /* --- cacheline 5 boundary (320 bytes) was 12 bytes ago --- */
> > > >   int fds[253];                                                /* 3=
32  1012 */
> > > >  } msg;                                                        /*  =
 4  1340 */
> > > >
> > > >  /* size: 1344, cachelines: 21, members: 2 */
> > > > };
> > > >
> > > > This results in many unaligned accesses for multiprocess malloc req=
uests.
> > > >
> > > > Examples:
> > > > ../lib/eal/common/malloc_mp.c:308:32: runtime error:
> > > >       member access within misaligned address 0x7f7b35df4684 for ty=
pe
> > > >       'const struct malloc_mp_req', which requires 8 byte alignment
> > > >
> > > > ../lib/eal/common/malloc_mp.c:158:9: runtime error:
> > > >       member access within misaligned address 0x7f36a535bb5c for ty=
pe
> > > >       'const struct malloc_mp_req', which requires 8 byte alignment
> > > >
> > > > ../lib/eal/common/malloc_mp.c:171:8: runtime error:
> > > >       member access within misaligned address 0x7f4ba65f296c for ty=
pe
> > > >       'struct malloc_mp_req', which requires 8 byte alignment
> > > >
> > > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > > ---
> > > >  lib/eal/common/eal_common_proc.c |  2 +-
> > > >  lib/eal/common/malloc_mp.c       | 18 +++++++++---------
> > > >  2 files changed, 10 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_=
common_proc.c
> > > > index 0dea787e38..3846c7178d 100644
> > > > --- a/lib/eal/common/eal_common_proc.c
> > > > +++ b/lib/eal/common/eal_common_proc.c
> > > > @@ -62,7 +62,7 @@ enum mp_type {
> > > >
> > > >  struct mp_msg_internal {
> > > >       int type;
> > > > -     struct rte_mp_msg msg;
> > > > +     alignas(8) struct rte_mp_msg msg;
> > > >  };
> > > >
> > > >  struct async_request_param {
> > > > diff --git a/lib/eal/common/malloc_mp.c b/lib/eal/common/malloc_mp.=
c
> > > > index 9765277f5d..000c7f6b47 100644
> > > > --- a/lib/eal/common/malloc_mp.c
> > > > +++ b/lib/eal/common/malloc_mp.c
> > > > @@ -148,7 +148,7 @@ get_unique_id(void)
> > > >  static int
> > > >  handle_sync(const struct rte_mp_msg *msg, const void *peer)
> > > >  {
> > > > -     struct rte_mp_msg reply;
> > > > +     alignas(8) struct rte_mp_msg reply;
> > > >       const struct malloc_mp_req *req =3D
> > > >                       (const struct malloc_mp_req *)msg->param;
> > >
> > > This patch seems to have a lot of these definitions with alignas adde=
d to
> > > them. Would it be simpler just to put the alignas inside the rte_mp_m=
sg
> > > definition?
> > >
> > > More specifically, if its the "uint8_t param" element that needs alig=
nment,
> > > how about changing that specific field to make it aligned?
> >
> > We could probably enhance this, but I expect this breaks ABI.
> >
> Is the multi-process message type part of the public ABI? I don't believe
> we ever guaranteed multiprocess support working across versions of DPDK.

An application can register its own callbacks which take a rte_mp_msg as in=
put.
Hum... would it really be an ABI breakage though... need to think.

At least I tested, and the ABI check is complaining.


--=20
David Marchand

