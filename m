Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B06ACC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:39:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAB51402DF;
	Thu, 15 Oct 2026 16:39:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A981F4027C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:39:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792075140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FDsnifB7BsSAIeZmBPITXCpTAdUrbShUB4SeuWFBYcA=;
 b=MTv5Uo6V2Khlx6UOOj4dYPYRmIm9byiXcFdjrcTT/gDox5gAw2PuuT7lrwqakjjd2Zu1U9
 dpSzkBNl2+vdWkvBy6Bjygr9EOF9ki2KQRgJc4zRBIz5p4nAs4rjaVoYVa3Bfn539VLtJl
 KisqAQUKKX8dN3Jqk64eO8QTTWeVLXA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-IGTowP5dNseaJXC7y6QcKQ-1; Thu, 15 Oct 2026 14:38:58 +0000
X-MC-Unique: IGTowP5dNseaJXC7y6QcKQ-1
X-Mimecast-MFC-AGG-ID: IGTowP5dNseaJXC7y6QcKQ_1792075137
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5ba3f707a6fso2787114e87.0
 for <dev@dpdk.org>; Thu, 15 Oct 2026 07:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792075137; x=1792679937;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FDsnifB7BsSAIeZmBPITXCpTAdUrbShUB4SeuWFBYcA=;
 b=QPG3dm4dsmkin7mkpLUXNGkyT/3owz5jINKNvVPYZGOtYKLNwUzl3rWa6Nebj/FWUm
 t5uTRtXF8DYOI7Bw2eWNAD4+RsKoTiojfH5PCuLGU+Zszjh7/mL4k5PYUu1xQjFrO0ZP
 YmUoDKIQk0n9eJMYQdlwr/zeKlGZknrk1Jd4pW+k0Uef1wkiWFYDwcfLPI6+6yxsseMY
 DRixBo+rp1gIfZJy/sbf/pzgzJtEmN3MFIhqK8f26olIFVOTwFNy5rNCa22NXv+aUthF
 jJlfzBClg87rMEy/qKrXUQFkc+CKqRai6Hiq2Vp5LkTKnN57dvYKNiykBI0xLROvRuj6
 VECw==
X-Gm-Message-State: AFq9FYJmrJkP0NUQrAMMdIf0zF3KY8rSQAuQbKmNDQ3H40n9fiSLS0hG
 JekRz8kK4g6mKrajKWARyLF0P/oFMk/tGARBu6TGR76+ZVL/g/SqmSz+AXrs7PHSOD1wQjP2jj1
 ItWztUbME+u8X7+X9rfJyRUPxeJUf8a7PobqR0ygR6EhgB4vOgYEwgLUYermbzSKgYUTVTF/YRp
 T4yr+G6eeXTFSK1AOTuhc=
X-Gm-Gg: AYBFou24veI5PvQSjgprJYjnWS9xbYvi5EUGpWEmn6H1Q6iue42rNg4EurUhS0ZCzvl
 CWKahCaQ1hzFZtr3kqnIdoi1ef3uCSyZ1HQ3K9oGL/5wvLi/xYN8Fddp2I9Nn/FgEglLpXoo+gW
 Scc/hr3sRakkj5zEiUWWarh12a/eJM5VRYtQlF/Hk5kPZGvn7XkfeJFh2gL1HTzAA69i1nDgiGp
 7Z0eAMBWIRXDfkaF1IVGP7WeFI4gVX277SP92uamx3usnvH
X-Received: by 2002:a05:6512:3e04:b0:5be:3db4:5665 with SMTP id
 2adb3069b0e04-5be3db4582cmr854491e87.7.1792075137010; 
 Thu, 15 Oct 2026 07:38:57 -0700 (PDT)
X-Received: by 2002:a05:6512:3e04:b0:5be:3db4:5665 with SMTP id
 2adb3069b0e04-5be3db4582cmr854485e87.7.1792075136583; Thu, 15 Oct 2026
 07:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20261014192153.2693883-4-rjarry@redhat.com>
 <atCDBq7wWE6p-hP1@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <atCDBq7wWE6p-hP1@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 15 Oct 2026 16:38:44 +0200
X-Gm-Features: AclHuK-3cUwP-Sc2M02uvbcuEiyzyugFq18lmxHT0AzN4lSLXz3Lu9QUsBIFC6I
Message-ID: <CAJFAV8wz1FKp4beYTXP8uizSd20-FC5xybYydeLPkr4rgOTuYQ@mail.gmail.com>
Subject: Re: [PATCH dpdk 0/2] lib: remove niche libraries from always enabled
 list
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _3IBfnQ6y-diOEFO8U9T08WwzXaQgNjjnxchwG9UphM_1792075137
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

On Thu, 15 Oct 2026 at 09:39, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Wed, Oct 14, 2026 at 09:21:53PM +0200, Robin Jarry wrote:
> > Some libraries are only used either for internal apps/examples (cmdline)
> > or by a specific mempool driver (stack).
> >
> > Everywhere they are used, an explicit dependency is already recorded in
> > meson. There is no reason to always enable them.
> >
> No objection to this, however, I actually have a more complete RFC almost
> ready to send for the next release, which goes even further than this by
> doing initial dependency analysis on all components and using that to
> compute the minimum set to enable. Specifically, if we assume the minimal
> set is EAL + whatever is needed to build the always needed basic
> infrastructure drivers, the RFC finishes by computing the lib
> "always_enable" set as being the dependencies of
> "bus/pci,bus/vdev,mempool/ring". [As for why that set of minimal drivers -
> if we omit them, lots of things in DPDK won't function, and we cannot
> guarantee that any other components selected will depend on them. For
> example, nothing else depends on mempool/ring so if we want working
> mempools we have to have it in the enable list]
>
> I'll try and get the RFC out this week to at least get the conversation
> started in advance of 27.03 opening up.

Looking fwd to this RFC.
In the mean time, this series is simple enough, applied.


-- 
David Marchand

