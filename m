Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050E9CE8D4D
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 16:08:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47402410E4;
	Fri, 14 Nov 2025 17:08:10 +0100 (CET)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id BDD6E410DD
 for <dev@dpdk.org>; Fri, 14 Nov 2025 17:08:08 +0100 (CET)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-7bb710d1d1dso575951b3a.1
 for <dev@dpdk.org>; Fri, 14 Nov 2025 08:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763136488;
 x=1763741288; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y/qTLL1Grmo48RzrByycuvYarHH2/gYc1laxaFgLwJU=;
 b=YY2R4dwYTYuyu+diN1lB9mIpBseM5Is20RYOkIMpVjNh6R3Kga1VsgzDhbzSsV5dux
 SDcC09Z0ia69uPc+xhg8JtVkPMlrwV1cdtsCespnt0hYRzSuB1spiY2MeLM2Lg/aMzz3
 7uTKUQSyCgeBVDqAnGT3gQlmmlVr7/t7bJFFq4jsSeLzE8cNyJToUqzX8CtTkGwNDmsi
 yD2WkIj1ZoTedzzbxNB/PSZ/kPlMDXsihTqXGoepoW1ISfPJ62xdmj0np2livBU1gy02
 uJilF17eN6YW/qDkJBZlUM3jhYHKAj1wR8MJXYk5aLZvcyCGSuWYqPRlD+1KwIXvy4Dz
 eU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763136488; x=1763741288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y/qTLL1Grmo48RzrByycuvYarHH2/gYc1laxaFgLwJU=;
 b=Wrr5cXyBv7I5eePKe6BubhFm/qkfsORaj72N5pZ9KC91vh+LEqOnKoONooOOmQWr77
 QSZfTyPYWWEPI2wDGCacZaJQUKY/97KBlWt4WQ5xMenYHSiqFjsIwJWKoRAFWdDMb4iY
 Jtz8GXJlv4saB/Hxk3hgZhUrYJwvZK2rrLrnQFWHGDZdovp41Jcnl5OXapk0fS3hOQZ3
 dFSJlnmyWHdUKnjwUxvO8tlWCpy3tS1HL6MPtMw3a2FHN0rJeyALRhY6EcLX+n4POM6F
 xXLnaKQmNPht+MUDLBdRN0EBbIi2vxUlkQlum5xHc6aXFg6qjfmXTnio/x+0ipg4Pl5X
 ATAw==
X-Gm-Message-State: AOJu0YxnGg6KShxFtHqVSRJ3kL9pRh0Tr+lI1YEFrUkyjkn8TeHrwIvG
 Sl2uO978Ds8UkZxESMk+qM+0c6xrPJFFm5COLCkUmvnpfcG9v+XymaF15JqeHalC2qs=
X-Gm-Gg: ASbGncvSw64mMeJ6kPnTw19f/OGhvnklffU/cIfnu0SK7MRq1o65SsRaOfhlpvzbNAC
 6BUchZzcjW3rUlj/n9C0/dQ3Lt3ZnIWRvEN8mzoQUIoU8R88cNeMAftTjxmiLOgM4KaJIPbIiY3
 LI1U4D6yYCbhmhrsfVz2S9ermF5Nm8WlYrGiOC3Q3BLkWhO/+eyq8HDK4pAAhS34nIqLCPJNO8J
 uE9PNQ+0X+7HV8g/LgJ+eMroRlynbdL47/48qnhSFvltr4yn2DodmuNsNjh2IvX51XXaJIZEnNR
 Ql7WhmiiAIra8bq09Q/eclOgaL1pupkZCW4isHtLBRrbpKWSQrH+P2FnQWgTixRUq2bLLuFaiya
 ET39nGjNBZAez49ctstWx1fRB5m6o5fS2R5RUrQLz3r11hWl4SdKOXQlioLsSN+QALueAlESaLm
 F0bmI07vj89vo1/lJQJxx6OHiUYm0f0zpzdLPgEXXQLOmS
X-Google-Smtp-Source: AGHT+IFxWD2ka7ozkgpe7aNXMmEjjjWBgaB4cdlQ1xoOObRU5oM8c/NoPHQOFhG01qg24/CS9/KoDQ==
X-Received: by 2002:a05:7022:69aa:b0:11b:3742:1257 with SMTP id
 a92af1059eb24-11b4120ca2amr1949590c88.34.1763136487280; 
 Fri, 14 Nov 2025 08:08:07 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b060885eesm11258932c88.1.2025.11.14.08.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 08:08:07 -0800 (PST)
Date: Fri, 14 Nov 2025 08:08:04 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Christophe Fontaine <cfontain@redhat.com>, stable@dpdk.org
Subject: Re: [PATCH dpdk] net: ipv6 link local compliance with rfc 4291
Message-ID: <20251114080804.7636e240@phoenix>
In-Reply-To: <20251114105751.54802-3-rjarry@redhat.com>
References: <20251114105751.54802-3-rjarry@redhat.com>
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

On Fri, 14 Nov 2025 11:57:53 +0100
Robin Jarry <rjarry@redhat.com> wrote:

> @@ -406,7 +406,7 @@ rte_ipv6_llocal_from_ethernet(struct rte_ipv6_addr *ip, const struct rte_ether_a
>  	ip->a[0] = 0xfe;
>  	ip->a[1] = 0x80;
>  	memset(&ip->a[2], 0, 6);
> -	ip->a[8] = mac->addr_bytes[0];
> +	ip->a[8] = mac->addr_bytes[0] ^ 0x02;

Could use RTE_ETHER_LOCAL_ADMIN_ADDR instead of magic constant 2,
but seems a little wordy to do that.
