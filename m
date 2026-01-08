Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF93D1D467
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15E034066B;
	Thu,  8 Jan 2026 15:49:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5D3264027A
 for <dev@dpdk.org>; Thu,  8 Jan 2026 15:49:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767883781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L8MosjpP3h5k3HcA+M6jZUkw1PEHpIT3ALhN2oDvbiQ=;
 b=SEJCBCXJZjxZ+sF70X4zWx1QwnsH5feiWuGRjz3Ojpu5q3NxlYJKEn+wtnjRMmIKEMueF4
 LK3mKEfJerou4j8umCI/X4+9dnecB2TY7QR5zv6EVFT9UwS5zWHE9Si3cQ9UukgRwMiQEw
 Il5C/980ftS5x1TLB/MAvwNhUlgA6lg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-nGsI-6MFPVGrm7X3YGbNDw-1; Thu, 08 Jan 2026 09:49:39 -0500
X-MC-Unique: nGsI-6MFPVGrm7X3YGbNDw-1
X-Mimecast-MFC-AGG-ID: nGsI-6MFPVGrm7X3YGbNDw_1767883778
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-59b6a320b35so2257968e87.1
 for <dev@dpdk.org>; Thu, 08 Jan 2026 06:49:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767883778; x=1768488578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L8MosjpP3h5k3HcA+M6jZUkw1PEHpIT3ALhN2oDvbiQ=;
 b=LaV8i4uYrvw1ZHOoJeV4hrrS+ga7nlk6UC2ggrjUVKDipooW5wdb3ES/LxwNgxV3Z6
 10T+ZKA2ps/9ZFf5O5Wm7sgT33VG4jmgo0hQlz7B9VNEmKukKhrrI81cOr2vMVdJyYCl
 i4SbeHoEQ9IafHRCrllrvcFioogXmn7zbcbcYARNrsrbuRxW9uVOoS8+qW0rMQkExIfc
 zulP2J2OQ3obIn9AeXiZ61YEcjs8IRSVDs9iCnKr8tSECAOguOAjb3a9hugTV3vLep1x
 CDOk/4oF8O4fg1suIX4mxESdUEzX+MxAx7dfxDweK1lBrjvrfZrSFB0gOBZB5mXzEpwc
 gDDw==
X-Gm-Message-State: AOJu0Yw/rC642tJSzk2wI8qjKSGpPI6rHjTbkUlsTQOM7gkqNcFiHQ6I
 sMIjnZp14ZtPfkUoBAm/hHftcJgXHtY/PbSw9sM3BXNk308CnK9wyoA3Ud8nam+mjyZ2RG6BW8m
 DpjIKNpGw9yUJCFcwsBfN7csOcb5PptBVR1hgVAXl7SOo4KGll+wLl3OJpMMxi0DcULnkF0lDa5
 dGsYHx3iCScdgAftVJxTo=
X-Gm-Gg: AY/fxX59/Shymz29JLBoPfHKrkTu4AyBumh1zQsggtUyXD70E/9WqmOXuR3cAU27YK2
 elEdOa2rrbzf/Gca+mnl6f9kLmhHMyXiMPNXYzZU983t762dNsOsAfydhy94yIauRljEo7xHLpn
 Jer8VQHxkv8s95hkgFG+jbY11obTeVq1ugulpWU+Tbe3vYy02FZlLoEpnWb4U858ykNtEa
X-Received: by 2002:a05:6512:224a:b0:594:524d:d966 with SMTP id
 2adb3069b0e04-59b6eb641c2mr2079746e87.21.1767883778035; 
 Thu, 08 Jan 2026 06:49:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLkuHZBRwQ3AWo4Bh4R7II2gwOW891kALXX5dkgFPr6esf/ESejvBdb/OzEplQ8WJCfysLJfU5NYfdEPJlRZY=
X-Received: by 2002:a05:6512:224a:b0:594:524d:d966 with SMTP id
 2adb3069b0e04-59b6eb641c2mr2079741e87.21.1767883777604; Thu, 08 Jan 2026
 06:49:37 -0800 (PST)
MIME-Version: 1.0
References: <20260108134951.3857110-1-maxime.coquelin@redhat.com>
 <20260108134951.3857110-4-maxime.coquelin@redhat.com>
In-Reply-To: <20260108134951.3857110-4-maxime.coquelin@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 8 Jan 2026 15:49:25 +0100
X-Gm-Features: AQt7F2qRqq2xhEBrWOO53ISHRtYhCIiKMkh0nqK-iAMEr4YzfFWAVnyyeVBzO8c
Message-ID: <CAJFAV8xvbT2J_d4MD6D=gzuMz2iL=_Jr4Q0DmKcN-AX8vXjo4g@mail.gmail.com>
Subject: Re: [PATCH 3/3] vhost: fix mmap error check in VDUSE IOTLB miss
 handler
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, chenbox@nvidia.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l1ATSz7sHcCFZUcSoJDLNcIUUYYwkfQ5hy0eX9uZgNM_1767883778
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

On Thu, 8 Jan 2026 at 14:50, Maxime Coquelin <maxime.coquelin@redhat.com> wrote:
>
> The mmap() function returns MAP_FAILED on failure, not NULL.
> The current check for !mmap_addr will never detect mmap failures.
>
> When mmap fails but the error is not detected, an invalid address (-1)
> is inserted into the IOTLB cache via vhost_user_iotlb_cache_insert().
> Subsequent attempts to access this address will cause memory
> corruption or crash.
>
> Fix by checking for MAP_FAILED instead of NULL. Also add strerror to
> the error message for easier debugging.
>
> Fixes: f27d5206c598 ("vhost: add VDUSE callback for IOTLB miss")
> Cc: stable@dpdk.org
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Ugh.. I should have caught it when reviewing initial commit..
Reviewed-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

