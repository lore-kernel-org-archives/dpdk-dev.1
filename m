Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB354606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=Z4XgfGIn
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1698840297;
	Mon, 19 Oct 2026 20:59:12 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 7D47A4021E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 20:59:11 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-919abb3335fso21037066d6.0
 for <dev@dpdk.org>; Mon, 19 Oct 2026 11:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792436351; cv=none;
 d=google.com; s=arc-20260327;
 b=bODbnIurtNYC6U+ubRvLN06AVKQZYOnWbA6kr+5wTWDc9M+eoPIEXUPTJjZWxrDdB5
 1VJeRxdbTPP51WQIqQbNtSceq07MtTceyoN7bGcALZY/bpLBPFA9Tm3FrepKAPAuuQoG
 Ci6SaUMVaVym3aJs7nqOWS3uMhJYZumOYQsVoTaJZQBvwQvCybnFECk8CeFVbBrMMscw
 BDiYX6BAWoZzkvGPrbAsyx1hJ0mnel96mQnQaYVcJyPuH8Dt8DBaCC5MzcUR3gVbG0Ox
 /jVKNDS7Sr2fwsDbbfS+ffttWNVol4rsxR/Xj8AXrnhNGfLHhm/Rb04OXTkNP0XN6WxY
 eumA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6ncZGXy7jymAlxO2SHju+oXBBJDTdh8kSn9/OzueZDo=;
 fh=ZVk6RVH4Ua5RX8FF/JY+wChj4MBgV4ubSi8+rwrK84I=;
 b=GU5WDACRRuZZVK0YQ0KQ82LncuYk3DtDmDm2Zw/WZM7aZA6VAMZ8gcBKp0D6guR79g
 F8JhhcfzCLqyHmUdF9QOltEdaWMAzfJ5Gs6ALz41oWYbpy208+QGW6rU2cuArfz/oH4B
 LrherQui7InIxG1QM4LdM4QTqyvoJw2W0FOXgne5GUUzlNGl+sgT8/jyQRcM4h5B64+d
 56FDb40BxNFgoTrJKCyvAxcltQljWao3Nsb+Pyoourm6yWxQ0SfYdQrQynv8E87ZN6Ij
 l+u2CPtNGgeRkygVsUQLlKuN+0FdBfxNgMZcQWyDBfRNRxM9Fae9Wmm1Z6BQOUN6jMpX
 KzVg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1792436351; x=1793041151; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6ncZGXy7jymAlxO2SHju+oXBBJDTdh8kSn9/OzueZDo=;
 b=Z4XgfGInRm1vp92f8wyvNiKZCNKk0zdZ0XFaklpQxj/lngW4EiYIkmTatD+4ySKg+k
 PWCYDuMRHIcd7yhy0kcf2pYZzTzj+z7GRrHpJXZxHHixT6mz1dvO5/kWVpmVzJeHziGe
 gBNh7cHv+swBtWyT72SJR04qzKFdTdLYJFdLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792436351; x=1793041151;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6ncZGXy7jymAlxO2SHju+oXBBJDTdh8kSn9/OzueZDo=;
 b=wIRZK3xRGJ54HtA8Lv0y7qWdqqJ5ZEFGuhZeqacawAervawzVzVyxY7cjhUl+XOLK3
 H9TXLorc//Kpm4P8jVm7GtbsnFiHNTRy5Fs/HRSJSC8noUkCJZJuq0pV3Ih0pVSDPdjw
 9ygBR2IV5yA7RjK6mH7xOHTU8Rvn+ppnNEI3zbC3HaYY0TPOUFLMq/590UezOsqV+Xx4
 ByMWbxe44OGp89Oo16GWDJxK4eNWfZVtUkbx23iInkC/D/N/Y3j3wjD49uukqE3Snfx3
 wSir/bFTU5IXHocb9/z0HdYCbDIeaivqVoI6X56mNS0ubOxV906FRn8iNxj5RFqABJjC
 hVSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGef24ArMwthDjGEPqpPBd02Gs7AcDuZIAsZ9X9XhEswrvUGOb7BiKyMu6uTIvztHDyS4=@dpdk.org
