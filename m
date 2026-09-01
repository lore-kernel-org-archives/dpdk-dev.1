Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62409C61DD3
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 14:25:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D6DA40615;
	Tue,  1 Sep 2026 16:25:31 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id E3F4F402D3
 for <dev@dpdk.org>; Tue,  1 Sep 2026 16:25:29 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-84830c774a0so1121546b3a.1
 for <dev@dpdk.org>; Tue, 01 Sep 2026 07:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788272729;
 x=1788877529; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fLd+kZWtIuUqp6SR4DdOSkpF5bAak2+OkFGwjIrlENY=;
 b=fIEC+8CfHDUc7OkuRVYBCktCr2TgcjxZVkNOBuB+mP+grs8l8Fr6VOuwElOCf3TMVG
 SgdM7QNsR+qn97VtfxVqMxm8MZaJ1I7clahDdDiOavCTUXNhMyGNldS9YzhvZ346sF8g
 TAroxgo3ZbYxqfskW3lULvurdefK6oPqlQwt5k9sPQ4f+3Elw8BvQWprAcmr4iDKhRnO
 hbjom5l7CzojlKtw4scbWG20x0hrKk43lHGMWg72cNv9Lm2pQqzbrdTdLPhePwD51MES
 Y+/RysVJCEsYFjqJ/TnRwP/fjfZOedQzzYjeHT2z+QCvuHuR2JMxGzfvpLyKCzY691Sq
 3UDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788272729; x=1788877529;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fLd+kZWtIuUqp6SR4DdOSkpF5bAak2+OkFGwjIrlENY=;
 b=r7OX7N8TWgoOW36y1n3ouf9cm9EqZu/ArTglC+gs2i5v53/ktPYbd7kMbqlZGlQwtg
 RRYJXYKGEKyNzdw2AZqhFc2pvY1IftDRf9sCtvWFCcL7oj9jm3wJbg6DEfvRmtRnKgmT
 ldmmS3yOJxCKy2JXpMpWx1V5Gu+XsB6RqGeGZMq0LDYZf7xd83VrmqEnhwr9TIlTLfPO
 tWrf/7jk3Uo0vIJ03B6E+G3yOVaF6OW5kqqG3S53uPwTDx4KAsbZQk3V2jl9Rahdh1or
 LlN6Lj99qsFeNKk1opFtxzsusvHR0ZVnJxPTrZAh54f0lIQX0jBPUgMaucYS42iL2yKt
 EA/A==
X-Gm-Message-State: AFuF++nmtujtmTbVmeIUfSZBLzdQsdMCmHlKBd5igC2hS4/NbVHm0y1j
 DrdYeNYiT6bjaKmt5TNQJvy2FIm8yGgErInJPUxGEU5pelv4C0oh8jmMFMrsZdnxZdU=
X-Gm-Gg: AR+sD13ZMCFoKeqEpXA1N7vvgp0uPmqvJLYe/HbnOWvTbvz/d4edXG7xw7v0FgB1yiL
 jessAkRBjWJKrk0hJ/0miOArT3LtJS73YoSwAAzs5egW/B9DrRe2NVFBpBt7fxANpSs8dD+LY3o
 z8AIIrDtbNbUaHxGYaMq8qGUiKf6hvRGKWyQb0pImmcHJEKYPpAAaEUvjztX1aPrmUJ72UO9Pbk
 DoN0N4c7dxXvTGr1L+tzZlCZZSbhLX4s0ix7e3fYIO7Sr7xrtVKTmonWq33KboQf+Cv/Hd2kuyO
 lgl9DW3H7Tze+Z/lz8xZfkJ/CHy7TnNg10D/m25KtDtYT6EEo8B/moWvVBcMEoGMQjGfQru/lo8
 brZKwfNn2+BOnq5m4apnfRpOWL0r2dsZSqonjrfspDSRZsfqcxvXwPXCNu+iKeCeWVTc3oSabQ+
 DXG/HcB9QZyy2iypEwls25gPclk51st0tvNVzDZ0UtWzS+ekB4085xZI0YGP/WE5RJfzreW5qa2
 pYOk74yY9xnM9CGXFX2eBZwG/X8jg==
X-Received: by 2002:a05:6a00:e0e:b0:84c:1cd2:142b with SMTP id
 d2e1a72fcca58-85629a252femr52019869b3a.9.1788272728650; 
 Tue, 01 Sep 2026 07:25:28 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85be8e5e2efsm1229104b3a.28.2026.09.01.07.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:25:28 -0700 (PDT)
Date: Tue, 1 Sep 2026 07:23:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Pratik Senapati <psenapati@marvell.com>
Cc: <dev@dpdk.org>, <gakhil@marvell.com>, <gmuthukrishn@marvell.com>,
 <kai.ji@intel.com>
Subject: Re: [PATCH v1 1/4] app/test: extend mlkem support
Message-ID: <20260901072306.54a130fa@phoenix.local>
In-Reply-To: <20260831085009.256634-1-psenapati@marvell.com>
References: <20260831085009.256634-1-psenapati@marvell.com>
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

On Mon, 31 Aug 2026 14:20:06 +0530
Pratik Senapati <psenapati@marvell.com> wrote:

>  
> +uint8_t mlkem_768_dk[] = {
> +	0x29, 0x18, 0xA0, 0x56, 0x30, 0x51, 0x93, 0xF1,
> +	0x80, 0xB9, 0xCB, 0xAE, 0xD3, 0x97, 0x02, 0x73,
> +	0xAB, 0x7D, 0x7C, 0xEB, 0x44, 0x03, 0x60, 0x06,
> +	0xF0, 0xD5, 0x2D, 0x21, 0x46, 0xBC, 0x98, 0x91,
> +	0x89, 0x59, 0x45, 0xCF, 0x99, 0xC3, 0x49, 0xE6,
> +	0x71, 0x80, 0x2A, 0x6B, 0x49, 0xCA, 0x8A, 0xC

Test vectors should be const, and ideally static so local to file.
