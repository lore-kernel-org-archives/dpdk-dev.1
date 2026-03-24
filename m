Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8CCF54AC5
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 15:16:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E3F8402BE;
	Tue, 24 Mar 2026 16:16:04 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 0D8984025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 16:16:02 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3567e2b4159so1054158a91.0
 for <dev@dpdk.org>; Tue, 24 Mar 2026 08:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774365362;
 x=1774970162; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qjqJxNMnvYa7OABy1cHJTN3Gfs5S/Qdg7Biy0vVgP/s=;
 b=gSIYRitfz34Xp6Lg6KlE1Do8+R/xWFMqbhpQPI1cvvQIhHzBtk1wTzDNkk7bBbCJ8A
 ASewoqo4zsAuzTK2dN7c+ugbQ2+rkg/4x7YduoVaai5IHEZQKYDK8XmrYRHrxlEV2UjK
 f4WXRYRBAQSc38OxhKluXyHjcWBYcCRX4xwv0gNlItlheGEC3RJ3NFnbgM5dX2Wl3QX+
 SKUlYsYCRYQQKtraX5VUT+wcXk7BsJf7govydg2HBO/kBatpHgFySIxafz/nW3g9/e2Y
 vafTrmbIvUuYfNyHz1BW+9A/55q2sKCByS/LP9IbtRAGdqrJrYVg8tHMHXtqvgbNNDlK
 wIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774365362; x=1774970162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qjqJxNMnvYa7OABy1cHJTN3Gfs5S/Qdg7Biy0vVgP/s=;
 b=sM4SFFDNJ7oaLE/XmDIW4m0xuP4/8dUpAD4MuOo78g6zjXwxU+f+xE3dgttO0mSA7w
 hXOn3nLavuVtUrgO85tK0q1s8w4vZ7RyCLGpxBh5F5DsLNWyG8soR6lOws7TGJaQlTnE
 85T5UJXQq0KZKuEIiuCCrXu/ndL1WbL9dgHdM4ZSoZrXuFdVEutbo/67OI6NRvQelNE8
 QEAaeJE13U1aTqF24jcFdIn36ERzGJQS+95s6XqdyKyUYAKjvtHBiKYIC3OG07FLo8ii
 3hcTIPikvl/cdc3HESjppmFvreytxyr0XX0CpWqQnCUOe47GbAObhfdkaAblGtaP6haJ
 A2AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdTb3FRo1uWsm0Vjh0T0SRsbxhmjmcurHXu5Tto833FDmH8pVUsk4bgH6lhzNffImw8O4=@dpdk.org
X-Gm-Message-State: AOJu0YzDine9rKyztgmCSSQFTF2ErukILApJngUX7D0H1WQf4HOsKxxO
 WeN2nHYBxkn4iQL9yW9jKZGOXDhejMoADcbdoe5OOEno0/BBq32E9HtwnBlCoWlSl+Q=
X-Gm-Gg: ATEYQzxbXa47ZWXCGAzytj3rKNAxQDZiJkf56uA1MNiVQgmp+fg0QJ0ckF6ao+Yk4M3
 PlTKGGQt1vKgWfXxn1yW4PiZ3VzqPts385vTIdO/nABwphqWNsPnQlT7otD8l82kt4OA5ng/Rg6
 36D5D/GzSPFQ6GjbSa92gZUMb2iVvZvU1bqX9s/sronPPf//TPtnaZHvtEVHARp4PStQqc4JtQi
 s2RqWUuO79S2/PKw7zSWItsm/ECjakykAOj4oHLFDxyXl5DjbFd5xQI4YpqrfVzLrE3R//UVeyi
 TDPcRfRMzsTrM1hW8cU+PpcTqspq/PUHOnuAQMJUc0u1H8tUB+9NtGGEu9JLMfQxRC7a+ZQA0dT
 zYYDULwkPN6kZwgSPyX0UYKMU5k943SaCPdsYMLx6t10KYAPIobXYlRVHST99SiQHUDR/x6Any8
 B2stQqvv+csC7UsADzyhscAOynb/p+1H0BROI=
X-Received: by 2002:a17:90b:35d0:b0:34c:fe7e:84fe with SMTP id
 98e67ed59e1d1-35bd2d0dabcmr16102108a91.28.1774365361933; 
 Tue, 24 Mar 2026 08:16:01 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c087cd95bsm1556117a91.13.2026.03.24.08.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 08:16:01 -0700 (PDT)
Date: Tue, 24 Mar 2026 08:15:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Aman Singh <aman.deep.singh@intel.com>, <dev@dpdk.org>, Thomas Monjalon
 <thomas@monjalon.net>, Raslan Darawsheh <rasland@nvidia.com>, "Adrian
 Schollmeyer" <a.schollmeyer@syseleven.de>
Subject: Re: [PATCH 1/2] app/testpmd: assign share group dynamically
Message-ID: <20260324081553.1e38e474@phoenix.local>
In-Reply-To: <20260324123709.3471-2-dsosnowski@nvidia.com>
References: <20260324123709.3471-1-dsosnowski@nvidia.com>
 <20260324123709.3471-2-dsosnowski@nvidia.com>
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

On Tue, 24 Mar 2026 13:37:08 +0100
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> Testpmd exposes "--rxq-share=3D[N]" parameter which controls
> sharing Rx queues. Before this patch logic was that either:
>=20
> - all queues were assigned to the same share group
>   (when N was not passed),
> - or ports were grouped in subsets of N ports,
>   each subset got different share group index.
>=20
> 2nd option did not work well with dynamic representor probing,
> where new representors would be assigned to new share group.
>=20
> This patch changes the logic in testpmd to dynamically
> assign share group index. Each unique switch and Rx domain
> will get different share group.
>=20
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---

AI review feedback:

The logic is sound =E2=80=94 assign_share_group() maps each unique (domain_=
id,
rx_domain) pair to a share group index via a simple linear scan of a
fixed-size slot table. No correctness bugs found. Two warnings:

Warning: share_group_slots[] entries are never freed on port removal.
With dynamic representor probing and hot-unplug cycles, the slot array
(sized RTE_MAX_ETHPORTS, default 32) could fill up. The RTE_ASSERT will
fire in debug builds, but in release builds the behavior would be
reading an uninitialized slot. Consider adding cleanup when a port is
removed, or document the limitation.

Warning: share_group_slots[] should be declared static. It's a
file-scope global without the rte_ prefix and only accessed within
testpmd.c. Making it static gives it proper scoping.
