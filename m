Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB92CCD8C92
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 15:14:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEFD940658;
	Mon,  8 Jun 2026 17:14:18 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id E7BC640265
 for <dev@dpdk.org>; Mon,  8 Jun 2026 17:14:16 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-8cce26ee1e9so69840916d6.2
 for <dev@dpdk.org>; Mon, 08 Jun 2026 08:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780931656; cv=none;
 d=google.com; s=arc-20240605;
 b=hW0wbXUoTah4z9o5ILp8+r4wRjQvRW3Axcvz+N5YPohE5/EezSZqNXXk/P+loNNKBe
 SRBS/Xh9L6ZHgasvOwWKJPwKPzJnMnkUrVVqiiOU9gv89UmfuF15UPsmYAg/gI5BVCeu
 W1qgUMOr1B6AvU9qeTs89r1zAiPSMMM8Vqezudg3ScSuw9P6lNYohQ7Bj0KcuA/uoqss
 1LpQVSgc2AxXJQqZqVo3WEIVfYoy/AngT7sMRmOEVYwbaX6R5jy8Mdtwj2I4fwz34Tnc
 KB4YsZTj5KF/buZuaHW9eMQDOX1iZBgGmHYOzrMXuRTkKFsXBJCq7DqDO3N+7r/uoFmH
 7Mmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SczClKYkvMsM9vQt0aJu5ERpS4dPekD9jYZMA31zMTc=;
 fh=oBzMBBXUrXJu8DCdXy429mcmyPngsflSehz1sgIePJU=;
 b=QephFHSvRcyzMzLU7QVVuZQgEdkmp4CjzY2gITqkvkIx15unfHcxF14XCj4Eikgn4K
 NYuC9XSPOAvR7RG2y/96TNYIDlQpAgRLEcDKflXBIOutDKgAF185mDFiUCZp3oBrcNqI
 b0lqMlr2hDUB5M/nkel8tNUVVYgpPHl3TfLIuyGbmjsYBR8OZmqA0rOD8sm3K6d/+dGT
 SR+HJxQQR4e3GRx+EIsmWxMfIeu8XifQcVlLKuAFXHFqTc5rUWwI298ZB/MRogNjCoZB
 0End45U4gWyp+OFqMtQoWSwHrwYxt17BpkIk4flJsn8vvtTE3OtmyAbua8gdgkNYGbnp
 DP7w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780931656; x=1781536456; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SczClKYkvMsM9vQt0aJu5ERpS4dPekD9jYZMA31zMTc=;
 b=VnMhPoWsFa1B94J7q0LervJLVz3jxuBFkGrEUqlHQzmAR1b6zrpMErJSs/gNrUGysp
 1mZF5uJbINigLem5REOJVFgUv9xNMiCDmYmq8pJ40gxLAW944G0Th1sgmOl+lqsBtHRt
 WPVdioOIqX5tfESBRNV/tXg45OokFK4FLwMT9+yzgKl59XJuj5K1FbDKB+Uedvjgpvs6
 d0pggOrnvwisRCbBzOo6XkyV98WN3Hb8BNrJ+y0GmYWzSXF1QjoIIg3LmZSI52R96CYl
 9PCnsmKiNxaLNEsCpK6PcOQaMl+HkR1RYaiLMTMVntgL6FKWY/1W/CXFU5T2+yv9Ab2O
 FTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780931656; x=1781536456;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SczClKYkvMsM9vQt0aJu5ERpS4dPekD9jYZMA31zMTc=;
 b=n3NCiofX4QDa9yRuwk7nWravhEdZqXC9ERVvojLcnPUoOyjIHCg7sYlmBZITq7OOrH
 LZZyMU9va9JqEWrbYpcAtP7/qJuqFPp+0EOHFRDDD/nSQSFokqXvppxpQldSCIfbqRHY
 Td+2ZsFpGHdj2+K1ya/ancqsMUiHEDtIivN/1FR+9EkJ7UxRea2TPoeDQJp5mchd7IPc
 smkGBkyVHKyiTqNB0osennXS2C0sarG9hs5/5EydrBq7DL5i77xPlW1H76+B0ign/0uW
 sI3TkMQr1SfGpi7DH2qBsRVn+ZfJ9T91g0q8Qt/YILzYzlVUlNSwaJ1Yhf5VsMmvKE2p
 RYVQ==
X-Gm-Message-State: AOJu0YyBVwxGGUP0BpofyntVy60xg+3hGXyia+i683dUd1Y6ZTwWSp5s
 yztl2w4Jm6o6VYOGeC3YW1uDkZdyzKDM9O8Fi9O+eQEXUwMR0yu6xIJ6quTYxYLZxUCcnp0YXIF
 klp8Nar70pPEmFXAzlWUQorrYtMjT1pyRZwQQv7U=
X-Gm-Gg: Acq92OFNNBNgzG8FW91Yl/vF1QuLX/h78aPdoexHvHl+uKOtzV8MTZIt84SDljcXdG/
 +/AWtdgqPV2c+SSC23jFEB5fj1gl/XExUCUaJJWF1FidHzZhmv24LsWKj19YzrpbUduNkQV2nRS
 59jSb+Skl0e+n6zkvhaEgaIPPIp0yJOAiYO8r+d8g+i5Q26mrNb3i5KFb8tCLs8uktWboSoexke
 k+QSzICni+Pewdu7sfJwuAsHNX3fchgnbcrTLbgjHNWfe3QRTvldWIC21hTyQbgqtEHGU5CkZOF
 bbbobTjuNaEOg4Hcy8OHNcNb
X-Received: by 2002:a05:622a:6096:b0:517:8fb6:56b1 with SMTP id
 d75a77b69052e-51795bbf276mr202530751cf.17.1780931656128; Mon, 08 Jun 2026
 08:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260325051756.2588380-1-nkishor@marvell.com>
 <20260325062114.2595888-1-nkishor@marvell.com>
In-Reply-To: <20260325062114.2595888-1-nkishor@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 8 Jun 2026 20:43:49 +0530
X-Gm-Features: AVVi8CdQ9Lr8F9SKCvGkOldjBhnktCAhTzYuPB1_q-Zn5AE7Svam1QwamqgbkOc
Message-ID: <CALBAE1MXR=_8HeByJcmYzm_jQgDwV20=7vZp3mSsiw5CNdEdJw@mail.gmail.com>
Subject: Re: [PATCH v2] common/cnxk: allow typecasting to CN20K NPA structures
To: Nawal Kishor <nkishor@marvell.com>
Cc: dev@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 jerinj@marvell.com, asekhar@marvell.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Mar 25, 2026 at 12:10=E2=80=AFPM Nawal Kishor <nkishor@marvell.com>=
 wrote:
>
> Add __attribute__((may_alias)) to the CN20K-specific NPA structures
> (npa_cn20k_aura_s, npa_cn20k_pool_s, and npa_cn20k_halo_s) to allow
> safe type punning when casting between these structures and their
> base types (npa_aura_s and npa_pool_s).
>
> This attribute tells the compiler that these structures may alias
> with other types, which is necessary when casting pointers between
> compatible hardware register structures that share the same memory
> layout. Without this attribute, such casts violate strict aliasing
> rules and can lead to incorrect compiler optimizations.
>
> Signed-off-by: Nawal Kishor <nkishor@marvell.com>

Applied to dpdk-next-net-mrvl/for-main. Thanks
