Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F62D2D11F
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 23:19:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E420D4060C;
	Wed, 14 Jan 2026 00:19:52 +0100 (CET)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42]) by mails.dpdk.org (Postfix) with ESMTP id E3DEC402BE
 for <dev@dpdk.org>; Wed, 14 Jan 2026 00:19:50 +0100 (CET)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-64ba9a00b5aso11741150a12.2
 for <dev@dpdk.org>; Tue, 13 Jan 2026 15:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768346390;
 x=1768951190; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gG5e+4ecgiulFMAtydENGnL85aKkdjnVw4qj0mnom40=;
 b=PQe2ga6GivwYUinmTgsmd+WqftiKMb1wA5hUtRUS7JIDYqd94PZNTiQ+7bPVWE6GA8
 56+cwyyDIp0Cb1j/uWsbeFf4Yzyhnebjra6bmObWapkCmGAYIDEFJbBPhJ740DT2QIU1
 LBcTc34hoqG6TyRIz9B2kYHbPGS/zLUBLUJ52j6O4K/5+MJx85uHnnE8l4uAIyGKI+8I
 u2ZnzwDmPlr6E2wXzdprVkL+v4AbKSKhkz0vQlcB/lwszjyDJA9gLUfhF1uqcMDt4LLy
 TOi8i1FjjtYa4CqGsjRDAhP8T5RMsRaC5FeRg1NbgPUTTAAaZENVMC6ouBraOfKlxQXx
 gcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768346390; x=1768951190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gG5e+4ecgiulFMAtydENGnL85aKkdjnVw4qj0mnom40=;
 b=lp+eZ+lqRymCHZIcbxn2Avehg9TqVuh+Jc80hYHc2BbOcZBy34CGGAzpO9CS1cQLvp
 aCL2GNzIj6TbJKts73aRDp6O8GGXQfMlz7D3MiYDqFN1bsrrHHtW4eVxvPv389Dv53B2
 5FSW3gzG7YG2+DDTszSptkLsyYJ7m2llQjwAhca9g3X9znOLHMOZjMDMKeRlVu9YjCvy
 akvZzpHtcIkH4eBEQqfiSLkk3TVH4jpjlg3G87NtWOVVNpeseOO4VGcZ/qovCiygaZFO
 gJQ7SHUGbxnNn+VAoDQklM6zUQ4Z7Y+EfWHHMxg7f6JdKkEzKp4rFKUhzeew5yBch7Ff
 5M/g==
X-Gm-Message-State: AOJu0YydDiv9+WVBOhExY0aOTLsnuNR5BQBDW4uKR6lQx+MNJID6QLjB
 2JDIoSzyLwVGLChgSnEhy2f8ZXGFrtwhBLtTizlMiewOE8uqr+3cy5HnNyJr6MMcRaA=
X-Gm-Gg: AY/fxX6nC7AT6su06aZFpKudSUycxPvP9uF7H2UlDbK7wFvMQJ59VzyduEugDsn0ssj
 YjqMzmw0kbXLERoqS6jrtysy4ZzvvtF4GSYgUDG4RjkZKkZDqPZ/IjlBOjuYaeOiR8Ht/d1e+PZ
 rhY3N4JjDmarPvT8PUxCQdRV+Rbgs/x06aGBJaY4GQqwFPfhJQgToSr/DqY+mIk9OsRu5rcxOwA
 yEi65JXZJ00X8GijfYjigN/F3q7bNJIu2AtR4to/9ayU/rPb2OLEwxxXyKLcxjPt1eYa0LlFOR8
 pM6IGRYv1QvxTIlctT9X3f0YdYXSjaxZ1ciYnbEEkPi0kHEzSTSsNvdDreCdnrdmfZIn4yFCAS1
 d2ah5U5Mk+DlIv2ETJibTpqO5vuQ1fH2MAi/P/HX+VEhNxrl+mhywC7ye3iSfDvHu4LkH2t31NM
 xUC0C+JiPUH+8ocgWHCm9dp6YBAsNpjmTKtIQZr1XuFXdjaqXW/lyy
X-Received: by 2002:a05:6402:50c8:b0:649:c56f:5847 with SMTP id
 4fb4d7f45d1cf-653ec10f91dmr488227a12.10.1768346390476; 
 Tue, 13 Jan 2026 15:19:50 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507be65197sm21157339a12.19.2026.01.13.15.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 15:19:49 -0800 (PST)
Date: Tue, 13 Jan 2026 15:19:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, Konstantin
 Ananyev <konstantin.v.ananyev@yandex.ru>, Vipin Varghese
 <vipin.varghese@amd.com>
Subject: Re: [PATCH v6] eal/x86: optimize memcpy of small sizes
Message-ID: <20260113151943.31c58217@phoenix.local>
In-Reply-To: <20260112120337.277331-1-mb@smartsharesystems.com>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20260112120337.277331-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, 12 Jan 2026 12:03:37 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> The implementation for copying up to 64 bytes does not depend on address
> alignment with the size of the CPU's vector registers, so the code
> handling this was moved from the various implementations to the common
> function.
>=20
> Furthermore, the function for copying less than 16 bytes was replaced with
> a smarter implementation using fewer branches and potentially fewer
> load/store operations.
> This function was also extended to handle copying of up to 16 bytes,
> instead of up to 15 bytes. This small extension reduces the code path for
> copying two pointers.
>=20
> These changes provide two benefits:
> 1. The memory footprint of the copy function is reduced.
> Previously there were two instances of the compiled code to copy up to 64
> bytes, one in the "aligned" code path, and one in the "generic" code path.
> Now there is only one instance, in the "common" code path.
> 2. The performance for copying up to 64 bytes is improved.
> The memcpy performance test shows cache-to-cache copying of up to 32 bytes
> now only takes 2 cycles (5 cycles for 64 bytes) versus ca. 6.5 cycles
> before this patch.
>=20
> And finally, the missing implementation of rte_mov48() was added.
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> ---

Not sure all this is really needed.
Would rather get the patch series in that used cocci script to
replace all the fixed size rte_memcpy() with memcpy().
The compiler inlining is safer and as fast or faster.

Be careful, there have been and still are bugs in DPDK rte_memcpy()
where it reads past the size of the source bytes.
