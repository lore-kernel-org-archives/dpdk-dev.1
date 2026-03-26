Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC77106F2EA
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 08:22:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 705B440E15;
	Thu, 26 Mar 2026 09:22:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 22BA7402F1
 for <dev@dpdk.org>; Thu, 26 Mar 2026 09:22:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774513374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sk1BMz06DXz8iUs+SKsUYXhp2pGOOYPHbttGlRGzpMQ=;
 b=QZGmjN3tW2KJOIneGDsGQ1GmDzRqP4OY37W7UHC3SOJFZq4dqw3ulaJG5r5zawUJJon97Y
 9PSgFPebiGaoh2JN4YlXlusX3575uHp/427unIfGz+7cxHbmcFcJMHtsn3vw79ElyzBV1e
 ecpbyjerapglp83h6787gBmO3WRHSXg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-OFAHI_E7PFWKrXY4jJzzaw-1; Thu, 26 Mar 2026 04:22:53 -0400
X-MC-Unique: OFAHI_E7PFWKrXY4jJzzaw-1
X-Mimecast-MFC-AGG-ID: OFAHI_E7PFWKrXY4jJzzaw_1774513372
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3870692eb93so2509841fa.0
 for <dev@dpdk.org>; Thu, 26 Mar 2026 01:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774513371; x=1775118171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sk1BMz06DXz8iUs+SKsUYXhp2pGOOYPHbttGlRGzpMQ=;
 b=XbQdLofPlO6qYzOSXgXjmL81nN5UCu3MiuPBCbc8RWxxk1inBrklj+XV6BwgttUR2g
 EXeDhZ2t4YIfMpPXWllm9YytfmWEcMPS9CByQ20gRuya02JHVg9wS4oa1BmRfg4rU2oy
 Cwraj0f0pcoC0wXod9omv217A3HjZwTyMoHs2SihenLLd0NKI2kxVVJ1XfiUgupTBfxK
 buCY1Ce6dQTq/YGBz8BBU3+G13KWk1cRh/H1tJ0Bsw+UsLXuZwfIZ3lvoaXCfOrf4bet
 Br5MxbyZXrCNqKdy4GqYc/vRckUi+hCyT15DWWjJL6Am+Na+n0vTkx9dTE3/52KBpoux
 09Ug==
X-Gm-Message-State: AOJu0YwVy/T+Suy0WQ94keHEztKACrjiGnPuA9eaClOnShhgeRZL2V0l
 FDRmzU+Q8xBAI+g7ivFlsH9qLam5TfOziHS6odYOhSJCSbMrM4y4dYP2lDdzlQ0mRvH9+DUfovj
 axP//JyuA4MP8FXf8sPZVUtXDk8KySPFyifGvyNnbdhSk/fTPX/ewhiIqre6V/oKObDQ9La9qr3
 KXpy8aD/SFVkTCE/iqvS0=
X-Gm-Gg: ATEYQzyj8MSBsu3LF0Y0Kb5wQSKU2oPF9DjcwC1Q01ZWaKLhCSnfDG3BioikpiZyNrI
 WGW4OCMcgs2jQs3EvXNML0gYYug/37s/H3K4V9t5ZMgWIcg06x4P8PKkdHkowQ2PtUcIFsr9b0E
 iZx9A8EQfG0Li7TadKvOGUq/4rWU0f2uDx/3xPLbc9L13jOjEJxfMGmyEipVDni7U84VWnL6RvG
 xcDhjJ+yCYKlmA02HDGpHVlUGh84Ry/tbcYlzx5MxV7L6JyyBrAHqdTFqpUeKT7jC6EIA==
X-Received: by 2002:a05:651c:324d:b0:38c:63df:82a6 with SMTP id
 38308e7fff4ca-38c63df8422mr4097461fa.29.1774513371474; 
 Thu, 26 Mar 2026 01:22:51 -0700 (PDT)
