Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0759BC369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 18:01:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9514D400D7;
	Thu, 24 Apr 2025 20:01:44 +0200 (CEST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by mails.dpdk.org (Postfix) with ESMTP id E90A5400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 20:01:43 +0200 (CEST)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-70427fb838cso12580707b3.2
 for <dev@dpdk.org>; Thu, 24 Apr 2025 11:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745517703; x=1746122503; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=cQ6t+Mb2vRFFZ+m60ilKIpZBn4l2EIIEETVN3j1lLfRTEWQdjmkHTgvvPO0F/nNfmP
 4Ngp5AjpCWwcJ9r+ZnPPHdztw/HAAE5wro6QW3MZ1TWRKT3LyHuwU1fj1mvrx/2aQGz2
 INilk/w7u8vDHffiWatWY7BCQtk+4ePDgNgP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745517703; x=1746122503;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=R+EK+ee2pmN4xxsW0EaKyqdqi9eXO1oEDiWWOMqqiezH540u2aMxj3ulM1Uc2SVNSQ
 580ITPVue5HWfhWRp3/fwOW5WpamFtdsRm8ByWGc6gAITZ3Tvnfu3WdRcHHM+6O68R68
 txVxowHAZzITXPvg0u00h3oMEHxBU1jpwQWpvrGrecSHvZTqb7K2Iu95NBqxoiDYhlQA
 Yh8Nj6mrJhJbDAXE6LTJoGSuWmoNfr1DH5QxOFNg7PnnLPqFdcsChPI+K+7Glb3av6O3
 hTuumrBJYPAMS6DrInK2NPLPBR4rjGEdS3srRdcDK5foVGm/8DpwWTjF3pCBfFTtlAVs
 0qJw==
X-Gm-Message-State: AOJu0Yymsp/9eZA1lkbxcpiua+QNuYKL431+YufYCMslrpduL4WFha95
 R6lBCCyrttfZePIoDkXQnPGal4r5e4s4+kSfcAyWqKielC6OGeeNYoNAn5TrITwCpHnHOxlhloo
 w+Gyjnilcy53F0z/C+PeymFdOvQRdwiCFnQJPdw==
X-Gm-Gg: ASbGncskTPgXDNzdmxyQli4FO6BFZnI5EEDdNwtSMVFQIV7E31eAyk6+s7wD7ZaFAMw
 gcwhO8Bap54imfwzO2UhmqE/lLrT9F+Rt0QnYuIOo4HYHDZvVIv4G22LxoiEYr4K+BztJzgvzCh
 3ixAOQ9NPYimiwPfk7v7ydL3qnvmN3L0NOqYp8WaqrQG09XBCRu5GU8ckxweFlwz5J33A=
X-Google-Smtp-Source: AGHT+IFvgcOPZ/G5MRqu9SxoMYFrCttmAck0auT6kb3UgPxOjWMZtnusS4/nGnNmHf3tCgUd+30Ox1PQiO+MuaIfxE0=
X-Received: by 2002:a05:690c:e07:b0:702:591a:6958 with SMTP id
 00721157ae682-7083ec5d3f6mr53507537b3.22.1745517703280; Thu, 24 Apr 2025
 11:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-3-luca.vizzarro@arm.com>
In-Reply-To: <20250314131857.1298247-3-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 24 Apr 2025 14:01:32 -0400
X-Gm-Features: ATxdqUFLCJ4reTXDsFcvrPZJCmw_bwNWdYzTlgy84zZaJf2zU3fTborfA8A-bG4
Message-ID: <CABD7UXNwPPuakFeS=hkZm7i=wuvd9jLPcBSseHoxZpbyLLrFUw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] dts: add blocking dpdk app class
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>
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

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
