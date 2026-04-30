Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C6EFF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 10:12:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2F6C40615;
	Thu, 30 Apr 2026 12:12:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9E4CA4021F
 for <dev@dpdk.org>; Thu, 30 Apr 2026 12:12:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777543936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yATKaTujukDQNwwvRUEQCmuDmQ+U9Nzb3TyDq0HktCw=;
 b=ZHLFErojgm9jKe/iK2Rg4EiFlawC75sGq2bdz6Ig2abvNGXv7Vy+4DEEXH8l/v9tOU3f97
 vLQ/0T33sJCgkuRfGUINztsnCCI4xFxsKnU7pSGYf9jKO7erfPQjpPJ8K5zTP6w0lWoAad
 sAb9gx7DrSLdRMzH8f/D4WdDcHCMJ2Q=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-S4zKfshkMvK4MhINdtjbUQ-1; Thu, 30 Apr 2026 06:12:14 -0400
X-MC-Unique: S4zKfshkMvK4MhINdtjbUQ-1
X-Mimecast-MFC-AGG-ID: S4zKfshkMvK4MhINdtjbUQ_1777543933
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3870692eb93so4941411fa.0
 for <dev@dpdk.org>; Thu, 30 Apr 2026 03:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777543933; x=1778148733;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yATKaTujukDQNwwvRUEQCmuDmQ+U9Nzb3TyDq0HktCw=;
 b=opiWgRxFByKamKAkVWwDrdJMU7vtbKHTgIwCmU/W/J6JBB71itAEpAUBZGlcyl4iPe
 y7qllBTkMa11m3NeLufGQp63vlDT4vbC8nmVFMzxLNWhOBCTCbMowv44FLZYEam5VsJE
 hmbYMxTCunRMw/zm+ECaM3cfxnBjO1AnXZtzBORP4iyjNg91paUw9X4EzusL0FLXF2pF
 22AAA0kXjwrh7VLRydt8cLDLtu4tB1Etau2l+YFvXCd3cuSey+dvNqxTvW+4M/HSDeNT
 Di986AbeMU6uuT9mcgOkaXQcT+Yb7+hW84NG9DBajLSLWxfKf1SAiWwNqICn+LTRgpiZ
 pXTA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8k1fnI4KQmjuoDjgmJ/y+VlX/GNZeUb0CmlWzqNnCCZ+22Ic6IToNZJetxTyqeFxdOkWA=@dpdk.org
X-Gm-Message-State: AOJu0YxwDR/sZuHi3oHeddG0tlGZoqhoSLV2tplbNMGLHVgBrj+72MWt
 UUpcAX1GArL/jDlTeVIRiKVw7JR6w9ypgkROC5erSBEFqoQWVjMGtXMyZjbcl2V3u0ygOgUjo9k
 mc3dqcMbzY17r6uptgF2Cx1rcpye37a5rWE7j8I8GvBVqzMZMUYdLStcVNd3h6h8XkYoEKb/O6i
 FHodoHRZvHluSwt6cDhpI=
X-Gm-Gg: AeBDiev+AkJvBUfDGQ4tOxLE2RODH4m5YQIl7OUPax6Qk4bVXb/Wd1966Ah7JVZn+6W
 ZYPLCt94oDvqlnFHO/vE141gax75UbGnpewpqi4aqvov/G2RRTXIJQ/wf5vPOX0D3kQjz8Hy+MQ
 odA0Wg1KTEi4AGEqqd6S6nhDtOJPyoGruGM1jw1RnXbYAJ6cetRC5CtLSk6WIymXTYhVuc1ES8p
 Qy8eVCHXft9Ld2zFNdXEv8Fhv0I6e/LoipRf3hgst48YGTdBdX0xz+g5mzHaYYwLBTESnG7L3jg
 j3b9
X-Received: by 2002:a2e:9e52:0:b0:393:5920:2c5d with SMTP id
 38308e7fff4ca-39359202d6emr3444841fa.28.1777543933147; 
 Thu, 30 Apr 2026 03:12:13 -0700 (PDT)
X-Received: by 2002:a2e:9e52:0:b0:393:5920:2c5d with SMTP id
 38308e7fff4ca-39359202d6emr3444661fa.28.1777543932676; Thu, 30 Apr 2026
 03:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260422102814.645299-2-rjarry@redhat.com>
 <CAJFAV8yAhr-iXkn6JvderT_Yy4rB91LVWqYvwRqJH0DdmNkJ1g@mail.gmail.com>
 <DI3VM171VBSL.3E3J3C1HJ1GZG@redhat.com> <40394769.10thIPus4b@thomas>
In-Reply-To: <40394769.10thIPus4b@thomas>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 30 Apr 2026 12:12:00 +0200
X-Gm-Features: AVHnY4LnUkFva-VAQ9sls-agTM7qCvwQwI49WO2UtxNsF5C3NXmtNhYANA8xye8
Message-ID: <CAJFAV8wf-orBns0McCNeW1nx6a1s34+syV0jMXUP-+=0q4k8ow@mail.gmail.com>
Subject: Re: [PATCH dpdk v4] net: fix VLAN packet type
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Robin Jarry <rjarry@redhat.com>, dev@dpdk.org,
 Gregory Etelson <getelson@nvidia.com>, 
 stable@dpdk.org, Kevin Traynor <ktraynor@redhat.com>,
 Luca Boccassi <bluca@debian.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sGSD3m6V1iEnFHpaDunWmRKZarDLlC2WNS3t5vAiVD0_1777543933
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

On Mon, 27 Apr 2026 at 17:53, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> 27/04/2026 12:47, Robin Jarry:
> > David Marchand, Apr 25, 2026 at 10:40:
> > > On Thu, 23 Apr 2026 at 13:25, Robin Jarry <rjarry@redhat.com> wrote:
> > > This is untested, but what do you think?
> >
> > That looks correct. But you don't impose a limit in the number of VLANs?
> >
> > I don't see any good reason to support more than 2 stacked tags.
>
> Look in the mailing list.
> I remember it was to limit a risk of infinite loop.

Defensive programming (iiuc why it was introduced) seems a bad idea.
It imposes a restriction for no good reason.
The same can be achieved by checking the offset vs packet length
(rte_pktmbuf_read), and no arbitrary limit needed.

I am for simply reverting the patch in LTS releases.
We can come up with a new change in main for Gregory usecase, but it
does not seem like something we want to backport in LTS.


-- 
David Marchand

