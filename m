Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D39C02198
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 18:55:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2495840665;
	Fri, 14 Feb 2025 19:55:02 +0100 (CET)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
 by mails.dpdk.org (Postfix) with ESMTP id 3E11740651
 for <dev@dpdk.org>; Fri, 14 Feb 2025 19:55:01 +0100 (CET)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-308e65891e4so2130181fa.2
 for <dev@dpdk.org>; Fri, 14 Feb 2025 10:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1739559300; x=1740164100; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nlFpQH0DFDzVtw8cMT7Wq2IjOKUc25FX2gnrht453vY=;
 b=YUOZ8PAe73dS50rin8Qn2KP7qAEMTRqgsH+aZ77nUs64AlgXGbMjviYvqltCrMgIt4
 7ik7Fe2M4wPhwBXgPaOZAatXSJgO9buHbMDMcvc8shyB8fzE49BmvtgvCGrmqufXwW1L
 4qDetzniIr1DPXYSkR8lblVu9sZB0UEdz4C+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739559300; x=1740164100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nlFpQH0DFDzVtw8cMT7Wq2IjOKUc25FX2gnrht453vY=;
 b=a9lgoZunKreOwNFDlK3nVPaeU6t3j0ygVUYgv9gEEad1/3QrBQcQ0lzV7MO0pambYu
 jR5zONRGlODlpDWYDOj1sXx9FoD/E1cQtWeHJAOzZAVOpDbWtAp1tiNNA/+jwGdWSbdg
 9Cn5P8wOq40Hoz9kai5YSkRb5jzf+IWgmo6ZdxEw11ckJfYzlkyh0hXvSKr/t0mSYGnM
 9hDVg4FPcq4MAQLRumMtyOSSsOFF91A10jMBFEu2dGKI9SgQfRWp90H5oF4EKIcZ+8K6
 WJLQajxaQLJxSDYL6bH02FPfBXVqWZNzyo4EQUAY2ooir2/3kBc5S+BBAE6SnVYdk+mR
 rolQ==
X-Gm-Message-State: AOJu0YzNnNDcT9PaJYxbTKI6w9nEZ0k1UAoPV+yZ378G+seslS01w7zi
 kzq7p27ddhZvtJTn8lbNY/BtGcYFoRleSCrmh2J/beNJ1ydPEqSLb/nX4XCLEMdW9maC72WfVDp
 sB812VP+idMvSRSZeHuej40mM4lr7OKhmDEpNVQ==
X-Gm-Gg: ASbGncuOtEok8KqXz/ODIT7dLIwQZUvP/0D68D4HMOP3Y0uzG4LbfjiVSMYmgELqXeB
 atC+YsqGQdLZdOURGmCRfwDz7ZHceYRJADdrJSJnl1LAsJe18+DABBLQotq049N1UBUfKMpZikb
 ajhlj6KqXGIALBf/U/UVSFEMxO/L90Zf4=
X-Google-Smtp-Source: AGHT+IHH/iZOqbrcI34apd07F8A+9Lf9qS/oPsw4tGzws5c6Irfw68LO/Y6V771RIHH+xX3omJqEmUBV3hVgAeI220o=
X-Received: by 2002:a05:651c:991:b0:308:f48a:5560 with SMTP id
 38308e7fff4ca-30927b0133fmr859731fa.8.1739559300508; Fri, 14 Feb 2025
 10:55:00 -0800 (PST)
MIME-Version: 1.0
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
 <20250212164600.23759-1-luca.vizzarro@arm.com>
 <20250212164600.23759-7-luca.vizzarro@arm.com>
In-Reply-To: <20250212164600.23759-7-luca.vizzarro@arm.com>
From: Nicholas Pratte <npratte@iol.unh.edu>
Date: Fri, 14 Feb 2025 13:54:49 -0500
X-Gm-Features: AWEUYZnefU099iYJoDBnEHviKZ4NbRcHoxYdAt7_oRQEaj-mbF-mUybaWkbOra4
Message-ID: <CAKXZ7eh5EHbJ1mNEQ2+ht-8R67CrM-dqSCzR2kGP6nEC0O33Kw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] dts: revamp runtime internals
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Dean Marx <dmarx@iol.unh.edu>, 
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
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

This definitely cleans things up a lot!

Reviewed-by: Nicholas Pratte <npratte@iol.unh.edu>

<snip>
> @@ -217,9 +218,7 @@ def get_supported_capabilities(
>          )
>          if cls.capabilities_to_check:
>              capabilities_to_check_map = cls._get_decorated_capabilities_map()
> -            with TestPmdShell(
> -                sut_node, privileged=True, disable_device_start=True
> -            ) as testpmd_shell:
> +            with TestPmdShell() as testpmd_shell:

This is probably a needless concern, but should this change
technically be in the last patch in order for it to stand on its own?
Not sure if that really matters or not, but figured I'd bring it up.
