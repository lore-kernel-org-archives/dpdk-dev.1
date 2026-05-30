Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0552CCD6E49
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 May 2026 20:11:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06E74402ED;
	Sat, 30 May 2026 22:11:38 +0200 (CEST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id 3EEF34027F
 for <dev@dpdk.org>; Sat, 30 May 2026 22:11:37 +0200 (CEST)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-8ce9e56f68cso313226d6.2
 for <dev@dpdk.org>; Sat, 30 May 2026 13:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780171896; x=1780776696; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KOAliQEKehOielf67P4GdnK3HfBj5fKy6QiXICQWLME=;
 b=g8ZI/K849n5T+DnjAfo7quiXAg6/y+6zM4trd3258lkjG8ojs6DGKYivUmu6wXZYXo
 3+yT2WsZmxYw9giIZFPayu8EkpPleAi8pURp68PnBu76AEo9iODh2RR7KVimgATyWLFy
 SdG72T/BtKmkh1NkvvLVzqQ6GaG640eBKboGVykHLgDEF1z4y/FdKwUZwhi+BH7TL1eF
 OYb7AkUnDpzaxcYY29VsmpW2wLMzS7X4oRdTSXI/cYsvGJnpSCGeoewL+IQbT1YjUDig
 uvM241bToSzMkGRZ8fjq6mfYOkE3I5wonEUjMgvmbRJuJMMI8l16dPQf8lrrjY03jLOx
 WLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780171896; x=1780776696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KOAliQEKehOielf67P4GdnK3HfBj5fKy6QiXICQWLME=;
 b=me5ev1B4cP4kpPN7/iT70/hDi0L03IsoxPAD/T4SCaK5VYRd5VwnXwN4z3wZ3j7p/l
 QQ/ZivK8JXMBMyvgVJE6fdIyvyNuJR9aEgh7VaWFEuiMfximNkJ1Mg0nv7x/HlZQNaeH
 8vbIRABJLYt+An0DXOgWb9xedCXM0DA7NUy79uoVvKS7lgMwgrJmjy8+RhkBG/xqHUkF
 3QqEQHOXH+5YFysJliXKLQP3i5b+IaLzg+qCjmXCLvgBwdfRcE3ueXerTSmsitB8s3VD
 g02aRHcUvvIPrRYQGZ6DqC5J4Qz+si+d6HG61SPfjsgSs7abGwdqCJ4BnNVbsh+k8wre
 j7TA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/tmEIt6dOCdCTN81MDSEz+Tj/Z13dLHE4VZ/yPx7roHXFWSXwXlxwoStQTFLwpnV3eS6k=@dpdk.org
X-Gm-Message-State: AOJu0YzqwLezVLN3jVLDwuzQ7mYh6An5YFlwSKH4Gfxb4RuynfHgoZ4A
 mRrlhj5mp16C/FZzh2YLWuLLrJSTNxd/os8Qmy6fgx5NBiQWllA23Hw75NAfwcX7z/A=
X-Gm-Gg: Acq92OFKUfyJeRiL1WRlFYIS0bcY78yLL9EA/FPemQCZkTl7mhfczGAQu/96jczs3Da
 fpXL9rrpOfHR3EnAN5/M9mRkedOCYubWaO5OFxXpyffch0vTTgAPuBh1C7EcWelVhp8p+E9EIZg
 r7osFjyE/zpUgPgPmxCGRCWyb5IwGxL3DE/Oa0PSbS5EyDEDLQOwAE64Suqqu6X94sMWajD0XHz
 1N/lWRcmzjSsCJRzB85O0b4tLAPPLXgN0sg14x2O32Ssf4U44UbOSx7EC1Z17KrMRifLj4j/ZJV
 REGpFlJFLHjQKcVu8av0NREKdojlCGNldzIb686OOEwsx/hX+z9lnRmX7dedfxNksD/VLcRSKsP
 fURn1QEbfgrcGvbh3gSFje5dghq+/430veBYgY9HWfF1TaWP+sZSmYnEyeK243vdDhR3Ymf/q57
 XwienT1FQVHeJTE5qIRK7JEJ7bCi1g8LhBqaSLSm8Lj7rgfHDWp7tBso7BKO63qofCioZfxUOwg
 dZPy7+6y0fXiz1sBlh4cZjoI5S8iw==
X-Received: by 2002:a05:6214:4890:b0:8a4:21d9:bbf2 with SMTP id
 6a1803df08f44-8ccefddc648mr69643486d6.33.1780171896437; 
 Sat, 30 May 2026 13:11:36 -0700 (PDT)
Received: from blam-mobile.hsd1.nh.comcast.net
 ([2601:188:c083:cd0:c107:2c35:5b4a:5cad])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccea07e2b1sm51060286d6.17.2026.05.30.13.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 13:11:35 -0700 (PDT)
From: Patrick Robb <patrickrobb1997@gmail.com>
To: dmarx@iol.unh.edu
Cc: Honnappa.Nagarahalli@arm.com, dev@dpdk.org, luca.vizzarro@arm.com,
 paul.szczepanek@arm.com, probb@iol.unh.edu, yoan.picchi@foss.arm.com,
 Patrick Robb <patrickrobb1997@gmail.com>
Subject: Re: [v1,1/2] dts: update verbose output regex for VXLAN packets
Date: Sat, 30 May 2026 16:11:31 -0400
Message-ID: <20260530201131.19462-1-patrickrobb1997@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260312203630.96473-1-dmarx@iol.unh.edu>
References: <20260312203630.96473-1-dmarx@iol.unh.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Reviewed-by: Patrick Robb <patrickrobb1997@gmail.com>
