Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E924FD8FF2
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 18:19:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64AF440647;
	Thu, 26 Feb 2026 19:19:46 +0100 (CET)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id 5B18B4042F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 19:19:44 +0100 (CET)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-1271195d2a7so1777720c88.0
 for <dev@dpdk.org>; Thu, 26 Feb 2026 10:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772129983;
 x=1772734783; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLDNLtAXBd8bypc8HJbrBKLKaXSkmd503rE50HTZyaI=;
 b=Bf1G6OY5kyXYLI6De4XMn3+paWC1XjLb2I8Ph8QE2Z+jky/TFLTFEmJW09CB9JeOJz
 KZ3pJITx0tzG9MQVo8PuayR5G/ERIhWsXRMMLnsYvIIukAqm3HGzbR3PNfNQC2SSD7/0
 +SGBgTDJ2aciO1nioMApBlW1BiT4FS+REFj5M4Mlo//MRlmP71x4h+5G56YKpn7U+DXU
 cY8IOdz2a8Co5CSH5l43n5WNYXYr6jmZA+aFXwraRvOTK8Vjxt0Jez9mCXF6vjh8/va0
 CnRUtS2eerLkiFmyd2k57hAc918w/mOEJuUZ8ESu9aaMdGlsc4y3yBp1AAs6TPK4bQxb
 mBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772129983; x=1772734783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zLDNLtAXBd8bypc8HJbrBKLKaXSkmd503rE50HTZyaI=;
 b=JJ1PMIX5DKvlrz3sfS+2dq7LmJfenkFf7/ZT4tNj4X8aIcWHjgS2MN5+BvhxbEYRmX
 dKE60Rp32rrWi0dHVmZzz1IWhBEwufU1sg9L8lwUILpS01OQJ0MnrZs96Vr8tTMbpW7v
 d/kc6v3b40hT0CxZMNOtK84C0B+lVr0+PzPyNfI9MTFxww/Th6cOpacvhs/+SH9/W7V0
 1shRBFy7lX40kb1JRhVDX9imrsgYZZtTi78QHw0REy9Si0CQEg893ee6Fu9n7PTKE+u9
 pcKDTeQR4zduxLw7tm+czYN+ohsOitkwKcg6VlPDnQKrJd7IWlcJM9GfvzwSHaUOP0l7
 6vag==
X-Gm-Message-State: AOJu0Yy4OcwMNNxgsS2r9aFZrXxxi8DwVCIghcnZ/XUNlWfMObI7jVRX
 64FyGGEA2hT9RukaG0QeZ3nTe77yJI/Q+aA3G4CphGl8f0TqVelw3wq2YYe3vRBxgQs=
X-Gm-Gg: ATEYQzzVeGYjC2YIhunag0ajyoLjP9Lpg93M2W/JiFr9qf+YMum1mhAvYDyseXPyhDR
 GAHGs/bVzPD8xeknfTYlZnkOHngwzNvSuJE54NhyueEF1m51DSEkHSDX2qmuC6XCTYZLAl7GUXr
 vXRHZn/3SDhxRLMMvqC13tUS4vahYNXvMk5/xAwuiubQMkVimy/tFxRFfwr4Uprtrv97l1a+p/K
 SZBy5/VdLzt23IKEUL9SLlskS5ZhqhiDBRK6brnGWI42uztQhK1eyORJV0gxyuWqZ5kFFp8KmBw
 tvlQZJ3wRDTsvO5bmTPGGXBeN6qSOhnxn3XD/AQuy1xaiHzSA3QZ+jQXt2/vohJvJ36Zq69UsoZ
 22bNlHN59DMuD8nRWYsA3DA2WrmlxqRQRryxrkWN7PUQKKAb84EKMEK/bGwpjd2v5znanij6ASV
 btX2pRdSDWpa7vrf9kHYAO83QnMLEZRhTPtY0gtL4Aetdf1+ucYvJ16iMMLrOwjiFeUw5pRo3zp
 ds=
X-Received: by 2002:a05:7022:511:b0:119:e569:f26c with SMTP id
 a92af1059eb24-12786990d32mr2713912c88.21.1772129983166; 
 Thu, 26 Feb 2026 10:19:43 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-127899df36asm2738236c88.4.2026.02.26.10.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 10:19:42 -0800 (PST)
Date: Thu, 26 Feb 2026 10:19:35 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v12 2/3] cmdline: add floating point support
Message-ID: <20260226101935.490f172c@phoenix.local>
In-Reply-To: <162c8c5bbecaafc97e698196e57b7835d794a83c.1772124281.git.anatoly.burakov@intel.com>
References: <253bd83015321590b266eee7c5f774b7c8956831.1772124281.git.anatoly.burakov@intel.com>
 <162c8c5bbecaafc97e698196e57b7835d794a83c.1772124281.git.anatoly.burakov@intel.com>
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

On Thu, 26 Feb 2026 16:44:49 +0000
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> +	if (type == RTE_FLOAT_SINGLE)
> +		dres = (double)strtof(srcbuf, &end);
> +	else if (type == RTE_FLOAT_DOUBLE)
> +		dres = strtod(srcbuf, &end);
> +	else
> +		return -1;
> +

You could use strtod for both.
The conversion from double to float could happen in caller.
