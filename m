Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F6DE6689C
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 22:04:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40D804060A;
	Fri, 19 Dec 2025 23:04:00 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4CE0D40276
 for <dev@dpdk.org>; Fri, 19 Dec 2025 23:03:59 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2a07f8dd9cdso24534995ad.1
 for <dev@dpdk.org>; Fri, 19 Dec 2025 14:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1766181838; x=1766786638; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yrqZ8y9uxfm3kRCqt1JBcO7uNUMyYN8sRcObn1RcfS8=;
 b=CidI/U57nh2xYkQqdur6ruJ9paJGlwZnDp0OJyb5nlz5kALV3LojM+pE4LxkxkOVTU
 teq4wOZP5b16G59scsIyQCkV6kg6Wp6fW5eNdMNsSmKYK6IWKMdBBCvdPh5zFfCEmsm5
 POynqeyV9D3IcPGpdJubRZVhBBhrB1QiJ6R4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766181838; x=1766786638;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yrqZ8y9uxfm3kRCqt1JBcO7uNUMyYN8sRcObn1RcfS8=;
 b=KBdpyy0wMhR3CUP9/teg9Ha+JkZElNLdKHGUpZDbVFJOnhvWAyyqd/76Y1qLKXAT5X
 SQ0zQnfNPDIPPkEd6EED09WfB4z1LF/yU+dJsIRCsACNF6H+s2C+FyNAOLjw4FwqEaoh
 b9bQN+FqBANKtLe/U04yTzbIiHEK5EdzaPpk81iKHybjT271R6D0kuSQf/b2XkYnz/im
 G6hU9cxhB2NtD19oiGOFy5gBqvwRnSr+PkeylWMjNCGT2JNuxZbG9OSLB+ERm468rlT0
 Qv3tO+W8+vVstoXCl4vQY9kt9Y5FVQo+CJDBtp54MOWryanHSW4i2f1BFkh3eSC00r2B
 hfJg==
X-Gm-Message-State: AOJu0Yy38HMlSQ8Ad3xuBlBbtZ7pZZylY1qjD8RtsCw4DScdCcJWfvwG
 boFpcre4RahJmEI/KPVmtvbCkRJw5PHEIPDAgHkMRC6hePi1rrNuuGDLPiBSceHadawQNq0YT5p
 TyRAxhji/3IIX86e8Yz/QT/Wklu9dTDL6wMN47teSXA==
X-Gm-Gg: AY/fxX4spEayA8UZNSKW8ui2OYRsQAagkkLtAU65/4IXl2LEeEvmLJwENBzRgnxh/ps
 2XYVFPyXgXt/LTQyAdAc6PQz1Nch0r9YRpphH8tGOrbOkKCF+0RTTrX8RlRs+E8JxrxuXKUvlhp
 mcDKFx3G/Vt623KEm5U0n4zeawEx2Yqzksl/064henDB9bRFy/eWxHjLZOxv9hyYhv9PpCNqu2f
 OfVk6ZVEJp9kGqcaoNcbd5YaQ6ZPNNOpwquzOBrk/r1imqTcZH+d838XK+bro0piKdSRKJs1a3C
 osSDpMcIXA==
X-Google-Smtp-Source: AGHT+IFWxrcIe0NXv39G88QonLW87+cgolKxbN/w+Ip0Xl86Oa2UXMZ+XIEVsAzu3Nz8YLWyrPwisLz+M5OhdRaeqZs=
X-Received: by 2002:a05:7022:b883:b0:11b:923d:7735 with SMTP id
 a92af1059eb24-121722abe66mr3032290c88.1.1766181838377; Fri, 19 Dec 2025
 14:03:58 -0800 (PST)
MIME-Version: 1.0
References: <20251208101203.315647-1-rongweil@nvidia.com>
In-Reply-To: <20251208101203.315647-1-rongweil@nvidia.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 19 Dec 2025 17:02:07 -0500
X-Gm-Features: AQt7F2rHH-VqG80bs2WU4cdGCQ2opysbTdZmpDXSCBuGcRmE4GDD3eIIQ1J0DGM
Message-ID: <CAJvnSUAcVA_RAX1JrrRGs_wXFE5tHHcJCjXDyMxk0LFrkv0WRw@mail.gmail.com>
Subject: Re: [PATCH v1] net/mlx5: fix job leak on indirect meter creation
 failure
To: Rongwei Liu <rongweil@nvidia.com>
Cc: dev@dpdk.org, matan@nvidia.com, viacheslavo@nvidia.com, orika@nvidia.com, 
 suanmingm@nvidia.com, thomas@monjalon.net, getelson@nvidia.com, 
 stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>
Content-Type: multipart/alternative; boundary="00000000000015e17d06465541c1"
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

--00000000000015e17d06465541c1
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Performance

I am putting in a CI retest - no action is needed on your end.

--00000000000015e17d06465541c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Recheck-request:=C2=A0iol-intel-Performance<div><br></div>=
<div>I am putting in a CI retest - no action is needed on your end.</div></=
div>

--00000000000015e17d06465541c1--
