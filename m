Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FAAE9A02C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 17:01:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB07D40269;
	Wed, 18 Feb 2026 18:01:29 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id ABC5E4014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 18:01:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771434088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ok03nz9AU8HCByybyZuJ4iNGK8idYF2gRpAEWx7MSgw=;
 b=OeHS7HdoMf4Tjmd10tEJIE0k09ZAcEQlnaj4m7PGw5CAu2/uTUWTpirStCwemSLarZeHCQ
 Onj4lUAgxwqYtJH74b8X7kkeAv7BHv/SEBLF0FrDOMDzAko4kKw9Kie2W1UdapkCMs6IgW
 ZFyob6usTFtyciX5plZIQPhxIV3cmec=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-K9kgg3y1MiehAtClWd_KaA-1; Wed, 18 Feb 2026 12:01:26 -0500
X-MC-Unique: K9kgg3y1MiehAtClWd_KaA-1
X-Mimecast-MFC-AGG-ID: K9kgg3y1MiehAtClWd_KaA_1771434085
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-59f7319ff3fso57042e87.3
 for <dev@dpdk.org>; Wed, 18 Feb 2026 09:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771434085; x=1772038885;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ok03nz9AU8HCByybyZuJ4iNGK8idYF2gRpAEWx7MSgw=;
 b=MQNvMIrywj3oXRtuW7aDPk04KxmjzToCpdScMOmdIfBTaUyks8aZO5EODcmZ8tILkC
 sSfwCYZeYPxdIxs28VlR+DfVMqw1fTm2kY3YnBjl+G8aVvn5m5AoPoy/VXdaO1U3Ae2b
 NscmE5gpKp1Y+6YK061tqVKJes0ZnTqQdGOhOpI/9kHv0wWPx/bwFXhwJCgbaBRECAZI
 hVtcUJQRQNLL6x0ohcYxf9qGq6IbPNbNhPhxvPRLaXUrUYXNdStQPEYDWn7v30IiXqIF
 LJXNWRwtJS2NOJwOGz4TnVHka5pyq/Fn+xTXqZ9EvpsJeN8G9YOrjaia5rRBcriilRKG
 z8Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/OylVE3M1Qzu52zEgm3XZigxR1biJGYWCFXOUzuHebrKQERMapXw8Ke5gzf9pt62HJOM=@dpdk.org
X-Gm-Message-State: AOJu0YxvjQhDAAWzR+qhhn7hOnXsbdN/tjarq4vTNh7VEnjgwdQqiiPX
 7MMntNXly+P6VGJBU9CUtEkWGiVTPPSwgSNK25Z6CAklhMdb0Nmj8suHTdoA/RcB5JJOxKLFMLx
 qwETw8GlP4N7wnifUBluEJLv0hZ/IhzMuoj2IrXiQm6qaOMMjo1tGGRoHbT+GSO+7QKkDVhdCU6
 FQl5MopgQt1U8EomaDUAc=
X-Gm-Gg: AZuq6aLv+1GlqNjY7af3nzWUT055jwzZ+cZ0yR+f3i/GFlLHyBswU1nngp/0URNTOn7
 VTVhyTe2I4cMQe8UKdWQw44j7H7UQhjveePzJekXMb/5NQ2b7nFiOq9cFiDSYXuwGnyFYX0paXD
 yB4ttv/3Qpp8xxsabW2xnydlefTsoNErPuYHOQSmSE+lre0jH9564QWuFaGPokC9rueETeJszQt
 A72/HMsldhgGESU/1IWzVGOJwfJIPm7rlY5hdSOnB3Qv5sYI5vCswrHxAs6olCVsGt0Aw==
X-Received: by 2002:a05:6512:acb:b0:59f:851d:fc29 with SMTP id
 2adb3069b0e04-59f8974aad0mr18080e87.2.1771434084215; 
 Wed, 18 Feb 2026 09:01:24 -0800 (PST)
X-Received: by 2002:a05:6512:acb:b0:59f:851d:fc29 with SMTP id
 2adb3069b0e04-59f8974aad0mr18069e87.2.1771434083508; Wed, 18 Feb 2026
 09:01:23 -0800 (PST)
MIME-Version: 1.0
References: <20260218160453.142311-1-maxime@leroys.fr>
 <20260218160453.142311-12-maxime@leroys.fr>
In-Reply-To: <20260218160453.142311-12-maxime@leroys.fr>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 18 Feb 2026 18:01:12 +0100
X-Gm-Features: AaiRm50xUKItWz1dNypjOO7xi0QPwORmPcHJD9Ix370w1gtbykQ71EVMOXl8Fp8
Message-ID: <CAJFAV8yNUdZRfxcHG3uGtS=7hW32JOxwyseetC7J6gBnMYB0vg@mail.gmail.com>
Subject: Re: [PATCH 11/11] bus/fslmc: remove dead blocklist check in plug path
To: Maxime Leroy <maxime@leroys.fr>
Cc: hemant.agrawal@nxp.com, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R-a9LqWIJIm5qSmjEzsmvflR30qzofUw8TWMyjag4Wc_1771434085
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

On Wed, 18 Feb 2026 at 17:06, Maxime Leroy <maxime@leroys.fr> wrote:
>
> The plug callback is only reached via rte_dev_probe() which adds the
> device to the EAL devargs list with RTE_DEV_ALLOWED policy. There is
> no way to reach fslmc_bus_plug() with a blocked device, making the
> blocklist check dead code.
>
> Remove it.
>
> Fixes: b5721f271cbf ("bus/fslmc: support DPNI hotplug")
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>

Checking for RTE_DEV_BLOCKED does not seem needed as the scanning part
will affect this bus device list first.
The strange thing is that it is probably consistent with other buses...

The scan/probe code would need some cleanup / consolidation on the EAL
side, but that's a separate topic.

Overall, this change does not seem wrong, my only concern is
disaligning with other buses.


-- 
David Marchand

