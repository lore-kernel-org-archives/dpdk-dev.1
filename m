Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36E9D0E6F8
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 14:59:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2CD140B94;
	Tue, 25 Nov 2025 15:59:26 +0100 (CET)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 3FBA540B94
 for <dev@dpdk.org>; Tue, 25 Nov 2025 15:59:26 +0100 (CET)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-11b6bc976d6so6837978c88.0
 for <dev@dpdk.org>; Tue, 25 Nov 2025 06:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764082765;
 x=1764687565; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vxnW6ZFPHl5JN3wVNkg/WOuz9FiXx0yT5Bz1N2lMs4=;
 b=PIqV+CGYV7+zd780/ErnU3QhdIqgRXLGg4dz8X+z+sjW2YONmZDwH6fpN5G5QZkjc8
 0Pa9uv9D7eEt+w1opYyNnR4zBji8ZnvDZFmw0aPCNyhcuF1VyJz6ScWKF46n2rF7JApD
 y6jmfHJ5DxT7mY+n9saXevKFXw313RcP5iBq4jV0ApMu+DrW/FIe5SFpYQTZwA0KYv+4
 0tKyhrZ5nTHUcA/0H/oa4cLfdLLtdoJ3mt4w0X+hXpBbRZAaHZPHTVypFgdg32kX3Wwk
 GqHLUGGQhF0T1vMtlC3iXx4i8TDDn/xWpwztdimyyPdjXmMFVTzYaY3p0KYW4pv6uLaQ
 AiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764082765; x=1764687565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3vxnW6ZFPHl5JN3wVNkg/WOuz9FiXx0yT5Bz1N2lMs4=;
 b=Yjz/1ybvNsMesisu6JsDbkCTvfTB1n89UakojY0ZSUEfBbVHXtOOC8TJpswzE91EfN
 V1RRmbpHiGsgyuVQQye6HoC5jdquXglrfY4CmDBCSEYNcc7SP83uPxct+C+xUwChcFHD
 QrdqRtbpd0DDPfpfa+S/kpiacrjKATr3X16WV8Z9814dDN0ok+byFPK0H/Ac/cgW9Bv0
 JvN1JwtIW5H40T5eWzHA8KPxrx0pulzxvATc0m1JzYPhlkLWWei35DRaKP24Qi8plH/6
 voBDTyn5AMjMh13K3zAKNZPqUm3CD8rBrRSZdnbFxrCkDSVSxQIjaGwh8WVFhHi8BATI
 /szg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYUngxCx55aLaG17/CoEcVdq9fqOyOPkX0z9+vwUuP+h7HbMlYXhAp1kcF77/kVeIfQgg=@dpdk.org
X-Gm-Message-State: AOJu0Yy4wucTpQ4cQr/1S7L79VvgWISi1JtOeW15R8OQRaj9YW7NYRpo
 8QbxKCAyrCk9Gwm45yAKwvEHcyM3xSXfbVq7Q02VPhPbPf44iyEKUGFR/7oHcAR9d6U=
X-Gm-Gg: ASbGnct4cj1soV4HVgmlDwhZNyHdBRrJ4bKDidCwsv7I4IhW7K+o8x8+w9C5nO7MXx7
 Dj2X6UerXqdRNzH86vr6X/34O9cWpCaCR6WrDz/SVZC89yi/Lv0aj/M1+kJ2oSWfMqqfn3GXI5u
 o+o8wgwuaFKSxVJmd8aPYPoIZccAyj3mMAScVn4M+wYBKrxtYRQfBTS71sd/GRW70fkA/45uKSv
 3ZifivnS9H3FJn7Tah/o3OtujeSSOnwZuUZynxzXb+QOG8UpQgLjsBxHAOrBmt2OK5mn3ixqwrF
 PhSSEYoiSG4eOkHqIDV88TNIeC29yeypQvz961rL+Qr5FK24ZKXnWvNKpCusClZWVAX/4o+5y6O
 00SP0SlSJAR3PPxXB+zvuyINzkvFBERaXVBEve/gyYk00M0UKD46tXLJxR9DbhMLIqydGP0iNJ+
 3rCoX1PdDC3nkRBaozrf46D6U9iXAJFXHuQynKGyuz8UsRLqSPWURf
X-Google-Smtp-Source: AGHT+IGBEhiNWKw6rxu8CFC9iVhH95pSufiFl3BO+o6bHQgUC6gkZLwTThdp0/YVJRsLJoO4ACdJ5A==
X-Received: by 2002:a05:7022:3d0e:b0:11b:3eb7:f9d7 with SMTP id
 a92af1059eb24-11c94b601c2mr11051414c88.14.1764082765164; 
 Tue, 25 Nov 2025 06:59:25 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11c93e5674csm82710475c88.8.2025.11.25.06.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 06:59:24 -0800 (PST)
Date: Tue, 25 Nov 2025 06:59:22 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "=?UTF-8?B?bWFubnl3YW5n?=(=?UTF-8?B?546L5rC45bOw?=)"
 <mannywang@tencent.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
Subject: Re: [PATCH v3] acl: support custom memory allocator
Message-ID: <20251125065922.7d12dc7d@phoenix.local>
In-Reply-To: <16C60E2E552D75E0+20251125121446.41247-1-mannywang@tencent.com>
References: <66734dfb22e841ddad035c630bb74f1c@huawei.com>
 <16C60E2E552D75E0+20251125121446.41247-1-mannywang@tencent.com>
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

On Tue, 25 Nov 2025 12:14:46 +0000
"mannywang(=E7=8E=8B=E6=B0=B8=E5=B3=B0)" <mannywang@tencent.com> wrote:

> Reduce memory fragmentation caused by dynamic memory allocations
> by allowing users to provide custom memory allocator.
>=20
> Add new members to struct rte_acl_config to allow passing custom
> allocator callbacks to rte_acl_build:
>=20
> - running_alloc: allocator callback for run-time internal memory
> - running_free: free callback for run-time internal memory
> - running_ctx: user-defined context passed to running_alloc/free
>=20
> - temp_alloc: allocator callback for temporary memory during ACL build
> - temp_reset: reset callback for temporary allocator
> - temp_ctx: user-defined context passed to temp_alloc/reset
>=20
> These callbacks allow users to provide their own memory pools or
> allocators for both persistent runtime structures and temporary
> build-time data.
>=20
> A typical approach is to pre-allocate a static memory region
> for rte_acl_ctx, and to provide a global temporary memory manager
> that supports multipleallocations and a single reset during ACL build.
>=20
> Since tb_mem_pool handles allocation failures using siglongjmp,
> temp_alloc follows the same approach for failure handling.
>=20
> Signed-off-by: YongFeng Wang <mannywang@tencent.com>

Rather than introduce an API change which can have impacts in many places;
would it be better to fix the underlying rte_malloc implementation.
The allocator in rte_malloc() is simplistic compared to glibc and
other malloc libraries. The other libraries provide better density,
statistics and performance.

Improving rte_malloc() would help all use cases not just the special
case of busy ACL usage.

The other question is does ACL library really need to be storing
this data in huge pages at all? If all it needed was an allocator
for single process usage, than just using regular malloc would
avoid the whole mess.
