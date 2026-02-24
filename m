Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11256F3C9AE
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 16:00:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 031EE402E9;
	Tue, 24 Feb 2026 17:00:54 +0100 (CET)
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com
 [74.125.82.194]) by mails.dpdk.org (Postfix) with ESMTP id D84B1402DB
 for <dev@dpdk.org>; Tue, 24 Feb 2026 17:00:51 +0100 (CET)
Received: by mail-dy1-f194.google.com with SMTP id
 5a478bee46e88-2ba64b5a53aso5357302eec.0
 for <dev@dpdk.org>; Tue, 24 Feb 2026 08:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771948851;
 x=1772553651; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k05AhOTuCZoI12aS/JfbP/fkvD4XC65rBxdzy6M8Bbo=;
 b=QYRTGCGhDqReoikCW6EunXvMS+tBVs0hsIQwkE8Vi/bAr8ZFM3D95uEcgzg9qolGII
 kcpCNyULLowYIrQtrKhQf2wGoSChKfTAbiJre+9vhwdIPBIypXRkeuv7cNXiwyp58e8x
 xOcLcE4ijtwiY/BSCP717+6Nlc3hVdZkHkIYfyngssg99ss3aE3zflPg7asUX1LDv41g
 H8nlYmnqXydROwQJO9S3PMuJLfm1WVXfvgKqSewo66dFH6QxoQFHnutnO/TuYynFhsGk
 4U5vn4Zgcz9TOZhKJSP4swoVzw9K14Hv2fb0Ec1urVy/0qWxlCTLBaaYh1BOaCKy+dwd
 BXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771948851; x=1772553651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k05AhOTuCZoI12aS/JfbP/fkvD4XC65rBxdzy6M8Bbo=;
 b=Eh2blOq3INYCY/qjOR+uT6XCBIitxOkOwSOoYiEpmd5SgPUyK9a1UPyLm6Gbgqhmwd
 Vg2yJY4sdCqODfhqZAwQAL+s1H/X2eTPGrt9L9dzEumYsvRmuIn/pxaRWb+nXN7WoVUq
 /yEwm0VfQcO4QtCRRVzt3bg48rOaYyXjIHZlBakiKc7dUNxakUESmlMTgNCDN5Kv72su
 uEQfS2MGKihNJraNHJRxjGCJwDBAcQeRvg25GwFJym/JGcWzj3gykR3hugSqR1p/Appa
 gPI2duBZSC6IUtDwn7rO9W0jmUEGDbFxQ8wZ/tXM3H7i6j2z5svXZPUmy7QsGeCr9dXH
 7H2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUM9Lls1Zv8gWUvVgeDSXw+nUJwSyXYzyjyQqk1Ople+3Lvfv5OBMEkXd8BM0GSnB88Sk=@dpdk.org
X-Gm-Message-State: AOJu0YwSNWnVHyS9jZV1Dg+lklsLKLSggK0X33UN2ryy8ZIzMIhiBU2A
 rNyeqtoTJYmJ5tsJjUhny5ZgnpQyKjnJmUgbKiR0Zq6PwrDvCs7DfXjp8cJabpnz9BM=
X-Gm-Gg: ATEYQzwvx8y/gGpUfroeaCkMIUmDIjRoFynHtVdhMMr5+0cwznnjFgmxrm44XZRepQm
 FoT1hsP/idfWJEvb3kl5pFICTDtXtpqZ5MDupI7J+wHvfZAHMBbzIxqnCrAba+RgugYNJ8OXIRe
 1zf6NCEzrsiGznlL4aAPK5mmFqWM80+PNVTnuB9R9GPtFBFiPfBjnmU/2RiJq5rs+MfjNfi5vqq
 wYPTDWF7GedzXhT2GBJm3rPGUapPQauqvCKrymhdSqLt8z7nUUFbOBhi67bqK1aPMNn50F0JUQi
 UkWHQDxWD2LRsofu/rM3vQ6iNgFKdGZOeyHrR0SikceN+w3YJEKuSzKJbykEiDAzuaZHw3HRvpo
 ndTeIZF7G51/P8nOTzP/TbKcxPqPVFta+4IFo0XNBpqyJXfVNeJW+WOAIOjzzaCCR1XmMty0lOe
 e4zdVXJCnZkKjTlaDS5lOTzIbydIcJi3s5HSfVeHHj8U9nS6Whm2aAPYNKQVD8bry8jc9jOFZ19
 /k=
