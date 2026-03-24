Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C4EF532E5
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 06:59:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CC1A402CC;
	Tue, 24 Mar 2026 07:59:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 93B104025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 07:59:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774335551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vnm8sHTwVZaMlOzhS3/1zvSORzTyKtCttBH6VIRtJLk=;
 b=GFzIlizDH+9ecyE1P1Gk/gX48sWViUax1XsvxPpV/V/fDextaJOPq2QrEQRoXy12WFTuSf
 EQxu5Kn1wn5EmOlMZjk5nTN4YJlXKfQ3v+O/ntuw6EN3c0I7VGkLAj4iwEEdWVVZX3CxMW
 ZyF+8Ctl11iKayvPvQAA3z/B/bWUzPw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-ghbs3y2NNZ-JchDzqQa_vw-1; Tue, 24 Mar 2026 02:59:10 -0400
X-MC-Unique: ghbs3y2NNZ-JchDzqQa_vw-1
X-Mimecast-MFC-AGG-ID: ghbs3y2NNZ-JchDzqQa_vw_1774335549
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-59b6cbd5493so457656e87.0
 for <dev@dpdk.org>; Mon, 23 Mar 2026 23:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774335549; x=1774940349;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vnm8sHTwVZaMlOzhS3/1zvSORzTyKtCttBH6VIRtJLk=;
 b=sEn5uX8Ni5XeR3eysliDzyTyN3DQiCKfIdQ4to3D5D/ZsD2LJUjYv73wvH7o6MkOfl
 IvWvebSAkeIhjF0S7dFw0Ac8aCvgPZSOI1y71YyAyCPKtneJ+R/QYd2FfbTrLI5zyaLs
 Up/00NnRfQmF+WucIruWhhgBnhpPYJC7hRPoCkEfJj/ASpHneHPvj1F/WQOHF4yTN5QC
 ruG18wndPO+IU7P7x9epyo/SflvmFszgn94NSZWDzvhvD3Bgsc9zuWuHpw3bXqO37VZg
 FXhgvDPvBay13X4QBfh159zifTimjVZbJWCmqqsYQAstQxK2zk6ZYYuctl7VGBfcTluC
 km9w==
X-Gm-Message-State: AOJu0Yywiu71Qv3cxATxf1V8fJWd0XThuihP6p0N7y7kI4V4auRjCl0Z
 jr3Qf/EPwdP8PA7hCG2SXngLhfzX4z9dPl7K14tPhGsoQaLetNm4sC3ULxUJz7M7E0SnD/5s3DC
 uScAJqBvW3nTPb/Wy+ldpkQLz+qkL3Js0FbXgeWbNlh44xKK/Zqv0OKRfmouiTHVRAfffRNxeyv
 Ocmsc6/YzmoTrE1CHjBvA=
X-Gm-Gg: ATEYQzxCkLhdg4wOqLcevW2SIx76VuL6UEYsuit/eXog1H+Gw7UrCv2eBoqeB4st6it
 CaQJyQ0ZWomcKYII5jiaxImQrLGaXJI3wpBZTzTmwA3CTiNuuAaADgD8zSjZ+f1MHHXLeHkWG2P
 ijvAkDVm9jHn1bAmssoiWcoO+xqPmjZPoIs8zvq6f4/KtCvIvomrpewzx5dR5DljuxelgtZ/PIj
 2rY3uvHQNNz9fq9uUYhxmAFf3cktda60avT+jr0oRupqhUHyaccqr7eu/eZD9lgAgNBeQ==
X-Received: by 2002:a05:6512:3ba0:b0:5a1:1e44:8682 with SMTP id
 2adb3069b0e04-5a285b4c3femr4300052e87.34.1774335548995; 
 Mon, 23 Mar 2026 23:59:08 -0700 (PDT)
X-Received: by 2002:a05:6512:3ba0:b0:5a1:1e44:8682 with SMTP id
 2adb3069b0e04-5a285b4c3femr4300031e87.34.1774335548497; Mon, 23 Mar 2026
 23:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260320133309.1015506-1-david.marchand@redhat.com>
 <795dc7d0d3744a32aa88ed1e61afd765@huawei.com>
In-Reply-To: <795dc7d0d3744a32aa88ed1e61afd765@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 24 Mar 2026 07:58:56 +0100
X-Gm-Features: AaiRm51mGyBCVHRcNCnV4tIucSH_OS_EU6SjqtweCDuKRzgaVP8bbF-bW0spPjY
Message-ID: <CAJFAV8xHc+g6EK=3w4V99H-dU0i-YwQTSQK4TaWku0Mtf9pRqQ@mail.gmail.com>
Subject: Re: [PATCH] pipeline: fix build with sanitizers or debug options
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>, 
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nm9_qSe3v_epmW-s5euTIQS_PtRU0EVINkur2fkayHA_1774335549
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

On Mon, 23 Mar 2026 at 12:58, Marat Khalili <marat.khalili@huawei.com> wrote:
> Should we only fix those at the end of a function? Other cases may not cause
> issues immediately, but may still confuse compilers and readers in the future.
>
> We are using the following hot-patch command in our CI:
>
> ```bash
> sed -r 's/\bCHECK\(0, (\w+)\)/return -\1/g' -i lib/pipeline/rte_swx_pipeline.c
> ```
>
> And it performs 6 replacements.

Yep, I did this on purpose: I fixed what was breaking compilation.
The other cases are not strictly wrong.
Usage of this macro seemed intentional (for consistency?) so I did not
touch the rest.


-- 
David Marchand

