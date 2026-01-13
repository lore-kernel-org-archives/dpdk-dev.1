Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D736BCF45D4
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 00:39:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABE8D402B0;
	Tue, 13 Jan 2026 01:39:48 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id A2F1F402A2
 for <dev@dpdk.org>; Tue, 13 Jan 2026 01:39:46 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-47d3ffa6720so65229845e9.0
 for <dev@dpdk.org>; Mon, 12 Jan 2026 16:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768264786;
 x=1768869586; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XzLzbWFB5xoPfOEdDks+nkQVIfMppMYYrc62mEySFeQ=;
 b=1ywamX3evrOf9gLbwFv9eq++GBcN+swG+mMy6aE7FxkxZCh+gcZHfaAUCJLJs8xun9
 JoetMQlJ/jnVsfkMqSiPk9/xP+dFSGikC2sywpMkogeD1j8FNvdzyejUnp7I/K4/E5/X
 zXVElzExzf/hmqxQFmwUXJK0S36vShUhOBnqk/4nXaAekRB0Ht5mt/7jF/ZKFh73CNvY
 aofYD2CXX2U8tQl5UxwaqwGU8deIYLVzF+0Gqa9RhYv6QM+oA9w+AoCHmgdEEkCI4lG9
 CwbYKb04pBGbnkScyLLJUNUbJKV3fGsPV0M73oJ+JJJB0DufKprvKPGYzEKxQQJiYlMP
 MaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768264786; x=1768869586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XzLzbWFB5xoPfOEdDks+nkQVIfMppMYYrc62mEySFeQ=;
 b=jhFQ50lj0zm6R5RRX/D7fozFxGCuKuBFtq5gYTzs0CUT71Epq5VR10/8Cx/ti8Nf34
 InHApzgeu7WdElinjYBBEvV8nMUmvyikQ+VVucgiXykn3UOVv7+LgNz1ziX8F0a1Wdil
 PIVPhzuPO7cwFwZDKYTQZUQuhz+aufv8/9NrWlNG+J9mOsDQ0yx7ZV3C+mRwW9cYkGf1
 /SdalkVmQ9LWbINMpNwtfqkVrePC5K4R35RK9ZrC1JT7+2CzK/cB+XcXpdu6lDZbSZeW
 wjfaGwde3ef0g48iVkigopwRufcucZIx/GNeT9gEAON+LB7QNLAXLQmXWp4TSIFHbb6T
 OsqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyp9Qy4jqQxBMMPzAhE8TOeNSD2NSK8mSnZOGvpwEIS0SVUrruupL9p4rt9FHUsKlaAm0=@dpdk.org
X-Gm-Message-State: AOJu0YxWQeiv4xubBiK0CUpWeNazglN76unvcdBKjFGodgUZdXRw+iii
 cuO7+mLDkdIaTqtfr6KmYY79x5Ej6YdU7yivNmiAZooNSyiZMd0EvawH5uJpAfwZ8KU=
X-Gm-Gg: AY/fxX5fqN3xPLYgtk4nGyOwnWL7p4MXdBkB0uDR7sJmxXnkaOeUbuIUtcsHG0gEToP
 yn088Mgo4pNVmE8Wt36ZBFoyHFESY2hE3Pmqj3oKGAypXUMITcaLTFr4sMPVaOKq/tYUIFNCTfM
 8Wzn3I03v+yv2sSDp16jsq7EvudgEyvQZadcwhHRlCbBnm/k0mjDrbwngM0ZWabr28pLEXEUPau
 JUkHipxN3bf3Gt/S8y8pUO7bLLQPAV19Sz3khY8Mt4NAFAUUbh7Nvx4/iu0TNoeeHWx7Ix2Z6Pi
 tG7RGB01F25DkWhq3xHSexqc3xQV5NdbychPONwiWYNNaW9cMbhNNwyVljhR9l0PVArGF9iK+zf
 VAv7y/6rItXGlgLVm4rkGE1L3GTB5r0EBWWKCJnrpdiSButV7Itfk4TGNYgOzzn2g+d4M4rsj0k
 BE7i70FYrOwXruDTMwtiYDK/nb7cHNiqAnDu5uYTcmk8ryWjhlr/WKpc2pmE+4g+g=
