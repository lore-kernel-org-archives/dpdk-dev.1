Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC23C7EE31
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 14:30:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 974F840287;
	Thu, 26 Jun 2025 16:29:59 +0200 (CEST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id B70B840156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 16:29:58 +0200 (CEST)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-6facf4d8e9eso12728386d6.1
 for <dev@dpdk.org>; Thu, 26 Jun 2025 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750948198;
 x=1751552998; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D7d8WL6GvnO6ko+lT7FmzPVIT7blZlt2dtjN1deE2zQ=;
 b=Um16rSDj/FLRlDLRMhRAQbKuqIP3BBtzNKGMC09t+FTzBYMUaSZKWySWXojH+jNZz/
 POXm/UJtlKV0Wj1dYyXNyEjRv3YFQZinHM30PoYAxUrP0Tj/XEaQ2Y8F2CxZGPlS4X7O
 K2MgtJgYV3z8JYkxyzjqOzo9Q/vl3//Tq7BM4CLSQoBF3fx6pXkd+gk1dtn3Be6NDB7E
 s54tIhXwh7raCvdmiyKvpoNIJutMJmkaa3ZyhpMyq19LsWNXW16QuTZupOY166S9kBen
 v2KygRMkNdFLn6XtwOJ4LdeJXwChkNtj/9lSKGIAT+dGxjZkTixC8h6BzVEut3+OCIY3
 HOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750948198; x=1751552998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D7d8WL6GvnO6ko+lT7FmzPVIT7blZlt2dtjN1deE2zQ=;
 b=Vgc8gL2m5uAUYfAZ2WarEA2tPvR1CiEBnEm89jgVTShV0taVf6PITxoHn+7iHujP70
 m5YuQ0XDdXvvfiNc8w38v1o1vY1UTRarppfe4uozqAas+we1jeMXBPjIwvzGkv300Md+
 Ht07BLMDoXQQdqzsQt9jEwCEzr4gDumtME6ClkSVXFPc02pcPdni8MNpMOc7+36pxjwI
 mVNfBbZuZ+pr4ot/KKTwH/rqSCBgL7NPoTL3AhV9vlww2m0pjJeSxjiHV70NLjeuUmsX
 H3W9Klo66BZCIzSbtReekllCte3vSry0YjG/XKnzJIlQhvdOhBXWJe2FWFMvLyLSc1nT
 ECKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcG8CMhxJXju9aPBpSJl3+cBw0dAJZ5D3vMP4b4phB3UqSCioLObMd1ueZEujsfKD/F98=@dpdk.org
X-Gm-Message-State: AOJu0YzdkIDl5NzVDXiutFBbCqRCcAmE7nLepZoKq3j3tWsbS2JeLhq1
 OnqFfXOniIdrqPufNHfpszgpPHJUO2gRFQLFFLhpZ9yv3BoMqJyQKlmw+sQQMvvQ2Sw=
X-Gm-Gg: ASbGncuNb4lwx5DWhF5F9ATLjVFMKmqg3vF+Ksm3cte9YCEsT9Sz+kkuEJCNlztFxfQ
 GSw3SduTClVC+owezgsDzX9VI253sJB5uGuTYi1+3huzpVVLD2YjqrW7xtudOsGK7ZWWzTyqPms
 WaLsqJAypLPy/KZssfbUUd7vusI+eNPC3/8bP6FksV5/56lcedQftDLiJr7+U+fKL3vKmd/cqlB
 eXtyo3p2d+YdfkNlE+CEHs2wWTRoVkk2aYxuGgrSC8vy5Ry7NFtzjRXeroWGd+87oNkKT0j7CWc
 574MoXfmd1++Y3ezpVAsiAfWFoaOupQYYYvDB51BXzOX8ybIW76QDzf6ol0XivFNmN3tOQJS3lh
 oZfwEPJKV14VwQ91Nh+wQFADBJ1Kn9hqULvk1bR8=
X-Google-Smtp-Source: AGHT+IE3yeJOyV7fPFcPyIDwNxcjF2KuOkbvRpt989Fg1o69A4x9mZI/6Spf+3Hb2nzd8sbvDAieQA==
X-Received: by 2002:a05:6214:401c:b0:6fd:ace:4d01 with SMTP id
 6a1803df08f44-6fd5ef9dd04mr123483316d6.38.1750948198004; 
 Thu, 26 Jun 2025 07:29:58 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd772fc964sm7879486d6.92.2025.06.26.07.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 07:29:57 -0700 (PDT)
Date: Thu, 26 Jun 2025 07:29:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bing Zhao <bingz@nvidia.com>
Cc: Slava Ovsiienko <viacheslavo@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, dev <dev@dpdk.org>, "NBU-Contact-Thomas Monjalon
 (EXTERNAL)" <thomas@monjalon.net>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Raslan
 Darawsheh <rasland@nvidia.com>
Subject: Re: [PATCH v2 2/3] net/mlx5: add new devarg for Tx queue
 consecutive memory
Message-ID: <20250626072954.6ca04456@hermes.local>
In-Reply-To: <PH7PR12MB6905F9250E91DEE1DE0BF4E8D07AA@PH7PR12MB6905.namprd12.prod.outlook.com>
References: <20250623183456.130666-1-bingz@nvidia.com>
 <20250623183456.130666-3-bingz@nvidia.com>
 <CAOaVG15O-jY-YJoFpytUVQATJQnDe+saDHD1DQZJD58xFNqhfg@mail.gmail.com>
 <PH7PR12MB6905F9250E91DEE1DE0BF4E8D07AA@PH7PR12MB6905.namprd12.prod.outlook.com>
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

On Thu, 26 Jun 2025 13:18:18 +0000
Bing Zhao <bingz@nvidia.com> wrote:

> Hi Stephen,
>=20
> Thanks for your review and comments. I will add the description about the=
 new devarg in our mlx5.rst file to have a detailed description.
> Indeed, after some review and internal call discussion with our datapath =
experts. We would like to change the devarg a little bit but not only 0 / 1=
 as a chicken bit.
>=20
> Since the memory accessing footprints and orders may impact the performan=
ce. In the perf test, we found that the alignment of the queue address may =
impact it. The basic starting address alignment is system page size, but it=
 can be bigger.
> So the new devarg use will be the log value of the alignment for all queu=
es=E2=80=99 starting addresses. And on different CPU architectures / genera=
tions that have different LLC systems can try to use different alignment to=
 get the best performance without rebuilding the binary application from th=
e source code and it is configurable. WDYT?

Please make it automatic, the driver already has too many config bits.
The users should just get good performance with the default.
If driver needs to it should look at any/all system info to determine what =
the best setting is.