X-Received: by 2002:a05:693c:60cf:b0:2bd:b4d6:d9b0 with SMTP id
 5a478bee46e88-2bdb4d6db35mr455045eec.0.1771948850509; 
 Tue, 24 Feb 2026 08:00:50 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bd7dc35362sm6844027eec.30.2026.02.24.08.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 08:00:50 -0800 (PST)
Date: Tue, 24 Feb 2026 08:00:47 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: <vignesh.purushotham.srinivas@ericsson.com>
Cc: <konstantin.v.ananyev@yandex.ru>, <dev@dpdk.org>
Subject: Re: [PATCH v2] ip_frag: support IPv6 reassembly with extensions
Message-ID: <20260224080047.711938b1@phoenix.local>
In-Reply-To: <20241015082133.3910533-1-vignesh.purushotham.srinivas@ericsson.com>
References: <20241015082133.3910533-1-vignesh.purushotham.srinivas@ericsson.com>
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

On Tue, 15 Oct 2024 10:21:33 +0200
<vignesh.purushotham.srinivas@ericsson.com> wrote:

> From: Vignesh PS <vignesh.purushotham.srinivas@ericsson.com>
>=20
> Add support to ip_frag library to perform IPv6 reassembly
> when extension headers are present before the fragment
> extension in the packet.
>=20
> Signed-off-by: Vignesh PS <vignesh.purushotham.srinivas@ericsson.com>
> ---
>  .mailmap                          |   1 +
>  app/test/test_reassembly_perf.c   | 163 +++++++++++++++++++-----------
>  lib/ip_frag/ip_frag_common.h      |   4 +
>  lib/ip_frag/ip_reassembly.h       |   2 +
>  lib/ip_frag/rte_ipv6_reassembly.c |  75 ++++++++++++--
>  5 files changed, 179 insertions(+), 66 deletions(-)


This patch was never reviewed in detail.
AI review found some issues, it would need changes.

## Patch Feedback Summary

### Critical Bug =E2=80=94 Fix Required

**NULL dereference when first fragment arrives last** (`rte_ipv6_reassembly=
.c`)

The code sets `fp->next_proto` *after* calling `ip_frag_process()`, but `ip=
_frag_process()` can immediately trigger `ipv6_frag_reassemble()` before re=
turning =E2=80=94 which dereferences `fp->next_proto`. Since `ip_frag_reset=
()` initializes it to NULL, any flow where the first fragment arrives last =
will crash.

**Fix**: Move the `fp->next_proto` / `fp->exts_len` assignment block to *be=
fore* the `ip_frag_process()` call.

---

### Security Bug =E2=80=94 Fix Required

**No bounds check in `ip_frag_get_last_exthdr()`** (`rte_ipv6_reassembly.c`)

The loop advances through extension headers using `ext_len` values read fro=
m packet data, with no check that the accumulated `total_len` stays within =
the packet's actual payload length. A crafted packet with malformed extensi=
on headers can walk the pointer off the end of the mbuf's data buffer (out-=
of-bounds read). Add a check that `total_len + ext_len <=3D ip_hdr->payload=
_len` on each iteration.

---

### Minor Issues

- **Typo in comment**: `"or th next header"` =E2=86=92 `"or the next header=
"`
- **`ip_frag_get_last_exthdr` return type**: Returns `int` but accumulates =
into `uint32_t`; large crafted extension stacks could produce a false negat=
ive error return. Consider returning `int32_t` with a documented cap, or re=
structuring to use an out-parameter.
