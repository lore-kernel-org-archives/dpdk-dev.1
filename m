Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F10C56201
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 10:33:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBAF840696;
	Wed,  5 Aug 2026 12:33:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 561D14042C
 for <dev@dpdk.org>; Wed,  5 Aug 2026 12:33:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785926033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VxyvqWn+wVeZMPMu2c8KBKNIQ0fAdEymVEo5YCsOQL0=;
 b=JrQG5TEq1YMKHUUBG9qfRuSvRAaI2jWzXKvf31NyCVPZh2RFNqQr5sLCoqLQ/e+o55+hj/
 jwKs3XL8LV65Wkhms+18Qi4V2tFIx8IJBM/M5L7gcG8Anhp4EO3w9Ksc3zMTlnGqDLOHTD
 UvzeIV48P/lxOzDjB4oQFWOTvLVRtvc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-rCIeCbgbMEiZReryJ0N5bA-1; Wed, 05 Aug 2026 06:33:46 -0400
X-MC-Unique: rCIeCbgbMEiZReryJ0N5bA-1
X-Mimecast-MFC-AGG-ID: rCIeCbgbMEiZReryJ0N5bA_1785926025
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47407691804so571574f8f.1
 for <dev@dpdk.org>; Wed, 05 Aug 2026 03:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785926025; x=1786530825;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VxyvqWn+wVeZMPMu2c8KBKNIQ0fAdEymVEo5YCsOQL0=;
 b=LDCQRLrkyq8/VGJfsjgUkwoB0i6x7SpNjq6ZSgkHTeLWf4xPdEYEBRwXmOK6uk9Lb1
 QBC0cxHZo6hc3LEVHzV3VC0wAcIAACwu8sSOdBfmWKT034Yu1z68y2rLzgDUfNvR0C40
 LUNl0iIe0n2VpNW9uU9sXfdOzZZKe+Utzgd9Pi6+6IOmDOV3USXGvO6RhBfGdaLzm0Ei
 Cyf00RXO50OI6yblNZ6gHKko26UiMYjS1td62qv0SptkHcwuq/GLXv9TJkZ4dTukbGR3
 iYh6D/qCaBVLch/R4wbKX2AAkWINKae9Vy3ErPjL71I+C/b+fps94WwQZofWxT0PtClu
 8V2w==
X-Gm-Message-State: AOJu0Yxqz6rlP7cWirdepjyk/l5hBe0xLYyFZ6J+3miXEt/bPbONU4Av
 gNqtRNqTzV777z4q5yZ4n64p+uoeTEJtxfM+EBv0xqbMmbV7RBqFwLAZRLQfinU+JjxgmirpnZ+
 il4PqfaguMcXjCzENSd2aVwHdNIv1C40IOLkizCFdf3eC
X-Gm-Gg: AR+sD122YC6G5oDlU2ClwmF78fcBS4LPMunbLTy0MCXbhVPMfxmKM0E+CIvXLt9NJOE
 fm7MuL/H9iCdBrsSq6yK3pd6PlbgTp7BXXgxHnNR6JpEHY61pR8ATUrUOyt98LDSp5Ht4Ops6ZK
 FSJSXGoMQBgteWXccqHSF4NDvTzaibfP2L1/OPMMn101103ClLDo75slHnwqaHSghPuGejL3jgF
 l5UiirfpgeFd4CVIYOipbYly/RSIc0rvMeSGLMBT96UdjfHY8g/v/eAUEeq64u5iUAw7BHGKYKO
 CD4VyG4Nhgihfop1Np351hBHamEYxa/Faebo6WvyCgLaAPedSXkbN0Ibp/y4u28gx06iCEMwlLz
 z
X-Received: by 2002:a05:6000:4006:b0:46e:c978:7ddc with SMTP id
 ffacd0b85a97d-47fec62e675mr8827056f8f.24.1785926025144; 
 Wed, 05 Aug 2026 03:33:45 -0700 (PDT)
X-Received: by 2002:a05:6000:4006:b0:46e:c978:7ddc with SMTP id
 ffacd0b85a97d-47fec62e675mr8826981f8f.24.1785926024704; 
 Wed, 05 Aug 2026 03:33:44 -0700 (PDT)
Received: from [192.168.0.66] ([78.16.71.222])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47febfda6afsm7277458f8f.3.2026.08.05.03.33.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 03:33:43 -0700 (PDT)
Message-ID: <021dca67-9966-46e7-bdd3-c3dc838099d9@redhat.com>
Date: Wed, 5 Aug 2026 11:33:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 25.11.3 patches review and test
To: stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 Ali Alnubani <alialnu@nvidia.com>, David Christensen
 <drc@linux.vnet.ibm.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Luca Boccassi <bluca@debian.org>,
 Raslan Darawsheh <rasland@nvidia.com>, Shani Peretz <shperetz@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>
References: <20260804104755.135019-1-ktraynor@redhat.com>
From: Kevin Traynor <ktraynor@redhat.com>
In-Reply-To: <20260804104755.135019-1-ktraynor@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1pUW3oHCBO4K3cmuJAfup2N9utIRcqhrAbS99eu9Zvs_1785926025
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 8/4/26 11:47, Kevin Traynor wrote:
> Hi all,
> 
> Here is a list of patches targeted for stable release 25.11.3.
> 
> The planned date for the final release is 20th August.
> 
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
> 
> A release candidate tarball can be found at:
> 
>      https://dpdk.org/browse/dpdk-stable/tag/?id=v25.11.3-rc1
> 
> These patches are located at branch 25.11 of dpdk-stable repo:
>      https://dpdk.org/browse/dpdk-stable/
> 
> Thanks.
> 
> Kevin

Hi All. A few new backports [0] have come in since RC1 was sent. I will 
apply them and give the rest of the day in case there are any others. I 
will send out a new release candidate tomorrow AM.

So if anyone is about to begin testing RC1, it might be worth to 
hold-off for 24 hours.

thanks,
Kevin.

[0]
afa438ffc4 net/iavf: report selected burst mode when no-poll active
299a834154 net/mlx5: redirect LACP traffic for legacy E-Switch
a32d39d583 net/bnxt: fix Rx timestamping for non-PTP packets
07f9221521 net/bnxt: fix PTP timestamp flags in scalar Rx
94bf87ff04 net/bnxt: fix LRO capability reporting

