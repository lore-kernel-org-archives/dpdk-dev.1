Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69011CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 15:44:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 932854042F;
	Wed, 20 May 2026 17:44:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 67768400EF
 for <dev@dpdk.org>; Wed, 20 May 2026 17:44:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779291869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3GyNaP/6O6zlpMiMiyPzxFdPriQ1hQqG33yCGHKGaeQ=;
 b=Ku83AOcIZ7YEnF70sQUztcjdQEA9Wo5vTEvWT7Dlozfp3IBfV3ONuaMHU9+6Bv+A13/g7o
 MiZKS7q1jgII+yW7B+eQM4Shm+fW/F4j2VC+Xt+zMEDTzjY97E6jdI70tRVGT9vIxMNkqK
 KgxLaNu088bskAswxoHXakKEabFHsy8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-seaisWA3ML29Bwv4FmV43Q-1; Wed, 20 May 2026 11:44:28 -0400
X-MC-Unique: seaisWA3ML29Bwv4FmV43Q-1
X-Mimecast-MFC-AGG-ID: seaisWA3ML29Bwv4FmV43Q_1779291867
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-38e9589b7c7so26432211fa.0
 for <dev@dpdk.org>; Wed, 20 May 2026 08:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779291867; x=1779896667;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3GyNaP/6O6zlpMiMiyPzxFdPriQ1hQqG33yCGHKGaeQ=;
 b=fmisneW7jgt1Duu2ixoXJs6ti5XjoyIym1EH+SAEBOL7hsbIDNqWm/GPnI77Qoi8jX
 CgYQLyw35wh++yKPJzs7AgcbEBkTAmP1b0pjnn1ghYCCHRx4a4krwv/uGjAnqOFR3nWB
 Ut9gaPWXhMNk5NwoTIoXCN5lYHfUaz4uX1c/XTEP1+ApkhwPScdq1WiwB+uneJaDqZPI
 1gVHBaJRP1Vncm54CWq5ZJPiaIV4zAcRrQw+5vL6cfEoTKw0c4lblh8XgZ4j6xXW7n/B
 naMzVXk3719TP2PLblFd846hlLsaUtYuB2B1KxB/e/BDZGxQaUSkSMUJDmznH1aIxjs3
 6FPQ==
X-Gm-Message-State: AOJu0Ywn0DRAxWuDlElVLIq2D96mb6yyTma3ucXW55indWvxf9maNWA1
 G+gUKs59f5yrnJXWf0bjrV+6MDoQocT8UTz7MGkKFkgAYnOWoDar4ktC9u5/hs9NC6Hq2dRK3eS
 maO2Kqc+uM/UEYhrGlWh+A4ZV2+KDtfjMDyWH7UqsyKdtxcJe3s39hSgWzgzaQsePwEFJHOUyZh
 HzOXVqdWB6c8RTCovUTrA=
X-Gm-Gg: Acq92OGUI+Yr11rIIyTv36h962ETU6wC4KBWA9V4VMw6YR6UPeIGquCfjd/iyqbmckT
 uci69zG8F+mT8CH6bPf197+rtGsbDQ06W24TfCxzcWJ99nurGyfC4Ypp62y3Y/QtZmOz1rBjNlD
 czhytgGiybA+a9yaitMHhQRYDtGqZWN76cLnZXSsdWT93XnkLILOLdgTP+5BU4iWN1YK2JkJj6C
 7BM8XvyJdFMk6Evw+cg6buIrfzwBspTT3aUy1gFHl07Uwq7hr1ND6/XwTXBXUAn57NKvw==
X-Received: by 2002:a05:651c:f02:b0:38e:e6fd:65b2 with SMTP id
 38308e7fff4ca-395aef0c999mr23960141fa.21.1779291866777; 
 Wed, 20 May 2026 08:44:26 -0700 (PDT)
X-Received: by 2002:a05:651c:f02:b0:38e:e6fd:65b2 with SMTP id
 38308e7fff4ca-395aef0c999mr23959951fa.21.1779291866249; Wed, 20 May 2026
 08:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260516101942.443871-1-david.marchand@redhat.com>
 <agykrWAcEnOBZvY-@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <agykrWAcEnOBZvY-@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 20 May 2026 17:44:14 +0200
X-Gm-Features: AVHnY4JpEf1bFJRiRTdFNHttPGAzSwURj011nkesdcS22bpTJA0hPA0kUgYWnrM
Message-ID: <CAJFAV8yLBFGVqOvfQ4SEZmy61g7xR4vrra7vyxG_NCc=4y1O7g@mail.gmail.com>
Subject: Re: [PATCH] net/ice: improve log messages for DDP loading
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, patrick.mahan@hpe.com, 
 Anatoly Burakov <anatoly.burakov@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -sx_xJBVE1FEEnMb4_fv3MiaiOcIzNitP2V-8xmu1EE_1779291867
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

On Tue, 19 May 2026 at 19:58, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Sat, May 16, 2026 at 12:19:41PM +0200, David Marchand wrote:
> > Some nics may not provide a serial number (PCI capability
> > RTE_PCI_EXT_CAP_ID_DSN).
> >
> > This results in a confusing ERROR log:
> > ICE_INIT: ice_dev_init(): Failed to read device serial number
> >
> > This is confusing as DDP loading does *not* require the serial number to
> > be present for the port to be functional afterwards.
> >
> > Besides, after trying various path, if the default DDP is not present on
> > the runtime system, the port initialisation ends up with a vague error:
> > ICE_INIT: ice_load_pkg(): failed to search file path
> >
> > Improve the situation with adjusting the log level when reading the
> > SN fails, then add more debug context to DDP file loading and end up
> > with a ERROR log mentioning the expected file.
> >
> > ICE_INIT: ice_firmware_read(): Cannot read DDP file
> >       /lib/firmware/updates/intel/ice/ddp/ice-b49691ffffe6e69c.pkg
> > ICE_INIT: ice_firmware_read(): Cannot read DDP file
> >       /lib/firmware/intel/ice/ddp/ice-b49691ffffe6e69c.pkg
> > ICE_INIT: ice_firmware_read(): Cannot read DDP file
> >       /lib/firmware/updates/intel/ice/ddp/ice.pkg
> > ICE_INIT: ice_firmware_read(): Cannot read DDP file
> >       /lib/firmware/intel/ice/ddp/ice.pkg
> > ICE_INIT: ice_load_pkg(): Failed to load default DDP package
> >       /lib/firmware/intel/ice/ddp/ice.pkg
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> >  drivers/net/intel/ice/ice_ethdev.c | 31 ++++++++++++++++++++----------
> >  1 file changed, 21 insertions(+), 10 deletions(-)
> >
> On top of the changes made in this patch, how about something like the
> below to extend things?
>
> Rather than just debug logging the failed paths, we change the debug logs
> to always log each load attempt. We also record the path as it's attempted,
> and then on failure to load any path we use that record to print out an
> error message for each failure, so the user can see in the error logs ALL
> the failed paths, rather than having to re-run the app at debug level to
> find them.
>
> WDYT?

That's a lot of code for something that is usually detected right at
the first installation/run of your DPDK application.
When you are at this point, restarting testpmd with the right debug
level is the usual way.

But let's say you can't restart your application, log levels can be
changed dynamically (possible with testpmd, grout and OVS)
before/after trying to probe the E810 device.


-- 
David Marchand

