Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F31EC87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 Aug 2025 21:56:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23F89402EF;
	Fri,  1 Aug 2025 23:56:17 +0200 (CEST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com
 [209.85.219.177])
 by mails.dpdk.org (Postfix) with ESMTP id D06CE4028F
 for <dev@dpdk.org>; Fri,  1 Aug 2025 23:56:15 +0200 (CEST)
Received: by mail-yb1-f177.google.com with SMTP id
 3f1490d57ef6-e8da1fd7b6bso1969708276.2
 for <dev@dpdk.org>; Fri, 01 Aug 2025 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754085375;
 x=1754690175; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qiJ4vpuEkPcvZQGChGjf5PDC4Ecq9Pc4bVExSguDmss=;
 b=Ao6YTlKbaNswtBNF4BdaR8XfD6LjpG+n53TRbTsTMvfENmdKjteF01XKcfsKwK8G++
 hQGHWh4wv++i4r0GINMSBvEf5g8dzgiGia/a+7p56yUcf0s9aHdAGJl5RtAYr2SQ8PCr
 /WDUpPClFb7DVb0apaBSkAU/3z0IT7Fu9kVhOkwzdSp875gUsTfMWCsG3qLgKIhiUN8B
 vSunemYPqAeN5liHx1NTiKtECAvPpjXH7MLrqPWMWlmlU7y/EUJ0YV56JupPcvitJU5F
 5szREo0Oba8qLDpPjeVmu8HGy1Q7xWikWhxlWBgq0uFc7VOsQZie4TBOVuZBpELR8ion
 +p2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754085375; x=1754690175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qiJ4vpuEkPcvZQGChGjf5PDC4Ecq9Pc4bVExSguDmss=;
 b=DJHLWkM3crlt4Gntzy2ms18yj4/4RobPmnTYX6jrGMSSOmfy0+vUgzLZV7HbCSSIOF
 Z3mSbgOs232S/q0ROezYZp5jrl3QdxmL9UdZSKzoSqdQsdneS4TEP+pikkwffARPaXpt
 ZnXTbLlWhPcytb1e23eA29LMgcaXsLHapowiVwMyuSmH7GLuAuovzINok7EampPQzijU
 5JU/eLWRgsPEpJZkQuh3bpRrs5EkLS4NCgpekm+Y7xti6USGoUXrdRE7azG2v+6PfeXN
 39oZEdDUqViscX8NG+5jug27Y0BKxd482nLhyih2UKW3TXjcRD1XOy4X8UcSPv55nifO
 a/TQ==
X-Gm-Message-State: AOJu0YysxC3ai5AU2vuPVGpccwxBIFJaTXuCwAGYR6z7gHBcHeiJ0CS5
 Wn1k5yNM8oRI6bDD33fBb3md9Xj9dzysb+CdItxUonaHz7135aBleGWnfgKh+OtWzm8=
X-Gm-Gg: ASbGncu1WczqUzS9ekaNnfvdADj7dncgMYqjimjjUo43134DHPLaUGAWUv3t00Nkfdd
 OlSXNY5R43tAeu93vYmIDqQbwtGg2+rEzETxPZe6xJUIwfS7y5DiASei5fNefU66XsEWrUlg6VV
 /+MTC8RYvsUWTls5vMWnO/VnHDw8HgKZH5mtW1bkkt3gl9xbnc08Xgn1aA/xVvN+FM4QS0MWyqH
 Mp6g0MJhYKbltmRqqHd6s7L4UWclGuJlAPEra7tdNEsk93ho31uKOMPxESXROaUlWu6eisWlmOO
 iTt4XeEvEjwF3Ksa9D165j9ZWj1Lh5dOdLLYbbNPS5FBWuF41VPB6t0e46iwCAPIjVZ+d323FPe
 l0j1W4+6RoPtP+h46F9i0uLM20U4wwoKX9qdagEdTWccO1NkbMdlKqMJ0QeZlsH4v1mfyYZCd3K
 RMQ7BdAfMQew==
X-Google-Smtp-Source: AGHT+IER7cjmuNhVM6hawNV1CQBJK6ni/Rvg5Qn/J6GpZhW+wvTdC8XNHjHAqniZusJ7bcIdD2q24A==
X-Received: by 2002:a05:6902:108f:b0:e8d:717f:a50c with SMTP id
 3f1490d57ef6-e8fee0e1db4mr1442316276.14.1754085374962; 
 Fri, 01 Aug 2025 14:56:14 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e8fd38aa805sm1808236276.39.2025.08.01.14.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 14:56:14 -0700 (PDT)
Date: Fri, 1 Aug 2025 14:56:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, andremue@linux.microsoft.com, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: Re: [PATCH v4 1/4] eal: add basename function for common path
 manipulation
Message-ID: <20250801145611.7a2ef22f@hermes.local>
In-Reply-To: <20250731160041.914837-2-bruce.richardson@intel.com>
References: <20250704140551.4151993-1-bruce.richardson@intel.com>
 <20250731160041.914837-1-bruce.richardson@intel.com>
 <20250731160041.914837-2-bruce.richardson@intel.com>
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

On Thu, 31 Jul 2025 16:00:38 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> There is no standard, cross-platform function to get the basename of a
> file path across all the supported DPDK platforms, Linux, BSD and
> Windows. Both Linux and BSD have a "basename" function in standard
> library, except:
> * Linux has two different basename functions, a POSIX version (which may
>   or may not modify args), and a GNU one which is guaranteed *not* to
>   modify the input arg and returns pointer to internal storage.
> * FreeBSD has just the one basename function, but, to be different, it is
>   guaranteed *always* to modify the argument and re-use it for output.
> * Windows just doesn't have a basename function, but provides _split_path
>   as a similar function, but with many differences over basename, e.g.
>   splitting off extension, returning empty basename if path ends in "/"
>   etc. etc.
> 
> Therefore, rather than just trying to implement basename for windows,
> which opens the question as to whether to emulate GNU and *never* modify
> arg, or emulate BSD and *always* modify arg, this patchset introduces
> "rte_basename" which should have defined behaviour on all platforms. The
> patch also introduces a set of test cases to confirm consistent behaviour
> on all platforms too.
> 
> The behaviour is as in doxygen docs. Essentially:
> - does not modify input path buffer
> - returns output in a separate output buffer
> - uses snprintf and strlcpy style return value to indicate truncation
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

What about existing uses of basename()

0 main.c                  main                       553 char *token = strtok(basename(rst_path),
                                                         ".");
1 process.h               get_current_prefix         220 snprintf(prefix, size, "%s",
                                                         basename(dirname(buf)));
2 mlx5_common_auxiliary.c mlx5_auxiliary_get_pci_str  85 base = basename(sysfs_pci);
3 idxd_bus.c              is_for_this_process_use    271 prefix = basename(runtime_dir);
4 bnxt_tf_pmd_shim.c      ulp_pmd_get_mac_by_pci     156 intf_name = basename(gres.gl_pathv[0]);
5 eal_common_proc.c       rte_mp_channel_init        628 strlcpy(mp_filter, basename(path),
                                                         sizeof(mp_filter));


