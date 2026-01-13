Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F172CF45C6
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 01:20:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADC74402E8;
	Tue, 13 Jan 2026 02:20:38 +0100 (CET)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46]) by mails.dpdk.org (Postfix) with ESMTP id 3D265402E0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 02:20:37 +0100 (CET)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-64c893f3a94so9577124a12.0
 for <dev@dpdk.org>; Mon, 12 Jan 2026 17:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768267237;
 x=1768872037; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UIVndeVy7ISJbt4mDuxji4YUYJlTYQnXHO5bJ4QaIyk=;
 b=n4c8Y291GFgMwEsNZfxSOk+dLKg08yW2B5as0jsDFilG4G0Uo/nTewnAAt9nbfm7e8
 9oGcREYt6lSGwGWm1NRTBrX4YUQg+kj/5HwyPULU9lOPY2gmovySB6GODIEoRgskEFlu
 /3UdCPl7NMhsl+IzOgQOWQSrCD29aei+Tsbf84itLKmJWeum1fRHvpUYmdYhqaotjZ3s
 VaBQlBkWEeEY1YNKcxpUvvcNm7bxLX31LiT7nTd6QLqNg3farcrAgTv53G6T4HCd+jFY
 xSorBU8K1zO3qMVHm826N/CokKEk//LhX4wvt0/KcgYxhJfW3yLdcpzTd3nB3xdireZj
 3jvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768267237; x=1768872037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UIVndeVy7ISJbt4mDuxji4YUYJlTYQnXHO5bJ4QaIyk=;
 b=QbKRNbQvQ9ZxXNpcb+f4hmu4HwdrzEqGd6+PrPHzn88WgrGOMFlIxTgLByFzo5ZFRJ
 Qz/4VjE7fZhjufKdzb6pRNd4NPOnWWHSRhaNtFYhgJxNJnN2r5gbroFt0+Qt9//2Vaqx
 KKBTOO9QDSLi0BpSJQ2UtGTlP2ekoczE46s4Orzj1AP402ccmjU4mSO8kq7GlCjPkARZ
 i6EnVjujLSBhLw6iu4l+4NALJ/Kz7xM7l9qgv0yM92w7Ua/pE9b9Uf7X4EcGYXS7/5Oo
 2IPmKDYdlj6M5SOpyq/8dRE5tqgILWQDYmN1ThPlsOO31wsToIzDykrCV6s1DkRA4JC/
 V3WA==
X-Gm-Message-State: AOJu0Yy9zXsF1Wu2O0aauEsHfFI4gfNYolv0pu3yYWN4NTRypW+4w5SR
 gV/rw1Y8hv6lSjbHy9J85/+9zggnejdPs0nfui6/gGlAPR0ckno6wSD2BieZxbWEQrI=
X-Gm-Gg: AY/fxX7xkWm1ExxAXKUQT7lMyzu9JdDpgHe6z+1lSRKulSrP7Iv+KkVqYTufgNas0f/
 jqtT+0Ugnyh2ywe7hG6BD8SPmKLBkyWoux6PVZGorJInTpplYtDPZ9G/bw4XCdEnWenwS/qJ8Li
 jFLYYH1R8PyL22g2+IrbX3v1SnqvVFHyox8K1fzItcUc0P4Sy5bEesOUlnGSD+2zxC/umenByYb
 d9+WSMd8kfnWa9ezMOBC+8f1NYaeYDnzWJ0pXSGZ8R9TuKc6cSGJqUxVXMfU8FE0BEXcpmiGBtT
 HliF1Hz6rTizvsJJbpLWlGzWrkGm4FLoQ+3T4jEOG+UKyt+QvyjTy3ucozY0bBho/ZJvB4//EFl
 4m2LSXo6dgPOmgIGb4aNQcOfbR+LqcKGIj5jd2h2cBkkg2AQCzFR9o7PqOUIzKPPRrn09iuRGd9
 wyZEtzJ+ycIbhExp92XhXxr5zM4irRWeXHJ3gMyErJYb1tjLdIklM4
X-Received: by 2002:a17:906:9d2:b0:b86:f9d3:c with SMTP id
 a640c23a62f3a-b87359a09f0mr77974366b.26.1768267236644; 
 Mon, 12 Jan 2026 17:20:36 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a4cfe76sm2044699466b.40.2026.01.12.17.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 17:20:36 -0800 (PST)
