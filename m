Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF128C83F09
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 12:46:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E91A440677;
	Tue,  8 Jul 2025 14:46:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B3015402A0
 for <dev@dpdk.org>; Tue,  8 Jul 2025 14:46:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751978780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t+ZR7SxzoprrnsmTYpgy6Tk80AgazfXSeirOl8VqV1k=;
 b=CN/qyyEZx5LaFoyKd06cwEbMxR+hF3g1be1YjNPn1lMiPIedKp9WObQBNQIzAxHjA4P9oS
 PYKrqkZ6Hu730XWvzXXu878FaExf0WvzogFZY0w9MSmjV5y+Y+TiYHQVI/OrMOk3ZkZT7/
 PFcXezOzKHEGcIr2rRGUnwsT7fJGOkA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-1JJrxe8fPmS2svmjCi_uSg-1; Tue, 08 Jul 2025 08:46:19 -0400
X-MC-Unique: 1JJrxe8fPmS2svmjCi_uSg-1
X-Mimecast-MFC-AGG-ID: 1JJrxe8fPmS2svmjCi_uSg_1751978777
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5562a916832so2619991e87.1
 for <dev@dpdk.org>; Tue, 08 Jul 2025 05:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751978777; x=1752583577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t+ZR7SxzoprrnsmTYpgy6Tk80AgazfXSeirOl8VqV1k=;
 b=Wg1J2le5Ab0+ohtreSac1EB4BoBV8oAd3QhdbC3Zr1WIujoI+Wtq98ZM8MpCb4K9gg
 twxGLJfsrBmUxvqMYmBQG2ITam/dgZ/hUWU8l5nxDEIKu5qRBDrFSbg6WKtuGq2e5UGN
 9NtAIYOHGGEEvrcINul7pMlIjD9Saa7pjJoF7vF7nzt0AojkU4YM6JqwyxHrzcqhddzn
 ezG3VGNHKQjk3I+uYsxj7203zJWpVbpg94nHHJJaujRR2xiMFcCFLME4WtsjXoyMrl0L
 Czm4a62G4FCCvn6wduk2RTRDpPLLZ8W+XcWnwcSgf467G4eXf3FcOQxAEo6v2+sLzKY3
 ZcsA==
X-Gm-Message-State: AOJu0Yz0o/l5Jz94OHLgg2een5g9L3303E/SlU0KObqQlVxZVHrNXF3t
 r+WzAQpUSHMOO/XlY8GYfLPEBRdv+gMTm2xxTHYXETw679lSVZ85S2kIU+DFoxohHe5iCQK8g4L
 2D1keDh2SaJbVAxoAmCXemPtuTMeisAf3j6+yIeNVKPLj1yuZXoBhIQAQt/P07zMS2ntmnQxvgp
 uK56XBBaSbfz3bjMErDSU3F2Kjneo=
X-Gm-Gg: ASbGncsAOm5uN6teD0fTqDnQxF3bmO4Qj7XdaBjsix+XoH9zVB7oQ99zBuECkDItKp5
 e7AVvKaiPbM0WaFagATUSg7R948u+pOngMhDXgAU3JKh/ErsoGNQCWTQvJPA0XLN4ERNGAhs8a0
 TuR/A2KA==
X-Received: by 2002:a05:6512:a84:b0:553:a2c0:da70 with SMTP id
 2adb3069b0e04-557aa2934a4mr5359936e87.26.1751978777352; 
 Tue, 08 Jul 2025 05:46:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEpGW8g1yVCPwOpzgawTfCgO0HcsJxa15UqWEt++4HnkM3lzDDAEgJ/ixh6rt52jMyl9t1D59yqNkcbqZJoiM=
X-Received: by 2002:a05:6512:a84:b0:553:a2c0:da70 with SMTP id
 2adb3069b0e04-557aa2934a4mr5359923e87.26.1751978776699; Tue, 08 Jul 2025
 05:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250708122823.3406288-1-david.marchand@redhat.com>
 <20250708122823.3406288-13-david.marchand@redhat.com>
 <aG0SmKmMAnW3hrfE@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aG0SmKmMAnW3hrfE@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 8 Jul 2025 14:46:04 +0200
