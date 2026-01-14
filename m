Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A08D31A0E
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 05:13:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5A9D40615;
	Wed, 14 Jan 2026 06:13:38 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id C2F8E40289
 for <dev@dpdk.org>; Wed, 14 Jan 2026 06:13:36 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso75613875e9.3
 for <dev@dpdk.org>; Tue, 13 Jan 2026 21:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768367616;
 x=1768972416; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lTVtNwIUitUyV1vBK1jqgftwLsowY9LX1YUHBYeVoaE=;
 b=L3FjGH+IxvxprHiVCC8kSShmXykj9vSfhlwMXSZ/Rtf1n6o/S9u5BmVgnzOnDBipAp
 IY3gN1AtUI7rS/0AuTVh8ThmdveiROWrfaVC7sbtoiCjNHK6+rcfPQVK2ubMrl2QMevP
 fiBtnXJNhMwA4k0CdAzxO84hHV7sJEP8zt2sIJCESl7cUEOVdNA54ktFpY9GdrowecqD
 jZG6y+wchHES3YucpEkQMBgi9S5/4PN6dQwOHfBTpWagFWSZGYOaVElH97uWi3N6tA5D
 SaTSLcRqlSdtkgZIYSYIzeAh+ruc36isQX2EDNsKFMo2Sx7eLOtIrfM+eg1GJvYk2jy9
 BSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768367616; x=1768972416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lTVtNwIUitUyV1vBK1jqgftwLsowY9LX1YUHBYeVoaE=;
 b=HnFlaC6l7pmetF35STL4unBb+syTHA8oSgjHaLNa66ffcyIwxpF9CSUMILuyH7139c
 8EygsvTCjynAGjwO4te0nFPt1NGhvbAsxqaqIcPeiEJKSVh/7cpAPoyInMx7qBULPWu0
 YDsfhZqAj9vmeISEcrTeaUUO3xdlFIP54E/cwpPCf2VKO4SQUBbFdZu7qA44KPI3XZ+e
 F7hQLfo5aWTz1Glz/WjK5/YBz4xmDmsssbmYCwbG7smV8kj6x7sionsYx5jZ9eKZm2bX
 LeYInYiiqFjAelj1Zv1BndTACSRvef7RB7W3+AMrHfnDA7Mtm81mNQ+SPKuliDYn82CC
 P2XQ==
X-Gm-Message-State: AOJu0YxCVUBMp2Z2hVerGhIKxYCmq0Pv1jvmdPFhHMc5/eKUuGziquH7
 tsIQ+lQYykI0ONm75fcDfKWz2JgVln/tsI/V8OEFtGNWyOwdKHP2MAtNAfVy1wwLkM8=
X-Gm-Gg: AY/fxX6IyvOtkKX1AYbBtB18m1FHNBRNYXdrQB6rk+r38OFXVqWKN0CrK+ymdlQIqDr
 F3eSQhe1sle1cnkSdX5E9Xo3YH5pyJMXzNLAMv8/htQdfVFOoSlXFi0pquMTOBUwYmWxe9iWP9K
 dgi0TRrmcecp25JFRSREq8gQ4wpEKibE2wUCzXFyyutIUs9UhdbztYTN9Tx4efbf96OYXbHUld6
 d1hZYXkAdCAFMskCX6YpOcg+cZUxwqQZuWprjXNogsqrA5/EX1k0dLTxX3NepLbtw6puqMfC8Wd
 JuywewiP25gNac13rzV70Vb3bTzj17+z+oob4fLB3s/8roDYDFi/g6IYCZj2qqtQBUV2Dren5Mn
 pSsOhFgKArTOXqxuyl8SD8kuf8C3IHToFlWcBz4Qivsxa7OnTyWKXoKEvv8CsKQMnyJWalU56h5
 p1XP3crYs6eYXN4uiZ8xwCqTv18WOTYSkLhkt4FBfCR/meMhn+GSd8
X-Received: by 2002:a05:6000:2407:b0:430:fced:90a with SMTP id
 ffacd0b85a97d-4342c4f70ebmr1235682f8f.16.1768367616203; 
 Tue, 13 Jan 2026 21:13:36 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee5e3sm47682790f8f.35.2026.01.13.21.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 21:13:35 -0800 (PST)
Date: Tue, 13 Jan 2026 21:13:30 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Abdullah =?UTF-8?B?w5ZtZXIgWWFtYcOn?= <aomeryamac@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v6] devtools: add .clang-format file
Message-ID: <20260113211331.3fb0de98@phoenix.local>
In-Reply-To: <20241014221545.66810-1-aomeryamac@gmail.com>
References: <20241007102410.6c68f2c6@hermes.local>
 <20241014221545.66810-1-aomeryamac@gmail.com>
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

On Mon, 14 Oct 2024 22:15:45 +0000
Abdullah =C3=96mer Yama=C3=A7 <aomeryamac@gmail.com> wrote:

