Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9C0C3600C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 13:27:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3154A40EDC;
	Tue,  8 Apr 2025 15:27:36 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 7615E40A89
 for <dev@dpdk.org>; Tue,  8 Apr 2025 15:27:34 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso5868460b3a.2
 for <dev@dpdk.org>; Tue, 08 Apr 2025 06:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744118853;
 x=1744723653; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8GWDzoQ+uu2c+J6CcYrrmimZkb4X/6lL6q+QyTW/SDY=;
 b=QbOc3/XAEOGFyltLjjMGWPAyZswVGn/u2HivWXWN2iRobjo7J/emGsDHS/RDl5TIB6
 jkNo0U2rxpQrRGgkMhnMnTH/0A5HjiKjos6glewwdsaMxofAc4bvfzxc/cL6xF3WgRX9
 5WtrzGS0rrYvuCsHlQEH/9jEByLTINUKfDAvevqLRd60qcv5TI7QgEq3G/+kkD0o2q4k
 2nI8VTnjPLdb0yiXHL8eof/k9D/YZ56SnBArLy6O3CeFmdkRyb1XzEsQaVdJsfDzHAfe
 6fzYhjh3gku8seo6AzMh/kGMBfA6VLNuul3PYH6+HKwFF0AsPu+A/XYD5crA1GazLwCY
 2nyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744118853; x=1744723653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8GWDzoQ+uu2c+J6CcYrrmimZkb4X/6lL6q+QyTW/SDY=;
 b=gudYoFC+bSMeNrzp3RWH3BkkloTlY4t4WVS8AjkKaueD5kOOT5DlTozgQ1IwgKdcYr
 alV0nDIDrlSJ3qpp3D61jWKQa05UV29Mf8dmP8nodmGAv+p18o+2/igYvK6YJnJXNjdu
 G9C1GQui+iGtYeRSsW+RZqvaNOaEi8LBfjO75WJsp+3/S34TyCTklkVf0bGDjzC/PSIb
 VFq9uI/yjmJPaco9wnCKXNULGMXD76Kiz/HRUzcqqVDAv+eu2fyavxz445kdieQ3C28x
 eB3HvlLTBV5Ldz4y2ifmXfO6/4oPM81UctyPW55Aj/gaFPwSNc4O6yZSEBvRHFydtY3v
 N2+A==
X-Gm-Message-State: AOJu0YyusWXz2ljOuHJ6R5891Zd53Wp0Jii7tLmQemmVzzgMi0viy9V6
 RVaeIg+v5rNae5LpQQuw3cLB4wdzOPQaftHduWjOeAWXtjMc/bWgwOXIkBSrqDM=
X-Gm-Gg: ASbGnctclyXEVWZ9yS+ccUOVybqJ5swLXOdS4jtdflGkBaYUOPkfFLbN4qwY2zwoTdc
 zaYUuG+sdl73zvywl6Rd2x4H1gn0ieL2wnUvsvARJScFDCCB0T9UYv1wmRZq5KQkIwKnawXAl2P
 jetD5pTqptg3X/pOTij1J5wfQARF8vwUdinSz/C6MH2QWNj+m8BxoGinWJGuWCs6tnCjA/AUEdd
 1H2uXBqaStj0FSepM5DcV0Gju8eI81rm2AH41BLAMlnkQcmPrL1MXrsOOt01Ns5PjPzcyjSrKEP
 1Na9pH6kZXw6qPO7C7Aa+SzbILTt5/PKZB6Iu5473enCa6HfjkdqnnNZ1LqJmNnM8DBCrXxhvBY
 0+pomk6oiJ+SiePb3/ZEQ
X-Google-Smtp-Source: AGHT+IE4t6Ht4QNA3gM9O4QLu6xYW3h1n2sljVNvaNs5d1Hy3qM4PAyVpyffPvxYS9yHqaF0RJwyTw==
X-Received: by 2002:a05:6a21:9982:b0:1f5:8d3b:e272 with SMTP id
 adf61e73a8af0-20104590ef9mr26057822637.1.1744118853579; 
 Tue, 08 Apr 2025 06:27:33 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0b3feesm10779109b3a.140.2025.04.08.06.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 06:27:33 -0700 (PDT)
Date: Tue, 8 Apr 2025 06:27:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: =?UTF-8?B?6YOt5pil6Zye?= <cx.guo@samsung.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, =?UTF-8?B?5byg5aOr5Lqa?=
 <sy0705.zhang@samsung.com>, =?UTF-8?B?6YeR5piO?= <ming83.jin@samsung.com>,
 SRC-B Security <bstsecurity@samsung.com>
Subject: Re: Inquiry About DPDK's Roadmap for Dynamic CPU Scaling Support
Message-ID: <20250408062728.013a5b61@hermes.local>
In-Reply-To: <20250328033731epcms5p1393d177ee4de90debad11e9578e758f9@epcms5p1>
References: <CGME20250328033731epcms5p1393d177ee4de90debad11e9578e758f9@epcms5p1>
 <20250328033731epcms5p1393d177ee4de90debad11e9578e758f9@epcms5p1>
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

On Fri, 28 Mar 2025 12:37:31 +0900
=E9=83=AD=E6=98=A5=E9=9C=9E <cx.guo@samsung.com> wrote:

> Dear=C2=A0DPDK Team,
>=20
> I hope this email finds you well.=C2=A0
>=20
> I'm writing to inquire about DPDK's future plans regarding dynamic CPU in=
itialization support, particularly in Kubernetes environments where exclusi=
ve CPU Pod scaling is being enhanced.
>=20
> Backgroud:
> With Kubernetes upcoming improvements to InPlacePodVerticalScaling for ex=
clusive CPU Pods (Guaranteed QoS Pods), we have encountered a limitation wh=
en using DPDK:
> =E2=80=A2 A Pod initialized with=C2=A05 exclusive CPUs=C2=A0can have DPDK=
=E2=80=99s EAL successfully bind and utilize these cores.
> =E2=80=A2 However, when the Pod scales up (e.g., adding=C2=A02 new CPUs),=
 DPDK currently lacks native mechanisms to detect and initialize the newly =
allocated cores. This forces us to either restart the Pod (causing service =
disruption) or leave additional CPUs underutilized.
>=20
> Key Questions:
> =E2=80=A2 Is there an active DPDK roadmap item to support binded and=C2=
=A0initialized=C2=A0CPUs scaling up and down?
> =E2=80=A2 If not, would the DPDK community consider contributions in this=
 area, especially given Kubernetes=E2=80=99 evolving CPU management capabil=
ities?
>=20
> We believe such functionality would significantly benefit cloud-native NF=
V workloads. Any guidance or references to ongoing work would be greatly ap=
preciated.
>=20
> Reference Link:
>=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 InPlacePodVerticalScaling=C2=A0Enhancements f=
or=C2=A0guaranteed pods:=C2=A0https://github.com/kubernetes/enhancements/bl=
ob/master/keps/sig-node/1287-in-place-update-pod-resources/README.md#future=
-enhancements
>=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 A PR to implement=C2=A0guaranteed pods resize=
: https://github.com/kubernetes/kubernetes/pull/129719
>=20
> Thank you for your time and expertise. Looking forward to your insights.

I have seen no plans for doing this. It would mostly impact the application.
One way of doing it now would be launch DPDK application with max possible =
CPU's and instead
of using remote_launch across all workers, be more selective.

It doesn't make sense for DPDK to grow direct access to Kubernetes API's.
But maybe the kernel API for hotplug has something.


