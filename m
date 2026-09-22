Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B518CC982FE
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 15:32:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1DEA42DD0;
	Tue, 22 Sep 2026 17:32:53 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id D05B742E00
 for <dev@dpdk.org>; Tue, 22 Sep 2026 17:32:51 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-398c066106cso23332a91.1
 for <dev@dpdk.org>; Tue, 22 Sep 2026 08:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790091171;
 x=1790695971; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MdvZvXc39epn0ISnx79qX+GAOnZ5JAoXedVvlhYJCGs=;
 b=SoxuiSMQ3Qa9bSxtoFA15ZYE+FNxQC0/21byJqr363N1UQYkdifKoNVTNemjL2A/H1
 zrZjds6UbU/P4aur2Ufp0mPIb6KM6BpVPV+xwHxIxB1HOV+67IuiIozdnAsgKhGG2ujj
 0ADAYHPhA+cUqCAHlPwbXh8WrXHxsf80WZYr5ECYJawbz62gINIbDcAdBMqMwJBaeM4U
 pOTh+8dptN88ksrckQgH/sxzoAFEaRy0zeIIaVG3kuLQEKR5jtdQFqR8bg3xi6jUNhDx
 0TzT4H28RnQqJYuYxbxOUnW/eUcpKxVJ8deBVMvJPMDOnTxX02vp0jfrqBKwteG1fncj
 lJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790091171; x=1790695971;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MdvZvXc39epn0ISnx79qX+GAOnZ5JAoXedVvlhYJCGs=;
 b=SiPTgz/ty7LjEO/qqQmT05bvt/zBeEWCPNzSsrXRTSr6VhnggiIfoOjK/fHjTFSroT
 6wwYoj5X65xM80Sc8TpXBj5b65UDVAI8Hy3KOkDkcERri2OpyXM02EJkN3sIR6QXyFwm
 DxsxQavfyPn5Mu8axiWW6GsEs2AyugDWgyACI7yl6gsvQd4VSFLBqRu0b8+4tXLDIctp
 za69exc9gKvffxIRcq/wfk/OZk0TRoC2KlayAmYu3TVwJxMcsnmgS9ahOHXbXhTHmGfK
 tIMaSQOH4EoLc+mTGXr7pGUT2/xaLIwQGtU6vdORp8NlNjKn4HYaAKRu8JnwMkPj4FJH
 J0+g==
X-Gm-Message-State: AFuF++lKdcW26D5lV01n8dpGM3h6YB/aR4r/A3Ol6De4kNSEWlIZ3zxz
 PZgdm5h6aSs7J3zBiWZvcqYnem1Tw2yNOTFLZYzlqy6ReCnZruEfunWW39c6RjNhuXI=
X-Gm-Gg: AYBFou0cG2Uh0oVr29Ezzb7PVmRglaN8d92yGgWG/kv07bHPYOtWY+sdtD+r8T5739B
 KrVa75fNsvI+ko/Y+MhdPRmgUZF31JZSLGvPum1JVdw/4Kx0s5OBcontGxCm7yKSqBVJ8OysrLD
 rxArvNJNiYK+fc/ggtIMV0C9wGbEX99A8qwc+HCGiNh2fDrDIy4c6NwUQ95EKbW+EFnms8Ah5pN
 vVoTFU5WevQgDzLRRXJKsCcVVGZYbPbelNxbJjv2dYfPFTeCcTmNAeQeUMnxtNc9G7df4g6K4hj
 OvqjioR5O2NUrznjRewL1wL/tltuTnIFs0og1+yoXmBx3vtL4RTwglyEPwVmtq0+jcwrZd8lPxC
 3IPWXpe06YCVJDhrk6eK9wshLS9HpT2XLe7LEEqk1tU1kqBwUDiPJaDTyVPPrzqM5HpLzmXM7hn
 gCtRNoYbBR7uQiOuSKaw3xW1vb9X7hz/ltJ7NHJFKSvhi0D8EVGBNkyLF0H5JdUYNMzKzEUh0lr
 FKz1D0HhGRBLhDd1riZCMnQT5JxMlcW8cRS9Qz2
X-Received: by 2002:a17:90b:2810:b0:398:a145:5d3d with SMTP id
 98e67ed59e1d1-3a07306ffeemr1808439a91.6.1790091170741; 
 Tue, 22 Sep 2026 08:32:50 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a06cb2b46csm1609150a91.3.2026.09.22.08.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 08:32:50 -0700 (PDT)
Date: Tue, 22 Sep 2026 08:32:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v2] net/ring: remove internal devarg
Message-ID: <20260922083247.7c10c1c8@phoenix.local>
In-Reply-To: <20260922142411.2975581-1-bruce.richardson@intel.com>
References: <20260922113614.2952557-1-bruce.richardson@intel.com>
 <20260922142411.2975581-1-bruce.richardson@intel.com>
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

On Tue, 22 Sep 2026 15:24:11 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> The devarg "internal" was used to pass a pointer to the creation
> function to reuse set parameters. However, this meant it could also be
> used as a devarg on the commandline leading to incorrect behaviour.
> Redesign the passing of the args parameters to use a per-thread global
> instead. The wrapper function sets the global to a valid value before
> calling the main creation function, skipping passing a devarg, before
> resetting the pointer back to NULL when the function returns.
> 
> Bugzilla ID: 1687
> Fixes: 96cb19521147 ("net/ring: use EAL APIs in PMD specific API")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Looks good, applied to next-net.

Did manual validation that internal arg was gone.
