Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97A4C44536
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 17:41:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B26542E00;
	Wed, 21 Jan 2026 18:41:38 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id E0B3B40261
 for <dev@dpdk.org>; Wed, 21 Jan 2026 18:41:36 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4801c1ad878so1216085e9.1
 for <dev@dpdk.org>; Wed, 21 Jan 2026 09:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769017296;
 x=1769622096; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1v/aTgi9CU1rXr89vnNK5+j9xgocwTIs6f6xWEfLhU=;
 b=v9aL2Jpn2W7+cLa24lt7tiWJGe+XWMR7HC87CTwNlYqcpXc1W3UxQuNUeplu90SEmJ
 4+Bzeo3Emb96vHp5YqlTUe3HYWV/VS1gQ0eVhx2X76DC6Z0UlXIMbbxttITWTAG6GnbN
 M9UtPnaRpjOeHwmF49YKLmtsGiKqB7HHkQJZJ+bWJTT5w10x4wcM19/ZKJrwdX++iuep
 vXnd2E8hIkm1/0mfoe9usJIsQpP+oZfMt3IiIEXjKGAZms7x05VMZYB3rJpce/PFti+I
 ybW6uuCoU7W7TLhaLnlX28BVlKsBYEMbMRgJxSHeZhRqlOh3XA3raZpsEuxfj9B1Q/aX
 WXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769017296; x=1769622096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I1v/aTgi9CU1rXr89vnNK5+j9xgocwTIs6f6xWEfLhU=;
 b=gC4sDcO8iA7P33lv0oGvlWoEilE3IasaxoqPit7ZZoBsGrKLxvfRUbBqhvmvj8nbz/
 7gkbbml+VBYoC60i1YST0Of+7sJKXQ7x3c5vxDiLkBJkAsRO99Rxc+ZEo2T9MnBTbySQ
 HvcdAPpcfDuYFDtIsFuz2LHM+GC+ImzKl8U2Usf1kSrg8XZ3B6WsrIjSlNJ6ZEEWZivr
 JS7rYDDCkJr/vKPYaYYC4jenh2LWSi/fCsh7Toh6x/LQ+7TYPaB+s8vXzi1f8du4UaqN
 WGXJNZjPWfj0XSjYhYot9IRMOXzSuNG2rGfH5D8pMF0lRgnbj7wlZfjZ+GjnNJsk1aGx
 0UOg==
X-Gm-Message-State: AOJu0YwoUD8GYXjHmusVQAPCxF7q/xX7Gd/d2c9GoKyZFJK7KeOyMbWO
 8qV3Eokb7N5HXxXFYrXBAZue8yYSh+BNuqiigN/flcT0ciXkcIt8tVzhTDEgBrN0YYtbJsFRuFP
 PaKrr
X-Gm-Gg: AZuq6aLdVhfHfRSyVXfiGJoBFL37khTGfe2Wu4fj/0IFNiQ1w60ar4yycWlH4z0KDJY
 aaN+nl4hzfrZoywqzfwAkcRlsZEXnvQwxwISwgEqb1makD7zJk6x0oLQutEm0whyQfJIpRyyOTs
 a4fYrliZh4BULIEBK/pwPFvH6VSBNNO5dBbj0a9ileZgTJCJELx24iSA5BZ3n7/78rlrybxcqWe
 l+n+U2Uo3GEUyetRn3J2UwrR4LI8EBK4KCK4aFr4uwy5bF0zrGCnxxotUQqxXuTyBt3FdoqJDtA
 PDmTxNhpb7c8jIZempLoUMhIZOh5zSvvNS/7kEYU0s1z2Oz1mSWy1hNAKrql6g2fO/gMS5agyiq
 45N0hY91aeZQl/3lHjCYPtno/ie5yYr2m/srSzfRqCE3cjWEMMAivjlzn/BG8zUfUGc943oKdSh
 1cEk3WxUyELYn0tEmGKFsaP1b1UvUs9t/oGEdbm/WIjO+zH4nS9fdZ
X-Received: by 2002:a05:600c:4695:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-4803e7900bamr102856765e9.8.1769017296391; 
 Wed, 21 Jan 2026 09:41:36 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48042453863sm30491715e9.0.2026.01.21.09.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 09:41:36 -0800 (PST)
Date: Wed, 21 Jan 2026 09:40:36 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 3/8] net/nfb: add vdev as alternative device probe
 method
Message-ID: <20260121094036.3f3265e6@phoenix.local>
In-Reply-To: <20260121170333.272985-4-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260121170333.272985-1-spinler@cesnet.cz>
 <20260121170333.272985-4-spinler@cesnet.cz>
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

On Wed, 21 Jan 2026 18:03:28 +0100
spinler@cesnet.cz wrote:

> +			/* Clone non-vdev arguments, result is shorter or equal length */
> +			ret =3D sprintf(dev_params_mod, "%s%s=3D%s",
> +					dev_params_mod =3D=3D dev_params ? "" : ",",
> +					pair->key, pair->value);

AI review raises good point here:

Minor style note: The sprintf() call at line 897-899 uses dev_params_mod bo=
th as target and in format string. This is technically undefined behavior i=
n C, though it works in practice. Consider using a separate buffer or snpri=
ntf() with proper handling.

Verdict: =E2=9A=A0=EF=B8=8F Minor concern - The sprintf(dev_params_mod, "%s=
%s=3D%s", dev_params_mod =3D=3D dev_params ? "" : ",", ...) pattern is risk=
y. Consider refactoring.

