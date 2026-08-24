Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7047EC5DF9C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 16:06:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A93740270;
	Mon, 24 Aug 2026 18:06:49 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 45ECD400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 18:06:47 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-84a4d8fd6ecso3803458b3a.1
 for <dev@dpdk.org>; Mon, 24 Aug 2026 09:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787587606;
 x=1788192406; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rppV09UU59ePhsR23FPsM47HGt9djHtksFC19fqAC3s=;
 b=AN4bWRdxdM6zdFGt0fIZgwtzm4nRdWEee/ufCO3odsRHZUxZM/UfLQABqCy/h8kUOb
 WnYwVFE6u3e553apAnWW5aDE9UrDltNoBcISMvcvmQt99AOYKnZxWbOJtF1Pnz8rO6WI
 +sApocwviQH0e9BhEjDhWR3jvH41XX5rKLwW2johehp0o2+/vJTEXhg0C4djMkQ4Bd9C
 lKTIq7WEA3gp0jAfleJyqJKvsc+et0+gapZxbI3emez3PDYH90drCKLqHcodHDgtfh8z
 ZU6shlek7QdwccNJ+IVeZn2byJ2W2clbKp52WoTz0wqOOL+CKxZ3iwxT9JTeXbqz9L7g
 z7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787587606; x=1788192406;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rppV09UU59ePhsR23FPsM47HGt9djHtksFC19fqAC3s=;
 b=aWEPdNyCX31ITE1awQaIygyIQSw+THyvJzhTp6pK0JoYaXUcIxWvGE0Mo/4+71RZWp
 G7iTMqQbDtxvSLOS6/fReBX4qIWlifawyrRsCC7IvEhsnNbqQCuBQkQxk4m6yCH47jyj
 VlGKsc8ACdtkM46tROC88HhqWL1KFW8tTpHMGeAISIkSvmG0RYt8CdMKqIgRPe57/HV/
 ztKo0G1FbOS7Sb3KW88O65HUSJ41E2X3J7nzrElvGqAccqlY84QEMhfh+0e+CZeYR8q2
 xv7SdMUCHVsCAyc23/r6zGabQjltCr/eVn2mqCVxEP+AmlDloG8qHdVuAtyOm1pK27/Y
 meJQ==
X-Gm-Message-State: AFuF++mlmgKFZfTIk/KuV1eKqWY34T7TYCPJVbOkKGwBhI7nPSV7vRjl
 sLa5CkuNE9myTt1qYeMJHgbavcgxMzKCviSl0AlKBekFqWc6JSSL1CkewpqoXsWVHWc=
X-Gm-Gg: AR+sD11biB7Yr8Q0q4cW18QWP8+8VpEQdjx+gXnhp2sXUcbDqnAkCBY4BHt9BWJN8LE
 tMAhWlmtZ0x/0BwHbtXXai6B8G4OciNz9gjhzOqkpXYM0mIhMjBZn1G9VvmIxzB9bHnZaKGydpf
 wFa0WDkCWutpliYjUiKwOj3OkWGZ9YvHCZF1xrL4JfvXvLLMJbXT+k2+WWV/kSC6pBa9OwXX4so
 DPkkpbEEM5c+v186helykAhSneRTWbE9QiNNg+wEO9u6LpV1ET3KqmIOZGGV0f/KFwwsEXgUgip
 NCSyDl/lCP+Hhe0JaYQdvAS/vJhrmGTHj3oJzW0qr+83diknzUDLNXWFbZYc+RmLXLhtJ5RzdbX
 TD1t15wUcH/iLO8r3wPAdMlWyQfUpWhJi/NU2am3QiQV5CPr2sg68fddoFrKHrR4OdnaZZFE5LP
 tZ6dCUV7IkigLs9knPVJPh44YzBumroP8hqcuEVzlwzdB4wb38Se0t/Dr3XKP/S60eKGv7bBB6a
 Pyw3GTubZsFslhr3OGbOlE6conaLA==
X-Received: by 2002:a05:6a00:1884:b0:852:2ef:c05c with SMTP id
 d2e1a72fcca58-8520beb3763mr33407871b3a.17.1787587606072; 
 Mon, 24 Aug 2026 09:06:46 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8520ef2f573sm2101305b3a.23.2026.08.24.09.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 09:06:45 -0700 (PDT)
Date: Mon, 24 Aug 2026 09:06:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Viacheslav Galaktionov
 <viacheslav.galaktionov@arknetworks.am>, Andy Moreton
 <andy.moreton@amd.com>, Roman Zhukov <Roman.Zhukov@arknetworks.am>, Pieter
 Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH 1/1] common/sfc_efx/base: clear VADAPTER stats upon
 allocation
Message-ID: <20260824090632.687d7e6e@phoenix.local>
In-Reply-To: <20260824112647.27146-1-ivan.malov@arknetworks.am>
References: <20260824112647.27146-1-ivan.malov@arknetworks.am>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 24 Aug 2026 15:26:47 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> The probe-time clear in 'ef10_nic_probe' runs before the VADAPTER is
> allocated and so cannot zero its counters. Add a complementary clear
> to the point at which the VADAPTER is already in place, so that
> VADAPTER statistics begin at zero for both PFs and VFs.
> 
> This change affects only Medford4 NICs within the 26.11 release, where
> Medford4 VADAPTER statistics have been added in the first place.
> 
> Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
> Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
> Reviewed-by: Andy Moreton <andy.moreton@amd.com>

Looks correct but Opus AI review spotted something.

Review of [PATCH 1/1] common/sfc_efx/base: clear VADAPTER stats upon
allocation

The new failure path is correct: fail6 frees the vAdaptor only when
alloc_vadaptor is set (so the EVB case, where the vPort belongs to the
vSwitch, is left alone), resets en_vport_id, and falls through to the
existing fail5 unwinding.  efx_np_attach() runs in ef10_nic_probe()
before ef10_nic_init(), so ep_np_handle is valid at the new call site.

Warning: the code comment and the commit message do not match what the
code does on the family they name.  efx_mcdi_mac_stats_clear() splits
on efx_np_supported(), which is true for EFX_FAMILY_MEDFORD4 and
later.  On Medford4 it therefore takes the netport branch,

	efx_np_mac_stats(enp, epp->ep_np_handle, EFX_STATS_CLEAR, NULL, 0)

which never reads en_vport_id, so the comment's "do it here while
'en_vport_id' holds a valid value" does not describe the Medford4
behaviour.  Conversely, it is the pre-Medford4 families that use the
vPort-scoped branch, efx_mcdi_mac_stats(enp, enp->en_vport_id, ...);
the probe-time clear there runs with en_vport_id still EVB_PORT_ID_NULL
(0) and the new one runs with EVB_PORT_ID_ASSIGNED or the vSwitch
vPort, so Huntington/Medford/Medford2 do see a behaviour change as
well, contrary to "This change affects only Medford4 NICs".

Suggested fix: reword both to state the actual reason -- the vAdaptor
counters do not exist until the vAdaptor has been allocated, so a
clear issued at probe time cannot zero them -- and either drop the
Medford4-only claim or explain why the extra vPort-scoped clear is a
no-op on the older families.
