Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF710D39003
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 18:00:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6C5540B90;
	Wed, 14 Jan 2026 19:00:19 +0100 (CET)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54]) by mails.dpdk.org (Postfix) with ESMTP id 5CEC34027D
 for <dev@dpdk.org>; Wed, 14 Jan 2026 19:00:19 +0100 (CET)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-64dfb22c7e4so2175720a12.1
 for <dev@dpdk.org>; Wed, 14 Jan 2026 10:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768413619;
 x=1769018419; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vILcaUb4DTtxFI1QjQBKJIXtsstUbXrdq1yzO9hX5wk=;
 b=ctewXqDEhPXiKMsjg54Nh1nxu4OvlMIgEGFh3+L+DMljqUwYv8tMxIxg+DJ6sY8V3A
 3ZkUL4Wwzk/fjSRRlcqPNnG8BiT2WOd3G59f4KNZZe+vQOyv6fhrdc/0S25Ywzm+kA+o
 Y7KNCs2f0VCqiG/2O4MzbYIFUZy4uwNRcBE7Yvi2XL/gDchBOrVElLvWZYfgQlFfL8Bk
 TwPeyMAX9aAzE/nTwOkQ4HBzK5rmuc/jXOlu4dgasgWD8c26bX6Vj7fAucjTyb+WVee4
 O1kDndbuRlKDUPx/QimKG7vJhKDtxWC1pOozyXt4NFO1vscteRBO2uasbIH/tv1UtAsp
 gIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768413619; x=1769018419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vILcaUb4DTtxFI1QjQBKJIXtsstUbXrdq1yzO9hX5wk=;
 b=TDvhbkm8ZqYxPMqRwI1q6Wc9vI+GcDzWDQCKT73srCSfEAyqyepOVO7WKspqIcKGZb
 Ug2vmcD7b/sB8qSLj2MkZX+yzN8vsep37RImrilC6qBvDlkxC1Ppm+1RPgAOZPOgC6cB
 m1zgYXQQnlMiARx+B9I0jSOPcvSgkLDhjS6xKb0nsNlYzXPWRMEY1xNvViLM3fsYrjsh
 LsWEBDwz97bex1pP8a37pLdoGh9TK6AjBj+SSy3Hs8PtYQQHfuIajz2HJ2Qour56HApg
 9KcH3cd1CJwbvm5j86Wb2kMqGMWmsvJ6mu3QB7Q+YtVmT9y6Bfqp3VVyr1POb6j946a5
 EDnA==
X-Gm-Message-State: AOJu0YxbmNbJ5RPBzomWA2IePEOWRbMgDtHXXdt4hS6YHWzgl+cdfsiU
 xCjA6b+xwMu9f6KKr6anpF+15ILGxmg/i/fcug3EnglEgnKPKdxIrlO5KSnjjT7wPKO3CLqR9tH
 Ew51k
X-Gm-Gg: AY/fxX4ASeq6qWwRiHz5mZzW+dyGOMedRSJEkNTcVjc32s/uYAVmI/vfemxS1vvHUSk
 tcJ12N4p1muxeKn79NysuNkii/X0GCF/saAQoU1ZFvZpCCyhjJFv3hWd3wiFgpsXxZkLX3NEY/B
 3/qaWtbIzaPmP0QPmD8SX2+ITbZ2gyyTNp174vhvN6FMbQbgjZwcVvwRPv8gpfmMGy3Om8e+rZ4
 MfIaA22pMIetAg4w4zq7oD7v+k8b3NBl9m3D+pHm/ZN2AXnHeqNlnPNXpIVlhGmhr43AqMIK2V3
 Nn30K2yMuMx0+nQiQ7KrdyWHf4Y6tsBPs6GwyZM4zlLCUFz78v6xTWkWbf43Vl+BXvszYTsXcX7
 /0wsMSttoN40MMAlNxhw3E52ctmoANHAzWepHJkdXcJonPm9TaA1VwpbizMPkLE9wRfuvaohufH
 aws/6jog8y9m8gTjW+NA3Hst2VKrM62klmgOFjBQJZyCeuCNTupgYW
