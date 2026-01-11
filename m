Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA34D2502D
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Jan 2026 16:01:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFB2F40649;
	Sun, 11 Jan 2026 17:01:23 +0100 (CET)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41]) by mails.dpdk.org (Postfix) with ESMTP id 9C4BD4064E
 for <dev@dpdk.org>; Sun, 11 Jan 2026 17:01:21 +0100 (CET)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-650854c473fso5528843a12.1
 for <dev@dpdk.org>; Sun, 11 Jan 2026 08:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768147281;
 x=1768752081; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fKT0ejohBo05ttMmDaBEyrUOZbPBXhrBnIfCRWo+8ik=;
 b=VX/ex4sYWkgTEmVHt+BAxYHpsX7vw+ep4p2VaqMQ0ELApFrjQ+8+k1TP3tLLm5BMFL
 ZejSsg7k/4tm+OdoqBNh3aDHMit9Lld0Oj6Clibdb3twl8ihkFrrz/jYEOALwnWEs9MN
 lBzgnlMut0r9+GPLCzOwJww7GGFRwuoUgLSaMq9q4XsCPXTNfn95jtS6DCzVwVuSST2a
 CyjYEYzLTKtpECG0vHD7diykmxba4TfBuGFou9mL9LuBy3frQkU4AN/rW5FJdTDasyGW
 JKPD1mmWJHsKnGYCOCTWprhdOyIbcoQrXaUTOq/inEiUTt/EUSFRLByxPp1qlJML6sXT
 iORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768147281; x=1768752081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fKT0ejohBo05ttMmDaBEyrUOZbPBXhrBnIfCRWo+8ik=;
 b=WSLGcLK3v/CSQ0v0/EEZPhbe8LiEgbUl/TMWYlW2WPPuuxxY2NAMubASJMlMe/paNF
 hRhf7K8PZPu22ogxCLW/KPSUl872hImgsg/l2kR7If3YYV+UeSqYSDc6NH2huzg2TI5s
 6Blda8rYxVZPWUZT+CCt79taNr1JSTtizpTvHKCnw6mq97nxecyhsT+yacTbZwDdkDrV
 pL434u1vuyP1y1D725O9Yxr4EK6/tMuSShVFQrmWGLfk2kwiunonMutBx4bOdjwz+Utf
 kHFTQTlEQPvQeXtIM3VdDbDozkyoUTVWrRb2y6fYC2WNDJwhQWr2UE3xBpvD5pUWWwq/
 EHdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWnyEx0TUwubmTg6WzhSlQiHh4Hjwex3i64k//qryLl2f9EL4ok7hUKufwgnHkgpbsGA0=@dpdk.org
X-Gm-Message-State: AOJu0Yxs52k7b+M+8dSXUl7DZELjDoDFQfQ/JTst4S8S9cGtsoiPBuDv
 A3xiqsl8E18IVIW0HfgxTgP9/zV59dY2piwsvsrCQcnYD3qBOB2HIbd0guOvg9S6pEs=
X-Gm-Gg: AY/fxX4Mdl8fVsauO2JJx7F5NBCPCVooCY4sKRDQRma7j/30uh2DO/e55D+hJHKq7L5
 UFLLq9CNuhNiaoLHpip5TW3JT6DAab9QC2OSkVTo6OOY5QhgLu89BqqEu7sOR//2M6eipfUEScm
 ahs/oy03HF72qQ2PdDxeRZJ5GI7JFOKCWBMWbjyapM9odZtTjtkuVoFPX0O+rIVxyZHfYr8lDeZ
 uWZ0axCgPVMVBsTS6UYQF5m4UM9P5JhuZhJuryQ/pq7L1VKJ4Vk/O7b+xBqudQnGBeD8TmSdj1G
 MkP1AQOYF+6dxgHlMbnsUVPFJXdi/6+fB46nF27uEaYbKdX3MceRYOA8D1d+hrBiBUfXmDGtnfy
 oaxQNPUeeLYO5+4Hw/yTfYkI33ITVFOCFTXFVKJFw9vqF1yrQKZIo1SA8rrI01EGGUyeAwjm2wH
 6mIlkqjShZFR4CDjpwoPkTEiVYgRkXcmWJ2V+mLKSdQh4Jz8p85Bv6
X-Google-Smtp-Source: AGHT+IHN1OGGo5imCzwyE+pXoNgx8GnnIFHgNgh8Hreh682Lj29RzdOOusp8agM+H426EKm3/pXx8A==
X-Received: by 2002:a05:6402:1467:b0:64b:a3ea:5086 with SMTP id
 4fb4d7f45d1cf-65097c1899fmr15759176a12.12.1768147281154; 
 Sun, 11 Jan 2026 08:01:21 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b8c4454sm15466410a12.3.2026.01.11.08.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 08:01:20 -0800 (PST)
Date: Sun, 11 Jan 2026 08:01:14 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Bruce Richardson
 <bruce.richardson@intel.com>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>, Vipin Varghese <vipin.varghese@amd.com>
Subject: Re: [PATCH v5] eal/x86: optimize memcpy of small sizes
Message-ID: <20260111080114.3df6d91d@phoenix.local>
In-Reply-To: <c2bf94e103f64dcaad115e1d3d39d654@huawei.com>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20251201155525.1538260-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6561B@smartserver.smartshare.dk>
 <c2bf94e103f64dcaad115e1d3d39d654@huawei.com>
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

On Sun, 11 Jan 2026 15:52:28 +0000
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> > > +	/* Faster way when size is known at build time. */
> > > +	if (__rte_constant(n)) {
> > > +		if (n == 2)
> > > +			return memcpy(dst, src, 2);
> > > +		if (n == 4)
> > > +			return memcpy(dst, src, 4);
> > > +		if (n == 6) /* 4 + 2 */
> > > +			return memcpy(dst, src, 6);
> > > +		if (n == 8)
> > > +			return memcpy(dst, src, 8);
> > > +		if (n == 10) /* 8 + 2 */
> > > +			return memcpy(dst, src, 10);
> > > +		if (n == 12) /* 8 + 4 */
> > > +			return memcpy(dst, src, 12);
> > > +		if (n == 16) {
> > > +			rte_mov16((uint8_t *)dst, (const uint8_t *)src);
> > > +			return dst;
> > > +		}  
> 
> If n is constant; wouldn't compiler unroll such memcpy itself?
> Specially for such small (<=16) values?
> I mean. can't we just:
> If (n < 16) memcpy(dst, src, n); else rte_mov16(dst, src); 

Yes, better to just let compiler do its own inline with all constant
sizes.
