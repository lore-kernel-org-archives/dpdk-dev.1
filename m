Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1483606A328
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=vZbDZWM0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 039AF40264;
	Thu, 22 Oct 2026 19:16:28 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 165CA4003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 19:16:26 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-3ac77270fbfso39367a91.2
 for <dev@dpdk.org>; Thu, 22 Oct 2026 10:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792689385;
 x=1793294185; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fP8gkZfSrNzODx6sc5q/TCsoF97RlBkzmfOcsfI3e5c=;
 b=vZbDZWM0dhK20u6Cmx5rqU40zgBWAtWz79F/9GHOmCrFWmnr4hBvMHa7MlCiAtXiDi
 zipVJstSa1+zutH1u8LrcFHgONoEvxSiTFBN/bhc0O22hsWANklX3gskgefn9qw2X6gE
 Lqy5lh25dMplpeyxvjbmYVSoCM+r9KWAMd0fXsjLO/xxNGFVKv3+46/ecuSZy7UAOc3j
 s17Tu4VCPIlcHOZXET8TNvS6dJmVZRGlZ9StZuh6anycB+ZhMsPUHx6KsDmilWo9qb/v
 GLsOeDG/BKfZR7PtdBiYy6g81LFBgBnuJUZhHQ1JkXtGMM+MAj9wEL0RGaSKm6vUT+Rz
 HvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792689385; x=1793294185;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fP8gkZfSrNzODx6sc5q/TCsoF97RlBkzmfOcsfI3e5c=;
 b=VrW1Ny+LIKOxAFsAiANqyiFHfL4HUt8LNRf0kgkyU3PtVbq+8Xi2Z0NFiCHjwjKUfX
 yFu7WIKAXFPCNPBcVeHQ4sE0bnbNmYic/DBvPLrjUTETHwCSP3CYUqp86u80Narmt54I
 LjLvZTOLAsemuBSgAPA+aZY6K2pZtxQuO+aLS3yzDzI8zAYAFiZtvs5/CDXZk9OdlFog
 GJwbAhoIhQjl2m9E5JpreIOgh48FYQ45FjeQdF1BiPCxfPUYxaTW9kgJFOoW7km1csYX
 WDHNNhoyo3x5Dy9UOXz9zJiydwrXylmTuzoZ94tMnFq+PjmUcCakY2jtfYOJ0B+CdFfZ
 HyPA==
X-Gm-Message-State: AFq9FYJjYUQ2PezkJe3zElwVqWSIXSC6Na/nK16QaComX7VMBPEqTUZP
 6Xv6X9O89xPHrv/AFx1+XhtPjEJD+lNwDD91gBBY+38bB8tm6uZKDraCT4AdU3fweVs=
X-Gm-Gg: AYBFou0N/chxmm1CXbwV5EjEKPGPO98i0fgxK8VZq39Zoia8JL0g9i7F4CUdVNBgazK
 bTd+830LqpV6Nj1Raij1mZYKDdixozfueIwXud0CN5UWZZ6KxHn5s8vSsvMWyC0yBUrM8vbnh/r
 9JQtA+mVZC/lL5XtEpFG2pgbyAN17GPQR+IiM7OEmvvoSlY6FjoseQKrjwdCeCuWkT59i70VS2W
 VUTIWkeykXJlmcqRK6Jnkbx3Mgig4zMBcE3f50TkGbjeZV8VAdhcELaHavU6D/k5UX13nhA5DmH
 AnOflVGCWRxmGe1yaIjOlh8/eA69EJfr7FuZieptbQ9OgrBVh3faXDtN/D7MiepCuLBNalO9CJ6
 vLPjY8PLaI5dFLnfzMIWxqpckoatmsZ24JqsDfhbL2uuHv9nLaqPiBqEzV8dk2uyiEMYkW8OTP7
 q4akKYd3bnDPa58HQomSfhewCgOtSPfTDtUw+FDBMukIaXoZj50CrM6noDTi7ISZr5Ab/75c44S
 i37lpOCPiEWpk5rBoQICgo3IApNbVYulPp+o0roFscI5LbDmlASjyJlqb4QeEoqGGSB1QRGqRda
 P5Y24kBPq7pQ8tpLeaEJlA==
X-Received: by 2002:a17:90b:37cf:b0:3ab:c674:d83c with SMTP id
 98e67ed59e1d1-3ad86ed34a8mr5147205a91.27.1792689385156; 
 Thu, 22 Oct 2026 10:16:25 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8ba8a5342sm5008a12.17.2026.10.22.10.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 10:16:24 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:16:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zhang Tengfei <zhtfdev@gmail.com>
Cc: dev@dpdk.org, jiawenwu@trustnetic.com, zaiyuwang@trustnetic.com
Subject: Re: [PATCH v2 0/3] net/txgbe: fix FDIR Rx packet buffer handling
Message-ID: <20261022101622.51fe8e06@phoenix.local>
In-Reply-To: <cover.1791995192.git.zhtfdev@gmail.com>
References: <cover.1791898970.git.zhtfdev@gmail.com>
 <cover.1791995192.git.zhtfdev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 15 Oct 2026 00:39:21 +0800
Zhang Tengfei <zhtfdev@gmail.com> wrote:

> Enabling Flow Director reduces the Rx packet buffer 0 to reserve memory
> for the filter table, but the size was computed from the current
> register value and never restored when FDIR was no longer used. Since
> the FDIR mode is reset when the last rule is removed, on flush, or when
> enabling FDIR fails, the next rule enabled FDIR again and shrank the
> buffer once more, until it underflowed. Validating a rule also enabled
> FDIR.
> 
> Patch 1 computes the buffer size from the default packet buffer size,
> which alone stops the repeated reduction.
> Patch 2 stops enabling FDIR from flow validate and rolls back the mode
> when the first rule fails. It also rejects a mode other than signature
> or perfect while parsing, which configuration does not implement, so
> validate and create fail the same way.
> Patch 3 disables FDIR and restores the buffer when no rule is left.
> 
> The same issue was fixed in ixgbe:
> <https://patches.dpdk.org/project/dpdk/patch/20260927042545.45152-1-zhtfdev@gmail.com>
> 
> Compile tested only.


Applied to next-net
