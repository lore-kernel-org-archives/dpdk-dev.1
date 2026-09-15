Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB84C88E73
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 08:57:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B37A3406A2;
	Tue, 15 Sep 2026 10:57:15 +0200 (CEST)
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by mails.dpdk.org (Postfix) with ESMTP id 50169406A2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 10:57:14 +0200 (CEST)
Received: by mail-yx2-f12.google.com with SMTP id
 00721157ae682-85d4ddd17a0so24146517b3.0
 for <dev@dpdk.org>; Tue, 15 Sep 2026 01:57:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789462633; cv=none;
 d=google.com; s=arc-20260327;
 b=E5JP8jS5DHF8BCmSIcGXZVbAO8xBC7NjM4zUJ+N7O8rgUBGbqaqrgOF6ZQwGrWqjs8
 C3Hmm3dcJySRF/a6MdWs3+cBrL0G1uKJxPLve9PWLnfSOe1AP3a4eOJ67H2wjoEjEYPw
 tCmQo4c66jushbNA3cwzVYIVOMovgZ8zx3PBceta50d2fjBD7OVn4GIy8Pvi0btIGzWF
 Lzx55N2qv1gkyLuRsa4k7JM/EHYoh8lgRr4S2Phzz8VeHBBJc4ujos28KAznKGH6WKDj
 KanQKKrU8HJPHHcUxLMTQc2yy5WBwhDUsoe0dpkPbOIw7zu3IJsygeCV1/6LTqRYl2oz
 RV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4a/ugrL+pwcLvseV04r5HlZkxmmTYeotwmpw+cBZiFw=;
 fh=3jhLaMuF0cK9B93rD7/XDxDEn7MzkwNN7QeYn0h20k0=;
 b=FqT12WoThS1/44V529F8XyzLpejzqBtqnkbLTCRyyMOQjI6u/5zHcAgq6l+bf6VKb5
 MgorDSdQid3IRabL9USupRxzuvDHSIQo+6S8c3HsQFPvdwyvAGZ2CHv2DpyAnYlzFAk+
 8eOCgCS/mWd9Be4MqUPLyaeX9sxNUhfNabbFUP+DQydX3pd7Vtz0LsfSXKvL0SDh2pvX
 dPVdo2F3tG5oeyQxZ0AzmL+B5QDyp8Bf7uKt/xIJbRbN0htpSSXhhHW2EBMkWCNYrGLu
 X9/TBR4MEAgvJTaP8Q/sOaeWY7UhH5YU6m+SatYq+aHkYGOB1JFxXPJ/P6o48cGt1On0
 vEZg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789462633; x=1790067433; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4a/ugrL+pwcLvseV04r5HlZkxmmTYeotwmpw+cBZiFw=;
 b=CaVpHUveiFLaV+ehOuTokse5yha5qSwISnuGItw5tNN+fhrRfM2ReFSQj7ULDbNX1X
 iSDlVLuab6pJLHrJTncoHDfqor1HdV3b3fe3kt8ID4ndm8deT7TYKlRUByuUnJ7/yrRr
 aRGU9IKMLnK+1K/66v9CpD2IPw5MQiX39FI3qgQbXDH/kf9w7ejgKixN0jr0z6n1g8mU
 /7nwgvx1iuBOQMjwGq+OKh2/AACsf+ynNXaB+x6nhOR1UEm/rdYWyEavfdWFUS7pddc7
 NrpJV4CMnas/aZ4LShaDXOs+Hs9STAT3hySSw5r/aXe7Gd/Z4nap6pN2n0/jkbpn7A9j
 zgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789462633; x=1790067433;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4a/ugrL+pwcLvseV04r5HlZkxmmTYeotwmpw+cBZiFw=;
 b=apiz/ng2d8ASa6LrxxnM8o/kyc+GSm4WCQ9dcuzLqPfsrDodol5LaG2EGKOyItvYVs
 CTflciVsAVcIMrKNp5f/3lVjYPW7fFMWFpVMZZIXI27AaAweNpVjcm4C4xOvEZdF5O05
 doDBU735coGHEd/ZQRmIb2ZNQtzHMqN4W24pZSmqUeVCs0LmWItFNas93UHir8CgP+bp
 aTKzkcXKX0cjWMDcaLnRVLN1Gtt31oig36IpSGqhsojQDTD3byDkX1DHmTnw1ZuCLFrz
 bdYMRawu1qahr84Dwu9o/MVIMf49pOs0R5YxNXuJMEq/PNmeyZbEkMtH0m5G46NpIHj+
 V7zw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjnHxUlJww8Q4CcIZ1dDjXvNUcIb+OtvogV3VJA1/Ms7/Jfj3mr81X3YpQYyM73g9AtQo=@dpdk.org
