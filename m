Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FC2D46BE5
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 17:40:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44A494026F;
	Wed, 28 Jan 2026 18:40:09 +0100 (CET)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com
 [209.85.222.42]) by mails.dpdk.org (Postfix) with ESMTP id E0FF74003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 18:40:07 +0100 (CET)
Received: by mail-ua1-f42.google.com with SMTP id
 a1e0cc1a2514c-94803734b11so70323241.2
 for <dev@dpdk.org>; Wed, 28 Jan 2026 09:40:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769622007; cv=none;
 d=google.com; s=arc-20240605;
 b=C/Ttg6CWdVHVvZNm9BXaS22d/OKakPRblVrUfFPKSsgLuTf+jpQgE7TN1s4JGJtNDg
 /vZ3Rdq12DgOveTryGDKiSMVjVPFjoBMyVQnI3rVsEcZdYsNBQSswHyr54W89hFKR85m
 m/xWBiVgeRHUm2DPWPjyRiu90XiYuGf1anrAFqtkcIMR0wyzBCWwQvbCG02iA38wNLN/
 7UgGveh4QUoGtgF7qXi5tbDM2wqTezOENTS+QJTW4TjEJ2HIitbIMVEQzBDDMJ2VBkaa
 Rb/eMJRvBVQ65pB3B+v3xOhdfr+6GxeWIlqQebAYxVJVj4bkX1hswbnaLgYFe5L4+s8m
 LMXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4UrVayZoHw4uVjWZcIRnhTHFkQKeVQ8sRva2hQqPjzA=;
 fh=NYG0V0oaGpBTZNcqqw0KE150BBo6RcYjlZZTwwt0oNM=;
 b=EcDa2s0qIIVUd9dLHAjLuE+Jh4plBU9KJrzJMZcbuS7jqDQewHM8CIP6OsyI7Cd9zn
 5wgT7kxX3uO7OgpT9wRU0h85MRl4wtkNHJa33GlRxUnFUISfp8sH6ZwKXLppg94znzKG
 GAnp8/Fnot4+l0BMRPEQnqfUF7CPlKXGJgWDVrYK9TNHXtFJJRpownk1fjsq87KkTyP8
 NkZ03td2Uo0SaLC9DkgLFFysuCtXpczISr2UKlZ7n84sKvzng6vVZpWGoaaIlmW/MgoS
 UUp64wy0Hg6zc8PmY8/EA+1aZQ2ns1Z03O4ZA78ra71Ndf1jgUyLwQyIzeR51nWtA4xI
 1mDw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769622007; x=1770226807; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4UrVayZoHw4uVjWZcIRnhTHFkQKeVQ8sRva2hQqPjzA=;
 b=SgFhReIkQwfO/cXAsQeHilwrmjyaBO3j9qKQvm/f1yQKFdMaK0SGfWlv2s417eA2xi
 0Ak/Ine3fFKsjkjsb0cuz7FwgGXW6wGbZ8+M2dFG5I1+V6SdQNa90sCP6OpYJgYu+mNp
 mt8yTF10Zh4VWBmcwCQxSZ1jKDvlf91RiUzjdRRadx6EWUwj1taAX4jfqx3PIDQmwPxq
 fvqp0jKaw1lqfo7Vk5A4Il/CZRDXQrOFxh4PNseMdJ14cxRF7cV4N0lVpaDKjtpzSvmh
 EhoMqrFIm0g4WNfrPalKMoElwfWBylQKNQLS9rPiHrtAjwuLJDWED7JWUM7IcqTI4qfZ
 kyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769622007; x=1770226807;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4UrVayZoHw4uVjWZcIRnhTHFkQKeVQ8sRva2hQqPjzA=;
 b=nfJprR65gHVCTApxmMlInEUTFmLb7S9ETFCw8n3YIVP7OoapRaU60bkSrxp4b0XIdt
 I5899o93714KwCRzf4iKzNSjVrYLKc+PQhxIXSRaJf+wopugmE0Vl5kI7TnL6BHSLxtW
 TK9kVI4iSXSDSkhAD2SXLD1/uy2NJTMLu42N1Vq0k+7hcXndRM0XUOps7uY3Hh6nv//c
 YXsbU9ZqRxR5fcSQ8DsiFxh5aUjMyW1UcIryJU9N456znIi3EZrTLmg8Eqw9qhC8v+Rt
 9jw6VWduwxOBdAE2WxYpWjbKPCgebSYi3kTAsKjlED6IVvGlqJw7gXLp9uYOB6aKxQGG
 QzOQ==
