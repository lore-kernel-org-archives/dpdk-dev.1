Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9116E606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 09:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OmyVWrtJ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8EBC402D8;
	Fri,  6 Nov 2026 10:58:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 0DF72402B8
 for <dev@dpdk.org>; Fri,  6 Nov 2026 10:58:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793959120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=09+tHN09+ldEueO9vTs4NASN4j1Oo9UBVPyRFrJTAag=;
 b=OmyVWrtJY0GQW6Zb3+lw2pJYWBML7kUvHI0k7MXd8SFy87NqinA0zuWLuNQx3bwGJQNJCe
 s6JHnzoxnClj037p4o1Laa9Y5r6O85aBYONEQ4QTpfbSostyppG3MrH5nubXhX7Zwk7TOG
 Z2jI1XlIV5ekshltz8wNIMvSLdLKIeg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-wud--mqXOzCtx_62qdr_Pg-1; Fri, 06 Nov 2026 04:58:38 -0500
X-MC-Unique: wud--mqXOzCtx_62qdr_Pg-1
X-Mimecast-MFC-AGG-ID: wud--mqXOzCtx_62qdr_Pg_1793959117
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3ab30096801so2223911fa.1
 for <dev@dpdk.org>; Fri, 06 Nov 2026 01:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793959117; x=1794563917;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=09+tHN09+ldEueO9vTs4NASN4j1Oo9UBVPyRFrJTAag=;
 b=L8gvnXRBIALv2fU0iRsUV5aoVK+MxrpxsxHFeZd9jIcVSzlP/FCRboyNK+dApozXGw
 EezebLf4MTwFUSPPB2GZuvYHttutjxpthL39EJuWiiIPR7vvdUM7oFCh4Xx76cVI9MAj
 q5Jk5ZRj3nOtINZ9CZMpOBNKZgzyjD7uc72j9nElLRrs0xPmE3hKjJijuSV+ngKptAgM
 8gNnptBmybycxO3yOGp9IE+kuuSTHqPvBfEh2EvHJHNhcfBqd2l5JLE9COc+6uGm4VZp
 ieg2pjySTLAmmpgEAAoDd2bdU7Ae9uGw/32auvPY6H8lr0LgsH7vHgy6dBtNVlFvG0jV
 vgvQ==
X-Gm-Message-State: APuU4Z/dCpFCUvqvjwxsJSMImHDHNY7cahVeDw3jy8VlHeL5zFAKqob+
 7uHBOA950JB9aWT6C/SyTdxlN9fTlQV1VqrScipJZdXakkNMVwjdA3Euqr+LBNmbvdPhPi7bXXc
 T6bzxrnawQNVxwvvYUKdA7O8D33T9W/hSw7+2LL5x3H/UeGLqOwwzkVCHlEeYoYPc78sOHVG5oo
 f+i2sajExZdcjwNjukVIcnvCag3AuQHA==
X-Gm-Gg: AYBFou3lcS2yk23pcQFUsXD2QjyPA6W9ZlwGi262ODdUE6gpFnRYdkzpBGdzSTp3EZw
 ffSi3agx9QGM7+Z4c5b6kFBiL1lDGdk2Pi9a8PH8OPAFTjzqW8zzp/RWs8htRNQF0PV4Ei762cs
 H/cS8LDb3I3exQW/yKznj2hysrivpdQih0kGKj+z5xJOSsr5LMeTb2WX+YL3MDzpmpl1qcmD5CF
 ZgXpn9KNmpI5MMVGYQ5+XElUEKUT4hgQqF+kVfS0rR1CtJg
X-Received: by 2002:a05:651c:1466:b0:3aa:fd7d:6164 with SMTP id
 38308e7fff4ca-3acf3d327c7mr4027831fa.25.1793959117336; 
 Fri, 06 Nov 2026 01:58:37 -0800 (PST)
X-Received: by 2002:a05:651c:1466:b0:3aa:fd7d:6164 with SMTP id
 38308e7fff4ca-3acf3d327c7mr4027771fa.25.1793959116813; Fri, 06 Nov 2026
 01:58:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103170717.1243319-1-thomas@monjalon.net>
