Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98598C677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 10:12:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 420794060F;
	Wed, 11 Jun 2025 12:12:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id DDCE64060F
 for <dev@dpdk.org>; Wed, 11 Jun 2025 12:12:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749636737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bE6m8XybMZSs1IXnoEXlEQrTz9dsSxdCJt7J4Yr6dCs=;
 b=BoqbRuUMF0GDWp8h1Xfd5M5fQnkGWpQKFhNCoPJmJdFKvccK8ofoTlXqBNKfIANFZYl8UH
 jktw0yko1eAYs9xsd4w5WLwdaKWknQZh3gG09ETKLH6DiQdjlZNmy7vTovtZSSEK60+hE5
 hhKN3zbHu/Vh6xQpH+WqJi8NzdHCing=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-f3BTQfinMuK1GDe858ekDg-1; Wed, 11 Jun 2025 06:12:16 -0400
X-MC-Unique: f3BTQfinMuK1GDe858ekDg-1
X-Mimecast-MFC-AGG-ID: f3BTQfinMuK1GDe858ekDg_1749636735
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-553522f65a8so3515797e87.1
 for <dev@dpdk.org>; Wed, 11 Jun 2025 03:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749636734; x=1750241534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bE6m8XybMZSs1IXnoEXlEQrTz9dsSxdCJt7J4Yr6dCs=;
 b=c67FR0GUjrh+iKL8+8DLlhmpIxKQqt8TehL0WI2HFsEI6Kwfrhz/wK9EOi3zJQ7i0Z
 YN/H+OPSt4klxL5ZSHnVoJAJC37Q08+CCw+bUDZDQFt/6AFFcInw5liBqZYBNbDXE/ZS
 7jVmI5aUSfSb4RXwxhWBusV+EpKoR3JQDWddv0Pd+j/DNLLzgu0QzENL2q1PVeG3rg+w
 rRocWyqqtetaMSqAogzvl/hM38CCDVJzYVILcueFp/GBVkMmb3/5VX0IAfSMI6hGfJ4V
 ZRXrYXdiavgoP2LUaakHv/WLKr/lRR07ABiKJ5qkQyJ4/McM3Zu3UWgGayLgZvEH9QIf
 +52A==
X-Gm-Message-State: AOJu0YxM+XLfKsjV47dKgvuGjtoTJ18rLBCAjxDxvbMpb2tLJpphGUzP
 rEmUvShrdR2Qt3oN/ubHDBHXkenckM69eScYDtyhJ7s8Btii24wpOK6hWQ6uuqqaqV1jVzK7usW
 WYcm/ZTNDpKAylE9hnSajJd177M/Ka0p/gyMoDXb25YA1G5AwqLN7tuZ3M2twgWMXEPjpvUdMJd
 JG861l94KRz0soHsM3hro=
X-Gm-Gg: ASbGncvJwHLxD4W8R6H2tm1NoHh4q33Bep/jQv/HQQa6TDZyP4JeyM58321jlu9GSrR
 UPj/tWzfx0k2Pi69m9JhRGwmopdb5ZLluL8xZvIb2rIZRnIDZOl+/r+00KVzOOMVSz05TCw0ivO
 phMdUwEw==
X-Received: by 2002:a05:6512:2242:b0:553:5166:5a5f with SMTP id
 2adb3069b0e04-5539c25549cmr826466e87.53.1749636734586; 
 Wed, 11 Jun 2025 03:12:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOABgz+OVnsKPL2V4TJKLKiNa9xQ38mUy/NzFnbAMkxkCJcF3ZU8H+jX27LHmyaSDTiMMdkvSuqpGiCPRJzqY=
X-Received: by 2002:a05:6512:2242:b0:553:5166:5a5f with SMTP id
 2adb3069b0e04-5539c25549cmr826454e87.53.1749636734177; Wed, 11 Jun 2025
 03:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240314093630.1066948-3-mingjinx.ye@intel.com>
 <20250513092156.1198659-1-mingjinx.ye@intel.com>
In-Reply-To: <20250513092156.1198659-1-mingjinx.ye@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 11 Jun 2025 12:12:02 +0200
X-Gm-Features: AX0GCFvqMhXIcg2B_VPKYEM9GJY2gvbl2SfY8bgg6D7LzoHeUQD9Xxb4LS4Mw-A
Message-ID: <CAJFAV8wzoDuL4c9E-2WaOfUOjopwqJ4opvwwLuL85nZcaR0ptQ@mail.gmail.com>
Subject: Re: [PATCH v2] bus/vdev: revert fix devargs after multi-process bus
 scan
To: Mingjin Ye <mingjinx.ye@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 09DUuEzlLFCBePI3DO_W6tqY0zvxWXAVsFQ9ph5Kdfg_1749636735
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

On Tue, May 13, 2025 at 11:52=E2=80=AFAM Mingjin Ye <mingjinx.ye@intel.com>=
 wrote:
>
> This patch reverts commit f5b2eff0847d ("bus/vdev: fix devargs after
> multi-process bus scan")
>
> With current code, we do not add devargs to devargs list when we add a
> vdev in secondary process (because `init` flag is set to `false`).
>
> Because of this, when we do vdev_uninit, we call rte_devargs_remove on
> the &devargs pointer (the one we didn't add to devargs list but did save
> inside rte_vdev_device struct), but in secondary process, because
> devargs were not added to the list in the first place, devargs_remove
> does not find the associated devargs in its list and therefore does not
> free associated resources. As a result, we get a memory leak, because we
> free the rte_vdev_device but not its associated devargs.
>
> Revert this patch to avoid leaking devargs on vdev uninit.
>
> Fixes: f5b2eff0847d ("bus/vdev: fix devargs after multi-process bus scan"=
)
> Cc: stable@dpdk.org
>
> Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>

I see back and forth on this topic but this still seems strange we
would have to revert such an old commit.

Please add a unit test showing the bug.


--=20
David Marchand

