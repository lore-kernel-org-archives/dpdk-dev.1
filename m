Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0688B106F304
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 08:55:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB9F8402F1;
	Thu, 26 Mar 2026 09:55:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 66DA1402B5
 for <dev@dpdk.org>; Thu, 26 Mar 2026 09:55:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774515314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A6E1Qsw+P8yzvMEJskJSj3g8cA6ZexSo3MUduiHd53Y=;
 b=Re9Bdlfpc2nbPUE9JxT/pUhoyMSk46fXvptIRtzYdf8YvhcP+huDyKRZKT5aaVPMkulQRb
 mg3mJ+gyKP8YqAb993Il1xvECChSWy0+I2mgkJD7/UinzQz2Gt4bZeJLAv7p7BXbOdVAPk
 z8m4Xyg4VX4mAlze1Ev7vkz4dkynRw4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-ksEHHl6KN_uc2QtasWReIg-1; Thu, 26 Mar 2026 04:55:12 -0400
X-MC-Unique: ksEHHl6KN_uc2QtasWReIg-1
X-Mimecast-MFC-AGG-ID: ksEHHl6KN_uc2QtasWReIg_1774515311
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-38c55c64b57so2376001fa.1
 for <dev@dpdk.org>; Thu, 26 Mar 2026 01:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774515311; x=1775120111;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6E1Qsw+P8yzvMEJskJSj3g8cA6ZexSo3MUduiHd53Y=;
 b=Rhpsl1J+uv6Dmzf2Tnww9tgZ+6y7f012mYXu+1+ubz8u8pY42UQQG9ITdoRg6RYOxy
 Mwc5wCeO4Vi+FaSEOHyQGBapDUzZ7+XCgC6egIg+LwsGn/3j9j0bzEai8QURwAOo0GUb
 5gu6k0FugOZGvmxqctOHAYBhrvYl011SeSl5C9JCPCIly2NBFC9xS7sV9raW9DTvxbhO
 8dkN0NEx7zqxNRaHqKfAUi9OdFNv9jDZNs68LA9XF7EpEz413h1l7Y514Bx3hqWGYb9J
 bYJQxTea1ZKu3mx9wa0FFV+qr+lxL8XReXzibiqY++Qb+rFluHSCbZSTNdagVvSZ11+K
 JpSA==
X-Gm-Message-State: AOJu0YztJbvisc/cVR3sAjGJ6M7fB/wpK8h5VajPbPPzyZMHtsoYUI+4
 jL9jxAqCrxV3LwNwjMxB8gYi+KM6M2wawjRJL6URgUFb1HbxdYcuuup8T2k7FIz8Y0CTPVgL3YW
 cV6/x9jXGBkd3J8gRXs0HWnjXjCQNHbmmh0rqbnmsr21sY/R17bAT1NzBgsQudkcdNtfO/3Neo6
 WGY+m2RAS5QvVfk0k8EGE=
X-Gm-Gg: ATEYQzwKm/abg1TjRGR4JFuky99yGAYUtZ+exm7yeFXi8q5Oirn1JpmSJJrtmvDX4rd
 p9Pq9MG/gLlLhEcr4latYUt8dr23EPtdoVVp/XW1FW3+aJf0Pi/iXJDeioaoHYUfDd+O9W8n9y8
 S8CqKex6cyQDyyPvv1CHzPu94GaqtXzaRAsPZlXqyYRhtvmNaVonLFGpabTFLPQZdHUtokDwZwh
 EKJu1Zd17Ha+yPQBBVhbsuq0uMFMsWl/k29XVE4+SY+7WtD7oUwUCZqv/4R3Qou/eCo9A==
X-Received: by 2002:a05:651c:154b:b0:38b:dae9:87ee with SMTP id
 38308e7fff4ca-38c4323f85dmr23689291fa.36.1774515311100; 
 Thu, 26 Mar 2026 01:55:11 -0700 (PDT)
X-Received: by 2002:a05:651c:154b:b0:38b:dae9:87ee with SMTP id
 38308e7fff4ca-38c4323f85dmr23689141fa.36.1774515310528; Thu, 26 Mar 2026
 01:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260323105306.1531689-8-david.marchand@redhat.com>
 <37eb6e05-b27e-4412-9e55-d7629d94ae3f@redhat.com>
In-Reply-To: <37eb6e05-b27e-4412-9e55-d7629d94ae3f@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 26 Mar 2026 09:54:59 +0100
X-Gm-Features: AQROBzAUeDvuDVU3aZfhGtBNOXNyVtn_ZMvAt0oNysa56un0N6Q_Kf4_tEPfbqU
Message-ID: <CAJFAV8z6zo0sZ8+tm08mZg9QXU0mLeqxdx6PbYi-yi+_4MqXrQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] bus: remove per bus scan mode
To: Kevin Traynor <ktraynor@redhat.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ty-GV5geKZAJT7SX0CFTZRAiVvLAMxN319BwxmbZsUM_1774515311
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

On Tue, 24 Mar 2026 at 17:02, Kevin Traynor <ktraynor@redhat.com> wrote:
>
> On 3/23/26 10:53 AM, David Marchand wrote:
> > Following the refactoring of device selection, it becomes more apparent
> > that there is no need for a per bus scan mode.
> > -a / -b options are mutually exclusive.
> > --vdev option works in parallel of allow/block list scan mode.
> >
>
> -a/-b are mutually exclusive but does it mean "-a 0000:01:00.0" stops
> default probe for all devices on other buses ? Is it a change in behavior ?
>
> (I could probably test but I guess you thought about this case given the
> nature of patch.)

Hum, yeah, it is a change in behavior, I was too focused on the next
patch (where the new mode can't be used with -b option).

This patch was an attempt at simplifying.
Since there is a risk some user may have relied on this combination
(iow some user setting -a busA:XXX yet relying on block mode for other
buses), I'll just drop it and return to how it was in RFC v3.


-- 
David Marchand

