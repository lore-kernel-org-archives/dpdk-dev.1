Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFB5C44501
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 10:04:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13C9F4026C;
	Wed, 21 Jan 2026 11:04:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 60C48400D7
 for <dev@dpdk.org>; Wed, 21 Jan 2026 11:04:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768989863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o92vd0DILwSkHYrwarVV69pMvAp/pA12Vsvve7GNMNw=;
 b=PMM5QxZY3aty8U+/hk2YtahFyimjIs7NjECXRPOOeif7i4HiWjkbJQkzfW/5EVixqlY+OF
 Uhn4Iiee5Tt39deJKsRKpX/9CEmgugLBx7LdHgFC5BiM/fgl0AjJCKnjc+2fbC/HsLBAbq
 p7gE1JceZOgzYwY9NepHQ9LVVJGs10s=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-buhooteOOQOrbbzRBGoTnA-1; Wed, 21 Jan 2026 05:04:21 -0500
X-MC-Unique: buhooteOOQOrbbzRBGoTnA-1
X-Mimecast-MFC-AGG-ID: buhooteOOQOrbbzRBGoTnA_1768989860
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-59b6cf50eb2so2930974e87.2
 for <dev@dpdk.org>; Wed, 21 Jan 2026 02:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768989860; x=1769594660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o92vd0DILwSkHYrwarVV69pMvAp/pA12Vsvve7GNMNw=;
 b=iIbjHQ7OE6Hd21VUSiNNur7plSR67UQhbYGaJMiGTZm1ysHuEom3M2qhgunk6/+TQs
 yMvBdmsJuGai06RR8ipUaBQ3zlIjOZtoFhngBdY6e20jVw8YYPxH+1ecwoo4qulqaCzW
 kk6r8N6ut3MmL3txkK11c8zeuFyt1mCv83oYuk4KcCAFxyDhKqHWW5F3s3NpxV1F7JGG
 yKRzQ5Ye0Du9a4BdM34SKPyQ+xlhHP4OToq4zNTUwiHgq5iOIQW9cF41512RSgGLRzY1
 8BMV3enyPkePN3qpQ173vAut03p5JALhSWADvB43UAQJnZ+h50dkMQ7VAY269GFj0K18
 lWvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4DR7I5Hu5S+ger4EGTsHfMg10/TNGo+eCXQ0dwWLByFDT1FYbAk2GhMKvks8AlfmmFhE=@dpdk.org
X-Gm-Message-State: AOJu0YwS1xNSHqCnE/rDZ6PjBXlmjmFBPX2jUHmIhx34otRch5tZWDUL
 n05yaDvpC46IMhAzQVBoVdW0c9uCv5+Ne0RnnBp2/eevHWL5rE9IVGUStpuOyKSqQOyS5cm/55h
 edThVAmofYVwLwWx3MN0U2PJTomQf8nzYEPSEGNwVmrNPaGVT09Vvb7zaTP0LpxG5DP/rgrvnUf
 KkSyIiHOprT+X0ytj6rSVmMieCw3KDaA==
X-Gm-Gg: AZuq6aLHstIR2ZQb92Gr6mAfKLew2cP8tMrlE7SwLXJJzmu8QJP+ix2vuIaG8z4A3j1
 ztIG4OQNr41CcbDCnZN5F30uHSFhN5sGaSswnqz7RYRPSaJtsuZ25hbMwOSivDiWpVVG6TtXo7c
 kEk/RXfJZ+gabKo3Gl4Rxt4zM8zMCtsjeInZwh/5hS6ZdiWqSuhPgN5wcX2AsMzClydhDw
X-Received: by 2002:a05:6512:3f1c:b0:594:2f72:2f7f with SMTP id
 2adb3069b0e04-59dc8f0d830mr1662207e87.6.1768989859708; 
 Wed, 21 Jan 2026 02:04:19 -0800 (PST)
X-Received: by 2002:a05:6512:3f1c:b0:594:2f72:2f7f with SMTP id
 2adb3069b0e04-59dc8f0d830mr1662192e87.6.1768989859226; Wed, 21 Jan 2026
 02:04:19 -0800 (PST)
MIME-Version: 1.0
References: <20251024185056.607160-3-dmarx@iol.unh.edu>
 <20251107215020.255182-1-dmarx@iol.unh.edu>
 <CAJFAV8x4g4yy3LO7bfKh-UzFZ=fA5Y0Q3hAvOamw2o4rFMbeKA@mail.gmail.com>
 <CAJvnSUDdXrq+=KzXdMU_2oyPQwtHUbpbR6KhV3GOOThcd1G8DA@mail.gmail.com>
In-Reply-To: <CAJvnSUDdXrq+=KzXdMU_2oyPQwtHUbpbR6KhV3GOOThcd1G8DA@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 21 Jan 2026 11:04:07 +0100
X-Gm-Features: AZwV_Qgw9D4oTLNWwjrSxxDF2mNv9s0BD56qdV9WmJg9pjfmMj878NL1MDFlbgs
Message-ID: <CAJFAV8zGwdbzks4efBg_Yh=Fs4QBHbhgPCcBiuhPfkaX5-Yhaw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] dts: add start Tx first method to testpmd shell
To: Patrick Robb <probb@iol.unh.edu>
Cc: Dean Marx <dmarx@iol.unh.edu>, luca.vizzarro@arm.com,
 yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org, 
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3R9WK0UTSBCdDhxyqiede7PqdwY-gUqnkf_c1ZrQkRc_1768989860
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

Hello Patrick,

On Tue, 20 Jan 2026 at 17:46, Patrick Robb <probb@iol.unh.edu> wrote:
>
> Hi David,
>
> Dean and I both looked at the patch from Lukas, yes it looks good and I will add a comment and tag there.
>
> Otherwise, I'm not sure how the patch could have been breaking docs given our process. Can you please sanity check my process below? Maybe I am making a silly mistake with validating the docs build.
>
> For the next dts branch, when I'm adding new patches, for each patch:
>
> 1. Apply patchseries
> 2. Run normal checks (checkpatches.sh, check-git-log.sh, dts-check-format.sh)
> 3. Perform a doc build like below:
>
> meson setup my-doc-build
> ninja -C my-doc-build doc
>
> Then, It quickly does a doc build, and (although I don't always look unless I'm making a docs change) it is possible to navigate into the build dir docs dir, and open up the html docs files.
>
> 4. Then at the end I push my local branch with the new patches added to the remote next-dts repo.
>
> So, is my above docs check sufficient, or am I missing a part of the process?

As part of this process, I assume that you look at reports for the
series in patchwork.
This looks correct then.

To be honest, I can not see the warnings myself locally (running Fedora 42 atm).
I guess there is a difference in Ubuntu 22.04 sphinx, that is used in GHA.

However, we let doc warnings for dts go unnoticed, and this should be changed.
I sent a patch for this:
https://patchwork.dpdk.org/project/dpdk/patch/20260121100127.1701459-1-david.marchand@redhat.com/


-- 
David Marchand