In-Reply-To: <20261103170717.1243319-1-thomas@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 6 Nov 2026 10:58:24 +0100
X-Gm-Features: AclHuK9RNSxk7BvQMiB1F1eouEG7mY7hbpMzXkAUj2bZlh8L87pag7iMuJEQs1k
Message-ID: <CAJFAV8yi5jPC-S=-ByFn80eEgnccWH5T1n6UeLug7fSATJJeKQ@mail.gmail.com>
Subject: Re: [PATCH] ipc: increase hotplug devargs limit
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BVGa8hoNYDWWedBDzm_3MbbWuTCiTlt_cP759eN-0GE_1793959117
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 at 18:07, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> Derive the hotplug devargs buffer size from the IPC parameter capacity.
> This increases the maximum devargs length in multi-process mode
> from 127 to 247 bytes, excluding the terminating null byte.
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---
>  lib/eal/common/eal_common_dev.c | 2 +-
>  lib/eal/common/hotplug_mp.h     | 8 +++++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
> index f42a8d2349..febb584313 100644
> --- a/lib/eal/common/eal_common_dev.c
> +++ b/lib/eal/common/eal_common_dev.c
> @@ -276,7 +276,7 @@ rte_dev_probe(const char *devargs)
>                 goto skip_mp_req;
>
>         if (strlen(devargs) >= EAL_DEV_MP_DEV_ARGS_MAX_LEN) {
> -               EAL_LOG(ERR, "devargs truncated (len %zu, max %d)",
> +               EAL_LOG(ERR, "devargs truncated (len %zu, max %zu)",
>                         strlen(devargs), EAL_DEV_MP_DEV_ARGS_MAX_LEN);
>                 return -E2BIG;
>         }
> diff --git a/lib/eal/common/hotplug_mp.h b/lib/eal/common/hotplug_mp.h
> index 7221284286..bd2f0f296a 100644
> --- a/lib/eal/common/hotplug_mp.h
> +++ b/lib/eal/common/hotplug_mp.h
> @@ -5,6 +5,7 @@
>  #ifndef _HOTPLUG_MP_H_
>  #define _HOTPLUG_MP_H_
>
> +#include "rte_eal.h"
>  #include "rte_dev.h"
>
>  #define EAL_DEV_MP_ACTION_REQUEST      "eal_dev_mp_request"
> @@ -12,7 +13,9 @@
>
>  #define EAL_DEV_MP_DEV_NAME_MAX_LEN RTE_DEV_NAME_MAX_LEN
>  #define EAL_DEV_MP_BUS_NAME_MAX_LEN 32
> -#define EAL_DEV_MP_DEV_ARGS_MAX_LEN 128
> +#define EAL_DEV_MP_DEV_ARGS_MAX_LEN (RTE_MP_MAX_PARAM_LEN \
> +       - sizeof(enum eal_dev_req_type) - sizeof(int))
> +       /* minus t and result from struct eal_dev_mp_req */
>
>  enum eal_dev_req_type {
>         EAL_DEV_REQ_TYPE_ATTACH,
> @@ -27,6 +30,9 @@ struct eal_dev_mp_req {
>         int result;
>  };
>
> +static_assert(sizeof(struct eal_dev_mp_req) <= RTE_MP_MAX_PARAM_LEN,
> +       "Hotplug message struct exceeds IPC parameter capacity");
> +

A bit ugly to list those fields, even with the assert.

No strong opinion, just listing an alternative.

The idea is to switch to a flexible array for devargs.

 struct eal_dev_mp_req {
     enum eal_dev_req_type t;
-    char devargs[EAL_DEV_MP_DEV_ARGS_MAX_LEN];
     int result;
+    char devargs[];
 };

+#define EAL_DEV_MP_DEV_ARGS_MAX_LEN \
+    (RTE_MP_MAX_PARAM_LEN - sizeof(struct eal_dev_mp_req))


This requires an update of
eal_dev_hotplug_request_to_primary/eal_dev_hotplug_request_to_secondary
so they manipulate a rte_mp_msg object.
A bonus side effect is that it avoids copies on stack for the message,
as the caller already provides the message buffer.


-- 
David Marchand