X-Gm-Features: Ac12FXxhgfyMHxLX6h9EhX5MOoN7WM37W1vXd6qfIXsJbSETzaPS6Dt6IqBSz8I
Message-ID: <CAJFAV8wj=EmaJnOVj4n8eVUR+BOAYhu38cJDu29Um4TkxFS9Tg@mail.gmail.com>
Subject: Re: [PATCH v3 12/18] malloc: fix mp message alignment
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lSeEKY-Ay9ZCbAVG4F4tlE07mtEwcWNxRAPhYG9zqSo_1751978777
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

On Tue, Jul 8, 2025 at 2:44=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Tue, Jul 08, 2025 at 02:28:16PM +0200, David Marchand wrote:
> > Content (param[]) of received multiprocess messages are aligned with
> > a 4 bytes constraint.
> >
> > Before patch:
> > struct mp_msg_internal {
> >  int type;                                                     /*   0  =
   4 */
> >  struct rte_mp_msg {
> >   char name[64];                                               /*   4  =
  64 */
> >   /* --- cacheline 1 boundary (64 bytes) was 4 bytes ago --- */
> >   int len_param;                                               /*  68  =
   4 */
> >   int num_fds;                                                 /*  72  =
   4 */
> >   /* typedef uint8_t -> __uint8_t */ unsigned char param[256]; /*  76  =
 256 */
> >   /* --- cacheline 5 boundary (320 bytes) was 12 bytes ago --- */
> >   int fds[253];                                                /* 332  =
1012 */
> >  } msg;                                                        /*   4  =
1340 */
> >
> >  /* size: 1344, cachelines: 21, members: 2 */
> > };
> >
> > This results in many unaligned accesses for multiprocess malloc request=
s.
> >
> > Examples:
> > ../lib/eal/common/malloc_mp.c:308:32: runtime error:
> >       member access within misaligned address 0x7f7b35df4684 for type
> >       'const struct malloc_mp_req', which requires 8 byte alignment
> >
> > ../lib/eal/common/malloc_mp.c:158:9: runtime error:
> >       member access within misaligned address 0x7f36a535bb5c for type
> >       'const struct malloc_mp_req', which requires 8 byte alignment
> >
> > ../lib/eal/common/malloc_mp.c:171:8: runtime error:
> >       member access within misaligned address 0x7f4ba65f296c for type
> >       'struct malloc_mp_req', which requires 8 byte alignment
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> >  lib/eal/common/eal_common_proc.c |  2 +-
> >  lib/eal/common/malloc_mp.c       | 18 +++++++++---------
> >  2 files changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_comm=
on_proc.c
> > index 0dea787e38..3846c7178d 100644
> > --- a/lib/eal/common/eal_common_proc.c
> > +++ b/lib/eal/common/eal_common_proc.c
> > @@ -62,7 +62,7 @@ enum mp_type {
> >
> >  struct mp_msg_internal {
> >       int type;
> > -     struct rte_mp_msg msg;
> > +     alignas(8) struct rte_mp_msg msg;
> >  };
> >
> >  struct async_request_param {
> > diff --git a/lib/eal/common/malloc_mp.c b/lib/eal/common/malloc_mp.c
> > index 9765277f5d..000c7f6b47 100644
> > --- a/lib/eal/common/malloc_mp.c
> > +++ b/lib/eal/common/malloc_mp.c
> > @@ -148,7 +148,7 @@ get_unique_id(void)
> >  static int
> >  handle_sync(const struct rte_mp_msg *msg, const void *peer)
> >  {
> > -     struct rte_mp_msg reply;
> > +     alignas(8) struct rte_mp_msg reply;
> >       const struct malloc_mp_req *req =3D
> >                       (const struct malloc_mp_req *)msg->param;
>
> This patch seems to have a lot of these definitions with alignas added to
> them. Would it be simpler just to put the alignas inside the rte_mp_msg
> definition?
>
> More specifically, if its the "uint8_t param" element that needs alignmen=
t,
> how about changing that specific field to make it aligned?

We could probably enhance this, but I expect this breaks ABI.

This could be done during 25.11.


--=20
David Marchand

