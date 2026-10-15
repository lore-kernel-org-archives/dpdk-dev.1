Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C0ACC6B3A
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:19:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68D75402E4;
	Thu, 15 Oct 2026 13:19:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C509C400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:19:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WOYvZUsiBetwwpcpflX0nTGsHBuoyyIMVFcT4VSVYIE=;
 b=Ix6/E/eUFpgsDNwj+2fd1kSykXa4/SptbRmOvIXNspefKzbc4RMBRr+0/dpfU/LqGnUbQW
 yHwZsv/MlPmzDbEf3yu8wjicM3VpcwTwBIz3iE6SH35T+nSbNqMtvzO7ev/nNcShZ3Kt06
 m9fl35xFqG/XOiPtgtFTSlIq4QYhaD0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-nrnlHbXrPdyyTHsglzmGlA-1; Thu, 15 Oct 2026 11:19:07 +0000
X-MC-Unique: nrnlHbXrPdyyTHsglzmGlA-1
X-Mimecast-MFC-AGG-ID: nrnlHbXrPdyyTHsglzmGlA_1792063146
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5bcf6b5224cso2174313e87.1
 for <dev@dpdk.org>; Thu, 15 Oct 2026 04:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792063146; x=1792667946;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WOYvZUsiBetwwpcpflX0nTGsHBuoyyIMVFcT4VSVYIE=;
 b=qCRhgNZ0APjtjP+QvDksXMq0iNSRkMeZPEl1Byp7R339EGo7BasX9QV0sHarCuMXOg
 xI3Q0YPZKXHI/sAbcTcAAI93LzdnUaLQEIR3oUp4znNut1ttxLhXPEnNtE5tPZSya8xt
 ZZSLKIKthrSjoep4Vz37GcIzCquRSdkPuizAldhB93RZEZfX78ztRL08in2Tk6G44QU4
 6wgU5ed091vmDJ2/k8e1TIRcCLPJN5Y13JR8IByg/5omUF8rxWXCDHC70Rp8xyF4Z0uY
 jdBsLmXapSJCxgMXbYK9bnDTy64n9tByPukFNkeB5ILfzNqB4BVvOp0SoiI6bJd1VEM/
 8bzA==
X-Gm-Message-State: AFq9FYIp6oZNNewyOWtAcI1eFIlPkNTGakY8QPCT87l3GSOGGClirgV1
 me03KdofKDMdkpc6cWKB3jW+Tt93q5/b/AeqoBnAJCjUFduhAAKVF4J+nomdKB2UBBOrfLkUJWH
 r3gI/Xf0jdD3pjrV288snxHvdyvs4p4j9MBCu22/oZu9gDRgjSUCX8siDOkILhPCyalPkNTJwIT
 XXwcc9GuAOY73v5lgDQbU=
X-Gm-Gg: AYBFou0oR43qMlMxgLhq3EbseTJXq1ZyK7mb2t8gCpnxq2YlpWqXR+aqNxYqJUevA2M
 FlBUF/WUgYkVBzIUuYTG2pBHP7j7xq/G7DGd/AHTn0cTnrhZ0yaSPN1TEBgP5QSe4TAgyuK7/Cc
 lLOlc2UUaXOR/+51wOl3m6j+nwaCeo3uiBN1XNVf/7OW4SEzwVMc3nYiSkGgizWmNKoKwqyZMhV
 S/o6UgbeJm3CFKnrlribw13vCA28FTuWqATqDKyfvX1sTMh
X-Received: by 2002:a05:6512:1592:b0:5bc:b5ea:94b2 with SMTP id
 2adb3069b0e04-5bcde8db1damr6677641e87.59.1792063145485; 
 Thu, 15 Oct 2026 04:19:05 -0700 (PDT)
X-Received: by 2002:a05:6512:1592:b0:5bc:b5ea:94b2 with SMTP id
 2adb3069b0e04-5bcde8db1damr6677622e87.59.1792063145041; Thu, 15 Oct 2026
 04:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20261014203435.583064-1-thomas@monjalon.net>
 <0b380d9d-f7e1-4521-a548-9a9163f10995@intel.com>
 <Q5JnIR46RbOi5z8Dxhadxw@monjalon.net>
 <fe35faf8-fad1-4977-8272-bdf6f1896825@intel.com>
In-Reply-To: <fe35faf8-fad1-4977-8272-bdf6f1896825@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 15 Oct 2026 13:18:52 +0200
X-Gm-Features: AclHuK8Dgad8tc0F5FfbTTXDUvP_2N1OiMxrfmss3k54SGtg4X1RBs6pht9h6dI
Message-ID: <CAJFAV8zqXgiwAghLZgR4Ha0dnvwtf9puECJpmv57N2zTE2dMxQ@mail.gmail.com>
Subject: Re: [PATCH] net/ixgbe: avoid private driver include in testpmd
To: Thomas Monjalon <thomas@monjalon.net>, "Burakov,
 Anatoly" <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wN-Ux6OWZRDxatL6nAsVjqU0m8qeEEWA4YsOPM1V0XA_1792063146
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

On Thu, 15 Oct 2026 at 12:41, Burakov, Anatoly
<anatoly.burakov@intel.com> wrote:
>
> On 10/15/2026 11:13 AM, Thomas Monjalon wrote:
> > 15/10/2026 10:53, Burakov, Anatoly:
> >> On 10/14/2026 10:34 PM, Thomas Monjalon wrote:
> >>> Testpmd commands should use the driver's public API
> >>> rather than access its private structures directly.
> >>> Note: ixgbe_testpmd.c should be considered as part of testpmd.
> >>>
> >>> ixgbe_testpmd.c includes ixgbe_ethdev.h only to check whether bypass
> >>> operations are available through the private adapter structure.
> >>>
> >>> Rely on the public bypass API to check availability
> >>> and handle -ENOTSUP in the commands.
> >>> Remove ixgbe_ethdev.h, ethdev_driver.h
> >>> and the now unnecessary RTE_LIBRTE_IXGBE_BYPASS definition.
> >>>
> >>> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> >>> ---
> >>
> >> Reviewed-by: Anatoly Burakov <anatoly.burakov@intel.com>
> >
> > I forgot to say it is mostly written by AI.
> > I didn't review it myself.
> > Please double check.
>
> It doesn't look wrong to me, testpmd code should not be using
> driver-internal things anyway except through pmd-specific API, which is
> what this patch does.

On the principle, this looks good indeed.

My fault for just moving the code around, without considering the used APIs.
And there are probably similar issues in some other drivers _testpmd.c
files (at least net/ice seems to include ice_ethdev.h).


-- 
David Marchand

