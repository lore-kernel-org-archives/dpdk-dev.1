Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993FCC5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 20:18:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FED240268;
	Thu, 20 Aug 2026 22:18:55 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id CFEAE400EF
 for <dev@dpdk.org>; Thu, 20 Aug 2026 22:18:54 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38f0f132f56so970289a91.0
 for <dev@dpdk.org>; Thu, 20 Aug 2026 13:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787257134;
 x=1787861934; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QiEwNionPG7fFNe4vIzCtVhWQX90VhA5ogqOKlrWkTM=;
 b=c962zQPfL88jLjAwa0U4DgbqJZJ/LxPIRxtquYBiog2Kc0g31JZY/156jh+dvgaHQA
 oCqcDFr8t2tGqFvIT0i2VYgDuans7v4xPKJEq6+HqRn5rncqXBnXfhfYeOQZVcFpcDDl
 ee2l/VC25pCwfXAl7ZIiLgcTzUoCTyvWX6rlGP7Z2JElWUPHo92XKq3QzKSIAt3+7TvK
 cSqXp31Wbb1s/xWOzDVI6qTXImsCxKnfuoDdQBAlwr/rGqBAyIM2KMc66i0k4On2XN4d
 cr+4d19dI/9P1rHMpkQRsgEdpHBtNOIjfFJuJuECjNJoUrF77N5YGfpWHfCyA3Maouq8
 Z31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787257134; x=1787861934;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QiEwNionPG7fFNe4vIzCtVhWQX90VhA5ogqOKlrWkTM=;
 b=GjVQkibhKXgWY0jqbU9vCW5M/REedOZ5nHORnXXnYPhsYRkZO/jvrbe9PW6D6m0blc
 GteM5XnVL9Qo/VP6pwmBOozm/dNExx1sCjH71IQtD5W3o/BXY6VtbZV6ciPHDSSFKlC1
 ZhiG6HH/lQIHYQgN3jpEJEO18L2aAbMJs4NyLlrC4UcphplHgW/rKWEPLKGxxD/R0t+u
 oYDwAgThQDIX8KF8zLARU0LpxWbP0GT5RR5f8FlUgFIVnkQKkK2dyLU6/KAMMYhL/ZhO
 vwbR3psRLyOPVdAfgT9NnMS/1vc04IEBr+4bpE+/vIK4ZXYhtVCVTj3iToceNcjF2rlf
 D8wA==
X-Gm-Message-State: AFuF++mhXeDXl5mKzAQ302x7jEy6JddbyvI6uOGF52V4U5QC4zJC9Dyy
 OT1AJ8jQcuzI+wlxVcxsE2qDk/Nsxy+10offwoqJSY5mXq65TqdKrOYbcuojv4FK1w0=
X-Gm-Gg: AR+sD10h0vxr81QKyyufn8pe0MkXiAtG6ind7om7OyzCNBLCEE4HKWXxMOf6DQS0JGW
 PjQl64Ig7Yt4M4m7zkPtpN3cZgbGyWmNsB7RvXMKhI9AdVTUC8PvEN805z4w2UhGUJhl6lPUf+q
 PdwlUIHC18EVapD5KDe6sGgyPHmOwRYwvqahsToCG1s+VtLk3d1M9qoqh+On+N0NqjBUp17kYys
 O0FMgsoJnpNsJ02xcwa5BUGMSTFulFKMpAB67arviepR/ctJRPwzJQ38v2bvyUBKNU4nj1EPhOC
 gUtfsjZtMQOeao3Fnf9sGnje+dFrBoP4WBg/3vVGc/iXSC5vBiRqfCJOCTSg1ROIZAKEHv3ACRm
 HEBGln2CwMAMB/TYUtEIwUKfR4GCxXXXNKgKRz3rXJfEvaGh1YJYtfraiYm7819+ABaf/ok5kua
 Rf/R06duAyIdlvmubsd+YxUqOyMsLpEckUDenK4yN29a2zBf0F/yhztOToyg0anx6zubZNHRjTp
 PAt43hmZsAUWvcmfdvlczg0fdGXtQ==
X-Received: by 2002:a17:90b:5823:b0:38e:c232:9d2c with SMTP id
 98e67ed59e1d1-395c4bde19amr488197a91.2.1787257133853; 
 Thu, 20 Aug 2026 13:18:53 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4be666bsm245735a91.11.2026.08.20.13.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 13:18:53 -0700 (PDT)
Date: Thu, 20 Aug 2026 13:18:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>
Subject: Re: [PATCH 00/61] reduce use of rte_memcpy
Message-ID: <20260820131845.100e3cf6@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F659FD@smartserver.smartshare.dk>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F659FD@smartserver.smartshare.dk>
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

On Thu, 20 Aug 2026 09:31:40 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > Many platforms have no special rte_memcpy() and just use memcpy().
> >=20
> > But many analysis and test tools know that memcpy() is a special
> > case and check for overwrite, bounds errors etc. Therefore memcpy()
> > should be preferred wherever possible. =20
>=20
> I think this is the only substantial benefit of replacing rte_memcpy() wi=
th memcpy()!
> Could we reap this benefit by having special builds for such tools, where=
 rte_memcpy() is modified to use memcpy() instead?
> Then we wouldn't have to compromise on performance.
>=20
> Also, rte_memcpy() used to have a pragma disabling bounds checks due to s=
ome Intel drivers using [0] instead of []; the pragma was removed from rte_=
memcpy() when the Intel drivers were fixed.
> I'm not sufficiently familiar with analysis/test tools to say what they c=
an detect when using memcpy() instead of the copy methods used by rte_memcp=
y().


The most common one is fortify which is runtime checking and part of Ubuntu=
 etc
build. So no doing some #ifdef FORTIFY_SOURCE really is not helping.
