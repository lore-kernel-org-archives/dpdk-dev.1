Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B58C87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 13:01:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D52FA40DCB;
	Mon, 11 Aug 2025 15:01:51 +0200 (CEST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com
 [209.85.221.169])
 by mails.dpdk.org (Postfix) with ESMTP id 65D154042E
 for <dev@dpdk.org>; Mon, 11 Aug 2025 15:01:50 +0200 (CEST)
Received: by mail-vk1-f169.google.com with SMTP id
 71dfb90a1353d-53987d78f0bso1025852e0c.2
 for <dev@dpdk.org>; Mon, 11 Aug 2025 06:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754917309;
 x=1755522109; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sBI/Cp8AuehsVB2bXamIwWB7XTEvmU0EoQZ+TCVJ+f4=;
 b=bncQS8H4GCmtRzBhwzEBJWYtippbdOSGxL0a0awdyMf8sNNFG2spHaeaFk2Z3g6Rg7
 Ww68jCav/UA5DCNRhvx/rV/JBAPHX24X2Y2kM8JGZLzLmSjdxKpo7u03b7cT7c32bDhD
 CLfvjCoFXyg0hm9gY+TGQSUINvDKHeyorG/Zi79w9U9w2aGWAK4nETWFSDC0gxfFdUwu
 hl03Hl2u0ve68BlGM0LKKa1H+bhxzMNyFyUTRFrokC86zwJOIBzgQwP7oSx0e4/Ei5ud
 6TN1q1Hx6YJV4P/q35dKhOPM6vc7RL7+i1DdIpJV3OcABASzW/kvvmaWyo13pIcSli68
 9wzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754917309; x=1755522109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sBI/Cp8AuehsVB2bXamIwWB7XTEvmU0EoQZ+TCVJ+f4=;
 b=Q9z6BHM4qPI+mH0Qnuk1Hpye34m9bqq1HHtBBVQbUDfzuookfbp2kM82FcCFDs2E/l
 mMF5cuh0JSxg0KeBKOymWte+Eda96OauyZSA0/0XirMdtrVAtXkR9DPLBCJvb5+7/QDT
 /PqxyFccxdFuEUmA5svtVBAVPgDMs8oKFRUxQQav4tSuVFyYJUpc+oAla+zcvP3H/N8d
 6pwdkYo4gVL1fuMQIB1ElxSgukFPglNENoik6yjmREGoeF6+7J/Cwq8+A7UEDZZWNgBM
 tHO1RREgXaA2tuU0M+SgMPeiyaJN1KCLpIxiWMminDj71yokzd7A5LZChp449yEXCHcN
 Mg1Q==
X-Gm-Message-State: AOJu0Yw4V7LUQh2yQ9sN4Nh06l66ZsD2maq1GWzFEVgu7EhhgVK+4spp
 A6rz4ON8waPcCzlH6x+5hTwJNA8qoWpFMwiIKFJ7K7MfA+7ww85pkOtiJ2LYMtx9DKr/lgCSAV7
 m46iFC6Whhvd6ETx4WnpE20kVhKfPYplZ6grGuSxpRg==
X-Gm-Gg: ASbGnctpj5p67kBMfjWzUi39DmavdjtcpX6O5cX8HwOtdBz9uIS/UfeAJPCvuMJT84t
 gny7xGCH65ARClr67mMCDuW/EXQxDsfIUoTj56b/Yjx7oH9l5nKraeYxR2Q4QfWObd9SEEz9XIc
 ICpRS6aMWpC4sV9OXDLZR1LR6ZuIUOuStYQK9oHeTgjDqTV9E44kB1N2Si2YdxuZImh1JTAMZ1r
 uon
X-Google-Smtp-Source: AGHT+IHCzxNIIbyAObf76fKyQhJ9xXZEl3dd+geWk9J7MRHr23FJy3X7IVvJDghtmcL+NbaUB3nQy6eL8tmM8y4GXOo=
X-Received: by 2002:a05:6122:8297:b0:539:1154:d12d with SMTP id
 71dfb90a1353d-53a52eb0287mr4119149e0c.8.1754917297800; Mon, 11 Aug 2025
 06:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250721105522.1019515-1-14pwcse1224@uetpeshawar.edu.pk>
 <aJnoXIl_2iNqStfC@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aJnoXIl_2iNqStfC@bricha3-mobl1.ger.corp.intel.com>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Mon, 11 Aug 2025 18:01:26 +0500
X-Gm-Features: Ac12FXw-VpT-KfB851m0Jh_ahr1NzTeuXSNfXfWMsUVkoS2G_A3_lzxlSRD8epI
Message-ID: <CA++2-x4wS_A5Y1FhNUz1Ms6jArZb14Lh1hr614AmT8CDGQFwag@mail.gmail.com>
Subject: Re: [PATCH] net/ice: fix segfault in secondary process by validating
 dev_private pointer
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, anatoly.burakov@intel.com, stable@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000256864063c168627"
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

--000000000000256864063c168627
Content-Type: text/plain; charset="UTF-8"

Hi Bruce,
Thank you for the feedback. We will later see if anything can be done
at this point.

I think that this can be solved by the following patch, please check.
https://patches.dpdk.org/project/dpdk/patch/20250804113322.53650-1-14pwcse1224@uetpeshawar.edu.pk/


Thanks & Regards,
Khadem

--000000000000256864063c168627
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Bruce,=C2=A0</div><div>Thank you =
for the feedback. We will later see if anything can=C2=A0be done at=C2=A0th=
is point.=C2=A0</div><div><br></div><div>I think that this can be solved by=
 the following patch, please check.=C2=A0 =C2=A0</div><div><a href=3D"https=
://patches.dpdk.org/project/dpdk/patch/20250804113322.53650-1-14pwcse1224@u=
etpeshawar.edu.pk/">https://patches.dpdk.org/project/dpdk/patch/20250804113=
322.53650-1-14pwcse1224@uetpeshawar.edu.pk/</a></div></div><br><div><br></d=
iv><div>Thanks &amp; Regards,=C2=A0</div><div>Khadem=C2=A0</div></div>

--000000000000256864063c168627--
