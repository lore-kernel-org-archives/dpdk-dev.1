Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85488C531C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 08:56:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B27DC4028A;
	Thu, 23 Jul 2026 10:56:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A5A124027C
 for <dev@dpdk.org>; Thu, 23 Jul 2026 10:56:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784796961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H42xYyLbPccQl5pDkga/JlPBKG8AY3mrY/WFGy1TQ6s=;
 b=THUY1uwR4Q9/LpnQXvL5LFbFNOeQKUFhmDNQBmaoa9Ordj1fMgwIlA59drPvRX1EFCkv2+
 zi/FtZxfoyosf+7h0h87Wuzy6b8WkvCf1gyKVK4vhz8bRFQ50UWD9p3WpSm20cD+i7/toP
 n+uNsklki6OpNcbmW2wHVwAGFXCVHpw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-hX8EEwKGPiiXrieUAMS_6g-1; Thu, 23 Jul 2026 04:54:09 -0400
X-MC-Unique: hX8EEwKGPiiXrieUAMS_6g-1
X-Mimecast-MFC-AGG-ID: hX8EEwKGPiiXrieUAMS_6g_1784796848
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5b29e7e8ab6so144810e87.0
 for <dev@dpdk.org>; Thu, 23 Jul 2026 01:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784796848; x=1785401648;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=H42xYyLbPccQl5pDkga/JlPBKG8AY3mrY/WFGy1TQ6s=;
 b=GQPCTUwUk84Q8jvxFEdn42SR1kLkgWg0TZpq1epAd+grnM1l0oKGQipd/ktiRgC9DG
 EdXZdk40NchAef6NhuboBmS1qt4KeXsXwgqQfb6RIvnm9BZ94aZIpmVFwDlI+AS9uA0q
 TA27c6Rk/kApU2G0ooXDArD0AL2EGU0QsX20qKS4WEITSGcAOgdudtvqc4P1U4QyvOYH
 3Og6VTFzA7F2WVhWvuFKStmGFWp5ehh3aAwOOWbKnAK79OUjIZb2FHz68r3Z23Vz8hju
 dp69TLnWiVtP8Fd4KSHaFgGM0oqq9YrO3MQhZuoehus2FVjpVDudvPXBkr0h5ohiGAU0
 9QIA==
X-Gm-Message-State: AOJu0Yy7DPnWuxovfQZVOzwm7ysvCYIOBVniqx2/+qmRx8fWEQx0EdUb
 N9cmrWb2zn12Jl/uHAUcdto4cu4zRAS2pUYnzF230X3Wq5MdFsCPkU+uDBGD8MweZ+Vs4LYChBH
 4jiSVFUjDoAWVDaFb+VU/KSfpIKiRJWxeTjDK36ErPTUU9x48SP+QeAHB+dYEUW7ml7X1Qt6pt/
 FaMIDCgiuCSM4g0S74vZ0=
X-Gm-Gg: AR+sD12IOG8ER/E/6Ddbe4m5swzs5Hcrwfga0wQV16Fqjb8MVj20KlsYFQbH+s/WVk4
 u30vfIgfhUDUAC5Yq2DCEohgvM/CXQYrNaZ3J+mbw99GquPlTldZlIrSWGJyuJ0nE56SW6pQoPA
 IPvHxwNTnU1kBh4E0lN8R7i/dPOKZV6cwEoFYdCf5H0NMlL6Ipo6iI5JHGIOHenh3zkLHXVG0VT
 VgSLxJ7DzbDcD3dqyxza1NTUT7h7hzBCoKFyhhxnK5LcfI8
X-Received: by 2002:a05:6512:130c:b0:5ae:badc:47d3 with SMTP id
 2adb3069b0e04-5b2b33cde03mr391331e87.28.1784796847985; 
 Thu, 23 Jul 2026 01:54:07 -0700 (PDT)
X-Received: by 2002:a05:6512:130c:b0:5ae:badc:47d3 with SMTP id
 2adb3069b0e04-5b2b33cde03mr391317e87.28.1784796847472; Thu, 23 Jul 2026
 01:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260723062416.1340761-1-david.marchand@redhat.com>
 <20260723081206.2105269-1-david.marchand@redhat.com>
 <amHUoLNaaNfm_Na_@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <amHUoLNaaNfm_Na_@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 23 Jul 2026 10:53:55 +0200
X-Gm-Features: AUfX_my3dw8D-wApSD4uT9Ki8hW73juo9Ar6F4h6IOa1jQ1w16sr80HxF3nluXw
Message-ID: <CAJFAV8yO4M=bZT18dCjyk2VxoFPQCE=uynkWiSm_59MFmdAnOQ@mail.gmail.com>
Subject: Re: [PATCH v2] version: 26.11.0-rc0
To: David Marchand <david.marchand@redhat.com>, ci@dpdk.org
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Aaron Conole <aconole@redhat.com>, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Bruce Richardson <bruce.richardson@intel.com>, dpdklab <dpdklab@iol.unh.edu>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sbgshmSGwMVNmdoxPl2rGIclLGVEd_5P8wpBhd7LVX0_1784796848
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 23 Jul 2026 at 10:45, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Thu, Jul 23, 2026 at 10:12:05AM +0200, David Marchand wrote:
> > Start a new release cycle with empty release notes.
> >
> > The ABI version becomes 27.0.
> > The ABI exceptions are dropped and CI ABI checks are disabled because
> > compatibility is not preserved.
> >
> > Note: we need to bump the version for symbol compat in ethdev and net/mlx5
> > temporarily. Next commits will drop this compat entirely.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > Acked-by: Thomas Monjalon <thomas@monjalon.net>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.

Heads up to CI: ABI checks must be disabled during v26.11 release.


-- 
David Marchand

