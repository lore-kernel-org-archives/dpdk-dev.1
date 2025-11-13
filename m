Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C49CD8CB0
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 17:50:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37C2240E4B;
	Thu, 13 Nov 2025 18:50:56 +0100 (CET)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by mails.dpdk.org (Postfix) with ESMTP id A2AE040E21
 for <dev@dpdk.org>; Thu, 13 Nov 2025 18:50:55 +0100 (CET)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-4504458b29eso435266b6e.3
 for <dev@dpdk.org>; Thu, 13 Nov 2025 09:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763056255;
 x=1763661055; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mnKDErVQ+YG09GyWiL7Omc32wmV/ekyfp8Jqe6Ty+a4=;
 b=P1V4/BGhG3vSny570OAuLn4CVsXmB/NT8Z3vDQv9cL+IRY1sQf5GkObN/5FcYSMuIf
 ejRTEVnTPiAt6YWlPv12nyW+Brw4ic1DyTjhKrX0mgyYCVcRDYcIxDHWiB4aHeJNyr4E
 NH6M38kyk4qhdCvK1Ci+8M0nNJHPgMZS/AgTyCAQa7VcJdR2UFv3Z/gpMst/9B+IiarE
 n6zcR8O1VZfBxpZF38ZjfGBvw6Q0ErgraMB9OC/IuWGLM2WA8pZTh1LnLko72jEnvBW5
 YPWSCz9b/vv7v4w0Ji5NKhR5CyzWIkK+eaQwNKFVzUONItBi9xubNldpg7dYHijd2Bjs
 lGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763056255; x=1763661055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mnKDErVQ+YG09GyWiL7Omc32wmV/ekyfp8Jqe6Ty+a4=;
 b=kE7kFIVV0AZu5LiI4tqPH5sPJ/4ja2TKdSBJRMdY1E52XzUaith+oiCQHh07P02vR2
 fLzBRQ3YueZwOOFi/9CEsSathn5I7M58X23iPmyvmX+QqPrz7iK4U+rCrduq96oLsQoI
 aKQAvaQ8rG33zGmZ+Pi2WlUgVQO+/W4Iuns69K3WeZuBmB5BNOFDX5cCPlBqYZmlb049
 pbrG4yvjnHsyVTFC/+InrZJSqMO/8ySmn/Q7nCQ3q4Qiyr0DzxAXwdEyeFBbUgES+WP3
 p1qSQGcVQjcu3pxXOR2IH9sABLRrMMpR2Fkk3K5AGc2pj3EHymTjQmefUMoty0FYXPTq
 rslg==
X-Gm-Message-State: AOJu0YwNSdWkLde/FQJhp8SshGgAqjdDpkBGlTKURbviJEXu+OSC0gN5
 ZXdsyRwisJv7CCRgIH1d/ri9S6YYW7u8Fs5mfZLw3NP0juyPirwOcUV+DMVPrRL0c/+cmruiVb3
 z7yxl4XIp/Q==
X-Gm-Gg: ASbGncswNY83CjLORWPokUXzEnDp9b/tzzqMv3Gr/imcirZs+lRpGSPHflbng5OUQg2
 /u58tGjFTnONqyzvnPooq10aWn4ZAfYDdkY8mySnxlFrk//5W8jIo1NWSqhB1W2yepDV8fiMtoD
 GpTOb5sC0AjQFbaOpzW7AQ8cOad4kWyhLxl8i8Y1Nb0ZbIwE+97QcQuy/INS8l1NkyDFnz5/jdE
 OgSZonsm+PgQnAPzwPXCwRq75G9be2IOdhfwyIgU/Fb3nrKbVlV+uhr1PVs3p2kgdZUYHmfEH/R
 ij+8tfCCB/B3tV73ugVk5XoHRDTKhOjqPmRvIbkw077xJAavzuwYLtg/XWk3LHOZkwGCC0Sg6z/
 RsTOyGD5o1xgO0XJOCTLS6K3hxcZObAL5Uraewcv6ILpEr1W6pVhuQcIiP7rDvvNpM2Mx3NAsQh
 KguP2dcj3j0L7RsK2hvP0BPdjjBv04vdnUArtYAstH1MjO
X-Google-Smtp-Source: AGHT+IHFw97Tg2XUzPWxpgpfpfyTfsssN8SFngf7RIleYqTdU7OALPXcJPhR2zm+74HcZz3zl0DhGg==
X-Received: by 2002:a05:6808:6713:b0:441:cabe:907 with SMTP id
 5614622812f47-45097349b60mr60038b6e.14.1763056254811; 
 Thu, 13 Nov 2025 09:50:54 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65724cb8732sm1308160eaf.1.2025.11.13.09.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 09:50:54 -0800 (PST)
Date: Thu, 13 Nov 2025 09:50:49 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav
 Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Ophir Munk <ophirmu@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix uninitialized warning
Message-ID: <20251113095049.008bbf9b@phoenix>
In-Reply-To: <20251113163301.285550-1-stephen@networkplumber.org>
References: <20251113163301.285550-1-stephen@networkplumber.org>
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

On Thu, 13 Nov 2025 08:33:01 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Gcc-16 detects use of uninitialized variable.
> ./drivers/net/mlx5/linux/mlx5_ethdev_os.c: In function =E2=80=98mlx5_link=
_update=E2=80=99:
> ../drivers/net/mlx5/linux/mlx5_ethdev_os.c:539:15: warning: =E2=80=98*(lo=
ng unsigned int *)((char *)&dev_link + offsetof(struct rte_eth_link, <U38c0=
>))=E2=80=99 may be used uninitialized [-Wmaybe-uninitialized]
>   539 |         ret =3D !!memcmp(&dev->data->dev_link, &dev_link,
>       |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   540 |                        sizeof(struct rte_eth_link));
>       |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/net/mlx5/linux/mlx5_ethdev_os.c:515:29: note: =E2=80=98*(long =
unsigned int *)((char *)&dev_link + offsetof(struct rte_eth_link, <U38c0>))=
=E2=80=99 was declared here
>   515 |         struct rte_eth_link dev_link;
>       |
>=20
> If the retry loop exits the code would do memcmp against unintialized
> stack value. Resolve by intializing to zero.
>=20
> Fixes: 1256805dd54d ("net/mlx5: move Linux-specific functions")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

The build fails with clang because of the (annoying) use of pedantic in thi=
s driver.
I will let mlx5 maintainers fix it then.

../drivers/net/mlx5/linux/mlx5_ethdev_os.c:515:33: error: use of GNU empty =
initializer extension [-Werror,-Wgnu-empty-initializer]
        struct rte_eth_link dev_link =3D { };
