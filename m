Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D106BCC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 13:08:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B71940291;
	Fri, 16 Oct 2026 15:08:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1A6D3400D7
 for <dev@dpdk.org>; Fri, 16 Oct 2026 15:08:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792156084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3P8tlPvR7Q2H0cSi9+z+wh7xTAADYH4T1DjjXzg4VpM=;
 b=eptGwZ9HpryVwjCf1hCxyiA+OKGDEWxB9v4iMjleFBYpg3b4v4/+btfd9oul9sn/vGnb/W
 MUBm6Gl1HSBB/ichJGX2Dnfr6L27pPvjHmNlrceTa4O2fZjPrPSJ5XG+nyIEoXVGOdEq6B
 /lmpVtHYXXBsZkZlElb4wHTazRivslE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-7qkgNXntNTCZa_vdgBNfmw-1; Fri, 16 Oct 2026 13:08:03 +0000
X-MC-Unique: 7qkgNXntNTCZa_vdgBNfmw-1
X-Mimecast-MFC-AGG-ID: 7qkgNXntNTCZa_vdgBNfmw_1792156082
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5ba4284e23eso4305308e87.2
 for <dev@dpdk.org>; Fri, 16 Oct 2026 06:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792156082; x=1792760882;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3P8tlPvR7Q2H0cSi9+z+wh7xTAADYH4T1DjjXzg4VpM=;
 b=05Mc+m2I/oWJySkqzGGCt19MJvaMvuBL9yhs+zhSvBQmjdMVcMCmy2UpUF22hnRKVa
 47cjVFVlB3JQkDV2nF8jVPW7V5WBctCDqB1b0JyHxfP2FGRmpMhiByA0xvsImxqtg0Fk
 R8osL6n7VsGZ7+AGrHRLgeJ+m02JxazPgZEqKjjTF1MdgFpnT0vTnGTtFEHUffDGj0Yo
 lviISZcfQ5JCdZu6T4kn5oaksF0MkgQ02rMIFixMJg2UXvnOEtaK9BwlIWbjcxCU6ewZ
 gQHjD1u3py7Qhu9mcqyjpORYVxrbskIXnOzLjLJu8tF8OM6jp5SRxbuLYn8Z34yXiS2O
 7HMg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzI0nmgmzU6wNNFWGcoRpw1YqtkkwqcPCqQ0tUFlgunqL8s4tXJJfs0vMvPPCTi/DqRJ9E=@dpdk.org
X-Gm-Message-State: AFq9FYJmiqr176gjRtyWhvlH6tSaUQCCBu4SU6KB4gXMtbJTMW0unILc
 wAYO2mkg7uYtu2pU4AluzVQGuM81wHF1K0G/MEV4tRBssRC2R59xcMonc7Zpro5TNZ14zahbhQv
 LNQw2y29bbO4YZdr5n7ApY09XS3AY224XXFG40Ga+H0//NJTNJrbTnTPzv5EoqghXtjdG3mYaAw
 8RkTDzAJDJ3XWCCjf5J8Y=
X-Gm-Gg: AYBFou0/t13mw9wQ7JUgfzTPOQaTJGQgkOhf3MeYY5RhHGN9hz/eyZl0ctMJRebdRjC
 f6EuhnFmwaXdpBXip8ZeFaoEchES+X7Ih29RUhL22EozuXD1hIhxEDGj7jn05WAWqCUXS4Unr9q
 4192wKqWulVUSB+iJRIizkEk0fmtQ3kvYnDljJpAbpjxgGnimZhYQjwoeH36s0wZnu/XEO+LMQx
 WMEwjOJ5c8UR5GlGk3pAPIU9EVabW6sslPIHnEOGMgtwsbP
X-Received: by 2002:a05:6512:224c:b0:5be:3444:57f1 with SMTP id
 2adb3069b0e04-5be3444605emr3433300e87.63.1792156081663; 
 Fri, 16 Oct 2026 06:08:01 -0700 (PDT)
X-Received: by 2002:a05:6512:224c:b0:5be:3444:57f1 with SMTP id
 2adb3069b0e04-5be3444605emr3433290e87.63.1792156081135; Fri, 16 Oct 2026
 06:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260921030811.1034869-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921091932.39fa0013@phoenix.local>
 <CAJFAV8y=YSgqdt+gtXn37VYZagnMzMCaRg+VQZbmjfQ974vW7w@mail.gmail.com>
 <CAPTrkjHZgh_ASCsyjh9B=LbUQaGvXGWCJSVHWJmYr+PZavHucQ@mail.gmail.com>
In-Reply-To: <CAPTrkjHZgh_ASCsyjh9B=LbUQaGvXGWCJSVHWJmYr+PZavHucQ@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 16 Oct 2026 15:07:49 +0200
X-Gm-Features: AclHuK-wu43otstCTXPFRzNw9m8D7t6Wj0FSSxeiO29C9u2NEdYzFlSZkaXvsv8
Message-ID: <CAJFAV8wyFrsFQzPqjzxb5UrCGZer38eMy_PvJOyBYqcy_gb2GQ@mail.gmail.com>
Subject: Re: [PATCH] net/bnxt: remove VMDq support
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org, 
 kishore.padmanabha@broadcom.com, Keegan Freyhof <keegan.freyhof@broadcom.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0OdoYq7JCHTVygUwSH1U6KMmK3j3BKHiy2DJeuPYMNY_1792156082
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

On Thu, 24 Sept 2026 at 00:44, Mohammad Shuab Siddique
<mohammad-shuab.siddique@broadcom.com> wrote:
>
> I will restore the explicit rejection in v2.

Well, this was not my point.

I just posted a series.
See https://patchwork.dpdk.org/project/dpdk/list/?series=39678
Reviews welcome.


-- 
David Marchand

