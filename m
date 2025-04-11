Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF494C36010
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 06:52:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA1D64068A;
	Fri, 11 Apr 2025 08:52:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0414040285
 for <dev@dpdk.org>; Fri, 11 Apr 2025 08:52:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744354348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnlPoAfsjhmvSxIlk6DBr1h3IP3jwtiDVEWX8hSVW4U=;
 b=RpOjdwU7hgYugyt8krtZ9ZAooNd5OtD6NJHdWfAzw68DVSxDJdcOVnKhb61St/IMLpAluk
 4LN/ogvy6Nqbf6Sqt007zZ4bzSXydVdJg6PYO9JFidxucvFTdVy8w3+e3OOfqPeZprXZN4
 DD9w0iSs64AwVMDB0Ri9sZrHPThy0LU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-T6Z_my-7MGi9HIX0i6I78Q-1; Fri, 11 Apr 2025 02:52:27 -0400
X-MC-Unique: T6Z_my-7MGi9HIX0i6I78Q-1
X-Mimecast-MFC-AGG-ID: T6Z_my-7MGi9HIX0i6I78Q_1744354346
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-54c0a1ca4f7so860238e87.3
 for <dev@dpdk.org>; Thu, 10 Apr 2025 23:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744354346; x=1744959146;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dnlPoAfsjhmvSxIlk6DBr1h3IP3jwtiDVEWX8hSVW4U=;
 b=aT21i0K0oBQOV8cwMTeX0jXYlsWAM7Dz9h5EEKSp2WES7TgrA5GzirCyH9GLdhMfMQ
 g1rN11bARoPdZNV2jfZFVn2XLuiHmx9sm76AdVP+eAg88L+xgHCKJofny4uRnyhB7rug
 VmyA1JC5VZDl3zQMMz6+Ok4d580uhamKyN1D9VXkmN88U+AqxUYk8ystywjLxRY7a/XF
 mKP3wGDPpoCro+y2ZJ8+gfje7aP8e0INwwn6hZUgU938+PCvCL0L+u2vW1+joJ0KDD40
 5IAkFj9chAU03Xz0ZQoGz/iArvy9ki2/hlAaVmDo1zGDumn4gsdw9EdrzD88ES6TZLkU
 z7NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpzAoohw76BmA3ADwzKnslZWBLSQ0SPEWXFPhN6/w8uCMVSJk8r1LGJh6McbD7O+j8K9Y=@dpdk.org
X-Gm-Message-State: AOJu0YyjPgSQOkEmuntkngHOMYrToDCcDKtfx68jkER4ooZ+v3zGo9CM
 DHpnJnDLKGNgIQBQvgO2M5c6vWSsVmw0f7D2af05pnLvWYAejxXiAgdk/M8UL8PFTjtznf73BCv
 UY7c+EqVO9Hm2e6ZnjgsW0UbZ0+f+JMSpLVq3Ci4wxl+D1Covv/2EOKVT760vphSUg1nroC0+0k
 4z+nsgZAze4Ta9wvc=
X-Gm-Gg: ASbGnct858BjfbUSYowfBiekiJTWyzuXN0QfiBeVSEQpbkVnmlyRF7CRzPivk/rApRG
 3eKCLt3v5eLWwL9aiYUg3nbZAI1SdzGquD5vUz4NpbtefhvRHiS4ErrOZIwhVC2l99RxKrOk=
X-Received: by 2002:a05:6512:3da5:b0:545:2f0d:8836 with SMTP id
 2adb3069b0e04-54d452d261cmr413706e87.40.1744354345695; 
 Thu, 10 Apr 2025 23:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/XbTXcNQvmMQw8SW2zaziUJsIL+2OqJAvJvv3COUmBCLLL2nxbVrDswABubHpxcCT7wejWXAWY3F+I3yat6o=
X-Received: by 2002:a05:6512:3da5:b0:545:2f0d:8836 with SMTP id
 2adb3069b0e04-54d452d261cmr413700e87.40.1744354345228; Thu, 10 Apr 2025
 23:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250409125440.7103-1-praveen.shetty@intel.com>
 <Z_aDznlc6Cd7nti4@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z_aDznlc6Cd7nti4@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 11 Apr 2025 08:52:12 +0200
X-Gm-Features: ATxdqUEo7CjEvKwQRHSjkGumoLUnF0QYw9mr1ZBU51CkaIBy7mGrgD4o1FbU-Yk
Message-ID: <CAJFAV8wMtW5y+-k=jCUg5RFizbbn1SLbRj8nNicVqrQQK6g_=g@mail.gmail.com>
Subject: Re: [PATCH v1] net/idpf: avoid truncation of constant value
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Praveen Shetty <praveen.shetty@intel.com>, dev@dpdk.org, 
 Andre Muezerie <andremue@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nJ1JxZczDhZC2KfSfs4fM_AVAI_W1OIiP5grWP3jMZk_1744354346
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

On Wed, Apr 9, 2025 at 4:27=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Wed, Apr 09, 2025 at 12:54:40PM +0000, Praveen Shetty wrote:
> > Truncation of constant value compiler warning was reported in clang/msv=
c
> > compiler for the VIRTCHNL2_CAP_OEM bit setting.This is due to 64 bit nu=
mber
> > is initialized in a 32 bit enum.VIRTCHNL2_CAP_OEM capability is not use=
d in
> > the present dpdk code,so removing this bit setting from the dpdk to avo=
id
> > the truncation.
>
> Please just watch spacing after punctuation in commit message. Will fix o=
n
> apply as necessary, no need for new revision to fix it.
>
> >
> > Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
> > ---
> >  drivers/net/intel/idpf/base/virtchnl2.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/net/intel/idpf/base/virtchnl2.h b/drivers/net/inte=
l/idpf/base/virtchnl2.h
> > index 3285a2b674..cf010c0504 100644
> > --- a/drivers/net/intel/idpf/base/virtchnl2.h
> > +++ b/drivers/net/intel/idpf/base/virtchnl2.h
> > @@ -265,8 +265,6 @@ enum virtchnl2_cap_other {
> >        * if a reserved bit is set in a standard completion's tag.
> >        */
> >       VIRTCHNL2_CAP_MISS_COMPL_TAG            =3D BIT_ULL(20),
> > -     /* This must be the last capability */
> > -     VIRTCHNL2_CAP_OEM                       =3D BIT_ULL(63),
> >  };
> >
>
> Although technically perhaps not as good as [1], this avoids significant
> divergence from the shared base code, while still fixing the core issue.
>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>
>
> [1] https://patches.dpdk.org/project/dpdk/patch/1734537913-1159-1-git-sen=
d-email-andremue@linux.microsoft.com/

LGTM.
I marked Andre patch as rejected.


--=20
David Marchand

