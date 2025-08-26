Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6D8CA0FE7
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 14:22:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 862F04064E;
	Tue, 26 Aug 2025 16:22:17 +0200 (CEST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 332D640652
 for <dev@dpdk.org>; Tue, 26 Aug 2025 16:22:16 +0200 (CEST)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-3c84aea9d32so1268542f8f.2
 for <dev@dpdk.org>; Tue, 26 Aug 2025 07:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756218136;
 x=1756822936; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTHuvtqjWVIl9Y34NCelk4JsFD0sRNatjeXvOHZGqB4=;
 b=zk87PFuB7PVV2as1x2MlE6vJfq0Gw7jG9qsurg7vZvMsV61uHGrnahJ3KIjmiW57SY
 R5lq4Xr+fiwmrDtS2oKB2Mua5kUr7jaTR/n88XfftL/u4fGpRxRSHpuJKtOTJHQr6ug9
 PR8Tp7CnDPqMixJmjjkSqnih3COTDQ42bR8VGiiEt7GHuRc31esDtcu6ChWCw3T3SKhj
 WptgSBy/RO/V5lyXOKFA8RbUnDmMKKjKgKyk3ypXAmJwhdlSkHUE7Z9hqJzNpg1n0Kf/
 zEkDs+o9ItIaJNZ0GhpQgVky22oaRl0bfFVI2sExyB5UkFWsypC4KCnSXp2po9DOgBMd
 1mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756218136; x=1756822936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eTHuvtqjWVIl9Y34NCelk4JsFD0sRNatjeXvOHZGqB4=;
 b=tXcCZj4oMzj7K0udOoCeWZiCH7YrPldJOu1HtDGiIb/FtNMB8pFuGoYgKhJjurpRCF
 wRLk7su0kMb574HFfoH5bgNQ1VhihuSqpZYNYz+7ARFTYUFD7oEJ4V6IQovpQr16l8CV
 bXDJIj/yZSDnfdFVbVkOEM9an7tGSpFaMdThPmxzJ8Rlg/APruoFZax9DT4FZuj1lYli
 GE07pKq5NzwI+HMF8VG2q5rZ//Ox9U4BjXWEwgce+903I48zcyEnlVTRrOP1RGbUNR0Q
 X6/9r0QDKf0XOLW5L2lzK1iakNULVCMsQSOhwdVbatxS5cTH4d5AjWmcCX7Gj7/EV8il
 e+YQ==
X-Gm-Message-State: AOJu0YyZL/TfTFIKdZx3lBUn8SKaQfM35ePcrRQGdQy2ydUo8X4Lp0hu
 +X59A/lVf8/HsX0jXCP6b0QKLR3w2QEX3Xt6Wkml4EjoMQDuIkK5s5NikcRcvwBW2Vs=
X-Gm-Gg: ASbGncuaasXIAzG7FUh2WyhuqW6tv96ey7Hx2Je4CLyjMNHcJJ6tTf4Mhw2TjVwn6Xr
 wLTqHeSQixkMwZUIMmf+DnMhH3t8Pp6rYMgjzSxfG316+AqIFNsU0hOlz3tr5lsBJAY67Uxhuk/
 qGeDh54BYogleYzoR7mDXgEXOPryPaai95ybcX+NL6A74AUbji9nBZRmAV4/ifFRpV1ZOTeFece
 aWGmQF4HUKTIxmovIAuzSztxY76FkwWUNof6yUyGCrbUs4ZOH1ePVJALtTtH0bxGEMx+IGWpn32
 VFes+KHNQX9jSluY1gk431SD4k9996GZ9L87mV24ji0Mcr95koBTdY0vBmm4IHPl2/6Ss4h91Al
 vSq47ejCx973zeThZKAtxNh41f2lQPQsUHlAdL/fcfPp099Ca6zVjaeGnAhC2Pmco4tUSgqXVPk
 rFHl+HmcRiFw==
X-Google-Smtp-Source: AGHT+IHtdgsdSm/82xkL2H+kHZq8SHgj/z5+2N8nWX7lrVCnC5vl9be32zN/B/1GyC/X7E6SjE8rTg==
X-Received: by 2002:a05:6000:2911:b0:3b7:54b3:c512 with SMTP id
 ffacd0b85a97d-3c5dcff79e1mr13827389f8f.58.1756218135562; 
 Tue, 26 Aug 2025 07:22:15 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711211bd7sm16842122f8f.38.2025.08.26.07.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 07:22:15 -0700 (PDT)
Date: Tue, 26 Aug 2025 07:22:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, "Wathsala Vithanage" <wathsala.vithanage@arm.com>,
 "Yipeng Wang" <yipeng1.wang@intel.com>, "Sameh Gobriel"
 <sameh.gobriel@intel.com>, "Bruce Richardson" <bruce.richardson@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>, Mattias
 =?UTF-8?B?UsO2bm5ibG9t?= <mattias.ronnblom@ericsson.com>
Subject: Re: [PATCH v2 3/4] hash: reduce architecture special cases
Message-ID: <20250826072210.79659b3b@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FE73@smartserver.smartshare.dk>
References: <20250821203646.133506-1-stephen@networkplumber.org>
 <20250822182110.27599-1-stephen@networkplumber.org>
 <20250822182110.27599-4-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE6C@smartserver.smartshare.dk>
 <20250826064149.25787722@hermes.local>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE73@smartserver.smartshare.dk>
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

On Tue, 26 Aug 2025 16:13:29 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Tuesday, 26 August 2025 15.42
> >=20
> > On Tue, 26 Aug 2025 08:55:23 +0200
> > Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
> >  =20
> > > > +static int
> > > > +rte_hash_k64_cmp_eq(const void *key1, const void *key2, size_t =20
> > key_len) =20
> > > > +{
> > > > +	return rte_hash_k32_cmp_eq(key1, key2, key_len) | =20
> > >
> > > Is the "|" instead of "||", to compare in blocks of 64 bytes instead =
=20
> > of 32, intentional?
> >=20
> > The cost of the conditional branch is usually higher than the cost of
> > doing
> > a few more instructions on cached data. =20
>=20
> I agree the key being looked up is very likely cached.
>=20
> But the key in the hash table might not be, and the 64 byte comparison mi=
ght cross a cache line.
> I think using half a cache line as the breakpoint (for using conditional =
branch instead of unconditional load and compare) seems like a better trade=
off than a full cache line. I have no data to back this up, just a hunch.
> In reality, it depends on the use case. If a cache hit is more likely tha=
n a cache miss, then the unconditional comparison is preferable.
> No strong opinion. I mainly wanted to ensure this was intentional.
>=20
>=20
> While looking into this, I noticed a few instances where your assumption =
about key1 being aligned is wrong, and the key1/key2 parameters should be s=
wapped:
> https://elixir.bootlin.com/dpdk/v25.07/source/lib/hash/rte_cuckoo_hash.c#=
L763
> https://elixir.bootlin.com/dpdk/v25.07/source/lib/hash/rte_cuckoo_hash.c#=
L1319
> https://elixir.bootlin.com/dpdk/v25.07/source/lib/hash/rte_cuckoo_hash.c#=
L1357
> E.g. when calling rte_hash_add_key_with_hash(), the key parameter can be =
unaligned, and it ripples down and becomes key1:
> https://elixir.bootlin.com/dpdk/v25.07/source/lib/hash/rte_cuckoo_hash.c#=
L1259

Ok, lets make 32 byte the watershed as comprimise.
Good catch, best to mark all keys as unaligned, but it won't matter on x86 =
or Arm64
