Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877EB606A31D
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=m1ky/7dG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6888D402E0;
	Tue, 27 Oct 2026 17:11:01 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by mails.dpdk.org (Postfix) with ESMTPS id B6FB2400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 17:10:59 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3ac7c7b3a90so33399a91.3
 for <dev@dpdk.org>; Tue, 27 Oct 2026 09:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793117458;
 x=1793722258; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8gL/fTQUcZFKw6pnrtx5uspSJXWLz2k4KsqVCa5NL+g=;
 b=m1ky/7dGp0Rxnmy6nbWl2Q+w4XKuhM2Fjmct/hmgizTfNRRtmeMT0nVToW40IP1Sua
 DIxNtXh3MX/GxPNhiNp79C4ImK34kX43Bjc63vZXxJfB2HfUEmyKwh3Reimys7BGm+aM
 nkdvyhxJ8Hvyeid3SSk61PtM3sDNZhi3vlMUGzrlQu7bpIvhJNCe1VQZtjJVvafMNe7m
 FBMHPE2XELdH/i444Q2q+1RdwBMxPIjoJ5AcoEHagcm09rEeCm4zSyzHG7/sP/7F4xud
 srDhUUBcF8OwFm++ewLYYPtktycY/a75aAurctlGkaXfoMeNcwB5+PEfwJXzTpzswMHn
 dTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793117458; x=1793722258;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8gL/fTQUcZFKw6pnrtx5uspSJXWLz2k4KsqVCa5NL+g=;
 b=lmWlaqrFJWO9AClSzKtOqaSysvTmc18xEYvMYNoGoTJ3Vn8zjp9NcEWhQWjg5KgSPf
 LKWJ4VZzO6CspuuO2HJ3VTanUOyYbT/45ldo9HtAbaNuxrlElOKaASfmxc/Cy6SyTa/O
 BFxIjimzXsK5UEu/bpOBLwlDZlM6liQFPdMcpOtWxlPh30YIsYzMNcCLHFMdLCfj40pk
 /gfVhezjNUeBPxDbxcXjDPbv+UuCCgO5NsI1jfjCKNIUNZ3CHUnyKsg7E39esMymXKEq
 TXzJTmvz6vQElnhCwNkUm82rQ0w4p1A+O9HqSHMjjZjy33TUoe8QFWOh0/yCZ3DRe8h1
 jSyA==
X-Gm-Message-State: AFq9FYI1VURxz3sOmGvzKUAZwyMArVuuL2wsic6NEHkCTtSkgVgIBvfh
 qdgg2J6RbyDxgTAWOv429iKbHRt3pS+MmQahZUVP1NXMbBTYVHww33UfEf64+5qlN4O+gH5GR2Z
 3OVNQZ8U=
X-Gm-Gg: AYBFou0+D6k4ifmZridxFPFwDKYmviAPsdOGEVGrBbt0TYglAHfE4xM3fsHvjYbC5mG
 jsZBR99ZQw6ItUqNHVuuCBp4FbU1miqofWdVsu8YAAVrVrAXHcQw2G1SeXxAU5nSuIbPCzeVFYm
 tEb+B9/2Pb2vzt77SxTIvGdPeCCkYaoFGAJcs5bmKNBkRA6IDEc7LOW9JDx6AipgYwkGt2Uxc5n
 o4jIhS1ooVnz3Ap7MHmgLfViu04MGYPp1cLeGcNdzXY3t6YrZkFMmPytF12TxEnH/ucR0DcU6Q3
 A/5ZBhlufCgeQ2emw7cgBdrq5rempToVgRjLWjJ363WvYLuOBXTfdAAoT5hE8zP14ogFjUwTWXq
 bTQcf0Kof3pht5zvoWmDkCHpuBKmntJp1qq57m8DwXYarm2mRFTYzg0k5Jnfem5n0Uay57wKT9g
 8Y2VB9pK4QWMyCTGAB76LZLYlBLEQlcRJ4JpUpWeZJNoUomjkq1ZOFu8UMF+RQGSdxd1KLGQTLp
 +LzoLwS2onZ5YTW9MTJXPe0Q3gu5W6tkpZCbTlbnYWGutLhCCXWjCJ6lG+PCxLMcYrZ8aR7QHoV
 NXmQuoCWSR36lcvDAFdANkkW5AMKFPspVg7bsdk/as0=
X-Received: by 2002:a17:90b:5686:b0:3ac:9ed8:f310 with SMTP id
 98e67ed59e1d1-3adeae64a6cmr9474897a91.49.1793117458304; 
 Tue, 27 Oct 2026 09:10:58 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebae7f3csm9149581a91.3.2026.10.27.09.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 09:10:57 -0700 (PDT)
Date: Tue, 27 Oct 2026 09:10:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH] Revert "examples/symmetric_mp: do not print or exit in
 handler"
Message-ID: <20261027091054.0f902c3a@phoenix.local>
In-Reply-To: <20261027150748.1170031-1-stephen@networkplumber.org>
References: <20261027150748.1170031-1-stephen@networkplumber.org>
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 08:07:48 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> +/*
> + * Signal handler configured for SIGTERM and SIGINT to print stats on exit
> + *
> + * This is not safe way to exit for a real production application; it is just an example.
> + * Doing proper shutdown with primary/secondary requires process monitoring
> + * and rendezvous.
> + */
>  static void
> -print_stats(void)
> +print_stats(int signum)
>  {

Needs fix to add __rte_unused here.
