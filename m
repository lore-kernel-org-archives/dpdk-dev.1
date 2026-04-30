Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D76FF8873
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 17:25:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05B444066C;
	Thu, 30 Apr 2026 19:25:39 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 8EF754021F
 for <dev@dpdk.org>; Thu, 30 Apr 2026 19:25:37 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2de831d2b20so2281623eec.1
 for <dev@dpdk.org>; Thu, 30 Apr 2026 10:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777569936;
 x=1778174736; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wj2K7avE5mpgAwm1uDXrE5+BUeSU1SZEgoVmXaHmgUI=;
 b=b3s5ed1EdndKFSheoPxhG80xV0MOwPMX+YtBfiaFLaspdi41gE4YUtO3wR2OBuRefL
 TBOO6NnOsj4ij14CzJYKfgoIb+Hxk0Dkla3PegnTy/YDvT/8XQ/6prGOHpCNluaxOLV2
 NxGE54oVlKS+0PoTVFFbKZxhkk/0Xnv0WAziJ1oai0i5pnRUz2dKC8NqKFEhFJTcxdzv
 mQKwTPR+Y7apayqFWeqUfIH9W9AsCxTQMuCjiCGngZ9QNtSLCNf7Pgb7Br+L8R+U70Gr
 LuzxU506VjN/t22v6EMx3aVNPGqNlAcPggIiCM8agCh1BDikEI1wzw69ighS9d/IFrh5
 kqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569936; x=1778174736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wj2K7avE5mpgAwm1uDXrE5+BUeSU1SZEgoVmXaHmgUI=;
 b=byr8VlryW3DC80QxqEbxoJ6tpf5EOzY2uB+Tbh9sAUdCFN2zA5nwSjnLAtk0qJB9g+
 dnZNiewIdoXjOa2YRw6k72nMNFI9CpgWPbcZ7JeSg/8BpaE6blXRrvsIWNgutMXvMKpF
 GcJKrAq6rs7W45vvHdV6y4TaRN8AJxEkorC9ycdIgjpvAkKmv/qUN7WqYcCwh9lBL7p/
 4myX7zKMJO+gjI/50WhMbK+NkH7+cXAknD8K1hNuYU4XTqwP0dQ+WvZAWuxLst2BnCS0
 wU1jerMt3GC/Beba9bg8vWwfUbS2ChulSNsok8G8D3wvEYsls3hUfSKYb4qLCsCFCL87
 lXGQ==
X-Gm-Message-State: AOJu0YyVtrto770AnQiStj3YUVdupFh0KAqcMVxYXP328R/Jt1d4l2F3
 dNX2sWrXMJZN1C/LhDhEfaTh5SchA8dpninvDOMrP081NEkADYLiz4m2BJbwsBKkDoxJ5d43VMk
 XQT1t
X-Gm-Gg: AeBDiev7aA2XBoMDEUK5hpP5trqCj5Xafasb58tu7KESvwi2tUddAqdWALe1mnm0XUY
 xe634VK0Pyip6igc4xp7llehSIoXGmjfRvMCXq5/M2I7biI6AC85+Vv5LKSdcoX7WG4yePIZL5m
 SsSdyjfYYMePuXFI290E5GaAiygrFgQmhg4KAnFpa3pjytNVyBIS5xRXLt86IkCOir0WEFMllZH
 gGZnPglSsaiyTiMWlnwwUvla3xupk/xf62ar/jpescw3cnWnNn9LkC5/FBOszvESZhicRt7A+6V
 sBAMOjnLYFRnqRCIZ3zoyVp2gYN+UHK8jS8AZDSixbPdeh3nZ2rHbJH2Z+kk6veODcZ4lbtKSPg
 mT6MJuYbTgQDyoK7gH803BdAzogfnoegyThDRtrDv3qDaAWbWLpy4j8K89YF19kXb7IUBoVBg5o
 bTCuSDTUXeVaCCe0Qq4Y7x92P+2DUnfB/OH0vFWp0XWe9hPg==
X-Received: by 2002:a05:7300:e827:b0:2da:44ac:6d0d with SMTP id
 5a478bee46e88-2ed3dea4fb9mr2227586eec.20.1777569936397; 
 Thu, 30 Apr 2026 10:25:36 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3bf6812asm691560eec.28.2026.04.30.10.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:25:36 -0700 (PDT)
Date: Thu, 30 Apr 2026 10:25:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: stable@dpdk.org, Sunyang Wu <sunyang.wu@jaguarmicro.com>, Bruce
 Richardson <bruce.richardson@intel.com>, Aman Singh
 <aman.deep.singh@intel.com>, Olivier Matz <olivier.matz@6wind.com>
Subject: Re: [PATCH v2] app/test-pmd: terminate process on second signal
Message-ID: <20260430102534.446b2190@phoenix.local>
In-Reply-To: <20260428135323.119782-1-stephen@networkplumber.org>
References: <20260427172617.295684-1-stephen@networkplumber.org>
 <20260428135323.119782-1-stephen@networkplumber.org>
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

On Tue, 28 Apr 2026 06:52:48 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The SIGINT/SIGTERM handler starts a graceful shutdown via
> prompt_exit(), after which prompt() frees the cmdline object with
> cmdline_stdin_exit(). A second signal delivered during or after
> that free re-enters prompt_exit() and dereferences testpmd_cl,
> producing a use-after-free.
> 
> Reset both signals to SIG_DFL so the process will immediately
> exit if second signal arrives.
> 
> Fixes: f1d0993e034e ("app/testpmd: fix interactive mode on Windows")
> Cc: stable@dpdk.org
> Reported-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Applied to next-net
