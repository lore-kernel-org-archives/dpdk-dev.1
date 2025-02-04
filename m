Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E7BC02193
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 21:08:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7B0640265;
	Tue,  4 Feb 2025 22:08:24 +0100 (CET)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com
 [209.85.219.176])
 by mails.dpdk.org (Postfix) with ESMTP id 7780940261
 for <dev@dpdk.org>; Tue,  4 Feb 2025 22:08:23 +0100 (CET)
Received: by mail-yb1-f176.google.com with SMTP id
 3f1490d57ef6-e589c258663so5784298276.1
 for <dev@dpdk.org>; Tue, 04 Feb 2025 13:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1738703303; x=1739308103; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rZ+mJk+aTE1iSYFfEzfIMtpBnkIL9ClFAzz9eOzYHHw=;
 b=IU9OGRidMWVTJSLFCDioayjvV9SHp2JfrHoncGDZCFIN6RwRcRu6EX0gJlb7DtmB42
 zcQHeAp5o4MFDWYZsM1cdRC6R772KKmjlfvyDNw3MWHaG4nVgb7bZFv+Iw/zGCd5HJvs
 hMl757c7LXpykQukWVZxgsfKMpxj68NGrYt9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738703303; x=1739308103;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rZ+mJk+aTE1iSYFfEzfIMtpBnkIL9ClFAzz9eOzYHHw=;
 b=WxEpi7bqgHUtMVJP/pdf6c6aumaMF20C6k/G+c4pXwMlQLjvZKlwj9ylNS6jIlLpft
 kbnMgxQiIBknEswjM4rtu6J08jVDGv1mz5yneayp4Hn7F0VdN7MtHX0hefDdE/cWn0aL
 NURqj3SMhFXHNf4jSmTSIHEQVd411McMFuLJxCCGG6aR54Uu6y6tAXgnh7Tu3Hr7+VzL
 3TMcek/TCCRHej9p+FfnsK0dh50DDDQDAaPCSdJ+jTvHO8hW8+9xqxkAI5lKE72aVHoX
 dmxByEJXF+v51tsPvaCAEBMO2q8FcxFXcrEntIo148yukMOLL32bUaG0D3LR38iUxoMI
 FEqg==
X-Gm-Message-State: AOJu0YzxHZ9H0BMq5gGMQM7+o5hN+8w30Zf6P6P8VjQm35GdTy/fVQje
 zmrJCBIAE7MlE1GYWNfDvDPTW7ieO3QZjTkANfmd+rSBRKXMKT6jR/ZELHEVzrcPBHYEF4T2e/z
 j16P/z2fKEruFG9SOPw4bk03NAiQ7C6REnt20Dw==
X-Gm-Gg: ASbGnct44haIE456em1iwdc2ePCRhv1cs53XYRPuSKHv+TZGGYIrW9BbkCdKkxEvl48
 UdlqrE/xyRz9NJR7nshSAe6aw+TYRM+U79jc3OC2geVXtYCcppvWl9HIVpeVt+6mUO66kTJPIe0
 RK48Y9kL8urgen2grpaTu10SvhRsKBsUc=
X-Google-Smtp-Source: AGHT+IFATAeDumtESTeaQ4ssoZUSlJdlfou5HVFXSZ3zbI1+VQspf9wPYUFvM+pZFkatSS8rQKC1somGj3mcfJCDwDc=
X-Received: by 2002:a05:6902:2505:b0:e5b:257e:c3ab with SMTP id
 3f1490d57ef6-e5b259d2cbemr482257276.10.1738703302758; Tue, 04 Feb 2025
 13:08:22 -0800 (PST)
MIME-Version: 1.0
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
In-Reply-To: <20250203151613.2436570-1-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 4 Feb 2025 16:08:11 -0500
X-Gm-Features: AWEUYZmu3j6B2wDTvl-Vlu-8wiNUcdehSUvx-gZ-NsZrolZfSEvMy-b23NfN4Ps
Message-ID: <CABD7UXP1rU9ZC8uQK33B4H5QR6noQiu9agwR1yapEOpn81EZ5Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] dts: revamp framework
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Patrick Robb <probb@iol.unh.edu>, 
 Paul Szczepanek <paul.szczepanek@arm.com>
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

Hi Luca,

I saw in the meeting minutes that the main purpose of this series is
to implement the separation of concern principle better in DTS. Just
wondering, what parts of the current framework did you think needed to
be separated and why? I'm taking an OOP class this semester and we
just started talking in depth about separation of concerns, so if you
wouldn't mind I'd be interested in your thought process. Working on a
review for the series currently as well, should be done relatively
soon.

Thanks,
Dean
