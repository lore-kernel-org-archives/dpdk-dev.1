Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1114FC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 01:23:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF637402D5;
	Fri,  7 Feb 2025 02:23:03 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id CEE28402D5
 for <dev@dpdk.org>; Fri,  7 Feb 2025 02:23:01 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-21f2f386cbeso27074705ad.0
 for <dev@dpdk.org>; Thu, 06 Feb 2025 17:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738891381;
 x=1739496181; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1q2D/wsl6nt5vv2pTOfDxMsPFqf4QB3Z6VpGvo2vCQE=;
 b=bLYsj4mfqqwUs0uXq93E3dpk96m3tF85FTKYbqRY68O2yNbDWdqLClVfg02J3kG544
 0++xAY5Bh3NSXr1Sdmm+zNjvfeLApgj5OlcaYlUpCyNuKdPTfg30pY0m9d/Iaho4kF2W
 ccoewysesfQZqmuaJwDOZD/nzcmY8TM4QIbR3yh/i94vrj0qrS4tLx62SEAd35waUYEB
 iym6T5gjwrK1O/qGiGQC09AA8JbwnqRZk7SPNEcoi7c7PynDxYqSPMi8L5yskk7AMwIv
 HDyoFZto6vF2tlAJPoVzeiWyJ4qf5gIJ8/CooPxTmqJqSAX3K89byGzR+lZqXQwraMOP
 RtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738891381; x=1739496181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1q2D/wsl6nt5vv2pTOfDxMsPFqf4QB3Z6VpGvo2vCQE=;
 b=hDpEIvUj5iPTEPyIaDfNoc1330vcZtwpxtfKOkFOazHkle/yDx2U0GLgfPIHwfyjx1
 PM7zKyT08rZD46vWW9Qzf6s59Q6nPZm6OKBeEVmiFndPOjqk9aMsNYqyS7/hmwXX4dCf
 6aLjhpFP2GcmWHxAv5FyvwbHdMtZt3dQr6Qd/+GUC5uugbcT/I0I2C9EljmowZfonpMz
 YFI2IVvq+lo9k5mp9x+cwAkSPwEIwNPpfQTUxlnBGTBf2ArOXFShi+cxA4GuTzSdZqq3
 s7v82FDzvu4pF+cDFwDRmkd80eFxygtq5WO5kArIisH6vd1Ob5+wSP4fYn0riPXwXE82
 /j2g==
X-Gm-Message-State: AOJu0Yxk7me9WG5r0fHG+rpiBKSzZBfoDKMYTTjQgfTbXmgniAHfIN/9
 uDuD2MN3OGN7eDQu66no5TvP4yJtTSMeQWkiT6gwMQn8mJilwM7oDWqNhQUZZoA=
X-Gm-Gg: ASbGnctcF65v9xj5SEv4yyARLFB2m2TAj6XgRtEpXdCbDYiWrw0J6UA6wAwwGmcGwJA
 DYlszT0pdrGEgaIGX+ym/gOC+KVrBVKUqPHhiZgQEZHEDhlwcwV/A1lRmNVZ+zNSkr5KZOxH7tf
 a3t9NNP6qDaIJp6ie1yIlnZb9a8GVPJuSHTQhZh2N2p0xkFyraPb0S0aKBYaNeh4QeMCTDqfCR2
 VHXbAntNEd5t18bEwC1bVbRW05Qi/F40wYUi1Eof9DAMMMSuusGeps9DtoI0BjqKjVZQ0p6PfLK
 5Wq2J86Whw+a0IbD/KGN2OSq86zzw3bdsX3HwTu9/mChXwnr+eAXNFECQFEqXy6Y4+z9
X-Google-Smtp-Source: AGHT+IGKk82OyiZ8IZEagroHXcADadLIZGeV1lObIc5ypuPcmmhhx5FYmpECjIp+Q1JSWuTELPB78Q==
X-Received: by 2002:a17:903:2311:b0:21f:3e2d:7d50 with SMTP id
 d9443c01a7336-21f4e6a0110mr20863015ad.8.1738891380736; 
 Thu, 06 Feb 2025 17:23:00 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3687df02sm19319855ad.208.2025.02.06.17.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 17:23:00 -0800 (PST)
Date: Thu, 6 Feb 2025 17:22:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org, ferruh.yigit@amd.com, andrew.rybchenko@oktetlabs.ru, Long
 Li <longli@microsoft.com>, stable@dpdk.org
Subject: Re: [PATCH 1/1] net/mana: do not ring short doorbell for every mbuf
 allocation
Message-ID: <20250206172258.20ca9bf3@hermes.local>
In-Reply-To: <20250206100744.734612-1-weh@microsoft.com>
References: <20250206100744.734612-1-weh@microsoft.com>
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

On Thu,  6 Feb 2025 02:07:43 -0800
Wei Hu <weh@microsoft.com> wrote:

> In the 32bit rx path, it rings short doorbell after receiving
> one packet and alocating the new mbuf. This significantly
> impacets the rx performance. Fix this problem by ringing the
> short doorbell in batch.
> 
> Fixes: eeb37809601b ("net/mana: use bulk mbuf allocation for Rx WQEs")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Wei Hu <weh@microsoft.com>

Applied to next-net with spelling fixes to the commit message.
