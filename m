Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0B8CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 17:11:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1B5B402AF;
	Fri, 24 Oct 2025 19:11:18 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 456564027F
 for <dev@dpdk.org>; Fri, 24 Oct 2025 19:11:17 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-780fc3b181aso1535186b3a.2
 for <dev@dpdk.org>; Fri, 24 Oct 2025 10:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761325876;
 x=1761930676; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SWMWdGlXcrcDmXTFyj2Sasgc17CH2KlvhEMuMz7n3F8=;
 b=U0iIicBI9eaoIYEW1pg2S17iQwXgNTMb9i+O89GIIdNFKRhQIksDYoD0yrqgoIEgra
 HlWTZpT3LIifsqGS+8HS/LWNDf6NFDLeLbeDr6Dk8oBdLR9Cwc6uSUtTMOvDiJvML9cA
 nHjHkpvjtd3rk5Aw2ZSr39S17kJnmf3VkWpceetTsJPFHpxgPF1dbqfc8AQBk1CLHx0V
 53cybJev3dNReztnl+XK+SfzmAEliNDLhT2omXPfZBnP9PB51dcYsWocCw75qwnY5mxg
 +BEBahX3oGuouik8Yb/hLqedtuCHIGrRmNX5M24IuKKFPL/rKwgrJVyvbP33btslMk7O
 dBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761325876; x=1761930676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SWMWdGlXcrcDmXTFyj2Sasgc17CH2KlvhEMuMz7n3F8=;
 b=CSvgODN4tCi8andQkFEUKAutXlmDsBXHXI4xnGG2K+9R1/tFgwuy6m7H4H0dzIwoWD
 ZSCPEIQsrbQkEsgSW1VILi5Z976ZIuRQIJXKbMuJET67bYhw0+G2QNVOEMEHYCCALXqL
 5H8J9MbMbstz7COgiyPOr7az7hPyd9HJkv02Vj0qtuuHxKwY4HFwr95CwkIiZuc99aXd
 k6x+WxhQoO27vN+XPsNWkfZABFuF8GdvReqRu8fr3I9VHlQCQcy+VgyIhEWQAHaY968Q
 zo436sRXZV+wojQSqwKQ845LDwzhesaGXKiQ3zuwWPExdl6MZ1CWIfqn6TzaJF7g25i5
 cQrQ==
X-Gm-Message-State: AOJu0YyZWb13pKJL1Dm5SFTsByUWve0aMIEH3+caP1S1QMwWHDNk1lhh
 Nrcw1FT1OAQ3cvzg9psqlFceiRgjfY3w5AhYQtlf78S0DhAoRvXr4228DKkT1AT+vfmA6SC/H6e
 UjXLz
X-Gm-Gg: ASbGnctQDRGAS0p7BnHstaVlTow/b9YtkEqRP3k1a0dno50AfAhq/Yo0DUWUsRpQJ99
 3KN+TGp5izhNlJiMMRJPJA5K4wjjinzn0FeA2MVL/dDVlcdwyCQHRkbUEySrdkyZK5DcKvnB2sC
 LLR/ufbKrU/8oq3CV7bVQjRt33l3AOEqxvcmAmYZ54LZNl8zk0QRN1RKPSB7Mz+gYTcgWAymzEw
 w1xfbbHb50g19Vcd824oIOZw8Sw0QuNUBxYfWkvp2xvceiMBGl/Ytkq6b6U2scdGPkBme20qZIP
 VSXuvxkf9Mh1qLhy5yu4xMZpHonmh9l7y3eWDd6F5FFB+aHsLX7heRI2B22UKnSOAgHB8eHfi4u
 UYXX8Vu47YiZ2P3GHk4zoxtHpfXld9ZL1zTteaRUtHwz+3kV2aH8hLvcClIAfBCi+uhbM3VPw0I
 WKvNawwSI5szqnmf9BhPsE5970CywmgV7qQkfo7v6IJbtj
X-Google-Smtp-Source: AGHT+IGQuOUFZ761+b2PTz8ZjJHPRpwRKlDJFrToD5EK0fJjByl6cArCaX1Qo9gAwsTiFitjupqmtw==
X-Received: by 2002:a05:6a00:1404:b0:7a2:710d:43e7 with SMTP id
 d2e1a72fcca58-7a274e59681mr8028591b3a.24.1761325876375; 
 Fri, 24 Oct 2025 10:11:16 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a27d583970sm4669776b3a.51.2025.10.24.10.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 10:11:16 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:59:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v12 13/13] net/sxe: add virtual function
Message-ID: <20251024095918.42bf57f7@phoenix>
In-Reply-To: <20250728090517.1811244-13-liujie5@linkdatatechnology.com>
References: <20250725104855.73326-13-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-1-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-13-liujie5@linkdatatechnology.com>
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

On Mon, 28 Jul 2025 17:05:17 +0800
liujie5@linkdatatechnology.com wrote:

> @ -2231,7 +2232,7 @@ static s32 sxe_hw_fnav_vm_pool_mask_get(struct sxe_hw *hw,
>  	switch (vm_pool & SXE_SAMPLE_VM_POOL_MASK) {
>  	case 0x0:
>  		*fnavm |= SXE_FNAVM_POOL;
> -		fallthrough;
> +		/* fallthrough */
>  	case 0x7F:
>  		break;
>  	default:
> @

This is a new driver. Fix this in earlier patch, don't patch a patch.
