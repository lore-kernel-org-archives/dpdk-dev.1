Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F051CDB471
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 07:34:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3DBB4021F;
	Mon, 22 Jun 2026 09:34:38 +0200 (CEST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTP id 95DF840150
 for <dev@dpdk.org>; Mon, 22 Jun 2026 09:34:37 +0200 (CEST)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-51a019e9ea9so25035701cf.2
 for <dev@dpdk.org>; Mon, 22 Jun 2026 00:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782113677; cv=none;
 d=google.com; s=arc-20240605;
 b=Sug+A04euGc51duQRgwLTg8tyQLHu8i0f/vOBX2TW5toMR82yIWXH5r+Am3Y3rGP8A
 inc1eqmr8+iLaGBLLBfI7sprc480WDnXQYoppzBsWf+59oPVa8InjOpmDERIQif9z9Ul
 MCYWDl8lc0nTn27Vaaxub5vzTyl3xIgEHL85S9qIznPIir45azk4QmZXsAZzrsX5It2+
 8vxSqcx5W0gH3ebifGlBbNsmcsXde5MAXrL2gv6K0tod1hwjwy+K4lkHTZcqBI0Pzkw/
 ZoRzEqnWSKUGKLjlIJYpHpJ//1Dk/yqLkKoej2j6G1WPGfaxB7evRwwXvA7Pwk2KF4Zx
 hsAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bKhsN7ZlI63h/2twScthZATAUDe1o8heCqt0voABSxk=;
 fh=H+AIAtj7CqmGfkJ7LUylfJHECI+djGy0sfwAA0JWTJ8=;
 b=OOPj0otC67+QSCnU70DdYw0F3li4Iu5BdOjjgWcaDDfL0TjlOaeKvvBpa1zYssExUA
 YdZcWuA6QrY+5AIV67lxvtTDdRbCJXpeQSJB8Pf2pAh8bZ9NE7E7Y2nDZWnMTuIrnjdv
 tPg/lCIdCERWE/sS2JVVP6JcnlSYVgdthx6D/Uc3tvzMNBy8n1ouxkTmvbJ3htRe8XTz
 0bDkHspx45PyilYCxvi96l3SUS2bQJ8xlshe8REpqZmGggFNrI0cSJi/0cAeVwET48EQ
 rmgSFRK66IJpqe6hfVugDLakRMVeP1SXsimwsVm+UpnK0Iwtg6EpJP52xVdi92AcSsE9
 zdSw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782113677; x=1782718477; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKhsN7ZlI63h/2twScthZATAUDe1o8heCqt0voABSxk=;
 b=UCuaoQLzcgSYKGWMWYbbaBo8gizjb4U3zrhyaXkYZu9DbuJnvmT0YpFXfwKbBMEx7b
 497pqeY0p8OmdI2KLi4KxSTtQUEDQRBA/h0HKZlGh4ck5PclVOLHxw2nGRcR7+M5w3mw
 kEo3KwbmJdFd+Nya6KFR06FMRfLJ7ZkxszsAlvW/cSJLcS7LYGALs/kcesUenvlBOmBB
 rOa2iarTBjJkarI08rV6Cl2R3Ptv7oVv0p2fqr09V5mqkwFitL7Y5U7D/JupE0SAaw3T
 mtu3YC+bzDw8VBK5+bNP7fzpFzwFww+94Ty6zKU0WBLjFEMFxnS5nG5ZMOD9nVmVHU1s
 KDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782113677; x=1782718477;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bKhsN7ZlI63h/2twScthZATAUDe1o8heCqt0voABSxk=;
 b=NEFGJj0Guyj4BuOWMJ3b4bY2m45MnRyKL2SAy35sfWe9cbtK4pc7jdRk0zPFKP/Azo
 oAGieM+EuIVOdvAMK1tFc/I9n83EHr64iZyXbTpOVdSWbzu+DGLkrzhdAE2vUEOo3hgZ
 r8h91HZxtpAU4DBE9D8kZcIYgbey8V0JKHSIuHkXwqXNusejcdZ868AJjTYg82I1dFg1
 DMFSc09dshGPXDzxeMTPpHxUmyAF5vG6yywX2zeu9aJCegWjVtg56nNfiGtem65aJg24
 dwhZta9rfeVo3Q/4TKtiqUswCRweGvitHe+WFeYC2OdtlNV5nDbrnd0BGMa/8w4XiHVr
 vjsw==
X-Gm-Message-State: AOJu0YzRlWMal2xHlqjKsD/I1v5qVR7U8GlEaG1PTuIPSufofOGPmE/E
 iodI11oBXthl4Y6E+uAZtpCGj2AD+Z3b4ugxoSyQVF2YoIvnSOSPbCiuk7ASruAu7E64gk2A8Tt
 LxmNOBA9KU/Sfnwc2yaMfvUC/tnBMnEs=
X-Gm-Gg: AfdE7clmO6FCor27HDuKq1e55ICKrpJUTB2ZiktdWqYoi3CwuZ70ICBhVqkNAjUGtBa
 8j+2rRDmS5/9U02NR46z9vRFU1z9MkA5l1XyKvL9AHu3EvKQg/+iLIiGVgDrgPe+qsCbUCtMDHF
 raCwPI1UgIjFb5s2E/TbohS1b2vNp8q2H8pIkjPuYfGgDYV8j+qJxXr86CPeW7M/Dmfs+YResE+
 07nChjlUXYaDmtMymqwTXWaiAWMRonaqOCSVzt/yRoo10YY8WdgOaPBFzAWGoKsZNH8
X-Received: by 2002:a05:622a:5c10:b0:519:e020:6087 with SMTP id
 d75a77b69052e-51a066c2935mr150301521cf.11.1782113676643; Mon, 22 Jun 2026
 00:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260605224514.651081-1-stephen@networkplumber.org>
 <20260605224514.651081-3-stephen@networkplumber.org>
In-Reply-To: <20260605224514.651081-3-stephen@networkplumber.org>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 22 Jun 2026 13:04:10 +0530
X-Gm-Features: AVVi8Cc0Bu2wpMSZMn6Ch2vPTTxbBNiVWgxhM8ue3vDlg0LQ_83_HrprbVqK0z8
Message-ID: <CALBAE1P4bBKWTXoT1-YHexsWi-TQvXpfF+Omsu8rGYs64uUi-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] common/cnxk: fix thread-unsafe NIX telemetry parsing
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, 
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>
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

On Sat, Jun 6, 2026 at 4:15=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> cnxk_nix_tel_handle_info_x() backs the /cnxk/nix/{rq,cq,sq}/{info,ctx}
> telemetry commands and parsed its "<pcidev>,<queue_id>" parameter with
> strtok(), which keeps non-reentrant state and races when telemetry
> callbacks run on per-connection threads.
>
> Split the parameter with strchr() and parse the queue id with strtoul().
> While here, copy the full parameter (the length was capped at
> PCI_PRI_STR_SIZE + 1, truncating the id for longer device addresses) and
> reject non-numeric or out-of-range ids instead of letting strtol() alias
> them to queue 0.
>
> Fixes: af75aac78978 ("common/cnxk: support telemetry for NIX")
> Cc: stable@dpdk.org
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Series applied to dpdk-next-net-mrvl/for-main. Thanks
