Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D7AC021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 09:15:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48F114028B;
	Wed, 19 Feb 2025 10:15:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BCDA94025A
 for <dev@dpdk.org>; Wed, 19 Feb 2025 10:15:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739956539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GWFxkfbRImMY+xDLb5nIKWR/o0pVuQ+uXN2O3ru9iTg=;
 b=dnw2/W1JmB3nf5EMNobI9AmRH6B7KahuClCTnLYPuNyMpMfaENWBA7NiBMS8fB4n74p0mm
 1SEYWEgHTlZfeW4f+3YgGBAKe/jd5joiGE+bkp70u2xXC08lli6X9nIWMJP8XKXZT8dDhr
 wZl4gwUXo4TTho1+yRL8P4xbIh6Dqs8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-19a-RC75ODW13vyjYfLK1Q-1; Wed, 19 Feb 2025 04:15:35 -0500
X-MC-Unique: 19a-RC75ODW13vyjYfLK1Q-1
X-Mimecast-MFC-AGG-ID: 19a-RC75ODW13vyjYfLK1Q_1739956534
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-543bb2be3dcso3996495e87.2
 for <dev@dpdk.org>; Wed, 19 Feb 2025 01:15:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739956534; x=1740561334;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GWFxkfbRImMY+xDLb5nIKWR/o0pVuQ+uXN2O3ru9iTg=;
 b=Dl7prESi4ViezwlT8iXZllQO/hCMgJenePT+19AFjp92Wk4iChqZx3nrkwe9Yn40fB
 wOqxpsvM/vxSkD1CuRvgAjU69EnW5tKcScRSG243SkRFbR1XgiQAbOJAjuiHUNHegLY0
 Q/KsaLIP9u6p91oyMvva/DyLxCtF8nwE5mlpwDDK++iqEJ0rIrreseNpu9ivTz1v3m2O
 oBrNppRBCSzVffmI9KzjgYgwjJ2FCUw8kxPrl55LmGGs8sW1viDjWDGNV1XRbJ7ccf4/
 1DADSUqA0glwfn6xPeW3r+tqukQTkU/eG2sqjWXulP9g9LKqZZpsM4gxW0FFnAhLXX2F
 aYPA==
X-Gm-Message-State: AOJu0YycvlY/MszzBzXGmCiduZMLyeI7XBFLLopiJ5tTZH0b6nkpPoxy
 GcgJwO0ZuAE5kz4zdvlzu2VqWy5yCUXRyw4yAWd/daRByHvoUjSQBF2CQ8/ajvGyBoDwFulct2O
 gecaj77SCAg6r/AFe6oCVOvG24nO28u55jGZg5d668P+UtiV+CX8YFTvSQ9m6fojqaFc10cmxFS
 UMz9ykopdWvqmyqgI=
X-Gm-Gg: ASbGnctizRpQY4Owomb8vAUE76Xd4XPdJHdtVxCbv33lpxqgRfEd+9Xonm5znXvrC7d
 R/13aT1xC7tzHsmOYasmsNaGBBnbs9rbl2YJXZnSWBvciumj3fP6S3M3E1R/q1yUK
X-Received: by 2002:a05:6512:159a:b0:545:9ce:7606 with SMTP id
 2adb3069b0e04-5462ef197eemr1223771e87.34.1739956534182; 
 Wed, 19 Feb 2025 01:15:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOcdFHej6OFIFGN2w7Jp2jyqg/Jg02tQib7BFaYJhGM/vjHeHgwi8i2i+4V5CXW7EFPJG+SRhaYJFTAszt9vg=
X-Received: by 2002:a05:6512:159a:b0:545:9ce:7606 with SMTP id
 2adb3069b0e04-5462ef197eemr1223755e87.34.1739956533739; Wed, 19 Feb 2025
 01:15:33 -0800 (PST)
MIME-Version: 1.0
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-11-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1739896329-1946-11-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 19 Feb 2025 10:15:21 +0100
X-Gm-Features: AWEUYZmwVa4s0EijFpewq-mBhwCUk7kI4W_cNWNX06tPXZXeJ7BapQ9Gzdr1ZTY
Message-ID: <CAJFAV8xSBZrbsfwSW2BmzETom78uSa4ZYEPXoZQgUSTCoo6z0Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] app: enable app directory to be compiled with
 MSVC
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HDxivOwkmwIn5SzguoKqq0drmNxZM6bmDZlfn7KLeBo_1739956534
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

On Tue, Feb 18, 2025 at 5:33=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
> diff --git a/app/test-pmd/meson.build b/app/test-pmd/meson.build
> index f1c36529b4..8e8863812a 100644
> --- a/app/test-pmd/meson.build
> +++ b/app/test-pmd/meson.build
> @@ -3,7 +3,9 @@
>
>  # override default name to drop the hyphen
>  name =3D 'testpmd'
> -cflags +=3D '-Wno-deprecated-declarations'
> +if cc.has_argument('-Wno-deprecated-declarations')
> +    cflags +=3D '-Wno-deprecated-declarations'
> +endif
>  sources =3D files(
>          '5tswap.c',
>          'cmdline.c',

We don't need this flag anymore.

This is probably a remnant of 9f2be5b3db8b ("ethdev: deprecate attach
and detach functions"), which got fixed later with
c9cce42876f5 ("ethdev: remove deprecated attach/detach functions").


--=20
David Marchand

