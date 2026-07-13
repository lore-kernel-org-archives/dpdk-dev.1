Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D08C44507
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 12:46:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6498E40276;
	Mon, 13 Jul 2026 14:46:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D1FEE40041
 for <dev@dpdk.org>; Mon, 13 Jul 2026 14:46:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783946808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8MEdnP5OG46UqfMwvxvNwOyhxNzeE/ZQV4crOHf+vRs=;
 b=P9PivTyOA4yomfUn4gt2QWyGFQeRmzLmGEmrWsA28NZwVtrAMqEreyX63ibr3b8Mt9E/WZ
 Xqwd4HW6LzNxaeUC2gbDrVp5eWlMk5pdWa7Is6BhXBpMokhhyHAcvUZ8IgICcfRj25jKy+
 wAxA89yXMfBfFwVA6oMJ+uhMBpFNqVw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-MgRHySaWOUeNNRe_xF-nuA-1; Mon, 13 Jul 2026 08:46:46 -0400
X-MC-Unique: MgRHySaWOUeNNRe_xF-nuA-1
X-Mimecast-MFC-AGG-ID: MgRHySaWOUeNNRe_xF-nuA_1783946805
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-39ad467f184so16707671fa.2
 for <dev@dpdk.org>; Mon, 13 Jul 2026 05:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783946805; x=1784551605;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8MEdnP5OG46UqfMwvxvNwOyhxNzeE/ZQV4crOHf+vRs=;
 b=lzPys5tAmzEFCBUBJqmncgX9KnabOjXepjoSuLYnussVhXPdmE5soF+OoPD1y+QYdc
 iAbVmU0mH7hKjqgdhcUl9vrp0n3m2eKdVOCqVZOO3isxdvvrIFBQVML1creV7PnNnLCW
 TX4W3f5G9CsvgRi6Ej8M5y8iqoj95TElMNoDDikA1IDcCv0fYawh7dJSyTj1Zse9xO7t
 W+e+E6Z0yKkRngYi09QhHjBitAw6mBLcfC3fqzggbKdsy/O//h7GXs3VZDqTnahqrjba
 SIGLa5phhAGWd00OkQZpYhRPgyv14khjk2SMPIk+FHvI8sqXiLwdBmifgFqD1tKNrD+b
 uxKg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQ7KY4NxHFte7V28i+h0oo9pJTDKS++4d0DiQo6LtObL1mX3krIS30Wwpw717YcO2yjiA=@dpdk.org
X-Gm-Message-State: AOJu0YwHNgzpJC6hY1SiJcRqRQvce4HUaM33H1NkGOWBjL071yk8J0Zy
 CNP2Ep7dCApYhqHxNcQh46dty/kl7tD9DxTI6F8KX+pXrD02LbO9t8YJLmzZe2Me/wqkFONuOVh
 5mjv+w7xJGpXQhVqj40JtYzE85fubzI0JeG5InWdhr/Y/12XF9LGHjuTfg1mWwJT8Aqa6/r8xM+
 vObi9fZK1jQTK0FuiXye8=
X-Gm-Gg: AfdE7ckvUHbyDqYckkjugVD4x3YbrpalozDfPwFmX+RE/SA+LW8X4ZmMcSBYfQtd2T/
 j8hDFRIjEHtMVcmfTaWz8s2khaGhRQLBKlmO0rBO3VLYXHi0+UvFNF9ML0CccbDPvWrzmlPivAU
 r/gxWHyZwCxJupWXO6YvWhXmQJg4MxmJI25dSeCUKEpIr/SmmUI2nxyBzQdXSgNC+4XMjOQ4cU+
 N8BJsABQVo/qeNHl+OZJheSWUwLr+RlnOQ5HHkNqYgIPEguS5RT7LaOJw4=
X-Received: by 2002:a05:6512:3b90:b0:5ae:be47:f006 with SMTP id
 2adb3069b0e04-5b0236b397fmr2206395e87.43.1783946805119; 
 Mon, 13 Jul 2026 05:46:45 -0700 (PDT)
X-Received: by 2002:a05:6512:3b90:b0:5ae:be47:f006 with SMTP id
 2adb3069b0e04-5b0236b397fmr2206388e87.43.1783946804735; Mon, 13 Jul 2026
 05:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260625133311.1299705-1-dsosnowski@nvidia.com>
 <20260625160645.1341914-1-dsosnowski@nvidia.com>
 <CAJFAV8zwKcABUr5kWV429+k_r=Wr=eSkGTLDymogtysobXMAwQ@mail.gmail.com>
 <PH0PR12MB70779D26817E22DC927E8860A4FA2@PH0PR12MB7077.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB70779D26817E22DC927E8860A4FA2@PH0PR12MB7077.namprd12.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 13 Jul 2026 14:46:32 +0200
X-Gm-Features: AVVi8Cf1EWb_hhQb8xARSUrZWXg-ROV21jkipcWD0xM_6ZFj1TTypcMucpnO2HM
Message-ID: <CAJFAV8wsW_m15GW8=+z2o0Jw2BRYLbcuEc-55=qGhMJv_h7TRg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] add versioned symbols for recently stabilized APIs
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, 
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, 
 Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Yu Jiang <yux.jiang@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b7koEFl_cV2DcYC86RuQF1oVH6zopT5z8D3NkvXyVTI_1783946805
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

On Mon, 13 Jul 2026 at 13:05, Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
> > LGTM.
> > Series applied, thanks Dariusz.
> >
> > Please send the patch to drop this compat in 26.11.
>
> Patches for dropping these compatibility aliases are on the mailing list:
>
> - https://patches.dpdk.org/project/dpdk/patch/20260713105935.24152-1-dsosnowski@nvidia.com/
> - https://patches.dpdk.org/project/dpdk/patch/20260713110101.24218-1-dsosnowski@nvidia.com/

Thank you.
Those lgtm, I delegated them to me, and marked as deferred.

I'll take them with rc0.


-- 
David Marchand

