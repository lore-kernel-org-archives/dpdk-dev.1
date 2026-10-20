Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82EC606A31D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=DsOufzrV
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31A58402CE;
	Tue, 20 Oct 2026 20:01:11 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 57E8B40151
 for <dev@dpdk.org>; Tue, 20 Oct 2026 20:01:10 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cd5e2d696e0so2313682a12.1
 for <dev@dpdk.org>; Tue, 20 Oct 2026 11:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792519269;
 x=1793124069; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZrY/ZL1pHQqpof/oi4NEmjEk1ejZGKi/9pI8FayEGdc=;
 b=DsOufzrVY1yEJhgpd/BZq0KKZ0omKpdtFnqjTZcyO7WTaalivZvHExMtgT4PtLQVcx
 MDANHOlBf0LMy5Z3pzzgFyue/9dVaaQkW05bOq/Q11v0xm3kRyIdBSO0j/tBX06dD2y9
 l6pnPXQ+74LHekSHcJjCfKWykxQ3LI8tjKlCBZ5OE/S4qedGJtpeSiBXXDm9W+yI0gom
 QVfJ3HvxRaR2w5E5lSL80kgnvPqEWeDaWkW02bmtZAdcQ8eEHZ4n5ct/D/G8d3YKNYDy
 XMLuVNYQG5RVbyytfrxvK2HbfnYCNPZQZ1TM1cEjMzdrR+AoauszyA5TfKYjoM+g0+ba
 j2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792519269; x=1793124069;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZrY/ZL1pHQqpof/oi4NEmjEk1ejZGKi/9pI8FayEGdc=;
 b=eFZ2DXKHHVamYCaLOfOHCp+4Ry49gRpmYJuW1N6B+rH3fuqV0isaci7IiI4Qxb02ag
 pgGWTkRZn/KCI8XpNzDQe3hSLgIfqgU6K7c4+Q1GkUt5H+HwzvuOdsZ+jye0M2Gz24eI
 LKgUkrdOjjnEonnie3Gp4YlSo+n6JKVDa5hHxm65L77O+nj1GPAKq0cBLOLaMIm7ITRV
 4ACzDbsN9LjXdT10Hyb9iCpyIwmWrwhZpfWJdRL0TLc33ckcibBQHDvLbIcGPDY2PXFt
 VvvLRSH6oSM1Rr7bReUYJABJoVAzstO7c6alj88sflzEaCLOPILttPGn3fjHNJiAqmS+
 zEvg==
X-Gm-Message-State: AFq9FYL+WHQczSHwaNk6sLWgxZznzmHR16nT6CQyMF7C1VwZgbnKRkTH
 /v+oB09556NKAowumYyqBa+jCCX9NqKheAyszoPRzx47CL5K7d6ldnI+7UYCQcaqg4Q=
X-Gm-Gg: AYBFou3Bk0D73SdhdvicoCFeiShq17+TS5gk4lqJFTuEGkeNkvzB9AbX6Fdq0a/E1KX
 1Q1iOTH9W8ut0RHTE3KcNyD67ForD/RACbmGpQnoVmjNYXPCXh8ILFZft+RfI/Mmqv5N4grtP4L
 rVnBGWi+7fZuEBrZ9CUjiLfpwkIpSdRCiQjHcq6vbbXVJVK+HCan4nMaJNyX1jRsKFsjsJotsVc
 ABR4pBloWQy5s0LCzzgGV3bIF+gnn6qKxWXbJhdvefCOnV+w/PWxbZr4LqEwFrCGrogQBjgOe5C
 eGGNz/5lURtmgc7vku8gAhlTd8uDuyXqb8XxzarxWDqhhK+ReYjg9PPk9zDMmRqMZQ0FoHiXu+f
 ThsV0Iwo+U+JV2UGh3FkMZa7ysKLEvZZ6qQDStg79wBx1CiTS8XKDGT9VT9mvMIiF5ANY+mQ3VT
 /DclfVkSRzzMAWmCR5IQKRoPIFkACVFn6lkdOUkG+qI9ui3rnHp9XVvSzkChBoCjL9YLk2DO/Nk
 Tz5+nRmnkE1WJaIiQr1DiUD17rTYBDIIzcJQEl++KD1v5TlXtni
X-Received: by 2002:a17:90b:3146:b0:3aa:548f:eb7d with SMTP id
 98e67ed59e1d1-3aceec7e927mr9811145a91.20.1792519269301; 
 Tue, 20 Oct 2026 11:01:09 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad813ee970sm413415a91.16.2026.10.20.11.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 11:01:08 -0700 (PDT)
Date: Tue, 20 Oct 2026 11:01:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, "Ali Alnubani" <alialnu@nvidia.com>, "Bruce Richardson"
 <bruce.richardson@intel.com>
Subject: Re: [PATCH 1/2] build: disable GCC string op warnings when unoptimized
Message-ID: <20261020110107.510a3af9@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65ACF@smartserver.smartshare.dk>
References: <20261020145541.388371-1-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F65ACF@smartserver.smartshare.dk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, 20 Oct 2026 17:33:32 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> I replied in the wrong thread, here it comes again:
>=20
> Also '-Warray-bounds'?

No, if it doesn't trip today, then no need to change.

>=20
> Consider making it a series, and also remove existing overflow/overread p=
ragmas in the code (if viable):
> lib/ring/rte_ring_elem_pvt.h - You did this already!

> lib/eal/ppc/include/rte_memcpy.h

PPC rte_memcpy is doing something different and likely
because of different versions of GCC.
Not sure in general how supported ppc is so left it alone.

>=20
> With or without suggested changes,
