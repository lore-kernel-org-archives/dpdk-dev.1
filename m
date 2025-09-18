Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6CCCAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 16:06:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75FA5402D1;
	Thu, 18 Sep 2025 18:06:56 +0200 (CEST)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by mails.dpdk.org (Postfix) with ESMTP id B830640288
 for <dev@dpdk.org>; Thu, 18 Sep 2025 18:06:54 +0200 (CEST)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-4b7a8ceaad3so11113951cf.2
 for <dev@dpdk.org>; Thu, 18 Sep 2025 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758211614;
 x=1758816414; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iM2LMeeepWzdJeu0rMtzfQaRPy3ENXWsAcEK3K3ZXiQ=;
 b=fzG3OcDOcglr5CDhjXTjp2IQGMvxhrR5e/+Rcpw4sKteZXmvDaS7UL7wooAyMzaAS5
 TwixSxSqdhvx5pH52XYEhDNRUpQhKaJTxYTjXCJiUAaN1NpKVQv3/M+SU6ZiPfX7VjOi
 ET2lLTnC/pVfph15M0piYVY62jU33ln2Vf94NGIu1Tvu+CXVJ4Ltxw9oOjLqqV7VLBl0
 dsIAo0Z5ub37LSIi5uqGTaaEZL8do9/0SFI5xSgXxg8gXnsBLodDeKD/f1+s2g8k/u3r
 I1PqZDR3PRJo8P1XzXN+A6pzRUPJAC9zo3AHoDMMyZskmFcyCVix3jgnijwL1a0dG3EM
 biig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758211614; x=1758816414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iM2LMeeepWzdJeu0rMtzfQaRPy3ENXWsAcEK3K3ZXiQ=;
 b=tR3qjcfQC2nYIHES4O1HnnKElOvK/3CAZFw9VHUBkh13EKuZGTgMyjE+7t5rMWIATY
 e1b1Ugt+iUBZYFchrbSyrcOO9d9BHxcRQj3tb/A028Doe94cQKofIRv/bBagYlUE11eQ
 n4NWdp9Tc9ZygRXunjX3jE/uaxgC9Tka6aI4r52xUtR1yyWQh0W5sOQLsKQGYXTYFWHE
 EYl1QJvXnYOOC7Sgp8JDyE4pcU30RQYskA84ovUm5i3kJ73+b+GvAtuN+cXhsn6LVNLs
 18yGXRoRX0pciNQyeZRJajLFH25PdUFxncPvagI/V/yTD/9ydXBxltLm6AdoPjMtzFVj
 COYA==
X-Gm-Message-State: AOJu0YzYPL2u9OZI/qFolOi2KIfIh6xd1WrtF3rdPqZhIHPt4TAWUgeD
 H1J4gUN9b29UF4RPEXTsTKTt+WT1vqK+IwgARkGQGtq5+M2iedB1wnTY7AJSs9drhQ0=
X-Gm-Gg: ASbGncuUmTVZGPoptbWE6EbO7aehpzFQCIgquDdluIqb7LrZf56KBDZGkQlazRmwNKm
 Ir8woBE6pD2/lIKVEcJcOQB+kC54Avzx3LyXBizUVOTHh2j0Av4YLLyD+4UAe0dC7QvmFt3l5/g
 yuJzDw9rNTDi91WteQxBJbxsDEq18mWhpGW2LlHVqqlENlRP7nI6FLR3L7u7ooDJZhTUSViJ5Tt
 +WMbwL+qzubDwFNa5C0/n+l9SErIdax/PD8gMEmYjQQPG9Fmc6+qUg34xkT9PQDRgAytnDIo/uu
 kDTrARz6tSm+kvBPv0pM354P3cnrhilhGp0FhhlBRsCV7/b2QsaZdNaEvaoAvT0cEanbnbXRf6Z
 6/F0eg8llGCcK7v0lKPS6hvrdQD9EVn/RTfEnFCIXqAi02mL2R0XV6/yvWQB8MTeoJTmBjCQp1q
 mXUjEE5KS82c2tBrKC1A==
X-Google-Smtp-Source: AGHT+IGgJWqeNkBC4QmQeDn8JQ0P7ksjzygd33TAqKjRFvsYF0FQI1XYJ6E3GyzyPHr4caY+KatfSA==
X-Received: by 2002:a05:622a:5c8b:b0:4b7:983b:b70c with SMTP id
 d75a77b69052e-4ba6b4670c3mr84720011cf.67.1758211613809; 
 Thu, 18 Sep 2025 09:06:53 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4bda1220e29sm15951931cf.9.2025.09.18.09.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 09:06:53 -0700 (PDT)
Date: Thu, 18 Sep 2025 09:06:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Xin Wang <wangxin679@h-partners.com>, Yi Chen
 <chenyi221@huawei.com>, Feifei Wang <wangfeifei40@huawei.com>
Subject: Re: [V11 02/18] net/hinic3: add basic header files
Message-ID: <20250918090642.65bb8e20@hermes.local>
In-Reply-To: <20250917101604.17045-3-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250917101604.17045-1-wff_light@vip.163.com>
 <20250917101604.17045-3-wff_light@vip.163.com>
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

On Wed, 17 Sep 2025 18:15:36 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> +
> +static inline int
> +hinic3_get_bit(int nr, volatile RTE_ATOMIC(uint64_t) *addr)
> +{
> +	RTE_ASSERT(nr < 0x20);
> +
> +	uint32_t mask = UINT32_C(1) << nr;
> +	return (*addr) & mask;
> +}

Shouldn't nr be unsigned? You don't want to support negative sifts here.
Use RTE_BIT32() macro if possible.

Since you declare addr as RTE_ATOMIC(), the only valid way
to access the variable is with rte_atomic_load_explicit() etc.
Some of the compilers versions (clang) will warn about this.
