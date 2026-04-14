Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B9EED7BBC
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 10:43:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D939402E1;
	Tue, 14 Apr 2026 12:43:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9F057402DE
 for <dev@dpdk.org>; Tue, 14 Apr 2026 12:43:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776163411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HUGAG8bdNf1MvDMtmUrZ1G5agDnCYQARrtxxOAiZUPw=;
 b=OpMjBOebpQCE5pocbOc0gCDrfyxX4I4cQLjEHXf21cqzQhI8Z9gHlGRa9Uxbr1KSb5+D6O
 tAGOu0BmV0RRUdIowdNLBwI88U1RNQXsJBQFTzp/5FOJngD5mPv0RdW4tJy4Fi7cThgqmG
 FE7lU30eqlR3VJpPhPhU8iW75ZJc+p0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-Ak_vxkR9O7-tzthc7Ip2Kw-1; Tue, 14 Apr 2026 06:43:30 -0400
X-MC-Unique: Ak_vxkR9O7-tzthc7Ip2Kw-1
X-Mimecast-MFC-AGG-ID: Ak_vxkR9O7-tzthc7Ip2Kw_1776163409
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b630753cc38so8582557a12.1
 for <dev@dpdk.org>; Tue, 14 Apr 2026 03:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776163409; x=1776768209;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HUGAG8bdNf1MvDMtmUrZ1G5agDnCYQARrtxxOAiZUPw=;
 b=cibtJNLNKRN6y9aapWJP73gAjUs+xiUQP7WglwHZgQgGkyVBbQ2o/HiEqEAL1uVVhJ
 5cPB7tVcGXaMFGfHn5peCe3oRXL2Vekmvy/CFAy/XXaffBD0WHBYMYMINITcDjxElR0r
 O9FfQ+8FDpPOvE0Lg73DQ0StNJx5AmqzwDr+nmzDaOjUDm/ZW9+mWgcAAgy6KQuDZddA
 R57ISa0Frb219FL7JEO1tPgVnU1PAEgTKrjmTrRYz2BJjtPI4xTbtshPq/Y3CBswJVux
 ZCG8xnqqgLUogLpSf4lQxX4RWXDcHrAUagSW0ec3b+M1bNGiRt62VAhQxke4tYDSpOqc
 oXxA==
X-Gm-Message-State: AOJu0YwAqrIqE5HuZD2kcTTapH86zKrteIUrHBeSZPVseIkBNN7GyHwM
 iUHlOECN2XjCr34CqfvzAywa800EVO7wIniNqTkKRJfOCoN9QRroZP/v5k8KACisUt7bAMtJcw3
 V7nnS47r4OBznmUUeBHG65OMBszjSAAFGfxenlr+6+AeEuBTbe8xM+eDmKEklzqpugsLxQWMlmo
 hcN/onZ/89AE9DVlENr4E=
X-Gm-Gg: AeBDiev4j528wDGE48+UwNn+2IcFDkPF/HnqAwij8aM1C8kP9G/e8981x1raYP0Pp73
 s1PraX1f3j+/fUBThwOrESgv6v2xiwSqlfRFnZkcr/aUGlP74kZXG1vcI5ZbRPdYmnLyOut1dcB
 fUjtRNLY8K74XxURRhNigZEwKGz2f5q7HrE9nPqRSRDVhhoT/5xGuUt+xoZSJBCgP64w5gYYIqE
 CQmOQh8DurtZQ4eEBeJn18KgYUtxVD1FjBA3qubQ0Rpoc45GaIGSR5p1BBMlevTkMbXxQ==
X-Received: by 2002:a05:6a20:a108:b0:39b:d6e0:306 with SMTP id
 adf61e73a8af0-39fe4062218mr19142216637.49.1776163409452; 
 Tue, 14 Apr 2026 03:43:29 -0700 (PDT)
X-Received: by 2002:a05:6a20:a108:b0:39b:d6e0:306 with SMTP id
 adf61e73a8af0-39fe4062218mr19142193637.49.1776163409031; Tue, 14 Apr 2026
 03:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260407115211.1903623-1-david.marchand@redhat.com>
 <20260407115211.1903623-6-david.marchand@redhat.com>
 <2054977.usQuhbGJ8B@thomas>
In-Reply-To: <2054977.usQuhbGJ8B@thomas>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 14 Apr 2026 12:43:14 +0200
X-Gm-Features: AQROBzDR9EdJ6frpKcJ39hQxMbztoPUh4xZ4IpJXU4VRsd2FB26of8hHWDyMPAM
Message-ID: <CAJFAV8xOHw3bK8J+9Grcd9ME4FKn6MKUor2a1fP10PoXiBc=Ew@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] bus: factorize devargs lookup
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Maxime Leroy <maxime@leroys.fr>, 
 Kevin Traynor <ktraynor@redhat.com>, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, 
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, 
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>, 
 Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, 
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, 
 Kevin Laatz <kevin.laatz@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aztnHW_XLVtgWjdBHfHMGI5fxL_pnvxbVY8mZOVn-pU_1776163409
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

On Mon, 13 Apr 2026 at 21:18, Thomas Monjalon <thomas@monjalon.net> wrote:
> 07/04/2026 13:52, David Marchand:
> > Each bus reimplements some similar devargs lookup code.
> >
> > The differences are in how some bus (PCI, VMBUS etc...) normalizes the
> > device names. We can't use the .parse existing handler from outside the
> > bus code itself, as the size of the bus specific device location address
> > is unknown.
> > Introduce a bus specific helper to compare two device names and
> > hide this ugly detail.
>
> I agree with introducing a new bus helper.
>
> [...]
> > +             /* The name in the devargs is usually prefixed with <bus>: */
>
> Is it usually prefixed or always prefixed?

"usually", for legacy reasons (like PCI address are understood as is,
or with pci: prefix).


-- 
David Marchand

