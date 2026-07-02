Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478DBC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Jul 2026 06:53:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CFAD402C5;
	Thu,  2 Jul 2026 08:53:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5958E402A3
 for <dev@dpdk.org>; Thu,  2 Jul 2026 08:53:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782975196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nY4yiPa+/eHu1uIxX0EbMYmwxqk/nxKDe/85/lfuswE=;
 b=MCoHLOl6YSjfiXI5KFEvdZzoBaRhtO55ELII2cx+Tij1cta4Pa7qwGkyv75EFdaSuDCNn5
 CDgjjH9ZUH/NU+1jtpmx5SVIUQyb9gLIat7bd01O37p5DMskIVvycAHeqn4UN0qAKh4T28
 K0QOmbCTCdTlaycsn2NqlGXKDm8uXAg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-xlk3LforNeCWGeSTzvEjcw-1; Thu, 02 Jul 2026 02:53:13 -0400
X-MC-Unique: xlk3LforNeCWGeSTzvEjcw-1
X-Mimecast-MFC-AGG-ID: xlk3LforNeCWGeSTzvEjcw_1782975192
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-39987ae63b5so6534221fa.3
 for <dev@dpdk.org>; Wed, 01 Jul 2026 23:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782975191; x=1783579991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nY4yiPa+/eHu1uIxX0EbMYmwxqk/nxKDe/85/lfuswE=;
 b=IzqtWCVsElvElLx2kzJ2QtrZCS3sFhYsjaLUbRFYNebu+sxTOiTJfY1U7SMGZOo2bS
 KcA+g10QAik5qzuBrCyl9gVtnGw8Huir5DH8yY+GzqwO9kBipGtw2dRBD3e73I0/iUZV
 guNbS8elu+ehMCN4X2D54yIUAFmiYkRyUxwq3uUz0DdpS/liERgs4PB9CoaXqb0ojZC9
 BgjjLDUaPYFLIM5kW6hRCshbHjPmNo3uhVG+xMJf6Tjm8Ya5M2pXBFoycJexfaDX1oFT
 f6ry+RxGoxYI/93wRrr8h2Dj5qJG14jfRIscWxZdjrY+fHo7G+010LMONx2pri+8hwiG
 Thdg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqMoJqfbGOFG0kIzW7kLgbMW91vZPb5KS3230b0Lw/h8i8X7RMoC1BBeY0N68KgTwPuzq8=@dpdk.org
X-Gm-Message-State: AOJu0YyujWXWUjvloANDErxhdhK+MRR9zV2DHnzbiLkQx0RQ/btLzGUm
 wR4rnFNgEdBMwpnmK0w4JPtW816vcWIpjAt1irHEVNSFiRIE5sjZqSIx7orFcyjQVfVens3KH5r
 d4n2JtqaUjaX2i8EmbOTKcfFFW3LwRUuZ+8VRpsuA85HaulEgH6WJe4aLTbhteJw0tS9sZuAMDT
 kcNpTVZ32YRV/6FQb0c2c=
X-Gm-Gg: AfdE7cnV9kJHt+vuidrjiOZnVzOS+3oQbjxAVkSkM3hhMfoZCIGpED0HotK0cUXdnc4
 RVQASk6YL9B0lh+lCj6h8i5HMYhV2PzjwgJiiWcCTL7keTin4IHbxqUOwHiZwBtU9BIOIpjL1Lv
 x5dEHlO82jVC9o3zrghClrNlJGDv0meNNEqrCHQRJuTCqPt+VUmjnkxpYFNze9mWD9qJPIBaST6
 aZnfv82u+n0g436Fec3H8VEMJuAsnt/RqmuErcAKmnd4QT3PBD8ogGaigQ=
X-Received: by 2002:a05:651c:25cf:20b0:39b:1c5:521c with SMTP id
 38308e7fff4ca-39b36f89c63mr6481031fa.35.1782975191582; 
 Wed, 01 Jul 2026 23:53:11 -0700 (PDT)
X-Received: by 2002:a05:651c:25cf:20b0:39b:1c5:521c with SMTP id
 38308e7fff4ca-39b36f89c63mr6480911fa.35.1782975191049; Wed, 01 Jul 2026
 23:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_FD79B9DBEB2FD074BFAAACCC6DD7A6EBB906@qq.com>
 <CAJFAV8wOpRcDPip62f4EuAv_HDK_PuoGf75ZdqiKX3Er14OQXA@mail.gmail.com>
 <CAJFAV8z1qo-C7jvoUAWSuaysiB-7Lud+XkPgUEED_uAMGGAuuw@mail.gmail.com>
 <257fb8fd-2850-4b31-aa9f-c1ef42897e7b@huawei.com>
In-Reply-To: <257fb8fd-2850-4b31-aa9f-c1ef42897e7b@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 2 Jul 2026 08:52:59 +0200
X-Gm-Features: AVVi8Cd2NhNEHg7QLc8GL2Fcy-tjOxg4mrM2URyt9Q8j_DT9pizvIqqfQ8OxVAQ
Message-ID: <CAJFAV8ytRF4jjsM=Euoij3=76BgRCCZPk-7MX7iCWv4zetz6yg@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix dmadev incomplete ABI validation
To: fengchengwen <fengchengwen@huawei.com>
Cc: datshan@qq.com, thomas@monjalon.net, dev@dpdk.org, 
 Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NCN_DN6Hu0AYd7M4MraGIuba3supMIfkHfLEJ4u-SvY_1782975192
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

On Thu, 2 Jul 2026 at 03:35, fengchengwen <fengchengwen@huawei.com> wrote:
>
> On 7/2/2026 1:01 AM, David Marchand wrote:
> > On Wed, 1 Jul 2026 at 10:11, David Marchand <david.marchand@redhat.com> wrote:
> >> On Tue, 30 Jun 2026 at 15:24, <datshan@qq.com> wrote:
> >>>
> >>> From: datshan <datshan@qq.com>
> >>>
> >>> Fix dmadev incomplete ABI validation.
> >>>
> >>> Chengwen Feng (2):
> >>>   dmadev: fix incomplete configuration validation
> >>>   test/dmadev: add config and vchan validation tests
> >>>
> >>>  app/test/test_dmadev_api.c | 186 ++++++++++++++++++++++++++++++++++---
> >>>  lib/dmadev/rte_dmadev.c    | 156 +++++++++++++++++++++----------
> >>>  2 files changed, 283 insertions(+), 59 deletions(-)
> >>>
> >>
> >> This series is not versionned, but I guess this is a new revision.
> >> Don't forget to flag your submissions with a version number in the future.
> >> I marked the previous patches as superseded in patchwork.
> >>
> >> Also provide a high level summary of the differences between versions.
> >>
> >> All of those steps are listed in the contributing guide, I suggest
> >> (re-)reading the whole guide, with a highlight on:
> >> https://doc.dpdk.org/guides/contributing/patches.html#steps-to-getting-your-patch-merged
> >>
> >> Thanks, I'll try to find some time to review this week.
> >
> > Well, enforcing *now* that some fields are 0 is actually breaking ABI
> > for existing applications.
> > This change should be deferred to 26.11, and backporting to a LTS is
> > not possible.
>
> OK
> BTW: Should I submit another version in 26.11 cycle or do nothing?

I'll mark those patches as Deferred in patchwork.
That's enough, I will apply them after 26.11-rc0.


-- 
David Marchand

