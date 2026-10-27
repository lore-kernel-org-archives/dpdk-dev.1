Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A785606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fwmw8zGp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C335140151;
	Tue, 27 Oct 2026 14:46:09 +0100 (CET)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTPS id 64B3D400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 14:46:08 +0100 (CET)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-8a06b44bd01so2228252b3a.0
 for <dev@dpdk.org>; Tue, 27 Oct 2026 06:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793108767;
 x=1793713567; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ekVXUZdYJih9R3c3dN2DEn3Rh9fkiM2A7NZv/m1KeKM=;
 b=fwmw8zGpf30Ug+Agg1Kl3DZYQuboRZOcZ47wINNUnJLrBmqpy2LQicbu54ppP8ey85
 y//5y+i5Gu4uishkZrJovAwnQYQuwZxj6vkXHkuBQvBO7R6szAn4WM7B0LE1q4d155/R
 4eQ6YUcS/kK3/HOBVP5Ox2n8+OwRWc6EMEgRat0cLR7pEWN6RKSNXDsrjrW+A9nzqKF3
 djFVyox0ULyjfIsgqR+3NFUud5CvgZESTniR4rsEyYayaVwqLjbuxUvNVPLtQZvKOVhE
 IrAU1qKJ35kzpkYxcjSjuVt+o1QjVaDE1Y1oZnDhT+1YyAfvFG3AQVsEsR3Ur6ZlAiie
 b/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793108767; x=1793713567;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ekVXUZdYJih9R3c3dN2DEn3Rh9fkiM2A7NZv/m1KeKM=;
 b=MAFeFcRo3BctpF0KeKDzSv0Ot/u5bCJ4SCx4MEra8SdRYefaonibN0js+XtW+jld+c
 8079/Ct+RVLrktnc+Fl9bxw1yegLCl/VVBT7xRV9UcW0PRxLToCYcXBSPWFRIKZrA+vv
 l7HyGByLwlPmb6BVQ0JVyq6EHpZRfmlhlxyYJ57J1ZUpxK9SsFnRfz2qcWm873GYJ6mZ
 x+YAeijh2Qj1xkXh3noWEuTTpGaVDmgYeRROLQ5dhsk2Wv/npCQsckxEQDj6Qmf9G3S1
 AmOCyrqHHqvFO4vjgA7Rro0zr4Uj1c3nGclTJuszpbHFZbeGniG2xjXrUK7ogK2fb40Y
 fFSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMSQlo6Jm610Gj9L/ehfCQ4uiJz9E+FvBHmkhzcPhH84RZaX3lqa/rInha5ykR2FCMwEY=@dpdk.org
X-Gm-Message-State: AFq9FYKRI/1XthskO3KnhkAOJPzS3s2I6nAetkZdVCxjt4e5ispSkj9/
 wxcj1S2FObl8DxAzd/zbcWIUlBC6jnYs76XlEVNt7rjHT3kaxuLaKRTO3Ihj59FDRsI=
X-Gm-Gg: AYBFou1WMgYg/jIPcRytMCq1bysfjq+YjXJ7kw7fMMMWHMB19MxhaVZfJiHqlzSYwiZ
 nfasPevTFuKrSe0ghcFmD/vMto7ikBX/uhx4cT6SPxyxfDcSTKGvd07pBkBNsB/AnejiOPzK6e0
 kzvQ4QLNqJYwVlMrNSW0V7imWLRsHsV4HrbYle00MTmMs/cTuuPbzVo2RgpfXo8UjGwXX3WVjvN
 QMeYbBQ3zKwxT+XOEX7Cd3eFCJ4EveaAyejmbkBFdAejAWU8w4X/16Myvxh6r5pFcQKczestvk0
 lznG8kFpPWrTe3eCo1A57ZSIY2XmNjHSzsVQYCv5sku0zGXGaUR9BdrKKXhboBbyc0cGaX3fYqq
 RyQp1M1TsJkTeXdcFzHxjfylkSWvnXMJaMOoFu3XK8kZ3+2ry1a8jPKzJQG6aR+dQsSr2cxOBoV
 Qz5MsJv3RUT/+t2LqZa1Lt4iYTzjwZkkQzh3oOoHPG9jS3nIe1TThJddg/czc0vtK64TFtMVYKA
 DXfs7WoykTuY0nR0eG52igB9nOQj8JZ8YCInFM98lgnE1JaJJc2FM85R3vL3FXjR/q2VNGCFtE1
 pJxlx9UXC6wDFoNtGrSC+g==
X-Received: by 2002:a05:6a00:ad0e:b0:880:5fe5:a81f with SMTP id
 d2e1a72fcca58-8a36715c4b5mr8378973b3a.11.1793108766736; 
 Tue, 27 Oct 2026 06:46:06 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a6a3d5e08bsm50299b3a.5.2026.10.27.06.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:46:06 -0700 (PDT)
Date: Tue, 27 Oct 2026 06:46:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: Gagandeep Singh <g.singh@nxp.com>, dev@dpdk.org, hemant.agrawal@nxp.com,
 jun.yang@nxp.com
Subject: Re: [PATCH v2 1/1] bus/dpaa: fix maybe-uninitialized in
 bman_release_fast
Message-ID: <20261027064604.32e6505d@phoenix.local>
In-Reply-To: <CAJFAV8x05HOZgC9V4PbQfT-2z-htEajud66KVpneX4K=qDjL_Q@mail.gmail.com>
References: <20261027061531.3970219-1-g.singh@nxp.com>
 <20261027063131.3979699-1-g.singh@nxp.com>
 <20261027063131.3979699-2-g.singh@nxp.com>
 <CAJFAV8x05HOZgC9V4PbQfT-2z-htEajud66KVpneX4K=qDjL_Q@mail.gmail.com>
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

On Tue, 27 Oct 2026 08:48:53 +0100
David Marchand <david.marchand@redhat.com> wrote:

> > Fixes: e55e2e2d0c66 ("bus/dpaa: optimize DPAA multi-entry buffer pool operations")
> > Cc: jun.yang@nxp.com
> >
> > Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>  
> 
> This current fix lgtm though we don't have CI that ran on it because
> CI tested it against main.
> 
> It should go through next-net where it can be squashed in the original commit.


Applied and squashed, will push update today after backlog is cleared
