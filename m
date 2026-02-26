Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E4FFD8FF5
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 18:31:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 674C14028F;
	Thu, 26 Feb 2026 19:31:39 +0100 (CET)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 8FAFD4027F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 19:31:37 +0100 (CET)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2bdcb30fe8aso1769097eec.0
 for <dev@dpdk.org>; Thu, 26 Feb 2026 10:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772130696;
 x=1772735496; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5SmA26+n9JNq8b2Zcp1D+o3WKUQXqmu6JjF+nOt3CE8=;
 b=d60eKRPHmgL9j62NZhf9Puj4aydhPLwuwgbHlMtgNQgwNQaMaxP84mNAAWxJSPPWhO
 Su8ayVA8+p/+N6Td+LRuP56mmO8KG/PVUpYFOYeFLjrgxooSd+bNy4db35hiD9ZNUZwT
 QQ0B/hgxR4uRX5T1IZVjm7w8av4mFVQyuwvAUjMn3CbhZbPNDYMWvvHTJpAPc47BOB2A
 HgHGHMyFEBBOz20MibQBv53MMTD9bnU7tHWh/udka4TTa//znIXtGwa1UXSzia2oa1ET
 r2ME0+yWpzNrkocCUY1GffjPalIgJloh7wxd01psk54IjDyAcPeH569DqTw5kkja8v6w
 In+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772130696; x=1772735496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5SmA26+n9JNq8b2Zcp1D+o3WKUQXqmu6JjF+nOt3CE8=;
 b=rJIaBNEXl8EFKKbvbtPRG02bM1VnkCwVLDIRaPptgry+iou4D2T/IuVq1i4T5mwcpW
 mHYWpXMIBn1ny9oQq8oPipUu2M1efF4uO4d7KCXFRnIYYM2Yr5NfoaXooPrbCP40Iqcp
 UkZoCSwzlUcQdzXzBYM6wwWxc01egotYrr0vmJ5UuFLzovv2N0BKzI7hmuFPKIhZFaHd
 ubU4r19J+82BmPyJB8hFw+LTXWj8yAKsvcgS3ytQxAUsOoLU216DKr3g/bVy5oyTMUVf
 Oqh8JAVMpuvwCUOSwFiCeDxP126p5GyNF6l7AP0VgO/vprALM05dPDsaIvyFaBHHOdJI
 8+sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3LJsvC2C3p6skyT34qQ8g99ueNgvMbJzjv/wjrlj+g3RV3CE5PfdgN2NMMV6Lvh5HQ14=@dpdk.org
X-Gm-Message-State: AOJu0Yxn26kgbXjItOq5UGmZ90vGhwnvdWdZD5QNjFMlbcKQCAMGEfTp
 P8/agiT/3X7JawuNeJhP/lOBDc73zwKb4xujVxcGxZO16dz6jgj2jcYVyhmteLFAosY=
X-Gm-Gg: ATEYQzw2sxj712MXSFlIMZdPG19BVQLhDX6dF+eJvkChv29I/nvKQBJ1nrrMIxJIrFB
 SJ2QXciqULTziXElimmZn+3xvxtCTrXxT+3e4fvY0nKqeFPWvaMczENhLh9tppnsdzGcRKKngXn
 X0G/BUGBcLvYb/BCVIBYNZGMJjsWnjBzOWy9PX+mruz8rod05AJmgArU3j5BBSFU7BBcB1owKO3
 E35EcAUKnwLW6lfqmZYJ1Gg7F41ZmY0+5w7iWXVyKj+WU+lL48tCbYbf7amyQ6XFBsPEnW4BWiy
 pzchhRZq16DGzrUM7WhSyQV1BrXhu/mHdyDwBZLYdaMRvsqmAaZwYIRHJY8yYTgzNP4+I9zOw2N
 7s9Jhb3y8Tz0464jnZhxU/FhIguqRq5h7PjPaAp9gl0Zynqar0brBlagzG/W5TF7QtVzrEP4Qk+
 tO0TvcCsIlyw0aPQjo1bb8fS5OLM903rESl3iKco8foVdoEp3/0+paa405uxnEvmhH
X-Received: by 2002:a05:693c:360b:b0:2ba:a661:8512 with SMTP id
 5a478bee46e88-2bde1bbf5b2mr33781eec.17.1772130696366; 
 Thu, 26 Feb 2026 10:31:36 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789a43c12sm3042916c88.14.2026.02.26.10.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 10:31:36 -0800 (PST)
Date: Thu, 26 Feb 2026 10:31:33 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: P1erreCashon <2022302111412@whu.edu.cn>
Cc: Stanislaw Kardach <stanislaw.kardach@gmail.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Yipeng Wang <yipeng1.wang@intel.com>, Sameh
 Gobriel <sameh.gobriel@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, dev@dpdk.org, gong-flying
 <gongxiaofei24@iscas.ac.cn>
Subject: Re: [PATCH] hash: add riscv vector support for 16-byte key comparison
Message-ID: <20260226103133.63176d72@phoenix.local>
In-Reply-To: <20260226064939.2362323-1-2022302111412@whu.edu.cn>
References: <20260226064939.2362323-1-2022302111412@whu.edu.cn>
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

On Thu, 26 Feb 2026 14:49:38 +0800
P1erreCashon <2022302111412@whu.edu.cn> wrote:

> diff --git a/lib/hash/rte_cmp_riscv.h b/lib/hash/rte_cmp_riscv.h
> new file mode 100644
> index 0000000000..7881d17e05
> --- /dev/null
> +++ b/lib/hash/rte_cmp_riscv.h
> @@ -0,0 +1,93 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2015 Intel Corporation

This patch is not from Intel, and it is not 2015
but correct copyright on new code.
