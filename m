Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850B1D30CC3
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 21:10:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 827924028C;
	Tue, 13 Jan 2026 22:10:54 +0100 (CET)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id E492E40285
 for <dev@dpdk.org>; Tue, 13 Jan 2026 22:10:52 +0100 (CET)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so6677280f8f.3
 for <dev@dpdk.org>; Tue, 13 Jan 2026 13:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768338652;
 x=1768943452; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6NJUiFZc1jHryXum4Kc2TSvXObsllOJTXQIVXj7aAY=;
 b=STCegfI6mng8OkqPyC5JfRdcNvQVJRnE5M9PhjWgoZK7xeYU0r/sgSSBdaYz0UHNY5
 AEitOfLjsMaU1EfbQS3JrGP1Rb3Ht66/yWFnhF4HW8+SW7xbmKy1XZnfvviLwIH0tDss
 v16jmGBSf1QuTgCTQXVjG7FOGEA8uzengHMLYZawvYbvXO+rzNAPN98GK8xCqEHY1bi1
 XSYJgpjlC2rrvslJAiIqZ3voXtJBXz0Vo9j3FtgjCe3OqBY/4tQzx1FWerrQFBhu3Mli
 w6yUpTR/dimbBZk0Uhg7C9TIumOM3QAQfJejpj+a1oKv6keNzM6eL9nxTRrlfOdE9Lpr
 +EeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768338652; x=1768943452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v6NJUiFZc1jHryXum4Kc2TSvXObsllOJTXQIVXj7aAY=;
 b=XAQv90OZpu5obpxLNVf+iBCqqlFUAZDCZ++lvWLixvN5GpLNmb9lAwaGNHFLxzY3Ow
 MEC/yntLBhLoi8sgPL3+yU1vHXgDqbJFrG1SVmAU5Kotcj1oz2FKlZfysF8b3NsHFNZb
 4r02CK67fkokoVLOyIpAg7VpzI6f5/Roc7NRGLVyKhn1G2Lh0n69pDnXxxOCf8IPIwOA
 0v2nwol8wj8n2dRcGyJLFMtKqwXVd1m+Jeq3r53WZhgYgtsvoJL07pIojzO7mzIAeLNP
 SwkVsw28Dvgz9WYyEKxftVXzqyDsfiEKBJt5+846RPAOBtOl+zrbk39u3QKPQNyyYtNL
 0uwg==
X-Gm-Message-State: AOJu0Yy6jKj0pnCn8VPPsM7LkY3wwaHmy+GAR9rl/kpZJMZfh9/Vffwj
 pNoRWeTdRBaTt7k3VGf2eMsemdC52V7b4uTYSuR/zfGW4jXQSB4bhyMaJDDX8q+JE7A=
X-Gm-Gg: AY/fxX5eXh3ebhholqgbQPydqcwXi9e/R1Mgr7+gEqJZKYw3QwnXGBXUB+b8OVBWywo
 BAUJfwQJxtLCpDs5EGPqwchLFKN2la5L/EoO2fiqMFLtSkhnElDdKiDgxRhAD2UEfwlr8XYgvgI
 kFLLmrFXrqd0sJ1dPRSxFOb5MJcl10YrHrRbs7lblpaSxBJ+dn5XTZwjgwNc4VxSjtoxBzew0yX
 LjfzYWeyez6h9wfIYpgoSabsWNVXtS4lqYhcS4N7eZ5A+tcfFfguucGvIP0PRYVRo3b9obpkmnk
 M/Th7T1WQKbm+bj32gbSINIpsivNf8bgPGT4isOnZ/FAsOEbD8cQEW33Tisi61p3uTy0fkbA21e
 OuRWa8gjB/dKaPHbYwO/7ksxOvsY2XFHFtsMTLSEEBFlFEeyLN3Hn5wvz2JONbwM3ogpYBcZSIO
 i5kstGfx9/c7E81xyT4cmKn1YFyblUUd49jXy1oU303cKLE7IC8Gjv
