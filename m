Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3731CC55172
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Aug 2026 15:25:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57AAE402BB;
	Sat,  1 Aug 2026 17:25:20 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id DBB8740299
 for <dev@dpdk.org>; Sat,  1 Aug 2026 17:25:18 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-38e08baf860so1882726a91.2
 for <dev@dpdk.org>; Sat, 01 Aug 2026 08:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785597918;
 x=1786202718; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SythJgTBLgskT6LaeknbJ3NnOLCjfF7yXa8Y0zazwGI=;
 b=Rddrp0psFahIuKLs/rs/R4keBSXv/syKazZ2WtUgkNUSgrqNqWiPwXjhLQ/8IWkPGO
 BvTBqOxQsSgWoednt9ueDAoQa7vatNZOU7y9PvnFgpkk23bkhSXIKLSEBtZc6TrbDzo1
 imjLrrtekZxn5+kJRu4hZNM3EsC4oUWl2jaN1bpKZgh5tLHZgQxBYQqzMjebGt2JLTtS
 hxVgTDR3DvyNzFgeeqxT0pMPW0mtjsYXL5tw10qmXMJVVLpQROQjjKgMLcAiUtW8eR4A
 mWBelJ2AkjpJi2Sh1JkhTi39Ha2iW91kHnK64kWmOMPDt5hfva2UK+DhQlurT6VYTWJA
 gOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785597918; x=1786202718;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SythJgTBLgskT6LaeknbJ3NnOLCjfF7yXa8Y0zazwGI=;
 b=CZ8GboKtdXVFPtvtwWM+FRNDspNJF00tXMJugevBV16bFWzZA/fto9G9pjarcKabY0
 6/CVHIZYA6wn3IwI4SVWpcft4cbrl/cbqVr5HD29YHOktwp3NDgou94rjyetfkOolPSY
 W04Hl9aF5JgEJkw7AZzbJXGSKbm8Ih/zIWEc8Bs0uONQUSvRNQC+IPhivuiMem4b974r
 mHMUd30iGPSlHM36uP4ircrCDLtYqVTwxNFsoBZzsDBEFz6kigx+bPQoaIaiiCw+je9V
 a/YPoPCSY5hsFZxNRsi4vMYi/+vAD3HcPTMz54Q6ChMlQBQ45xOqxyLWNNKIovRC5G1T
 UwxA==
X-Gm-Message-State: AOJu0Yyxqor3VUJHyhuofBjdfEUjbAxTXhjO05Yc8GS60VZF/zavOVjg
 kRfMU+msec9kmRAuq/4/pGBput1YJvIy0GADaoG+/zi4Ylzi/uwmzCOUwsqHyvSs92c=
X-Gm-Gg: AR+sD110aItPlYiKhmQEXs8I0GIJfqMKXsn81fJLL9NEFLtOz/ZasoizfpB28/LmUyG
 nMk86pozmrBrshOgBvb4SCKeEDhPuf8V0Yxn+evZuGnMbJauZM4KOEirrjOLp5ybB8KQROk29Z4
 tgrPW1wWrpVgro6EFShJvthHDdUa32RHY2KTrKk9GvXcVAri2Q+9RBlPHZs5TS70eRb8kafEz30
 bbXVAd5dBj7uGpXOF3BMrxnyWr19JCTRuedSAPTxtzlSPiDd8KHp6zMi2KaQCo+WjGXmLEqbCvR
 amyfYoHNc1LvuXOkIbbKW/jQhxqKDmJW+TeZuYvz6EBo3iQuoi5nh0iHI01DBCE1fJ7ksx8hFt4
 1gijeDJUTKpqUA9ANeWv5mlFEXHy+dGTBvdUXzg4apiqGjmlQdNMW9Wu3M+3nvuQDE3h2WofF74
 lgQMIBemIbykTSR8wg5BbqMkmkVb0IvPR6TSJcitbZvVC28xT5YYIOMZwZVQ92GderM5XR+pp1R
 VwTZASc4byFD/j1jLkgw8jCgxI2AYGFd11N+rNA
X-Received: by 2002:a17:90b:5824:b0:381:9028:5945 with SMTP id
 98e67ed59e1d1-38fbc43a847mr3691849a91.14.1785597917879; 
 Sat, 01 Aug 2026 08:25:17 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e06fe9fsm16452272eec.25.2026.08.01.08.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 08:25:17 -0700 (PDT)
Date: Sat, 1 Aug 2026 08:25:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, <bruce.richardson@intel.com>,
 <konstantin.v.ananyev@yandex.ru>, "Vipin Varghese"
 <vipin.varghese@amd.com>, <jerinj@marvell.com>, "Maciej Czekaj"
 <mczekaj@marvell.com>
Subject: Re: [RFC 12/32] stack: always use C11 memory model implementation
Message-ID: <20260801082514.4fd2c724@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F659AA@smartserver.smartshare.dk>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260729175715.165120-13-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F659AA@smartserver.smartshare.dk>
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

On Fri, 31 Jul 2026 16:53:45 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> +TO: x86 maintainers, ThunderX maintainers
>=20
> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Wednesday, 29 July 2026 19.54
> >=20
> > The generic and C11 lock-free stack implementations differ only in
> > memory ordering. The generic version uses a full barrier where its
> > own comments state an acquire fence is sufficient, and seq_cst for
> > all length counter operations.
> >=20
> > Only x86 and ThunderX still used the generic version. On x86 the
> > switch removes a locked add per CAS attempt in push and pop; TSO
> > provides the acquire semantics. On ThunderX the pop fence weakens
> > from dmb ish to dmb ishld and the push fence goes away. Unlike the
> > ring, no platform selected the generic stack for measured
> > performance reasons.
> >=20
> > Remove it and use the C11 implementation everywhere. =20
>=20
> The lack of measured performance difference documentation is not a valid =
reason to remove the generic version!
>=20
> It would be reasonable to assume that x86 (and ThunderX) use the generic =
version for non-insignificant performance reasons.
>=20
> If there is no performance difference, I agree with this patch. Otherwise=
 not.
> This could be verified by providing the missing measurements.
>=20

The reason is that smp_mb's need to go away.
The other option is revise to replace with thread fence, at which
point it becomes the same as generic code.
