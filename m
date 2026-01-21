Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D265C44536
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 14:57:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A33D427E1;
	Wed, 21 Jan 2026 15:57:28 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id D78C0400EF
 for <dev@dpdk.org>; Wed, 21 Jan 2026 15:57:27 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so48105335e9.3
 for <dev@dpdk.org>; Wed, 21 Jan 2026 06:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769007447;
 x=1769612247; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=InxBiMUJ1/kIeEPP/+8uXUuoE1hCAwrrRmqXBamGXrg=;
 b=jwfTEjciA1zE15isEjQwidvym9DBE64NkQ+50ENzWw3XemZtiCZosLbNwXWOoNhE7n
 m6dfDHOEm6v4EBEgiotO6QvQ68/YqAZ5v0R8jKzyTrTS17IhRMT147H3q28dfA9mgEV8
 B0DG+N6xfyr37iRY3PaJ4sXOdHvbd1xI+T65XKYJ12XrEkKrdZnq48wXA7MnJ2dWwBqv
 cR35arBf841UI+PEopapL+dfNIZIGNHdFj2C6dCZtvWc0sqAYtH+sWhOdMJBPCC6CY8r
 ti3Y4f54ZDLk1dEyrnW/P7xmsdWoqqfkdSw4KA+kOVt/y9JuFpshMVmVw+dRPBpNJ6mp
 VYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769007447; x=1769612247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=InxBiMUJ1/kIeEPP/+8uXUuoE1hCAwrrRmqXBamGXrg=;
 b=UgLijHdCkUelTxTGvRdT7mAqel9ELfPCWz1idDlsk/ygf7dZXnmQGZ0YwArIpGfU36
 BrlR2wRrYMojcPgUhw55b3pknvG+KGJg4/l83WbFVo8OJnOQsNkrPvUsbuvtrEU5KeV5
 ZlJTZcdQkTu9yORNs9HAeIUewo9sJziFQWUFG11Kqdz5iml0UaXcTh1ZrWNKhefZimJd
 Pg/QiYGnfh3i/E2iyex2TmB1DC8VyFxsASRQ+toNSGDv4zkWwn+dCJxtLDkPmjnYWkg0
 uEff1IHBWNHn2A+LKMG6bOBjOWNRhuWgTaI79Ljwr35MBj4Qo4euMYExUt/I4Q2gKGm2
 upxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW7XumZRP/WJEI/FB3g9g2dS8WcGk9K2l9FJU6Vx74umyLZVz64DNVupnLhVBIimjRpF8=@dpdk.org
X-Gm-Message-State: AOJu0YxRrmDTm6YbRGCWf8py9+85QiDC4LIkYkcy5HD7HedI6X8VKHDH
 iRCCHen0lqoWcmbGDeRkpVon1RPW9I8NdgfXZvFPuP5Q7MIjcFPeLJgEEDMbrjYDKxo=
X-Gm-Gg: AZuq6aJBD/R0kj4jsgdjpChHbqbvFbqv7lWA4vJB/jYwV3fNLBKqPKwb+IuBFv4fRaR
 2LiHKVtThLtDxS3ORmA27BPUC5yD15pwur47evhHAgcnrCTQ9uFk0j4ru6A7qU9rePs1B0c9/25
 fUCo1htiO8hKUYsY9tz7MHSUfBt0BshPpASSzupN/nw1dgLXYujyTWI//u1VtQE3F/tOrInVrXG
 81YlyluuPLoiCWsvDy6AWIr5w/zbQw1i1iHgbKg0xheQ7sZeyQL0NO/6W+mNpxZ87ihcpP+f/qP
 aPLaTYRKIQyQkZxLjn2ANKydfoIepXvV49PIPcRZ37TpFaUQUNbiT3tJqVCdfSC8EL1hRhagzAj
 IxlCYH2QqauhO7pTMUiuJ8h5oraTTt3FxBh/eeZ/DafNCSDlX1F86jW5zoF604N/FHLocZ4artQ
 dS0vMV4BBg/MeOlgBdfLBWB5/OyTQEBTkBl0Bh0e9YOslzGX3GpCq6
X-Received: by 2002:a05:600c:138c:b0:47e:e949:37e8 with SMTP id
 5b1f17b1804b1-48039d19076mr124067525e9.30.1769007446395; 
 Wed, 21 Jan 2026 06:57:26 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8c05c3sm308873495e9.11.2026.01.21.06.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 06:57:26 -0800 (PST)
Date: Wed, 21 Jan 2026 06:57:20 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Honnappa Nagarahalli
 <honnappa.nagarahalli@arm.com>
Subject: Re: [PATCH v3 1/6] test/soring: fix buffer overflow warnings with LTO
Message-ID: <20260121065720.0a497b2d@phoenix.local>
In-Reply-To: <bbda56963fa74b86be402911610daf75@huawei.com>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260116064646.224254-1-stephen@networkplumber.org>
 <20260116064646.224254-2-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F65669@smartserver.smartshare.dk>
 <20260119144821.70e2ff35@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F65674@smartserver.smartshare.dk>
 <20260120063413.72e0d725@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F6567F@smartserver.smartshare.dk>
 <d9a4cead8c8e473e907f604b98370013@huawei.com>
 <20260120112728.146e63b4@phoenix.local>
 <bbda56963fa74b86be402911610daf75@huawei.com>
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

On Wed, 21 Jan 2026 12:56:25 +0000
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> > A much simpler and clear solution is to just get rid of __rte_always_inline
> > and use inline instead. The compiler still inlines a lot but it can make its
> > own decision.
> > The attribute always_inline is not always faster, in fact in real world
> > applications it can make things slower because real applications get i-cache
> > misses and lots of inline expansion makes it worse.  
> 
> Sounds like a clean and safe fix.
> I also don't expect any perf degradations with such approach, 
> but will run some perf tests with it to confirm.
> Thanks

Only enqueue/dequeue functions needed the change.
