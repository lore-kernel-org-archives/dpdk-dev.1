Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F978C982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 15:57:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66F5242DCD;
	Mon, 21 Sep 2026 17:57:54 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 3E12342D76
 for <dev@dpdk.org>; Mon, 21 Sep 2026 17:57:53 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d747eefae4so9688935ad.0
 for <dev@dpdk.org>; Mon, 21 Sep 2026 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790006272;
 x=1790611072; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H2Nkpct/47ZKDvPqyUgO8opF3TlUFYhz4O/rS8lwxUY=;
 b=TIovmNzHfFOwR9bgy6EB4U7hhlE4kkqh0nwkaps5Jvs04VTYbbuvZzeRPJtySGkD1a
 I3DswMSLZ/Zx7cl64ZXRdlZxoaNXMbkM1xDM1a/2OZaVxXdqCkw5z3D4Dsc959FsUbAI
 J6E1OYg59IXE9PhyHK0IhTo4fFe0wKiRJmLfq/obbDjjpRMnB0KagJHv9Uwk6SmvRBxI
 e6rqBWCG2WFNvCqAj6/3YOCDiIKRmk9ajJmARAU8TKJQKuyeEqWZ06uoNYPq5n+CFwZV
 Yy6NfBzZA87tgOLJi9CQ2wSCzUgEZzhayCzkXSZINcQkYy1P+0tnPo3HF+F+M18cNPGq
 I3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790006272; x=1790611072;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H2Nkpct/47ZKDvPqyUgO8opF3TlUFYhz4O/rS8lwxUY=;
 b=x7fnON85cEqzpKuAKhuh5QnNdDvHhHXqzYr33i2LCBVHGpI3ajy08DDmJf48QzIbFb
 lxtd5dscqcOaKb0qaENkybpAuCgD2hpjzzICc2at1xXBYT6sDS+vyIZItZQXPvbywn0r
 n0sHIaFAEtseQVuGXLYWik0pdcvm+15Z53xfXOvm3VTzxjtgrQ/y1UL2C6fVJsAnJHec
 v9KwjxSHwRH1Bjrp6PeqgIsVXdvYCt1ovhdzjylhzQAsUt+5Dxq3orjo79//F2f/Dy7c
 HfysekK5Eq3Y0lNo9tgLVy9dKF5eKpddGcPphvb6HBzlzIXWzCL1rPauSbnG97j/oOqi
 Ac/w==
X-Gm-Message-State: AFuF++l/8Zz8Sa8UZHNt8ERZ/I1yLjknJ/wGiedKKN2k2sQfDxrmYoDm
 aorqprqe1fXKXko3iOo1Bs29U2OWNRn+MRyVDgtLAY8Rh0QTCr8TLEdnS7s0yRcsxtk=
X-Gm-Gg: AYBFou3mHy4HN/+RUfHRaQgVEcy+O6PRH3uk7nxG39a2WQbq+rU4Ik2b4DVw6+y46LH
 OoQZ0Bg1+ZTHm1anU4y1uOLll2WgG6V6sMdO77PWI4dyQPxuOO3KTAdhrni3pqTAMDgVIXkD7jR
 DjhUWCDD+2QM4I5iXMhzGRiaGDAc8oix2cHI1KBHYc7avBw5skqSDgC/wlu0p1hzJ7mLE8sy604
 6qct4ZcZ3hdkpWK/GyeqEHRCeuBH5DWo50mlSnvyjF/X+hFekZ7RZ3tHMiF+h3lfeWymTFz1rIf
 zLAxyB1gq6F6azM2MKdJbOv41CwD4bptzwRaoP9WKrzTaddxgU/SIbRHNEb1cSGHGkT2+Y4OxCF
 E6FLzxbXRLo5tyZ0KNZodVvm1HDXYmYz4O3X6vAWmw+cgcH60pPKpHaKPhO+9AH40VUpr1vV58f
 1e4wMkmFMoAL81em4KlehEJjMiQ4TnIELAmHp3zTlL3PfNf5pfJJcBZkx0ViOjepLFhXZ28Pv8Y
 FIxsDjPOq29iz2nF0lSWsNmx/xRoigyifh3m6v/
X-Received: by 2002:a17:90b:3908:b0:3a0:2900:f55e with SMTP id
 98e67ed59e1d1-3a066b27b25mr36316a91.29.1790006272151; 
 Mon, 21 Sep 2026 08:57:52 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a063f33101sm739922a91.2.2026.09.21.08.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 08:57:51 -0700 (PDT)
Date: Mon, 21 Sep 2026 08:57:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2] examples/rpcapd: demo version of packet capture daemon
Message-ID: <20260921085749.0966b507@phoenix.local>
In-Reply-To: <2801d980-791c-4552-a9cd-4ad705ebb196@gmail.com>
References: <20260908210832.1556291-1-stephen@networkplumber.org>
 <20260920190007.1128720-1-stephen@networkplumber.org>
 <2801d980-791c-4552-a9cd-4ad705ebb196@gmail.com>
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

On Mon, 21 Sep 2026 10:51:39 +0100
Marat Khalili <qm2k21@gmail.com> wrote:

> Very cool example, demonstrating many advanced DPDK features at once. In 
> this regard, it really excels.
> 
> It could be however useful as a debug tool, and in this case having to 
> deal with a secondary process is a hassle. Could we have this feature in 
> dpdk-testpmd, instead or as well?

No. There is dpdk-extcap which is better tool.
Testpmd doesn't need more bloat and opening a socket in testpmd would
also expose more attack surface

> 
> Otherwise, having seen the demonstration, I do not have many comments, 
> except for a couple nits below.
