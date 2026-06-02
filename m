Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B63CD6E57
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 20:34:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90F68402AB;
	Tue,  2 Jun 2026 22:34:52 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id DF0E1402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 22:34:51 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-30749947917so1469760eec.1
 for <dev@dpdk.org>; Tue, 02 Jun 2026 13:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780432491;
 x=1781037291; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+WMNCV4rHHA9/ivHCcM+WqplUI7eNXHGvX4+KYgIDjo=;
 b=pvEZTREDSx7x43g4yk2JZS4cInCeytjZcpzJXuEM1j1pQNK6Okoab/S2h+LptYgq9t
 h5kfIvKnyo+bzEvJoenyGZ47foYBNd18acfZymuW0C7akYoSgN4E8A90BpFccMH3r72I
 PlMKBHlV933/ubPVTLRouX4xVIp29o6jJtfQlbyn3gSMtVn8sYrHWJmACpXXHllYz/+Y
 3KQZyPB62j/bHnqQg6bifXw7k77Bud4bqlO6HWquto4HbEC/2QHjT0nf7hIVSzzVlqXQ
 /LMZPSmA+YXeNd9yRpKKKxCSRCW4nqV4PKwV6jm+EWq2QmcginW57+u+dX+zM4+OhHWa
 Ehgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780432491; x=1781037291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+WMNCV4rHHA9/ivHCcM+WqplUI7eNXHGvX4+KYgIDjo=;
 b=OtISeqPUJFTi7QJLlqToO9ONmH4V/MByItB5buHBZgf/InTsiHWEDfCBvuVIkh0lpJ
 sn/aCWRPE5iT1ntx0ewQF9FuxSXBvm1/JkHxhVyTKljBxduoMA1tp8BLXx+x9dTDujzG
 l8AsiKRBIK0LuRCkJfZ0E9mReXRStaeRWk3zrfy9KIzm9/lJK+psO5mSmfUrh1YCOA6W
 +umyhdl81E9ipcS0i0nY+3mSlO4Q9WWwgLm8Jd+56Nuk1Mk3nhWOO+uyc0JocaxrlACy
 YY/nTn1VbTY5MsVSPBD2gw8ZXa1rK6cVXL7P8Lfrojbt2l/hxEcs1vLCrmKpOToKVwDd
 44fQ==
X-Gm-Message-State: AOJu0YzCxTSvj5kJMy76KFbSlekui4sW5DXWv4eH3b4y6/AoyzJBuAuw
 trEwoYX+16pMYX2eCpMtYDmg5el2stgiZV5bwhnOiGj/GaZPtZ8vUFDX7g/H44yBRSnXEBmL/Mo
 269+U
X-Gm-Gg: Acq92OFvmGpRgiQ22Z2hdWbg4PpKip332u02gXnF6Urt2pJB6L7+3eiU6sS6R8XgIBx
 92IB01l4LOkUv15xMeQFaInp585kRx62Q/ul3kmVEU6wuo070ybCnV4HANTuzF34VcYI30SC1Fe
 CdxNJxvT6xfu9Wq37a7BuNYMGfbk5TajnzYgywZUxKW7RFaMqf4JVJLs5VLwuwZxuPYKyJfeleD
 B5kMTmVHbDDM1FA+2uzhUCrWH4WECsskPTkj8etjJ/jWW/E9c8kBvsMbgIf27ywQRVLWctB5jAV
 EkcozG+YjxD4Ttfnemhsbb9jXOK7aHbEKbjUJfRGAxVv7H6vvU14uWEiVG6RJupnEJOWHklCDmO
 e2xAEysuQ73zbG8O+bnv/AzZBcOoQYcXH+Rdnmzto18MplNt7jI+BRVmBB7pnSG5faNx6Nf0cR9
 O09dCR0PABCVmFPgSqJyRlt86Jic5YwhWpoF3F2BvbQrqPq/rmDO1wK7aI5jhV/whHzypMXc6hB
 PU=
X-Received: by 2002:a05:7300:ed13:b0:304:e58b:cccb with SMTP id
 5a478bee46e88-3074fa57234mr162262eec.2.1780432490672; 
 Tue, 02 Jun 2026 13:34:50 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dea8e8csm400529eec.16.2026.06.02.13.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 13:34:50 -0700 (PDT)
Date: Tue, 2 Jun 2026 13:34:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v6 15/20] common/sxe2: add shared SFP module definitions
Message-ID: <20260602133448.79cb8ac8@phoenix.local>
In-Reply-To: <20260602155240.1002602-16-liujie5@linkdatatechnology.com>
References: <20260602055414.630859-21-liujie5@linkdatatechnology.com>
 <20260602155240.1002602-1-liujie5@linkdatatechnology.com>
 <20260602155240.1002602-16-liujie5@linkdatatechnology.com>
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

On Tue,  2 Jun 2026 23:52:34 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This patch adds a new shared header file 'sxe2_msg.h' which
> contains definitions for SFP/SFP+ modules. This file is shared across
> Firmware, Kernel driver, and DPDK PMD to ensure consistent protocol
> handling.
> 
> The header includes:
> - SFP EEPROM memory map offsets.
> - Module type encoding definitions.
> 
> By using this shared header, the PMD can correctly identify module
> capabilities and report diagnostic information in a way that is
> consistent with the underlying firmware logic.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>

You never answered the question of why this is in common directory?
It is only used by this driver sxe2.
Common directory is intended for drivers that share code across
multiple devices like net and crypto.