X-Gm-Message-State: AFuF++lWG2yfeAx3yYmsoRpcnKX5OCODelRBdXG6wX5wCBNLeEo9ApKA
 9Ebb2CdSN88u7QtyBPcaDlWIK981qMsqajxYb2MkTZilENmHe4rkotp2T3f3ZkkKKyUtOM1E5Oo
 e/e0/r97smPFBlio5f20KasqtheGA0wc=
X-Gm-Gg: AYBFou03Wz19WeW2bBLRXkKYbnvAEpa5AMZ+iYxWQ6ONaPHFjBatDJW8hhmOH0a8WsY
 U3+uks7W1oEqFXXGke1UfczxD5lLCZYCrkhZiIUlUQ7fFM1MMoZ7tkgnEbQcfXhnT+8edhSUGtT
 ALAZYD9V9dvFgTpzj4ZJ7zwO8XpAFKQRlWqgMWUrrhNniJSFEFDTBgZK4wYzpx4PGD4+R99Z1s1
 yemkG/OKb6XRFiECnW8ygisFHe389XtE66vLIu35r3/AncuK6HUymlcpvmFahqQZ5rf7wkfkHxm
 iDmka+RSGrmDnYLMh2XwwRBU1qxFazhR2+VUOOp2bGSk/v2PyJxguEfh0zUQCdUiNYugPhWfpB3
 HdE65qRO1Eq2GlmEvng9f91K7nNK2TjGs53o53A6NT+K7lH2HpI4TwenytWYU2LIlTte+0IneC9
 5G+np2pYmroK/dU9rJ
X-Received: by 2002:a05:690c:e284:10b0:87e:2404:5c46 with SMTP id
 00721157ae682-88d1fade932mr21706757b3.12.1789462633644; Tue, 15 Sep 2026
 01:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260904092157.51040-1-amiyaranjan.mohakud@gmail.com>
 <CAL+mCpNCdJDJN77BFwFP4bK887xsRDtid7HxSZ=3yapW5mvNsQ@mail.gmail.com>
 <CAL+mCpOxM+AeN6ehfr5vVwQQ=1KSv8uivEC-Ng7j3tQ58cjbLg@mail.gmail.com>
 <CO1PR18MB47962DFB9B96FD9E2B86F8F6BFBA2@CO1PR18MB4796.namprd18.prod.outlook.com>
In-Reply-To: <CO1PR18MB47962DFB9B96FD9E2B86F8F6BFBA2@CO1PR18MB4796.namprd18.prod.outlook.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 15 Sep 2026 14:26:47 +0530
X-Gm-Features: AcwNN1WcDqVkRyefJsVyGLSD2G8bmHXlzpdFa1dJuk4kxEg01x1Qx0kNP8lXwQA
Message-ID: <CALBAE1PFgynxMV7hk5wjbf8Zdb9YMeX9qMuAqtss_dipHSNjhw@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH] common/cnxk: fix duplicate mbox alloc in
 NPA aura pool init
To: Ashwin Sekhar T K <asekhar@marvell.com>
Cc: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>,
 "dev@dpdk.org" <dev@dpdk.org>, 
 "stable@dpdk.org" <stable@dpdk.org>, Harman Kalra <hkalra@marvell.com>, 
 Satha Koteswara Rao Kottidi <skoteshwar@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, 
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar Kokkilagadda <kirankumark@marvell.com>
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

On Tue, Sep 15, 2026 at 1:18=E2=80=AFPM Ashwin Sekhar T K <asekhar@marvell.=
com> wrote:
>
> Acked-by: Ashwin Sekhar T K <asekhar@marvell.com>


Applied to dpdk-next-net-mrvl/for-main. Thanks
