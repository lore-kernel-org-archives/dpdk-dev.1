Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8794C7115B
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 16:45:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 965A5402E1;
	Mon, 23 Jun 2025 18:45:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CD42C40151
 for <dev@dpdk.org>; Mon, 23 Jun 2025 18:45:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750697115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OCI297KccGdaCE7wHahZmEew6g3cMXPnEQ/bII0ZyqM=;
 b=ABwsZNxzw2119SbCY12xXnbcf0izQRSbPwxeYkJYb+tU1ZTGP6+JmH3iYm8p0swkLzHp/x
 h6ixETI+RF4C84/J8Y0V/u5TrNsk/XpD9co0JJ9WAozI0L/QeILSevd0jd39Uo1nbfidB4
 CeE8ULbjRiwgC02PyKetihIt4Izw+Zw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-dkjqYmEeNb2IaRDJotzVyA-1; Mon, 23 Jun 2025 12:45:09 -0400
X-MC-Unique: dkjqYmEeNb2IaRDJotzVyA-1
X-Mimecast-MFC-AGG-ID: dkjqYmEeNb2IaRDJotzVyA_1750697108
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-551ec3101c7so1745162e87.2
 for <dev@dpdk.org>; Mon, 23 Jun 2025 09:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750697107; x=1751301907;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OCI297KccGdaCE7wHahZmEew6g3cMXPnEQ/bII0ZyqM=;
 b=MN7huTdOIAdLjsF9GcN+Os49IeKPo2xaco7foxeaKL+thWUk5k3PIGy5wQQxGYF/E8
 ghJeq7wQPx8Cxqs0zOAslTNJJAsJU+gysAqBH3mn7TmQubAIApBp8J4b3NpyM067+GT5
 3uAbvq+eghMtSbRKf63wOsrjD0YcbVfXU1WCcaU1b/fEPKAab+xHrY0Kv61h7BdB1kWN
 B1lCrzkve/KYzPvA5s+XckO0xjrv8V+gLS60vuIkM+1Uq85nAvYLSAjzkiovOzqlDDgf
 LUS2cWodHSy1vqUOhoZAYFRYEor0wt5a2l0V0bEiQF2WrSP+VBmQqU647xCYwLHHuQkz
 hedg==
X-Gm-Message-State: AOJu0YyauIhKvMHu3m5sCRMHUt8vyb66ertSPvDGNf4M0OUejOVNCWcv
 yZGojeMVWF/aD5N72QVzyGTVuJN48BY2dyfgD+ZRsGzS1JpYd0HIub86AO6J17lyrN9W4C8XzFb
 omhILtD7ptv6lOEn0T1meVwtwtzWLnIGB6KqLCVfp7KVj4V26sUfElukN5na0lIPcSiQ24RFnQh
 UZquol8xDrV1WMWIvvNgo=
X-Gm-Gg: ASbGnctJjoTlRIB5xsQp2nL7sd878MdWgjUPR61mNGZIHG1bsFUBIQpPoTxVKjsqPrF
 1tNm891Rec2WNWyIuK45pVjSt4LD/u66f0g6ytPd5919/GnxCEG6JzPXl/3poJ0Q+GltTut0Ub4
 TWc1GCCQ==
X-Received: by 2002:a05:6512:239d:b0:553:268e:5018 with SMTP id
 2adb3069b0e04-553e3be91c3mr4196673e87.31.1750697107554; 
 Mon, 23 Jun 2025 09:45:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFavR0xd6Jbf0AYremXH8k/AhEbnQt8K/Zx7boSn8OimHrlgsurrXxyfzoS88UukwzNleExrMO+P11jwl2qtcE=
X-Received: by 2002:a05:6512:239d:b0:553:268e:5018 with SMTP id
 2adb3069b0e04-553e3be91c3mr4196661e87.31.1750697107108; Mon, 23 Jun 2025
 09:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250527152913.279011-1-bruce.richardson@intel.com>
 <20250527152913.279011-2-bruce.richardson@intel.com>
 <CAJFAV8zpV=KUDha1tknK0cgv0cboG0htvJZ1kujtx=EJ7hXQHw@mail.gmail.com>
 <aFl8-3IuF9WU_YAe@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aFl8-3IuF9WU_YAe@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 23 Jun 2025 18:44:55 +0200
X-Gm-Features: AX0GCFvZ7QN_1zJQORdffjLZPWere1vwJ6Sdwb32Wz_gDpm4hHRijUpSA_wDmdM
Message-ID: <CAJFAV8wTVaEpA4whNtEXbrEpD1Kvny4oNZ_di=-maF+4A+tRuA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] eal: deprecate old coremask-based EAL parameters
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -5_U0Gk96PwHKdNuQNiCvh9JxRYCiMpuDjHSkmR2iYk_1750697108
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

On Mon, Jun 23, 2025 at 6:13=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
> > This patch will need some rebase.
> >
> > I see you fixed a few docs, but there are quite some misses in
> > copy/pasted blocks:
> >
> I'll take a look and respin this.
>
> I'm think of separating it into two patches: first patch with the doc
> updates to remove use of -c flag. This should happen independent of the
> deprecation, I think, and second patch just the deprecation notice. Does
> that sound reasonable?

Yes, we can already cleanup the docs (advertising lists instead of
mask), and then have the deprecation notice.


--=20
David Marchand