> clang-format is a tool to format C/C++/Objective-C code. It can be used
> to reformat code to match a given coding style, or to ensure that code
> adheres to a specific coding style. It helps to maintain a consistent
> coding style across the DPDK codebase.
>=20
> .clang-format file overrides the default style options provided by
> clang-format and large set of IDEs and text editors support it.
>=20
> Signed-off-by: Abdullah =C3=96mer Yama=C3=A7 <aomeryamac@gmail.com>
> ---

Adding a clang-format would be good, but the patch never got reviewed.
I was a little concerned that the new clang-format would have some
style conflicts with current DPDK usage; so I asked AI.
Please consider these proposed changes and resubmit.


## Patch Review: devtools: add .clang-format file

### Commit Message Analysis

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 | 39 characters |
| Lowercase after colon | =E2=9C=85 | "add .clang-format file" |
| Imperative mood | =E2=9C=85 | "add" |
| No trailing period | =E2=9C=85 | |
| Signed-off-by | =E2=9C=85 | Present with real name and email |
| Body =E2=89=A475 chars | =E2=9C=85 | Lines are within limit |

**Warning**: The prefix `devtools:` is potentially misleading since the `.c=
lang-format` file is being added to the repository root, not to the `devtoo=
ls/` directory. Consider using a prefix like `style:` or `build:`, or simpl=
y omit the prefix for root-level config files.

---

### Clang-Format Settings Review

#### =E2=9C=85 Correct Settings

| Setting | Value | DPDK Requirement | Status |
|---------|-------|------------------|--------|
| `ColumnLimit` | 100 | 100 chars max | =E2=9C=85 |
| `TabWidth` | 8 | 8 characters | =E2=9C=85 |
| `IndentWidth` | 8 | 8 characters | =E2=9C=85 |
| `LineEnding` | LF | Unix line endings | =E2=9C=85 |
| `InsertNewlineAtEOF` | true | Files end with newline | =E2=9C=85 |
| `AfterFunction` | true | Brace on new line for functions | =E2=9C=85 |
| `AfterControlStatement` | false | Brace on same line for if/for/while | =
=E2=9C=85 |
| `IncludeBlocks` | Preserve | Don't reorder include groups | =E2=9C=85 |
| `SortIncludes` | Never | Preserve include order | =E2=9C=85 |
| `AlwaysBreakAfterReturnType` | TopLevelDefinitions | Return type on own l=
ine | =E2=9C=85 |
| `IndentGotoLabels` | false | Labels not indented | =E2=9C=85 |
| `ForEachMacros` | comprehensive list | Treat as loops | =E2=9C=85 |

#### =E2=9A=A0=EF=B8=8F Issues to Address

**1. UseTab Setting (Warning)**

```yaml
UseTab: Always
```

DPDK style specifies: *"hard tabs for indentation, spaces for alignment"*

`UseTab: Always` will use tabs everywhere including for alignment, which ca=
n cause misalignment when viewed with different tab widths. Consider:

```yaml
UseTab: ForIndentation
```

**2. Missing Pointer Alignment (Warning)**

DPDK follows Linux kernel style where the `*` binds to the variable name:
```c
char *ptr;      /* Correct */
char* ptr;      /* Wrong */
```

Add:
```yaml
PointerAlignment: Right
```

**3. Missing Space After Cast (Info)**

DPDK style typically has no space after casts. Consider adding:
```yaml
SpaceAfterCStyleCast: false
```

**4. Missing Short Function Settings (Info)**

To prevent unwanted single-line functions:
```yaml
AllowShortFunctionsOnASingleLine: None
AllowShortBlocksOnASingleLine: Never
```

**5. Missing Brace Wrapping Settings (Info)**

The `BraceWrapping` section is incomplete. For full DPDK compliance, consid=
er:
```yaml
BraceWrapping:
        AfterFunction: true
        AfterControlStatement: false
        AfterStruct: false
        AfterEnum: false
        AfterUnion: false
        BeforeElse: false
        BeforeWhile: false
        SplitEmptyFunction: true
```

**6. Switch Statement Indentation (Info)**

DPDK style shows `case` labels not indented relative to `switch`. Add:
```yaml
IndentCaseLabels: false
IndentCaseBlocks: false
```

**7. BasedOnStyle Consideration (Info)**

`BasedOnStyle: LLVM` is a reasonable starting point, but Linux kernel style=
 (`BasedOnStyle: Kernel` if available in your clang-format version) might b=
e closer to DPDK's actual style since DPDK is modeled on Linux kernel devel=
opment.

---

### Summary

| Severity | Count | Items |
|----------|-------|-------|
| **Error** | 0 | None |
| **Warning** | 2 | `UseTab: Always` should be `ForIndentation`; Missing `P=
ointerAlignment: Right` |
| **Info** | 5 | Subject prefix; Missing short function settings; Incomplet=
e brace wrapping; Missing switch indent settings; Space after cast |

**Recommendation**: The patch is a solid foundation but needs the pointer a=
lignment and tab usage fixes before merge. The current `UseTab: Always` set=
ting will cause alignment issues in multi-line function arguments and struc=
t initializers, and the missing `PointerAlignment: Right` will format point=
ers contrary to DPDK convention.
