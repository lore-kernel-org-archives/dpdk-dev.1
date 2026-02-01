Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B61FE6529D
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Feb 2026 19:01:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55EA4402F0;
	Sun,  1 Feb 2026 20:01:15 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 56DD340150
 for <dev@dpdk.org>; Sun,  1 Feb 2026 20:01:14 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so27312585e9.0
 for <dev@dpdk.org>; Sun, 01 Feb 2026 11:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769972474;
 x=1770577274; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c6oYG/ob6dTa2LONHYMzYg6m/oK+bbyMQHBEpbRHCnA=;
 b=XovuCaWmB6dF95gwAfSk7OJ2vgkB60RBnJiLbiViEQla0h/yPgpD2i3kyi1PZDYMmw
 SshWfzXlJ6NUUUFqc8t/LfWCRSvx4VIJj2hBbG89g0cTu8TJDor3ctaDyySrU4C4WC5U
 TSYr7E4KYsINmVUMlnJ7FyJLx9xIhJ/jkdeqUhSp4IaO6RNNZ+MadGjyflP3QmIygujU
 +W98pYeWX9qAbLVSSD/m5Bs1DQUg0rNGfUYI35U2yjNOWf1F+Q6n/QLDdL30/W+gpmZ9
 zJt9R2HDDTTW9cxUhAt8LUoZPNbsPK+gmOoCxJ15R+c2p79Wvz8JFgyIr+L5KquqJdzc
 nvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769972474; x=1770577274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c6oYG/ob6dTa2LONHYMzYg6m/oK+bbyMQHBEpbRHCnA=;
 b=p3bC4qe4yfBXKiylXPqFQ70z0sZgERDvK0Ve2kMMYXCGaX9L4jReRkq3CD72kF/NpG
 LwyReyclSPhdaVVNSTXvjgk15H0gcbyLDdFk99ZW7Ru9vY2+Su5q0KK76Rx82ECR3xzA
 H1SxfDw5cStpBaS7aZvAB7w18aUX7Nrgu+DHKMGJ670c+mam4F8nHrF8/htdbqVmDCxd
 wTO+zfKmj0NukPoftzxw96NBSUgXFV7l/VPjoPclJlW3HQ/F0oY8+eX06HqM3yQAOZnt
 5l3dNVlNJwV2KYBy7zB3sCSMF22JSRI7vINNLzlFmKwSghm71WgsIV6qPcrvfYbnf9uV
 URhw==
X-Gm-Message-State: AOJu0YxC5fiO59C0gFwkmaLEq8djL1sKWGnY9N0ksu9cnzSL/WxOtoe+
 f5uQ38juIGY+VNZ2KMHPYnA5w1zDyWm7eBmN9YVACxvjk2BaGM5k8lfubh/nh9Qk71k=
X-Gm-Gg: AZuq6aL0T8mQpzf7tQ5FVDZyTaa1VJZMPryaCcNX8g9V5xUTXiQZF1frQiRBe6+1swr
 pdR29/YPbaoqqHYiqJ3o1p/Gk51dFb1kSsHMMeXD40kwcc5J1g2gD1F48jh+AyWQ7ur8Ys6voDi
 mCVv96BATiwE3MjT7E5Gxh5txb4ynI+AQfOdcylczJbX4sjGeZKGlg+tO4brBAilGUdEa/h6Tpq
 +lWonH3Hk/IQvZEmYnUArp/CEv388X07dVMTRxrf+IHHvOFEfFLtusPIpoNf4losLY3mluzlvAk
 rIjtwu3ypyYIng+q9iDC+EiVoHEQu9wcCHdgKHId5Tjef7JZ+ppQ5ZgW0PBoeiz5EsoSFS2ktEg
 ulMfhmJnQFL32x88ciuyuzwgxZeAyHcAt6ThzlnuODXvR2VCMhNbd/J3vh/eR70IJ8FesNCfDRm
 lkkNinNaMbXHzOldnyF2/XAMzyc5ZkB6CX494r8DC10VTPcpMAGR3u
X-Received: by 2002:a05:600c:5566:b0:482:dbd7:a1c1 with SMTP id
 5b1f17b1804b1-482dbd7a308mr75026905e9.34.1769972473822; 
 Sun, 01 Feb 2026 11:01:13 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce4c515sm330144455e9.11.2026.02.01.11.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 11:01:13 -0800 (PST)
Date: Sun, 1 Feb 2026 11:01:08 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, Aaron
 Conole <aconole@redhat.com>, David Marchand <david.marchand@redhat.com>
Subject: Re: [RFC] devtools: replace get-maintainer shell wrapper with
 Python script
Message-ID: <20260201110108.5d80c3be@phoenix.local>
In-Reply-To: <3273409.mvXUDI8C0e@thomas>
References: <20260131204823.29363-1-stephen@networkplumber.org>
 <3273409.mvXUDI8C0e@thomas>
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

On Sun, 01 Feb 2026 14:51:01 +0100
Thomas Monjalon <thomas@monjalon.net> wrote:

> 31/01/2026 21:48, Stephen Hemminger:
> > DPDK has been reusing the Linux kernel get_maintainer perl script
> > but that creates an unwanted dependency on kernel source.
> > 
> > This new script replaces that with a standalone Python implementation
> > created in a few minutes with AI. The command line arguments are
> > a subset of the features that make sense in DPDK.  
> 
> Almost thousand lines for this new script.
> Are you sure that's something we want to maintain ourself?

It really is less bad than the awk mess.
And the kernel often changes the rules.

The bigger issue is that the python version is not detecting everything yet.
