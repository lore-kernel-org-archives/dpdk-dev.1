Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5B3606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pi41pJ7r
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07A154060F;
	Thu,  5 Nov 2026 16:04:01 +0100 (CET)
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 1CB1F402DB
 for <dev@dpdk.org>; Thu,  5 Nov 2026 16:03:59 +0100 (CET)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-679965fb848so2331426d50.1
 for <dev@dpdk.org>; Thu, 05 Nov 2026 07:03:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793891038; cv=none;
 d=google.com; s=arc-20260327;
 b=IwQPQxGFBzBIO/Ia8sJbQdOlYARslAHTY4KXufOs4H3p28gSEe2UNWGKEX6z5DaN5c
 EXRW+T+iXJFZoA/skelTOdRwngoksDkI1PSBI0k25p6BPFfMh0vqEmtzQuVHuZbfNfO7
 cS5SRSVgmZIliGD5IBdPBL3zAWBCuJPSdlsD3r2cDCV/Aru6d6jpKypUZPFhq1FZ1mWz
 vgB7oaJbF9jH0Dru8KlRn9AVtGR6sf5uBwINrn18dAoOoVDeGIVrAaZFtcORwvC/y774
 U7106hLCcU695lfa4Zy+W4GYprDGvp5DwqFPSRgXBBcE74fNVwyHAvMkAWbruPfREHK/
 /a9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N518aOUX84oMs5+dRMWDQdNLoNwl+0wl+RnDu0acR6c=;
 fh=oBzMBBXUrXJu8DCdXy429mcmyPngsflSehz1sgIePJU=;
 b=dYRAUWwHuiYQQEwz0A1PDVu4ma9Ve5VRRu7C2gV0ZAKA1V9ecmUSrrMSLOW3K2ZQVH
 JBdFrEZ7VoiJIJ/XprYjnPBB7jy02mV9/3daeeC2B8NmsvpFHxiLB/l0vDCQu0oqRBPs
 KJf8DFBXlAX9gqY2vj+nKVljw3FgPA+Ov5UiohKhKAIKMvOzXmofVAYCxy2bDJG0kSbB
 AIgk4O8pnO97/hJkeU1kliIyFRyZEyw1RCiTwXO0eNUPNXNxO61XDqz5nh6LTWGnZsVb
 El4Pxec0zVcFdh06nYR40Nm0sGrOOn0wIf08vk6IHEJ2d+9jO8R8mi85xl7gAmcbQRSm
 MKxw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793891038; x=1794495838; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N518aOUX84oMs5+dRMWDQdNLoNwl+0wl+RnDu0acR6c=;
 b=pi41pJ7rLCe22i1MVPQ1HxjIAiq47zBF+8Gt5aG2aNwXTM5jUtrUEWxW2Sn4gdZHyl
 sBt9uyxI57V6bUM2smtFMDUqiISV9DkstZb4RGhWVkWDdbMh1DjrqD84Yt+oQQvlTuEc
 kht4sJ7Az/i2Gur8TrFNLSZvpZrUxB9q3bW1GDOz7Z7p4kA8HqmmzSTDaIzWYqSejX9u
 smXsDEndL4KPVjCN1g4TJA+PMtP9Tcuh2xa13blSDhCKBntYOrjMxNPWFzEqr9A5G1B/
 CPsXMOLs0VrS0WPQNqj2jnp7bx6hrLdiNSkf7xe1fo8yfsPRu2pp/0lnUtxLgN2wqZYA
 TZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793891038; x=1794495838;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N518aOUX84oMs5+dRMWDQdNLoNwl+0wl+RnDu0acR6c=;
 b=eLyrS+g/tYmwSMjh0VBLGYsTP+oEzeccXDjweUrbsJbPoR6Mh2fufI+UoRRv+d7v9u
 GY9zrFNoThnlALhVmNMcyxzHuD8tKjGUZDZ41C73uduLUPypahsmTgSLjLKbTzgbi1ix
 4t7LiiDJ/THj1GBwdb+mbSOYldSohPZ/hF80EKD1MjDGj7gnFbC2q0ZDmLnZ+KnpiS7d
 TBcusqp7olblraQDvakjJwN+s7jnGAcrGYZ5Ve+bhWQxfDrzYIYbSLxEmI+bmDOEW+uP
 jNl7gvqY7qvZ9uXVdZ8CDvzTAaZKaQw4INpGa2SqrF+3DdZVnmLF2yg8mCijuv1ulAlE
 Plrw==
