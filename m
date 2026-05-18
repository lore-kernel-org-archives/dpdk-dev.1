Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1941CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 17:10:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE0F6402D9;
	Mon, 18 May 2026 19:10:27 +0200 (CEST)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id 5158040041
 for <dev@dpdk.org>; Mon, 18 May 2026 19:10:26 +0200 (CEST)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-1329fc4bf77so6545904c88.1
 for <dev@dpdk.org>; Mon, 18 May 2026 10:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779124225;
 x=1779729025; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=03ZzvszZ/1+tJxCacuglyEPnYA5pY2+33HYPPWWadx8=;
 b=gWfeGghVImzcRpxp72DuCGi4ZfBozulkBmIrSeBR8OQRH/VleaAMRWV9RsBLmoFboS
 XexZw40kondStk8+XzfEJTgZ3VsDB6a9ydHmYETh+qLcyUgzjkT6nEd6wsyRyvALccwS
 5Sa+Oh1FPYZIuLiUzT0ytqyJWNSaXjjWAUqM30i4+XSKDC83BqmLWkoMC04mOv5wmx+p
 0GIcVgvPC8ymECZqMn1sQNG7Pp63dVeUlRWSt5A9WsXFna50glxnMQek4PMfwcO/+RMb
 j8aCIwe8qkywgoC8XTSvbObZcKXrpi/LUBOpVCHkqRN+uW+FWN3/R8ggISEMTg32jANG
 XIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779124225; x=1779729025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=03ZzvszZ/1+tJxCacuglyEPnYA5pY2+33HYPPWWadx8=;
 b=dqKwGY89xs931RnfRMqvGy3mIUqKFSsKC0kBDIv+se0fGTT037eeXH18IqE64gXrRp
 ZsB0Sp8xU9y2s4QCBHAt6x+OPLkc31wQLiwkV3VI7Bq+qmqqKcO6FrFE+4LX24MA1fde
 NllINHKQx2EsVrkTAcvDGu8InwU9KopeuKCyGCOJo/6GG55RyGamoRwvlk+fWaQNMBtW
 T5JH/uzqihMaxgUY6mpz1jhZau01dozBGszxorOActa2r0fWQAUJ4sRMkiwYPGrL6677
 AXX13noMxKs2F7Pg3r+k7j/sgquGlW3pgCTpXAcv/uYWOBouRaah9UQhowQP6QusMrcv
 vVvQ==
X-Gm-Message-State: AOJu0Yx6XD8TQXpSqgzIVFtawrZUB8r0CBX1EQysmYWX3js9OtOEdL7X
 EG+Azsx8n5YzekQzE//WM5x6XOjmj7gVDDk8nrPV6kqSud7aL2DRkmpwHpNs7fXDWJU=
X-Gm-Gg: Acq92OEMuTiXvrucRSQg8g+zeiZKpA0dVg+Stdq5vzelyCooyzLw/x+yVLlYGIH73VF
 8KitVbZj1mZQ0wWd+lBwCTuQIG1CaJsDJqpP9xVhVymqSBHXBEqHPLwybkyKmrgkvvoPwmgtbiT
 sq4usKi6fcZFx+gQip20Ej8PXuCZrsqUM7OjGHJMt9n/k4oa60S1n/dsqpyOQ3i+qcaAsb4BPgk
 s/UDzesf3Z60z6detuAYyuSh368X2jHxlCPrkY5fUUJeGu6VgwrIAwGzwITwK2yEGphXIZW5X8V
 oziOwqcnRf7sQXH5Fp3kYrsAIWkcK1jILlAto7Dl7O/ibMo2KWNdmHSxFWidCd3BV7m5CA1Vk9o
 P5R4foPD6Kgq17cBdgenO/NimP+jQbUTmm9UPCCtOWMYe23VJ4cllpbZN3ldnC+2MbWljmOBtWl
 1Ba5t6lgRddinLeGGLHsOjq2DziDy2H6PeKRk=
X-Received: by 2002:a05:7022:40d:b0:12d:de3e:cc02 with SMTP id
 a92af1059eb24-13504a53ff1mr7011264c88.41.1779124225009; 
 Mon, 18 May 2026 10:10:25 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbcb9ef5sm19996881c88.2.2026.05.18.10.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 10:10:24 -0700 (PDT)
Date: Mon, 18 May 2026 10:10:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, Jack Bond-Preston
 <jack.bond-preston@foss.arm.com>, Gavin Hu <gahu@nvidia.com>, "Honnappa
 Nagarahalli" <honnappa.nagarahalli@arm.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>
Subject: Re: [PATCH] eal: silence -Wconstant-logical-operand in
 RTE_IS_POWER_OF_2
Message-ID: <20260518101022.7d665d83@phoenix.local>
In-Reply-To: <agtEqEv2fB7R7_Aa@bricha3-mobl1.ger.corp.intel.com>
References: <20260518163401.580696-1-stephen@networkplumber.org>
 <agtEqEv2fB7R7_Aa@bricha3-mobl1.ger.corp.intel.com>
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

On Mon, 18 May 2026 17:56:08 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> I'd also suggest changing the second part of the && to match, changing the
> "!" for explicit "== 0":
> 
> #define RTE_IS_POWER_OF_2(n) ((n) != 0 && (((n) - 1) & (n)) == 0)

Was heading for the smallest possible part
