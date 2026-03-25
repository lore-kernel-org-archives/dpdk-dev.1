Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D790109C05D
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 20:16:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DFD4406BC;
	Wed, 25 Mar 2026 21:16:51 +0100 (CET)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 5742A40669
 for <dev@dpdk.org>; Wed, 25 Mar 2026 21:16:48 +0100 (CET)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-35b88a4f123so87436a91.1
 for <dev@dpdk.org>; Wed, 25 Mar 2026 13:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774469807;
 x=1775074607; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KBFEqUQ8ld5oKz9eOlg/RRXRus1TZKTSLKXl0au+I8=;
 b=XDCaGeKjZOjYkWSijntv0CTlqNZW3F1KG1JRbn52fUQ+Z9r1ogZ4YBqgNlSZYfJsT1
 7sULo6GLmSCXaXTwuRhtWKlnDQD2PHuORgWiXyFbzdIsk6QsX7pqLEgKiipJXySwtqz+
 joqAYkqudeX4T8+OT+uNjpaehF8Uvf9iFP3NuZ1rtqaWPdtSHdeauujQPEqlKpp+WhUd
 zKrK08x2lbDF2mevFNkH1z3s9luf3TAuigLmuyZQW/ugZ3aA+6Oh3/+dgHONGufB2H5S
 zqmp2EU5pK0yi5mG4JM30TOuQf3r8WO4hmzHBp9tcDaauWKQQmwykSLpSt8JkjBx33VN
 TsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774469807; x=1775074607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8KBFEqUQ8ld5oKz9eOlg/RRXRus1TZKTSLKXl0au+I8=;
 b=GHEZtoj4z5KPUCDSZBb9EXxypTdPZZQpwmg+kVZpBSy9oAq9DYIRP+uJuFUXunf7tP
 5ZfTMTkoQQYuY4ybIlHa5FOpJkHkiYLpO0+0f7giWbUzG3IKThf8VKxXQRs+J5oGjxYj
 i6bQrLXYBVv2YPoEh338C3qpKc/F/WdMzedd8AzLHLvUDd2c3U5QhOdNk4zSDsPVRU8J
 PGyimAT+dL4B5n+u0V027z+GTvuXndsrgf2xzNWo3Uu83BS1FotB41lfiTYszFFmOn2U
 +I/Ob0fNJFzqz41tJuOVUMHy3fYrUrYyZXhpaBzOKIjuQ2SM3j2WDzRVsuZcNPQKBoXC
 boMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7EP3oOeV1aQWMK1NjhLRSyfevAK6cSFR7WhDgzyFny+wfkAz5Wei1KoH7I1b0lLdIIxQ=@dpdk.org
X-Gm-Message-State: AOJu0YwnxNrVYWLMOuJZTtpEOOP71rUCd+Hj/aBR2roN8RQUe6T9yfjE
 Ro+W6x8P6SyM9UwCH4NwQS/PE4rUy0SrANCwJ+wOQPY1/z8LUX0c19jPi/hF6VHH/Uo=
X-Gm-Gg: ATEYQzw4GNBqQM7U6HSQctYx1uOICb+bxwbR29UqlQftAhxhOKayImfAUFCYbK80WoW
 qdMUG/Iw2+b+N1Cr+gM3cIXIPzv+8ODCVFWsORr5TrG6aTB5yWAaIDtzbojtTFGP2OwkDTpz3xy
 MHx66JjVAMz4cFk7PRygcohn7lOfWIQPat8eF/zSEij/0qz6hOC/8k1tEqSi6tsWVCoWQ9z4b+V
 9L50nP8IZTARek2Pkh5sTcyMygft57ql5mXH15xAbmusnqEZa3PuQVVewE3Uc03hlOx6ddngeP8
 103p1RV7h0NHPVUzSw9iHgDez70otZja0Jox7/fkcqH6SNH9Y1bnV2SdBhJxrZYHZXzs5HGjYv9
 5aNBGnu7CWaal9HRHlbEv6/cuYoCgzvDH6EYGiLd5O3bHbp7jTAs2b6ZyD7yP0+CCbC+tH5HomY
 YjXT3kUFw0oy53hhW12WuwF7hBSxNNGdsUQws=
X-Received: by 2002:a17:90b:1dcd:b0:35c:69c:2a12 with SMTP id
 98e67ed59e1d1-35c0cffc5eemr4292678a91.0.1774469807428; 
 Wed, 25 Mar 2026 13:16:47 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c1dd3800bsm151986a91.1.2026.03.25.13.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:16:47 -0700 (PDT)
Date: Wed, 25 Mar 2026 13:16:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Aman Singh <aman.deep.singh@intel.com>, <dev@dpdk.org>, Thomas Monjalon
 <thomas@monjalon.net>, Raslan Darawsheh <rasland@nvidia.com>, "Adrian
 Schollmeyer" <a.schollmeyer@syseleven.de>
Subject: Re: [PATCH v4 0/2] app/testpmd: assign share group dynamically
Message-ID: <20260325131637.74f01067@phoenix.local>
In-Reply-To: <20260325190906.68531-1-dsosnowski@nvidia.com>
References: <20260325180255.57489-1-dsosnowski@nvidia.com>
 <20260325190906.68531-1-dsosnowski@nvidia.com>
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

On Wed, 25 Mar 2026 20:09:04 +0100
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> Our internal regression tests have flagged issues with shared Rx queues.
> Specifically, issues with domain mismatches:
> 
> 	Invalid shared rxq config: switch domain mismatch ports 0 and 3
> 
> These started appearing after commit [1] which added checks
> for globally unique share group indexes.
> This could be worked around with --rxq-share=N option,
> but it does not allow proper testing of all use cases [2].
> 
> This patchset addresses that by changing behavior of --rxq-share parameter.
> Instead of relying on user to select proper parameter value,
> testpmd will dynamically assign globally unique share group index
> to each unique switch and Rx domain.
> 
> [1]: 8ebba91086f4 ("app/testpmd: fail on shared Rx queue switch mismatch")
> [2]: https://inbox.dpdk.org/dev/yotjxacqrodttraqrr3r6ftut4cty66g6cjnr5ughswtatapgh@gqqkftskp3qq/
> 
> v4:
> - Use short circuit return try_release_share_group().
> 
> v3:
> - Use short circuit return in assign_share_group().
> - Replace assert in assign_share_group() with error checking.
> - Do not require optional argument with --rxq-share option.
> - Fix typo in docs: update -> updates
> 
> v2:
> - Add releasing share groups when ports are closed.
> - Add static to share_group_slots array definition.
> - Remove double empty line in revert commit.
> 
> Dariusz Sosnowski (2):
>   app/testpmd: assign share group dynamically
>   app/testpmd: revert switch domain mismatch check
> 
>  app/test-pmd/parameters.c             |  14 +--
>  app/test-pmd/testpmd.c                | 121 ++++++++++++++++----------
>  app/test-pmd/testpmd.h                |   2 +-
>  doc/guides/testpmd_app_ug/run_app.rst |  10 +--
>  4 files changed, 86 insertions(+), 61 deletions(-)
> 
> --
> 2.47.3
> 

Applied to next-net thanks
