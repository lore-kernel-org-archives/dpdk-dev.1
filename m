Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98599606A321
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I710AMxX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 674D540E30;
	Tue, 10 Nov 2026 14:08:24 +0100 (CET)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by mails.dpdk.org (Postfix) with ESMTPS id 50F6740285
 for <dev@dpdk.org>; Tue, 10 Nov 2026 14:08:23 +0100 (CET)
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-4b28d7c729fso1248801b6e.0
 for <dev@dpdk.org>; Tue, 10 Nov 2026 05:08:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794316102; cv=none;
 d=google.com; s=arc-20260327;
 b=kzQk2vMLq4/y+sxC8PASxexIkanYkq1g1PKQiYpbwWb4IYFVkiWD5dD2q45Ui5Z4fy
 Q7p4mNsP4cvMVBPVGaMCpPwplmlOBtCjx9ob3oCEBcIWGI99my7BFtjUcjDfSy5oVGqR
 9UVVHYn2hvxhvgH9sU3L0Pv92sYmXriDVLRGqxLFR0to/40jSWiHtKjwuB0goiaJknfH
 gTnPh5r3PmIIpQvDEknN+LiNTV2oDQ7YqOkt4pvjQoBwxyBOwNxJdIiSlAGr7ApN6/Xn
 2lNjSiaLSby8DOrmk2VtD9H841RdbcCgiolUxtWdfaHUxl5XLgiP6bIJe9OC6gEDtNsX
 cGCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tb1g9dTqpd8JWUuNTlunOpPeaTUzelTmqTBRhm3DsvU=;
 fh=uJxG8AOg/0AnvaqPYEI3OhErrWP9Vwme/AFpVNCEY7M=;
 b=mOzUbS9Uc2xUaugdnD9xAN4GZDV12DzoQnQ2axUahPXfV/wd579twIpe0bazDGBdAY
 iRn/KdEvPyLQmr/+TloVUxJFQwwKqVPLepAkQLycYSmfm/iFmKliiRQzIQkFZf7yQc7t
 bL315rkcua3Q8urG/lQnQADnPTtGsHiDbqMi56CJ7zfWWUp+ugCR2J4B+MA5I5pbrT4x
 XXG4kH6SLGEZXUlcsmcmbmMPyvD/+51n/HUFaRDiSDqUr5Wfq16nPEeCMr6mcXtc2NYm
 bm+JzSF2kJfLcaoHvGoU0WB17rh5x078YVrI34SxXuEnNmYDHz033tNoNceGdJsxkto2
 xljA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794316102; x=1794920902; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tb1g9dTqpd8JWUuNTlunOpPeaTUzelTmqTBRhm3DsvU=;
 b=I710AMxXXwGBl331UGxRtu3jwwaKZWOb+qjnVHmlosnSpyseIa8CAz4ZlI1/GaKIUl
 6rQzhk4G4jtqE4dz1ofPddJ6Rt1x6Dc8dKCxGNvZw7a9ck/1j8JlrjdjeQ74srPXvw9G
 Rjy/7qpt/K582P0xkFsPja6wu7ypI8XYyIsadlbJXvfBqeCtjpG2KPftBORszwwtAq9B
 nQr4OlomzCk/kzYHOtexGzqRRrcUg0/Y0Tc1b3ZCFFxcXUVlCKa6Qn2V/daBKWSLpmKo
 K8DyP8iSOsIEucCJQJIF+XcpCatxgZ19w2bp1ZcEnoKoA5v19k7EY5qaZb6OV0ppp+Sl
 vI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794316102; x=1794920902;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tb1g9dTqpd8JWUuNTlunOpPeaTUzelTmqTBRhm3DsvU=;
 b=smi4X1kCHjIIsv9BIqvmcbeV0wC95MEWt3WKMpkA5Py9JQ/0O8UBD8omYM0biqD6SJ
 ON0Ocs1FneAwa9P7byeWBuUtUSpHiUuLhS8xxnv+ZfHDYLgenhO41tBwT1HbBaNWv5+a
 htt703UHbzPGvOvqdSQGf5+OnYYiox2d49as2tZLgE0kzeVsMjPOdZMaqJQm/cIlxWyz
 EOwL13G3abtqUlajGhJzUQVBFvJKBzyzXzQou9STMwCeqaYcqEfXkynMF1ow/EOF9uJh
 fYc2lThXLjRDHE6vgQqQoXhMNPGMywg5bEkVUrSOJOhBhtpKQyxvNPb8PT4n6HvjH6S6
 hpSw==
X-Gm-Message-State: APuU4Z8cXEwOfT1jhrPleQiBQPYDVfCzwhH8if2ESzlfBhha11jxXhuA
 t4ezcXA/R/xer7bVs3D36BvCCmI1TiQgwb7V/56WrX11I7jSsUzaBt6D1lT+pMjUUWaYEiWxjah
 0c65WJ8kO/Qnv/JjVxPsV9Ji1PXWJ0OY=
X-Gm-Gg: AYBFou0VkXjefGNJ2gn9VmZt+2QO8UnOd8amV+8MfkgaMR14BMosHwpOnL/eeSlEjXh
 3MCtlmxc1W4QOzTsGPrP/G6P0dCRxyImXk9SPbJWVk/QnfSqfXn9Ai2zhpWyaE6ZmxcWqpBsaC+
 1yKOChP8gyyCFcUDkewm/Jjk7Yq3CqSbkXeu9Wc2WjyjFIG0zeHQ0lmPs9/cql6nYGCUBp5fg51
 QgJ8JOBsG0K4Pt5EAC7BFUQuwTlXLyOK36TLxZbXmlOQNq88aGvjBCYd6dFv6tiv/XEWG/Y+jue
 LnjXVg6fC9Ay7wGvfYpvuoTPYEKWRxwyhm91LjVZFMiZ19sSgQxMfphYW9CV+SoDY9ghmY6jgTN
 d1xFf4PPzGgGORIkxTtuL6aZl4cDnvDSQUrdCB2JxAn1mMqC2BZDyo6NgFA0RzU/GD2u54oQhlO
 Nj8MPOL+VNCypiMiX3ch712ybj+eWZRg==
X-Received: by 2002:a05:6808:1686:b0:4d6:9153:2966 with SMTP id
 5614622812f47-5683cd8d36emr1764927b6e.55.1794316101897; Tue, 10 Nov 2026
 05:08:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110062341.52126-1-a.mokrushin@ideco.ru>
In-Reply-To: <20261110062341.52126-1-a.mokrushin@ideco.ru>
From: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Date: Tue, 10 Nov 2026 16:08:08 +0300
X-Gm-Features: AclHuK9y7j7SrS0jTfzPiQ5Zc-bD58WY7XZ2dSaG0WU1d3dJliw9abOex-GIAUE
Message-ID: <CAEYuUWAc2cayCQgdgWDwgs-Yz-yEPBPOPrYikvPyK_FS-MA63g@mail.gmail.com>
Subject: Re: [PATCH] acl: reject rules with inverted range
To: =?UTF-8?B?0JzQvtC60YDRg9GI0LjQvSDQkNC90LTRgNC10Lk=?= <a.mokrushin@ideco.ru>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 stable@dpdk.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I suggest moving the validation up, to the rte_acl_build() level.
Validation should happen at the input to avoid dealing with invalid data later.
acl_build_rules() can use category mask without checks because it is validated
in acl_check_bld_param() --- let's keep validation logic where it is now.
Also, acl_build_rules() may be called multiple times
and will thus repeat the validation unnecessarily.
