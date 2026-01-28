Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70C5D3F098
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 16:57:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E04964026F;
	Wed, 28 Jan 2026 17:57:29 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id E074B4003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:57:28 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso444555e9.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 08:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769619448;
 x=1770224248; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7JfefGuBXBHv8Ahg71vG82uMUQMQ6ShEsauh/Zw4WZI=;
 b=qQ0EQjOFwkRAvKK7qdj7eXgdBjwyKmSsXnPWjYOsP5TvvJGHj3B/kB5dymuYbwTHg6
 //PKp4hOdRNr8yKNZLUhtE3AQBoFsAmmm2m2S0gBAMfOo+3EalwLXNYnBCYd3LBd8VJe
 jT9dOwC98H2PRF+J6XPwNpTwH/5f4Je9DoeBJ6xGP8HmEEj6LcDOwc/NkSHIHk4dRTFV
 xChHWZON5MGy1d3rH667DQ9/plwAIbqd0WekxcdkwOrq1jTT5XdAd0Qg/lVRk7IrG+Uk
 Ka0/Logt73b0veyijxzfRPSw39qg37cb/uBh9udD5A9glh6GGu4Mv+aaGmt0eCT4F0g4
 Holw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769619448; x=1770224248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7JfefGuBXBHv8Ahg71vG82uMUQMQ6ShEsauh/Zw4WZI=;
 b=taiPKemXSAt0qBBgEoXqQ1Y5hLyJCpPB/8eNYSl2ArQBpHR913t7JPsyJtmfUE/TLI
 xz2OE8QhiFRXT6Chkjf0MwUClTMizPz4waqbfVpkrnFaPGC8Z+uns7oiwApsC/cR5Y1n
 CFFkf6ki4gqkbKR2VG6XZjeIqavKPHGGU7UV+ps5Eb3/s+DXPhaRaGecRMIKbWoTdaxu
 EOhsF7s7ZMTbvdYEZJZyX+3FeyBsNsjAyw5f1Cs3Yxg+NCauDiqO4IxyxQdMt5LImEvH
 lL0d2X0BwSKhfDzGB80+ckQPaBMK12nldNsgyM8tDe3OcIRX2v8ndp3CPkD414JBdVK2
 U17w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLPjhEd3Rnu0ditA012J7a7iIkEqDHLokvyqm5iUw4BTPlq2rXrSkVP3TIGXqF5MuRPuM=@dpdk.org
X-Gm-Message-State: AOJu0YwNd74aN6xJ79UI7P1xVOWmAFtL3hFZD5dZxUqHyr9DJTclSyf/
 RRooB/NfGpC4MtpTgpplZedpEx/GQ4SDdbBPL33kas0UKogiX9he+1WDSxn4Ud1da2M=
X-Gm-Gg: AZuq6aIZHMx/oGRgHhTNThKn3iFGjIhPBjIbTFvbG7tKzJgtLavKgvCX3rt7Cf1rhor
 d8JpTGzKdjtWP9ihsPCjwpWDuCmWsr8DTGQUB/8+F4CUquOQ0/us2MaUEgd/37VcLarGC/EwOY/
 r8ws8C4/fKyrgwqHNUxwCEktwYAh43ohSjDyOIynSq6HQ9KDHTaaoscwWkX97rsJ02XGk3Ad05H
 uM5e/fqVkwhp7U8aicqwKhl4tRWW4yRFktXt6rFsmHa14Qx+5xR+KAPki1diB89RYz1UUaiQohK
 Bf8sC2GmJLRVro4yjXwoKgiJOf11Y+Q7O/fGbEtfScOfXU+811jaobGEA2SLpUeilUpVqonYmGX
 ozSMF+t2IHCqs8eEkKyvcCZh3rU287yDgNbiM5iZfK8BCy/lkg/p2eOjS2BK/nFPs36vnzPsHaT
 WdNY6W01A0TWVScT5CcXTLj76mOWcTxYzwSWBkYQ921WWlVtpp/ze8
X-Received: by 2002:a05:600c:c089:b0:47d:87ac:73ef with SMTP id
 5b1f17b1804b1-48083cd4ed5mr996795e9.13.1769619448202; 
 Wed, 28 Jan 2026 08:57:28 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c4f3edsm139119495e9.15.2026.01.28.08.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 08:57:27 -0800 (PST)
Date: Wed, 28 Jan 2026 08:57:22 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Scott Mitchell <scott.k.mitch1@gmail.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>, dev@dpdk.org
Subject: Re: [PATCH v1 2/3] net/af_packet: RX/TX rte_memcpy, bulk free,
 prefetch
Message-ID: <20260128085722.435e6eb2@phoenix.local>
In-Reply-To: <CAFn2buA=6ucB+UJ4=q=XU57S=FMd-94v6O0AhCjzCFO+bu0eug@mail.gmail.com>
References: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
 <20260127181355.98437-3-scott.k.mitch1@gmail.com>
 <20260127105440.267abdec@phoenix.local>
 <CAFn2buBzhD=+5fG44xVyVYvLdunSxK7hTUAqi8+acPqoLf508w@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F656BF@smartserver.smartshare.dk>
 <CAFn2buA=6ucB+UJ4=q=XU57S=FMd-94v6O0AhCjzCFO+bu0eug@mail.gmail.com>
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

On Wed, 28 Jan 2026 07:37:13 -0800
Scott Mitchell <scott.k.mitch1@gmail.com> wrote:

> Thanks for the context! That makes sense. I dropped rte_memcpy and can
> re-evaluate once all my upcoming changes are merged.

The other thing worth noting is that compilers and tools like fortify
know what memcpy is and do bounds checking. But even with all the annotation
to x86 rte_memcpy() it still doesn't engage all the checks.

Plus there is the case (found in examples/fips_validation) where rte_memcpy
would read past end of array on stack.

Many platforms have rte_memcpy is just alias for memcpy.
The only ones with special code are x86 and ARM64.

