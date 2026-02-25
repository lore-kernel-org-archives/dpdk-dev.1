Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901E2FD45FA
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 22:43:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B16D440279;
	Wed, 25 Feb 2026 23:43:20 +0100 (CET)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 8BD12400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 23:43:19 +0100 (CET)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-8cbb6d5f780so14848285a.1
 for <dev@dpdk.org>; Wed, 25 Feb 2026 14:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772059399;
 x=1772664199; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1OZkHtep/UEPxgntGjDiQ6kG1Pn/jeRRatzZlwCIg2g=;
 b=1Cy313ze5tfK0BSE0P2M8V6xVwD7r1qc/A+K0G6OlgfazFkmiYLfwkHufSjNhzVbPo
 pv51jZXWf4ZE59R+RZxvZXmmu1tfte3xh6qg7U1Pdf9KH7pr4Biv/Q4smnTsUwd3FOpl
 YXBwc/AVqNXDIp8OmgD2KwtkPyN5MO8udwndJSBdgqk3x3yH3Af26VeuDoG19CCdgChJ
 5/onv24lMC0VuSrZFPHSwSW7zrHqXdH7qOGQTockNOFiM7FiqeTzcWQ3G0nc4MVe5sPA
 zctbjLXfulOXAc8IPIFkQJjjHI108dVwleb5M+9PQL6cyRiU/5GvfToRzQYL3m3d4sMp
 zuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772059399; x=1772664199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1OZkHtep/UEPxgntGjDiQ6kG1Pn/jeRRatzZlwCIg2g=;
 b=aynVDXDs/jwEkbt/k20745Oun4ah/RUrVcdkKbOYj1nMG8A8B5T+LH6fBCc1O0Fhan
 lUj61A30H2NVR7iHg+X+6fjtp5gwDpFlQWZPGPTjsNwqnUL1hp0mvsj2MbWju84J8FsP
 Shb98npKxttqJhMvd0cakBzedV29Mjdw7uDpmsOkay33kuWMIRbGG8lr9ab14fHxZn1c
 QuTirwTvi29rrgkzhviI3I57YUUHUeVr4QdOnyQV11iJDxcz2eSwO3LwI3QdpQLBx0O8
 8K6jbTnh1RcUp2zYpPkurRsy0mpoFS4BDFYLGjTmC7dwdEHVaSmDPyDNmW1cE8w6K9qK
 3aPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcAUlJIa2FQK2eQUFhxBdXZ9ju8A9gtHwRsaWUie8/c8pcxGtYMKn2g1/6MC+HJnISPzo=@dpdk.org
X-Gm-Message-State: AOJu0YzQ+u6+F0LbbQZ7kffGRLPzNo/9pzJljRYrgAoaQlKLOtR5h8FA
 /Fwu2/q6YPx3xBAvp51VDCKx/r/NVNalQTCFShRgBgMNu85sImfFB+dEC8K3n93axxo=
X-Gm-Gg: ATEYQzxF5sYfVGfgW1xIjfyGKgFOilNwS1jx2BASTF98ZHxfpoOm6pqeyRkrPJWGmdN
 3JPU3vs0PNzeLwtvvn823G50CuNiJ4x60bHOOo62PJZL8yIv9YIfW9mZMltHyB8348dwZTG/Yiy
 01kECm0bqHw+uBIfi6il4I+LvbEVpTqNd74ElU36Evq69RdjE6cTxOs8W9ojhXm792f4FN9xWnl
 xuhP0JAPeCfSZDjNg/uNUKTiOLdYejz88QvUT1raIYZFa5+B1xULwvvII5JIY/ZNnW1p95e/di0
 zzUfwIaQbc3xAKt2PCVx7nfay/ugSIClnFwfEDpVr1m5zL2Wg0UYZYgsEAZcUJMH98aczVOtu3u
 +XClFBW13yPG9HWA5GXl91plALPlBH1xKXUDgTAWHgUCkjYuZ22bXmPxCapPzPoO8BmqVEOYxbV
 mSrkcbsBsDNS3wEU7YIxrT+Koqv26JMNPT+6kn2Ffzm6MerLN7sU1nvVyjCJszndT6
X-Received: by 2002:a05:620a:4543:b0:8c5:2ce6:dc2 with SMTP id
 af79cd13be357-8cbbcf30709mr289566885a.17.1772059398667; 
 Wed, 25 Feb 2026 14:43:18 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf7319bdsm43358585a.43.2026.02.25.14.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 14:43:18 -0800 (PST)
Date: Wed, 25 Feb 2026 14:43:16 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH 0/2] enhance for DCB fwd-tc command
Message-ID: <20260225144316.62da022f@phoenix.local>
In-Reply-To: <20260224072647.607-1-fengchengwen@huawei.com>
References: <20260224072647.607-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 24 Feb 2026 15:26:45 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Add two commits for enhancing DCB fwd-tc command.
> 
> Chengwen Feng (2):
>   app/testpmd: check whether start for DCB fwd-tc command
>   app/testpmd: add show DCB fwd-tc command
> 
>  app/test-pmd/cmdline.c                      | 28 ++++++++++++++++++---
>  doc/guides/testpmd_app_ug/testpmd_funcs.rst |  4 ++-
>  2 files changed, 28 insertions(+), 4 deletions(-)
> 


Straightforward and contained to small area in testpmd.

Applied to next-net