X-Received: by 2002:a05:6000:200d:b0:432:c0e6:cfda with SMTP id
 ffacd0b85a97d-4342c4ee790mr270770f8f.7.1768338652275; 
 Tue, 13 Jan 2026 13:10:52 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9afsm48917565f8f.24.2026.01.13.13.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 13:10:52 -0800 (PST)
Date: Tue, 13 Jan 2026 13:10:47 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [v3 0/3] L3fwd changes
Message-ID: <20260113131047.1ad937a4@phoenix.local>
In-Reply-To: <20241120040516.2836371-1-g.singh@nxp.com>
References: <20240806034120.3165295-1-g.singh@nxp.com>
 <20241120040516.2836371-1-g.singh@nxp.com>
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

On Wed, 20 Nov 2024 09:35:13 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> v3 changes:
> *  rebased the series to latest commit.
>=20
> v2 changes:
> *  Handled a comment to enhance the invalid port ID logic
>    and added a user option to decide exit or silently skip
>    in case invalid port in the rules list.
>=20
> Gagandeep Singh (3):
>   examples/l3fwd: support single route file
>   examples/l3fwd: fix return value on rules add
>   examples/l3fwd: enhance valid ports checking
>=20
>  examples/l3fwd/em_route_parse.c  | 33 +++++++++---------
>  examples/l3fwd/l3fwd.h           | 16 +++++++++
>  examples/l3fwd/l3fwd_em.c        | 22 ++++++++----
>  examples/l3fwd/l3fwd_fib.c       | 26 +++++++++-----
>  examples/l3fwd/l3fwd_lpm.c       | 26 +++++++++-----
>  examples/l3fwd/l3fwd_route.h     |  2 ++
>  examples/l3fwd/lpm_route_parse.c | 28 ++++++++-------
>  examples/l3fwd/main.c            | 58 +++++++++++++++++++++++++++-----
>  8 files changed, 153 insertions(+), 58 deletions(-)
>=20


These patches appear to have gotten stuck in the backlog.
Running automated patch review shows minor issues.
Please rebase, fix issues and resubmit.


## DPDK Patch Review: l3fwd Patchset v3 (bundle-1634)

### Overview
This patchset contains 3 patches by Gagandeep Singh targeting the l3fwd exa=
mple application.

---

## Patch 1/3: `examples/l3fwd: support single route file`

### Commit Message

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 Pass | 41 characters |
| Lowercase after colon | =E2=9C=85 Pass | |
| Correct prefix | =E2=9C=85 Pass | `examples/l3fwd:` is correct |
| No trailing period | =E2=9C=85 Pass | |
| Imperative mood | =E2=9C=85 Pass | "support" |
| Body wrapped =E2=89=A475 chars | =E2=9C=85 Pass | |
| Body doesn't start with "It" | =E2=9C=85 Pass | |
| Signed-off-by present | =E2=9C=85 Pass | Line 108 |

### Code Review

| Check | Status | Notes |
|-------|--------|-------|
| Lines =E2=89=A4100 chars | =E2=9C=85 Pass | |
| Consistent style | =E2=9C=85 Pass | |

**Info:** This is a feature patch that decouples IPv4 and IPv6 rule file re=
quirements. Logic looks sound.

---

## Patch 2/3: `examples/l3fwd: fix return value on rules add`

### Commit Message

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 Pass | 45 characters |
| Lowercase after colon | =E2=9C=85 Pass | |
| Correct prefix | =E2=9C=85 Pass | |
| No trailing period | =E2=9C=85 Pass | |
| Body wrapped =E2=89=A475 chars | =E2=9C=85 Pass | |
| Body doesn't start with "It" | =E2=9C=85 Pass | Starts with "fix" |
| Signed-off-by present | =E2=9C=85 Pass | |
| Fixes: tag present | =E2=9C=85 Pass | Two Fixes tags (lines 304-305) |
| Fixes: format (12-char SHA) | =E2=9C=85 Pass | `e7e6dd643092`, `52def963f=
c1c` |
| Cc: stable@dpdk.org | =E2=9C=85 Pass | Line 307 |
| Tag order correct | =E2=9C=85 Pass | Fixes =E2=86=92 Cc =E2=86=92 blank =
=E2=86=92 Signed-off-by |

