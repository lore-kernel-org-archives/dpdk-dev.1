Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D34CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 22:07:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0371F402C4;
	Tue,  2 Jun 2026 00:07:19 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id 904EF40150
 for <dev@dpdk.org>; Tue,  2 Jun 2026 00:07:18 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-137335bc3caso9048019c88.0
 for <dev@dpdk.org>; Mon, 01 Jun 2026 15:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780351637;
 x=1780956437; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D6hchXuokuKABoK6BZxphdK5qL35yrLOeGro88XauYA=;
 b=lzXaURseZi8jXw6DBBJGet33VfZcSkOnV12UW6JHTLIJrQcAfKij/QK3ZYhQc1/Ocs
 hGupwiZhb0buYEdHiCn3+yXiOhO1GptSqndoNwcMDt/9hGIKE1/hIvrmQdKvthsnZRXZ
 omSXgzJAqT0itcHHPq5KoAWJzZ1YdCOtQsyFb4GXF0Jszrs2yBuOV7n4O55vPNVQ7jr5
 YKVmVEpWjL3njG9HoTCwqiKr8YDLQ6JRldEUMFMyvYDbuzQytGI4sgC6oK6d76Mjec8K
 IFTpcXg8+GnU7R9LQiWsx/dZiVrBOSzwfQlOupLI62d3y1UjEaJIoRrRKUSbgjEcZ8uK
 pAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780351637; x=1780956437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D6hchXuokuKABoK6BZxphdK5qL35yrLOeGro88XauYA=;
 b=sDNOx7WLSNCDljjGCme2GiB+1s/Sxo5IL7Dne+k9In+E642CcIHHl4x88gsqwQGhm4
 1+Zi8tIt8DJ5nGqYHHwBt/vuuDOQrogpK4SK/fA2aEvOBGL0dWr0Blwm/6BgmukvH79l
 AfIISKIdYJzmftDMFfHhdpD6GLa84vlFcvtfTvIr0iG+mDksVRVnVbMmcyDCrMJA4GHE
 Qj4D2F/jQpkuZ39LoUOt/UhopVH9QwvrnQQ02YQU6+DZDNpp5SI8itBzEoddMsYUe/1t
 3juDd65WKcA9YgE6hZbAv7Iohva5ip50S9Ukr16gDEncVoVKDxf2SR/AD4c8Royc+u0q
 plrQ==
X-Gm-Message-State: AOJu0YxO761nMOsstdAn87ZY1GRo3uy/B2gxY7oE0X5uDtdc0dn0OVL0
 ZTShOd/Mc8FIJC560GOVTUuVuGLnWgdghoWaUgpw0Ym4g5vBg+U3hIri7+epq0DiVt5dwbIQrO+
 axWs9
X-Gm-Gg: Acq92OEgBHnQqTU0Jaqo8GI+vX4RkeQCqA0kBuVqjtC99fiwRs+JZlp0c/0ISiZAm6z
 u4GCX12fUJqDmp+ODtGoiCLBUeS8/yNxIyohel3aq11fliz+Fek87SfHfDLVbERUBQEdP0goG80
 jkO469dllgqxsSm/jNxjym8PC9zDdo12GAOdcBuAoygbCd3TP9zACFwOTwTlx0eziU/CvoDoj7y
 57CD4xYSQX8UjyzWccCRxIN8wxRLP3buHFWDOQByydMfzAKHaw1Tnil4w8BXKoV3ho2A7LwjUoE
 Q/MXQj5jugM+vX+P16ukmYmUUSyTMJbErwoINDCyOABvR1SAbBsI/etnMipK9SSPeIv+OkJTQir
 r8VTubeKcliDURmxV1DQV3VHaapTfThzIULGiK5OLLSD9iKEzbimsYsjfO8jMkKXrenesIjF0Ix
 pG0e1wT6X65qWmBW576rQPh+xr9+OKuZzS7j0tGjmXFrsue+MDv9Ls8w3jd0cuSaRQWgol9to7Z
 GasihFsCvYcfA==
X-Received: by 2002:a05:7022:eac8:b0:137:edc4:a5e6 with SMTP id
 a92af1059eb24-137edc4a7e0mr871244c88.29.1780351636926; 
 Mon, 01 Jun 2026 15:07:16 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137eda36ddbsm846494c88.12.2026.06.01.15.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 15:07:16 -0700 (PDT)
Date: Mon, 1 Jun 2026 15:07:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
Subject: Re: [PATCH v4 03/27] ring: unify memory model on C11, remove atomic32
Message-ID: <20260601150710.1f7ad9e9@phoenix.local>
In-Reply-To: <20260526232542.620966-4-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
 <20260526232542.620966-4-stephen@networkplumber.org>
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

On Tue, 26 May 2026 16:23:53 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Remove the RTE_USE_C11_MEM_MODEL build switch; C11 atomics are now
> the default for all platforms. Unifies __rte_ring_update_tail into
> the C11 form (atomic_store_release replaces the older rte_smp_wmb +
> plain store on the generic path) and renames rte_ring_generic_pvt.h
> to rte_ring_x86_pvt.h to reflect its new scope.
> 
> Also splits the head-move helper into separate ST and MT variants,
> removing the runtime is_st branch from the MT retry loop.
> This gets small boost and scopes the following exception
> more tightly.
> 
> Exception: on x86 with GCC, atomic_compare_exchange on the head CAS
> regresses MP/MC contended throughput by ~20% existing hand-written
> cmpxchg. As a workaround, GCC-on-x86 builds use the older
> __sync_bool_compare_and_swap builtin, which generates equivalent
> code to the original asm. Can be reverted if/when GCC gets
> fixed; similar issue was observed in Linux kernel.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

This is a big enough change, going to split it up as its own series.