X-Google-Smtp-Source: AGHT+IFHLeegb6w44RcxiimmjEWHBYmqZxKNvEgbfwqxmX3KyJcNoazNHj55lbH4Saa+vNej2DZsZw==
X-Received: by 2002:a05:600c:1394:b0:47d:3ffa:5f03 with SMTP id
 5b1f17b1804b1-47d84b3467emr237465125e9.21.1768264785921; 
 Mon, 12 Jan 2026 16:39:45 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f68f4ddsm386804075e9.2.2026.01.12.16.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 16:39:45 -0800 (PST)
Date: Mon, 12 Jan 2026 16:39:39 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Scott Mitchell <scott.k.mitch1@gmail.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>, Konstantin
 Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org, Bruce Richardson
 <bruce.richardson@intel.com>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>, Vipin Varghese <vipin.varghese@amd.com>
Subject: Re: [PATCH v5] eal/x86: optimize memcpy of small sizes
Message-ID: <20260112163939.12c7cf8f@phoenix.local>
In-Reply-To: <CAFn2buBx3JNXS1pb6w=0S1HOAxmG+HVTkk=_b+1kou5MnAnqpw@mail.gmail.com>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20251201155525.1538260-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6561B@smartserver.smartshare.dk>
 <c2bf94e103f64dcaad115e1d3d39d654@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6564F@smartserver.smartshare.dk>
 <CAFn2buBx3JNXS1pb6w=0S1HOAxmG+HVTkk=_b+1kou5MnAnqpw@mail.gmail.com>
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

On Mon, 12 Jan 2026 11:00:36 -0500
Scott Mitchell <scott.k.mitch1@gmail.com> wrote:

> >
> > The discussion about the optimized checksum function [1] has shown us that memcpy() sometimes prevents Clang from optimizing (loop unrolling and vectorizing) and potentially causes strict aliasing bugs with GCC, so I will work on a new patch version that keeps using the above types, instead of introducing memcpy() inside rte_memcpy().
> >
> > [1]: https://inbox.dpdk.org/dev/CAFn2buBzBLFLVN-K=u3MgBEbQ-hqbgJLVpDx3vSXVKJpa0yPNg@mail.gmail.com/
> >  
> 
> Great timing for this thread :)
> 
> My observation:
> - clang is unable to apply optimizations with RTE_PTR_[ADD,SUB]
> like loop unrolling and vectorization (e.g. cksum)
> - Even when clang/gcc do apply optimizations the assembly can be non-optimal
> - direct usage of unaligned_NN_t types can cause incorrect results
> (due to gcc bugs)
> 
> I don't think "rte_NN_alias" structs are safe on architectures that don't allow
> unaligned access bcz the inner "val" needs to indicate it maybe for
> unaligned access.
> 
> My suggestion:
> 1. Fix unaligned_NN_t types to ensure compiler doesn't aggressively
> apply strict-alias
> optimizations resulting in incorrect results
> (https://patches.dpdk.org/project/dpdk/patch/20260112120411.27314-2-scott.k.mitch1@gmail.com/).
> Intermediate structs rte_NN_alias are then unnecessary and we can directly use
> unaligned_NN_t instead (e.g.
> https://patches.dpdk.org/project/dpdk/patch/20260112120411.27314-3-scott.k.mitch1@gmail.com/)
> 
> 2. Improve RTE_PTR_[ADD,SUB] to be more compiler friendly
> (https://patches.dpdk.org/project/dpdk/patch/20260112154059.36879-1-scott.k.mitch1@gmail.com/)

FYI the Linux kernel avoids the memcpy silliness.
Mostly by identifying architectures where unaligned access is non-issue.
On x86, unaligned access works fine. As I remember it works on ARM as well.
The only place where unaligned can break badly is when this is an atomic operation.