Date: Mon, 12 Jan 2026 17:20:30 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maayan Kashani <mkashani@nvidia.com>
Cc: <dev@dpdk.org>, <rasland@nvidia.com>, <stable@dpdk.org>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH 1/4] drivers: fix flow devarg handling for future HW
Message-ID: <20260112172030.1ecf0a1a@phoenix.local>
In-Reply-To: <20260112092439.14843-2-mkashani@nvidia.com>
References: <20260112092439.14843-1-mkashani@nvidia.com>
 <20260112092439.14843-2-mkashani@nvidia.com>
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

On Mon, 12 Jan 2026 11:24:35 +0200
Maayan Kashani <mkashani@nvidia.com> wrote:

> SWS (software steering) will be disabled on future hardware generations.
> This fix should check for SWS capability bits and return relevant error.
> Update the defaults for the dv_flow_en and allow_duplicate_pattern
> devargs accordingly.
>=20
> - Default dv_flow_en devarg value will be chosen based on whether
>   NIC supports SW steering and/or HW steering.
> - If DV flow is not supported and allow_duplicate_pattern is
>   set by the user, forcibly disable it and emit a clear log message.
>=20
> This change improves reliability by ensuring only valid
> configurations are applied, and provides clear feedback to
> the user when fallbacks are triggered.
>=20
> Fixes: 1b55eeb7b76f ("common/mlx5: add ConnectX-9 SuperNIC")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> ---

Experimental AI review was generally happy with this patch.

The only thing it squawked about was:



## Revised Patch Review: `[PATCH 1/4] drivers: fix flow devarg handling for=
 future HW`

### Commit Message Review

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 Pass | 47 characters |
| Imperative mood | =E2=9C=85 Pass | "fix" is imperative |
| No trailing period | =E2=9C=85 Pass | |
| Lowercase after colon | =E2=9C=85 Pass | |
| Body line wrap =E2=89=A475 chars | =E2=9C=85 Pass | |
| Body doesn't start with "It" | =E2=9C=85 Pass | |
| Signed-off-by present | =E2=9C=85 Pass | |
| Fixes tag format | =E2=9C=85 Pass | 12-char SHA with quoted subject |
| Cc: stable@dpdk.org | =E2=9C=85 Pass | |
| Tag order | =E2=9C=85 Pass | |

#### =E2=9A=A0=EF=B8=8F Warning: Subject Prefix
`drivers:` is generic. Since this primarily affects `net/mlx5` with support=
ing changes in `common/mlx5`, consider:
- **Suggested**: `net/mlx5: fix flow devarg handling for future HW`

---

### Code Style Review

| Check | Status |
|-------|--------|
| Line length =E2=89=A4100 chars | =E2=9C=85 Pass |
| Explicit NULL comparisons | =E2=9C=85 Pass |
| Comment formatting | =E2=9C=85 Pass |
| Function naming | =E2=9C=85 Pass |
| Documentation updated atomically | =E2=9C=85 Pass |

#### =E2=9A=A0=EF=B8=8F Warning: Implicit Boolean Tests on Integer Bitfields

In `mlx5_sws_is_any_supported()`:
```c
if (hca_attr->rx_sw_owner_v2 || hca_attr->rx_sw_owner)
    return true;
```

These are `uint8_t` bitfields, not `bool`. Per AGENTS.md guidelines, prefer=
 explicit comparisons:
```c
if (hca_attr->rx_sw_owner_v2 !=3D 0 || hca_attr->rx_sw_owner !=3D 0)
```

Same pattern appears for `tx_sw_owner*` and `esw_sw_owner*` checks.

---

### Summary

| Severity | Issue | Location |
|----------|-------|----------|
| **Warning** | Subject prefix `drivers:` could be more specific | Commit m=
essage |
| **Warning** | Implicit boolean tests on integer bitfields | `mlx5.c` |

---

### Recommendation

**Acceptable for merge** =E2=80=94 No blocking errors. The warnings are min=
or style preferences. The patch is well-structured with proper documentatio=
n updates and correct tag formatting.

