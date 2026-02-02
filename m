Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA57E7DF19
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 18:43:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64EB84027D;
	Mon,  2 Feb 2026 19:43:37 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id C4E484026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 19:43:35 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso40239015e9.2
 for <dev@dpdk.org>; Mon, 02 Feb 2026 10:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770057815;
 x=1770662615; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JDa/VKz5rEuNc/fX07suaw30mOJb0FhcgxLZvf2r+ms=;
 b=dRZmryP/FQnGoWelFtEhYpvKpQ/UzEAWvFPc6xz7lsF5c3MOiltruQUMUQjlelYbzo
 HNksXyI3Nw4L+O4EY1+fYWxOTey7rFZCe+VQ+dcQcDywh0cwLvpo8cmOTC0QNwOsqsCf
 QszwEWqOruTaMg/+z33uLtduPlJZbcQD+ElSHYD8xYCo9OLwMso67oYh25b2PBwDrLKG
 6r78plZK5x0MPdw370SJ/JtlDsbl62SNcE/ryd2xf/6z36h0Gvsw/qXQUv6DFr5q66AW
 UnDFufixRSxnrX+qSJGVkhwZkPZNdtAujfyKhuYXebSu0ESqE/96n2P9Ppvdm8+ZKqVx
 XcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770057815; x=1770662615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JDa/VKz5rEuNc/fX07suaw30mOJb0FhcgxLZvf2r+ms=;
 b=xI7Jz0PWZ7entTaemHIxhhmdBcqQxACkIHxkxbRXoEvRR6xbaPiVI5IjdRXss8Va7j
 dBWiSbF9QhhISIVj3WKX2iZyKZdukgPMDcn0s5QH5PZWrHG9cdpeZerKJFQhBmCT3S0U
 2DObnERcgscWQAW84L9tTX8hIc0cxw8VoHCAQXDyfXZJl6IQPgxMK4Ul8BXaf+oX2IgK
 JGrmA5mJHXzxSw4M0p3YomQJ7Qglan1uHC+VoTijUEXxHyyfHtZcffp5zo71GOwQU2Lx
 tjWRd2rE8m0TLlxE63fAT9VtXDIr8TJ0VHqzIxF8z1SFx7DilT8b7nJUCu8GW5hmCxKh
 f4Yw==
X-Gm-Message-State: AOJu0YzaVhc+Teo8It/mszitm41HeMeeXM3R3JJyk0/5sEDsEo3URw+a
 FEDZuYuVLR17gJi2IruWnrioepW/JfBrfYdM0AmqhQT/kBI29sxbldhvXlR+lKIvgXY=
X-Gm-Gg: AZuq6aIy5QLZwdDyuo5Q3z127jaUuDSulFXd6g+d6/feZ/3R56p+kqlm+R7WCrl0A7w
 F+aE2lAuYofG/eqtx+uQgtyspI++4mXgXYvilMo7IxMUpRyl3qxeTr7QQf4EKZMDvcZAPKY4P4q
 e4wv7JQC3/O7RBwut8zOBSHPPn5/NDK1fspifdfW8vBRxfIjc8MyVtkUf8LNFIlsKW/c42yXVdb
 dTdqbVcJOFQK5Q5RLGs9svqm6gR1U1V8Rnw4pkjJm10vzdzX3OzdoMYPfGq4DGfl6litMd4hWUn
 thdG/tyAcdHpUqIdx5KeA1Vdzt3muSPYlXM0EM7may8X06mmHne54xyTdt2sfSxOYLmQzFZbtkm
 GeMGIfANJwvq/1vIKMOvSk28jepWsVH9lCtAtmzQ/PC9WS9d4U7XNthOgiLXN8rLLDEckNv7rUx
 2x+jck+S7pNSRBIJcKbsj8jzWWZ/B7/hU9Co3hWaZK4FXQgGh/S2ZH
X-Received: by 2002:a05:600c:a00a:b0:480:69b6:dfed with SMTP id
 5b1f17b1804b1-482db47d0d1mr176111265e9.24.1770057815362; 
 Mon, 02 Feb 2026 10:43:35 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830512e61dsm6787895e9.8.2026.02.02.10.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 10:43:34 -0800 (PST)
Date: Mon, 2 Feb 2026 10:43:30 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [RFC 4/4] net/af_packet: add VPP-style prefetching to receive path
Message-ID: <20260202104330.27156f31@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F656C7@smartserver.smartshare.dk>
References: <20260128173138.151837-1-stephen@networkplumber.org>
 <20260128173138.151837-5-stephen@networkplumber.org>
 <20260128170612.648cd657@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F656C7@smartserver.smartshare.dk>
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

On Thu, 29 Jan 2026 10:00:15 +0100
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > This and previous proposal to prefetch have no impact on performance.
> > Rolled a simple perf test and all three versions come out the same. =20
>=20
> Please be aware that many test cases are inadvertently designed in a way =
where mbufs unintendedly are hot in the cache, so prefetching does not prov=
ide the expected performance gain.
> E.g. when working on a newly allocated mbuf, the mbuf should be cold.
> But if it came from the mempool cache, and was recently worked on and the=
n freed into the mempool cache, then it will be hot.
>=20
> > The bottleneck is not here, probably at system call and copies now. =20
>=20
> The most important bottleneck might be elsewhere.
> But this optimization might not be as irrelevant as the test results indi=
cate.
>=20
> Anyway, I agree that dropping the patch (for now) makes sense.

I doubt pre-fetch will matter much in a driver like this because:
 - on tx the data is still in cache since just setup by caller
 - on rx the data is still in cache since kernel just copied
   it into the buffer.=20
