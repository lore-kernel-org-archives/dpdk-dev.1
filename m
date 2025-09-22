Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBE3CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 12:09:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA50E402CB;
	Mon, 22 Sep 2025 14:09:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id CE0354025A
 for <dev@dpdk.org>; Mon, 22 Sep 2025 14:09:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758542963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1HOtlIuPrdua+jPRl1/RsRdCzfyUjy26RBQfbThs7O0=;
 b=gMZBIvptBJ/praw+JrrNjRANcun2z35ls5d+EVuhqCcMkm2n0T45tKcxcI0/HuDQkMDc2D
 9WNcM+nvrUAzR/rbPR1HRPRsAXqZd5f18+5HdLUb96ut6XPVN9/xqExFVaTf6w1U4UQq5/
 gfPHzl9tZhbmynR+TYxqJ/9+oB2vi7I=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-kiKh1MQSP7GDzssHzwJk1g-1; Mon, 22 Sep 2025 08:09:21 -0400
X-MC-Unique: kiKh1MQSP7GDzssHzwJk1g-1
X-Mimecast-MFC-AGG-ID: kiKh1MQSP7GDzssHzwJk1g_1758542960
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-35f62a3c170so27265281fa.0
 for <dev@dpdk.org>; Mon, 22 Sep 2025 05:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758542960; x=1759147760;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1HOtlIuPrdua+jPRl1/RsRdCzfyUjy26RBQfbThs7O0=;
 b=EmHLqKoJsaZS8Q3QRnikAUD7LDXGYTGxcD4AK+jmF3NShORY77iF9xwpx7Hei09IzT
 rIApfHU5BYhOD8y/yQzlOCqF26x5MjDMymIdjnoVSMms0Dd9Jqc4toWZsAbjRi1H7cM5
 blOph4cwPeL542lESC/XlYuHCPUJ2GwMK5sSv1QsmmlLgANv1f93avbJgm7HXV9n+UwL
 ZQmk7TZ5VkYmxFpUQwFfAWam4QV/QBTloxlhFwx1ugzouHW0phNzyGDzC3fTFt5fQbwb
 y2b9YbXs0LUSew8q89pjt0xQ3waEC10waxpUkcIZlNRDZxx6O77UQ4RpfisHbu11m5GQ
 FDRw==
X-Gm-Message-State: AOJu0Yy5XGg/6HeYqRMUHlr0vSAbudcS42BYlroV3G45hEvwNXT6sXrG
 LZ4nGBTz5jAFXsTxx8toWISC8jmt0eX0QaeqRPLMQ82UK+buExyLNuZiVc25nHguqZgMHoJghOA
 ti3hpNc2I89nagqbXbNTBasEwtQcohveiTf4yDQVScPCduudD4jX8I/UuiAq0g4sFxFzdBr26CK
 dfv++ddabj0JVIuPVFsHI=
X-Gm-Gg: ASbGncuOmRUoFKEZJPPmRpBWKJAfJfpbTeXGa1T1PQpDsdyV6WXFJ7VKaZ+kMe++PcB
 oCZmDC0PuRt+IPEm8i1cVVFVC/57lzqNhNAmxsYzLvOQvndfbcvdGVhrpKMXuRIc72KZ294Gn9Y
 AwvngobMy0TCDk32hL+QiFKcI=
X-Received: by 2002:a05:651c:4355:10b0:36c:173:148 with SMTP id
 38308e7fff4ca-36c01730368mr4941641fa.6.1758542960301; 
 Mon, 22 Sep 2025 05:09:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTUaOb48UJWGdcoZhTO2bZtCM0HnLeAKz7cq373Zeb7s4231Ffag16FA+BxQmtOP4tg/tbXMp+cL3ysaMkhBw=
X-Received: by 2002:a05:651c:4355:10b0:36c:173:148 with SMTP id
 38308e7fff4ca-36c01730368mr4941531fa.6.1758542959883; Mon, 22 Sep 2025
 05:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250919145125.113028-1-venkatesh.vemula@intel.com>
In-Reply-To: <20250919145125.113028-1-venkatesh.vemula@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 22 Sep 2025 14:09:07 +0200
X-Gm-Features: AS18NWAZ32IOL2vJv0nulcyGLxCdwzxGwLlFUNceMIt3SUVJrLdhyQujjGRC6Mo
Message-ID: <CAJFAV8wK8G_Y+-PTLm1J4Z9g9+5WKSGMGr=1jBrd10kqt0CLVw@mail.gmail.com>
Subject: Re: [PATCH v1] net/idpf: add IDPF PCI class ID support
To: Vemula Venkatesh <venkatesh.vemula@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Shaiq Wani <shaiq.wani@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PuOL2fmKBO90Xum_LAhaazlj4F3xySK0Y5Qz9GABBWY_1758542960
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

On Mon, 22 Sept 2025 at 08:35, Vemula Venkatesh
<venkatesh.vemula@intel.com> wrote:
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

Don't define a macro with the RTE_PCI_ namespace in a driver.

Either this is really specific to IDPF, and this should be renamed
with a prefix reflecting this.
This macro is a huge wildcard on a pci class, which seems very specific.

Or this makes sense for other drivers and then this macro should be
moved to the pci bus driver header.


-- 
David Marchand