X-Gm-Message-State: AFq9FYJRAD4Jfht3eNVjEIGt82uP/SRFrWbTkfOgjdEKVMkKeefhcbRw
 FrFfMkWvmYzqAry/FXEhsnVcsPnbyxZO66N/5B7hb/bwTpHR4zs3/m+R+rvOLyMzpZZYECq2t50
 ehRK8MrG/xnQvZiwDbE5gKuKRnvwKb8X7lFS16NOXU5BxsbwJ9Yum4Dk=
X-Gm-Gg: AYBFou2AILJ/8jVWCga+40M4pTzoCVlRQKFDxFQnOsoQ1aNRKk33Tc+CsavasbpFe9E
 M5DTBqPJ0ZMNpibZ7YYexiUnIjc/tCPMtcgMNRZVvqQBvMrc5Yqsjow1+jR7Y4GMGzIgIQ5fZxb
 62AezneLCWBfYyNbnuphqJlwuA81Jf39ax9d6rIx2R25HgLMht3wQXbQkpIjBnurXqTEqEeS55i
 QkFAabAB7AP76ta9CJUY14FFaMN4p046C4meXafXeEI0hVi2SJPQaf4jSHQUp5YjE34HxiMuCZe
 RG82EOtyuQJVFX2/eNV2KPgG0fMU3taKLRjVNvzjgkemABvLn1UV3u1Hl3enb1ZGHlQG4wneJnC
 y8juI18uQt2Na8OsS6nYYCDP8MyhrGtO7MsJKouAMwoJFibDGH8zUmynAAtVkIA9r20Sz/BSL
X-Received: by 2002:a05:6214:5b03:b0:919:557c:f0a1 with SMTP id
 6a1803df08f44-91bdf0a6b36mr145993036d6.24.1792436350868; Mon, 19 Oct 2026
 11:59:10 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260901183701.431831-1-knimoji@iol.unh.edu>
 <20261008191139.1094155-1-knimoji@iol.unh.edu>
 <20261008191139.1094155-2-knimoji@iol.unh.edu>
In-Reply-To: <20261008191139.1094155-2-knimoji@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Mon, 19 Oct 2026 14:58:59 -0400
X-Gm-Features: AclHuK9lhw3xeGbEXTVFSASNNIPp--GcQSP3YS_7BVm5701Ym8yXIp_3tLhwF34
Message-ID: <CABJ3N2VHrNpwY3Rb7A19cxO4yRqg0EesdOXdTNQtALBqD1K98Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dts: add pvp multi paths virtio performance
 testsuite
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: luca.vizzarro@arm.com, patrickrobb1997@gmail.com, dev@dpdk.org, 
 dladd@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000f9f1b2065e361b65"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000f9f1b2065e361b65
Content-Type: text/plain; charset="UTF-8"

>
>
>
> +from framework.params.eal import Params, VirtualDevice
> +from framework.params.types import LogicalCoreList, RSSSetting,
> TestPmdParamsDict
> +from framework.test_suite import BaseConfig, TestSuite, perf_test


 The locations of these imports have been changed with the api refactor and
need to be updated here.
Fix these imports and this patch should be good.

Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>

--000000000000f9f1b2065e361b65
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><br><br>
+from framework.params.eal import Params, VirtualDevice<br>
+from framework.params.types import LogicalCoreList, RSSSetting, TestPmdPar=
amsDict<br>
+from framework.test_suite import BaseConfig, TestSuite, perf_test</blockqu=
ote><div><br>=C2=A0<span style=3D"background-color:transparent">The locatio=
ns of these imports have been changed with the api refactor and need to be =
updated here.</span></div>Fix these imports and this patch should be good.<=
br><br>Reviewed-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu=
" target=3D"_blank">abailey@iol.unh.edu</a>&gt;</div></div>

--000000000000f9f1b2065e361b65--
