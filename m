Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23A8C4451C
	for <dpdk-dev@archiver.kernel.org>; Sat, 18 Jul 2026 07:47:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFB87402C1;
	Sat, 18 Jul 2026 09:47:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A3C1F40290
 for <dev@dpdk.org>; Sat, 18 Jul 2026 09:47:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784360860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yCJB3q7UFsAn81dBQyyuQFB3uW/sxxZoytm5q8jJsvA=;
 b=FYZa86PZcWDZT9CJ0IvcX7alp4MIMRnoK0I/djFg4/hMkpbYOfISWgXRDpg21qeRT0Vg+E
 P9i4SN9bkNgYSrBMrFXz51MybOoId6Pv6kAjRNcst9WfQZCkI0NeCANuTTd0q2foQrVnA+
 77kUZooh7TrWhKAig0p3w9CLPChKCmU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-L_lL-4RgMoyWrbjqS3u-nQ-1; Sat, 18 Jul 2026 03:47:38 -0400
X-MC-Unique: L_lL-4RgMoyWrbjqS3u-nQ-1
X-Mimecast-MFC-AGG-ID: L_lL-4RgMoyWrbjqS3u-nQ_1784360857
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5aa68dae27dso3382918e87.2
 for <dev@dpdk.org>; Sat, 18 Jul 2026 00:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784360856; x=1784965656;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yCJB3q7UFsAn81dBQyyuQFB3uW/sxxZoytm5q8jJsvA=;
 b=cvd+jKTqfWaxuQ/PwhXNhJEHo5ctWClFKMekPPQNaVigRRJ+sFRWvkVhcxzal7JIdi
 75BghOcx3vca0dYeOZQGJGDtYMhENizpBm+96+PNB4ImfEqSh3JtpApofH4E0gKyCZx/
 n8hPZoMQuucvdt+z+FLXIOL+yRbENjaI5/RMwsBB8VD37ptI86G0DeNgZ04WeWcQhLQP
 Rf6qhDN5tNRYpjBRlNTUn5BV+SV0YzRuwxLCfF/1cYM3rOKIZQvVlTBuXhhcxvQRKJvm
 MHNEvZIVY8/WX/ekFqr3nfeQ0wOmK+QAYgkvbKzQMnhfH1RD1bjrjfG8W9jDNLsDF5sm
 YzPA==
X-Gm-Message-State: AOJu0YxUN4CbINi7HLJxIAzCC/wzcF30qghlOmFu6sUW+Kr2M0jts7Z4
 AQ4l2YvKdeYT7+Mne8Hbn0a3xD7XL6vvw9ZWNN74PK+GQXtNQEkptMSvmDCCYvlP4eIjVGFCYSJ
 VMpDZ85pV6QiGVtKCtDZdR/IAq9goI77K/7itvotBLCZmMGtg6w8ZUZ6bntDphE64uoNzR5w32/
 GXHmhd/G/6AWbbtXcl9xo=
X-Gm-Gg: AfdE7cnkqq7igcKAoKrMGUgkg/Ty2zMsV9BB7mXqJcOkjMVGbhlC0vL6UwZkREvtV2/
 TTeMV4Ll6yc8gegNzrWDRICgc8+Zi8uYiZj3FtjZhNTnVJRrHbxU2EjlTuQFGTs07ae8aKtzO9J
 GWrcXPi4XZE4/z1egYb3P9Fg0oK69S+0mxlCIuSUypP4aApD5eS1SvwNMIRiaotnCFPsfr6fHot
 R0BirG+3nlWTRRGAAM8R5wgyWqJnadyzKiJnqUx/2YgoxYB
X-Received: by 2002:a05:6512:3da2:b0:5ae:b5ec:62de with SMTP id
 2adb3069b0e04-5b28f87311fmr1253408e87.11.1784360856491; 
 Sat, 18 Jul 2026 00:47:36 -0700 (PDT)
X-Received: by 2002:a05:6512:3da2:b0:5ae:b5ec:62de with SMTP id
 2adb3069b0e04-5b28f87311fmr1253404e87.11.1784360856009; Sat, 18 Jul 2026
 00:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260717093006.229370-2-david.marchand@redhat.com>
 <SA1PR11MB82808D1A33417DAF40BD6761F8C62@SA1PR11MB8280.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB82808D1A33417DAF40BD6761F8C62@SA1PR11MB8280.namprd11.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Sat, 18 Jul 2026 09:47:23 +0200
X-Gm-Features: AUfX_mzFDiW6gtCyEvAGow3kDhG7djcIppQyvh3Ce3NeK5cRWVURAhJQmW0MT-c
Message-ID: <CAJFAV8yfA1YBbux5VZm4c--Ft3ZSxLmJUDdE7kx0h76X96NXUw@mail.gmail.com>
Subject: Re: [PATCH 01/10] bbdev: fix stats aggregation from queues
To: "Chautru, Nicolas" <nicolas.chautru@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>, 
 Maxime Coquelin <maxime.coquelin@redhat.com>, Akhil Goyal <gakhil@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UM7EkZywdMaAa6O1QiaZTdHbu2Nb7wu4ccjNMTAwSh0_1784360857
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

On Fri, 17 Jul 2026 at 19:23, Chautru, Nicolas
<nicolas.chautru@intel.com> wrote:
>
> Hi David,
> We use the same structure for device and queue level stats for simplicity.
> But really bringing these 2 at device level as an aggregate level do not really make much sense at system evel (ie sum of of queue depth is irrelevant). The other ones are relevant.
> I don't think we should change this, it would just create confusion with users. That's a nack to me, let me know if unclear.

I find all those stats confusing, but otohI don't really care.
I'll drop in next revision.


-- 
David Marchand

