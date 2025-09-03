Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00D7CA100C
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 09:49:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C09E40B98;
	Wed,  3 Sep 2025 11:49:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7EC3B402CD
 for <dev@dpdk.org>; Wed,  3 Sep 2025 11:49:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756892962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RKGPU5LveOT1xuS9u1NppitdE0yo/2nH4bhHJu9CjKI=;
 b=Vgbnhh69ZnaiAd9S+psD9GHqi6CVpge7HSTRT2KdMBajddT72Qut7wCK6yu7RFToQkAAvD
 2qo+0ghbrCFFP3DpK8W/3B53uEMYZCpC2aDEmDyaCqrqnzV2wNvoF19DBeVcL8tZ/hDBug
 0ieTlIpCd7nIwNgsOUsgHmaj0xN+12E=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-FGhqEU7gOTuk-0apk_KNVg-1; Wed, 03 Sep 2025 05:49:21 -0400
X-MC-Unique: FGhqEU7gOTuk-0apk_KNVg-1
X-Mimecast-MFC-AGG-ID: FGhqEU7gOTuk-0apk_KNVg_1756892960
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5608281dbf4so1250462e87.2
 for <dev@dpdk.org>; Wed, 03 Sep 2025 02:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756892960; x=1757497760;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RKGPU5LveOT1xuS9u1NppitdE0yo/2nH4bhHJu9CjKI=;
 b=kREAOcZ3gjrFMAyKWBCFMTq4V9M16WKfUMuZKJs8P2wEzTg60HuB8hVm4K50GDX2iR
 LOi3Oj1zMi1PEwSSWfOBqlta1/ocgaOVLj4P4HCRQg68Px7oDFBczV0V12JftgQHlH32
 hRyOoFxKP0QKXJVE3QUX6IZSwQOvUksGyjKr0u1uHVTZ+Q1eYJJWel7C51dwNNHvVWEe
 uNDhmXTvhuynTSPT6CdXXCFnbnPeNEmjP8nG+gdyJM5Co0w+WFDgacnTPfUiLrjR/vgo
 zu18hyP7TmFvo+Ze7SV3ZljGOWDtBTMqq+daJ6gV3h0wyEajHyrORprqZ/FyQx+wSLtS
 unVQ==
X-Gm-Message-State: AOJu0YwfzLta30CR0HimAeW8pUMdX0LmOuX6SYfdQUJTKHv0ycwqFolm
 pSG1r30vOWYb1w9LgYiOxe+an+/k8yW2ZScL7QJDJ/FaBsImhsKIS2RQLMKTjhzDCo21SZ+8BlB
 CloIohYyejCPRRATlDUQiU4EkqG1FnauZFtfEy+bsIa9dfvAkFKgkh+Z9UPu3I5TgqKf6coMsu4
 cTGzLvvNP6yH8yWFND3FQ=
X-Gm-Gg: ASbGncu60HkBBwP4rTiRFulQ2GdqwVeZRDiEBR6so97VoBS19yV+l9HVd5THff1OVDj
 Hv+7s/upYc4MAeyvmkSKhTze8cVg5Pl9sDVD/rb5+/ChtTGXV1refM85ukjNk5/k8Hksw3GCqK0
 k9Xs1oKdQ+dXB2MWhkhV2/Bfc=
X-Received: by 2002:a05:6512:2914:b0:55f:3d7c:387b with SMTP id
 2adb3069b0e04-55f708b35d3mr3386796e87.12.1756892959825; 
 Wed, 03 Sep 2025 02:49:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNpd4UX2PTGzAdHnEhfqN8+6nEcrD35dnT1L+C8Xo7XThErGVH8xtcCPL8SRMrT6ysOnZ/JIKPaE9EzZlRS88=
X-Received: by 2002:a05:6512:2914:b0:55f:3d7c:387b with SMTP id
 2adb3069b0e04-55f708b35d3mr3386784e87.12.1756892959379; Wed, 03 Sep 2025
 02:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250204160739.1603197-1-aconole@redhat.com>
In-Reply-To: <20250204160739.1603197-1-aconole@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 3 Sep 2025 11:49:07 +0200
X-Gm-Features: Ac12FXxdo07bxE26RJOQXeNNObr2miTCTUq_t4q3lDFKAdMkeNJQras8afO_8Jk
Message-ID: <CAJFAV8yogQtTMPOpxJVh6mEKrtbBaKm4j-v3EN16qV2GbSqAqQ@mail.gmail.com>
Subject: Re: [RFC] ci: Add support for Cirrus-CI service to test FreeBSD.
To: Aaron Conole <aconole@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Patrick Robb <probb@iol.unh.edu>, Anatoly Burakov <anatoly.burakov@intel.com>, 
 Michael Santana <maicolgabriel@hotmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XcjkJ-RtUJfqbg7D_OlzxwEuoBg4y7EmMbDmdZigXWI_1756892960
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

On Tue, 4 Feb 2025 at 17:07, Aaron Conole <aconole@redhat.com> wrote:
>
> This commit adds preliminary support for developer driven FreeBSD testing
> via the Cirrus-CI cloud continuous integration system.
>
> NOTE: Currently, this does not successfully execute.  See the following
> build result:
>   https://cirrus-ci.com/task/5626189961756672
>
> Full Logs:
>   https://api.cirrus-ci.com/v1/task/5626189961756672/logs/check.log
>
> The tests themselves may need to be run as root.
>
> Signed-off-by: Aaron Conole <aconole@redhat.com>

I was looking for a quick test on FreeBSD and I remembered this patch.

As long as unit tests are still in an unstable state, I would avoid
running them in the CI.
The check SPDX script should be updated to skip the new .cirrus.yml file.

Other than this, this lgtm (and works in my repo).

Thanks Aaron.


-- 
David Marchand

