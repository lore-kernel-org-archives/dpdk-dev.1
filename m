Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB81CA1002
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Sep 2025 17:51:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86B9B40269;
	Sat,  6 Sep 2025 19:51:24 +0200 (CEST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 2D5DD40261
 for <dev@dpdk.org>; Sat,  6 Sep 2025 19:51:23 +0200 (CEST)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-3db9641b725so3183635f8f.2
 for <dev@dpdk.org>; Sat, 06 Sep 2025 10:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757181083;
 x=1757785883; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BnXyvlvySQ+dvgHD5/w5l/ffCQOYRLbCwO1v6t0jcjQ=;
 b=MW1hcelI9gU5LlR3m4ch8LIclvoVhWbq2Juj7bBSj71mwcXRmgd+Pgw9OBxRW6JKsI
 FLsSK4AyZhMKe9WOFoSv3+jteicrWaU4XNGkczhtxblYqqudLpptFOGbKP6GvcApLbvY
 6Brv216Nf9A0oa9USMrxqXcofXr7h97Ag0rWn71WnqbZRaVl44AIiNuOn0ZeyV5kvaKD
 +H0V7+EU7111544HP6hAa6umbo4AkBZs9qoYDBDRUP+YuPTEPbvoz8Ymeu01pSNtmJ07
 3oirxyz6/gu6M7Wex0I/evhOCLfOdXMc0YWLSM0zFYY1ZEgt/Hj4bhnqE1IxHSInvJv5
 yZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757181083; x=1757785883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BnXyvlvySQ+dvgHD5/w5l/ffCQOYRLbCwO1v6t0jcjQ=;
 b=RcjbF4vR0DrzqG8kzcNgClX+QTgOnoJSlrs731nbdlzO2sTpAQLzIuDTRifmDM8FGV
 37DQHgZw8JHpM/Dt1IASJ5WBUIHsFn0u3OSeNI7tJKG75NDjPDmhHR9/8JBETYJYdRK/
 CUOmkg0IAAJ8y5LIQC2Qvl0gjLvNb9PbA47E5Y4Kuwd4iFkuEn/tN9u1RSdkuFZkpOLK
 hi11JmJ2Mpeply87fRQE2cLuYh+TGnrO44NuTLEsX1K6rF/5ruAy7RPsQVidPMHnRnvM
 0+0/AusiL+R8RPwy9I3c7OZ9JQe/jbwbRblOIzNU0CzQa9fCERKoFnKpZRkxt/0vLPN+
 PDww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVXI4o4RTI8nNXNP/+3InDJ/2i4bkXFMH/3Igq+WRSIVG6fUyPOd3rlqF7xZu4uZqE2y4=@dpdk.org
X-Gm-Message-State: AOJu0YyntNbgdGPt7W79sN8q7lvmrfo5Gcb3moijgHnj3mbmKl3mACk9
 aNb165U/5EFzX+QLsB9gq+hM4ZUrtisPBbbyaC4ynFiXet2Czlm+29cEjuyMw2Mm/f0=
X-Gm-Gg: ASbGnctTlRLoxiL1uq/KCWn7LHP4jLGpzFTUFZvn8ugM0MVfHevEi0JZueIRstEVytw
 MZ/ynXDZ6bjF3/gabfEY+VmEioPiEnmxq4/DIel+JmwdFsrwN1clUZ8ltmSsq+1IVgk845JBOZN
 99BUgvd3eZhHAD96TzDEw89WEegp4QlloMkkqWtXNK/rArHnv3U+kT3W0CEBRXgY2IAShQjMQ+s
 N56el4id5ViZiibN4w+crSoXSsgQgIILfL7iG1Se3tPAKFYj5SFMT47OewcIKK51+GnfJ/qncQD
 BgsCj1O3MufuqKEJ/mUb8DyvfhBUtIZepYJfXqH62dc0v+xAnBLZfBKYgH8XgNnpN1+/fiYylqv
 yGMp764VuxfwImvXzYZ9cIqI9nqgRVNvLalinCFblW7e/UVe3YDb01qAPx4Qkyy/Z7WUw5yORg8
 I=
X-Google-Smtp-Source: AGHT+IHvr0QfyJJW3xTbQol1k4YDFFCgsizyIiLYUfxz+ZEMtqYwo/UoXLMvr87Ht4hpyEGb58kr+w==
X-Received: by 2002:a05:6000:178b:b0:3d1:721:31de with SMTP id
 ffacd0b85a97d-3e636d8fb10mr1898331f8f.7.1757181082625; 
 Sat, 06 Sep 2025 10:51:22 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e4455ecaf1sm6125628f8f.40.2025.09.06.10.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Sep 2025 10:51:22 -0700 (PDT)
Date: Sat, 6 Sep 2025 10:51:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <skori@marvell.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>
Subject: Re: [PATCH v9 1/1] ethdev: add support to provide link type
Message-ID: <20250906105116.427529e9@hermes.local>
In-Reply-To: <20250901054552.813195-1-skori@marvell.com>
References: <20250821053425.3227866-1-skori@marvell.com>
 <20250901054552.813195-1-skori@marvell.com>
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

On Mon, 1 Sep 2025 11:14:34 +0530
<skori@marvell.com> wrote:

> From: Sunil Kumar Kori <skori@marvell.com>
> 
> Adding link type parameter to provide the type
> of port like twisted pair, fibre etc.
> 
> Also added an API to convert the RTE_ETH_LINK_CONNECTOR_XXX
> to a readable string.
> 
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>

This version does not apply cleanly to next-net or main branch.
Please rebase.
