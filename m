Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D07CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 11:47:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17A4C40B9E;
	Wed, 15 Oct 2025 13:47:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 63E3840B9E
 for <dev@dpdk.org>; Wed, 15 Oct 2025 13:47:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760528847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ndh203o0btWT/g88EvNYT8+AiW7cwnlkcbPPU0dPJck=;
 b=gH4L+l1oeOckCWN256vJ1YgCR71taTUGBv4epg+9PNDxQpaj34qJ5lPtkYlqTFYr8g+a3E
 +peHYugWP9/Go1wZAy08/7GhwcwldvlXn9JQVugAeZb718CJ6/LKrdGZNnHlHU7caTf8cQ
 HvenfiSq5K/z3BLJ7Eok6wGEamFXXRs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-5NjHaxVoP0G8EUvjoWvF-A-1; Wed, 15 Oct 2025 07:47:25 -0400
X-MC-Unique: 5NjHaxVoP0G8EUvjoWvF-A-1
X-Mimecast-MFC-AGG-ID: 5NjHaxVoP0G8EUvjoWvF-A_1760528844
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-57da66e0dc7so5316831e87.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 04:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760528844; x=1761133644;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ndh203o0btWT/g88EvNYT8+AiW7cwnlkcbPPU0dPJck=;
 b=Mk/QXBoZI5OWb4NFFXSAcjcyurchPz8Md3I40fASgQDUPfTcDM/diXxYGBrzDFhIJR
 hJv4CyBJUPwhp1H+8q/zS6Kt1UjeqDHe3pWQBSOgrojne7ydtiC/KFpT01VYVZDStebo
 85bVoQwkEGEhSUb1Zef4KxxzZoRMXlLL2JN+Fc5AcYL0+Kz3WuIe6BOBXLN0WJDqskQO
 gdrPm/Kw2kqqx/CmLeKA8EVxUDAK4AyDYuA5+XXOLEYTpCzCVmP6eRvK2O7NTdoWwLro
 eu1MwfuIRqMNy968A9cK0ASFHi56IM+e9qsgxL0MJalcw4R14xESI2l4fyIYUufWSPWG
 yI6g==
X-Gm-Message-State: AOJu0Yw+/Y+HQ8wfrMQ/BchKMAUWtWV8O9pC3FX3A6KmyEokK5uUCTc7
 +1OdvQ9fSk2WR9A2UnOjNnnD2Zb973abzIq4jKh4nrKi3tyGetR9Jm7rOz8nhpG6ftlj7p+JsrO
 PzaA8PsSmLBIxK2MBoGJzPbEEm1a5FIUnjnYMD6/MqagDTDnPdMtY21REKrdWUO7x9x5ieKCIl4
 dze52PTfGSEx+5k4DV/7c=
X-Gm-Gg: ASbGncs1cHIlvorNxP9s7bCxwQfs68Q1gxxwGXF37+3a5M6/jLIiolevx3UPTzX6BWL
 RrL9B4LN6ysYIIcx5A9QdSKlfdRzfXyEbTG2O/0rXIrm18uF2L06MvdaUYzfVMjqiGD5gWiP8HW
 ls22R5mnnQkgDEoc8IBFY=
X-Received: by 2002:a05:6512:2245:b0:591:c60d:b852 with SMTP id
 2adb3069b0e04-591c60dbafbmr1678677e87.43.1760528844116; 
 Wed, 15 Oct 2025 04:47:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ7YIJjHu7BFUxKUEesy2VnKCQU52/r+HLO1BA5nb4ExABAya6BN1gr2kG4qo0hTrGjq/lRyqdKAZodbBu+WI=
X-Received: by 2002:a05:6512:2245:b0:591:c60d:b852 with SMTP id
 2adb3069b0e04-591c60dbafbmr1678667e87.43.1760528843718; Wed, 15 Oct 2025
 04:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <09058cfb25d7583f67d74f09cd36673f1b10f5ec.1734661755.git.wangyunjian@huawei.com>
 <1760085696-35028-1-git-send-email-wangyunjian@huawei.com>
In-Reply-To: <1760085696-35028-1-git-send-email-wangyunjian@huawei.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Wed, 15 Oct 2025 13:47:12 +0200
X-Gm-Features: AS18NWDSk5x0j3nUJmGw5Sgitp5TUykh1iVv9P8rkxNMv1Nua6ekI5yH_7-0AEk
Message-ID: <CAO55cswTyj32B1sHX1nip7-nPWxRW63p0itKUusbYNby9N7S5A@mail.gmail.com>
Subject: Re: [PATCH v3] vhost: fix a double fetch when dequeue offloading
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: dev@dpdk.org, maxime.coquelin@redhat.com, jerry.lilijun@huawei.com, 
 stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JsQIGdUuFIFkM9VhBt6Y4rM6ILqzAVL_OJphfPrq7qE_1760528844
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Oct 10, 2025 at 10:41=E2=80=AFAM Yunjian Wang <wangyunjian@huawei.c=
om> wrote:
>
> The hdr->csum_start does two successive reads from user space to read a
> variable length data structure. The result overflow if the data structure
> changes between the two reads.
>
> To fix this, we can prevent double fetch issue by copying virtio_hdr to
> the temporary variable.
>
> Fixes: 4dc4e33ffa10 ("net/virtio: fix Rx checksum calculation")
> Cc: stable@dpdk.org
>
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
> v3: update code styles suggested by Stephen Hemminger
> ---
>  lib/vhost/virtio_net.c | 50 ++++++++++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 24 deletions(-)
>
Applied to next-virtio/for-next-net.

Thanks,
Maxime

