Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE382D44C51
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 14:33:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1479640268;
	Thu, 15 Jan 2026 15:33:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 17AD24003C
 for <dev@dpdk.org>; Thu, 15 Jan 2026 15:33:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768487609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NkeeYV2uD3GvfGO43DBgpLfiDrSkmATIWFCzFxa+kcc=;
 b=N+DJBUKkK8WFu/ZjeDZDXdny9iE5/qPQD5HtrzAxGl7rKEobg6ox9GITH/LEyxrmzYTO2Q
 RyQdBxQ3eiEsBZXq031z5pOtAUAY0dBbWYoDoXNkkGWrfvtGTZIOHTL6lro1GsLB1QyDfS
 Zg8SIBsEOoeEKHFi9V02knCTTLNmuwM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-3F1C9xdeOjm7oTYtjmctPg-1; Thu, 15 Jan 2026 09:33:27 -0500
X-MC-Unique: 3F1C9xdeOjm7oTYtjmctPg-1
X-Mimecast-MFC-AGG-ID: 3F1C9xdeOjm7oTYtjmctPg_1768487606
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-59b3b255ee8so639365e87.3
 for <dev@dpdk.org>; Thu, 15 Jan 2026 06:33:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768487606; x=1769092406;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NkeeYV2uD3GvfGO43DBgpLfiDrSkmATIWFCzFxa+kcc=;
 b=S0pJOeMbjA8lHOsopUZLkvn+iOhs1L0NcPs13gwFmP7TIrvq46yIZoWXS1eigRTOlH
 SQTuA5gGxKRJkF9t5fbtt4RonTpZ98SIavrO8DXp9gYhf/DyCGTN9XhfxJQUm03OCOn3
 GuXPUmmp2WJP7fx0BfOOXmr6ZbF/vMl1nTw/KY7x9BSfZfbUckhSsw6w+mm0+38jxl+I
 CCvLNAF/9gxAaSgEJv3YWPbV72EfDpcmprUwEBkiTjHtz/obd11ddHwFmCWCpX0ld2zw
 wwjWjA6x8f7Y/5fauZ0C1v4O/LrYq3F8x6egXAMzA3i7jmaeVxhXKfHlwv6BMxTrugW4
 FxUw==
X-Gm-Message-State: AOJu0YwAmv6u2/8PLE9iIPffff1fjHnnZB+m0ZW8nvzgD1hIYFW+UUNV
 rpf7fRe7hqNt9o3S+jNn0Lb6aBypPXnq3yFt0lkpv0+lXWtr7tI1QqoCFf32jCw//m17QSGQ1Hb
 xBwFvTZXJcgeu2UXwSOEpr4QaghjnO8EwBGTDvKguSt4nKBZIaiQKxou0gKMnrnRd80FnWn/p8t
 LqpFyN/XoDR4qG//wQueQ=
X-Gm-Gg: AY/fxX7kt4l+UL8C1biTWQYFyHFRT4Oqh21t3dZa+Q5ndGwhcP5IZScTUPvITkgUBuR
 MKEbZjhcjLxIk3FDNKbmfiIRsUDlAqV6D5tw0leS50YdGIxyvvI470Tl1ossAirLALf3sUqToTA
 qacMiJ5qD42dgL5vOxYxNF4K2oWZkjnaVmGUt9VujrUxtkHHQyo+ATMGEwjr37xL07bkJBBIP5/
 Nn/c+py8eFeLCP6WPg5ewq+o1NCP84gIaXWVtx8TqqVwMuQpcR7jA==
X-Received: by 2002:a05:6512:23a2:b0:594:493b:abd with SMTP id
 2adb3069b0e04-59ba0f62540mr2365856e87.13.1768487605721; 
 Thu, 15 Jan 2026 06:33:25 -0800 (PST)
X-Received: by 2002:a05:6512:23a2:b0:594:493b:abd with SMTP id
 2adb3069b0e04-59ba0f62540mr2365847e87.13.1768487605311; Thu, 15 Jan 2026
 06:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20251113124425.2913881-1-pravin.bathija@dell.com>
 <20251113124425.2913881-3-pravin.bathija@dell.com>
 <7de5dd70-45c2-4a76-954d-19beef994e5a@redhat.com>
 <SJ0PR19MB4606C6F61D8BBABEAA37A624F58CA@SJ0PR19MB4606.namprd19.prod.outlook.com>
