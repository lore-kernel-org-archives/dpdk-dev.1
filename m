Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AFD606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 02:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Hfyd+ood
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AEF74027C;
	Wed, 21 Oct 2026 04:56:49 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 690A34029E
 for <dev@dpdk.org>; Wed, 21 Oct 2026 04:56:47 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2e60f9af6e6so2060775ad.3
 for <dev@dpdk.org>; Tue, 20 Oct 2026 19:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792551406;
 x=1793156206; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:to:from:date:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fHkusr97bRANzjTa09Q4xIlrGgAXhu4jlAzBftmq5fI=;
 b=Hfyd+ood5vtaVjtOYjXvjib1ndNWlffX9bIjY6vYsouiYZwB+LVwuHlwYlY4ZX/llw
 90ocRp90yvK+6BisEybQHZQ0meJ08twHAPcrgKbGwHgD2flcsblAfbqgI0Uu6dUttCvr
 X241rytvxUBO3ZZ241TMNytwJ8ortOtb1l418luLJviSlU5cz0rj5/vxN65pNrlYF7Zc
 reTN53nkasH2iOC9c9jsyb1l5x4gwIR+9GoS8dzxXRNOzj0QHwPXvrYOLwZFiuWaz5Al
 39zRCwSL/TpkAnVXa5ljPijxuzQFi/JDFTUQkWGqgunAVSGDSppIB2qr+mO5cDz+LG+G
 bygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792551406; x=1793156206;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fHkusr97bRANzjTa09Q4xIlrGgAXhu4jlAzBftmq5fI=;
 b=PNOCAY6HXK6N1iBtcjcZst/ZwjFzUipt12y/EfWMbEdjFSBdyR0NlS7PIAqv/nPKXA
 XP8JS6iDOdbh86lq3CkKsLvwJJA65N3nwLoe1cdtXbPbn4MuJn6wdn6TSPA/iBDLXfyr
 +ywE1ZNiI1YlaXcS4HNZROYqYgtPWNnVOV6gWr1eTHSfOVkQ14zjCrbNF5XKp8PlQsuo
 FXQ/HPwbIiq255Ln5SJ65j+Cav1zGTPvo2rWR2+qwF+PZW1ulMhLZFkvuBj3aPcv4tSN
 Wn8Mu+ChuMcF/rR6JHmNIgv3Cp2CDaOkCErrren0VZqlJOmggXhyzL9uaDYSJ9UIhAmI
 rRfg==
X-Gm-Message-State: AFq9FYJW2ux5rYmsCT0XwThaQ+EC4PtWhxZlm2U05Mnf/mE2lK+G44fv
 J3ecA5N+Gwy7JrRl3M9DPQl6bJ1m0rBi8ouFgNy9h7uchW/ds4Eidk4laghuTNcfhuMImDDkk5M
 hHyS/f44=
X-Gm-Gg: AYBFou2SkAQq2zk2KwMO/RFT65QlPbQTFrmxj0FW2jLLpKgq9XCchMWO6ODTIxNTjHG
 ipqWMMe7rPS2k6yRLFPkQV3TgO6wtcNNGD2O9we02yCMS1TavB20a2plbqv4spWssI/cW9fNnfZ
 3XqzakdMsACV488fFttni/GP6lWaX+E/udP16P94FfoqxQhLfnf+Pc9Hq1mprx09/WmInEMwTeU
 UogCzq4xMD9q8bMiMVpk886uOtvb9oUZXofIYZV2oryf/PtCOtZoVo0qwIQkwAjZbupsgHYAy7U
 FkZuRhwHxHQYNWMB233mNZFzSdCsGcf3Ipv/c0EeRHzpdhNajuXZMXdpVqHhxvAzdjCSEErbJtG
 rT6H1hd30GwSoHw09u+WkCB/bueMK9aZ7C3kpJ0DVpO0IwJVqTRh4CpOqEVcqYzp4H4OW6pxucZ
 rHE56VNFjDqIuXzXBPCwxQlY+Uz5p/2PMv4aDdGXU4zoY9ROLyaiwCyL/dYcwEUnHIknvjGnzx1
 0vjNVhfUuht7Nck1M2xh3Z5zb0GK2RqTJ1CYK7CktXHfSjheZtj5FYjNK06xoNbDxs/I8QN50tC
 qyHwm2rxg+d6kNSnO3+Fjg==
X-Received: by 2002:a17:902:da8b:b0:2e7:4a2f:68e6 with SMTP id
 d9443c01a7336-2ea43c71344mr5906835ad.39.1792551406319; 
 Tue, 20 Oct 2026 19:56:46 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea3b43524esm5098225ad.37.2026.10.20.19.56.45
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 19:56:46 -0700 (PDT)
Date: Tue, 20 Oct 2026 19:56:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH 0/3] pcapng timestamp conversion and user-supplied
 timestamps
Message-ID: <20261020195644.3d92163a@phoenix.local>
In-Reply-To: <20261020175732.1552406-1-stephen@networkplumber.org>
References: <20261020152907.2607513-1-dawid.wesierski@intel.com>
 <20261020175732.1552406-1-stephen@networkplumber.org>
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

On Tue, 20 Oct 2026 10:55:41 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> This extends the proposed user-supplied timestamps.
>=20
> The pcapng library converts the TSC into nanoseconds since 1/1/1970,
> because that is what the pcapng file format records. Make that
> function available for more general use.
>=20
> The third patch is Dawid's v8, rebased on the first two.=20
> Some rework was needed to fit in because because adding
> new parameter to existing function creates lot of API and deprecation
> headaches so rte_pcapng_copy_ts() is added as a new experimental function=
 instead.

FYI - AI says its own review is bogus..

1/3 Error, clock_gettime() failure: noise. CLOCK_REALTIME with a valid time=
spec cannot fail on Linux, FreeBSD, or the Windows shim. This is the same c=
lass as the pthread_mutex_init() false positive. Both suggested fixes are w=
orse than the code. Failing EAL init over an unreachable path is overkill. =
rte_panic() in a library is unacceptable. The eal_tsc_base =3D=3D 0 sentine=
l is also wrong, because base 0 already has a meaning.

1/3 Warning, missing test: weak. rte_tsc_to_ns() is already exercised throu=
gh test_pcapng (test_write_before_open, test_long_timestamp). The suggested=
 test is broken: it reads ts1/ts2 and never uses them. It only checks the f=
requency, not the epoch offset, which is the thing the API adds.

3/3 =E2=80=9CError=E2=80=9D on 1ULL << 63: the bot raised it and then concl=
uded =E2=80=9CNot a finding=E2=80=9D. That is exactly the retract-inline pa=
ttern AGENTS.md already forbids. Its own Pass 2 then claims nothing like th=
at was left in, so the self-check is false.

3/3 testpmd hook: it invents a testpmd --pcap=3D<file> mode, which does not=
 exist. It then talks itself out of the finding and ends with =E2=80=9CNo a=
ction required=E2=80=9D. This should have been omitted.

2/3 =E2=80=9CNone=E2=80=9D: should have been omitted entirely, not acknowle=
dged as clean.
