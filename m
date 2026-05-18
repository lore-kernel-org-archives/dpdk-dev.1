Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B63CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 08:16:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2586402D9;
	Mon, 18 May 2026 10:16:47 +0200 (CEST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 2A77D40265
 for <dev@dpdk.org>; Mon, 18 May 2026 10:16:47 +0200 (CEST)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-8b8e98fd885so30117056d6.0
 for <dev@dpdk.org>; Mon, 18 May 2026 01:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779092206; cv=none;
 d=google.com; s=arc-20240605;
 b=IvS2q49mrKeC/3ngBwTwgpzy9HFw3SBYHOnxLAfNjBd46+NYBMxr38sH5P6Wxc1Ylr
 CsBqJ+tfwg6wV0I+ULD3D6PdxqDxEQ1BPo5x/PqvNowFrW6n88GqkNxfjwnwGEbf0rNg
 jfOrd74gp43K5TXcz6ZoRqn8DIpKu+ebAqPwh8nUKjr8zwNrsVzilu3/GsLm7hV0KS7S
 vWt9xkRA5oRpu/Yg8lEJY3tL1rB/AJWHbUrzNwJl4GaUAAW/GEhCf/Sp0g4LfCxafyzJ
 GKpeSGY1+LZjp+VNKfECgygeQLNj0Tcmd/pAJMoRFhfqaYsY0SvLJN6uVQ5XEM0j0iVh
 vY1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=Er+slCuEivIQJDZCMkAZGHFMFdubvVPkn+XIxhwpHkY=;
 fh=hZYrAb1rHrd9aeHhIvxXvuqXAp1ZHQhbVN9JJutjVQE=;
 b=UT+aO2ukGdyIG/hWRvMDhWj4CZ1qBPBAyOshncAFgXAULI0GFkrt1TfkH7m1geahKS
 8eVVia3nf/2AThZXuWX2+TlMvxCbLYpgdJ8Y81bE3ukqVxP6PJUsXUvR028Rg5T7HcSb
 +yWXrkE04flyQciMKQ6Dj5aaDDePZ7n5ZrhN4EF7T8AT+yTVgIzvtVX3szBgB4xj1LdU
 IUaXsWMPOKjuDR+/jUt3fjuykAkR1No3BrBUsoGxksnft3ihfAGFWyImHHXqGJ2AtKco
 9Jin/PkHsryTJAd+ifESl6hgJi6ruIZK8ykuJYOBc5lJX+DHMCdSQGn0F8dNx0qxjB/C
 fiIA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779092206; x=1779697006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Er+slCuEivIQJDZCMkAZGHFMFdubvVPkn+XIxhwpHkY=;
 b=ls21H5RlQtMq7klLyvK1SScB6AbB19oyyN3fQnwwch4e4ktBYXAr5JRCz741TNaT6+
 IgRg9wBkU1DPsHMnRhmK0xSzTDCAeCg3Z+APGf6Co/+BgO3BROjd1lFeCEMKLTXBFglC
 09OVgvyOiFTUjpyHN8wL/GVHofVLtdpuyW4CpnJCRjzec3AGDsUDxyRZXNQZI5oWI0iU
 xAmsZ1lk8CqYfYGLO+o7FjaygDXXEvaDjC6SYROEJ/Et3FJe5jYyZdrt5E8L9PUPREh0
 d5Tcl1iLT3F/Hz9qXehrvJ92mWOxYI5nxnhmPOTln4OQZvKvLzCMxTh9FOg8LN8WW+Z1
 nC/Q==
X-Gm-Message-State: AOJu0YyF7gdRZ1xHUiFlb3zBBo86HhGpT/mxrQomwbDQ+TiWmZg/PM9B
 91zIfE3CLqbiGOUMKgXlrndkAPGfE3cICtL7tjCvmqYn4nnfa1GpJVISY5RMy5t3P4SYgvNE9T4
 cnfYS27LLhQyNyfuF4G8dR2htr338Kew=
X-Gm-Gg: Acq92OGQ4mg47nfICvGlBPyOVIr0GUq00t9AVvh6V+6bArnQ2zGg3F4SVuZlRnAS33I
 ySe4Gyy6GN9jyHZU6frR30OV8wGdtYewGoIDnQ5c6COC9TQKl7/ZkzWc6qhq+0jhmHYGiipMF3m
 Lo2kt3aWfLKr3SWXdtWiOehxMcK7omsxltUXLfkp3O3Czsmp8d129MBZL6WmQW3NJ1M1WOz8ZoA
 C0JzCJfLnjPt1ForPpNLlwP43r6Gttlz1mBI379zMqbUIno7NtrAzh85OzR7GVdSbPzofWZaU+i
 QSgG2Q5NSlqnZU+5w7s0f/QrdrK6WFhKA9LAoDvBBfqGfUso
X-Received: by 2002:a05:6214:4b04:b0:8be:3da0:bba7 with SMTP id
 6a1803df08f44-8ca0f671f23mr255386986d6.16.1779092206380; Mon, 18 May 2026
 01:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260513203725.1905-1-shofiqtest@gmail.com>
 <20260513203725.1905-2-shofiqtest@gmail.com>
In-Reply-To: <20260513203725.1905-2-shofiqtest@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Mon, 18 May 2026 10:16:34 +0200
X-Gm-Features: AVHnY4KaGR1u7lo6lYCJ7oscR78i0vXDfdt4Wpx8A60ZhAydSTiRErD-7OJNOlY
Message-ID: <CAHHRULUAgX8ha7+v3oSH2yv7ihq8ojbXuGFn5k51hP=B4ie9_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] bus/fslmc: fix ignored return value in
 fslmc_bus_unplug
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com, sachin.saxena@oss.nxp.com, 
 g.singh@nxp.com, stable@dpdk.org
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

Hi Shofiqul,

On Sat, May 16, 2026 at 11:20=E2=80=AFAM Md Shofiqul Islam <shofiqtest@gmai=
l.com> wrote:
>
> fslmc_bus_unplug() called drv->remove() and discarded the return value,
> unconditionally clearing driver references and reporting success even
> when the remove callback signalled failure.  As a result, callers had
> no way to detect or react to removal errors.
>
> Capture the return value and propagate it to the caller.  Only clear
> the driver references and log successful unplug when the callback
> returns zero.
>
> Fixes: b5721f271cbf ("bus/fslmc: support DPNI hotplug")
> Bugzilla ID: 1914
> Cc: hemant.agrawal@nxp.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
>  drivers/bus/fslmc/fslmc_bus.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.=
c
> index cf881b3eec..9cfd8b10ba 100644
> --- a/drivers/bus/fslmc/fslmc_bus.c
> +++ b/drivers/bus/fslmc/fslmc_bus.c
> @@ -620,7 +620,9 @@ fslmc_bus_unplug(struct rte_device *rte_dev)
>         struct rte_dpaa2_driver *drv =3D dev->driver;
>
>         if (drv && drv->remove) {
> -               drv->remove(dev);
> +               int ret =3D drv->remove(dev);
> +               if (ret)

We log when the function successfully unplugs the driver, but there is
no log for error. Adding one could help here.

> +                       return ret;

Could you please declare ret at the top of the function to match the
existing style in this file (fslmc_bus_plug() just above, plus
scan_one_fslmc_device, rte_fslmc_parse, rte_fslmc_scan,
rte_fslmc_close all declare int ret in the local-variable block) ?

>                 dev->driver =3D NULL;
>                 dev->device.driver =3D NULL;
>                 DPAA2_BUS_INFO("%s Un-Plugged",  dev->device.name);


Regards,

Maxime
