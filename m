Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B625EC110C
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 17:44:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49381402EF;
	Mon, 23 Feb 2026 18:44:03 +0100 (CET)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49]) by mails.dpdk.org (Postfix) with ESMTP id 15A774025E
 for <dev@dpdk.org>; Mon, 23 Feb 2026 18:44:02 +0100 (CET)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7d18d0e6d71so3000646a34.1
 for <dev@dpdk.org>; Mon, 23 Feb 2026 09:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771868641;
 x=1772473441; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ba+7tLvwsXEDCEVPXzfChm/DFnNfbotXjU2lE16uUi4=;
 b=0R0jY5SQ3suwiWIHgMIXToxYlkU9QgQk/J6hSk/8A0o15I9UINR8KP32MQyCo81vgN
 RC+7+9cGmWoalFwFTdGQUnKV50NIozgZsnrtoF542p6f15n5lESDe/laZBp7NB0S1mFj
 7QKrBuKMnlRSa5VhoKzOPHVYthfvF+B9UieElBWOByy9iwaS3cEMO3XjNNwbyWaP01eV
 8wNgwFV0eWO+qFBhyZmw0PX3yiDzdZUH9Zix4bQ3e14j6XYt1h0i1um1yyzSek9IjlnC
 cxmh1QfkVqETX++TsOAnNxr9WJ1e0qst1XqSWnnZa+q986aLAilFHA807waNhsqLzTE1
 AvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771868641; x=1772473441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ba+7tLvwsXEDCEVPXzfChm/DFnNfbotXjU2lE16uUi4=;
 b=Luomjy6xxgWE48QLHveHc54O8z2RsvBFkWF5xTxrAWU/Cr76dYNF6k1/Q7NacJnoZP
 EJKPfmORwmPCXwiBDslB/kTsyLW9f7LLgp9hNK4CV3FhcqXnZ4NcSF9pfljC1PpwlCb2
 juXNdbCOUW68KZYxsvQEjdC3ecHskn2oPxwVPLE+vIC2vCeFedIiCil/3m57Z9tKi+ma
 zP8QHZwxboBX+TgzowE3wjvajsYtS1D9wYAxw9SxQw34CNIQsvPdvfwRnvt0G93k9AO2
 ovy/FvhgWpVpP1s2uwl8IriGKU715wCvOpPbJvGEGlVIC3qHurddmSCMdh1UpEz2dy2y
 C6Gw==
X-Gm-Message-State: AOJu0YzhVLRKovsKl3osO72o3VE73t6WVVwJA0wE9Q1yFVCf8U8C13Au
 QkWA9jeXrpqXijNtK8K/iR8zdrz/7F7/gHMgEL3yY5NO9VBedhRUo8gX2SBVGJVo6/g=
X-Gm-Gg: AZuq6aKm78Uj193apceRFTGuH41PhFfT8nnaIEU8cTbA0cL0J8iv9J11SuSokqIZKRo
 lk9q10IlKMqy8nBYPdhtCuw0AS6Zfo7EgmEYh/YtZnIhoMlfE5/etvU8WSx1UmtbxUpqOcT8uc3
 1FeiXbYVkmH2AUGdXjQsB8tMV5DGpyVcx+P7wRYUcDRmNgMLNK1qwwVv7yqTr4z7CNRuTlH15XW
 j/3AGYLuj6fAGnDWrk/NHe9D7MXRH1/GmpMf0EvMctrNwBfZI2zr5PP7/z9Fa2Q2aGlG4HYwLPz
 s8E18rPIbG5YkHzW4M7mpiwLI/GQ8MiNVClqNkK6TwGA615noyZOGkUVh5hcyxIgaiXcIir7VsE
 8J8ILjwNYuZbTJg61HNveq2AVTv6JYrLi45Zlmc2g0aW3YJq4nGCgYmYV+JMO8o61YJUR8zW0RF
 PmIM0WW29dVZfaXOmD2HDt/PvnLW7BqgyfuTUNGBF6mny+x7Shp3kO/fIxPSzRicyF
X-Received: by 2002:a05:6830:6996:b0:7cf:cc2c:1d7b with SMTP id
 46e09a7af769-7d52be3af25mr5936313a34.10.1771868641263; 
 Mon, 23 Feb 2026 09:44:01 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d038804sm7723275a34.18.2026.02.23.09.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:44:01 -0800 (PST)
Date: Mon, 23 Feb 2026 09:43:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linux.microsoft.com
Cc: dev@dpdk.org, Wei Hu <weh@microsoft.com>, stable@dpdk.org, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Long Li <longli@microsoft.com>
Subject: Re: [PATCH v2 2/8] net/netvsc: fix race conditions on VF add/remove
 events
Message-ID: <20260223094358.58f5b0f4@phoenix.local>
In-Reply-To: <20260221024540.659098-2-longli@linux.microsoft.com>
References: <20260221024540.659098-1-longli@linux.microsoft.com>
 <20260221024540.659098-2-longli@linux.microsoft.com>
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

On Fri, 20 Feb 2026 18:45:21 -0800
longli@linux.microsoft.com wrote:

> From: Long Li <longli@microsoft.com>
>=20
> Netvsc gets notification from VSP on VF add/remove over VMBUS, but the
> timing may not match the DPDK sequence of device events triggered from
> uevents from kernel.
>=20
> Remove the retry logic from the code when attach to VF and rely on DPDK
> event to attach to VF. With this change, both the notifications from VSP
> and the DPDK will attempt a VF attach.
>=20
> Also implement locking when checking on all VF related fields.
>=20
> Fixes: a2a23a794b3a ("net/netvsc: support VF device hot add/remove")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Long Li <longli@microsoft.com>

AI review spotted related issue.

**Patch 2 (net/netvsc: fix race conditions on VF add/remove events)** =E2=
=80=94 the most complex patch in the series.

**What it fixes correctly:**

The old Tx/Rx paths had a TOCTOU race: they checked `vf_vsc_switched` witho=
ut the lock, acquired the lock, then re-checked. A VF remove could complete=
 between the first check and the lock acquisition. The new code takes the r=
ead lock *before* any VF state checks =E2=80=94 correct fix. The lock is pr=
operly released on both paths.

The upgrade of `hn_vf_close()` from read lock to write lock is also a real =
bug fix, since it modifies `vf_attached` and calls `rte_eth_dev_close()`.

Moving callback registration into `hn_vf_attach()` with proper rollback (vi=
a the new `hn_vf_detach()` helper) is a good structural improvement that ti=
es callback lifetime to VF attach/detach lifecycle.

The unconditional clear of `vf_vsc_switched` in `hn_vf_remove_unlocked()` i=
s correct =E2=80=94 if the VF is being removed, the switched flag must be c=
leared regardless of whether `hn_nvs_set_datapath(SYNTHETIC)` succeeded.

**One potential concern (~60% confidence):**

If the VF is successfully configured and started but `hn_nvs_set_datapath(V=
F)` fails at the `switch_data_path:` label, the function returns an error b=
ut leaves the VF started and attached. The callers don't clean this up. Thi=
s is a pre-existing design issue the patch doesn't worsen, and the hypervis=
or may retry, but it could confuse subsequent add/remove cycles.
