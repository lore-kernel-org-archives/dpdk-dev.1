Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA6CCD6E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 11:53:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB8F94021E;
	Fri, 29 May 2026 13:53:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A3D1C400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 13:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780055624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WZgDBblsqOtHD8wHdV+9/hOIznyToMT9G+WnjguBQu8=;
 b=NIF3SrHghyw17L+kRWzilxAu7Lf8MU+v30mZVOu4A2ngTxSccRf3N0YUe36v5jO54rPROw
 rR90QKrBi1pcTKjL6avoDqeqZtCoMxfB5K9NuTlg399uOTkav/16mqigJe3taUYssMs2bR
 551Xz1LPJpDUtStjpcWGbb6NP/clyuw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-vyogJYNPPcCgtKJl88PLQg-1; Fri, 29 May 2026 07:53:42 -0400
X-MC-Unique: vyogJYNPPcCgtKJl88PLQg-1
X-Mimecast-MFC-AGG-ID: vyogJYNPPcCgtKJl88PLQg_1780055621
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-38e9589b7c7so15109011fa.0
 for <dev@dpdk.org>; Fri, 29 May 2026 04:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780055620; x=1780660420;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WZgDBblsqOtHD8wHdV+9/hOIznyToMT9G+WnjguBQu8=;
 b=ihWwWmG7zdaHlz8TX2HgIOoriaMHN7cctHbfrJey/kwJ8Z8EKM06o8IrxBEbUojhzq
 MjHNDVFcKDAjD5S2Q68LMozjQfiOD5IC6qD7tVpvvfwv6ssbQBcR8j6FvSputx6OcHwJ
 y1U50gQoFTZh0y72MeHFf6ZwALvLPGRtX+nuOnYohAohVI5C4qMNOqch0gNJQfue/b0g
 k9miVFq4DBAsscHkLAwcZnmg15awE/HgmEluThC8VFkIB9/tZGVIqZJtfKRubiO/wV/g
 2Lm4jiRCCUBoMXmKlI/gWjuG1cQ/daWqpd0aGXLzP8POCMFcZ62qmMgLBGG7ywvJPpeo
 npjQ==
X-Gm-Message-State: AOJu0YyLV+AsF8cu0ErGi40c1VGsYbnrQOQ7CwYubStpg1hglBC9G/iJ
 tPPTZ0bA/fUTGSWyNnfcEAAJHn5Ay6fNLmeh3j7WA/UVYKGaebGsVnd/D1Ra/JGtLNsc6TjKLEE
 HL1gOe0f/+BKXHMZ0Q7SgjUbgT87LbBk9dquKTWv2enNf1jKaAK0VrNASGCCaZh6DitxMa1a5yo
 Tnm/0z9/xREfnL5kIL+Hg=
X-Gm-Gg: Acq92OGXw7W7UvH6SH1VC1+V7htTbmUh1sZHZTa7EyxdBBjBVYwysk2o1FJ2l8ZKhV+
 BjYq3Ol8FDicQmE+eRlC//tYXP5q8/XeVSiHEGkJMJT6mbCbtM8zd9l2pKM7XAB5ME6hCUPnZmz
 Zkf1bfTyhHPHnncFBTSL5KG3rX7vqT174r1Uht2KnYCq3jAjmL7i9PTCBFm/sDes1cQIkcshhRU
 nxkT+EvYlFg1bqKR70oIbqJdj9dQFgSPT+RVAKoBF/LjtGh1mhPwziR8Jg8dvNeEf6V3vSQhub1
 FUVT
X-Received: by 2002:a05:651c:24c6:b0:393:f205:eb45 with SMTP id
 38308e7fff4ca-396539bf806mr4728961fa.24.1780055620526; 
 Fri, 29 May 2026 04:53:40 -0700 (PDT)
X-Received: by 2002:a05:651c:24c6:b0:393:f205:eb45 with SMTP id
 38308e7fff4ca-396539bf806mr4728831fa.24.1780055619978; Fri, 29 May 2026
 04:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260527075654.3780732-1-david.marchand@redhat.com>
 <8fe9d77c-9ade-4cbe-ac99-582f95531cb4@huawei.com>
In-Reply-To: <8fe9d77c-9ade-4cbe-ac99-582f95531cb4@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 29 May 2026 13:53:27 +0200
X-Gm-Features: AVHnY4I-WgkOxT_Wddhpmc-Z3OtFntSgiNOKsP_NtMCeADVN25r1X1uQQ-m2XBg
Message-ID: <CAJFAV8xMupNZD_g4BzWLiiNredbHgpFXueUtUBr4aC4Zvom-Hg@mail.gmail.com>
Subject: Re: [PATCH v4 00/25] Consolidate bus driver infrastructure
To: fengchengwen <fengchengwen@huawei.com>
Cc: dev@dpdk.org, thomas@monjalon.net, stephen@networkplumber.org, 
 bruce.richardson@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TWC9E0ashzaKrEVbg5ON9G2eIiVAJa2qtQOPZ93mguc_1780055621
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

Hello Chengwen,

On Fri, 29 May 2026 at 09:47, fengchengwen <fengchengwen@huawei.com> wrote:
>
> Hi David,
>
> First, this is a great refactoring, thank you very much.
>
> I have tested this patchset on the UACCE bus and it passes. Two issues were
> found during testing and review:
>
> 1. Patch 25/25 fails to apply to the current main branch.

Yes, I am aware: next-net-intel got pulled in main after my rebase for v4.


> 2. Patch 15/25 (bus: support multiple probing) has issues with directly
>    enabling multiple probing. I suggest merging this patch into Patch 17/25.

I am not sure I understand the issue, but I will have a look asap and post a v5.


> The UACCE bus part has passed testing. Please add my Acked-by tag to the
> related commits.
>

Thanks a lot for your reviews and testing!


-- 
David Marchand

