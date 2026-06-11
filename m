Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDFECD98C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 17:06:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 658BF43357;
	Thu, 11 Jun 2026 19:06:18 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id CAE1E40279
 for <dev@dpdk.org>; Thu, 11 Jun 2026 19:06:16 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-3078e0dcd67so192380eec.0
 for <dev@dpdk.org>; Thu, 11 Jun 2026 10:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781197576;
 x=1781802376; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+3EAlrFQtHVaI+QAGaMzGiCpYAc3OEnF5yjBfGkQ/M=;
 b=BZTXtDYMjf1dD0ClYjLv6WE9WLkKao4gkGnNyB6ycZEiumqUVk25h2BmC6c8dO7jp8
 HPPjisgIn3Wj9b3T0F5gpPbIq2ueCd5PYCOdgCjKekqI1TdieEdsz3vsn8yYoezuur+M
 /lhEFkesixFAo5ZK3nWYBKWDNNUgsZtIuITZiMv/ucZKoDHP6PBSkPqkSp3zGUyHrnCi
 MsKen5xJdRK5Ptrf8QbMhItdD4HYX4SaiyKF3qq0ZUi9J8eRC51yTz0lU8dDg+ka7B/I
 R6ZkQ1O/jrotbEfYtmfOMP0ix4Fxnw71LaAX+KSvV8YjTY5n4XefrJF4aFRirjerhcuO
 ybow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781197576; x=1781802376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h+3EAlrFQtHVaI+QAGaMzGiCpYAc3OEnF5yjBfGkQ/M=;
 b=RZXTmMDSHQXgFJ1+Tztl0WKwbIykj7c3i3z1h4hx5fAQoHbsZaPHYgPSI2ciUnRVGc
 sJP1cWvAKJJOD6NvGAiBRDAyFQjqQKw7VUbreQ0xbiW1iDWjn8NNLr65h0OqdokmCsNR
 szr257/oL5OUCXrReiu/VWR307q59ME8AG8Ks9Ntw+tbQAD5vlka6GRng6VKjc1bPURi
 i++lpCHnLnGAL36JE4VOwwFTZ0ZtcMsNbPrOVRBx/gOhhDgWiLpPfuyciKCjaODZoZ4X
 xTP0kROAWvYnBcYvAB9OQ2WnMH5QIBSi+rkTCL8rlEDIdOmudKzTtzTPI502RLa/VHbh
 a9SQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9YON0mrseY4HdYsI6zt00Tl2LT2ACA9QFs8PI5PA3Jt6aSR+L7yV6FqKXhSPtPPfBu0hI=@dpdk.org
X-Gm-Message-State: AOJu0YwaAqHQNLlSfqYDEht9zYYCnH5bdoz8ZIY2APYFG9AVIEamGowZ
 IRec1QwdcletWJD5shdacwj4zGYvwbv6O+0APA17KbhQqggY+rZVZDk68D1ZPQo2Ia4=
X-Gm-Gg: Acq92OFUz5fZluLgwmZZhAiZYVjTeK+rL2hlD6EtD1EY56/pfAlZoduTa48aISHoxWj
 O7z1curXt946SS/bvjH8Ce8RG9sTJBLMdIkOmYxTubDuP0WfdF9Oexim/UGyD6uq3gIxKFVb933
 sneVnpih0UAfzNKkc35EG+B1tBruKeM01t6FVrc+10wt6pd6TKPo5G1GkMd1XI+ZSwVIvG4hUBG
 PxytvsyouxWJNtAnL371im88t3kNIA8IbpAvE3KvlMgePoE9iCMUlRTo1TzfiopHJ8CKTXZIgGE
 477TKjLQBHTD7LRumxjROTm9Aj4TcZjJE3IbghK1CQhp1cFB54WJgMKQIz7qc4lec7/5LMuGQlO
 cdoKkdrlM2pJ8VEX4T8m2PYC+o/jTiMTPkS62Ht3pvpiNxeFTkL/7ApF/OJ0QDGPpxap1n3npsv
 j/CPOhBM7nG1TSlhO2fJI8CUSZO/TUJDbTJU1iEHqIBIOW3fye8tllvlUuqG101omeDvZvyQhQi
 yw=
X-Received: by 2002:a05:7301:9c83:b0:304:de94:1c55 with SMTP id
 5a478bee46e88-30804cce904mr3106294eec.35.1781197575626; 
 Thu, 11 Jun 2026 10:06:15 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806c2efc3sm2644101eec.2.2026.06.11.10.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 10:06:15 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:06:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shreesh Adiga <16567adigashreesh@gmail.com>
Cc: Jasvinder Singh <jasvinder.singh@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, dev@dpdk.org
Subject: Re: [PATCH] net/crc: add 4x folding loop for x86 SSE implementation
Message-ID: <20260611100611.17880d3b@phoenix.local>
In-Reply-To: <20260609075712.247286-1-16567adigashreesh@gmail.com>
References: <20260609075712.247286-1-16567adigashreesh@gmail.com>
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

On Tue,  9 Jun 2026 13:27:12 +0530
Shreesh Adiga <16567adigashreesh@gmail.com> wrote:

> Add a 64-byte loop that maintains 4 fold registers and processes
> 64 bytes at a time. The 4x fold registers is then reduced to 16 byte
> single fold, similar to AVX512 implementation. This technique is
> described in the paper by Intel:
> "Fast CRC Computation for Generic Polynomials Using PCLMULQDQ Instruction"
>=20
> This results in roughly 50% performance improvement due to better ILP
> for large input sizes like 1024.
>=20
> Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
> ---

Looks good applied to next-net.

A couple of nits from more detailed AI review, that you still might want to=
 look at:

The current crc_autotest does not exercise the new 64-byte CRC16 path.
Its CRC32 vectors are 1512 and 348 bytes, so the CRC32 4x loop is
covered =E2=80=94 but the largest CRC16 vector is 32 bytes, all three CRC16
tests being =E2=89=A432. So the new CRC16 rk1_rk2 (64-byte fold) constants =
ship
untested in CI. My exhaustive test confirms they're correct, but a
future regression there wouldn't be caught. Suggest adding a CRC16
vector =E2=89=A564 bytes, ideally a non-multiple of 64 (e.g. 80 or 100) so =
it
hits the 4x loop, the single-fold tail, and the partial-bytes path
together.

In partial_bytes the comment /* k =3D rk1 & rk2 */ is now stale
 =E2=80=94 after the patch k holds rk3_rk4 on every path reaching it.
Not introduced by this patch, but the patch is what made it wrong;
worth fixing in passing.

