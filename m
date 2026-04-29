Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E649FF8873
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 14:22:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FAB640151;
	Wed, 29 Apr 2026 16:22:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 27847400EF
 for <dev@dpdk.org>; Wed, 29 Apr 2026 16:22:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777472555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R6Sf9t7+faWRRjKQ87rHEZ8/0M5F5gh0YG2TndzGxXc=;
 b=WFC0K24sBBb/xzvowpXO7uFxbkEcdbv6MxyRpcjZ4PiCpOzy8Jcez7HV9NvmSQskQx8BjV
 WRcTUZFljoFYN7RnUeAR8xDns9GmsfcbWj5hO/MCCqa3oQbsHUICbenztgn75TkIMDT/zK
 uNHV8+1WcWNzZw68I6xZhhcjIIOfF7c=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-a7aYpwYKPeGFKC3tUwKBRw-1; Wed, 29 Apr 2026 10:22:32 -0400
X-MC-Unique: a7aYpwYKPeGFKC3tUwKBRw-1
X-Mimecast-MFC-AGG-ID: a7aYpwYKPeGFKC3tUwKBRw_1777472551
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5a40505f715so8251420e87.3
 for <dev@dpdk.org>; Wed, 29 Apr 2026 07:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777472551; x=1778077351;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6Sf9t7+faWRRjKQ87rHEZ8/0M5F5gh0YG2TndzGxXc=;
 b=RgUYwgsf/URXNeqNrTMfSMYKCZUU6vQ/1VB49IWw/kFJcCD7N4dU1s8TxG/TTh8RSK
 NdB//asvbFr7Wb8D/xiyGI2r3H84QDMqbIb/6pQl99+fkEdFROh8xTXo32r9y7Hb2xbd
 kkJkMd9bM8RCbKUkozfR4bao1YwllKEjNanyk3Cyq/wG1fxKH1T5eNP+ZkzhtsmvneZf
 nKaiWGLKleJ5lJRf52eXFx8WRQecIDS/6hGi+KflNVRD8HIDxg5aTRtnZi5Vw3DuaMSb
 m+5syAocqSGTyULlWNpx4GkDQHqY21lwWrHRWIFKxJHFZ8GWU6ntcJ395ej+2xA7igBr
 /PoA==
X-Gm-Message-State: AOJu0Yz7qaBpQsvBhwTpH8zzGkWqh/Gw6XAZtekdPe+rTigsVOl4pSpl
 xHrn2e7KHERtjn+YydNRvuZ7xYqdpduM5Gph/XOfS8u8/szSit85sHVZ42OH/o4miZtXFq0SmZH
 wrGHOOhq0phYcxD7sD95x2DwP6y0jmfgVJmUcaNrZ1kM/0zdUMx1IxAPAfFTM/wHzgQb1/fx1jH
 XPcdqXQHGaLc74YKfNBnE=
X-Gm-Gg: AeBDietgXqgBzIcUjIdHpssxEy/fsPa+A3+svT2Jv+3d6skEKfQlv3dD68CHfmO3Wtv
 EdXg67Jo2IqJKaPeKqlEPK1jDKSE/P3L/xbZ6UHIsFXMseXZ/hlRfDPHDr+rZvc4rfKVN9hLJXA
 DX6EfU6ngaVUlcV06YlDUzZ7FL24nmOy3RPTzFIcHzcrc2cE1NZEoR0Mu3y3A2m4sTsXHH+zVho
 Iom2Qe/2YtutFjCghxxGyMbJfESmzoUPb2yCYOLrQPGYozZb/jHTO5/VW7lPnLP2JB4uXuvB3+g
 GJYt
X-Received: by 2002:a05:6512:39d1:b0:5a7:46e3:2f55 with SMTP id
 2adb3069b0e04-5a749cf21c3mr1450092e87.3.1777472550628; 
 Wed, 29 Apr 2026 07:22:30 -0700 (PDT)
X-Received: by 2002:a05:6512:39d1:b0:5a7:46e3:2f55 with SMTP id
 2adb3069b0e04-5a749cf21c3mr1450071e87.3.1777472550042; Wed, 29 Apr 2026
 07:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260405114720.081a3b56@phoenix.local>
In-Reply-To: <20260405114720.081a3b56@phoenix.local>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 29 Apr 2026 16:22:18 +0200
X-Gm-Features: AVHnY4KVgXIVvioU_CaPpoUMfK_gOX1WKgPOx3fOzHHpIXz3akUyDHTtBHneZ1I
Message-ID: <CAJFAV8y79aqHz7WVsJ-cSpZh+XJh+gQuGSPrq19WYaO1NHz6_g@mail.gmail.com>
Subject: Re: [PATCH 0/4] Remove limitations coming from legacy VMDq
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, rjarry@redhat.com, cfontain@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ovgYQCks09PrsOwu9eiZs2oG3Pmfc3jJe-KicT6H-WA_1777472551
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

On Sun, 5 Apr 2026 at 20:47, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Fri,  3 Apr 2026 11:18:31 +0200
> David Marchand <david.marchand@redhat.com> wrote:
>
> > Since the commit 88ac4396ad29 ("ethdev: add VMDq support"),
> > VMDq has been imposing a maximum number of mac addresses in the
> > mac_addr_add/del API.
> >
> > Nowadays, new Intel drivers do not support the feature and few other
> > drivers implement this feature.
> >
> > This series proposes to flag drivers that support the feature, and
> > remove the limit of number of mac addresses for others.
> >
> > Next step could be to remove the VMDq pool notion from the generic API.
> > However I have some concern about this, as changing the quite stable
> > mac_addr_add/del API now seems a lot of noise for not much benefit.
> >
> >
>
> Make sense. The AI review found a couple of things.
> Had to poke at it to make a good description
>
> Subject: Re: [PATCH 1/4] ethdev: skip VMDq pools unless configured
>
> Patches 1/4 and 3/4 look good to me.
>
> Patch 2/4 has two issues:
>
> 1) In bnxt_reps.c, the new line:
>
>   dev_info->dev_capa = RTE_ETH_DEV_CAPA_VMDQ;
>
> overwrites any default capabilities that were previously set before
> the driver callback. The other drivers in this patch had the same
> pre-existing pattern (plain assignment before &= ~FLOW_RULE_KEEP),
> so for them it's no worse. But bnxt_reps.c previously only did the
> &= ~ clear, so this is a new regression. Should be |= instead of =.

The explicit &= ~FLOW_RULE_KEEP was added as a "documentation" hint
for maintainers.
2fe6f1b76279 ("drivers/net: advertise no support for keeping flow rules")

Though I don't see much activity on the topic, so this hint probably
missed the target.

In any case, dev_capa is set to 0 from ethdev before calling the
driver op, so nothing is broken with an explicit =.


>
> 2) Several drivers that receive RTE_ETH_DEV_CAPA_VMDQ don't actually
> support VMDq: e1000/em, bnxt representors, and i40e VF representors
> have no max_vmdq_pools or VMDq configuration. Marking them as
> VMDq-capable seems incorrect and would allow users to attempt VMDq
> configuration on devices that can't handle it.

This one is interesting and it seems to make sense, I'll double check.


>
> Patch 4/4 has a stack overflow:
>
> iavf_add_del_all_mac_addr() allocates list_req on the stack with
> addr[IAVF_UC_MACADDR_MAX]. At 32768 entries of ~8 bytes each,
> that's roughly 256 KiB on the stack. This will blow the stack
> on most configurations. Needs to be heap-allocated.

The heap allocations were removed recently, I'll see how I can rework.



-- 
David Marchand

