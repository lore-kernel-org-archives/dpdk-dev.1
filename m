Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04633E9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:45:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F93540269;
	Wed, 18 Feb 2026 17:45:55 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B94724014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:45:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771433153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YeOwIzEUpHCM2V0MsXq/NIp7Y1xO8eYgz+shPTV1zWE=;
 b=ORdb51et1r0Jg6n4ka+CVOAJiglAxLxrE5YHiIFNQvrHHIft9TrOwFS4U1ivkeHF5LE1wU
 tevDbvSo7G1dl1aBmbIJJTRIhr67BiP8B/nras1eLB42BAzuHD6Q6YsLV0Pd81xAwrNbKX
 te4ToJI93B7DD0qTjlrCi1Itgze6zxs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-3XhTD-koPquwZ4Dd7C46qA-1; Wed, 18 Feb 2026 11:45:52 -0500
X-MC-Unique: 3XhTD-koPquwZ4Dd7C46qA-1
X-Mimecast-MFC-AGG-ID: 3XhTD-koPquwZ4Dd7C46qA_1771433150
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3884fe7ace1so315151fa.1
 for <dev@dpdk.org>; Wed, 18 Feb 2026 08:45:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771433150; x=1772037950;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YeOwIzEUpHCM2V0MsXq/NIp7Y1xO8eYgz+shPTV1zWE=;
 b=JlQXFiIXI9DICrDDMZm5YpzR9484uMwobwW3vRTyvXmdM05tOd3pww1TKZQTF9Ws8K
 JndVuCWq4QXUQZUHYJmDEtJYWDyP/Nx3XEntYmE5WJZroY7XsWS5JK1+rKRg0a1LrMMz
 RJ0EAR0bftGMOsQd1UOYZNAxLe7oGtDza1FHLgxSAEwsioEYQtlLUcj6cCITWDBLw0R2
 qbpDNFlhv3Yz9mv8mc/DWgqQ/C2xbmtsZIHme6yIL0Qh6TmsOZnNuk/hmb1Kt5Oe9ijZ
 9hl4C1VpFpNyOk3fwWrq77g1XG9yiS82WXYT6NrOyXoS82sVbe9KTJFOBuvWM1rX1nbw
 NsHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQiIzCM6JHAzEiCtesBzUG6FvdDywzxTkZWUKivQy04QDiF+6X9pZ5V8QIT3EEsFS035Q=@dpdk.org
X-Gm-Message-State: AOJu0YyMStDP58MuhWTAaNF/QdGKQokWTxPS4HYUuS61gKdlEaPxuVkF
 KWBq2s/nyIbQ4HGbkOXavbAUSu/T+z9f2QuvUxtLW0WmieAbH+l2sJmJUl6ppYMtmPRjSxRiiHc
 /H9mFdzeT2Dop4YI6bMIANBHwLH2ls9SRZ2bILwSmJxQ9hkuxLhWEjrPcH2kzekDlJfLbxR6eOR
 48LlzZv3HkMIAZHmPDFHM=
X-Gm-Gg: AZuq6aJp4Xastl0eMkvmjW6UgWShntcjWTQz0ztgx+R7iNfBn4wVixdaeI/NRRO6QuQ
 mujeUcCEHmSDWLznx8MJRPuoonXjHO86x5wgmejU/xhqRjGy5bTvElOa3TTNaNg5LnM7+9PhhtO
 9CV4X/FUDZksfzBQnE7dlBtWW8XeZ0mzATPdYG2D0Ay3RrxndykOI1eSkBYWUeGtNQW/noqH2FU
 YfFBO8hhlzZG31u98mVzKlcX7NOtOeSt9BU8E7Lx7/1crUMA8hcnlQ2tBpU4QOQ3/sEJA==
X-Received: by 2002:a2e:a99d:0:b0:387:1337:8c00 with SMTP id
 38308e7fff4ca-3881b8b31c2mr44806621fa.4.1771433149617; 
 Wed, 18 Feb 2026 08:45:49 -0800 (PST)
X-Received: by 2002:a2e:a99d:0:b0:387:1337:8c00 with SMTP id
 38308e7fff4ca-3881b8b31c2mr44806571fa.4.1771433149186; Wed, 18 Feb 2026
 08:45:49 -0800 (PST)
MIME-Version: 1.0
References: <20260218160453.142311-1-maxime@leroys.fr>
 <20260218160453.142311-11-maxime@leroys.fr>
In-Reply-To: <20260218160453.142311-11-maxime@leroys.fr>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 18 Feb 2026 17:45:36 +0100
X-Gm-Features: AaiRm53tgiq0YGs9L7z93LrNAfJhGg_JF7ph660Kqy-xl0BN5N1Lcc7wfFtbxo0
Message-ID: <CAJFAV8z=CfhvELVRPJMteB+LwTwET7ZdaOuA9eyL3OaVGmPMjQ@mail.gmail.com>
Subject: Re: [PATCH 10/11] bus/fslmc: fix devargs not propagated on hotplug
To: Maxime Leroy <maxime@leroys.fr>
Cc: hemant.agrawal@nxp.com, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QH-AzdKnLAF31dtE01g1AfUYczr6rLFeqy2RpDluZzU_1771433150
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
> When a device is hotplugged via rte_dev_probe(), the EAL adds the
> devargs to its global list before calling the bus plug callback.
> However, fslmc_bus_plug() never refreshes dev->device.devargs from
> the EAL list -- it was only set during the initial bus scan.
>
> As a result, PMD-specific devargs (e.g. drv_no_taildrop) passed
> through rte_dev_probe() are silently ignored by the driver.
>
> Refresh devargs from the EAL list in fslmc_bus_plug() before probing,
> the same way it is done during the initial bus scan.
>
> Fixes: b5721f271cbf ("bus/fslmc: support DPNI hotplug")
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> ---
>  drivers/bus/fslmc/fslmc_bus.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
> index abdb0ad50d..a539753649 100644
> --- a/drivers/bus/fslmc/fslmc_bus.c
> +++ b/drivers/bus/fslmc/fslmc_bus.c
> @@ -596,6 +596,11 @@ fslmc_bus_plug(struct rte_device *rte_dev)
>                         struct rte_dpaa2_device, device);
>         struct rte_dpaa2_driver *drv;
>
> +       /* Refresh devargs from the EAL devargs list, as they may
> +        * have been added after the initial bus scan (e.g. hotplug).
> +        */
> +       dev->device.devargs = fslmc_devargs_lookup(dev);
> +
>         TAILQ_FOREACH(drv, &rte_fslmc_bus.driver_list, next) {
>                 ret = rte_fslmc_match(drv, dev);
>                 if (ret)

This looks like a strange location for a fix.

The hotplug path calls this bus ->scan() which is supposed to refresh
the devices.
Could you double check if something is wrong on this side?


-- 
David Marchand

