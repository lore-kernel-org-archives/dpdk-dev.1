Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D86C531CB
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 08:59:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D45B4028A;
	Thu, 23 Jul 2026 10:59:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9C2574027C
 for <dev@dpdk.org>; Thu, 23 Jul 2026 10:59:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784797195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mYmbXcBF1YRYs3v7fGQXbphchYaTRSWn/jISyevFrB0=;
 b=i4KYC368n2W3DQa4PuUY+wz2BSxyfzIP8oMp8R6irCSyGawoX75zgubwd0dxi4oHGKLrd0
 a6r7SlayAuax08Nk0kB1jVV+6qIaMXZDykwroqoYBoOxIeBGuEldn3LdQHeyIG1rg3qZHQ
 BJs75ESOHMbleLVr+GHMz9Waba/OEY4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-4EtmoFN1P62iAn-p7f46rw-1; Thu, 23 Jul 2026 04:59:53 -0400
X-MC-Unique: 4EtmoFN1P62iAn-p7f46rw-1
X-Mimecast-MFC-AGG-ID: 4EtmoFN1P62iAn-p7f46rw_1784797192
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-39ad42eaf7cso1372201fa.2
 for <dev@dpdk.org>; Thu, 23 Jul 2026 01:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784797192; x=1785401992;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mYmbXcBF1YRYs3v7fGQXbphchYaTRSWn/jISyevFrB0=;
 b=MeOFz4w8ZMpUig/ye89CmU4d0n6ryOziNGEqvMwvf2+mQYSDR/4DnbevdulE8zlsxi
 sEzshWcPotN4wiL4b1v9XL/Vnm1qAWDp2CLZLaZdbG646GFC2XGOSQExUV7IK6579bUy
 6SqlOmHrXGhVXp15/nggYAZ3yfIyZ63T8eZWbxQOHIGL1hoSuidWwiXeuHVf+pkuKIuF
 feRtzxYd3Ewe0gCCr/1DxXzhpCKnLaYeZ1lkUVhPNLvCmjC+BwUBasPMPMZE+xNKbXC3
 nQt0HB/Q7po/bjdPyuDF5V7atm4iJUmhjuObo6QI7nF4UqfYfkGPgt0HQtoQ2hlbC1cx
 XqRw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/WiP24pCdKfpZIv5P+4GldRyUELlaficP8cg/rPPF0r6tOJLmk6KnAq++NcFojmrCCcM=@dpdk.org
X-Gm-Message-State: AOJu0YyewLycSrwguLCmCO7GmR/Ar5izZfW6zmk3RRnxNrUezEjKe0yd
 S643XeH5srWUAnZTmxwpzsXZ1R0TICnkrZvqOBgJUjKO9H2kqB2WCJObnLPxj5v6uJYmvpgcLg8
 Dx8QHyyxvHpzkFD8str4iSLDtKYHVU7PlTzi3g9DO7i10JhjZpFj5I7ZfqNgzW8qq7f/n3I5jEM
 wkEltzc29LGINN5OYAbHM=
X-Gm-Gg: AR+sD10gvXGiOqFW3BxVewvWuAQRcWj5L4OyvEv+wFI9BQKXdG5bY60qYLpavQQWTl5
 wPb8Xa+Qef1UrHZVInhSrmZF7lUrmYMtLfxv71O8Y5HZV/9+LX1f2ws6gwHyfLdQ5o/7QVCl0pd
 BhfoNfOr2pr46eD92HxsgL18JLlqFXhP96xTeOjgGKyV3LzK8/c1+ZXa8J6Ui0duGGBKvTCQGF+
 z1OdFOY7vbzFz1vuRMisveMDGIuczrJBzqeiMLqWXTTaE02
X-Received: by 2002:a05:651c:18c6:b0:39c:99e9:da37 with SMTP id
 38308e7fff4ca-39f07c288a3mr4119061fa.1.1784797192074; 
 Thu, 23 Jul 2026 01:59:52 -0700 (PDT)
X-Received: by 2002:a05:651c:18c6:b0:39c:99e9:da37 with SMTP id
 38308e7fff4ca-39f07c288a3mr4118911fa.1.1784797191543; Thu, 23 Jul 2026
 01:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_FD79B9DBEB2FD074BFAAACCC6DD7A6EBB906@qq.com>
In-Reply-To: <tencent_FD79B9DBEB2FD074BFAAACCC6DD7A6EBB906@qq.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 23 Jul 2026 10:59:40 +0200
X-Gm-Features: AUfX_my35OM6r2niakrGD4yWm9PshlRTcwGUnQUzFyAQoPJdYDMpcnyOqFoe_n8
Message-ID: <CAJFAV8yDSbkXsy3-Ee1vmO9crd5yaVNy0Az+ifxBcyqaXbvOGQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix dmadev incomplete ABI validation
To: datshan@qq.com, Chengwen Feng <fengchengwen@huawei.com>
Cc: thomas@monjalon.net, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I-Jrvsn_lE5qUB0S1OrmDxQMO2_C8E4Rw1nZ7ZYeEPc_1784797192
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

On Tue, 30 Jun 2026 at 15:24, <datshan@qq.com> wrote:
>
> From: datshan <datshan@qq.com>
>
> Fix dmadev incomplete ABI validation.
>
> Chengwen Feng (2):
>   dmadev: fix incomplete configuration validation
>   test/dmadev: add config and vchan validation tests
>
>  app/test/test_dmadev_api.c | 186 ++++++++++++++++++++++++++++++++++---
>  lib/dmadev/rte_dmadev.c    | 156 +++++++++++++++++++++----------
>  2 files changed, 283 insertions(+), 59 deletions(-)

I dropped the Cc: stable@dpdk.org and applied the series applied for 26.11.
Thanks.


-- 
David Marchand

