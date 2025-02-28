Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A80FC282C5
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 08:48:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18FB440E1D;
	Fri, 28 Feb 2025 09:48:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 69C614028C
 for <dev@dpdk.org>; Fri, 28 Feb 2025 09:48:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740732521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E/fbpxWzOFzwciGIUlJYHSSbfm3GwdAT4uOaIwUFPEk=;
 b=HbQAIOn9+8L8GDJGTRc0jtTi7anGSIDZrRFU8pB4I3pXRW6yfQvQl6Sqpsw4q8QPVp//I0
 hLar47cSZtIHg7Qb4s6gFfKLPtmM9gybBiaTQN7JRs27ltYowRb416JMNDVZ7lQvWPFuKl
 EE/xH9LDGEol43nNOZla8u94lCg1y9s=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-kU2_RfWvMmifif8CAgmmLA-1; Fri, 28 Feb 2025 03:48:39 -0500
X-MC-Unique: kU2_RfWvMmifif8CAgmmLA-1
X-Mimecast-MFC-AGG-ID: kU2_RfWvMmifif8CAgmmLA_1740732517
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5452e3275f9so1820687e87.0
 for <dev@dpdk.org>; Fri, 28 Feb 2025 00:48:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740732517; x=1741337317;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E/fbpxWzOFzwciGIUlJYHSSbfm3GwdAT4uOaIwUFPEk=;
 b=J2Q0IfT5ilqlR07RR/YscUOX7Kj/joszvQpVjBmVwuFWUlJSw6J72QksSE1HSrGgmg
 J139gy+C6QOeb1gcLnx+2EBnprRqFGIj3Kws8oSqnE/P5XS+jNBjgQYMIqwcezFIMENd
 i+aOZrjTUgrEvywJidCdoVoLY9IKZGJUPutOdh5P3NY3pPrdlgwTwXw7FTJ1jnM4LenL
 MJ88khk6hDZcJbsqaiivB0BtYVWWDWGCQ8pKAGDxVj+BJ8Jlj2EsHt5nQ2rCKN6kPPX5
 gpUVCv3scVs9GnPqT4GEMfwh5avSE3iuaH0xJV4NwfyHxZuToj+G3fO43liMKzJAixz5
 xXMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMs+GnsFuoKAbgerH3Sr7RpmVLtM/MAt024xfS8LM2NyfudV2Sq8B/7uF7MOJbd9AX150=@dpdk.org
X-Gm-Message-State: AOJu0YzowlC6BMn6yix8sr5YScO8eQZJZGyPtymU+kfsEoDI+xDT7tCa
 HldGJWuWcpoiSsCIBcgQj/oWlp9CDA3VSwaBuB7pxv4ADQsWdKdIb+rag4OJGSiM/80TiLrTkfG
 ysyOzyZa8Ot6v2I/sNcCb0868hdboXRNJ3FbYw6Eca31I/9yj+wFE+yi5H6BjlA/pNRdzV+7zGj
 x8sHUlDGusSONyNuA=
X-Gm-Gg: ASbGncvYtVMFZFoNwO9EmmBBu6NJqmZDjCCL5fbDcGh3vHn6BDoXo3giBz5i2pEd9h2
 qveOra7aDxhOzBFNulejFMofeYz0ZVQ9Mf0gh5BVAcY8NstInb7yFAW6CXruRBjhb73lRJWtvw4
 M=
X-Received: by 2002:a05:6512:398e:b0:545:8a1:5377 with SMTP id
 2adb3069b0e04-5494c1168cfmr891059e87.2.1740732516799; 
 Fri, 28 Feb 2025 00:48:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGX5okV75kr8463O5cQCYlFZNsBEFPWOuFt9InfryErxywPnzlI3PsWS54S9uvFsa7mjinryq9NQhSbEmZNeZY=
X-Received: by 2002:a05:6512:398e:b0:545:8a1:5377 with SMTP id
 2adb3069b0e04-5494c1168cfmr891049e87.2.1740732516440; Fri, 28 Feb 2025
 00:48:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740594750.git.gmuthukrishn@marvell.com>
 <0784f44b63f6161ac8716644acfea979704eca39.1740594750.git.gmuthukrishn@marvell.com>
 <81fac570-cdd7-45f7-b209-ce999d5c3d0e@redhat.com>
 <de649087-3686-4372-a1ac-d9a05961b6c0@redhat.com>
 <BY3PR18MB47054AE703CEB9AA6812A7C9CBCD2@BY3PR18MB4705.namprd18.prod.outlook.com>
 <BY3PR18MB470536F2A1329EE6732E332CCBCD2@BY3PR18MB4705.namprd18.prod.outlook.com>
In-Reply-To: <BY3PR18MB470536F2A1329EE6732E332CCBCD2@BY3PR18MB4705.namprd18.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 28 Feb 2025 09:48:25 +0100
X-Gm-Features: AQ5f1JpmKAZ0p6PNxTjh5Y084Ow-fhna6zab9kXLXnu4b7S-M65lLIb1qI3FARY
Message-ID: <CAJFAV8zDrLGrjk2F5EXqzGJUytQdnFnv5b1y5xr01TfYj0dRLA@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [v6 1/5] vhost: skip crypto op fetch before vring
 init
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>,
 Chenbo Xia <chenbox@nvidia.com>, Fan Zhang <fanzhang.oss@gmail.com>, 
 Jay Zhou <jianjay.zhou@huawei.com>, Anoob Joseph <anoobj@marvell.com>, 
 Akhil Goyal <gakhil@marvell.com>, "stable@dpdk.org" <stable@dpdk.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i884h8xLG8QXqYzxcb8blvefIXAvI8RpnccnWAbemGQ_1740732517
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

On Thu, Feb 27, 2025 at 7:07=E2=80=AFPM Gowrishankar Muthukrishnan
<gmuthukrishn@marvell.com> wrote:
> > > Ha, and also you should be able to remove:
> > > __rte_no_thread_safety_analysis /* FIXME: requires iotlb_lock? */ in
> > > vhost_crypto_process_one_req() once implemented.
> > >
> >
> Removing it would break compilation for thread safety flag.
> http://mails.dpdk.org/archives/test-report/2025-February/857515.html
>
> It is due to local vc_req that is passed to func that requires iotlb lock
> In vc_req->vq. Even though vc_req->vq is locked vq, GCC does not allow it=
, as I understand.

*cough* clang.

>
>         vc_req =3D &data_req;
>         vc_req->desc_idx =3D desc_idx;
>         vc_req->dev =3D vcrypto->dev;
>         vc_req->vq =3D vq;

The annotations won't handle this wrapping in the vc_req object.
Just pass a vq object rather than the vc_req (which I don't see little
point in having in the first place..) and adjust annotations.


--=20
David Marchand