X-Received: by 2002:a05:651c:324d:b0:38c:63df:82a6 with SMTP id
 38308e7fff4ca-38c63df8422mr4097301fa.29.1774513370932; Thu, 26 Mar 2026
 01:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260323105306.1531689-3-david.marchand@redhat.com>
 <0b33ca24-dce4-47f2-aacd-cb0e9ecfd5d6@redhat.com>
In-Reply-To: <0b33ca24-dce4-47f2-aacd-cb0e9ecfd5d6@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 26 Mar 2026 09:22:39 +0100
X-Gm-Features: AQROBzBfKKEXrobOSRUuesm5HlJ1001rTBCm7Q19308RHoE4aJ_LyemI0FNIgjY
Message-ID: <CAJFAV8zs4ToAEXq7EvvH-MEpvdrGUaEPzd1L8BQx=zmJ67iUXQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] bus/fslmc: fix bus cleanup
To: Kevin Traynor <ktraynor@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Sachin Saxena <sachin.saxena@nxp.com>, Rohit Raj <rohit.raj@nxp.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2q8cF4I0SEtoq0cGzNR4wW-JO6XSeKIg-oMmChNzKRc_1774513372
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

On Mon, 23 Mar 2026 at 17:59, Kevin Traynor <ktraynor@redhat.com> wrote:
>
> On 3/23/26 10:52 AM, David Marchand wrote:
> > The close operation was never closing probed devices.
> >
> > Taking a step back, reevaluating the devargs makes no sense during the
> > close step, as a probed device must have passed the allow/block list
> > evaluation initially.
> >
> > Since the device contains a reference to the driver that probed it,
> > simply call this driver remove op.
> >
> > Fixes: 274fd921ff7f ("bus/fslmc: support close operation")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> >  drivers/bus/fslmc/fslmc_vfio.c | 21 ++++-----------------
> >  1 file changed, 4 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
> > index 550d4e0e8d..7daa18d850 100644
> > --- a/drivers/bus/fslmc/fslmc_vfio.c
> > +++ b/drivers/bus/fslmc/fslmc_vfio.c
> > @@ -1393,7 +1393,7 @@ fslmc_close_iodevices(struct rte_dpaa2_device *dev,
> >  {
> >       struct rte_dpaa2_object *object = NULL;
> >       struct rte_dpaa2_driver *drv;
> > -     int ret, probe_all;
> > +     int ret;
> >
> >       switch (dev->dev_type) {
> >       case DPAA2_IO:
> > @@ -1411,22 +1411,9 @@ fslmc_close_iodevices(struct rte_dpaa2_device *dev,
> >       case DPAA2_ETH:
> >       case DPAA2_CRYPTO:
> >       case DPAA2_QDMA:
> > -             probe_all = rte_fslmc_bus.bus.conf.scan_mode !=
> > -                         RTE_BUS_SCAN_ALLOWLIST;
> > -             TAILQ_FOREACH(drv, &rte_fslmc_bus.driver_list, next) {
> > -                     if (drv->drv_type != dev->dev_type)
> > -                             continue;
> > -                     if (rte_dev_is_probed(&dev->device))
> > -                             continue;
> > -                     if (probe_all ||
> > -                         (dev->device.devargs &&
> > -                          dev->device.devargs->policy ==
> > -                          RTE_DEV_ALLOWED)) {
> > -                             ret = drv->remove(dev);
> > -                             if (ret)
> > -                                     DPAA2_BUS_ERR("Unable to remove");
> > -                     }
> > -             }
> > +             drv = dev->driver;
> > +             if (drv && drv->remove && drv->remove(dev))
>
> Not new but dpaa2_qdma_remove doesn't return an error which seems like a
> bug, but it has it's own log and it's just a log here anyway, so not
> critical.
>
> > +                     DPAA2_BUS_ERR("Unable to remove");

Indeed, the dma/dpaa2 driver does not report errors.
And there is probably more to fix in the fslmc bus, as I see that the
bus .unplug() does not check the driver .remove() return value either.

I did not dig deeper in this bus for now as I was focusing on the
devargs evaluation.

Could you open a bugzilla for tracking this issue?

Thanks.


-- 
David Marchand

