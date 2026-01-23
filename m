Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48595D6CFBB
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 05:14:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AF2D4021F;
	Fri, 23 Jan 2026 06:14:41 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id D0362400D5
 for <dev@dpdk.org>; Fri, 23 Jan 2026 06:14:40 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4327555464cso1103811f8f.1
 for <dev@dpdk.org>; Thu, 22 Jan 2026 21:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769145280;
 x=1769750080; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uzdqnWTo0xmGe1RcOvDBNhXX8S76GVVwhr6iIVd1VMY=;
 b=0Xo9GBbO5MYrJC5kjxdzuWKQyh7txbyI7qu197DHaziiKwyZ1gv4e3oEdTB7p2B3Sq
 vdaQ2GTkWmMIvCqQlUrQ+l7lWh4eOfTDuuZqIu6Lw+CfdHgelhNaMAkC+0jGudgrQFqA
 ANEeJLfIHP2794cz7+L5aTRlTy1WqjmEotCvmFiczaeN/T+SRKdkhynV0mZwwKCzOG2q
 89e85jfunvLGoK7wcl+rOzQdRaw2h3az8dQ+kH+lhqeaanReNImBJdmIpFx4LBnfKfdA
 OYho/hNxWm5wcpuwM6rnJqLCr82nvzfvcs8o2iR5KvGwTL9t1QgQjTdlrExbGJN7vCSJ
 5jhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769145280; x=1769750080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uzdqnWTo0xmGe1RcOvDBNhXX8S76GVVwhr6iIVd1VMY=;
 b=TLGGgjNatBEWCaglgG/rgABLKRw3aJkXZsxx8IoOnXZIBRM+BYGtyx0yuBVcKzs5qY
 R4/Wj4u/oC+mpzTfHhWubQ0KiuA5KvLNeSjNeTgKkLif8Qy3oeh2UhqR4IhukcZpfnYS
 Ic5l4Ve2FkVIRrzx6pJ4CdzBttvLrPwRmZJX4yUlI09UjaFwGSc50V1OZ74oURiuLCLO
 1BCPTRyME4quCnC33CT2swbcAF6VMWOyS+xr5Fmi+B7W5Yqdq/E9c5xWBMvguVO5p+ei
 CP23/zpKADfULhnG3bAlERtthEP9buFmCdkavDsqYRxpV2qIh/yBcxem+HsmqriYXZ4b
 SL+A==
X-Gm-Message-State: AOJu0Yzr70240ZY+YGHzTNiMmABhk6HsbpRlsgY6f/RSupk+B00coBMD
 jZzQCjuoWlfTFdsKa0V+bH+zuE60SN3flW+pFTRphhcbqoqVyXGSjVbEVx5d8aFWG48=
X-Gm-Gg: AZuq6aIauZ0kWmJeN+jX5kx1kCgKR7TnUggV289m7K9bCT1DxLFSu0algx4hv8T4b0i
 aJp66fH5WoB+G5hdmGUlcJLtrySam9icK66KRyF2GX97y1pdUcH99vIC4eWiOyvMqJXoyhk5OFe
 lq0X1VZuT4LM6VPJHXyBKV5Wtc77+MuyZd18u+z2BQGoaxwRVfT8PhhmUkhN946wVf6oYueQkXB
 hpM9I5fs+OiiPBv1PkQcogsZVNw1krIm+sgFci5baOfnO2MK3X1HK3OHHKtlON7lfg8/bgoS/li
 fwn0ipPc1yOKjxMSUnSFY/ZdhV/q11amqwsp1MMc1ifJ3sSi8/KqUbWjZXL6+/bJnuHZsQDP2wM
 PnYOZ3DezdKCi/T6jlKYxaiPqO0ye6NnBhCN/x/Q+M3eg4scVOZthw7qjXT/QbCD36t0qvhEah9
 8wcz41eEtdtVn9op8CHQZVRLSGpBpbJkQTngtCjKGBbuGSVyv7z2WJ
X-Received: by 2002:a5d:64c5:0:b0:430:fd84:3175 with SMTP id
 ffacd0b85a97d-435b162c7b4mr2982537f8f.38.1769145280378; 
 Thu, 22 Jan 2026 21:14:40 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745dbsm3900998f8f.34.2026.01.22.21.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 21:14:40 -0800 (PST)
Date: Thu, 22 Jan 2026 21:14:34 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mattias =?UTF-8?B?UsO2bm5ibG9t?= <mattias.ronnblom@ericsson.com>
Cc: <dev@dpdk.org>, Mattias =?UTF-8?B?UsO2bm5ibG9t?=
 <hofors@lysator.liu.se>, "David Marchand" <david.marchand@redhat.com>,
 Thomas Monjalon <thomas@monjalon.net>, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>
Subject: Re: [PATCH 1/3] bitops: promote bit manipulation API to stable
Message-ID: <20260122211434.07e7449c@phoenix.local>
In-Reply-To: <20250518080556.675092-1-mattias.ronnblom@ericsson.com>
References: <20250518080556.675092-1-mattias.ronnblom@ericsson.com>
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

On Sun, 18 May 2025 10:05:54 +0200
Mattias R=C3=B6nnblom <mattias.ronnblom@ericsson.com> wrote:

> Remove experimental tag from generic selection-based APIs to test and
> modify individual bits in 32- or 64-bit words.
>=20
> Signed-off-by: Mattias R=C3=B6nnblom <mattias.ronnblom@ericsson.com>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
