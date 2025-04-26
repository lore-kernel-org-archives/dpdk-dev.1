Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534ACC369D8
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Apr 2025 15:23:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00B1F40156;
	Sat, 26 Apr 2025 17:23:58 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id ED87F400D7
 for <dev@dpdk.org>; Sat, 26 Apr 2025 17:23:55 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-73972a54919so2841063b3a.3
 for <dev@dpdk.org>; Sat, 26 Apr 2025 08:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745681034;
 x=1746285834; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ry3z2157egI3zEeff+PivHIHY8XSROqy9x6sDvBeBZg=;
 b=SSlQMkNWBC6+LblqEIkmAabPjnDW8uQpae+x45np/gPM3HQ5NK5CAoLY1PoTc/3YMv
 C7/R+ChwSvmGF6AjYcVEbkSI4zgfXkw4MvFTxFMVTMfbCPJJRKdRTJXz6iO+usp5cr34
 YueSi2CXGiHIdcsVqen0QEsoytLQYoh6KV6uxIH8yTPO5boE9hBKGxPdGmnGFjyqYDk1
 aJ+cNbzjYwefrLLK8qdQdVFwwRPcexIq+M340JT862fGz2mK/CJGibVa69NxzNFKRUne
 Ro08Q6PmsMUzSFVDLH2yAH6QcHQAtnt6ArHQjIKuUnnsdx+eL7Tx0mxrwNp6yaK42D6o
 WPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745681034; x=1746285834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ry3z2157egI3zEeff+PivHIHY8XSROqy9x6sDvBeBZg=;
 b=RAuNQLyrfWZ27q5ZzoW6b0/W5wYgJJdo0ZMaHpxea+LaLK3xtpMdFj9qusD2BmUdNd
 gnWbhBdsDcdbkRjWJ4vQDdf8tfMHyPMV570+xPwi/yweRXq3VhljCvKL75oa/FqVoQMS
 Hnh0GcduFXDfHRPG6we7UkMJwp5ryyHLCUH8rNSOsB+2wzl+SpmxP2s1l1LGkrM5B3ok
 iyjby/wCmT97EElHpXLrOMPkmfKiCwFP2MKrpyA4FqaG0eL3WryikTGt0g7vO5jSqgmp
 4V60B5uzspVCF/opJXduwCUOixTvRP8TwGobK2kNCMEitKkl5utciBIG86O708VxP/Sc
 9CkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkYKuzcV8OJ/8L46X2caqq8BinHjewKSSLGeJc9e9z1Lv8UXVUlxK6ilEv/whjDuiuJd8=@dpdk.org
X-Gm-Message-State: AOJu0YxfGZDqeeUMXfsLYqJKEqJP8FC54Nhw5fhmQTptJ1FJX9ZMZRbG
 bsb/v7Pj0b/XyXoIAi5xpAYLdHOMC57IxocmpCrKyynQcgM/kUULQcPleBaA2cA=
X-Gm-Gg: ASbGnctw7V5Oi5hoSiNfMRS0KIYU4paY2olfWXOzSwgWUJVp+sW8Um9q2mEYN1KgoFs
 Jh2mYPzMmEv2tmM+l8+un4EPhe0/qllY93UTnXHhZMJ0ojO1QH15Tza2ewyS827uyFmk4KpV4aw
 nqvWabNSrKsfRe6cp7E6c888ZqtQxVWXfQ0FHufeZx0x66y2tI4xhqVhR2rlLubbxKzK5mOl+jc
 gYkMhTUm4A1U0Mtp9W8yRsiSrn4vuuQWG5VrKG41a+QNKAhLsgFfKEK23UrNkEBkOY9Xkfsr67+
 yj8CdkRiySB/OE5ZBigqBjpa4cXtkb937r1y8yGfJwqJCrhIw7yZMXbO6AG0D1ZV0Y8UfUAX88b
 jZ2q0BKWqk1X/ytbT
X-Google-Smtp-Source: AGHT+IFBlO0+t2D2GL99iQOMjS5srcKllggTeCLE3Px7aD4Qq1syCryEeAa+AtVjBtf7Ew/SRjBH/A==
X-Received: by 2002:a05:6a00:174b:b0:73d:fa54:afb9 with SMTP id
 d2e1a72fcca58-73fd6fdda13mr8192520b3a.7.1745681034598; 
 Sat, 26 Apr 2025 08:23:54 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912ae0sm4955356b3a.1.2025.04.26.08.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Apr 2025 08:23:54 -0700 (PDT)
Date: Sat, 26 Apr 2025 08:23:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <bruce.richardson@intel.com>, "Ian Stokes" <ian.stokes@intel.com>,
 <dev@dpdk.org>
Subject: Re: rte_eth_stats_get seems slow
Message-ID: <20250426082352.260b9b5d@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FC02@smartserver.smartshare.dk>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FC02@smartserver.smartshare.dk>
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

On Fri, 25 Apr 2025 13:52:55 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> Bruce,
>=20
> rte_eth_stats_get() on Intel NICs seems slow to me.
>=20
> E.g. getting the stats on a single port takes ~132 us (~451,000 CPU cycle=
s) using the igb driver, and ~50 us using the i40e driver.
>=20
> Referring to the igb driver source code [1], it's 44 calls to E1000_READ_=
REG(), so the math says that each one takes 3 us (~10,000 CPU cycles).
>=20
> Is this expected behavior?
>=20
> It adds up, e.g. it takes a full millisecond to fetch the stats from eigh=
t ports using the igb driver.
>=20
> [1]: https://elixir.bootlin.com/dpdk/v24.11.1/source/drivers/net/e1000/ig=
b_ethdev.c#L1724
>=20
>=20
> Med venlig hilsen / Kind regards,
> -Morten Br=C3=B8rup
>=20

Well reading each stat requires a PCI access. And PCI accesses are non-cach=
ed.
