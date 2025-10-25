Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC91CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Sat, 25 Oct 2025 16:38:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD8EB4021E;
	Sat, 25 Oct 2025 18:38:51 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id 6C76940156
 for <dev@dpdk.org>; Sat, 25 Oct 2025 18:38:50 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-781997d195aso2281273b3a.3
 for <dev@dpdk.org>; Sat, 25 Oct 2025 09:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761410329;
 x=1762015129; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZpoDcAC8jMDCQkPnaJ6hIbpInJcOY5byczwvZ2sKOh4=;
 b=hGYFloFaCAEoBOLElilKyA1Fl3mwBHdb7HcAcoPoLHXsD0beVLVxnto/BxJvvmeJw4
 6HzyR/mTQgaEIxZknuXixFpvABStqlllMq3bhWiIG/GY9NajIew24PNi26fGDBHlsgUa
 UJvPDPn21SR9froKoTM5j2VMz6BfAGISjVWGQRINa6andXbjCOrQ0Bv6bW6+0XIuDLBm
 l7ZGlvv7uxtGvoYdQdUqlBGF0xJ+g2lVbJeBBEkG4cQx5+AH0qgHtYRrSj0HzTeoTmKi
 jMPstF9mhi9tN1OPQX+htzfFHLHSd530ri7CdaS4xoEgwvgdEkbhSeQlRCvEzoKE8ioH
 8ylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761410329; x=1762015129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZpoDcAC8jMDCQkPnaJ6hIbpInJcOY5byczwvZ2sKOh4=;
 b=hMSyFHQ2n5RVeze50tWGh05zD29XPfwPghgm31rBqQd39ifJM5B9ukUkl3/k7UhtEG
 eOR5MdwzHHDmCQ3Fm0LitcuBJymMx6ryB5WSL+IPErBQJQZTr6i6DkbnFI/cskIgJw/e
 ijTlLpKeBhF9wZJiHFvDESb8Ol1Djk6wsy+eftrbOCyFdH/zRbbzr5s4vrk43dXPIm+N
 qan4I2a9W9JPYMoefGWjMzR1vtMyEb8U9yk9KKwoCQDn2hm7t6ynhrQS7dHxukOnDYMY
 lyoX8RrK15Ylp3xsAIIfGUM8GJnbgCFY6YJreuCNUkrgeeXf88eUqDSIkDlfdc3u/fIP
 Rj6A==
X-Gm-Message-State: AOJu0YzNQkRvtv98qW+V2tpmWPdYSx5faDyadYJW7Np/KLRK67Cp3sDd
 wQyOfD5u2DdRaSGnbGxXYTyuIU8dxMvlWU5TYRIFERuK5NqT5DMSMQYdIzXR5zvdrrVcQL02ID5
 aaF2T
X-Gm-Gg: ASbGncsrYHJkOHcWVs+rzZC4DyPPD1Z1M78+HCnVAb9bovaWv4K2/f3UwWoXLe87beD
 eIcs7SxCFRE+tHdn2SMvoh8duxrtLz2HMAMtOwAfjwTsqdTJSdhPzMjHIkk4k6njWNagEiS1Lzd
 nJwsaGCczy6QvDIs7kruLnR1LuJ4gTesjdvdfPvqNqDHuVg0uUlGSNAd+76DALO/B84WR+C3Fyf
 1tVfAJ8oTHWpoX0Znh5k3gW1pX/A23iSAOKPjFB8h0KjGTRCm3iyC/OjvpLldXHgVI0j7sNcJr5
 HI1TcftCMV76aRm/tkAJ7HdRw827VYQE5+ELvYJP14yoxFMAm+WNnjUmIekDYxmf6ntAyTOXYCQ
 SZWLb0H2egMmAvYYb7QWXwU3oqZkPfSCY0vvQn2RJoQr6kpp+qNlJY/QjNrS+3oKyfEPwDPSQTU
 +HysbED2lYvd1JwLvlQ9TmosKQMGs2kGqcK0UdNEsr2FXo
X-Google-Smtp-Source: AGHT+IHd29umBISLT7orIMYu+DSwZme2RPg20qNlmlBxNH+D3ORHT7EcyOXgeXwciBIW1waTWWCBnw==
X-Received: by 2002:a05:6a20:a10b:b0:32b:70aa:a1d9 with SMTP id
 adf61e73a8af0-33dead52beemr8567331637.33.1761410329350; 
 Sat, 25 Oct 2025 09:38:49 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b71268bda1asm2450449a12.3.2025.10.25.09.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Oct 2025 09:38:49 -0700 (PDT)
Date: Sat, 25 Oct 2025 09:36:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v12 02/13] net/sxe: add ethdev probe and remove
Message-ID: <20251025093620.181ca783@phoenix>
In-Reply-To: <20250728090517.1811244-2-liujie5@linkdatatechnology.com>
References: <20250725104855.73326-13-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-1-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-2-liujie5@linkdatatechnology.com>
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

On Mon, 28 Jul 2025 17:05:06 +0800
liujie5@linkdatatechnology.com wrote:

> +	if (value != after) {
> +		LOG_MSG_ERR(drv, "failed status register test got: "
> +				"0x%08X expected: 0x%08X",
> +					after, value);

It is preferred to not break message strings across lines.
When line is split is harder to use tools to search for messages when they
show up in the log.
