Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21480F3092C
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 12:23:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BAE8402CC;
	Thu,  5 Mar 2026 13:23:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B29BC4029D
 for <dev@dpdk.org>; Thu,  5 Mar 2026 13:23:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772713422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iQ70QQSNgeoeXXWgUrbNR4bOVAGUZWboodciC/B0tyA=;
 b=Vt7VZ1I/u5ROi+4J/JkLNHEVqHTd7uJXKDwoVRiI1yEm6+26XIW6f/8XJpIJ+IV+LHAloP
 UcxWThWc1aKtqxqpyPDL2pKyiTUP4aob1fmf3dGTqfnJ1m2wYCJi8w9iM4jNmbTJabogdT
 gQ15fOD9OHWWThVRmC5a/rHdE6Yt9Gw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-J3eygRtzOpq2qKsojYmvug-1; Thu, 05 Mar 2026 07:23:41 -0500
X-MC-Unique: J3eygRtzOpq2qKsojYmvug-1
X-Mimecast-MFC-AGG-ID: J3eygRtzOpq2qKsojYmvug_1772713419
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5a12e8e6767so384689e87.1
 for <dev@dpdk.org>; Thu, 05 Mar 2026 04:23:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772713419; x=1773318219;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQ70QQSNgeoeXXWgUrbNR4bOVAGUZWboodciC/B0tyA=;
 b=SjlmtfgQ4cRXenqqnTA2wCjIWuj2YY4Xme0uy+wDlW7x0TtNr3nDvU3sS1X1ok0hgz
 tZgUp9zglE04s6SfdXqqQgBluJ8nElKEQG6n/jr4qVY18SrzZtsQ/IJM/GBoR6G901kP
 ObvYmT+t8jFhQqtK9eRrPJ756trZsqljHOYf2EdxFgnP09jG3HGmGbIM1Pp2s9x8l8QL
 5D5eVP81AdHXb+kh3Z7xdJtWN/TI4u+2UqoaV6z61+Koh8I0yyjdJj/LbWbQUsgj9j9x
 2IZXcRHKTdyov8F8AlumhUEDK21CX1w8RS8twAV6Lo7QoDpXhU36MFQtce2QZUjzM3iD
 wMww==
X-Gm-Message-State: AOJu0YzIhWsY+l35XsBdRTW39yfec1bwlMK+G+BmxyBQdcXdhSFvANgj
 vkdG2cakQikVFC14l+MlNoyFZwoHxMCUwQg3M9+kWaIdsiSgkRw7lX/LTouxCLNCAATN0icvG51
 arZh3o4tP14zEU55mCZfQFOvNI8buep/sY+wDIo/FoF9qzg8kSi9nrbHm2/FBmbQ3rf75nx8vSy
 kthmSR0XE1lsBNSvyhaOU=
X-Gm-Gg: ATEYQzxUDhX5t6sHYaAGoDC55Xmbc/x5AC8bCdL2UzgiTrRTFqqjZFBPmDKOXYMR6nO
 K+FaPe+FUd+3o0PGFuSPdaESgqRQW+Kn6uU/JLXayWVOequ3ChQvAbEuDCZNFjkGNvHdfVhAZso
 3Cphxbze4MkHtQsR/X3KQIL79hfrM3QutBOu/2S1R+Fu3arojoeXAnkMvthhKWVy2vGsgs6WguM
 E1EAQ1DR4w8Lyct+ppHZEh0TGARxQj9agB18JZl59iewtKID8tW/E/hIGazLpDVuv+WFg==
X-Received: by 2002:a05:6512:1088:b0:5a1:1640:d366 with SMTP id
 2adb3069b0e04-5a131f249dbmr757160e87.19.1772713419387; 
 Thu, 05 Mar 2026 04:23:39 -0800 (PST)
X-Received: by 2002:a05:6512:1088:b0:5a1:1640:d366 with SMTP id
 2adb3069b0e04-5a131f249dbmr757155e87.19.1772713418901; Thu, 05 Mar 2026
 04:23:38 -0800 (PST)
MIME-Version: 1.0
References: <20260218101859.3028581-1-david.marchand@redhat.com>
In-Reply-To: <20260218101859.3028581-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 5 Mar 2026 13:23:27 +0100
X-Gm-Features: AaiRm504Sju4KAUNXDVztLCiX9NXB-h4AxdubueUqKBMQGvDI5ZU3itxVm7Fmro
Message-ID: <CAJFAV8xoT+rV3J1JR_zy0hCQhM6cW6J50dcd1s=LBft1qrdMKA@mail.gmail.com>
Subject: Re: [PATCH] eal/linux: fix HPET symbols export
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vsa5joYQQ1czEnk9ny4sxylx833bjwjpqQPds3XsjRg_1772713419
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

On Wed, 18 Feb 2026 at 11:19, David Marchand <david.marchand@redhat.com> wrote:
>
> The .map generation script has no clue about build configuration as it
> relies only on the presence of RTE_EXPORT* and RTE_VERSION* markers in
> a source file.
>
> As a consequence, Linux eal_exports.map contains references to
> HPET symbols regardless of the use_hpet meson option value.
>
> $ meson configure build -Duse_hpet=false
> $ ninja -C build
> ...
> $ grep hpet build/lib/eal_exports.map
>         rte_eal_hpet_init;
>         rte_get_hpet_cycles;
>         rte_get_hpet_hz;
>
> As far as I have seen, superfluous exports have no impact on generating
> a shared library with the GNU linker, yet it might be different with
> other linkers (MSVC linker would complain, for example).
>
> Moving those symbols to a dedicated source file solves this (non?) issue.
>
> Fixes: 57c194d142d9 ("build: use dynamically generated version maps")
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>

Applied, thanks.


-- 
David Marchand

