Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2C8C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 17:01:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28C0E402D2;
	Wed,  1 Jul 2026 19:01:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 52B1640279
 for <dev@dpdk.org>; Wed,  1 Jul 2026 19:01:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782925287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1fNg/KDTqasaJg0XgRlZH76rwn7AvYYgzQKevgTxmB0=;
 b=MLwC72BeTfO3kzteg3izE5nt8V4jx+Hx83CduMLHBvygEleImAujTpRHnyqHAG75RIEr3M
 +CVRGwHjmI2KC+slb+fXRmwCDKH2Bi7U7BdyF26asIiuzgFLVPVnNblyaGkRIQ+36nLs+3
 vfneghJghq1dxqfqDAobUgbGMBtH/b8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-u0NfNG5XPbSGird0mcL3kQ-1; Wed, 01 Jul 2026 13:01:26 -0400
X-MC-Unique: u0NfNG5XPbSGird0mcL3kQ-1
X-Mimecast-MFC-AGG-ID: u0NfNG5XPbSGird0mcL3kQ_1782925285
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5aebe29f8cfso735462e87.0
 for <dev@dpdk.org>; Wed, 01 Jul 2026 10:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782925285; x=1783530085;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1fNg/KDTqasaJg0XgRlZH76rwn7AvYYgzQKevgTxmB0=;
 b=PL5eKWstQ1wKf9spNxGn8rGBP/abx1JR+PZZEw8nqPISqTMCmF0y0h0yOu7B98TlE/
 qK9n7+rP6lxE8pNmYGHcIqc4yTiGN7XdnYrNWjUSxPCYp+Hfv7/sXdFfnw0VP2BZZIps
 9EjCpAfgddivxghO4bXKpDD1aGFR2KT+kVpnOHjD6ybR6ph9YzgpmBZFFVMGbxM3ZgNc
 cA32m7ujE2dmJ4X0RVF8P4tqO8V3chtBY7Z98aY+2v1mURw0RpYUj2RthECJUvzekuTO
 vg39N3v3YJdZoJX6puMsJH3xpnOSd63qr7e7Bxpn2JRudV7fZvSpfct+LjZ7BjTmAhxw
 gLYw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrgWnw+4KnCLJzpJBVdDoxzIz5BSlOCYbTjqmtZLwJRM/QFIFZhAhWl10tWNUhufiiCScs=@dpdk.org
X-Gm-Message-State: AOJu0YywvMIrwnUBfI1NCcWpktOJ7qTRgwBS2yqgd/JseRgLvdfYHLqo
 yixL3nykxmHKKrZMkD+MFRv8xBP2Bl8fMfN02UkecCPxJaSIa8J/xS7M8ldyM2XX/Rvxa3RqbN4
 bKWMnlaEHOYC1OzLmj8C0il3yOdOYR8Th5fDDHBFgnx4ZZ0lCwukaBMtLiS4+ot7KSEU1p65c+u
 jkjDfMohzvkOPgKjD7AXI=
X-Gm-Gg: AfdE7cmUshOnuQlQ63EtPG3i53ltRNmANuC+qp9W6b46IHjQrTXLEid39vdzfYmGWzp
 nClFzazTWpVW/R4Ep2iXTdOoInhcIvGr5HZNltSsaOpKx/tom94LhgqlS3Igz3m3KMP2j0Li8NK
 1QVr4KwGwWhHmbH0hpVIpY23L+OKSXN4Y6vydEXTy3kVi6QthyRAVPo2Y7zVcwkebtlnrJbqK7C
 VF2iPE6LP1WWvGNi/QO6DxmzjcQFpQ8zsdCO6b4/XV/YV+UTppkarZJj6o=
X-Received: by 2002:a05:6512:23a2:b0:5ae:aa02:4c24 with SMTP id
 2adb3069b0e04-5aebf97f803mr1688899e87.24.1782925284956; 
 Wed, 01 Jul 2026 10:01:24 -0700 (PDT)
X-Received: by 2002:a05:6512:23a2:b0:5ae:aa02:4c24 with SMTP id
 2adb3069b0e04-5aebf97f803mr1688881e87.24.1782925284299; Wed, 01 Jul 2026
 10:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_FD79B9DBEB2FD074BFAAACCC6DD7A6EBB906@qq.com>
 <CAJFAV8wOpRcDPip62f4EuAv_HDK_PuoGf75ZdqiKX3Er14OQXA@mail.gmail.com>
In-Reply-To: <CAJFAV8wOpRcDPip62f4EuAv_HDK_PuoGf75ZdqiKX3Er14OQXA@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 1 Jul 2026 19:01:12 +0200
X-Gm-Features: AVVi8Cc7v2zPnot2RGBhf5BR2um6oDsXBDVN2NduHjtOWw93rtDwxwZaleTNiyw
Message-ID: <CAJFAV8z1qo-C7jvoUAWSuaysiB-7Lud+XkPgUEED_uAMGGAuuw@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix dmadev incomplete ABI validation
To: datshan@qq.com, Chengwen Feng <fengchengwen@huawei.com>
Cc: thomas@monjalon.net, dev@dpdk.org, 
 Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SyaDJ_iWePeNzG3PufBccaDmPbDjlXwCw1Mn59uqxaA_1782925285
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

On Wed, 1 Jul 2026 at 10:11, David Marchand <david.marchand@redhat.com> wrote:
> On Tue, 30 Jun 2026 at 15:24, <datshan@qq.com> wrote:
> >
> > From: datshan <datshan@qq.com>
> >
> > Fix dmadev incomplete ABI validation.
> >
> > Chengwen Feng (2):
> >   dmadev: fix incomplete configuration validation
> >   test/dmadev: add config and vchan validation tests
> >
> >  app/test/test_dmadev_api.c | 186 ++++++++++++++++++++++++++++++++++---
> >  lib/dmadev/rte_dmadev.c    | 156 +++++++++++++++++++++----------
> >  2 files changed, 283 insertions(+), 59 deletions(-)
> >
>
> This series is not versionned, but I guess this is a new revision.
> Don't forget to flag your submissions with a version number in the future.
> I marked the previous patches as superseded in patchwork.
>
> Also provide a high level summary of the differences between versions.
>
> All of those steps are listed in the contributing guide, I suggest
> (re-)reading the whole guide, with a highlight on:
> https://doc.dpdk.org/guides/contributing/patches.html#steps-to-getting-your-patch-merged
>
> Thanks, I'll try to find some time to review this week.

Well, enforcing *now* that some fields are 0 is actually breaking ABI
for existing applications.
This change should be deferred to 26.11, and backporting to a LTS is
not possible.

Opinions?


-- 
David Marchand

