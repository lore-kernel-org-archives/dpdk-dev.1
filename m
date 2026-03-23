Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC95F483E6
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 19:24:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4115402D6;
	Mon, 23 Mar 2026 20:24:48 +0100 (CET)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43]) by mails.dpdk.org (Postfix) with ESMTP id 9078B40268
 for <dev@dpdk.org>; Mon, 23 Mar 2026 20:24:47 +0100 (CET)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b936331786dso506399266b.3
 for <dev@dpdk.org>; Mon, 23 Mar 2026 12:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774293887; cv=none;
 d=google.com; s=arc-20240605;
 b=bwvXQoCA4lzfQ3oAa9d6gWdqv65ruPkjoir4sm/W6pe00yJXh5bb8X3OheamQFZjxR
 hUAdUQqUP+VYeX4H23ymapdjFhp/VO2D+Oyrj7AIHlMsPZSpEhZNLgL1pMZRNwSZ78w1
 +bijUUamCAGIGDBJuitjaNH1+tDuxxfFgu2NLl5GB2hyMVsGPzA2qM3t4sMq0B7f12X+
 gqZVR3/K5gKMj/Id/CS0hxXqIT149gySpoT8hD69iUvPGKzJ+EpLGxwQAcgjODqIHHZY
 SwGVp81II1SGaME8YApFo0Md9hGW+2eBDQptCeBm6Ysy+4DDgKoeODvzXGHiDhivFVZy
 dYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0lSDAtZusJg/XQ1dtGsrfw7HSnQSdm/jEMpdvktZF4M=;
 fh=Jw/I1NQAG13oKvKcy9H7n+Q9FS5BBWV1nucWC1lvmfk=;
 b=A2WTuOfPVFACmcPeJB6jJ6iknBMuZCTIiuqODmX91X2xRrO+lUzFPgX/sJWt3uVIl8
 SmG2v2tuD7joDcLuAbWKIGTqeyuaeCyKSH7Gbs38B9VZ4jBYnTjw5rkGlyN8mWM15B9d
 UZs1XFKEIl5Ut0crKN9PDmqMyjo/9jG0Kk752qJzgkf1vNaXH1VyDua69A6JxpHURAoS
 93S+dhB9vLt/ohrZmYQQiY3filsQQrM4wy1G/jLRFET1VtUyFBehwvN8SAo7hcFIv9vn
 M4nxB9egOVYqHPpvnU5MNRd7thJxHeGagMaJtbytlINZamtQjZ3hG2sAHfG9lqa8rHaY
 Ezng==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1774293887; x=1774898687; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0lSDAtZusJg/XQ1dtGsrfw7HSnQSdm/jEMpdvktZF4M=;
 b=CKsOdkf0GDKMIm3oVrQl/FiZzv8wPHDtqkAZNUjSnXu02KIxqadqJEcjm0/v4PKTr1
 rXc4tefA3ID2EI4fyMTy7CukTZ1vYm7DNpt8MUUyZ2EMbNqFl+yMOxujXjo0Rd1HDsAt
 cDPvJEIdnfyKwqZcOZG5ns1MKwUo6IF57vv9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774293887; x=1774898687;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0lSDAtZusJg/XQ1dtGsrfw7HSnQSdm/jEMpdvktZF4M=;
 b=n6nc00GZmZxXSUSd7kQ5BU1KwzMJ50FYGYCm3I++F4Qd9o4td2I8agi+Z5yg7l5S22
 C2vVql5D87N7dtZFLzObvFwq39Xw2D+Zopp8Bk7UpwTlTwSXFighTbSgEjGC8C7DFamb
 ESYxOz81hanVC5Nfl792qGJescprDpObcoKzGYolVrvudB6au3uIGwHORHb6V0phqAch
 zWaaHrSquWWu1A+ebE51gVDbXgXNmJjKJKeTpD7IO1xUVsDpjnaGjfwTj7ootwMwDPD/
 liGs8oGduPhK5YwrfEGWBkojJOaPzGE5M78IiJivNZZ/9k87KsaMTADb7zrHpZtqo7zu
 Vuxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVCzd+x32I+3lZ3tomG4w309HUOPXESfrr03EvdjNm7SZZwjBkW/MB21BdaZ5W5nrh8TY=@dpdk.org
X-Gm-Message-State: AOJu0Yzsnk9RUzvPANoDAsLMFr2HTtEFe9iwoDFV0K+1GOaKgnMgJrDq
 TvmCaZmdt5zfrRfy3RuHOdJ7cmRQOVqt2S5WSsCj0eJfeXdlAtA/VlcE+DwTTzijTOOUOAShXoO
 2fckjnJZww3RJ/bMIqkdcjI9MRHcIinlH/8K33p0b5A==
X-Gm-Gg: ATEYQzxPPEZPDzELKD5jHtSxWIPwO7mxUlZ2mvE7uCR0Z602VGCdOtGsXfy905zYp1F
 XWapL3uspiIAMySu1uB8L8CVKIeMRIGFu+wfKvAtAreH2plzf4otD/GbV8g7qHuIHpCwRJT4KGT
 ElkBfkdZ5OvZelGNBEWuWXyxafnca1L6qqohpf9sekdBixL2Iddj/QKd5/YkpCy7M07fzld2M+P
 2lz8EZjwOe4yCNxJPnGiv1F7dzmezsIag9tbPcYMrBzlUwyKDDZS0SOMJG2dzGWoV7Oh2oxAk+a
 GjxY1hohzpj81KzhxUfkYjplgXXzDAw2bam8bOaN
X-Received: by 2002:a17:907:1604:b0:b97:fe6d:2e4a with SMTP id
 a640c23a62f3a-b982f0a95fbmr1010744366b.10.1774293887123; Mon, 23 Mar 2026
 12:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260323180818.674041-1-probb@iol.unh.edu>
 <20260323180818.674041-3-probb@iol.unh.edu>
 <CABJ3N2V7=3tsbXDuBsTryjABM0E_rc8VX-MDTigA2jZqLZSWMw@mail.gmail.com>
In-Reply-To: <CABJ3N2V7=3tsbXDuBsTryjABM0E_rc8VX-MDTigA2jZqLZSWMw@mail.gmail.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Mon, 23 Mar 2026 15:24:35 -0400
X-Gm-Features: AQROBzD4gSyCo6BFPFabC4Jw1tDO5d8XQZt_fGdSK-NkkZ1bxG7doQc2dqKvFBQ
Message-ID: <CABJ3N2VAd6VuyWTKgJTEJvfXfLyQakZbS7LT+1o76CfP7y512A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dts: avoid dpdk resources conflict
To: Patrick Robb <probb@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu, 
 knimoji@iol.unh.edu, Paul.Szczepanek@arm.com
Content-Type: multipart/alternative; boundary="000000000000de8dff064db5fccf"
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

--000000000000de8dff064db5fccf
Content-Type: text/plain; charset="UTF-8"

oops, I forgot a colon.
Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>

--000000000000de8dff064db5fccf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">oops, I forgot a colon.=C2=A0<br>Reviewed=
-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu">abailey@iol.u=
nh.edu</a>&gt;</div></div>

--000000000000de8dff064db5fccf--
