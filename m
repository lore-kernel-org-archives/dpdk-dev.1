Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA181C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 13:41:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F14544065F;
	Thu,  6 Mar 2025 14:41:00 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id ECBE040430
 for <dev@dpdk.org>; Thu,  6 Mar 2025 14:40:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741268459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/t7/kkcd/3ZLXzotYiIAPN7nMhz3/m9SkZwleqExDk=;
 b=QvVaV9hy28BoGwOzPceb0lG+otlA9coescCN7Mq3mNBk8KoDfWazuMwwTQQpmIXT43wqhL
 J5opOTSegfsahwkhLaXQHEeXtQoHPb7God4a9btOri7U+JfFpKWaPkrGUDtzabhgjDlnLI
 zjg+TaU6ttZBKS4YoLuNiDwU9pYJ0/Y=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-Mh-AqRMINXy44hEriksLDQ-1; Thu, 06 Mar 2025 08:40:43 -0500
X-MC-Unique: Mh-AqRMINXy44hEriksLDQ-1
X-Mimecast-MFC-AGG-ID: Mh-AqRMINXy44hEriksLDQ_1741268442
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5498879a3aeso267423e87.1
 for <dev@dpdk.org>; Thu, 06 Mar 2025 05:40:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741268442; x=1741873242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j/t7/kkcd/3ZLXzotYiIAPN7nMhz3/m9SkZwleqExDk=;
 b=v8GgrZfCu4i5b4dAtx2OInlMSqGixgCTnEl3dnSzqFJA8zClK8g8WXmNwvyD61QSBQ
 TOsHbSQAeoBC9NKal9cGWOfvP2hXY1pa7mJZtoFxQnGbG9QtC3lz7JuL6kSEvYQNAbNT
 WOFQzBu/X7H5Dh+G1yMAa0eTGMOkQuY07+B32C04wx/aHVMsCHVwIWQ3KEv3HOjFxDcv
 YLFeAtDgwhrZvyi6y5elS8luvAsQSC5J0LCd2XG2sNAgnJy9tDCvezIdnrZpa4MGILXi
 3XVLlq8sDCGC7vMqKYhl7bSWYBQSvb5T4O43i29AbBqsI9g8icFgLt3/6SOprUSf84Uq
 B3qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMrj7afTBE3ohWGZ4ewpLyj+gQnE+0z0L72Rsf3iWV9CMN4rOCWCXKhBckMO76V5IjXtg=@dpdk.org
X-Gm-Message-State: AOJu0Yz1CKi+Kg1UVmjdbaPv+je8RYZ8iBQ0xiQfescQUXsqFI+MIMiL
 3VHBKd/5R3fBw4RrUeMMDRt/JNLCp2aIdqWC8HX7rSQF1Mw71AxR3JLXpTMgxk/8nTtel4myjc1
 7UYznoOgH8qB3/Ja0Qsfj5cQIfvviZjC/t+2UVbX0BGHRJfCgzTiOE8CdDaNUPwM0CFRVrDDvkE
 fmNFJMTQ2y588m37I=
X-Gm-Gg: ASbGnctEegd33sEZcUS2l8jjI7cnV7AkrAekq+XvZjEgHLTsTZRNz0ATzx0IvUeGvO2
 HhRx+/enaoQpPpTbFv/wh/uctrmdPbEFd+VlK7NVIlpnrH1zbHmTytMh0G/YttFjG/vn7jNQze/
 E=
X-Received: by 2002:a05:6512:3d0e:b0:549:6759:3979 with SMTP id
 2adb3069b0e04-5497d336a8dmr3020125e87.18.1741268441939; 
 Thu, 06 Mar 2025 05:40:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRUzYAkCYm3yEiDKeeoJz+zzEQ15/GtolEdk7xhyfB/Ms4MOVdl+YOhimSaGK4PWdNyLwpg1Lx0NAKZql+bCA=
X-Received: by 2002:a05:6512:3d0e:b0:549:6759:3979 with SMTP id
 2adb3069b0e04-5497d336a8dmr3020112e87.18.1741268441538; Thu, 06 Mar 2025
 05:40:41 -0800 (PST)
MIME-Version: 1.0
References: <1740757940-10253-1-git-send-email-andremue@linux.microsoft.com>
 <1740780187-5272-1-git-send-email-andremue@linux.microsoft.com>
 <1740780187-5272-2-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1740780187-5272-2-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 6 Mar 2025 14:40:29 +0100
X-Gm-Features: AQ5f1JoySz20jm_i_48e_ExLCGR_WzWPfOF_heOqsdkimRFarAfRpl_PyuHoJcY
Message-ID: <CAJFAV8z4z4jYRpB9FXgrRTyqQRRq+f7sZ_2iCJR70290L7VBow@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] config: move existing code that is common to the
 top
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: bruce.richardson@intel.com, dev@dpdk.org, konstantin.v.ananyev@yandex.ru
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I31IyowKjqghR2WPVVfKM6LsXeFEkunqKICB7wqF6f4_1741268442
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

On Fri, Feb 28, 2025 at 11:03=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
> @@ -14,9 +59,8 @@ if is_linux or cc.get_id() =3D=3D 'gcc'
>      endif
>  endif
>
> -cc_avx512_flags =3D ['-mavx512f', '-mavx512vl', '-mavx512dq', '-mavx512b=
w']
> -cc_has_avx512 =3D false
> -target_has_avx512 =3D false
> +cc_avx2_flags =3D ['-mavx2']

It looks like rebase damage/conflict with another series touching those fla=
gs.
I'll see if I can fix this while applying...

> +cc_avx512_flags =3D ['-mavx512f', '-mavx512vl', '-mavx512dq', '-mavx512b=
w', '-mavx512cd']
>  if (binutils_ok and cc.has_multi_arguments(cc_avx512_flags)
>          and '-mno-avx512f' not in get_option('c_args'))
>      # check if compiler is working with _mm512_extracti64x4_epi64


--=20
David Marchand

