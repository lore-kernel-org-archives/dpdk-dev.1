Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CADCD98F2
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 13:36:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECF96402D5;
	Tue, 23 Jun 2026 15:36:09 +0200 (CEST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id 5B72B402B5
 for <dev@dpdk.org>; Tue, 23 Jun 2026 15:36:09 +0200 (CEST)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-51a14efe25fso35354981cf.1
 for <dev@dpdk.org>; Tue, 23 Jun 2026 06:36:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782221769; cv=none;
 d=google.com; s=arc-20240605;
 b=QJWP6RvBmJplWY2lP1QVL1x+gyAi06rdpEEaYRJEcuB3ikIV1Mlm6AnGXC9+oG3ci7
 nhr56CU50R+fH+Hos/Z2I9pRWjZQnOmP6ds8YbBBrxWDjiHZTNLAI/h7ytKGNTFWZv3G
 kXqsu6l64FywR4LGlKgY3u32VQ6oTOgY0/JTgAjOyw0J1BV2IIk5VbsQlI7yySXJDj5g
 dbNoLDWFB29Kk10l468eYLNr9JzWZ/QPQvJjqbWPbYegcFw6xeknELqDDqn4OF8fLQuj
 visopfW5JiPScw1xQAooC3sswpgsru/PlZ46haPNvLnvhGWIRfJO/vR6qCa7kiOIW3By
 UM7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7OdJH0YsGogl22ppbjL4KWWT7Hll231uZyp6GTYyYKQ=;
 fh=0G8VTDsdZg+vv10hCdhfYHPw9nBlDpQNEf8si+5NnR4=;
 b=CuXJZZ1sAYZhzrntI2qgvwthcZ0U5oVg7gTwhCm3x0snPWR2/u2uLavLO+BcWp0h5q
 GDwv0oxEMmKFnFVxyguLVHcpTmiMNC2aUa9+iMRORVcOtQU/3R5rjb99YhAbBretcrhi
 5lLb6k57Y1ib0/eaxEKLMBUHckBBJ1bmf3i9sBkqQaTHTL22WOwY/NMseXoa2PxHy9gE
 SIQwpVR+HIyiTZQqTbEZQtuD1ND8yYQ5L30zhtXFAais/2Cz4/I3ezCeoOXZsyjmj5cx
 X9PJXwOV99dC72cN4e0KzRctQxWw+OK57tOARCCM7YKLy/F5PvOpZWqnjeDBfguHeaJJ
 6nQg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782221769; x=1782826569; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7OdJH0YsGogl22ppbjL4KWWT7Hll231uZyp6GTYyYKQ=;
 b=MLAkm2qy7jUOFSjIbVZ7oQqxkp/geZy5LzOTKeE71W8Cq8KDIEfTzmAasT/KJJgsNc
 3ZaMEzMdgLGF7WjfCy3mvUf3zeCXyO0YvYUGybiRZBNg9mK3bVZGramYaCgrUOB3W33G
 4d+PNi0B3JqmrVClRSWJ04XjjLUHtBi1/jte7FNoJDtcrUv6RycsTOneSCtvfjEKYtgq
 XuzBWwepjmYTkUy3eUnF0zcLrNu9pLEinZX6+sdUrK+zVHWHGE3CoHM636gGK2eMYGOj
 WSOPct9gNjbLDbZU6zpaj/a3xRJriOiPt8zoIP1l2tVmQABv+i1O3oB54HoStISpOZji
 5tDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782221769; x=1782826569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7OdJH0YsGogl22ppbjL4KWWT7Hll231uZyp6GTYyYKQ=;
 b=qODcUB6fQxPvU41POAF6lMxqiCSQrLrSWXwJttxp35zyfdtxVOIHbSz0AcJejuTdRS
 Y2+P4BlSs294FYGG+SIfFKSxzU8aZSQHdF94fLnW4nkdszWZr/KwZPyHGmAGMAb5BG5C
 QHUnEuGEoyyoW4PZeqLEFJxb+eagAyHI7Sg45jtV0/J75FEkJL065sZVRQeriwu15ScQ
 STa/SwsLJ/Oj3TLa4BUKc11jikxAu6hHDJbHD6wSRuSuDdf80KkkxRvvSaUHKWDdhRgH
 JHoBiymj/92tVGijHEB4+oXkeBRuM9sBCpT8CCh0y8UiffL/wizOqwIAUk7+pwaNW2zg
 xjJw==
X-Gm-Message-State: AOJu0YzQOJ4veVuUJUYGl7ziH72Z9iM7lyV+qj8CS4D/B2p1ri6wUk6M
 LeJ+Sy23VJBGq5IOwEFeb9DNT6m7t/wdJ+CVWgQmFv06wjuwDKjIxPVy3fJOkIddJQgmUamwg/k
 3Vx6866wx0eud5Zq3ujuJgVMIUGZ208GhvGPUUpg=
X-Gm-Gg: AfdE7cn8RjcWmlKUHAWhHCHMtpq78IrRNsX4EWJpJk7/TYzVrO1cDEIkjVqjehS6edg
 I57yl6BQLtPtCm2/rBacYzfjUyomYpWoR6FrWAgdh1tiNjr4eQIUurOClcfBeJjIgWOxh/38ehY
 +hdXd904aQeBgup1B9wGL6+ihSw1xDAOJZHTZbYtnsj8RNkmAIpnPMrK4rv5CinsII5NwhG9jkm
 iCATrRAuOYbGdDNO3d6IVf7L3kQP1qlMFkudTTo5bQZHkHSlZf6opOJG9aFhG28E+T2
X-Received: by 2002:a05:622a:e0d6:10b0:51a:329:e802 with SMTP id
 d75a77b69052e-51a0329e951mr153120671cf.41.1782221768474; Tue, 23 Jun 2026
 06:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260623085433.3190541-1-ajp@marvell.com>
In-Reply-To: <20260623085433.3190541-1-ajp@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 23 Jun 2026 19:05:41 +0530
X-Gm-Features: AVVi8CeXhnCJBZFGof65ZqZ_UYaPP5vP3qSDVQVggxK4_XJuJnhH39q7XdaLe4Y
Message-ID: <CALBAE1OFZduoa9oMHwGyeH8FDO1tMFg+=9GFeY=A0hCTMZsuZw@mail.gmail.com>
Subject: Re: [PATCH] common/cnxk: fix inline dev null dereference
To: Aarnav JP <ajp@marvell.com>
Cc: dev@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, 
 Rakesh Kudurumalla <rkudurumalla@marvell.com>, jerinj@marvell.com,
 rbhansali@marvell.com, stable@dpdk.org
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

On Tue, Jun 23, 2026 at 2:31=E2=80=AFPM Aarnav JP <ajp@marvell.com> wrote:
>
> inl_dev is initialized to NULL and only assigned within the
> if (idev && idev->nix_inl_dev) block.
> Move inl_dev->res_addr_offset and inl_dev->cpt_cq_ena
> accesses inside this null-guarded block in
> nix_inl_inb_ipsec_sa_tbl_setup() and nix_inl_reass_inb_sa_tbl_setup()
> to avoid dereferencing a null pointer.
>
> Fixes: 3fdf3e53f3c4 ("common/cnxk: enable CPT CQ for inline IPsec inbound=
")
> Cc: stable@dpdk.org
>
> Signed-off-by: Aarnav JP <ajp@marvell.com>


Applied to dpdk-next-net-mrvl/for-main. Thanks
