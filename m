Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE1DCAC598
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 21:14:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F68E402C9;
	Tue, 16 Sep 2025 23:14:35 +0200 (CEST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id BBCB240288
 for <dev@dpdk.org>; Tue, 16 Sep 2025 23:14:33 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-78325a3a5d7so21129776d6.2
 for <dev@dpdk.org>; Tue, 16 Sep 2025 14:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758057273;
 x=1758662073; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2lRBzEAiXKhaiPhpGMyOT24Qe5IAsQheQwliTaZcVGw=;
 b=byAorZGx/bZZV5R22mMb6szQ2aXJZ8GcANnfyG1ukm7jfD1jGLTqPUGsb+Dr7a6ZSy
 zJ8Me4DtD0lvfBfl9gG5Ml1n2QRyxzGerwd8mdxrRRqO5aa9o0Vt08XRW0w5A3yUTUNe
 ffymezB1HX5cAp5f8tO2aEkPkF0eFL+Omww8C8UAxJUTpz6GepnbLBgiIs+9rCmJ0dJq
 ic827GVJSbQHmc81Ni2crkKGT0s7GE1aOathxECdPsYluMbsLJQYINhOxerXQu/z49ay
 1RoUo5GU8u6DDbXw5rPyg9y6mKI3ERWnUUPULH39u9v55sPSmO+cNSv4b6o7JUSZFBF0
 VsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758057273; x=1758662073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2lRBzEAiXKhaiPhpGMyOT24Qe5IAsQheQwliTaZcVGw=;
 b=Sdow9q0JZ15TprOat29jAnhlDhaGOV52rwE2VWsLq9gfJWZgcyGVEyxR5QLojA+rkp
 csGIUC+xcbPn74o7BOnDwYuMDAOACReJNP/05ZfvokmTCU+QiukGbWvWxNwHI10MupBe
 Gi2C1cGUitB9DGo6LET3xV2A7HmGK5MLSC+OVymo9M0ua7p93PAsMkpsMpB40cidLfDW
 ShGngPX/ZCF07ikHW40bUzuyai0qlMUFCRenMiT+IpGsgg+0N7rAX9d3x2RAUYQ26oFa
 gHske4dNeRoKDzcR6HV7EGVtm0ptcbifiWmd9gQYeaXIaajDz8B6bqApbyqo3rmAaZOq
 UHFA==
X-Gm-Message-State: AOJu0YyJHd57huIk1TOdZtE4z1T6B0hD1pf7GSwZBOmM+OvY2WD37org
 EdfLpOe9JuP7aMdbHNz+JmbEOkGcGqBdaiXKwqHYTEeBWVS6wMqc0Cn12NYWER84N7A=
X-Gm-Gg: ASbGncs3Zi74eaSXqaH0i/PJ49M0RulpTTyPKJm5CXJwSTGyXRAzjzdV/WpNEHPmPJ0
 WluDc0tw6jzNuiSpzYDd/QSlI1rrRrGQ+iID8vJbQ0fg81mlXOJXfiHdR0voStstPDCqZPztzhU
 5L48wDuPByd0t1+yFYzvey52QnmTaPA1qRE7MWPyP46oZv7Y2iYvL7sCKjIwS08OuaZzqAipicC
 kBrnVnFnceqEaQsUFVWQTAZ2SzzSRiNUzz1IL4X/7lDbwC1LnuzkiDGzFk1lByZoQ3u0JRkXpcp
 T7FzkAyEtpgev+sDPjz4ZpXKr0/jENwCrDKcBolaalURSe9fiNWx2E/N1wqKaogZ90m7Hmve4u0
 pZGNMwOQG96DW0oM4TsKmBp091uD+JYf1+hr1NVTikhqRrWoZsv1QWKNpxfgwn1RuuNBMyDkMkJ
 k=
X-Google-Smtp-Source: AGHT+IGqFupuiaBIvPXyk3//Rfl+hiljf6zrOiza75NmXwUawWkn1THtSTePS2bmreDEIc/1y38Btg==
X-Received: by 2002:a05:6214:2249:b0:780:555c:7690 with SMTP id
 6a1803df08f44-780555c7ba2mr102267896d6.66.1758057272750; 
 Tue, 16 Sep 2025 14:14:32 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-780f71363d3sm44828766d6.53.2025.09.16.14.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 14:14:32 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:14:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: <dev@dpdk.org>, <mb@smartsharesystems.com>,
 <bruce.richardson@intel.com>, <ajit.khaparde@broadcom.com>,
 <jerinj@marvell.com>, <konstantin.v.ananyev@yandex.ru>,
 <david.marchand@redhat.com>, <maxime.coquelin@redhat.com>,
 <gakhil@marvell.com>, <viacheslavo@nvidia.com>, <thomas@monjalon.net>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, "Bing Zhao" <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan
 Azrad <matan@nvidia.com>
Subject: Re: [PATCH v2 2/4] net/mlx5: mark an operation in mbuf's history
Message-ID: <20250916141427.67caf4bb@hermes.local>
In-Reply-To: <20250916151207.556618-3-shperetz@nvidia.com>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250916151207.556618-1-shperetz@nvidia.com>
 <20250916151207.556618-3-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 16 Sep 2025 18:12:05 +0300
Shani Peretz <shperetz@nvidia.com> wrote:

> record operations on mbufs when it is allocated
> and released inside the mlx5 PMD.
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> ---

If you are adding this to one driver, it means it should be
done to all drivers. Which means it is creating lots of churn
and testing.

For me, this amount of churn and #ifdef is not worth it.
Think of a better way using some other mechanism.
