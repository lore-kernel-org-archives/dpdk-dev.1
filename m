Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705CFCDB477
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 08:05:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7985B4029D;
	Mon, 22 Jun 2026 10:04:59 +0200 (CEST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id 22ED04021F
 for <dev@dpdk.org>; Mon, 22 Jun 2026 10:04:59 +0200 (CEST)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-5177945a22eso28175991cf.1
 for <dev@dpdk.org>; Mon, 22 Jun 2026 01:04:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782115498; cv=none;
 d=google.com; s=arc-20240605;
 b=NdYG1+L+Z+A+O0aqGLHtG3QL1TlIuES6+Gv9fHb3bYO2hTHKSbodYKCQQOSFEzuuEN
 OHhmw7drGtohOXk2w6VwuqKFBb709X3HZNTWcC/GPmYGMBZkU5uLXPcIteJElee7mJTO
 Pljyl4GYjOpTaKLUI5/F6jwFZiL92U0Sqt4bWJiukqd7TQCnYRNi4IAOVqFgoJWn8diw
 laNQw9jjD7Yz3eldX1bf+13HlpusuLg7cAz8so2eUHhxaOCqF4fgkAoAzKYHPpsrXNld
 +syLimnWvxohwWZQj4f0UAXkdRyra5JQU/GiWdoUv8dPI1v1cNlSANqaP9RwleLycVBV
 YfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZF0P/rUPzHygT6+l3F+qaeMQozg77ReLoehzGmHu0mA=;
 fh=NCdZfH2Otwhp2gcbwJCKUQDp3uaNU8cPlwArlGDOzdw=;
 b=ehyVyQ/WEiys7dr9qAVuyFuaoakNFAwTjBk9AXrzopidcmLpS8Pc7NZpHUki3vzPAM
 OtRm+dGJgNbvHGL7Je1gnxDMRGB6R2FOFu5l05svnp4KxhTJJhUh1DoF9MHJL48u8Ppl
 t2LHtnm/DnrppjKcb411jAxZ/29Nz4ud7zfr37EIL3T/9vcpDep8CF5oiXr4MyXYTA3P
 neN4Cd/ipCD/LuhYFKJ8ThZ0LZ1tXhgWcdC59BnCzdSsfIKhpgWUL+wv4lW8TFvVw/gl
 4Ru2/slVQ80nqMEQOqB0mPg8b/muthvMJOIYdNFWWL+Z3NJGYIBevAE7xIyrYTllTAZz
 gGpw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782115498; x=1782720298; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZF0P/rUPzHygT6+l3F+qaeMQozg77ReLoehzGmHu0mA=;
 b=GmlaBHCQUckjR2+2PN0klijG+Gp+dhLlhXluHVdsVhEEC9a0LBp1VU2vUbCgRvT6ZE
 hnEc4tqKwAKqlXGhgtuMeMfXDqWIWmn5XKV4jH6l7f7Jb60zBeSV57XwumkKFBcsQ2Lz
 exV/50BPqG/BdA/MdwN956g3YIkuue+ZsLfu4xUtxu2C65U/820/n/j96b6yi0Lo4mKZ
 2mBR7BLahS/79KaAnIjPE9+uqAHkD1jLcDKWnFeCHRBgyKe7SMuCz25mkfK8RrMXRtuX
 Jx71+mzzk2g0Y2jx+xmkfa20wjeHU0kXv9JdxHaKTKqP4F6lzUNOwnYBSF7hRNBgx7YF
 Viiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782115498; x=1782720298;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZF0P/rUPzHygT6+l3F+qaeMQozg77ReLoehzGmHu0mA=;
 b=EomtpT0rVPS8aahNS2sv3amJLh5cCMbbCqooFKM3JsofxLhZr3et95v3h8KHfGnVMt
 rjs6yFbg6WTGs4hzvyRjFaOXhl4oRd7KvvfEuLLMXKkk3h0lbpyWxZqwRjEyW5gxjAcK
 C8VUnSYEKgOCzrApox6WSB4Ma6J9YY46+e7SpgxnBnRY0FsV7aN44Xk9TJfbKGB93cod
 Q9uLjistcH4JViZIBAc94kdguDbLDk2XRLF0G/D2vm3sLUjippvPFFhuZrkMrBoRFj0u
 +icXQn2MZPj8aaVtLBQvWNF2uch+U9XeV4nFRtps01DygNvvOxHQHqrqtPUFOGtbF2AK
 AnTQ==
X-Gm-Message-State: AOJu0YwnYhQ5GPHbITKcjAj0J4rpaz07wkAdv2KK1XQtddEIJ//Wo64N
 F9LhEzkcSrO2d/gxy6OVNUbpVgff1CkhJtTNOI70GWcU7lkEJAM+f7FLpkt3CgUQE3OTPsuzUIC
 j3NnWQV2knZkdSpVt5bLNhI7MsWesq5c=
X-Gm-Gg: AfdE7cmUX8jVGSdtw/wEzOQyvL8bzZyJPXLuD+2KxRHi5UhJfKBGFsNwxrWEnNFASw0
 /A2mq/KFN/8O5VgCdi3+kDLqVTXVtLW2TQrzlJq/1eV79IRl/Om+m2OJ11AY1HXp3u4Wr2RcCdI
 8a8fDf84C7kmhj2r3Fb9d5cIdFepEbgQ5iuo7n02fHXE76/JSDaaq7o6oFGtSXOvocBNJoGV2eE
 W9UyoXMA/v1H6eZFPIhFbTsFjQUbnciqX5LCK7+qDpiLUpBvoCLCMq34EnY5uFDYeV3
X-Received: by 2002:ac8:6905:0:b0:516:e031:932e with SMTP id
 d75a77b69052e-519e4905c5cmr183795191cf.4.1782115498240; Mon, 22 Jun 2026
 01:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260331085445.1105590-1-syalavarthi@marvell.com>
 <20260609035251.912771-1-syalavarthi@marvell.com>
In-Reply-To: <20260609035251.912771-1-syalavarthi@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 22 Jun 2026 13:34:32 +0530
X-Gm-Features: AVVi8CdPsXrcfldOYYVKV-2VtEqFOZGT--KwLioQZtJ3z8fC_lGP3fvuy7IPRSg
Message-ID: <CALBAE1OaSiPNdS4V5thsiQYqLoa5DRjYiwpvfq2uLxxuNuperQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ml/cnxk: fix overwriting layer name during load
To: Srikanth Yalavarthi <syalavarthi@marvell.com>
Cc: dev@dpdk.org, jerinj@marvell.com
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

On Tue, Jun 9, 2026 at 9:31=E2=80=AFAM Srikanth Yalavarthi
<syalavarthi@marvell.com> wrote:
>
> Layer name is initialized during metadata fetch and parsing
> stage and should not be overwritten during model load. Fix
> overwriting the layer name during layer load.
>
> Fixes: cc254869ae19 ("ml/cnxk: update model load/unload functions")
>
> Signed-off-by: Srikanth Yalavarthi <syalavarthi@marvell.com>
> ---

Applied to dpdk-next-net-mrvl/for-main. Thanks