### Issues

**Warning:** The commit body is very terse =E2=80=94 just one line:
```
fix return value on adding the EM or LPM rules.
```
Consider expanding to explain *why* this matters (e.g., "The original code =
always returned -EINVAL, losing the actual parser error code which is neede=
d for debugging").

### Code Review

| Check | Status | Notes |
|-------|--------|-------|
| Lines =E2=89=A4100 chars | =E2=9C=85 Pass | |
| Code compiles independently | =E2=9C=85 Pass | Appears self-contained |

**Info:** Good fix =E2=80=94 propagates actual error codes instead of maski=
ng them with `-EINVAL`.

---

## Patch 3/3: `examples/l3fwd: validate port ID in route rules`

### Commit Message

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 Pass | ~47 characters |
| Lowercase after colon | =E2=9C=85 Pass | |
| Correct prefix | =E2=9C=85 Pass | |
| No trailing period | =E2=9C=85 Pass | |
| Body wrapped =E2=89=A475 chars | =E2=9C=85 Pass | |
| Signed-off-by present | =E2=9C=85 Pass | |

### Issues

**Warning =E2=80=94 Missing Fixes: tag:** The commit message explicitly sta=
tes this fixes a bug:
> "The current port ID validation logic... has two issues:
>  - It can pass if port ID in route is 31+."

This is a bug fix and should have a `Fixes:` tag referencing the commit tha=
t introduced the flawed port validation logic.

**Warning =E2=80=94 Missing Cc: stable@dpdk.org:** Since this fixes a bug (=
port IDs =E2=89=A532 bypass validation), it's a candidate for stable backpo=
rt.

### Code Review

| Check | Status | Notes |
|-------|--------|-------|
| Lines =E2=89=A4100 chars | =E2=9A=A0=EF=B8=8F Check | Some lines are bord=
erline |
| Explicit comparisons | =E2=9C=85 Pass | Uses `=3D=3D 0`, `!=3D NULL` styl=
e |

**Error =E2=80=94 Inconsistent error message format:**

The error messages across files use different formats:

| Location | Message Format |
|----------|----------------|
| l3fwd_em.c:575 | `"IDX: %d: Port ID %d in IPv4 rule..."` |
| l3fwd_em.c:593 | `"IDX %d: Port ID %d given in IPv6 rule..."` |
| l3fwd_fib.c:617 | `"IDX %d: Port ID %d in IPv4 rule..."` |
| l3fwd_lpm.c:661 | `"IDX: %d: Port ID %d in IPv4 rule..."` |

Should standardize to one format (suggest: `"IDX %d: Port ID %d..."`).

**Warning =E2=80=94 Comment style:**
```c
bool exit_on_failure; /**< Skip the route rule with invalid or */
		      /**< disabled port ID */
```
Multi-line Doxygen comments should use a single `/** ... */` block, not mul=
tiple `/**<` continuations.

**Info =E2=80=94 Code duplication:** The `l3fwd_validate_routes_port()` fun=
ction has significant code duplication between the LPM/FIB and EM branches.=
 Consider refactoring to reduce repetition.

---

## Summary

| Patch | Verdict | Blocking Issues |
|-------|---------|-----------------|
| 1/3 | **Acceptable** | None |
| 2/3 | **Acceptable** | None (minor: terse body) |
| 3/3 | **Needs revision** | Missing Fixes tag, inconsistent error messages=
 |

### Required Changes for Patch 3/3:
1. Add `Fixes:` tag identifying the original commit with the port validatio=
n bug
2. Add `Cc: stable@dpdk.org`
3. Standardize error message format across all files

### Recommended Changes:
- Patch 2/3: Expand commit body to explain the impact of the fix
- Patch 3/3: Clean up the multi-line Doxygen comment
- Patch 3/3: Consider refactoring `l3fwd_validate_routes_port()` to reduce =
duplication
