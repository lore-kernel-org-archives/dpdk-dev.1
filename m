Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B69DC87FCA
	for <dpdk-dev@archiver.kernel.org>; Sun,  3 Aug 2025 16:08:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BB414026C;
	Sun,  3 Aug 2025 18:08:46 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 8F308400D5
 for <dev@dpdk.org>; Sun,  3 Aug 2025 18:08:43 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3b8de6f7556so436057f8f.1
 for <dev@dpdk.org>; Sun, 03 Aug 2025 09:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754237323;
 x=1754842123; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HtX+4kGMslHpF74LqiEbwGdjjmDSaspJpfnbdhn0hxU=;
 b=qX0o/Ih2TsV5TxknW8UzV1spV9rdT7s9opOzoWGIhvihwZb2W9ViTGDg5gtdTEaOnl
 gE92FRo8A/so82jW2f8/7c0RxFDf0IWBfFqLlWrJxERYhZUkj+PJggnkF/tff6EUVGbT
 OBd/agH4WkWzDWvaR7pcVQOSnwmDMWklflpujx/RZx54UY7sF3pwsML+bxmV7Qm7m6/r
 6ztfQXCRcObd/e8/6S3Uox2n5UVxX5Hv/izi3jU8KJYRR+cyXjB4/bm6jgDarygQiAmG
 tMQOmEhQ5b8r3od69Lg3KJsaX0mXCX9yxz4WMmkV/xzNfT7LNoJLYoj/VUa9pZMooEiq
 voGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754237323; x=1754842123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HtX+4kGMslHpF74LqiEbwGdjjmDSaspJpfnbdhn0hxU=;
 b=SVa+CQaemT9PWcYhJseL6l46qEGEJCXArnnHIKUODFnamQP++Tzrl2XCTOB+6wIjIU
 IuWCMh0KMo/NTiztxhnMY7IU6HGVtU8Jo1y3TTd8ae/P/nnGgO/zpdmnNkjVKOByPVfJ
 qsUtsWTl/zzbYvC27BXda2SCDCKsb5u8XowOMa6e8oJOIvOyGnr33LGUln0ugDpEiCin
 AbdGwSYdavAQBe47wwiu9R4/TDpqP+CTjsQddpREVv7v77SKOGKdMy/BUK2CWaFcNgmS
 IJUzYP+hyqHYFVBj8fAs6y0X3p35RQp+hEb2d5RWg7ed2r37WvZNvZT3lrC9MCLVcZ+a
 r4Hw==
X-Gm-Message-State: AOJu0YzieQflrY9bbNXobL5Mg0IjlHN08HXdIyxvK4QxIUmxNVrf7oqR
 loUgmhzo1Zz6XOcc/tT7oP9Ec2pKXAztL0nspeksp53/xaRLS5LNcvJtAulqUiwUkgA=
X-Gm-Gg: ASbGncsMZUUifOZUpMrOc39bSGGHf7YlFTXukTWN17teZYgoVdnw0j9VAKBLwotVk5S
 oibXvfdTdjcWRxiQdsG6nURF7StD6kLVE5JCzcAAJm9si54nV/3pOLk/Z4ChUaPTIIz7n12CmuW
 3P3RC46PN/D6MJVYZfj4gaTOQ7MEHJsfpvM8Zoil77ay7GHFbBfK5w/DByXV/aaKEWRlSRPOfgY
 ogABs0a7oRcJSFEQl9CweOo5tksp+/lpanDrTc6J0w+zhll+BzbMUlJGTn2gdxh+2L3jFqkwKzO
 OcpjyvTFKp4tUac+Solr9i9l3uI7jYhxByFn+2wWF5A2uqH83zsyA+JLa1QQ41y1Bw67deXBFCq
 +ic1ncboSPvxt79oEbFQ18zpe3Uw+Ekmd3bDpWtmIT7UPrCi1/EMkFQG4ZTupfIgx1namvuV+et
 U=
X-Google-Smtp-Source: AGHT+IGTzVLep8FHFs6s7Svt8n3u13egJ74nyaWvsFkcnA2Ue9Vil8wk44trDzJYonaq4r+RTJN3Zw==
X-Received: by 2002:a5d:5d10:0:b0:3a4:fbaf:749e with SMTP id
 ffacd0b85a97d-3b8d94c2141mr4577247f8f.49.1754237322748; 
 Sun, 03 Aug 2025 09:08:42 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3bf970sm12572553f8f.25.2025.08.03.09.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Aug 2025 09:08:42 -0700 (PDT)
Date: Sun, 3 Aug 2025 09:08:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Su Sai <susai.ss@bytedance.com>
Cc: dev@dpdk.org
Subject: Re: [v3] net/cksum: compute raw cksum for several segments
Message-ID: <20250803090837.15589edd@hermes.local>
In-Reply-To: <CABsP7wOxyD2zEnZ2Yc0BrSDg3aMAVxcNqrHR=mWygUZTShRfDA@mail.gmail.com>
References: <CABsP7wMLpN-mggd7dY42YEbq_YH5nz=BQSQHV43yZWhpbDNy=Q@mail.gmail.com>
 <CABsP7wOxyD2zEnZ2Yc0BrSDg3aMAVxcNqrHR=mWygUZTShRfDA@mail.gmail.com>
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

On Sat, 2 Aug 2025 04:08:16 -0700
Su Sai <susai.ss@bytedance.com> wrote:

> The rte_raw_cksum_mbuf function is used to compute
> the raw checksum of a packet.
> If the packet payload stored in multi mbuf, the function
> will goto the hard case. In hard case,
> the variable 'tmp' is a type of uint32_t,
> so rte_bswap16 will drop high 16 bit.
> Meanwhile, the variable 'sum' is a type of uint32_t,
> so 'sum += tmp' will drop the carry when overflow.
> Both drop will make cksum incorrect.
> This commit fixes the above bug.
> 
> Signed-off-by: Su Sai <susai.ss@bytedance.com>
> ---

The patch is getting corrupted by your mail system and
does not apply cleanly. Fix and resubmit.

One option is to use an attachment
