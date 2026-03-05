Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4033DF3092A
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 10:10:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F4E44029D;
	Thu,  5 Mar 2026 11:10:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C098E4027A
 for <dev@dpdk.org>; Thu,  5 Mar 2026 11:10:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772705450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=umER5syq1ZTPc5RHg+3DLuFKGLQ+DiNOCVyjnN+xld4=;
 b=AFjcOA8Amh/bFiwsFs9GJtBrVFD0DGMHX1lGRNCb5zgCmSV+qMdGjSnxLh4PuUs4Q5rG+2
 09AAjjAJAQ+mWiui8mzQYC0K8A2zbKN6NyaXIgbXaFK0rFxGFUn9r/l1sV+FR9rjO+l/rm
 SUEGhYf4484Kpn0wnZnLnooDVCh1K8k=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-Gc23sU39PLqg9632ZM1YmA-1; Thu, 05 Mar 2026 05:10:48 -0500
X-MC-Unique: Gc23sU39PLqg9632ZM1YmA-1
X-Mimecast-MFC-AGG-ID: Gc23sU39PLqg9632ZM1YmA_1772705447
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5a123feb18bso512894e87.2
 for <dev@dpdk.org>; Thu, 05 Mar 2026 02:10:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772705447; x=1773310247;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=umER5syq1ZTPc5RHg+3DLuFKGLQ+DiNOCVyjnN+xld4=;
 b=utXulVnY9Wu5I0C/tQ73hUhdWAtlDc9TPyNusRVzLWnnRvLwC9sN+7oaQoesMAEWBl
 Nccl67q0iMW2/aa19nixNrxUaZww862gOSgLUG9TbIhaEActbECQ25RVtEm6RLZ4Jn6q
 DP/K8p+4H9CD/MIlUyFQdPvyJLlY3V2HAuq2mb8TWfSwErsv5Cc/vstFf/CJ2GYElcyo
 eNHqokGDFjk+tJwLy8YOKhKMuN5/CoHX/9kSRtwEdLXewv59a2T+V8J7FnMkqHfpzJ/o
 MvYRnYRWhNrNt/zQqk300zbtzzWPJ6QF3jUAMU3pXvrT6fOs6vOJLKaWdJ8QLLu/CjW3
 FIkg==
X-Gm-Message-State: AOJu0YxA0qQJLYkq2AxUFsVY8R014v52Vp5oZXXxGeiIXQELJMSpSJuR
 N/WMgWs6Df9fGbbYuiLWx+wbzPI8UTG5DmhxMgZeQ4SLTlSWbWpqfe1iwOasZVHpIqZLCAulmNe
 R9scYtkoYGVq+x2V5D4RT4iS/OiEnyRr0wF1+wdWNb7PbdpCXVw7jTXJI6t2/9Kq6Ftdz9Vf7cD
 VZsgZzpB7ulLTN9viiNIw=
X-Gm-Gg: ATEYQzw8JZ1Sb1g9YidgHCnMa5G4b+wVK/Jxwq7F1nY1nyRmDG/rVCVLMAEYPTNeN6Z
 UQ1AR6xs0gVKo/ewpvfQMpJe9UaUX5Tbl2V7Gjw4k/doSHe2xEHkyaQkWku3ok44VWOPECKUfRS
 doRf1BRsePhNd+19Qveu7+fZEDyeAHbhhQUda+TOX7dTxUf5G0oyenb21tHxVW1LxK6bLrwkhzx
 VNt1GTrVTgcsTvGe0R5J0yOB2cZ5cXAAVQ57C8rH4bDyDDJN95ZlBytqtGR6IOF87zC1Q==
X-Received: by 2002:a05:6512:33cf:b0:5a1:1de6:2231 with SMTP id
 2adb3069b0e04-5a12c357acbmr664426e87.45.1772705447287; 
 Thu, 05 Mar 2026 02:10:47 -0800 (PST)
X-Received: by 2002:a05:6512:33cf:b0:5a1:1de6:2231 with SMTP id
 2adb3069b0e04-5a12c357acbmr664420e87.45.1772705446834; Thu, 05 Mar 2026
 02:10:46 -0800 (PST)
MIME-Version: 1.0
References: <20260305091039.1057276-1-alialnu@nvidia.com>
In-Reply-To: <20260305091039.1057276-1-alialnu@nvidia.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 5 Mar 2026 11:10:35 +0100
X-Gm-Features: AaiRm50BmGfYWysEuuOl19q2IXQ7f2oULi0fPPYIZQjan9u6RkmEwnRtUNrb7Ls
Message-ID: <CAJFAV8z=x1EQvvW6Jw_x9oX6SQGN56EKbnL7aPa=LsPNnasg6A@mail.gmail.com>
Subject: Re: [PATCH] devtools: fix symbol change check for non-lib patches
To: Ali Alnubani <alialnu@nvidia.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rG4kiJw2hcFiQk3_yXJvhQZut8DNqzWkYVszz7vNStw_1772705447
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

On Thu, 5 Mar 2026 at 10:11, Ali Alnubani <alialnu@nvidia.com> wrote:
>
> Initialize lib var per patch file and skip symbol handling when no
> lib/drivers file header was seen. Avoids NameError exception when
> processing patches that only touch docs or other paths.
>
> Fixes: 1a0c104a7fa9 ("build: generate symbol maps")
> Cc: david.marchand@redhat.com
>
> Signed-off-by: Ali Alnubani <alialnu@nvidia.com>

I don't think resetting the lib variable for each patch is enough,
this relies on the patch content order.

It would be more robust to catch all ^--- a/  lines (which marks the
start of a new file), then if the file is neither in drivers/ nor
lib/, skip any line until a new file is reached.


-- 
David Marchand

