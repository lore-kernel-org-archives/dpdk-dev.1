Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC06EDF17C
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 16:01:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78616402C0;
	Fri, 13 Feb 2026 17:01:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 03601402B2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 17:01:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770998489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=So8Mc8NXF0PbFK7qt35tXR/mWw4URfMl4tcqSdwyO8Y=;
 b=baMo04R4lCBURVsA6K0xJKWmN1PIkOTbWjiZnxqPs3afxhKy8W8mNt1dDCGCHFwQTNvSIu
 PQaEV2YogzpM+rpner65RPPXR2PnvVXgD4RXk4IRBZyxHkTG1HCXRacC5P8epIqH/Ef2H4
 OJEYXJoPRhxCf4OX6Gu2E0WVBDOoX/o=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-SfBOJ3EvMJKAn6RKWWx3mQ-1; Fri, 13 Feb 2026 11:01:27 -0500
X-MC-Unique: SfBOJ3EvMJKAn6RKWWx3mQ-1
X-Mimecast-MFC-AGG-ID: SfBOJ3EvMJKAn6RKWWx3mQ_1770998486
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-59e64d4157cso917032e87.0
 for <dev@dpdk.org>; Fri, 13 Feb 2026 08:01:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770998486; x=1771603286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=So8Mc8NXF0PbFK7qt35tXR/mWw4URfMl4tcqSdwyO8Y=;
 b=QBxsfaPrMVelbaweaOuNDiQImlZdmOl7ObYFOGO/aF5E1m60YirLjP2KLo5pOzwUsL
 CGAWYRbX8VPm08pZ9+U7upmPitV+ssbOpaT2mHdUbaM/2BbhyKTdESnozy+iWMycYJfi
 mcD4Z6xFT44lV0XsHSdgAI4WEfXwIyaefqc38IvLCrq3spNI81lMh4FAkQeCvIICibxO
 kdXlPGGUacu+otXZRpC1LY7FODrxC1kc3PvS2cV0HbYKMWKQCTp1YdZJ5FhUOKkamIgP
 LdE8ZvkBOMldpI/dsdYimHoy1Q6JFPSUXwuAwGEMeaZWYlnXR4IA4pKNPewBAx2UDGqq
 jHqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdzbL1LNfbnV5iS+4FAdaMIexFIaY8YP6YryimeRW5nAfsiMKvyO5AdMS9iahxJz4HW7M=@dpdk.org
X-Gm-Message-State: AOJu0YynnOIffUqXX4kmtt0ZzK4G+R1VDIjje8yzXT+m8ZwaUYgCYoCy
 xnbnsND7xQxyQE5km9AUeEqtTACUpFgvsq9rhLioy5QMbNKMHwqqUWSwL3PaAGlTDCx29hlQ/6L
 D2VcRBnmvNumCVV30f4Ev2NjBuq+lul3y4c4sm+KB71A75Xh9mwIaOVZ3nnAyW1ZAt4mG8uvFbY
 k6Ra5QJEozLPtw7qusINA=
X-Gm-Gg: AZuq6aJz2wYcrV83Afki4VCEHaY+xinwmPjC5ibmINB305VsSsj4vadMLO36ZKcYXf7
 wBl7OhDtoONJpl0zVcX2u7j4N656qiriux0EEnR75J7DVM1VGq4r4tw2EY/y6EDZQoiypR/SzAU
 WHs4vzZQsRxlsugLr7/Nj6HhPeGk/GLh2q0Xk8kZ7z40BMxGcV1M6gZMotiutM/+zWpt7pqqHlw
 /YrPdBKfTzuKQnD72bVzadd0u4AB7spujMZNcWnkBqzaaVXSjO1YAD5WzS4Xu2zF51xwg==
X-Received: by 2002:a05:6512:b10:b0:59e:4a2f:9911 with SMTP id
 2adb3069b0e04-59f6cfe394amr176523e87.23.1770998486078; 
 Fri, 13 Feb 2026 08:01:26 -0800 (PST)
X-Received: by 2002:a05:6512:b10:b0:59e:4a2f:9911 with SMTP id
 2adb3069b0e04-59f6cfe394amr176513e87.23.1770998485445; Fri, 13 Feb 2026
 08:01:25 -0800 (PST)
MIME-Version: 1.0
References: <20250814213246.4141803-1-jfree@FreeBSD.org>
 <20260114093140.3256584-1-jfree@FreeBSD.org>
 <20260114093140.3256584-4-jfree@FreeBSD.org>
In-Reply-To: <20260114093140.3256584-4-jfree@FreeBSD.org>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 13 Feb 2026 17:01:13 +0100
X-Gm-Features: AZwV_QjiEersiXASg3U5K6DSJLLMMz71iGmdCBqoOu_KMNV-_v9JOduJbmlA6ak
Message-ID: <CAJFAV8ypPkO_p5zQj8X8KF4Kda4nVhkL8B0nqLyr2B=WPfq=WQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] eal/linux: check hugepage access permissions
To: Jake Freeland <jfree@freebsd.org>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>, 
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rkzlyAWeQkOfWLSiYReui9B0W4z1Ked2VWaahIMtSFY_1770998486
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

Hello,

On Wed, 14 Jan 2026 at 10:33, Jake Freeland <jfree@freebsd.org> wrote:
>
> Currently, hugepage mountpoints will be used irrespective of permissions,
> leading to potential EACCES errors during memory allocation. Fix this by
> not using a mountpoint if we do not have read/write permissions on it.
>
> Signed-off-by: Jake Freeland <jfree@FreeBSD.org>

There was some cleanup in this area recently.
Please check whether the change is still necessary and rebase.


-- 
David Marchand