X-Received: by 2002:a17:906:8910:b0:b87:63a8:91b4 with SMTP id
 a640c23a62f3a-b8777c5360cmr18712666b.30.1768413618631; 
 Wed, 14 Jan 2026 10:00:18 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b86ebfd007fsm1382139566b.31.2026.01.14.10.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 10:00:18 -0800 (PST)
Date: Wed, 14 Jan 2026 10:00:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kerem Aksu <kerem.aksu@i2i-systems.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] cmdline: update clear screen behavior
Message-ID: <20260114100013.57faee61@phoenix.local>
In-Reply-To: <20260105113529.65969-1-kerem.aksu@i2i-systems.com>
References: <20260105113529.65969-1-kerem.aksu@i2i-systems.com>
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

On Mon,  5 Jan 2026 14:35:29 +0300
Kerem Aksu <kerem.aksu@i2i-systems.com> wrote:

> Control+L should clear screen and redisplay prompt at the top
> line. DPDK rdline library will not change anything on the screen when
> fed with Control+L.  When prompt is lost after too many text written
> to the terminal, users will press Control+L to clear screen and put
> the prompt to the top line. This is expected behavior in bash(1) or
> applications that are using readline(3). Updated to behave as users
> expected.
>=20
> Signed-off-by: Kerem Aksu <kerem.aksu@i2i-systems.com>
> ---

Overall looks correct. AI review had some feedback.
I would add a release note just for clarity


### Summary
This patch modifies the Ctrl+L behavior in the cmdline library to clear the=
 entire screen and redisplay the prompt at the top, matching standard bash/=
readline behavior. Currently, Ctrl+L only redisplays on the current line.

---

### Commit Message =E2=9C=85

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 | 40 characters |
| Correct prefix | =E2=9C=85 | `cmdline:` is correct for lib/cmdline |
| Imperative mood | =E2=9C=85 | "update" |
| No trailing period | =E2=9C=85 | |
| Lowercase | =E2=9C=85 | |
| Body wrapped =E2=89=A475 chars | =E2=9C=85 | |
| Body doesn't start with "It" | =E2=9C=85 | |
| Signed-off-by | =E2=9C=85 | Present |
| Acked-by/Tested-by | =E2=9C=85 | Both present |

---

### Code Review

**Overall Assessment**: The approach is sound. Refactoring `rdline_redispla=
y` into a parameterized `rdline_reprint` static function maintains API comp=
atibility while adding the new clear-screen behavior.

#### Errors (must fix)

**1. Extra whitespace after comma** (style violation)

Lines 126-129 in the patch have double spaces:
```c
rdline_puts(rdl,  vt100_clear_screen);   /* two spaces after comma */
rdline_puts(rdl,  vt100_homecursor);     /* two spaces after comma */
rdline_puts(rdl,  vt100_home);           /* two spaces after comma */
```

Should be:
```c
rdline_puts(rdl, vt100_clear_screen);
rdline_puts(rdl, vt100_homecursor);
rdline_puts(rdl, vt100_home);
```

#### Warnings (should consider)

**2. Consider order of escape sequences**

The current implementation sends `vt100_clear_screen` then `vt100_homecurso=
r`. Some terminals may already position cursor at home after clear screen (=
ESC [2J), but the explicit `ESC [H` is safer for portability. This is fine =
as-is.

**3. Potential documentation update**

Consider whether the programmer's guide (`doc/guides/prog_guide/cmdline.rst=
`) or API documentation needs updating to reflect the changed Ctrl+L behavi=
or. Users familiar with the old behavior might notice the change.

#### Info (observations)

**4. Good API preservation**

The `RTE_EXPORT_SYMBOL(rdline_redisplay)` is correctly maintained, and the =
public function signature is unchanged. This preserves backward compatibili=
ty for any external callers.

**5. New VT100 constant placement**

The new `vt100_homecursor` is added in a reasonable location in `cmdline_vt=
100.h`, near related cursor movement sequences.

**6. Existing style quirks preserved**

The file already uses `for (i=3D0 ; i<...` style (spaces around semicolons =
but not around `=3D` and `<`). The patch follows this existing convention, =
which is correct.

---

### Verdict

**Needs revision** - Fix the double-space style issue, then this is ready.

The change itself is a sensible UX improvement that aligns DPDK's command l=
ine behavior with user expectations from bash and readline. The implementat=
ion is clean and maintains API compatibility.
