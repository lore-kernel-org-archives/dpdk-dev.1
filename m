Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78E9CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 06:52:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB15B4021F;
	Tue, 23 Sep 2025 08:52:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9465F40144
 for <dev@dpdk.org>; Tue, 23 Sep 2025 08:52:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758610354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eca7EVwSZ9v1kUs1RjmcYa0+PbWEGgRGVHF8RUhrqm8=;
 b=MKvTcSqJDMhXxBdsUYtbt9I8oBDUvEQqgsFaGDFbJ1kR0runDYuzxlITkQsupGwUvC4qrH
 pDgzuI2MX5NCNhKbyttmHvPrDO4IJeh3d7lWyPgxmPbeWkk3R6LgPB4VRKyXw1zF/EdGIG
 nitVf6jTYwhYgUQrD0Ln79VDBduw5GY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-x7t0nsKtO_aTYvrX5gaueA-1; Tue, 23 Sep 2025 02:52:32 -0400
X-MC-Unique: x7t0nsKtO_aTYvrX5gaueA-1
X-Mimecast-MFC-AGG-ID: x7t0nsKtO_aTYvrX5gaueA_1758610351
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-36412b9b157so29833641fa.3
 for <dev@dpdk.org>; Mon, 22 Sep 2025 23:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758610351; x=1759215151;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Eca7EVwSZ9v1kUs1RjmcYa0+PbWEGgRGVHF8RUhrqm8=;
 b=RriVDarOGg8CF0cOd59UigV5gHFt53wJYz36sB/NJxObSA1n7lxHYHRO5/qI/79P3l
 Olkns+sHTBp9DgdEUZ4WT7wfBJYfdC67ymUib0k4lCN7t2d6FPLg6BFDPV/ptX5o8U6+
 jOzPPOjKia+BvHw8ifetW3Gb4zb180FpvvWCylHCOTIndUjfZunK85x+fj8yFX3SNcUD
 4Yb5wQTVjXoJtgOg8R89UDV0HHeHQ2cln1s0CViFaOCayVuCZEu7SX8n7cRAArx0HSXk
 EqRHl7SA4M/5IUu8zIQzRQgVLIC9s3JBTwOZQEqR4WP5ZXTORrWk2CqspPUuXArd4A6f
 aPEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNw/i37XpzRy0iLD5bgJI8A1SFGtQEI230oc1VIZNP+yL/5XEa8BdItoXDbhxD8INk0Ro=@dpdk.org
X-Gm-Message-State: AOJu0YwC9RZDmPDLydOWsAmzoIfmNjDu2QzkDYNQMdmsrHIvmJDhUWZ1
 gEfvspz1d4RsHPpYQb0o7lfPZE5e3lQhXwHvidrli8R0OTL/GblRV/AWeo/BruzyNppkLz7m05h
 saK/tBrE8P/mdyM2Gy3PdzGukTB+aS4KWpf3AxdF50kvYWLwRswVGAg8tgCAPc2VtUEcT4ilec6
 opt7C7ft2LCiuJCHVEATM=
X-Gm-Gg: ASbGnct4UXH+htPpUJpB7HJkDdnAzbAzfZ8LSTeOYnqhQsyulqt75Uf8IRbMQSlGUDV
 6GXkZQIqlLMnMz/8zD7VL2UI58TY2kGhbtB52wjiFQyE5TLGJiXcmxPNBENKR8Db0Vc1cBCvSAz
 pw+0y3Ez4+6ud6ZTID1UaNccY=
X-Received: by 2002:a05:6512:b28:b0:55f:6cec:2890 with SMTP id
 2adb3069b0e04-58073702892mr452469e87.38.1758610350709; 
 Mon, 22 Sep 2025 23:52:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElC9MczAX6Eux7B2cFONPl6vqdoDwYJ5rx5XuGy27ZmZ45dpjeyJijK60knEHI/n+dqOsLaBdrjQH9a3jK1w4=
X-Received: by 2002:a05:6512:b28:b0:55f:6cec:2890 with SMTP id
 2adb3069b0e04-58073702892mr452459e87.38.1758610350278; Mon, 22 Sep 2025
 23:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250919145125.113028-1-venkatesh.vemula@intel.com>
 <CAJFAV8wK8G_Y+-PTLm1J4Z9g9+5WKSGMGr=1jBrd10kqt0CLVw@mail.gmail.com>
 <a1edf69a-33ee-41de-b7d3-24f0894734c6@intel.com>
In-Reply-To: <a1edf69a-33ee-41de-b7d3-24f0894734c6@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 23 Sep 2025 08:52:18 +0200
X-Gm-Features: AS18NWCvwVpA0MM9q6nPyx2CcqpzFnRZMbQ6y0LRz8Xo9g5Qxt9d7HHGgnFJe1I
Message-ID: <CAJFAV8xazigsmtQ1OTcU7DyYFF5Z9oZ83n6zAST_qV6LTihBEQ@mail.gmail.com>
Subject: Re: [PATCH v1] net/idpf: add IDPF PCI class ID support
To: "Singh, Aman Deep" <aman.deep.singh@intel.com>
Cc: Vemula Venkatesh <venkatesh.vemula@intel.com>, dev@dpdk.org, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Shaiq Wani <shaiq.wani@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _uoEyVJIJeHS8KEuvjPeksKlMEHN3qiy4raMu3Bl7n0_1758610351
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

Hello,

On Mon, 22 Sept 2025 at 18:36, Singh, Aman Deep
<aman.deep.singh@intel.com> wrote:
> On Mon, 22 Sept 2025 at 08:35, Vemula Venkatesh
> <venkatesh.vemula@intel.com> wrote:
>
> diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
> index 5f3e4a4fcf..9d1d7dc47c 100644
> --- a/drivers/net/intel/idpf/idpf_common_device.h
> +++ b/drivers/net/intel/idpf/idpf_common_device.h
> @@ -44,6 +44,23 @@
>         (sizeof(struct virtchnl2_ptype) +                               \
>          (((p)->proto_id_count ? ((p)->proto_id_count - 1) : 0) * sizeof((p)->proto_id[0])))
>
> +/** Macro used to help building up tables of device IDs with PCI class */
> +#define RTE_PCI_CLASS(cls)          \
> +       .class_id = (cls),      \
> +       .vendor_id = RTE_PCI_ANY_ID,  \
> +       .device_id = RTE_PCI_ANY_ID,  \
> +       .subsystem_vendor_id = RTE_PCI_ANY_ID, \
> +       .subsystem_device_id = RTE_PCI_ANY_ID
>
> Don't define a macro with the RTE_PCI_ namespace in a driver.
>
> Either this is really specific to IDPF, and this should be renamed
> with a prefix reflecting this.
> This macro is a huge wildcard on a pci class, which seems very specific.
>
> Or this makes sense for other drivers and then this macro should be
> moved to the pci bus driver header.
>
> Yes David, it only applies to IDPF. As per PCI document-
>
>  https://members.pcisig.com/document/20113 Table: 1.3

I'll trust you, as I don't have access.

>
> Is it OK to rename it: IDPF_PCI_CLASS ?

Ok for me.
Thank you.


-- 
David Marchand

