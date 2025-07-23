Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7F9C83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 14:24:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DE0940E15;
	Wed, 23 Jul 2025 16:24:50 +0200 (CEST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id AF5F040B9B
 for <dev@dpdk.org>; Wed, 23 Jul 2025 16:24:48 +0200 (CEST)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-7e29d5f7672so597866685a.3
 for <dev@dpdk.org>; Wed, 23 Jul 2025 07:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753280688;
 x=1753885488; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5UjRRk2TDttO76Anxt1TDITp88f0VAV/uw2yAbcNS9M=;
 b=NSJ0tsO+ruZMYblRGKJ1IGnSUrGkc2qi7r5P3pPi+koq516Ki5WZrQyxqBlRarPECg
 Ms0DM03knlLlperNnJR80XeF5Lm6aOk0KdESWoL3Ty7s94ToQb+dle1n9oWaMRQHWlUx
 SQ/dMLi2W8wYj+P9cuKAfJl1Wv9s9cpVYP+1pMaWWwcvDMrkv0KaYodNc3ivw1qAvbCk
 qL3cUN5K92j9d9za9mfs+av28w/NSpHhJyEDFTSdKdSrJD+oBAE2lMGlms7kKnR5xWVj
 9O5fxaEy8cWJcQDsaF0GdOEBhJZ6kRhb0W4+0qm5Y8onm2GaYkJhj9u7g+gRLeGt0Bn5
 NrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753280688; x=1753885488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5UjRRk2TDttO76Anxt1TDITp88f0VAV/uw2yAbcNS9M=;
 b=njin1wGE9eFCSaFJ9flgfviHwgfNP/rd/nVzm1ed8ZpoCjrTJrIGcEc/Cg9G4gsWBm
 UGvgUIrYw1mGefDdCH8RQgFXAj8l/3TP30egIGWLtrDv0rvhq7PhpUkw5SFcujvZzkh+
 NL+kxAk9f6QBo+ztMMu30OlrQZKw8YtQVncV6DDkBM1h0e3VZB6Wmk9wjVvzG66uK9Wo
 H+vrOF8+DME1QJ7jNcXY3I/8TBK0p2NcLfKwzGOcaMwSKXOYx9qu7bXF5K5CVL8LqUNK
 IEKHdhjAEHriDJQyZxKH/UyRE5xm/ZOrZXckwv4j90gS8rg0fINDFkYh7gpXNHXcXuDM
 O0sA==
X-Gm-Message-State: AOJu0YwKJt0T9Ty8Bo2BxYSO1axlrmFIZzvgRYgjSkFDdEcv33YIuhss
 se5aTq1LuLK91y95dRaLXEhYbllHkGYQeyjEUud2XCVRZc/N29ZO8gDRftEqjotUOS4=
X-Gm-Gg: ASbGncvIt2/BLpAoSMdlvUPg8JW85colpWtMFYymHa3+23vvnKJ8zLZBuyragE5kwLq
 GCuBjb9OEiDrUGkIUco68/HMg2jFVLfAbvyY2CcsvU/sPczP52UeDpWvXumupihua9vn393WQGU
 25cjIOv6zNT9x0LyYsPgBjhNQAUZ6m+fKJwwYbeaxkQsINWWISP7hpG/F4uHK3bluEqjbsN2Deg
 c+UUCtydSuFV2XTrR1UtTCZrjLmfk5iLuPyOARzesUXqSMe7p4lSAKeYgwCw/+HK76r3CInFnnG
 w4tfDspvFt4M+tvp2aEj3DUSeyZv02t7LDJXSYqGp2wfiZGTGKps3tU60kzVSJtVFrHn//GI0bS
 nFtadVfB6R+FFf9ggEdloEJhXAhTwM33jVyU9MkceKR2bisgdgUfJcYC0pAm43yItyN70S60Anf
 pexsSX1xgdcw==
X-Google-Smtp-Source: AGHT+IG+gDWq03RDs89/v2Os7HqBoz3yCejgmFs4DHqc5zcr1EkvXQ9H+Vg2mIYPtnEq5hD59M3iEg==
X-Received: by 2002:a05:620a:1790:b0:7e6:2f6a:5bae with SMTP id
 af79cd13be357-7e62f6a5d16mr113758685a.62.1753280685498; 
 Wed, 23 Jul 2025 07:24:45 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356c3eb74sm652657485a.62.2025.07.23.07.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 07:24:45 -0700 (PDT)
Date: Wed, 23 Jul 2025 07:24:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ashok Kaladi <ashok.k.kaladi@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] net/tap: fix BPF build failure in cross-compilation
 environment
Message-ID: <20250723072442.62ba35ff@hermes.local>
In-Reply-To: <20250723125702.3787183-1-ashok.k.kaladi@intel.com>
References: <20250723125702.3787183-1-ashok.k.kaladi@intel.com>
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

On Wed, 23 Jul 2025 07:57:02 -0500
Ashok Kaladi <ashok.k.kaladi@intel.com> wrote:

> During cross-compilation, BPF build incorrectly includes header files
> from the host system instead of the target sysroot. This leads to
> build failures due to incompatible headers or unavailability of header
> files in the host.
> 
> Fix by using the Meson sysroot property to correctly locate and include
> BPF-related headers from the cross-compilation environment.
> 
> Fixes: d8d065045c4a ("net/tap: rewrite RSS BPF program")
> Cc: stephen@networkplumber.org
> 
> Signed-off-by: Ashok Kaladi <ashok.k.kaladi@intel.com>
> ---
>  drivers/net/tap/bpf/meson.build | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/tap/bpf/meson.build b/drivers/net/tap/bpf/meson.build
> index 35d7438c74..1b87d5018e 100644
> --- a/drivers/net/tap/bpf/meson.build
> +++ b/drivers/net/tap/bpf/meson.build
> @@ -39,13 +39,14 @@ endif
>  
>  enable_tap_rss = true
>  
> -libbpf_include_dir = libbpf.get_variable(pkgconfig : 'includedir')
> +# Determine sysroot if cross-compiling and the property exists in the
> +# init files. Note that this environment variable will have to be passed
> +# in as a property during meson setup.
> +sysroot = meson.get_external_property('sysroot', '')
> +libbpf_include_dir = sysroot + libbpf.get_variable(pkgconfig : 'includedir')
>  
> -# The include files <linux/bpf.h> and others include <asm/types.h>
> -# but <asm/types.h> is not defined for multi-lib environment target.
> -# Workaround by using include directoriy from the host build environment.
>  machine_name = run_command('uname', '-m', check: true).stdout().strip()
> -march_include_dir = '/usr/include/' + machine_name + '-linux-gnu'
> +march_include_dir = sysroot + '/usr/include/' + machine_name + '-linux-gnu'

Keep the comment about why uname -m is used.
