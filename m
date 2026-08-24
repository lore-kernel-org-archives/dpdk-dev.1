Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0AEC5DF81
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 16:24:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9722640270;
	Mon, 24 Aug 2026 18:24:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 09B6A400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 18:24:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787588685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0GUPgPJhtqTRmEcHWmLcTcGTBkeTQGe+XPLTM+6/5tw=;
 b=SaGMGBxcN1Fcgj/w9xVj2+uAxXIO8VjkTVnO37FCMdjnbSD1rtuV4n44nuqpAnFYUbYUh0
 hPOz1tGWc1CdO8WtpUaQBRfOzQpXGXuvNX8tI8iKz3vl3Jp2GaL6DHBMqfSbGPFDJhnCa7
 RhVf+0neAFBpNR8S4/rabVk6QMzuibk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-6x4kMeWLP1aJiur-S8R2lA-1; Mon, 24 Aug 2026 12:24:44 -0400
X-MC-Unique: 6x4kMeWLP1aJiur-S8R2lA-1
X-Mimecast-MFC-AGG-ID: 6x4kMeWLP1aJiur-S8R2lA_1787588682
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5aebb33d6b8so2577988e87.0
 for <dev@dpdk.org>; Mon, 24 Aug 2026 09:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787588682; x=1788193482;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0GUPgPJhtqTRmEcHWmLcTcGTBkeTQGe+XPLTM+6/5tw=;
 b=MwG8A45jt4LkWAHi8I+QpNRPmS5ykLq43h0Y5gE9mzDsFNkiGgR51RTvnz1GxszrJx
 Fx0r2Qvfhl0aqZD2oO7Zl1IusGT0ta3D2gnqSKvRbWa1iyapTjFCpxsWRhcBgtB1Zy3q
 jgPFhh88eOfivsjbZCPmQWqw2Y639A8uA6aN7yHsLm9sKbXlBVBN4RZtPmcCZl5cZM1l
 MBoTJovUVzcBfCKEZ9s8PfYmK8cOr+Ix9sWBtD1kPCM2aQZKf+CFYCA8r1wzeAaahNLZ
 PyODBkXlOiXjmOxxUD7mfp/nT6vGSyrTaUdBQf0YQVuv8XE/a/PMmX5oNvwsBxeVIh3Y
 oMZA==
X-Gm-Message-State: AFuF++nzWN+6OT6/iJ6SXup00H6Yxldi8YxpqDhU7lqIjWnPmNziLaFJ
 aX5Cxh6js/ORXjJR2iSbsvakXvMjJ8qX2NwEHlqPdbgPn2NOLtLjp8QwY4bVyhYHvJoyE4Pm9vO
 uGiG9eDuGgbNgK3/hSCJcLsFnULLfvj7AErvCnK6mr1nslsF1qfHeGcIzCYixyrZ/TDO0epX6X0
 acWWx3AfqlABNEHq//yvA=
X-Gm-Gg: AR+sD11JWiQUwptZdSa3rh8nix0zWcWRAiUmpAJ8hS4+XhReCTTs0dk3WIkq+FSgZcb
 Un2vAe2NrYahZZjZ9AOkztIMG7v/jMAuMimcsuOWb7ReA/6ijKJYUDS+0oo7y8/FmiIA0sTTNzz
 o6TV42c4KjGSrvpWs2a9fzr1wU/QkZ1trb1PNEtwvKwG5hKevw6g+mozm+kOoXYqM5pqw2j0c8Y
 AmCRO74rYRTO/ab5iSB1T/IQ0bOkocb/IlW7WLBefL2JTLR
X-Received: by 2002:a05:6512:1092:b0:5ae:af98:497f with SMTP id
 2adb3069b0e04-5b484219259mr7976414e87.7.1787588682347; 
 Mon, 24 Aug 2026 09:24:42 -0700 (PDT)
X-Received: by 2002:a05:6512:1092:b0:5ae:af98:497f with SMTP id
 2adb3069b0e04-5b484219259mr7976394e87.7.1787588681893; Mon, 24 Aug 2026
 09:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260824114207.312513-1-david.marchand@redhat.com>
 <20260824114207.312513-3-david.marchand@redhat.com>
 <20260824092125.4d074c3a@phoenix.local>
In-Reply-To: <20260824092125.4d074c3a@phoenix.local>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 24 Aug 2026 18:24:29 +0200
X-Gm-Features: AcwNN1UwTIbgsPWvungkntj-R8pVVXnrG0wnTN8fF9mEtrOy940wgH2M2tFGASI
Message-ID: <CAJFAV8zjxCTcRV39H73cZs8N=AxqQm6NJahwAnXPxDOSLUQExQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] ethdev: skip VMDq pools unless configured
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, rjarry@redhat.com, cfontain@redhat.com, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, 
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: X68WoIAZYDztHEy4KULWoDOh2LFmxzQhqUiZ6oNc9zk_1787588682
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

On Mon, 24 Aug 2026 at 18:21, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Mon, 24 Aug 2026 13:42:06 +0200
> David Marchand <david.marchand@redhat.com> wrote:
>
> > The mac_addr_add API describes that only the 0 pool should be passed
> > unless VMDq has been enabled, though there was no validation so far.
> > Add such a check, then cleanup the MAC related operations (adding,
> > removing, restoring).
> >
> > As a side effect, the net/cnxk does not need to manually reset the
> > mac_pool_sel[] array.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
> > ---
>
> Claude Fable AI review has some warnings.

Enough bikeshedding please.
I requested a merge one month ago and got ignored.

Those warnings below are pointless.

Thanks.


-- 
David Marchand

