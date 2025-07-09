Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD11C83F0A
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 21:20:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9114640654;
	Wed,  9 Jul 2025 23:20:43 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id D3EBD4029E
 for <dev@dpdk.org>; Wed,  9 Jul 2025 23:20:42 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-74264d1832eso508635b3a.0
 for <dev@dpdk.org>; Wed, 09 Jul 2025 14:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752096042;
 x=1752700842; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q0hZ16Tm/j25pRxeggcBrvG5UXUCstohsBbcZuFjNso=;
 b=tG9Aea9uBYiKqv12Ls2cl+omhAkVCCYWH1BDaJNaSKf0PylN3EqLbU43m1xP89xdXb
 8Lc6XWp1t9o84+s8ng3Sql/5hr6UJRyDk70hpRCQtDc20imwdJvUhkXtn+4cwWuwiWSY
 PDae99Dv4N3WtOl+u1vkHELMCLSJTpWvI0cIyF6u8xAv2r65rjhVdB7GpF9k/3KP9DX2
 ajtNxdhjnpjnWI4ipH1j5dHAemJ02K6zzjvhnMd1pKp8JJLeKGH3FKh5bY9wmqj96Kgd
 BGjyw4O53qTuuKImgnJQp0ySBdOiMcqbfc8QkwEuBDV+ey+RXgxN06YejFwdDXV5BW1g
 0JNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752096042; x=1752700842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q0hZ16Tm/j25pRxeggcBrvG5UXUCstohsBbcZuFjNso=;
 b=ELR7UqCcFHr/3sh68QOro+TWtP9JVa50+PadB4P4avVcxOy7T4CizDOJ4F9RF0XGTc
 bQbYLG8vHy35aGuCaOXs8+/AFS49d7dXdL008MURVSNkhSQ1KOWuVprM02D7/75TWqdT
 hTsqEuw9X/DK52oxtivGY13NJGtABvPrfm+eL7NLOMj8hzVcd5eZ+fho4J5VU6DdVG1s
 PNM8p66jiWzK+oUdw5PzqSbUiFtm/Tf8MwacXTy/1ZwO63vqIesrr0dBNmycIngg0Ulx
 lvqYBGQuZr/2FuhN8MUfaaZG1EH3ZOWE9LEwMgIA9+mCXhp+HQaX+0jUkuo2AtKASpOH
 g1Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2Rsw2sUAuuAFBd/CpO9OGtyTHFcmVuf9cuJL1L1gDXY7oLgNkZSpcBC9Z0wsL3Dwuxxg=@dpdk.org
X-Gm-Message-State: AOJu0YxGdA03xtym26gGBS9GJuo/OCN4h+BTHOgb2jL+vCY6W6T+38Pj
 T4GmN71g96xqHlbnEfWX5NSrhUbi1bK9FpMvlIuhiyb0rpNYIUkqdywEpI95mkzww90=
X-Gm-Gg: ASbGnctHO7f0VlyZ34YopuwWy2f2bNXs288xjjI/70VcZTHKHQusngiWk2jXUjZiUlX
 X1kxuWbbZImfqV2v1/8hcIZEbpXx9PFRqdMzdu5nmrBs6Z6t7yKr+FNY4g/Ks2JyViC+PnXI9hk
 rwVehnbYeVqkD8/+13hJgHS+NBwexHQHMJsxb60B7fA6Lc5HtiZXUdqDFUpzj+yXtXXu3o4ltgO
 4UaP+tT0WMtN9KP4W96pk+Uygg1X9yYihrPLyQYxrAnyqAT0Y+m8Pv2YGt4oXpBscTIzRIgcuc2
 Mz7Pte4zkM9JW65vfBImGoGV0VXBm7N02KKqkL0JSws3+auZfa9Rm5ucUSJpJ0NfGWjoRCmP7Cu
 KGvcpzh41hdqvvpwqkVnq7Tw7gS3drv9OkW3mye0=
X-Google-Smtp-Source: AGHT+IGw+r5DqDn9BcYdTLO9Udk/EO/PD/QHlioD/8/Uq3c+BTtJITfVPN5rlZk8Qub8AH3DnC/97w==
X-Received: by 2002:a05:6a20:3d1c:b0:220:21bd:75c6 with SMTP id
 adf61e73a8af0-2300609f9c9mr197343637.33.1752096041910; 
 Wed, 09 Jul 2025 14:20:41 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74ce35cca90sm16308096b3a.37.2025.07.09.14.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 14:20:41 -0700 (PDT)
Date: Wed, 9 Jul 2025 14:20:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Anatoly Burakov" <anatoly.burakov@intel.com>, <dev@dpdk.org>
Subject: Re: Secondary process access control mechanism
Message-ID: <20250709142039.283dcaf8@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FDAD@smartserver.smartshare.dk>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FDAD@smartserver.smartshare.dk>
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

On Wed, 9 Jul 2025 20:02:30 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> Are there any access control mechanisms to govern what a secondary proces=
s can do to a primary process?
>=20
> Let's say I'm running a primary process, and want to allow only authorize=
d secondary processes to attach to it. No unauthorized secondary processes =
should be able to attach to it.
>=20
> I assume there is no fine grained control over which features various sec=
ondary processes can access.
>=20
>=20
> Med venlig hilsen / Kind regards,
> -Morten Br=C3=B8rup
>=20

No DPDK does not have any access control mechanism itself. But it the wrong=
 place to do it.
What you want to protect is access to hugepages and device memory as well a=
s the unix domain
socket channel to the primary process. For the typical case where both run =
as root, there really
isn't anything that can be done. But if you want security, the DPDK primary=
 process should
be running in a container with only certain privledges granted. And the con=
tainer isolation
would protect it.
