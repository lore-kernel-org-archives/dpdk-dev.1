Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4049E6BF1E
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 16:20:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49D4B402AF;
	Fri, 30 Jan 2026 17:20:36 +0100 (CET)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id 05CF840274
 for <dev@dpdk.org>; Fri, 30 Jan 2026 17:20:34 +0100 (CET)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-435f177a8f7so1397656f8f.1
 for <dev@dpdk.org>; Fri, 30 Jan 2026 08:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769790034;
 x=1770394834; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WuVpS7gAUu9NmqCLqz9h7mAeo3KNSOhZX0JiAGwDo+k=;
 b=bTUHRsU7i017c+4pT5VLJ75E96EJuzeenALXpEd6hkSFvkVUsQEhK3wdsynCv2bm4C
 uGXWtypFXJMUn5hbqTgmEDJJ/B5mqODlw15gedeTC30bIS07Ev9X+HcMw+TiEDZQcWr1
 mZkFX2BQwDSV0eEamdLeaF2M2C6nzXnuj1xqLJwcTxWda1DdEv0CYSBwt/5iDCXCvSzf
 KzYafl9KQ5OLMqukVGBXFMDMYNAb11dwmWv+Oiw7MVT3lFlpGdz8fyRxz1NKRT1sFK38
 /fTP4I34k5kXzQDKKYm5FkMp/H8yUGnb+iyi09BbZrXLzLsdk78RCkjKz9iEePOx4OLq
 Crrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769790034; x=1770394834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WuVpS7gAUu9NmqCLqz9h7mAeo3KNSOhZX0JiAGwDo+k=;
 b=ppide6C5DDdrsl9pviqPr/SRTvcx3RDul79998j8M6d3/rTfeEwY2JJtly9bq1Yr+L
 KV8rvfbqvUQXE+wCHPVPKW7Vu0i20vMx3OBPO5t4nOs+dsiw3jekMwtL9r9F/oVGc0Kq
 lW1T2QVl7ZMRNcP9ivHZXY9Z2SH4BqGBlFMbJIWlPcIeXrAOG5oM0tF5cqadDI/0h++K
 PFtAEnIDOeH9j0J8NbTYGoKqm3FSkkFafgjbnpZfzcVp3U4AqBnyXD1pQYCEglyWPeUo
 yyCQ0dbG1NRn587pc4I34gV7O4CaCI4FLIIWVOc7P58+IJIfpijImWNfBJUkGNILxBPz
 UieQ==
X-Gm-Message-State: AOJu0YzdmIKorYEPHAKEaffaEL4AiI65n2u6xEvEMAajlt5ilUiyqjSy
 eXkcQs6521oWVMA0WH0IH63cWD98Xy6pn7hcFnVeceT57kV+58GFH8LDg3xi6zQny8Opq3bZcIV
 yKhx9
X-Gm-Gg: AZuq6aL5MqeOahlD82kGibiKqgav9Td7laKjRcMzjnkDhJRXSkr3u1mxovU0XjkjJ2y
 ze1nGr1Sb4penn7MjUfemWmSbY0QPO4IEl5iOiTZ7zHhe0vRLKcdgsg8R+RnKVmNXs4c148JTZD
 NCbb/DvG6scVK6h95vECkSP7mwYhv3mDjttN6fLX86ot8Y77TBPPFsjfQA+w9+of+ichVHp3epv
 7HnyYa42RZZTub1KzruCG8NeE405FgpAmMgV/JtAjEFc6SaS5x+u9ZloHGFnYVBXnNYEO84xwki
 MWhI9Cawm31wHgRItJ4hhuL8kVBZqS03cBfJVIe1cIEefwIuUM7PdATAQhnLEnTHH/7wwp2nveu
 pA/uvi0jeGI3GHy4huN11iM2/va9uy2M3g/UF5iP7SEod53be1G45gMhieg+vsSIBkbkwQif7K5
 xi8Cc794b2loakklCvPy3ri2Zn6YFqCBUtbVSJm2vEgOASJkNJ8pXU
X-Received: by 2002:a05:6000:2002:b0:430:f494:6a9c with SMTP id
 ffacd0b85a97d-435f3a7b463mr5552035f8f.17.1769790034299; 
 Fri, 30 Jan 2026 08:20:34 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e13235f5sm22684795f8f.29.2026.01.30.08.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 08:20:34 -0800 (PST)
Date: Fri, 30 Jan 2026 08:20:28 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 1/2] net: ethernet address comparison optimizations
Message-ID: <20260130082028.1d3ebeb9@phoenix.local>
In-Reply-To: <20260130104617.535413-1-mb@smartsharesystems.com>
References: <20260130104617.535413-1-mb@smartsharesystems.com>
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

On Fri, 30 Jan 2026 10:46:16 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> +__rte_pure
>  static inline int rte_is_same_ether_addr(const struct rte_ether_addr *ea=
1,
>  				     const struct rte_ether_addr *ea2)
>  {
> +#if !defined(RTE_ARCH_STRICT_ALIGN)
> +	return ((((const unaligned_uint32_t *)ea1)[0] ^ ((const unaligned_uint3=
2_t *)ea2)[0]) |
> +			(((const uint16_t *)ea1)[2] ^ ((const uint16_t *)ea2)[2])) =3D=3D 0;
> +#else
>  	const uint16_t *w1 =3D (const uint16_t *)ea1;
>  	const uint16_t *w2 =3D (const uint16_t *)ea2;
> =20
>  	return ((w1[0] ^ w2[0]) | (w1[1] ^ w2[1]) | (w1[2] ^ w2[2])) =3D=3D 0;
> +#endif
>  }
> =20

FYI in Linux:

static inline bool ether_addr_equal(const u8 *addr1, const u8 *addr2)
{
#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
	u32 fold =3D ((*(const u32 *)addr1) ^ (*(const u32 *)addr2)) |
		   ((*(const u16 *)(addr1 + 4)) ^ (*(const u16 *)(addr2 + 4)));

	return fold =3D=3D 0;
#else
	const u16 *a =3D (const u16 *)addr1;
	const u16 *b =3D (const u16 *)addr2;

	return ((a[0] ^ b[0]) | (a[1] ^ b[1]) | (a[2] ^ b[2])) =3D=3D 0;
#endif
}

In FreeBSD kernel, there is no helper they just use memcmp