X-Gm-Message-State: APuU4Z9fpmJwd6XXzBriFEMSOiC3pbpkfVUXOsWCKjFfMfkk0LaCXcrW
 CxYWLenVKcKWxHJg7ntE+wMk9Ojt5S2PiMMBhAEMB9vKZT1O+Rwpp43Fe3yKGyoooIAsZexk7J7
 g6k1X35todMKpcdC8mbKc/+IvDSkBBZw=
X-Gm-Gg: AYBFou0ATsGQrunRv4iBDmBTltajvGvSqTLEDdnwOUssda6GTqBieZt9HDLVFfF5IA/
 xg7ylNYtguMyFzz806hnsPhRuCA7HzOWnyWleTXTw275yrR8XuSlY8IqsH7/67p+ypuwYvOpXBg
 7QwjAIMtz6YKWJ0nd6NQBNv0B4GSl4pJX5m07EVCsZXx09AvbszeyLf86/Ve1H7CpXeJu316cl2
 FBIJ3gbglgRf/LjP2YR3YYd5Dq100zFF6Qow44vcXa+bjGg+lFRpaYlgCUtAEzqC6i9Um7KkeO+
 vlR+8ecLcuHQRo9fwxgWSWpXP0lY1rTwOsi2yxdclgEPIZC8HH4xFMP3ghGtObUQD6VHIzfKEs+
 sMJPjpYVJjaRuSMgAKDbgaFYWMEWkFMFnKprYaR95e/3IYm0/QbJGyoa/jM/6rnQEbKUyRDlA8U
 gN1w8N3Nhzc8EhdSrncN9fvN8QOWIwzIIQXHndSw5m8KoOgEPgmNQPVHTnVODv5JRexryNSmxbK
 A==
X-Received: by 2002:a05:690e:128b:b0:67b:f3f7:c1d1 with SMTP id
 956f58d0204a3-67bf3f7d036mr2339963d50.21.1793891037712; Thu, 05 Nov 2026
 07:03:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030055006.947575-1-nkishor@marvell.com>
In-Reply-To: <20261030055006.947575-1-nkishor@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Thu, 5 Nov 2026 20:33:31 +0530
X-Gm-Features: AclHuK_lP9Wkiwmt9pk6MxGPssuej3JCVGzjXwFJ83U2q7EvKv9ycxgvwDh1PIs
Message-ID: <CALBAE1MTf9odxLW9=+CfEUB9OJAuJMAhSTzG81NMNZ06L8fc3A@mail.gmail.com>
Subject: Re: [PATCH] common/cnxk: fix uninitialized pointers in NPA context
 dump
To: Nawal Kishor <nkishor@marvell.com>
Cc: dev@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 jerinj@marvell.com, asekhar@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 11:38=E2=80=AFAM Nawal Kishor <nkishor@marvell.com>=
 wrote:
>
> In roc_npa_ctx_dump(), rsp and rsp_cn20k are only set through
> mbox_process_msg() in separate branches, while the dump code that reads
> them selects the pointer in a different branch. The compiler cannot
> prove that the pointer being read was set, and warns about a possibly
> uninitialized variable.
>
> Initialize both pointers to NULL.
>
> Fixes: a7cc84c6e9e5 ("common/cnxk: support HALO in NPA")
>
> Signed-off-by: Nawal Kishor <nkishor@marvell.com>


Applied to dpdk-next-net-mrvl/for-main. Thanks
> ---
>  drivers/common/cnxk/roc_npa_debug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/common/cnxk/roc_npa_debug.c b/drivers/common/cnxk/ro=
c_npa_debug.c
> index f978be9642..e2b50ae1c3 100644
> --- a/drivers/common/cnxk/roc_npa_debug.c
> +++ b/drivers/common/cnxk/roc_npa_debug.c
> @@ -249,9 +249,9 @@ npa_cn20k_aura_dump(__io struct npa_cn20k_aura_s *aur=
a)
>  int
>  roc_npa_ctx_dump(void)
>  {
> +       struct npa_cn20k_aq_enq_rsp *rsp_cn20k =3D NULL;
>         struct npa_cn20k_aq_enq_req *aq_cn20k;
> -       struct npa_cn20k_aq_enq_rsp *rsp_cn20k;
> -       struct npa_aq_enq_rsp *rsp;
> +       struct npa_aq_enq_rsp *rsp =3D NULL;
>         struct npa_aq_enq_req *aq;
>         struct mbox *mbox;
>         struct npa_lf *lf;
> --
> 2.48.1
>