X-Gm-Message-State: AOJu0YxGTUuN1iMUTG+tBguXzI8dEGb+m6JrCIJLB6AXz8Ymff8xHMhL
 BT9tmSfJTXuxILbLbCcAF/ypIAuk8tuoedhpp2wTak1/Jn+ArX+kdr+RWAeDqBw1INgBr/Nr+r0
 wddm5pTh1rzQQKUAWVyhJAEcEekeu78I=
X-Gm-Gg: AZuq6aINz319koyt+EqY3GB5SEH3he20syfgu+aocEJnDs65bX20rwffLBVKEwTLiYp
 k74yTT+MNzxfL/bELRoMGJcuFcPe1pZOEAOFaDL7YuT/P77cTzTcDLQ28qam+I4bshSvto5C05E
 MSBK0TuYNWjn7TCXKz9g7YrwRas3iVLS2SJMMi2evAT8N0m6WatKh7gvrPYXPeZLWHfcrv9XyB3
 M+GBDGtSYVZ4GP8mwXoxWvCXoMfE9UCdaQJhRZ38UDFw00nj04HCKsn0/rqto9YpZlER795MCWt
 Md28ZFSAYm8hVZMrFfWQ1g3jWMRo0kgPHg==
X-Received: by 2002:a05:6102:3909:b0:5f5:4027:b6eb with SMTP id
 ada2fe7eead31-5f7238a80bamr2671300137.45.1769622005610; Wed, 28 Jan 2026
 09:40:05 -0800 (PST)
MIME-Version: 1.0
References: <20260117212114.10466-1-scott.k.mitch1@gmail.com>
 <20260123160244.57335-1-scott.k.mitch1@gmail.com>
 <20260123160244.57335-3-scott.k.mitch1@gmail.com>
 <CAJFAV8wOwtsANF_z3EXp1ZeeMNw=jDvrBu_3xJ5kDZcB1j9E_g@mail.gmail.com>
In-Reply-To: <CAJFAV8wOwtsANF_z3EXp1ZeeMNw=jDvrBu_3xJ5kDZcB1j9E_g@mail.gmail.com>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Wed, 28 Jan 2026 09:39:54 -0800
X-Gm-Features: AZwV_QhGC3WTuacWmcg1_roE0360MXNyWJNAPYe5dYyKXyMK1Qv4V2kkwuXZ7Tk
Message-ID: <CAFn2buDGZY_8MJpQ_=kDSC+H_kBe_vA23sjw3CEheu1h5-E2ag@mail.gmail.com>
Subject: Re: [PATCH v16 2/2] net: __rte_raw_cksum pointers enable compiler
 optimizations
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, mb@smartsharesystems.com, stephen@networkplumber.org
Content-Type: text/plain; charset="UTF-8"
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

> Unfortunately, clang 14 (Ubuntu 22.04) is complaining about unaligned
> access in the new test.
> Could you have a look?

Yes, thx for flagging this. I think the unaligned types need both
`__rte_may_alias __rte_aligned(1)` unconditionally and will submit a
v17. I verified the asm on clang/gcc on x86 (-mavx512cd) and armv8
(-msve-vector-bits=512) are identical when adding `__rte_aligned(1)`:
https://godbolt.org/z/fdYPdoTa5
