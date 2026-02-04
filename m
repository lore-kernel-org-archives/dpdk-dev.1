Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCAEE8B39C
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 05:21:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D39DF402EE;
	Wed,  4 Feb 2026 06:21:12 +0100 (CET)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com
 [209.85.222.51]) by mails.dpdk.org (Postfix) with ESMTP id 2C8494027F
 for <dev@dpdk.org>; Wed,  4 Feb 2026 06:21:11 +0100 (CET)
Received: by mail-ua1-f51.google.com with SMTP id
 a1e0cc1a2514c-948c1171392so773671241.0
 for <dev@dpdk.org>; Tue, 03 Feb 2026 21:21:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770182470; cv=none;
 d=google.com; s=arc-20240605;
 b=FVXy71EUXF0mBnrpgByjGnPe4ZIYYZ74UT8moqZZpgIzRWfrnFku+sBMgY6/MNzPX1
 TnNIkTHRXpQP6vsGrkU98F3lX+6dnHCCKovOJIll0QVoDllQLnZvWPjMQms0RIneVXq3
 cHVnYN0f/28T/No1/tgi0x1VV7l+Nx26elCwIdwggPSGri09Qb8QmU6z4LWkGE1bLJ1q
 yHbEq0Z53PERcP3dAPLcdJ9XuWtekwQ3L0koEDqZ1UcfYY2FPNLQJvSw4WdAlqX1CZcG
 2HjYV8BAueAMUj2XKsv8urkdtk7PMedhPgITBk0L1xqt5+jZCP6Rlhf8rQSq8BprFevj
 amXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JYg+fSrqqX37p8Uf1E29LIoz7ZZnBn/IjbvZz/W3xQo=;
 fh=9GDrS3tifzgfNr1eIYplN6H+e66iZWb9rV8dlwI9lvA=;
 b=I4Zapt5SYfejnaEm6+C+W6d8NNXdKyoJSuyffW/nYVLcN39cHCVzg+fdLr/PF07XyQ
 ZIrrC+Ix/SfH4hA1wl0q4Tv2yAKZoB0WfSciB3sxOpQ2EXQpvbIAI6bAfWG7WdTeTIFq
 7w2cEFPuBPksibaLiHjU9E6+nDbwNetgW29kvRzUWAleMYgyDwy3mmAOdntw87fKbO+g
 QepLiCGt3ryOVdwY0ceTsNuH7zof3no1DUeMKmlq03LhHXE7vYXiW0c9tzIs6H/hG+WF
 P9iVc0sintKdDa2npNb/hYdQg+T2Xlh9jkHE865xPD+4mvL2qNf5oY3cd2b+bxTK1GN5
 2Pmw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770182470; x=1770787270; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JYg+fSrqqX37p8Uf1E29LIoz7ZZnBn/IjbvZz/W3xQo=;
 b=l/XuRoYNr9qxpTPur+NXNH+NEHS2I1Ge9+I8NSU39ZeEf8vaumzYK4Z/3b8yAFLLOk
 C9BwLUHD1UfrNDCIE4S6MK1ScMh5fDpP591a0dfuSu0E4l/A/DU9e65cEuSXXGDmcQ8/
 EYfziQfqVPpHLqjvmxbHLoM9Y4PtH3kV0YDjNk0fuQsxuCQRGbyIGtLQBAnhEzFHK5R0
 YMdJV/lZIj7FEh3uVjdQoCHKCkgAjyMcotnmCJKg8Juu35fXrapX/R4PPinxbLhNKzvh
 jLZy9vvvSAJuiwKXStndIzPIdaea31TLwP1GI3pQOVuGNik88tzSARG/uJ2PZtveq5I4
 XPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182470; x=1770787270;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JYg+fSrqqX37p8Uf1E29LIoz7ZZnBn/IjbvZz/W3xQo=;
 b=iScARInxS8zhaIcYByfg3GROw6Zo16jARsP/aRe/mmtWuqX7a6jx8SzQ9h1npldHLk
 ROcoWiAwZR9xfIZ5O4ooGyLQvy5g9X9rudbFgQ0qknTSTmI88792cFE7l4WPy0ZomdVs
 GC6MQyIkr1t2T3CJnU7FEIy/XQ4Pp9rb/R499R2nGAjeK6duu5Aw8cbfyDeoYfzqFLGl
 Ltqq8n0Jik1kJxArTdcle/gIiCrQGjbtFoEK+A7qeEwtCFsT1i6Uf+ALbbquKR6NgD0G
 mN5ZrfDJ86c30gjOuBx7Ue+2GE0uzZbxRs+OLFhado1/zWRYQ1lHan3AcYWOn2P5j7I8
 EhMA==
X-Gm-Message-State: AOJu0YywaoowkBGnYR/myojWdeGquRh3Rxg05Ol7dhRllNX6JcBrqq0b
 fBeO8eeLf9c8ROWEeY1QhdjwTFkrrFIN6JIpoeEi3lkdYf7PBTBineLSwnMRWwBo9e/F+rHWFYy
 gb3wYPW/VhjOIHmYzzgD6ZqN9hlQ5tL+F8zyy
X-Gm-Gg: AZuq6aLHU44i3Wzu830BSnDk5t3dHz6d+g51jBU6HabRE8S+soTIj2+ta2dRA3FWTm4
 s/3GxUKWrLyWcq1kpyEtjegmmdN4RG7KXzsg22o79xcTaRVQ8rDxihP9gZ3Vc1TcgCAIW2C6gIn
 E+OUcW5Sn14OjIETaU6CDELIthaslCz+nhw7q7vyC6hZXQln0ymI8Po8nbe/Qcr0DzrXXk2rUiF
 KG2bMcgsZcIW1K5pVQlYpYdSQqEtRccUVtYF7IVbDKMP4Ks4JUCWzJeD2X9fSMoWKIT0sM=
X-Received: by 2002:a05:6102:e0d:b0:5df:b5d4:e45d with SMTP id
 ada2fe7eead31-5f9395e2250mr703999137.33.1770182470213; Tue, 03 Feb 2026
 21:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20260203211833.44063-1-scott.k.mitch1@gmail.com>
 <20260204024631.73059-1-scott.k.mitch1@gmail.com>
In-Reply-To: <20260204024631.73059-1-scott.k.mitch1@gmail.com>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Tue, 3 Feb 2026 21:20:58 -0800
X-Gm-Features: AZwV_QhFuTUuzQXnl5JusmrZQ9xCJOJk7NVVVhKd463No3iSZ0-aL8QvaKw-Sb8
Message-ID: <CAFn2buCkBMExrXRG8nTYsuRs5Yj55jwcLTfrYHdAX98MDDPdCg@mail.gmail.com>
Subject: Re: [PATCH v19] eal: RTE_PTR_ADD/SUB API improvements
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org, 
 bruce.richardson@intel.com
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

Test failure is expected until Depends-on: 160679 ("eal: add
__rte_may_alias and __rte_aligned to unaligned typedefs") is merged.
