Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5A6CD98D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 10:09:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0761742FDB;
	Thu, 11 Jun 2026 12:09:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 44BBF42FE7
 for <dev@dpdk.org>; Thu, 11 Jun 2026 12:09:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781172589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F7gshjvuS9GFRP/oWHma+drfkczIoqWopseXeaVb5HU=;
 b=egWju6mSL959dYcqadLj8e26NmMMi+303CbBjGQ44gwA0OKqBLDGnmGdeIMah9ARzbsUS5
 o02aQCsA8S+fsDjdfOXUbIuiRLA83tmcJSHuCkBpqAfSTX7yLWe46G+zI3myMJ8oLieF85
 /JBdA5umIPMl8QSWPdd00PaQBuesEkk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-eqcOv0M5MAC--tQDKfu8qw-1; Thu, 11 Jun 2026 06:09:48 -0400
X-MC-Unique: eqcOv0M5MAC--tQDKfu8qw-1
X-Mimecast-MFC-AGG-ID: eqcOv0M5MAC--tQDKfu8qw_1781172587
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3966ec391c9so18219111fa.1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 03:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781172586; x=1781777386;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7gshjvuS9GFRP/oWHma+drfkczIoqWopseXeaVb5HU=;
 b=RuGs7r75cKv8gReGQ5Gb5EIqxBVzkpLa0hnrmujho0t5eUWI9OrQt+CvsMtB+5jkRK
 46zSjFLlq7u17Q59uiJ7+/yfYnvyTluGFGPZ8ff/jndRKa18xmWjNf6ySqHQcChjUWWU
 hlqA7Gf1K+tY8CRiJZ9URNizlYWMmuY4OsNCj57aJgSXasv6yX/sOlp/7Qm3qIwz6xqF
 VyjSn0nv1Jq3AEbx69bxD4GdStkQnUazIdfAdLmsiQqaz2LNnM/jMce/LdOGAh1Gj0p5
 OeDdptk3r5IrxBLwT2aFUKZdmYz7G8qrK1SPlGV/QxDaEcfEMPsPHpSh17YBMcfWv10W
 y6WA==
X-Gm-Message-State: AOJu0Yxq2cAgipaYtN45faP83kLdezrgaYkW0G3mwwbsIeei5i3GAsV9
 Dkg448jXQDioMlRJHJQ3MWF5sYpmWrkFcxjJFVPJgWS1aJ5Q+R/BVywudv6hvzRZ0y8ByXED7Et
 xzhWTr+xmlu5TfPTnH0/F1yHOLkSsX5XiPc4VaxWGWR6GGxjbZLnqX3nh4cVLn+bHBbqo8u9StF
 yPBYNoJJkQ4CM7+Bk49RFQpyCb63zyHQ==
X-Gm-Gg: Acq92OGtOWFJQQTy5Up7To3a9rXmBdCImQieth7MfP9J/hqEWwYVSRuWJ0a28w844tf
 mjHfjE0Wla84r2LET3nUXF97Co8pDOWI6FR+ZyV82bWKYsfgU9SpDZ3L5HYpOJwxjStix/1OKec
 3oNBF4zf6fawP7jgUVtNLNii2ypPudv/F0mLpnOd9hAT29tAyHq3f+bgLUcB+YP7qADUWXrpNSU
 0MLNjf2fLOgqG7E0M6QE7TEFazsoy5kb4bIamk2DsXlBXcG7Hzg72WWLRYA/a5QjbL8cFmhf6Nh
 +xx7
X-Received: by 2002:a05:651c:1401:b0:399:1fbd:8f2f with SMTP id
 38308e7fff4ca-3991fbd925fmr161841fa.9.1781172586506; 
 Thu, 11 Jun 2026 03:09:46 -0700 (PDT)
X-Received: by 2002:a05:651c:1401:b0:399:1fbd:8f2f with SMTP id
 38308e7fff4ca-3991fbd925fmr161781fa.9.1781172585974; Thu, 11 Jun 2026
 03:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260611094551.1514962-1-david.marchand@redhat.com>
In-Reply-To: <20260611094551.1514962-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 11 Jun 2026 12:09:34 +0200
X-Gm-Features: AVVi8Cf_OhrVx2iDypGoZ80AW6HR001rGrdwzgpCv14pQIJ0MW36DSBsSRfOV44
Message-ID: <CAJFAV8yq1KfHQr6tD4xZQNdvUgAPJeg7fSZcQFv4NFNOPse07Q@mail.gmail.com>
Subject: Re: [PATCH 00/13] Bus cleanup infrastructure and fixes
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org, 
 bruce.richardson@intel.com, fengchengwen@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yB82zHyEBKt8E6XRKFUA0MP0i1Wg-wN1oG2hZdhlBy0_1781172587
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

On Thu, 11 Jun 2026 at 11:46, David Marchand <david.marchand@redhat.com> wrote:
>
> This is a followup of the previous bus refactoring.
> See https://inbox.dpdk.org/dev/CAJFAV8zvFpLwz8SY8DUUezyJyM43eRZ17Yj30ex808eHC4ZE=g@mail.gmail.com/.
>
> This series refactors the bus cleanup infrastructure to reduce code
> duplication and fix resource leaks in several bus drivers.
> It should address the leak Thomas pointed at.
>
> The first part of the series (patches 1-8) addresses several bugs and
> inconsistencies:
> - Documentation and log message inconsistencies from earlier bus
>   refactoring
> - Device list management issues in dma/idxd and bus/vdev
> - Resource leaks in PCI and VMBUS bus cleanup (mappings and interrupts)
> - Simplified device freeing in NXP buses (DPAA and FSLMC)
> - Deferred interrupt allocation to probe time (NXP buses, VMBUS)
>
> The core infrastructure changes (patches 9-10) introduce the generic
> cleanup framework:
> - Refactors unplug operations to be the counterpart of probe_device
> - Implements rte_bus_generic_cleanup() to centralize cleanup logic
> - Adds .free_device operation to struct rte_bus
> - Adds compile-time verification that rte_device is at offset 0
>
> The final patches (11-13) convert remaining buses to use the generic
> cleanup helper:
> - DPAA bus: add unplug support
> - VMBUS bus: switch to embedded device name and add unplug support
>
> After this series, most buses use the generic cleanup helper, eliminating
> duplicated code and ensuring consistent cleanup behavior across the
> codebase.

The remaining bus that do not use the generic helper are:
  - dma/idxd which has no unplug support,
  - bus/cdx which has unplug support, but no cleanup (it should not be
that complex to achieve, but I did not try),
  - bus/fslmc which has unplug support, but a strange cleanup that
does not do much except release some hw resources,

One important point is that the series in its current form induces a
change in behavior.
rte_dev_remove (iow unplugging a device) now leaves the dev object in
the bus list.
I chose this implementation as it makes the API more symmetric
(allocations in .scan are released in .cleanup, allocations in
.probe_device are released in .unplug_device).

I wonder if this would be problematic for the vdev bus in some usecase
where many ports are hotplugged then unplugged and never reused.



-- 
David Marchand

