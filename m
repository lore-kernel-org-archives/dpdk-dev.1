Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F325D2629A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 20:00:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CDF740E0C;
	Tue, 20 Jan 2026 21:00:29 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 9903F4026C
 for <dev@dpdk.org>; Tue, 20 Jan 2026 21:00:28 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47edffe5540so50061375e9.0
 for <dev@dpdk.org>; Tue, 20 Jan 2026 12:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768939228;
 x=1769544028; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xSRmPzpm5WRlpKrbB19rREVwmr2mvnNCvWrtPjU/xjI=;
 b=h3epdtyMbXSUquaDQt/kt157NCVw6CvOJ14Het4rzCFUvdWCUHDmtwZJKIDP1KaC4m
 TzRb9/KwRjQI0oH0oQ0daf12nBVjLr0A+/QUpevynOPHWJcwDU0GeFnntLZoRN+DUnhX
 S9Pp49qENlxo5qhn8tsQ9O9ak8aepYeof/iKy4zZkd7stEKYsXT4wO6OAqS8oqMEJn1t
 Px5aC6HlJQLnXD59bJamNqRFZep9bs2a+CEdBxTjPBCAXOrK8R477Sm0XwoBRvvT9BE+
 W7EslxKlHiM+AOgk5d6D9mApKSLECGSaF0Kv5+G8XKnmuMJk4qGn5BOmDUCWOHd/m87d
 5uOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768939228; x=1769544028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xSRmPzpm5WRlpKrbB19rREVwmr2mvnNCvWrtPjU/xjI=;
 b=O2cms28UFWF+jJmIPA2hcahopbDSSwBsRBXrJKBWprDAlwMPfkhasBBC2BJqJWrr4E
 fvX+fhghZk82m8pREVLQxFwDnUDeZZnigeq4osJ+vUkb8RN4hSlAYEsyu2DAbjxPKz2D
 nQAsKSZUqiMzE/Yyr9fPm9n1Jaou6aorQafMe4+xVNydGvJtsSAxKuzuBimLRZw5IDxX
 UYXiaWrwUCLyClnO5MDbP4diwP7JAtc5igl126zyOGFGkP+WAWT6I0SHArd8wX9/Ca8P
 Jws6TzBkyhijcmvdvvlAT1mUCUgyqvotE47xbdT28JvFpCJOeYI+lBvipwjJ/fwvIudg
 jSrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVZa6BmsWhDleDOJJ27XnFYGchX8g36n+4RKrg8R0JS7nWiKoXyyQtnG+4lG5eLCm1EL8=@dpdk.org
X-Gm-Message-State: AOJu0YzGAccG6DtVVJ/+RxtH8zNbHcKZomhv4NeCPk4Hz1JTTU+Eo3GD
 5aUVy3sVZPSrVyki4QwUyUJ8RDAW4JJ5XyICU2oayAacvkX43gUK8SP7tGi/+1b0W3s=
X-Gm-Gg: AY/fxX7giJgM28aOOreM6RHkWlqrZbK5F21bMW+MfTVIYg5KXKg4IJznCfArHPgxhiT
 J7CcjhX/R6K0wV3CBUkj4x4dDjtc8x8qn/k9HlwHUljuUZimp2wHiDdYDhX1ByASSoG5CIYhOis
 FM0nWr5yPBfTcz9i/QgiG9aGuHlEaBwwqlzxMMAdE5HU2m4o/iXz1L/c6QlZd8oX4qiLVVE+x3J
 dueFofRUKZTKOtDrL0lMREWshZxmiE74Nb6aE1UV1FOUZX5Oo2kAIT8EZXfI2Tm73RVmukxdO22
 65rnoK/UbvFmAcP/7NXbeGDssbecDH/tJeSrjEJPPncYPj/9iov9QbBgO4a4DtagwsdOxk60c0E
 ESH2bTQNXxGW75dCq0JKTTsUemw0JuuWMtG6PQMi/XJFka+22KRyui6vmajYujCqqYVbYWKUXcA
 kHNvT7yBJ9pKwlojEQuLFnYhq4qc0LBY8tvWuiI/eD1M9K3OL3Hf2P
X-Received: by 2002:a05:600c:8217:b0:47d:5d27:2a7f with SMTP id
 5b1f17b1804b1-4803e7f18eamr42894355e9.26.1768939227829; 
 Tue, 20 Jan 2026 12:00:27 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm29074143f8f.26.2026.01.20.12.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 12:00:27 -0800 (PST)
Date: Tue, 20 Jan 2026 12:00:22 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org
Subject: Re: [PATCH v2] mempool: simplify get objects
Message-ID: <20260120120022.6b704e1e@phoenix.local>
In-Reply-To: <20260120101701.467039-1-mb@smartsharesystems.com>
References: <20260120082049.466224-1-mb@smartsharesystems.com>
 <20260120101701.467039-1-mb@smartsharesystems.com>
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

On Tue, 20 Jan 2026 10:17:01 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> Removed explicit test for build time constant request size,
> and added comment that the compiler loop unrolls when request size is
> build time constant, to improve source code readability.
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Not sure I agree with what AI review shows, but here it is:


## Commit Message Review

**=E2=9C=93 Good:**
- Subject line: 29 characters (well under 60 limit)
- Proper component prefix: `mempool:`
- Lowercase, imperative mood, no trailing period
- Body properly wrapped under 75 characters
- Has `Signed-off-by:` with real name and email
- Version changelog correctly placed after `---`

**=E2=9A=A0 Warnings:**
- No mention of testing or performance validation
- Missing justification for why this simplification is beneficial

## Code Style Review

**=E2=9C=93 Good:**
- Comment formatting follows DPDK conventions
- Lines under 100 characters
- No trailing whitespace visible
- Consistent indentation

**=E2=9A=A0 Code Logic Concerns:**

1. **Removed optimization paths**: The patch removes `__rte_constant(n)` ch=
ecks that allowed the compiler to optimize for build-time constant request =
sizes. While the comment claims "the compiler unrolls the fixed length copy=
 loop," removing the explicit constant checks may reduce optimization effec=
tiveness.

2. **Removed early return**: The old code had an optimization for the case =
where `remaining =3D=3D 0` (entire request satisfied from partial cache use=
):
   ```c
   if (!__rte_constant(n) && likely(remaining =3D=3D 0)) {
       /* stats and return */
   }
   ```
   This early return is now removed, which could slightly impact performanc=
e for this common case.

3. **Unnecessary code movement**: Line 127 moves `cache->len =3D cache->siz=
e;` before the loop when it was previously after. Since the loop doesn't us=
e `cache->len`, this change appears cosmetic but reduces code clarity - it'=
s less obvious why the assignment happens before consuming the objects.

## Missing Elements

**=E2=9A=A0 Should address:**
- No performance testing mentioned for a patch that removes optimizations
- No explanation of why simplification is worth potential performance impact
- Consider benchmarking showing no regression

## Recommendations

1. **Enhance commit message** with performance testing results to justify t=
he simplification
2. **Consider keeping** the early return at line 111-118 for the `remaining=
 =3D=3D 0` case as it's a worthwhile optimization
3. **Reconsider** moving `cache->len =3D cache->size;` - leave it in the or=
iginal position for clarity
4. **Add rationale** explaining why removing `__rte_constant(n)` checks doe=
sn't harm performance

The patch compiles and maintains functional correctness, but the performanc=
e implications of removing compiler optimization hints should be validated =
and documented.
