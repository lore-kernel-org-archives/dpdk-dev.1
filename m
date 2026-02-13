Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE5DEF99CB
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 19:16:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 446C0402C0;
	Fri, 13 Feb 2026 20:16:44 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 8CD9E402B2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 20:16:42 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4362507f0bcso1017761f8f.0
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771010202;
 x=1771615002; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AfOz/bV6jJw2u3j6IsdFg+FYf3i5PIR03Brgdoxk3C8=;
 b=G53z0Z1wC6gFxndeAmH6GUOZCVf7ykb7uut2IB6YPYYfsSsKJeDr9T76GrYXrgutk7
 UHMxabwUAWdM/9nXWK1iRnl4GvpGazZjv9a+tw7pES2HHj4D0QQ7oNjM1/uJb3aNdIS0
 H61vvyX0kbMylTr0ARWzj6mXqbBh1NWQ161MKpo1OrGNDVcFCAk0nJhd6MpbsIVBUI7B
 syriX8j0T8lz2fkqXPfVT+kaVGT+Os3rtaSA/wwJx8DHkbu+6Zq3y3dfQ75b9iGsI0vO
 hLVti0U8mfjGdggWRX4QgUi7H3WapbuVDjYFeVLebrcX9+F32fEsEKBVkBNA+iNVhkq4
 8ZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771010202; x=1771615002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AfOz/bV6jJw2u3j6IsdFg+FYf3i5PIR03Brgdoxk3C8=;
 b=bLSmi0v1NC7G4hovAEzkrStkDdG1uh+ta8bajngrWl05eos9luokFTpa8Ew5Bb2oN9
 rEfOKdEj8zqeZGsV2RuFcuRL9gAzVX03CHm/AWy1kSDAYzL64Qkv2fBms3/wn0KGUd+d
 FjV8iEJWQMYs59/DdTCstWh7mci/mmAc5PKgApsoucr8j7RLjgSVVCYTbKOSfr2sK9gC
 ZR/SmdZvMWtTeO3XknHdaxlXZYqQVYDMYPfRAViLyS21ud0ffE1aWeSRS8kMbsed+gyK
 fOryM8tjzIl0wmr01WRu7mly4ZSVeL1n4IgtOcFt4VGWGNLFmzjn5i/HxKRZ7MiJzwG4
 u0vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU/q2GfTM++YnI8tdjMGdDju0ClO4xmvYXSIJiMrPM3Wtfk2csH1JLPqOIuzArzDquZ+Y=@dpdk.org
X-Gm-Message-State: AOJu0Yxzs6Tm94GVIuNeLYWGs42+PTfbMoJnf02h1ptwpIU4ImCYl7Oh
 6YZ/cd6Cj8bzO4aQn3JSq5dmx5oS28Hcy/CWhDACVhOnm7jmJ+vNA82/6o597SWhtRY=
X-Gm-Gg: AZuq6aLm0YQRKmbgyeI4Lj/wbqjC2lWZerJV1zVVsn4MEcriQGpYltpBQjcZ/CL7/XV
 k78RyhYDSnupX3STRyQJDPlHVBIwGRQXR19xqnIU5szaH+BxTc3Em0fl4gtwHKVH02mlKPNbH5n
 SfbozRqXrKoXSWJArljFY8i6HhKDg+Oqf8fjVHFtwXdq6gKBvy8gG5RRNpp8+0H4nsyaSG2AXJ1
 LrizOEnUfpnZfbIj3gbwvsr2OF29Llcv/uXMYAsHPS+owkQF4U7YQ5Tkar+T8ukorsAPUCvFU3+
 WSbJADzGIvwPEHc7pfJVfLR6DAtredoHYt1q2BrKC4rp76qbEwt9s3XB75P7wPqe4j4c9pQSDAF
 yXD+n+wN/0pJBLa1IwCK89GFVIARGjHfkwky3ydZoMiIKyDiNqpgz/dU1tlNC3LFyrY+C4sjPkE
 iIbHPZp+WfY1vF3KJNSlTGJaCLuWifVNKln13iwRKBXaKzY6gvzQsKADscWu3k8jvg
X-Received: by 2002:a05:6000:288f:b0:437:7010:1cfd with SMTP id
 ffacd0b85a97d-4379d5db5a9mr2580006f8f.4.1771010201983; 
 Fri, 13 Feb 2026 11:16:41 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-437969fd36dsm7768611f8f.0.2026.02.13.11.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 11:16:41 -0800 (PST)
Date: Fri, 13 Feb 2026 11:16:36 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: =?UTF-8?B?THVrw6HFoSDFoGnFoW1pxaE=?= <sismis@dyna-nic.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org, Ori Kam
 <orika@nvidia.com>
Subject: Re: [PATCH v10 3/6] flow_parser: add shared parser library
Message-ID: <20260213111636.45d01a2d@phoenix.local>
In-Reply-To: <CAPQRu6EAKR59BGgRFAr=eWuQr+=3z14+xdCkbZMvfhM5K8bN0A@mail.gmail.com>
References: <20260202113659.24052-1-sismis@dyna-nic.com>
 <CAPQRu6Gb0tMH6f-5T7_vCVK23mAkEOmXn-T+X_DYaWsNZdYtjg@mail.gmail.com>
 <20260204065338.0fae67fe@phoenix.local> <2762564.TLkxdtWsSY@thomas>
 <CAPQRu6FR+RojmsKhcsegastxJHLBAbmtx5Qurg79Wn_w94yYpg@mail.gmail.com>
 <20260212164341.074639cd@phoenix.local>
 <CAPQRu6EAKR59BGgRFAr=eWuQr+=3z14+xdCkbZMvfhM5K8bN0A@mail.gmail.com>
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

On Fri, 13 Feb 2026 08:46:04 +0100
Luk=C3=A1=C5=A1 =C5=A0i=C5=A1mi=C5=A1 <sismis@dyna-nic.com> wrote:

> Ok, I can move it there then. Should I proceed with Patch v11 - that would
> include moving the ethdev directory and addressing the kernel's checkpatch
> issues?
>=20
> The initializer doesn't seem like a bad idea. I didn't know about that on=
e.
> The parser_ops are not needed for purely parsing, but to remain compatible
> with the testpmd's code, which is using, e.g., the hints on the commandli=
ne
> I added parser_ops.
> The simple public library API is for converting strings to rte_flow
> structures,
> the parser_ops is for hooking up the testpmd.

Testpmd can change as needed.
In general testpmd shouldn't be using "special" API's; that would indicate
a architecture issue.
