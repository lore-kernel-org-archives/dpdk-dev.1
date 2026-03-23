Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5448DEC01B6
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 09:54:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1884340268;
	Mon, 23 Mar 2026 10:54:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9F66C4025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 10:54:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774259683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F8L1bidhzeAlPVhWpxjViDfXrmFQbcHgoPHJ7wMqVLI=;
 b=OHcBejZGgvTd2LCntf8dX70ifA8ZbFnIjdOOhYChvqrGE+b+xFvlLsX5NFMlfrhUwedSM6
 necwfnNPXGcRBqNIaJ0FEAB+NzuGCPEzBv1I0oZTCrfjs5Mr6LPvTy5vzHokD/MdPOdUKL
 I+YaXllZa1i7ix3h9kb+IyMh8h1OvZA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-ltGrT4-3PBK7HNXkizij4Q-1; Mon, 23 Mar 2026 05:54:42 -0400
X-MC-Unique: ltGrT4-3PBK7HNXkizij4Q-1
X-Mimecast-MFC-AGG-ID: ltGrT4-3PBK7HNXkizij4Q_1774259681
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43b4a9a3bf6so1094086f8f.0
 for <dev@dpdk.org>; Mon, 23 Mar 2026 02:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774259681; x=1774864481;
 h=in-reply-to:references:user-agent:cc:subject:to:from:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F8L1bidhzeAlPVhWpxjViDfXrmFQbcHgoPHJ7wMqVLI=;
 b=Zczn8Us7AkCpN89/5toOAq562AShN5gs1Vpl7NMzEauxBYYl3gmXWwtdgf0rXF28x0
 BHA5400gwl69/OcLOcBxuzGYOZmcmkZxHpr4XxA9g//gHXPI3GMSeC74aV4v1Sxpsspe
 5eMUgm0o10+s43QqtNyFu68IUKvidGlzK7l+FGUyb2fvCzHLrKC1Z9up23cBLaWESPhZ
 iEcByFWTbUXSkGtBnaG8rTvp1LNfFR5RJkjOW+dHzMv3kxJ2e9xm9ogMDmORKKwzm/rd
 iT0debggD6GheYHVg3eJqsHf3wUBn9EjidJc0Nq1xrRzyBTDVEPsKIILlKY2WfbyOZpc
 ua2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWHK3SRE5DhmcEU1Z4jjtOBDyCUIIu551wMiTaqyGjAnTBUasmdhQm7OG2EO/MfHKYdDY=@dpdk.org
X-Gm-Message-State: AOJu0YxFl2drpIIZxddPd4a44aHwCzHcIb8l9jiWXelli/E+mTPZKoI0
 vdpKyFfuMtMF1sis5iekXs0o4KP4uZHi2tgig0LDm8Q7xxQjV1E+9SZh6Wd5aqxp7zrFgKo38/0
 ++sm1AHM2FmVK/RBM6Y+eUYkbfhFT7Jv8rXF3BdykihzV
X-Gm-Gg: ATEYQzyVIriesI+jNHTVy3gAm2HsMsQLs/n/Q2RmMlxvCuZy2Ws0GlCtzUxBVR6FUEx
 T/7F3/XrnaPez91lIsjBp+E5h/vpCFwK9hviErL1GAXmNMcFPUypLltUYo13lfJnqBTJ12NG9+T
 3mZsoMd8Pm0cke1utfuGe9fI5h+Ywg+1rngNyg4PMuqlrDFIc0+NH/rkWVRq1HIkGWZA+MZJWdU
 K0sTH2OzQx3qVehV/t2LbGOUSu2/Tyu9YptBcRnySH3gZxRSxqVwA7dyqBcgzrdt+kN/mVStp8U
 9kZJnpGdVBsMr9BOoU0vtGYlH/51mFy/PAmDqSsBTO6QhOlwqj50bSRoXn2+a+3e0NfA3+rUtUd
 6OScr9y4mLzLU1ANvNqldUO6o7lkenyRhOtBFtYXzHX0TO7KIIioJ4gnZ0hH6MdTRXp7TFIO5R3
 REtda7
X-Received: by 2002:a05:6000:2303:b0:439:b6d6:723 with SMTP id
 ffacd0b85a97d-43b64287251mr17040786f8f.42.1774259681110; 
 Mon, 23 Mar 2026 02:54:41 -0700 (PDT)
X-Received: by 2002:a05:6000:2303:b0:439:b6d6:723 with SMTP id
 ffacd0b85a97d-43b64287251mr17040741f8f.42.1774259680608; 
 Mon, 23 Mar 2026 02:54:40 -0700 (PDT)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b647120a1sm29202862f8f.30.2026.03.23.02.54.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 02:54:40 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 23 Mar 2026 10:54:39 +0100
Message-Id: <DHA2KCDMUWQ8.2E2MH717JQEH2@redhat.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>, <dev@dpdk.org>
Subject: Re: [RFC PATCH 0/4] VRF support in FIB library
Cc: <nsaxena16@gmail.com>, <mb@smartsharesystems.com>,
 <adwivedi@marvell.com>, <jerinjacobk@gmail.com>
User-Agent: aerc/0.21.0-127-g39acbf663345
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
In-Reply-To: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A9jnU1Al7ZaZV5v7ayyVKK3DUCDfwarmJwEiP3rrPp0_1774259681
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Vladimir Medvedkin, Mar 22, 2026 at 16:42:
> This series adds multi-VRF support to both IPv4 and IPv6 FIB paths by
> allowing a single FIB instance to host multiple isolated routing domains.
>
> Currently FIB instance represents one routing instance. For workloads tha=
t
> need multiple VRFs, the only option is to create multiple FIB objects. In=
 a
> burst oriented datapath, packets in the same batch can belong to differen=
t VRFs, so
> the application either does per-packet lookup in different FIB instances =
or
> regroups packets by VRF before lookup. Both approaches are expensive.
>
> To remove that cost, this series keeps all VRFs inside one FIB instance a=
nd
> extends lookup input with per-packet VRF IDs.
>
> The design follows the existing fast-path structure for both families. IP=
v4 and
> IPv6 use multi-ary trees with a 2^24 associativity on a first level (tbl2=
4). The
> first-level table scales per configured VRF. This increases memory usage,=
 but
> keeps performance and lookup complexity on par with non-VRF implementatio=
n.
>
> Vladimir Medvedkin (4):
>   fib: add multi-VRF support
>   fib: add VRF functional and unit tests
>   fib6: add multi-VRF support
>   fib6: add VRF functional and unit tests

Hey Vladimir,

Thanks for the series, this is an interesting approach. Does this allow
sharing the tbl8 arrays amongst VRFs?