In-Reply-To: <SJ0PR19MB4606C6F61D8BBABEAA37A624F58CA@SJ0PR19MB4606.namprd19.prod.outlook.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 15 Jan 2026 15:33:14 +0100
X-Gm-Features: AZwV_QgsklS_lRGPrY3dDyNDhXsK1GKPhC7GW6EuK7vCRh0O9WVVnUExBtEUnWI
Message-ID: <CAO55cszdKsDx4k7O9B+tPvWrGweCZ9bEPDVRGHaVjPKXVyihZQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] vhost_user: header defines for add/rem mem region
To: "Bathija, Pravin" <Pravin.Bathija@dell.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, 
 "pravin.m.bathija.dev@gmail.com" <pravin.m.bathija.dev@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5cW5J5NWBz3Erf4VX6Bie8Z7Iiuze9g4rg6Fs1YrZzw_1768487606
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

Hello,

On Thu, Jan 15, 2026 at 9:02=E2=80=AFAM Bathija, Pravin <Pravin.Bathija@del=
l.com> wrote:
>
> Dear Maxime,
>
> Responses inline.
>
>
> Internal Use - Confidential
> > -----Original Message-----
> > From: Maxime Coquelin <maxime.coquelin@redhat.com>
> > Sent: Tuesday, January 6, 2026 8:08 AM
> > To: Bathija, Pravin <Pravin.Bathija@dell.com>; dev@dpdk.org
> > Cc: pravin.m.bathija.dev@gmail.com
> > Subject: Re: [PATCH v5 2/4] vhost_user: header defines for add/rem mem
> > region
> >
> >
> > [EXTERNAL EMAIL]
> >
> >
> >
> > On 11/13/25 1:44 PM, Pravin M Bathija wrote:
> > > The changes in this file cover the enum message requests for
> > > supporting add/remove memory regions. The front-end vhost-user client
> > > sends messages like get max memory slots, add memory region and remov=
e
> > > memory region which are covered in these changes which are on the
> > > vhost-user back-end. The changes also include data structure
> > > definition of memory region to be added/removed. The data structure
> > > VhostUserMsg has been changed to include the memory region.
> > >
> > > Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> > > ---
> > >   lib/vhost/vhost_user.h | 10 ++++++++++
> > >   1 file changed, 10 insertions(+)
> > >
> > > diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h index
> > > ef486545ba..5a0e747b58 100644
> > > --- a/lib/vhost/vhost_user.h
> > > +++ b/lib/vhost/vhost_user.h
> > > @@ -32,6 +32,7 @@
> > >                                      (1ULL <<
> > VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD) | \
> > >                                      (1ULL <<
> > VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) | \
> > >                                      (1ULL <<
> > VHOST_USER_PROTOCOL_F_PAGEFAULT) | \
> > > +                                    (1ULL <<
> > VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS) | \
> >
> > It should be enabled only once the feature is actually implemented, oth=
erwise
> > bisection may fail.
>
> So to clarify, you are suggesting, this change ought to be the final patc=
h in the patch-set ?

Yes.
Because here you are advertising support for a feature that is not yet
implemented.

> >
> > >                                      (1ULL <<
> > VHOST_USER_PROTOCOL_F_STATUS))
> > >
> > >   typedef enum VhostUserRequest {
> > > @@ -67,6 +68,9 @@ typedef enum VhostUserRequest {
> > >     VHOST_USER_POSTCOPY_END =3D 30,
> > >     VHOST_USER_GET_INFLIGHT_FD =3D 31,
> > >     VHOST_USER_SET_INFLIGHT_FD =3D 32,
> > > +   VHOST_USER_GET_MAX_MEM_SLOTS =3D 36,
> > > +   VHOST_USER_ADD_MEM_REG =3D 37,
> > > +   VHOST_USER_REM_MEM_REG =3D 38,
> > >     VHOST_USER_SET_STATUS =3D 39,
> > >     VHOST_USER_GET_STATUS =3D 40,
> > >   } VhostUserRequest;
> > > @@ -91,6 +95,11 @@ typedef struct VhostUserMemory {
> > >     VhostUserMemoryRegion
> > regions[VHOST_MEMORY_MAX_NREGIONS];
> > >   } VhostUserMemory;
> > >
> > > +typedef struct VhostUserSingleMemReg {
> > > +   uint64_t padding;
> > > +   VhostUserMemoryRegion region;
> > > +} VhostUserSingleMemReg;
> > > +
> > >   typedef struct VhostUserLog {
> > >     uint64_t mmap_size;
> > >     uint64_t mmap_offset;
> > > @@ -186,6 +195,7 @@ typedef struct __rte_packed_begin VhostUserMsg {
> > >             struct vhost_vring_state state;
> > >             struct vhost_vring_addr addr;
> > >             VhostUserMemory memory;
> > > +           VhostUserSingleMemReg memory_single;
> > >             VhostUserLog    log;
> > >             struct vhost_iotlb_msg iotlb;
> > >             VhostUserCryptoSessionParam crypto_session;
>

