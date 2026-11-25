Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B396606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VBhTnQE1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9738740284;
	Wed, 25 Nov 2026 19:56:12 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by mails.dpdk.org (Postfix) with ESMTPS id 8834D40274
 for <dev@dpdk.org>; Wed, 25 Nov 2026 19:56:11 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3ae2b7e1e17so3970187a91.3
 for <dev@dpdk.org>; Wed, 25 Nov 2026 10:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795632970;
 x=1796237770; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qSeOdmEmtEoFmD4poZEqpwM08HYQ2c5ITCfujfoioDs=;
 b=VBhTnQE1OeOH4d6o2gwxwQJyfHdH0IEWOk4Vu+mVSsIC7bRVaqsNueJXgU053JbjDb
 jiV3wCZUK5quNzJZ8TmGh0gN1eUnb7R69zHd38bunsRTZpRx1ZLSTKlXtFbkThl4hT5y
 A5fbva4MzHmODMfDpc6vrk8squVhMxUtxOM/Al30xcM3AasClXfzosCp1r3AMOWOPp76
 ESfCVkuEapXme1MsEpPWRHuoHO+67w+jTwgK+jyDF78OB0C2msULFA8x8g1CPsNO8sj2
 FfRwbRfGuaRCynKnPbfpdnRAzP6qcBLPX5STdqulDrnQ26lV51Ojq2nY2DUPahKXXgnv
 McHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795632970; x=1796237770;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qSeOdmEmtEoFmD4poZEqpwM08HYQ2c5ITCfujfoioDs=;
 b=v8q8+1c7UMgOKfyUjbJoBgLMaSpP48tjct4P3Wm7TI/MK9x4DNVJ/5yo/7QOHBBDmT
 bybQyqwagEt6psd00apCPcCRbcXQcwe5au2bvyxbCTpZ5FiZ613POi7iYuqzZoGzbZgc
 yLq3mb1ioNFe7PfCeeiYRD0fCaqQ6drPogM78ITwl8hOWqRVx8m2dpSdd5KaFHr7fOXw
 pP1EfGNakt3cMwJxmf8aTdNbXf9ClD48Y8mnSEzoMwCuno9NFO8x6GSl0fhwgEiImIz0
 HeKBjtcK+OvmaILFt44yAFyF7tcqi4pjvWg4hL7RjsWnZGo3+5eIx3pB+QyhPIPDY+G+
 UrDw==
X-Gm-Message-State: APuU4Z+iubH11pW42qfoc8auUGPDvvgZDgdoA+8GDBow2beWxNplUqCH
 Lw30s4qnB7pX/NZxFUDqUrGlowbot/IYYM/cuYNdatb56ibsubaLufyi02pO8l/zkxI=
X-Gm-Gg: AZFdTZcBIFPfJU6sKVmEqE0TV5gfE/YrxdNy4fpZiQzPHa9Uk5TXaH3jxDnyV4lfcQ+
 zbunKSYZcF9vy625BMwKakhXvZEUIEH1WMg5sR4TkiU0YBgPpk3Hi08c2EWN2Lf7R5Tq2INlpGq
 RrQkah3Qg9lESQH267Uz5mrFpKuTu07VEAq0ZDncWfMuxr6qtBXIwtnOH/kJHrMkkK2+agfsYdj
 OqgvBjUU8Y8iRxzamuGZOg9IX+33vT9TAVTXIrM2fVA2RFey8kCn0oWdhUGHUxa6cpR/jMEJ7VN
 MHax+F4v+Cz8ZMf/w6K40SfSNqn5JllVToJAXXpIUy9rlRgZ3iluWeCaZNv7bN2ZYMXlh5A7aUA
 caVUFsnVkLaN3akt//f74NaQh+lBwcP8FzEUnCQCq7jHGwYOInaIAhTqntOd470J9Wu69XoDbXb
 4rA15EIht4RKTVtQg1lJBbPZmsyPvEPjV6Vu6dEUeM0eYWKZDlz4KNtu/T9Fmv04fbK9LXXqxdJ
 Cr8LPgZMq/RaoHD+N4drNn+a6Zj9E9Ewntz7fHEfcXfNASIEhbXao7myNGZPubvXedrcFPpyQ7H
 joLOG3eahrLSizFW2hVFBSmqXVW1Yk82kJayM6EIxWdMjaFXJiVwqTnxopFjDkcPy+gHNxA=
X-Received: by 2002:a17:90b:5546:b0:3b3:c44b:b779 with SMTP id
 98e67ed59e1d1-3b41c935639mr19379149a91.46.1795632969873; 
 Wed, 25 Nov 2026 10:56:09 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41adcfe23sm28753806a91.15.2026.11.25.10.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 10:56:09 -0800 (PST)
Date: Wed, 25 Nov 2026 10:56:07 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shuaisong Yang <yangshuaisong@h-partners.com>
Cc: <dev@dpdk.org>, <liuyonglong@huawei.com>, <fengchengwen@huawei.com>,
 <yangxingui@h-partners.com>, <yangxingui@huawei.com>
Subject: Re: [PATCH 0/9] support uncore power management on Hisilicon platforms
Message-ID: <20261125105607.5a8c631f@phoenix.local>
In-Reply-To: <20261125140616.3965843-1-yangshuaisong@h-partners.com>
References: <20261125140616.3965843-1-yangshuaisong@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 25 Nov 2026 22:06:06 +0800
Shuaisong Yang <yangshuaisong@h-partners.com> wrote:

> This series reworks the uncore frequency handling of the l3fwd-power
> sample and extends the power library with a Hisilicon uncore driver
> and uncore frequency telemetry.
> 
> The first six patches restructure the power management code of
> l3fwd-power: the uncore and cpufreq/QoS setup and cleanup paths are
> extracted into dedicated helpers, the failure paths now roll back
> the steps already taken, and the sample can set the frequency of a
> specific package/die instead of applying the change to all of them.
> 
> The last three patches extend the power library:
> 
> - a detect callback is added to the uncore driver ops, letting a
>   driver report by itself whether it can manage the platform;
> - a new Hisilicon uncore driver is added on top of the devfreq
>   sysfs interface of those platforms;
> - the current uncore frequency is exposed through telemetry.
> 
> Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>

Why does application need to handle args about uncore?
Seems to defeat the purpose having EAL.
The setup should be in EAL not the application.
