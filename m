Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D79FCD8CA4
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 09:02:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C9EA402BE;
	Tue,  9 Jun 2026 11:02:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id DB27E4025E
 for <dev@dpdk.org>; Tue,  9 Jun 2026 11:02:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780995756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iENeyodLHlUBvltDHT8kAEXEPcLuUzUl0XSYRO/QxDo=;
 b=a1r0Ri/3+iFS5z3Mke4rYd/qepehS6c56SmBTI9xUpMO/8/8Fq9mXQDCxhkUvrXjBc0Ort
 N1DkfD86w6MQO1qtjjVlBNbINQ/5Mt8BVmvrthRaCiied33bWegyWvwp9ERNNB/r8eWRWE
 nS6tUuCxijkxnV/0a/hMMYgCmo/063M=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-bR5FZgSFPN-UvCsRTLVCtg-1; Tue, 09 Jun 2026 05:02:33 -0400
X-MC-Unique: bR5FZgSFPN-UvCsRTLVCtg-1
X-Mimecast-MFC-AGG-ID: bR5FZgSFPN-UvCsRTLVCtg_1780995752
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5aa68d6aad6so2983076e87.1
 for <dev@dpdk.org>; Tue, 09 Jun 2026 02:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780995752; x=1781600552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iENeyodLHlUBvltDHT8kAEXEPcLuUzUl0XSYRO/QxDo=;
 b=gLEGhZecKLQvBufNkJTwdctaU/jO28UtpK7azsJbh39gxGKlQ6ZQLjuN421cw0IGB/
 eUdYxQMikdCnQRw6kqzcFxzW7n4S3fpOnlQ7aYV94LPiy/Gj1ynd4rj8nSn1ZCgFdRyp
 zujtHyApNmm7dyUxCu53I/Xh8BVhU9T8+6D4vPIOM4S+Gkz07gsWv964wPnshQEVML2i
 7Mmu8M4CqE1JnoOdkKMcyxdGdEP57cb4CZJl3Q6IzqSMKY44fc1aC/G86JBHqUpDIENc
 QUtQT3cN4QRzvCYfB6wghCN+ACaLHGdRLD+DA+GrxadqETWxKuuvVubIlVkd3ogefSBH
 cWXA==
X-Gm-Message-State: AOJu0YxdW+B//ySPm+PD2uZ39mnXGvw+B9oroaKAPrAqswJz5Eu/4UN8
 CRArQ6/0wSIraOV+KE8OJvjuHdvkPOy1AUpfJHUMCXuPz+MrJlgl43XNYTg1B0Z7Hx3+eE419Hr
 WMwCyf1oCOZV3fx3JSA1O1A2h5kOy5BOt8o04wJNkp58EkpZpRZ6odk9wPy50ZuymsT6CJAPIe+
 zcOLt9Jmykg4wkjl6K3uOLUe2AZZE=
X-Gm-Gg: Acq92OGg24MwU+lsbZajtjPzgirC7m36vIXm+znYIznfze4GD6BqUeSdZd3Yt4EJkmy
 RDcwDlS6IDaodzoBC8PYbtuT1PyNfvKSsNqGBzF1Pmb/s8K1lSl+5NcJI9x5wi2kgqWPS32v96T
 Ggd6zehPBEuXqaAwGxt/VbXadMpxLGER9L8/6kgdn7PzURxr+GU9Cp/WzPQdQmPv3Hf/dEINBBk
 IyIulVNe4uCJKVAgSajUklEga+rLQvA9f7bkAqW+rxHyD6EndfeMu32MmClA7uNlD3fa8PXo8s6
 Njlq
X-Received: by 2002:a05:6512:33c3:b0:5aa:659d:fb0a with SMTP id
 2adb3069b0e04-5aa87be96ffmr5678887e87.22.1780995751414; 
 Tue, 09 Jun 2026 02:02:31 -0700 (PDT)
X-Received: by 2002:a05:6512:33c3:b0:5aa:659d:fb0a with SMTP id
 2adb3069b0e04-5aa87be96ffmr5678863e87.22.1780995750588; Tue, 09 Jun 2026
 02:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20251219191554.939982-1-marcel@telka.sk>
In-Reply-To: <20251219191554.939982-1-marcel@telka.sk>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 9 Jun 2026 11:02:19 +0200
X-Gm-Features: AVVi8Cc-XoUcs4q7WGGowYhLhoPlD4nSRs9IQX6XexJ2X6JAgwuMIwBPxVrLUg4
Message-ID: <CAJFAV8wrWSydTxvL33A=7maQ+mDT19rLFBzsL3GOrPgbRC06LA@mail.gmail.com>
Subject: Re: [PATCH] eal: update comment for eal_get_virtual_area()
To: Marcel Telka <marcel@telka.sk>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: inu3rmCp7lVkAfygq8wsLfKq9FbhtpyggLsVtt7Mbmg_1780995752
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

On Fri, 19 Dec 2025 at 20:16, Marcel Telka <marcel@telka.sk> wrote:
>
> Bugzilla ID: 1853
>
> Signed-off-by: Marcel Telka <marcel@telka.sk>

I added some commitlog based on your description in the bugzilla.
Applied, thanks.


-- 
David Marchand

